package com.yang.service.impl;

import com.yang.dao.UserDao;
import com.yang.entity.User;
import com.yang.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by jiang on 2019/4/14.
 */
@Service("userServiceImpl")
public class UserServiceImpl implements UserService {

    @Autowired
    UserDao userDao;
    @Override
    public User getUser(int id) {
        return userDao.getUser(id);
    }

    @Override
    public int updateUser(User user) {
        return userDao.updateUser(user);
    }


}
