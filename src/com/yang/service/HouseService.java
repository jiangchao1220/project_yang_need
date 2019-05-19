package com.yang.service;

import com.yang.entity.House;
import com.yang.entity.HouseVO;
import com.yang.entity.IndexHouse;
import com.yang.model.FileUploadState;
import com.yang.model.HouseType;
import org.springframework.web.multipart.MultipartFile;

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

    /**
     * 关注房源
     *
     * @param houseNumber 房屋编号
     * @param username    用户名
     * @return 状态
     */
    String concernHouse(int houseNumber, String username);

    /**
     * 查询用户关注的房源
     *
     * @param username    用户名
     * @return 房屋信息列表
     */
    List<HouseVO> findConcernHouses(String username);

    /**
     * 查询用户发布的房源
     *
     * @param account    用户名
     * @return 房屋信息列表
     */
    List<HouseVO> findPublishHouse(String account);

    /**
     * 查询是否已关注房源
     *
     * @param houseNumber 房屋编号
     * @param username    用户名
     * @return 状态
     */
    String checkConcern(int houseNumber, String username);

    /**
     * 取消关注房源
     *
     * @param houseNumber 房屋编号
     * @param username    用户名
     * @return 状态
     */
    String cancelConcern(int houseNumber, String username);

    /**
     * 插入房源
     *
     * @param house   房屋
     * @param account 用户名
     * @return 状态
     */
    String insertHouse(House house, String account);

    /**
     * 保存房屋图片
     *
     * @param uploadFiles 房屋图片
     * @param account     用户名
     * @return 状态
     */
    FileUploadState saveImages(MultipartFile[] uploadFiles, String account);

    /**
     * 删除房屋
     *
     * @param account 账号
     * @param houseNumber 编号
     * @return 状态
     */
    String deleteHouse(String account, int houseNumber);
}
