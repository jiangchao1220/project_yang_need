package com.yang.controller;

import com.yang.service.BrokerService;
import com.yang.util.JsonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

/**
 * Created by jiang on 2019/5/12.
 */
@Controller
public class BrokerController {
    @Autowired
    private BrokerService brokerService;

    /**
     * 经纪人登录Controller
     *
     * @param httpSession session
     * @param username    用户名
     * @param password    密码
     * @return 跳转页面
     */
    @RequestMapping(value = "/**/brokerLogin", method = RequestMethod.POST)
    @ResponseBody
    public String login(HttpSession httpSession, String username, String password) {
        return JsonUtil.toJSon(brokerService.borkerLogin(httpSession, username, password));
    }

    /**
     * 经纪人注册校验账户Controller
     *
     * @param accout 账户
     * @return msg
     */
    @RequestMapping(value = "/**/checkBrokerAccout", method = RequestMethod.POST)
    @ResponseBody
    public String checkBrokerAccout(String accout) {
        System.out.println(accout);
        return JsonUtil.toJSon(brokerService.checkBrokerAccout(accout));
    }

    /**
     * 经纪人注册校验账户Controller
     *
     * @param accout       账户
     * @param password     密码
     * @param sex          性别
     * @param realName     姓名
     * @param contextPhone 电话
     * @return msg
     */
    @RequestMapping(value = "/**/brokerRegister", method = RequestMethod.POST, produces = "text/html;charset=UTF-8;")
    @ResponseBody
    public String brokerRegister(
            @RequestParam(value = "accout") String accout,
            @RequestParam(value = "password") String password,
            @RequestParam(value = "sex") String sex,
            @RequestParam(value = "real_name") String realName,
            @RequestParam(value = "context_phone") String contextPhone) {
        String msg = "";
        try {
            System.out.println(accout + "  " + password + "  " + URLDecoder.decode(sex, "UTF-8") + "  " + URLDecoder.decode(realName, "UTF-8") + "  " + contextPhone);
            msg = JsonUtil.toJSon(brokerService.insertBrokerAccout(
                    accout,
                    password,
                    URLDecoder.decode(sex, "UTF-8"),
                    URLDecoder.decode(realName, "UTF-8"),
                    contextPhone));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return msg;
    }
}
