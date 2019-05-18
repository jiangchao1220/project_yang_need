package com.yang.service.impl;

import com.yang.dao.BrokerDao;
import com.yang.dao.UserDao;
import com.yang.entity.ConcernHouse;
import com.yang.entity.User;
import com.yang.entity.UserInfo;
import com.yang.service.UserService;
import com.yang.util.CryptographyUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

/**
 * Created by jiang on 2019/4/14.
 */
@Service("userServiceImpl")
public class UserServiceImpl implements UserService {

    @Autowired
    UserDao userDao;
    @Autowired
    BrokerDao brokerDao;

    @Override
    public User loginUser(User user) {
        user.setPassword(CryptographyUtil.md5(user.getPassword(), "yc"));
        User u = null;
        u = userDao.loginUser(user);
        return u;
    }

    @Override
    public int findUserByName(String username) {
        User user = userDao.findUserByUaseName(username);
        if (user != null) {
            return 1;
        } else {
            return 0;
        }
    }

    @Override
    public boolean addNewUser(User user) {
        user.setPassword(CryptographyUtil.md5(user.getPassword(), "yc"));
        int success = userDao.addNewUser(user);
        if (success == 1) {
            return true;
        } else {
            return false;
        }
    }

    @Override
    public int updatePassword(String userName, String password) {
        User user = new User();
        user.setName(userName);
        user.setPassword(password);
        int isSuccess = userDao.updatePwd(user);
        //兼容经纪人账号
        if (isSuccess == 0) {
            isSuccess = brokerDao.updatePassword(userName,password);
        }
        return isSuccess;
    }

    @Override
    public String insertUserInfo(UserInfo userInfo) throws UnsupportedEncodingException {
        //校验登陆
        User user = userDao.findUserByUaseName(userInfo.getUsername());
        if (user == null) {
            return "您没有登陆,请登陆后操作!";
        }

        //中文解码
        String sex = URLDecoder.decode(userInfo.getSex(),"UTF-8");
        String name = URLDecoder.decode(userInfo.getName(),"UTF-8");
        String signtext = URLDecoder.decode(userInfo.getSigntext(),"UTF-8");
        userInfo.setSex(sex);
        userInfo.setName(name);
        userInfo.setSigntext(signtext);

        //查询是否存在个人信息
        UserInfo checkUserInfo = userDao.findUserInfoByUaseName(userInfo.getUsername());
        //已存在个人信息,刷新信息表
        if (checkUserInfo != null) {
            return updateUserInfo(userInfo);
        }

        int insert = userDao.insertUserInfo(userInfo);
        String msg;
        if (insert == 1) {
            msg = "修改个人信息成功!";
        } else {
            msg = "修改失败,请稍后重试!";
        }
        return msg;
    }

    @Override
    public UserInfo findUserInfo(String username) {
        UserInfo userInfo = userDao.findUserInfoByUaseName(username);
        if (userInfo == null) {
            return new UserInfo();
        }
        return userInfo;
    }

    private String updateUserInfo(UserInfo userInfo) {
        int check = userDao.updateUserInfo(userInfo);
        String msgupdate;
        if (check == 1) {
            msgupdate = "修改成功.";
        } else {
            msgupdate = "修改失败!";
        }
        return msgupdate;
    }
}
