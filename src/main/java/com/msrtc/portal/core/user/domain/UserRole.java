package com.msrtc.portal.core.user.domain;

public enum UserRole {
    ADMIN(1), APPLICANT(2);

    int id;

    UserRole(int id){
        this.id = id;
    }

    public int getId(){
        return this.id;
    }
}