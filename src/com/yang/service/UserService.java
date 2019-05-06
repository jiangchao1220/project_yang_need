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

    //用户登录
    User loginUser(User user);

    //查询用户是否存在: 不存在0, 存在1
    int findUserByName(String username);

    //新增用户
    boolean addNewUser(User user);

    //修改密码
    int updatePassword(String userName, String password);
}
