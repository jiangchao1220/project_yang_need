package com.yang.model;

/**
 * Created by jiang on 2019/5/2.
 */
public enum HouseType {

    RENT_HOUSE(1),
    NEW_HOUSE(2),
    SECONDHAND_HOUSE(3);

    private static final int NEW_HOUSE_VALUE = 2;
    private static final int SECONDHAND_HOUSE_VALUE = 3;
    private int value;

    HouseType(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }

    public static HouseType findByValue(int value) {
        switch (value) {
            case 1:
                return HouseType.RENT_HOUSE;
            case NEW_HOUSE_VALUE:
                return HouseType.NEW_HOUSE;
            case SECONDHAND_HOUSE_VALUE:
                return HouseType.SECONDHAND_HOUSE;
        }
        return null;
    }
}
