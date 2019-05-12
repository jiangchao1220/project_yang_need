package com.yang.service.impl;

import com.yang.dao.BrokerDao;
import com.yang.dao.UserDao;
import com.yang.entity.Broker;
import com.yang.entity.User;
import com.yang.service.BrokerService;
import com.yang.util.JsonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpSession;

/**
 * Created by jiang on 2019/5/12.
 */
@Service("brokerServiceImpl")
public class BrokerServiceImpl implements BrokerService {
    @Autowired
    private UserDao userDao;
    @Autowired
    private BrokerDao brokerDao;

    @Override
    public String borkerLogin(HttpSession httpSession, String username, String password) {
        String msg;
        if (check(username, password)) {
            return "账号密码不能为空!";
        }

        Broker broker = brokerDao.findBroker(username, password);
        if (broker == null) {
            msg = "failed";
        } else {
            msg = "successed";
            String accout = broker.getAccout();
            httpSession.setAttribute("loginUser", JsonUtil.toJSon(accout));
            httpSession.setAttribute("isBorker", "borker");
        }
        return msg;
    }

    @Override
    public String checkBrokerAccout(String accout) {
        String msg = "does not exist";
        User user = userDao.findUserByUaseName(accout);
        if (user != null) {
            return "exist";
        }
        Broker broker = brokerDao.findBrokerByAccout(accout);
        if (broker != null) {
            return "exist";
        }

        return msg;
    }

    @Override
    public String insertBrokerAccout(String accout, String password, String sex, String realName, String contextPhone) {
        Broker broker = new Broker(accout,password,sex,realName,contextPhone);
        int insertNum = brokerDao.insertBroker(broker);
        if (insertNum == 1) {
            return "success";
        } else {
            return "fail";
        }
    }

    private boolean check(String username, String password) {
        return StringUtils.isEmpty(username) || StringUtils.isEmpty(password);
    }
}
