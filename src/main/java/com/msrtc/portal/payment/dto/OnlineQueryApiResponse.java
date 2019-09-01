package com.msrtc.portal.payment.dto;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Column;

public class OnlineQueryApiResponse implements Serializable {

    private static final long serialVersionUID = 9103528100818747502L;

    private String requestType;
    private String merchantID;
    private String orderNo;
    private String txnReferenceNo;
    private String txnAmount;
    private String authStatus;
    private String filler1;
    private String refundStatus;
    private String totalRefundAmount;
    private String lastRefundDate;
    private String lastRefundRefNo;
    private String queryStatus;
    private String checksum;
    private String errorStatus;
    private String errorDescription;
    private String email;
    private String mobile;
    private boolean success;
    
    private String dbApplicantionId;

    
    private String dbOrderNo;

    
    private BigDecimal dbAmount;

   
    private String dbTxnReferenceNo;

    
    private int dbStatus;

   
    private String dbauthStatus;

    
    private String dbResponseMessage; 

    public String getRequestType() {
        return requestType;
    }

    public void setRequestType(String requestType) {
        this.requestType = requestType;
    }

    public String getMerchantID() {
        return merchantID;
    }

    public void setMerchantID(String merchantID) {
        this.merchantID = merchantID;
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

    public String getFiller1() {
        return filler1;
    }

    public void setFiller1(String filler1) {
        this.filler1 = filler1;
    }

    public String getRefundStatus() {
        return refundStatus;
    }

    public void setRefundStatus(String refundStatus) {
        this.refundStatus = refundStatus;
    }

    public String getTotalRefundAmount() {
        return totalRefundAmount;
    }

    public void setTotalRefundAmount(String totalRefundAmount) {
        this.totalRefundAmount = totalRefundAmount;
    }

    public String getLastRefundDate() {
        return lastRefundDate;
    }

    public void setLastRefundDate(String lastRefundDate) {
        this.lastRefundDate = lastRefundDate;
    }

    public String getLastRefundRefNo() {
        return lastRefundRefNo;
    }

    public void setLastRefundRefNo(String lastRefundRefNo) {
        this.lastRefundRefNo = lastRefundRefNo;
    }

    public String getQueryStatus() {
        return queryStatus;
    }

    public void setQueryStatus(String queryStatus) {
        this.queryStatus = queryStatus;
    }

    public String getChecksum() {
        return checksum;
    }

    public void setChecksum(String checksum) {
        this.checksum = checksum;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getErrorStatus() {
        return errorStatus;
    }

    public void setErrorStatus(String errorStatus) {
        this.errorStatus = errorStatus;
    }

    public String getErrorDescription() {
        return errorDescription;
    }

    public void setErrorDescription(String errorDescription) {
        this.errorDescription = errorDescription;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    @Override
    public String toString() {
        return "OnlineQueryApiResponse{" +
                "requestType='" + requestType + '\'' +
                ", merchantID='" + merchantID + '\'' +
                ", orderNo='" + orderNo + '\'' +
                ", txnReferenceNo='" + txnReferenceNo + '\'' +
                ", txnAmount='" + txnAmount + '\'' +
                ", authStatus='" + authStatus + '\'' +
                ", filler1='" + filler1 + '\'' +
                ", refundStatus='" + refundStatus + '\'' +
                ", totalRefundAmount='" + totalRefundAmount + '\'' +
                ", lastRefundDate='" + lastRefundDate + '\'' +
                ", lastRefundRefNo='" + lastRefundRefNo + '\'' +
                ", queryStatus='" + queryStatus + '\'' +
                ", checksum='" + checksum + '\'' +
                '}';
    }

	

	public String getDbApplicantionId() {
		return dbApplicantionId;
	}

	public void setDbApplicantionId(String dbApplicantionId) {
		this.dbApplicantionId = dbApplicantionId;
	}

	public String getDbOrderNo() {
		return dbOrderNo;
	}

	public void setDbOrderNo(String dbOrderNo) {
		this.dbOrderNo = dbOrderNo;
	}

	public BigDecimal getDbAmount() {
		return dbAmount;
	}

	public void setDbAmount(BigDecimal dbAmount) {
		this.dbAmount = dbAmount;
	}

	public String getDbTxnReferenceNo() {
		return dbTxnReferenceNo;
	}

	public void setDbTxnReferenceNo(String dbTxnReferenceNo) {
		this.dbTxnReferenceNo = dbTxnReferenceNo;
	}

	public int getDbStatus() {
		return dbStatus;
	}

	public void setDbStatus(int dbStatus) {
		this.dbStatus = dbStatus;
	}

	public String getDbauthStatus() {
		return dbauthStatus;
	}

	public void setDbauthStatus(String dbauthStatus) {
		this.dbauthStatus = dbauthStatus;
	}

	public String getDbResponseMessage() {
		return dbResponseMessage;
	}

	public void setDbResponseMessage(String dbResponseMessage) {
		this.dbResponseMessage = dbResponseMessage;
	}
    
    
}
