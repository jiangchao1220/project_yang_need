package com.yang.entity;

/**
 * Created by jiang on 2019/5/1.
 */
public class House{
    private int houseId;
    private int houseNumber;
    //房屋简略描述
    private String houseInfo;
    private int housePrice;
    //室 厅 卫
    private String houseType;
    private int houseArea;
    private String houseTowards;
    private int houseFloor;
    // 装修类型
    private String houseDecorationtype;
    private String houseAddress;
    // 房屋类型:租房,新房,二手房
    private int type;
    //房屋描述
    private String houseDetails;
    //小区介绍
    private String introduced;
    //位置
    private String houseLocation;
    //发布人
    private String publisher;
    //发布时间
    private String publishDate;

    public House() {
    }

    public String getHouseLocation() {
        return houseLocation;
    }

    public void setHouseLocation(String houseLocation) {
        this.houseLocation = houseLocation;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public String getPublishDate() {
        return publishDate;
    }

    public void setPublishDate(String publishDate) {
        this.publishDate = publishDate;
    }

    public int getHouseId() {
        return houseId;
    }

    public void setHouseId(int houseId) {
        this.houseId = houseId;
    }

    public int getHouseNumber() {
        return houseNumber;
    }

    public void setHouseNumber(int houseNumber) {
        this.houseNumber = houseNumber;
    }

    public String getHouseInfo() {
        return houseInfo;
    }

    public void setHouseInfo(String houseInfo) {
        this.houseInfo = houseInfo;
    }

    public int getHousePrice() {
        return housePrice;
    }

    public void setHousePrice(int housePrice) {
        this.housePrice = housePrice;
    }

    public String getHouseType() {
        return houseType;
    }

    public void setHouseType(String houseType) {
        this.houseType = houseType;
    }

    public int getHouseArea() {
        return houseArea;
    }

    public void setHouseArea(int houseArea) {
        this.houseArea = houseArea;
    }

    public String getHouseTowards() {
        return houseTowards;
    }

    public void setHouseTowards(String houseTowards) {
        this.houseTowards = houseTowards;
    }

    public int getHouseFloor() {
        return houseFloor;
    }

    public void setHouseFloor(int houseFloor) {
        this.houseFloor = houseFloor;
    }

    public String getHouseDecorationtype() {
        return houseDecorationtype;
    }

    public void setHouseDecorationtype(String houseDecorationtype) {
        this.houseDecorationtype = houseDecorationtype;
    }

    public String getHouseAddress() {
        return houseAddress;
    }

    public void setHouseAddress(String houseAddress) {
        this.houseAddress = houseAddress;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getHouseDetails() {
        return houseDetails;
    }

    public void setHouseDetails(String houseDetails) {
        this.houseDetails = houseDetails;
    }

    public String getIntroduced() {
        return introduced;
    }

    public void setIntroduced(String introduced) {
        this.introduced = introduced;
    }
}
