package com.yang.test;

import com.yang.entity.*;
import com.yang.model.HouseType;
import com.yang.service.BrokerService;
import com.yang.service.HouseService;
import com.yang.service.UserService;
import com.yang.util.CryptographyUtil;
import com.yang.util.DateUtil;
import com.yang.util.JsonUtil;
import javafx.scene.input.DataFormat;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import javax.servlet.http.HttpSession;
import javax.xml.bind.util.JAXBSource;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by jiang on 2019/3/31.
 */
public class Test11 {
    @Test
    public void fileDelteTest() {
        File tempFile = new File("F:\\test" + File.separator + "c.gif");
        if (tempFile.exists()) {
            tempFile.delete();
        }
    }

    @Test
    public void savrImgTest() {
        String imgPath = this.getClass().getClassLoader().getResource("").getPath();
        System.out.println(imgPath);
        String time = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        for (int i =0; i<5; i++){
            int imgRandomNum = (int) (Math.random() * 100);
            String fileName = time + imgRandomNum;
            System.out.println(fileName);
        }
        int intFlag = (int) (Math.random() * 1000000);
        System.out.println(intFlag+"**********");
    }

    @Test
    public void md5Test() {
        String md5Str = CryptographyUtil.md5("aa11111","yc");
        System.out.println(md5Str);
        String md5Str3 = CryptographyUtil.md5("jc123456","yc");
        System.out.println(md5Str3);
        String md5Str4 = CryptographyUtil.md5("321","yc");
        System.out.println(md5Str4);
    }

    @Test
    public void brokerServiceTest() {
        ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
        BrokerService bs = (BrokerService) ac.getBean("brokerServiceImpl");
//        String broker = bs.borkerLogin("18428327241", "yc12345");
//        System.out.println(broker);
//
//        String broker2 = bs.borkerLogin("18428327111", "yc12345");
//        System.out.println(broker2);
//
//        String broker3 = bs.borkerLogin(null, null);
//        System.out.println(broker3);
//
//        String broker4 = bs.borkerLogin("", "");
//        System.out.println(broker4);
    }

    @Test
    public void brokerUpPwdTest() {
        ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
        BrokerService bs = (BrokerService) ac.getBean("brokerServiceImpl");
        UserService us = (UserService) ac.getBean("userServiceImpl");
        us.updatePassword("18428327241", "yc123456");
    }

    //test
    @Test
    public void testr1(){
        ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
        HouseService hs = (HouseService) ac.getBean("houseServiceImpl");
        UserService us = (UserService) ac.getBean("userServiceImpl");
//        int s = us.updatePassword("18684016465", "jc994128");
//        System.out.println(s);
//        String a = hs.concernHouse(1,"123");
        HouseVO houseVO = hs.getHouseDetails(312737);
        System.out.println(houseVO.getHouse().getPublisher()+" "+houseVO.getHouse().getPublisherPhone());
        List<HouseVO> houseVOList = hs.findConcernHouses("18684016465");
        for (HouseVO vo : houseVOList) {

            System.out.println(vo.getHouse().getHouseInfo());
        }
    }

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
