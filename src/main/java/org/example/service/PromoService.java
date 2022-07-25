package org.example.service;

import org.example.service.model.PromoModel;

public interface PromoService {

    //根据item id 获取即将开始或正在进行的秒杀活动
    PromoModel getPromoByItemId(Integer itemId);
}
