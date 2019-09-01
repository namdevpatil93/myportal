package com.msrtc.portal.payment.domain;

public enum PaymentTransactionStatusEnum {

    PENDING(0), SUCCESS(1), FAILURE(2);

    PaymentTransactionStatusEnum(int id){
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
