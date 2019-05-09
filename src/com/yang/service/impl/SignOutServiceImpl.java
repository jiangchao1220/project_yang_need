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
            result = "notlogin!";
            return result;
        } else {
            httpSession.removeAttribute("loginUser");
        }

        String checkUser = (String) httpSession.getAttribute("loginUser");
        if (checkUser == null) {
            result = "signoutsuccess";
        }
        return result;
    }
}
