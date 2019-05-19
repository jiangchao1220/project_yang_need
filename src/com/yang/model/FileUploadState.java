package com.yang.model;

import java.util.List;

/**
 * Created by jiang on 2019/5/19.
 */
public class FileUploadState {
    private String state;
    private int houseNumber;
    private List<String> fileNameList;

    public FileUploadState(String state, int houseNumber, List<String> fileNameList) {
        this.state = state;
        this.houseNumber = houseNumber;
        this.fileNameList = fileNameList;
    }

    public List<String> getFileNameList() {
        return fileNameList;
    }

    public void setFileNameList(List<String> fileNameList) {
        this.fileNameList = fileNameList;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public int getHouseNumber() {
        return houseNumber;
    }

    public void setHouseNumber(int houseNumber) {
        this.houseNumber = houseNumber;
    }
}
