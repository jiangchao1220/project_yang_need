package com.yang.entity;

import java.util.List;

/**
 * Created by jiang on 2019/5/1.
 */
public class HouseVO implements Comparable<HouseVO>{
    private House house;
    private List<String> houseImages;

    public HouseVO() {
    }

    public House getHouse() {
        return house;
    }

    public void setHouse(House house) {
        this.house = house;
    }

    public List<String> getHouseImages() {
        return houseImages;
    }

    public void setHouseImages(List<String> houseImages) {
        this.houseImages = houseImages;
    }

    @Override
    public int compareTo(HouseVO o) {
        return this.house.getHousePrice() - o.getHouse().getHousePrice();
    }
}
