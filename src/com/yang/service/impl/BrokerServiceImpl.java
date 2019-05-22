package com.yang.service.impl;

import com.yang.dao.BrokerDao;
import com.yang.dao.UserDao;
import com.yang.entity.Broker;
import com.yang.entity.User;
import com.yang.service.BrokerService;
import com.yang.util.CryptographyUtil;
import com.yang.util.JsonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.List;

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
        String md5Password = CryptographyUtil.md5(password);
        Broker broker = brokerDao.findBroker(username, md5Password);
        if (broker == null) {
            msg = "failed";
        } else {
            msg = "successed";
            String accout = broker.getAccout();
            httpSession.setAttribute("loginUser", accout);
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
        Broker broker = new Broker(accout,password,contextPhone,realName,sex);
        int insertNum = brokerDao.insertBroker(broker);
        if (insertNum == 1) {
            return "success";
        } else {
            return "fail";
        }
    }

    @Override
    public Broker getBrokerInfo(String accout) {
        Broker broker = brokerDao.getBrokerInfo(accout);
        //过滤密码信息
        broker.setPassword("");
        return broker;
    }

    @Override
    public String updateBrokerInfo(Broker broker) throws UnsupportedEncodingException {
        //解码
        broker.setSex(URLDecoder.decode(broker.getSex(), "UTF-8"));
        broker.setName(URLDecoder.decode(broker.getName(), "UTF-8"));
        broker.setInfo(URLDecoder.decode(broker.getInfo(), "UTF-8"));
        int num = brokerDao.updateBrokerInfo(broker);
        //查询发布人发布的房屋编号
        List<Integer> numberList = brokerDao.findBrokerHouse(broker.getAccout());
        //更新house表中发布人信息
        for (Integer number : numberList) {
            brokerDao.undateHouse(broker.getName(), broker.getPhone(), number);
        }
        String msg;
        if (num == 1) {
            msg = "修改成功";
        } else {
            msg = "修改失败";
        }
        return msg;
    }

    private boolean check(String username, String password) {
        return StringUtils.isEmpty(username) || StringUtils.isEmpty(password);
    }
}
