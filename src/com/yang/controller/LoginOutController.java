package com.yang.controller;

import com.yang.service.impl.SignOutServiceImpl;
import com.yang.util.JsonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by jiang on 2019/5/9.
 */
@Controller
@RequestMapping("/loginOut")
public class LoginOutController {
    @Autowired
    private SignOutServiceImpl signOutService;

    public LoginOutController() {
        System.out.println("LoginOutController init!");
    }

    @RequestMapping(value = "/signOut", method = RequestMethod.GET)
    @ResponseBody
    public String signOut(HttpSession httpSession) throws IOException {
        return JsonUtil.toJSon(signOutService.signOut(httpSession));
    }
}
