package com.yang.controller;

import com.yang.entity.House;
import com.yang.entity.HouseVO;
import com.yang.entity.IndexHouse;
import com.yang.model.HouseType;
import com.yang.service.impl.HouseServiceImpl;
import com.yang.util.JsonUtil;
import com.yang.util.SortUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import static com.yang.model.HouseType.findByValue;

/**
 * Created by jiang on 2019/4/18.
 */
@Controller
@RequestMapping("/house")
public class HouseController {

    @Autowired
    private HouseServiceImpl houseService;

    public HouseController() {
        System.out.println("Controller init!");
    }

    //基本类型绑定,参数名对应即可或者@RequestParam(value="参数名与前台传参一致")

    /**
     * 根据房屋类型查询
     *
     * @param type 房屋类型:租房,新房,二手房
     * @return 房屋信息列表
     * @throws IOException
     */
    @RequestMapping(value = "/findHouse", method = RequestMethod.GET)
    @ResponseBody
    public String test(int type) throws IOException {
        List<IndexHouse> houses;
        switch (type) {
            case 1:
            case 2:
            case 3:
                houses = houseService.findHouse(type);
                break;
            default:
                houses = new ArrayList<>();
        }
        return JsonUtil.toJSon(houses);
    }

    /**
     * 跳转房屋详情页
     *
     * @param houseNumber 房屋编号
     * @return 房屋详情页
     * @throws IOException
     */
    @RequestMapping(value = "/proinfo", method = RequestMethod.GET)
    public String turnHouseDetailsPage(int houseNumber, HttpSession httpSession) throws IOException {
        System.out.println(houseNumber);
        httpSession.setAttribute("houseNumber", houseNumber);
        return "proinfo";
    }

    /**
     * 跳转经纪人房屋详情页
     *
     * @param houseNumber 房屋编号
     * @return 房屋详情页
     * @throws IOException
     */
    @RequestMapping(value = "/brokerProinfo", method = RequestMethod.GET)
    public String turnBrokerHouseDetailsPage(int houseNumber, HttpSession httpSession) throws IOException {
        System.out.println(houseNumber);
        httpSession.setAttribute("brokerDetailHouseNumber", houseNumber);
        return "broker_proinfo";
    }

    /**
     * 房屋详情页查询房屋
     *
     * @param houseNumber 房屋编号
     * @return 房屋信息
     */
    @RequestMapping(value = "/detail", method = RequestMethod.GET)
    @ResponseBody
    public String getHouseDetails(int houseNumber) {
        HouseVO houseVO = houseService.getHouseDetails(houseNumber);
        return JsonUtil.toJSon(houseVO);
    }

    /**
     * 更多页面获取所有房源信息,默认排序:时间
     *
     * @param type 房屋类型
     * @return 房屋列表Json串
     */
    @RequestMapping(value = "/getAllHouse", method = RequestMethod.GET)
    @ResponseBody
    public String getAllHouseByType(int type) {
        HouseType houseType = findByValue(type);
        List<HouseVO> houseList;
        switch (type) {
            case 1:
                houseList = houseService.getAllHouseByType(HouseType.RENT_HOUSE);
                break;
            case 2:
                houseList = houseService.getAllHouseByType(HouseType.NEW_HOUSE);
                break;
            case 3:
                houseList = houseService.getAllHouseByType(HouseType.SECONDHAND_HOUSE);
                break;
            default:
                houseList = new ArrayList<>();
        }
        return JsonUtil.toJSon(SortUtil.sortByTime(houseList));
    }

    /**
     * 更多页面获取所有房源信息,价格排序
     *
     * @param type 房屋类型
     * @return 房屋列表Json串
     */
    @RequestMapping(value = "/houseSortByPrice", method = RequestMethod.GET)
    @ResponseBody
    public String houseSortByPrice(int type) {
        HouseType houseType = findByValue(type);
        List<HouseVO> houseList;
        switch (type) {
            case 1:
                houseList = houseService.getAllHouseByType(houseType);
                break;
            case 2:
                houseList = houseService.getAllHouseByType(houseType);
                break;
            case 3:
                houseList = houseService.getAllHouseByType(houseType);
                break;
            default:
                houseList = new ArrayList<>();
        }
        Collections.sort(houseList);
        return JsonUtil.toJSon(houseList);
    }

    /**
     * 更多页面获取最近上新房源信息
     *
     * @param type 房屋类型
     * @return 房屋列表Json串
     */
    @RequestMapping(value = "/getNewAddHouse", method = RequestMethod.GET)
    @ResponseBody
    public String getNewAddHouseByType(int type) {
        HouseType houseType = findByValue(type);
        List<HouseVO> houseList = houseService.getNewAddHouse(houseType);
        return JsonUtil.toJSon(houseList);
    }


    /**
     * 关注房源
     *
     * @param houseNumber 房屋编号
     * @param username    用户名
     * @return 状态
     */
    @RequestMapping(value = "/concernHouse", method = RequestMethod.GET)
    @ResponseBody
    public String userConcern(int houseNumber, String username) {
        if (username == null){
            return JsonUtil.toJSon("notlogin");
        }
        String state = houseService.concernHouse(houseNumber, username);
        return JsonUtil.toJSon(state);
    }

    /**
     * 查询用户关注的房源
     *
     * @param username    用户名
     * @return 房屋信息列表
     */
    @RequestMapping(value = "/findConcernHouse", method = RequestMethod.GET)
    @ResponseBody
    public String findConcernHouse(String username) {
        System.out.println("关注房源:"+ username);
        if (username == null){
            return JsonUtil.toJSon("notlogin");
        }
        List<HouseVO> houseVOList = houseService.findConcernHouses(username);
        return JsonUtil.toJSon(houseVOList);
    }

    /**
     * 查询经纪人发布的房源
     *
     * @param account    账户名
     * @return 房屋信息列表
     */
    @RequestMapping(value = "/findPublishHouse", method = RequestMethod.GET)
    @ResponseBody
    public String findPublishHouse(String account) {
        System.out.println("发布房源:"+ account);
        if (account == null){
            return JsonUtil.toJSon("notlogin");
        }
        List<HouseVO> houseVOList = houseService.findPublishHouse(account);
        return JsonUtil.toJSon(houseVOList);
    }

    /**
     * 查询是否已关注房源
     *
     * @param houseNumber 房屋编号
     * @param username    用户名
     * @return 状态
     */
    @RequestMapping(value = "/checkConcern", method = RequestMethod.GET)
    @ResponseBody
    public String checkConcern(int houseNumber, String username) {
        String state = houseService.checkConcern(houseNumber, username);
        return JsonUtil.toJSon(state);
    }

    /**
     * 个人中心取消关注房源
     *
     * @param houseNumber 房屋编号
     * @param username    用户名
     * @return 状态
     */
    @RequestMapping(value = "/cancelConcern", method = RequestMethod.GET)
    @ResponseBody
    public String cancelConcern(int houseNumber, String username) {
        return JsonUtil.toJSon(houseService.cancelConcern(houseNumber, username));
    }

    /**
     * 经纪人发布房屋
     *
     * @param session session
     * @param house   房屋
     * @return 状态
     */
    @RequestMapping(value = "/addHouse", method = RequestMethod.POST)
    @ResponseBody
    public String addHouse(HttpSession session, House house) {
        String account = String.valueOf(session.getAttribute("loginUser"));
        System.out.println(JsonUtil.toJSon(house));
        return JsonUtil.toJSon(houseService.insertHouse(house, account));
    }

    @RequestMapping(value = "/addHouseByFromData", method = RequestMethod.POST)
    @ResponseBody
    public String addHouseByFromData(
            HttpSession session,
            @RequestParam(value = "images", required = false) MultipartFile[] uploadFiles) {
        return JsonUtil.toJSon(houseService.saveImages(uploadFiles, String.valueOf(session.getAttribute("loginUser"))));
    }
}
