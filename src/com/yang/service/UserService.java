package com.yang.service;

import com.yang.entity.User;

/**
 * Created by jiang on 2019/4/14.
 */
public interface UserService {
    /**
     * 用户登录
     *
     * @param user 登录的用户
     * @return 查询到的匹配用户数据
     */
    User loginUser(User user);

    /**
     * 查询用户是否存在: 不存在0, 存在1
     *
     * @param username 用户名
     * @return 查询到的数据条数
     */
    int findUserByName(String username);

    /**
     * 用户注册
     *
     * @param user 新增用户
     * @return 是否注册成功
     */
    boolean addNewUser(User user);

    /**
     * 修改密码
     *
     * @param userName 用户名
     * @param password 新密码
     * @return 修改的数据条数, 0:刷新用户表数据失败, 1:刷新用户表数据成功
     */
    int updatePassword(String userName, String password);
}
