package com.yang.service;

import javax.servlet.http.HttpSession;

/**
 * Created by jiang on 2019/5/9.
 */
public interface SignOutService {
    /**
     * 注销登录
     *
     * @param httpSession session
     * @return info
     */
    String signOut(HttpSession httpSession);
}
