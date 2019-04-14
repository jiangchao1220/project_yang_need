package com.yang.dao;

import com.yang.entity.User;
import org.springframework.stereotype.Repository;

/**
 * Created by jiang on 2019/4/14.
 */
@Repository
public interface UserDao {
    //根据id查询用户
    User getUser(int id);

    //插入一条用户数据
    int insertUser(User user);

    //刷新用户数据
    int updateUser(User user);
}