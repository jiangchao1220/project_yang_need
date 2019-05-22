package com.yang.util;

import com.yang.entity.HouseVO;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Locale;

/**
 * Created by jiang on 2019/5/9.
 */
public final class SortUtil {
    public static List<HouseVO> sortByTime(List<HouseVO> houseList){
        Collections.sort(houseList, new Comparator<HouseVO>() {
            @Override
            public int compare(HouseVO o1, HouseVO o2) {
                return (java.text.Collator.getInstance(Locale.CHINA)).compare(o2.getHouse().getPublishDate(),o1.getHouse().getPublishDate());
            }
        });
        return houseList;
    }
}
