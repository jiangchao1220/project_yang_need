package com.yang.service.impl;

import com.yang.dao.HouseDao;
import com.yang.entity.*;
import com.yang.model.HouseType;
import com.yang.service.HouseService;
import com.yang.util.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by jiang on 2019/4/30.
 */
@Service("houseServiceImpl")
public class HouseServiceImpl implements HouseService {
    @Autowired
    private HouseDao houseDao;

    @Override
    public List<IndexHouse> findHouse(int type) {
        List<IndexHouseInfo> houseInfos = houseDao.findHouseByType(type);
        List<IndexHouse> houses = new ArrayList<>();
        for (IndexHouseInfo houseInfo : houseInfos) {
            IndexHouse indexHouse = new IndexHouse();
            indexHouse.setDecorationType(houseInfo.getDecorationType());
            indexHouse.setHouseInfo(houseInfo.getHouseInfo());
            indexHouse.setHouseType(houseInfo.getHouseType());
            indexHouse.setHouseNumber(houseInfo.getHouseNumber());
            indexHouse.setHousePrice(houseInfo.getHousePrice());
            indexHouse.setHouseDetails(houseInfo.getHouseDetails());
            indexHouse.setImages(houseDao.getHouseImges(houseInfo.getHouseNumber()));

            houses.add(indexHouse);
        }
        return houses;
    }

    @Override
    public HouseVO getHouseDetails(int houseNumber) {
        House house = houseDao.getHouseDetailsOutwithImages(houseNumber);
        List<String> images = houseDao.getHouseImges(houseNumber);
        HouseVO houseVO = new HouseVO();
        houseVO.setHouse(house);
        houseVO.setHouseImages(images);
        return houseVO;
    }

    @Override
    public List<HouseVO> getAllHouseByType(HouseType houseType) {
        List<House> houseList = houseDao.getAllHouseByType(houseType.getValue());
//        List<HouseVO> houseVOList = new ArrayList<>();
//        for (House house : houseList) {
//            List<String> images = houseDao.getHouseImges(house.getHouseNumber());
//            HouseVO houseVO = new HouseVO();
//            houseVO.setHouse(house);
//            houseVO.setHouseImages(images);
//            houseVOList.add(houseVO);
//        }
        return getHouseImages(houseList);
    }

    @Override
    public List<HouseVO> getNewAddHouse(HouseType houseType) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        // 当前时间
        String nowDate = dateFormat.format(new Date());
        // 一周前时间
        String servenDaysAgo = DateUtil.getLastDate(nowDate, 7);

        List<House> houseList
                = houseDao.getAllHouseByTypeAndTime(houseType.getValue(),servenDaysAgo,nowDate);
        List<HouseVO> houseVOList = getHouseImages(houseList);
        return houseVOList;
    }

    private List<HouseVO> getHouseImages(List<House> houseList){
        List<HouseVO> houseVOList = new ArrayList<>();
        for (House house : houseList) {
            List<String> images = houseDao.getHouseImges(house.getHouseNumber());
            HouseVO houseVO = new HouseVO();
            houseVO.setHouse(house);
            houseVO.setHouseImages(images);
            houseVOList.add(houseVO);
        }
        return houseVOList;
    }

    @Override
    public String concernHouse(int houseNumber, String username) {
        //先查询是否存在关注
        ConcernHouse concernHouse = houseDao.findConcern(username, houseNumber);
        int delete = 0;
        int insert = 0;
        if (concernHouse != null) {
            //存在,执行删除操作
            delete = houseDao.deleteConcern(username, houseNumber);
        } else {
            //不存在,执行添加操作
            insert = houseDao.insertConcern(username, houseNumber);
        }

        if (delete == 1) {
            return "cancelConcern";
        }
        if (insert == 1) {
            return "concern";
        }
        return "false";
    }

    @Override
    public String checkConcern(int houseNumber, String username) {
        ConcernHouse concernHouse = houseDao.findConcern(username, houseNumber);
        if (concernHouse != null) {
            //已关注
            return "concern";
        } else {
            //未关注
            return "notConcern";
        }
    }
}
