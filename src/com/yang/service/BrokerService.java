package com.yang.service;

import javax.servlet.http.HttpSession;

/**
 * Created by jiang on 2019/5/12.
 */
public interface BrokerService {
    /**
     * 经纪人登录
     *
     * @param username 账号
     * @param password 密码
     * @return 登录提示信息
     */
    String borkerLogin(HttpSession httpSession, String username, String password);

    /**
     * 经纪人注册校验账户
     *
     * @param accout    账户
     * @return msg
     */
    String checkBrokerAccout(String accout);

    /**
     * 经纪人注册
     *
     * @param accout    账户
     * @return msg
     */
    String insertBrokerAccout(String accout,
                              String password,
                              String sex,
                              String realName,
                              String contextPhone);
}
