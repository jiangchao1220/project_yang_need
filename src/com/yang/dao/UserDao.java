package com.yang.dao;

import com.yang.entity.ConcernHouse;
import com.yang.entity.User;
import com.yang.entity.UserInfo;
import org.springframework.stereotype.Repository;

/**
 * Created by jiang on 2019/4/14.
 */
@Repository
public interface UserDao {
    //用户登录
    User loginUser(User user);

    //查询用户
    User findUserByUaseName(String username);

    //新增用户
    int addNewUser(User user);

    //修改密码
    int updatePwd(User user);

    /**
     * 插入信息表
     *
     * @param userInfo 用户信息
     * @return num
     */
    int insertUserInfo(UserInfo userInfo);

    /**
     * 插入信息表
     *
     * @param userInfo 用户信息
     * @return num
     */
    int updateUserInfo(UserInfo userInfo);

    /**
     * 查询用户信息
     *
     * @param username 用户名
     * @return 用户信息对象
     */
    UserInfo findUserInfoByUaseName(String username);
}
