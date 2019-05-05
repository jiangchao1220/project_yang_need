package com.yang.service;

import com.yang.entity.House;
import com.yang.entity.HouseVO;
import com.yang.entity.IndexHouse;
import com.yang.model.HouseType;

import java.util.List;

/**
 * Created by jiang on 2019/4/30.
 */
public interface HouseService {
    /**
     * 查询房屋信息给首页展示
     *
     * @param type 房屋类型
     * @return 房屋列表
     */
    List<IndexHouse> findHouse(int type);

    /**
     * 查询房屋详情
     *
     * @param houseNumber 房屋编号
     * @return HouseVO对象
     */
    HouseVO getHouseDetails(int houseNumber);

    /**
     * 通过房屋类型查询所有该类型房源信息
     *
     * @param houseType 房屋类型
     * @return 房屋列表
     */
    List<HouseVO> getAllHouseByType(HouseType houseType);

    /**
     * 查询最近一周添加的指定类型分房源
     *
     * @param houseType 房屋类型
     * @return 房屋列表
     */
    List<HouseVO> getNewAddHouse(HouseType houseType);
}
