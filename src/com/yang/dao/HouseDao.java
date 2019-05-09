package com.yang.dao;

import com.yang.entity.ConcernHouse;
import com.yang.entity.House;
import com.yang.entity.IndexHouse;
import com.yang.entity.IndexHouseInfo;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by jiang on 2019/4/30.
 */
@Repository
public interface HouseDao {
    /**
     * 查询房屋信息给首页展示
     *
     * @param type 房屋类型
     * @return 房屋列表
     */
    List<IndexHouseInfo> findHouseByType(int type);

    /**
     * 查询房屋图片
     *
     * @param houseNumber 房屋编号
     * @return 房屋图片列表
     */
    List<String> getHouseImges(int houseNumber);

    /**
     * 查询房屋信息
     *
     * @param houseNumber 房屋编号
     * @return 房屋对象
     */
    House getHouseDetailsOutwithImages(int houseNumber);

    /**
     * 查询所有房屋
     *
     * @param type 房屋类型
     * @return 房屋列表
     */
    List<House> getAllHouseByType(int type);

    /**
     * 根据房屋类型和指定时间段内查询
     *
     * @param type     房屋类型
     * @param nowDate  当前时间
     * @param lastDate 以前时间
     * @return 房屋列表
     */
    List<House> getAllHouseByTypeAndTime(int type, String lastDate, String nowDate);

    /**
     * 查询关注房屋编号列表
     *
     * @param username 用户名
     * @return 房屋编号列表
     */
    List<Integer> findAllConcernHouseNumber(String username);



    /**
     * 通过编号批量查询房屋
     *
     * @param houseNumberList 房屋编号列表
     * @return 房屋列表
     */
    List<House> findAllConcernHouse(List<Integer> houseNumberList);

    //查询该房屋是否已经存在关注表中
    ConcernHouse findConcern(String username, int houseNumber);

    /**
     * 删除关注房源
     *
     * @param houseNumber 房屋编号
     * @param username    用户名
     * @return 删除条数
     */
    int deleteConcern(String username, int houseNumber);

    //添加关注房屋
    int insertConcern(String username, int houseNumber);
}
