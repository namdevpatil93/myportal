package com.msrtc.portal.applicant.domain;

public enum CasteEnum {

    OPEN(1), OBC(2), ST(3), SC(4), VJA(5), NTB(6), NTC(7), NTD(8), SBC(9),MARATHA(10), SEBC(10),EWS(11);

    private int casteId;

    CasteEnum(int casteId){
        this.casteId = casteId;
    }

    public int getCasteId() {
        return casteId;
    }
}
