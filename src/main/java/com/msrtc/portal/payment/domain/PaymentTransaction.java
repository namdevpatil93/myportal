package com.msrtc.portal.payment.domain;

import com.msrtc.portal.applicant.domain.ApplicantPostAssoc;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "payment_transactions")
public class PaymentTransaction implements Serializable {

    private static final long serialVersionUID = -2939836157372228852L;

    @Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(name = "applicant_id")
    private Long applicantId;

    @Column(name = "order_no")
    private String orderNo;

    @Column(name = "amount")
    private BigDecimal amount;

    @Column(name = "txn_reference_no")
    private String txnReferenceNo;

    @Column(name = "status")
    private int status;

    @Column(name = "auth_status")
    private String authStatus;

    @Column(name = "response_message")
    private String responseMessage;

    @Column(name = "payment_mode")
    private int paymentMode;

    @CreatedDate
    @Column(name = "created_date", nullable = false)
    private LocalDateTime createdDate = LocalDateTime.now();

    @LastModifiedDate
    @Column(name = "last_modified_date", nullable = false)
    private LocalDateTime lastModifiedDate = LocalDateTime.now();

    @Transient
    private List<ApplicantPostAssoc> applicantPostAssocList;

    public PaymentTransaction(){}

    public PaymentTransaction(Long applicantId, String orderNo, BigDecimal amount, int status, int paymentMode) {
        this.applicantId = applicantId;
        this.orderNo = orderNo;
        this.amount = amount;
        this.status = status;
        this.paymentMode = paymentMode;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getApplicantId() {
        return applicantId;
    }

    public void setApplicantId(Long applicantId) {
        this.applicantId = applicantId;
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

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getAuthStatus() {
        return authStatus;
    }

    public void setAuthStatus(String authStatus) {
        this.authStatus = authStatus;
    }

    public String getResponseMessage() {
        return responseMessage;
    }

    public void setResponseMessage(String responseMessage) {
        this.responseMessage = responseMessage;
    }

    public LocalDateTime getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(LocalDateTime createdDate) {
        this.createdDate = createdDate;
    }

    public LocalDateTime getLastModifiedDate() {
        return lastModifiedDate;
    }

    public void setLastModifiedDate(LocalDateTime lastModifiedDate) {
        this.lastModifiedDate = lastModifiedDate;
    }

    public int getPaymentMode() {
        return paymentMode;
    }

    public void setPaymentMode(int paymentMode) {
        this.paymentMode = paymentMode;
    }

    public List<ApplicantPostAssoc> getApplicantPostAssocList() {
        return applicantPostAssocList;
    }

    public void setApplicantPostAssocList(List<ApplicantPostAssoc> applicantPostAssocList) {
        this.applicantPostAssocList = applicantPostAssocList;
    }
}
