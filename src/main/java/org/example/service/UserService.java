package org.example.service;

import org.example.error.BusinessException;
import org.example.service.model.UserModel;

public interface UserService {
    UserModel getUserById(Integer id);

    void register(UserModel userModel) throws BusinessException;

    /*
    telphone:用户注册手机
    encrptPassowrd:用户加密后的密码
     */
    UserModel validateLogin(String telphone, String encrptPassword) throws BusinessException;

}