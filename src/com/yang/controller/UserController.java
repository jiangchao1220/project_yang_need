package com.yang.controller;

import com.yang.entity.User;
import com.yang.entity.UserInfo;
import com.yang.service.UserService;
import com.yang.util.JsonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

/**
 * Created by jiang on 2019/4/14.
 */
@Controller
public class UserController {

    @Autowired
    private UserService userService;

    /**
     * 登录Controller
     *
     * @param httpSession session
     * @param response    response
     * @param username    用户名
     * @param password    密码
     * @return 跳转页面
     * @throws IOException IO异常
     */
    @RequestMapping(value = "/**/login", method = RequestMethod.POST)
    public String login(
            HttpSession httpSession,
            HttpServletResponse response,
            String username,
            String password) throws IOException {
        User user = new User();
        user.setName(username);
        user.setPassword(password);
        User u = userService.loginUser(user);
        System.out.println("jinlai la");
        if (null == u) {
            response.sendRedirect("login.jsp");
        }
        httpSession.setAttribute("loginUser", u.getName());
        return "index";
    }

    /**
     * 查询当前用户是否已存在
     *
     * @param username 用户名
     * @return 不存在返回值:0 ; 已存在返回值:1
     */
    @RequestMapping(value = "/**/checkUserName", method = RequestMethod.GET)
    @ResponseBody
    public String findUserByName(String username) {
        System.out.println("name: " + username);
        int exist = userService.findUserByName(username);
        return JsonUtil.toJSon(exist);
    }

    /**
     * 注册
     *
     * @param username 用户名
     * @param password 密码
     * @return 跳转页面
     */
    @RequestMapping(value = "/**/register", method = RequestMethod.POST)
    public String register(String username, String password) {
        System.out.println("name: " + username + "  pwd:" + password);
        User user = new User();
        user.setName(username);
        user.setPassword(password);
        //校验是否存在用户名
        int vaildate = userService.findUserByName(username);
        if (vaildate == 1) {
            return "reg_failed";
        }

        boolean successFlag = userService.addNewUser(user);
        if (successFlag) {
            // 添加成功
            return "reg_success";
        } else {
            // 添加失败
            return "reg_failed";
        }
    }

    /**
     * 修改密码
     *
     * @param httpSession httpSession
     * @param password    密码
     * @return isSuccess
     */
    @RequestMapping(value = "/**/updatePwssword", method = RequestMethod.GET)
    @ResponseBody
    public String updatePassword(HttpSession httpSession, String password) {
        String userName = String.valueOf(httpSession.getAttribute("loginUser"));
        int isSuccess = userService.updatePassword(userName, password);
        if (isSuccess == 1) {
            //修改成功
            httpSession.removeAttribute("loginUser");
        }
        return JsonUtil.toJSon(isSuccess);
    }

    /**
     * 修改用户资料信息
     *
     * @param userInfo userInfo
     * @return isSuccess
     */
    @RequestMapping(value = "/**/userinfo", method = RequestMethod.GET, produces="text/html;charset=UTF-8;")
    @ResponseBody
    public String addUserInfo(UserInfo userInfo) throws UnsupportedEncodingException {
        //中文解码
        String sex = URLDecoder.decode(userInfo.getSex(),"UTF-8");
        String name = URLDecoder.decode(userInfo.getName(),"UTF-8");
        String signtext = URLDecoder.decode(userInfo.getSigntext(),"UTF-8");
        userInfo.setSex(sex);
        userInfo.setName(name);
        userInfo.setSigntext(signtext);
        System.out.println(JsonUtil.toJSon(userInfo));

        return JsonUtil.toJSon(userInfo);
    }
}
