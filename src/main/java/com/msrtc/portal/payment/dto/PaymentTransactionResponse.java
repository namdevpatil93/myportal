package com.msrtc.portal.payment.dto;

import java.io.Serializable;

public class PaymentTransactionResponse implements Serializable {

    private static final long serialVersionUID = 5215664174768362960L;

    private String merchantId;
    private String orderNo;
    private String txnReferenceNo;
    private String txnAmount;
    private String authStatus;
    private String mobileNo;
    private String emailAddress;
    private String errorDescription;
    private String checksum;
    
    public String getMerchantId() {
        return merchantId;
    }

    public void setMerchantId(String merchantId) {
        this.merchantId = merchantId;
    }

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public String getTxnReferenceNo() {
        return txnReferenceNo;
    }

    public void setTxnReferenceNo(String txnReferenceNo) {
        this.txnReferenceNo = txnReferenceNo;
    }

    public String getTxnAmount() {
        return txnAmount;
    }

    public void setTxnAmount(String txnAmount) {
        this.txnAmount = txnAmount;
    }

    public String getAuthStatus() {
        return authStatus;
    }

    public void setAuthStatus(String authStatus) {
        this.authStatus = authStatus;
    }

    public String getMobileNo() {
        return mobileNo;
    }

    public void setMobileNo(String mobileNo) {
        this.mobileNo = mobileNo;
    }

    public String getEmailAddress() {
        return emailAddress;
    }

    public void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
    }

    public String getChecksum() {
        return checksum;
    }

    public void setChecksum(String checksum) {
        this.checksum = checksum;
    }

    public String getErrorDescription() {
        return errorDescription;
    }

    public void setErrorDescription(String errorDescription) {
        this.errorDescription = errorDescription;
    }

    @Override
    public String toString() {
        return "PaymentResponse{" +
                "merchantId='" + merchantId + '\'' +
                ", orderNo='" + orderNo + '\'' +
                ", txnReferenceNo='" + txnReferenceNo + '\'' +
                ", txnAmount='" + txnAmount + '\'' +
                ", authStatus='" + authStatus + '\'' +
                ", mobileNo='" + mobileNo + '\'' +
                ", emailAddress='" + emailAddress + '\'' +
                ", errorDescription='" + errorDescription + '\'' +
                '}';
    }
}
