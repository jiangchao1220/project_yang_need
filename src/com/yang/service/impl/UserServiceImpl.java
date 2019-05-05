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

    @Override
    public User loginUser(User user) {

        User u =null;
        u=userDao.loginUser(user);
        return u;
    }

    @Override
    public int findUserByName(String username) {
        User user = userDao.findUserByUaseName(username);
        if (user != null){
            return 1;
        }
        else {
            return 0;
        }
    }

    @Override
    public boolean addNewUser(User user) {
        int success = userDao.addNewUser(user);
        if (success == 1){
            return true;
        }
        else {
            return false;
        }
    }

}
