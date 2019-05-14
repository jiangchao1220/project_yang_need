package com.yang.entity;

/**
 * Created by jiang on 2019/5/12.
 */
public class Broker {
    private int id;
    private String accout;
    private String password;
    private String phone;
    private String name;
    private String sex;
    private String info;
    private int age;

    public Broker() {
    }

    public Broker(String accout, String password, String phone, String name, String sex) {
        this.accout = accout;
        this.password = password;
        this.phone = phone;
        this.name = name;
        this.sex = sex;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAccout() {
        return accout;
    }

    public void setAccout(String accout) {
        this.accout = accout;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }
}
