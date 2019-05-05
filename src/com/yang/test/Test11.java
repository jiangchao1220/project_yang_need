package com.yang.test;

import com.yang.entity.House;
import com.yang.entity.HouseVO;
import com.yang.entity.IndexHouse;
import com.yang.entity.User;
import com.yang.model.HouseType;
import com.yang.service.HouseService;
import com.yang.service.UserService;
import com.yang.util.DateUtil;
import com.yang.util.JsonUtil;
import javafx.scene.input.DataFormat;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import javax.xml.bind.util.JAXBSource;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by jiang on 2019/3/31.
 */
public class Test11 {
    //test
    @Test
    public void test1()
    {
        ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
//        UserService us = (UserService) ac.getBean("userServiceImpl");
//        User user = us.getUser("1");
//        System.out.println(user.getName());
//
//        System.out.println(us.updateUser(new User("1", "yangchao", "321")));

        HouseService hs = (HouseService) ac.getBean("houseServiceImpl");
//        List<IndexHouse> houseList = hs.findHouse(1);
//        for (IndexHouse indexHouse : houseList) {
//            System.out.println(JsonUtil.toJSon(indexHouse));
//        }

//        HouseVO houseVO = hs.getHouseDetails(312737);
//        System.out.println(houseVO.getHouse().getPublishDate());
//        System.out.println(HouseType.NEW_HOUSE.getValue());
//
//        HouseType houseType = HouseType.findByValue(1);
//        List<HouseVO> list = hs.getAllHouseByType(houseType);
//        System.out.println(list.size());

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String date = dateFormat.format(new Date());
        System.out.println(date);

        System.out.println(DateUtil.getLastDate(date, 7));

        HouseType houseType = HouseType.findByValue(3);
        List<HouseVO> list = hs.getAllHouseByType(houseType);
        Collections.sort(list);
        System.out.println(list.size());
        System.out.println(JsonUtil.toJSon(list));

        Collections.sort(list, new Comparator<HouseVO>() {
            @Override
            public int compare(HouseVO o1, HouseVO o2) {
                return (java.text.Collator.getInstance(Locale.CHINA)).compare(o2.getHouse().getPublishDate(),o1.getHouse().getPublishDate());
            }
        });

        for (HouseVO houseVO : list) {
            System.out.println(houseVO.getHouse().getPublishDate());
        }
    }
}
