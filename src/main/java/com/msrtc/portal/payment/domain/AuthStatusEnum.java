package com.msrtc.portal.payment.domain;

/*
=============================================================================================
Authorization status
=============================================================================================
=============================================================================================
AuthStatus      | Status Reason                                 | Proposed Transaction Status
=============================================================================================
“0300”          | Success                                       | Successful Transaction
“0399”          | Invalid Authentication at Bank                | Cancel Transaction
“NA”            | Invalid Input in the Request Message          | Cancel Transaction
“0002”          | BillDesk is waiting for Response from Bank    | Pending Transaction
“0001”          | Error at BillDesk                             | Cancel Transaction
=============================================================================================
*/

public enum AuthStatusEnum {

    S_0300("0300"),
    S_0399("0399"),
    S_NA("NA"),
    S_0002("0002"),
    S_0001("0001");

    String status;

    AuthStatusEnum(String status){
        this.status = status;
    }

    public String getStatus() {
        return status;
    }
}
