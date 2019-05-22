package com.yang.dao;

import com.yang.entity.*;
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
     * 查询发布房屋编号列表
     *
     * @param account 用户名
     * @return 房屋编号列表
     */
    List<Integer> findAllPublishHouseNumber(String account);

    /**
     * 查询房屋关注的用户人数
     *
     * @param houseNumber 房屋编号
     * @return 关注人数
     */
    int findAllConcernNum(int houseNumber);

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

    /**
     * 删除当前编号下的所有关注信息
     *
     * @param houseNumber 房屋编号
     * @return 删除条数
     */
    int deleteConcernData(int houseNumber);

    /**
     * 删除当前编号下的发布人绑定表broker_house
     *
     * @param houseNumber 房屋编号
     * @return 删除条数
     */
    int deleteBrokerHouseData(int houseNumber);

    /**
     * 删除当前编号的房屋信息house表数据
     *
     * @param houseNumber 房屋编号
     * @return 删除条数
     */
    int deleteHouseData(int houseNumber);

    //添加关注房屋
    int insertConcern(String username, int houseNumber);

    /**
     * 查询房屋编号是否存在
     *
     * @param houseNumber 房屋编号
     * @return 条数
     */
    int checkNewHouseNumber(int houseNumber);

    /**
     *插入图片表
     *
     * @param imageList 房屋编号
     * @return 条数
     */
    int insertImages(List<Image> imageList);

    /**
     *删除图片表数据
     *
     * @param houseNumber 房屋编号
     * @return 条数
     */
    int delteImages(int houseNumber);

    /**
     * 插入house表
     *
     * @param house 房屋
     * @return 插入条数
     */
    int insertHouse(House house);

    /**
     * 经纪人与发布房屋绑定
     *
     * @param account     账号
     * @param houseNumber 编号
     * @return 插入条数
     */
    int bindBrokerHouse(String account, int houseNumber);

    /**
     * 删除房屋图片
     *
     * @param imageName   图片文件路径
     * @param houseNumber 房屋编号
     * @return
     */
    int deleteImage(String imageName, int houseNumber);

    /**
     * 修改房屋
     *
     * @param house 房屋
     * @return
     */
    int updateHouse(House house);
}
