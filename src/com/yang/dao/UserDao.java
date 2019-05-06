package com.yang.dao;

import com.yang.entity.User;
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
}
