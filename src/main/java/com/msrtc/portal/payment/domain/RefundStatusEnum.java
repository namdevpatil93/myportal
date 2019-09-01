package com.msrtc.portal.payment.domain;

/*
===================================================================================================================================
Refund status
===================================================================================================================================
===================================================================================================================================
Refund Status   | Description
===================================================================================================================================
“0600”          | Payment status (0300) is success but it has been processed for cancellation (0699) i.e. refunded back to customer
“0799”          | Payment status (0300) is success and a refund [either partial/full] was initiated for this transaction
“NA”            | Payment status (0300) is success and is currently not refunded or cancelled.
===================================================================================================================================
*/

public enum RefundStatusEnum {

    S_0699("0699"),
    S_0799("0799"),
    S_NA("NA");

    String status;

    RefundStatusEnum(String status){
        this.status = status;
    }

    public String getStatus() {
        return status;
    }
}
