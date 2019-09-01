package com.msrtc.portal.challan.domain;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name="view_applicant_post_payment_mismatch")
public class ApplicantPostPaymentMismatch implements Serializable{
	
	private static final long serialVersionUID = 1L;

	@Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy=GenerationType.AUTO)
	private Long id;
	
	@Column(name="application_id")
	private String applicationId;
	
	@Column(name="non_creamy_layer")
	private Boolean nonCreamyLayer;
	
	@Column(name="gender")
	private Integer gender;
	
	@Column(name="caste_title")
	private String casteTitle;
	
	@Column(name="applicant_id")
    private Long applicantId;
	
	@Column(name = "order_no")
    private String orderNo;
	
	@Column(name = "amount")
    private BigDecimal amount;
	
	@Column(name="post_fees")
	private Integer postFees;
	
	@Column(name="payment_made_for_post_count")
	private Integer paymentMadeForPostCount;
	
	@Column(name="actual_payment_successful_for_post_count")
	private Integer actualPaymentSuccessfulForPostCount;
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="transaction_date")
	private Date transactionDate;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getApplicationId() {
		return applicationId;
	}

	public void setApplicationId(String applicationId) {
		this.applicationId = applicationId;
	}

	public Boolean getNonCreamyLayer() {
		return nonCreamyLayer;
	}

	public void setNonCreamyLayer(Boolean nonCreamyLayer) {
		this.nonCreamyLayer = nonCreamyLayer;
	}

	public Integer getGender() {
		return gender;
	}

	public void setGender(Integer gender) {
		this.gender = gender;
	}

	public String getCasteTitle() {
		return casteTitle;
	}

	public void setCasteTitle(String casteTitle) {
		this.casteTitle = casteTitle;
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

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public Integer getPostFees() {
		return postFees;
	}

	public void setPostFees(Integer postFees) {
		this.postFees = postFees;
	}

	public Integer getPaymentMadeForPostCount() {
		return paymentMadeForPostCount;
	}

	public void setPaymentMadeForPostCount(Integer paymentMadeForPostCount) {
		this.paymentMadeForPostCount = paymentMadeForPostCount;
	}

	public Integer getActualPaymentSuccessfulForPostCount() {
		return actualPaymentSuccessfulForPostCount;
	}

	public void setActualPaymentSuccessfulForPostCount(
			Integer actualPaymentSuccessfulForPostCount) {
		this.actualPaymentSuccessfulForPostCount = actualPaymentSuccessfulForPostCount;
	}

	public Date getTransactionDate() {
		return transactionDate;
	}

	public void setTransactionDate(Date transactionDate) {
		this.transactionDate = transactionDate;
	}
	
}
