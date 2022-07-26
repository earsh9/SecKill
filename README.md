# SecKill 初步框架搭建

## 概述

- 使用 Springboot + Mybatis + MVC 框架

  - entity实体层 -> dao层 -> service层 -> controller层
  
  - 自定义validator校验器与全局捕获异常

    - 将数据格式统一化 CommonResult 及设置通用错误码格式 EmBusinessError
    
- 学习模型能力管理：

    用户模型、商品模型、下单模型、秒杀活动模型...每个模型都有其特定的生命周期；

    聚合模型：将多表属性联结在一起，方便前端读取信息。

## 1、用户模型UserModel

生命周期：注册 -> 登录 -> 下单

### 1）otp短信获取

- 生成otp验证码：随机数 `random.nextInt()`

- 将otp验证码与用户手机号关联

  - 此处使用手机号作为唯一登录标识，所以mysql数据库设计时对telpehone字段设为唯一且非空。如果想加入`支持第三方绑定`的功能，需根据实际需要决定telphone字段的属性。

  - 对于redis天生的使用Key-Value存储形式，能设置字段的过期时间、用户反复获取验证码时可以覆盖以保证只有最新验证码可用。**（后续优化点）**
  
- 将otp验证码通过短信通道发给用户（Http post）

  - 这里暂时使用 HttpSession 域的方式绑定手机号与otp码：`httpServletRequest.getSession().setAttribute(telphone, otpCode);`
  
    - 注意 `httpServletRequest` 虽然使用 `@Autowired` 方式注入，但并非单例模式，内部为proxy代理模式，支持ThreadLocalMap，用户在各自线程处理 request实际上是支持并发访问的。
    
### 2）otp注册用户

- 验证 otpcode 与 telphone 是否符合

- 用户注册

  - controller 层：生成Model对象，其中密码使用md5加密后再传输存储

  - service 层：存入 database **所有写入数据库的操作使用 `@Tansactional`注解**

### 3）用户使用手机号登录

- 入参校验（telphone、password 不能为空）

- 根据用户手机号查询 database 中加密的密码与传入的加密密码是否相同

- 将登录成功的信息放到 session 中。（此处没有使用Token）

```java
  this.httpServletRequest.getSession().setAttribute("IS_LOGIN", true);
  this.httpServletRequest.getSession().setAttribute("LOGIN_USER", userModel);
```   

### 聚合模型概念引入

对于用户模型而言，其密码字段是不宜和普通字段（如姓名、性别、年龄等）放在同一张表中的，所以分成了`user_info`和`user_password`两个表，两表对应不同的 CRUD 即不同的 mapping。

但有时候不同表的信息是需要汇集到一起再返回给前端展示的，所以在 service 层引入了 Model 的概念：同一模型对应到不同表的所有字段汇集到此。（程序可扩展性好）

    借助hibernate-validator生成的校验器直接在 model 处添加注解以实现限制

甚至有些信息不想给前端的时候（例如密码）可以在 controller 层引起 viewObject 再进行一层筛选。

    Model与dao或者viewObject之间的转化都可以使用`BeanUtils.copyProperties(orderModel, orderDao);`来快捷完成。
    
    注意double类型与BigDecimal之间切换的精度损失问题、时间格式上的转换

## 2、商品模型ItemModel

    为方便后续调优，将库存 stock 单独建表为 `item_stock`，通过 `item_id` 关联。
    
    其余字段均在 `item` 表中，对于销量 sales 暂时放在 `item`中，当支付模块发生后异步 + 1

- 创建商品createItem

- 查询所有商品listItem（为了前端显示）

- 根据id查询商品getItemById
  
  - 商品模型 ItemModel 需要聚合库存stock、秒杀活动价promoItemPrice（体现聚合模型的好处：可扩展性好）
  
- 落单减库存decreaseStock

## 3、交易模型OrderModel

- 创建订单

  - 校验：商品是否存在、用户是否合法、交易数量是否正确
  
    - 对于秒杀活动，使用 `promoId` 校验活动信息，当 `promoId` 非空时修改商品价格 `itemPrice` 为秒杀活动价格
    
  - 落单减库存
  
    - 此处是在创建订单的时候就锁定库存，不会出现超卖的问题。
 
      - 通过url上传过来秒杀活动id，在下单接口内校验对应id是否属于对应商品且活动已开始 (可以适应不同途径(app)来的秒杀活动，可扩展性好)
 
    - 对应的还有`下单减库存`：直接在下单接口内判断对应的商品是否存在秒杀活动，若存在进行中的则以秒杀价格下单

      - 可以避免恶意囤积订单而不支付的情况。但有超卖风险、非秒杀商品还得走一遍秒杀校验。
      
  - 订单入库
  
    - 生成交易流水号：交易号id为String类型并非自增。初步设计为16位：8位日期+6位自增序列+2位分库分表位
    
      - 日期使用正常年月日的格式；6位自增序列单独建表`sequence_info`来完成设置初始值`current_value`及自增步长`step`的设计
      
      - 使用注解`@Transactional(propagation = Propagation.REQUIRES_NEW)`确保：即使外部事务失败（订单创建）或者没有外部事务的情况下，都会开启当前事务（生成序列号）并提交。**保证一个订单一个流水号**
      
      - **未解决问题:** 自增超过六位时如何复位使得以循环使用；分库分表位写死为`00`
      
## 4、秒杀活动模型promoModel

|字段|含义|解释|
|----|----|----|
|id|秒杀活动编号||
|status|秒杀活动状态|1为未开始，2为正在进行，3为已结束|
|promoName|秒杀活动名称||
|startDate|秒杀开始时间|使用`joda-Time`包|
|endDate|秒杀结束时间|使用`joda-Time`包|
|item_id|对应的商品id||
|promoItemPrice|秒杀活动的商品价格||

- 根据`item_id`获取即将开始或者正在进行的秒杀活动getPromoByItemId

  - 根据`item_id`获取商品对应的秒杀信息

  - 判断当前时间是否秒杀活动即将开始或正在进行，orderModel可以根据返回的promoModel的`status`字段判断是否有合法的秒杀活动，从而决定修改秒杀价格与否
  
```java
        if (promoModel.getStartDate().isAfterNow()) {
            promoModel.setStatus(1);
        } else if (promoModel.getEndDate().isBeforeNow()) {
            promoModel.setStatus(3);
        } else {
            promoModel.setStatus(2);
        }
```     
  
## 附件

版本依赖、session跨域、自定义校验器和异常接收器其他问题解决详见：<https://blog.csdn.net/weixin_45401187/article/details/125946288>


