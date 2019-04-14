package com.yang.test;

import com.yang.entity.User;
import com.yang.service.UserService;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * Created by jiang on 2019/3/31.
 */
public class Test11 {
    //test
    @Test
    public void test1()
    {
        ApplicationContext ac = new ClassPathXmlApplicationContext("spring-servlet.xml");
        UserService us = (UserService) ac.getBean("userServiceImpl");
        User user = us.getUser(1);
        System.out.println(user.getName());

        System.out.println(us.updateUser(new User(0, "yangchao", "321")));
    }
}
