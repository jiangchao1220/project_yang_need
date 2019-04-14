package com.yang.service;

import com.yang.entity.User;

/**
 * Created by jiang on 2019/4/14.
 */
public interface UserService
{
    //根据id查询用户
    User getUser(int id);

    //刷新密码
    int updateUser(User user);
}
