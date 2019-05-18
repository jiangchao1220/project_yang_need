package com.yang.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by jiang on 2019/5/17.
 */
public class LoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(
            HttpServletRequest request,
            HttpServletResponse response,
            Object o) throws Exception {
        String uri = request.getRequestURI();
        System.out.println(uri);
        boolean isPermissionsPages = checkPages(uri);
        Object loginUser = request.getSession().getAttribute("loginUser");
        if (loginUser == null && isPermissionsPages) {
            return false;
        } else {
            return true;
        }
    }

    private boolean checkPages(String uri) {
        return uri.contains("addHouse");
//                || uri.contains("user_guanzhu")
//                || uri.contains("user_pwd")
//                || uri.contains("broker_proinfo")
//                || uri.contains("broker_fabu")
//                || uri.contains("broker_add_house");
    }

    @Override
    public void postHandle(
            HttpServletRequest httpServletRequest,
            HttpServletResponse httpServletResponse,
            Object o, ModelAndView modelAndView) throws Exception {
    }

    @Override
    public void afterCompletion(
            HttpServletRequest httpServletRequest,
            HttpServletResponse httpServletResponse,
            Object o,
            Exception e) throws Exception {
    }
}
