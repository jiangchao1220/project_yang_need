package com.yang.util;

import com.mysql.fabric.xmlrpc.base.Data;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Created by jiang on 2019/5/2.
 */
public final class DateUtil {

    /**
     * 获取前n天的日期
     *
     * @param nowDate 当前日期
     * @param n 前n天
     * @return 前n天日期
     */
    public static String getLastDate(String nowDate, int n){
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();
        String lastDate = "";
        try {
            Date date = dateFormat.parse(nowDate);
            calendar.setTime(date);
            int day = calendar.get(Calendar.DATE);
            calendar.set(Calendar.DATE, day-n);
            lastDate = dateFormat.format(calendar.getTime());
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return lastDate;
    }
}
