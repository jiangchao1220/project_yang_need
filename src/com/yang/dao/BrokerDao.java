package com.yang.dao;

import com.yang.entity.Broker;
import org.springframework.stereotype.Repository;

/**
 * Created by jiang on 2019/5/12.
 */
@Repository
public interface BrokerDao {
    /**
     * 查询经纪人用户
     *
     * @param username 用户名
     * @param password 密码
     * @return 经纪人
     */
    Broker findBroker(String username, String password);

    /**
     * 查询是否已存在经纪人账号
     *
     * @param accout 账号
     * @return 经纪人
     */
    Broker findBrokerByAccout(String accout);

    /**
     * 修改密码
     *
     * @param username 用户名
     * @param password 密码
     * @return int
     */
    int updatePassword(String username, String password);

    /**
     * 插入
     *
     * @param broker 用户
     * @return int
     */
    int insertBroker(Broker broker);
}
