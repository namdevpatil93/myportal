package com.msrtc.portal.payment.domain;

public enum PaymentModeEnum {

    ONLINE(1), OFFLINE(2);

    PaymentModeEnum(int id){
        this.id = id;
    }

    int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
