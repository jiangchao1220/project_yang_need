package com.yang.service.impl;

import com.yang.service.SignOutService;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;

/**
 * Created by jiang on 2019/5/9.
 */
@Service("signOutServiceImpl")
public class SignOutServiceImpl implements SignOutService{
    private static final String EMPTY = "";

    @Override
    public String signOut(HttpSession httpSession) {
        String result = EMPTY;
        String username = (String) httpSession.getAttribute("loginUser");
        if (username == null) {
            result = "您还未登录!";
            return result;
        } else {
            httpSession.removeAttribute("loginUser");
            httpSession.removeAttribute("isBorker");
        }

        String checkUser = (String) httpSession.getAttribute("loginUser");
        String checkIsBroker = (String) httpSession.getAttribute("isBorker");
        if (checkUser == null && checkIsBroker == null) {
            result = "signoutsuccess";
        } else {
            result = "退出失败,请关闭浏览器后重新登录";
        }
        return result;
    }
}
