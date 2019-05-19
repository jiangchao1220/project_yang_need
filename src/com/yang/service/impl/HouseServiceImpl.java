package com.yang.service.impl;

import com.yang.dao.BrokerDao;
import com.yang.dao.HouseDao;
import com.yang.entity.*;
import com.yang.model.FileUploadState;
import com.yang.model.HouseType;
import com.yang.service.HouseService;
import com.yang.util.DateUtil;
import com.yang.util.FileUtil;
import com.yang.util.SortUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by jiang on 2019/4/30.
 */
@Service("houseServiceImpl")
public class HouseServiceImpl implements HouseService {
    @Autowired
    private HouseDao houseDao;
    @Autowired
    private BrokerDao brokerDao;

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
        return getHouseImages(houseList);
    }

    @Override
    public List<HouseVO> getNewAddHouse(HouseType houseType) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        // 明天日期
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(new Date());
        calendar.add(calendar.DATE, 1);
        String tomorrow = dateFormat.format(calendar.getTime());
        // 一周前日期
        String servenDaysAgo = DateUtil.getLastDate(tomorrow, 8);

        List<House> houseList
                = houseDao.getAllHouseByTypeAndTime(houseType.getValue(), servenDaysAgo, tomorrow);
        List<HouseVO> houseVOList = getHouseImages(houseList);
        return houseVOList;
    }

    private List<HouseVO> getHouseImages(List<House> houseList) {
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
    public List<HouseVO> findConcernHouses(String username) {
        //查询当前用户关注的所有房屋编号
        List<Integer> houseNumberList = houseDao.findAllConcernHouseNumber(username);
        List<HouseVO> houseVOList = new ArrayList<>();
        if (houseNumberList.size() == 0) {
            return houseVOList;
        }
        //批量查询house表
        List<House> houseList = houseDao.findAllConcernHouse(houseNumberList);
        //添加每所房屋图片列表
        houseVOList = getHouseImages(houseList);
        return SortUtil.sortByTime(houseVOList);
    }

    @Override
    public List<HouseVO> findPublishHouse(String account) {
        //查询当前用户发布的所有房屋编号
        List<Integer> houseNumberList = houseDao.findAllPublishHouseNumber(account);
        List<HouseVO> houseVOList = new ArrayList<>();
        if (houseNumberList.size() == 0) {
            return houseVOList;
        }
        //批量查询house表
        List<House> houseList = houseDao.findAllConcernHouse(houseNumberList);
        //添加每所房屋图片列表
        houseVOList = getHouseImages(houseList);
        //添加关注人数
        addConcernNum(houseVOList);
        return SortUtil.sortByTime(houseVOList);
    }

    private void addConcernNum(List<HouseVO> houseVOList) {
        for (HouseVO houseVO : houseVOList) {
            houseVO.setConcernNum(houseDao.findAllConcernNum(houseVO.getHouse().getHouseNumber()));
        }
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

    @Override
    public String cancelConcern(int houseNumber, String username) {
        int num = houseDao.deleteConcern(username, houseNumber);
        if (num == 1) {
            return "deletesuccessed";
        } else {
            return "deletefailed";
        }
    }

    @Override
    public String insertHouse(House house, String account) {
        //查询发布人信息
        Broker broker = brokerDao.getBrokerInfo(account);
        house.setPublisher(broker.getName());
        house.setPublisherPhone(broker.getPhone());
        String time = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date());
        house.setPublishDate(time);
        //1.插入房屋信息
        int stepA = houseDao.insertHouse(house);
        int stepB = 0;
        //2.插入成功,绑定经纪人
        if (stepA == 1) {
            stepB = houseDao.bindBrokerHouse(account, house.getHouseNumber());
        }
        String msg = "fail";
        if (stepA == 1 && stepB == 1) {
            msg = "success";
        }
        return msg;
    }

    @Override
    public FileUploadState saveImages(MultipartFile[] uploadFiles, String account) {
        String time = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        String msg = "";
        // 生成房屋编号
        int newNum = getNewNumber();
        List<Image> imageList = new ArrayList<>();
        List<String> fileNameList = new ArrayList<>();
        int insertNum = 0;
        try {
            for (MultipartFile file : uploadFiles) {
                // 文件原名称
                String originalfileName = file.getOriginalFilename();
                System.out.println("上传的文件原名称:" + originalfileName);
                // 文件类型
                String type = originalfileName.indexOf(".") != -1
                        ? originalfileName.substring(originalfileName.lastIndexOf(".") + 1, originalfileName.length()) : null;
                int imgRandomNum = (int) (Math.random() * 100);
                String fileName = time + imgRandomNum + "." + type;
                msg = FileUtil.saveFiles(file.getInputStream(), fileName);
                if ("success".equals(msg)) {
                    Image image = new Image(newNum, "images" + File.separator + fileName);
                    imageList.add(image);
                    fileNameList.add(fileName);
                }
            }
            // 插入图片表
            if (imageList.size() > 0) {
                insertNum = houseDao.insertImages(imageList);
            }
        } catch (IOException e) {
            e.printStackTrace();
            return new FileUploadState("fail", newNum, fileNameList);
        }
        if (insertNum > 0) {
            return new FileUploadState("success", newNum, fileNameList);
        } else {
            // 删除已经添加的文件
            for (String fileName : fileNameList) {
                FileUtil.deleteFileByFileName(fileName);
            }
            //删除数据库
            houseDao.delteImages(newNum);
            return new FileUploadState("fail", Integer.MIN_VALUE, null);
        }

    }

    @Override
    public String deleteHouse(String account, int houseNumber) {
        //1.查询房屋图片
        List<String> imagesList = houseDao.getHouseImges(houseNumber);
        //2.删除图片表数据
        houseDao.delteImages(houseNumber);
        //3.删除图片文件
        for (String str : imagesList) {
            String[] strs = str.split(""+ File.separator + File.separator);
            FileUtil.deleteFileByFileName(strs[1]);
        }
        //4.删除house表数据
        int b = houseDao.deleteHouseData(houseNumber);
        //5.删除broker_house表数据
        houseDao.deleteBrokerHouseData(houseNumber);
        //6.删除user_concern表数据
        houseDao.deleteConcernData(houseNumber);
        if (b > 0) {
            return "deletesuccessed";
        } else {
            return "删除失败,请联系管理员!";
        }
    }

    private int getNewNumber() {
        int newHouseNumber = (int) (Math.random() * 1000000);
        if (houseDao.checkNewHouseNumber(newHouseNumber) != 0) {
            getNewNumber();
        }
        return newHouseNumber;
    }
}
