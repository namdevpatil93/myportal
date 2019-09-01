package com.msrtc.portal.applicant.domain;

public enum StatusEnum {

    DRAFT(0), SAVED(1), SUBMITTED(2), PENDING(3);

    private int id;

    StatusEnum(int id){
        this.id = id;
    }

    public int getId(){
        return this.id;
    }

}
