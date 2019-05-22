package com.yang.entity;

/**
 * Created by jiang on 2019/5/19.
 */
public class Image {
    private int id;
    private int houseNumber;
    private String imgPath;

    public Image() {
    }

    public Image(int houseNumber, String imgPath) {
        this.houseNumber = houseNumber;
        this.imgPath = imgPath;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getHouseNumber() {
        return houseNumber;
    }

    public void setHouseNumber(int houseNumber) {
        this.houseNumber = houseNumber;
    }

    public String getImgPath() {
        return imgPath;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }
}
