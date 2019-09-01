package com.msrtc.portal.challan.dto;

public class ChallanDataDTO {
	
	private String feeType;
	private String challanNo;
	private String dob;
	private String msrtcAccountNumber;
	private String amount;
	private String branchCode;
	private String applicantName;
	private String appliedPostId;
	private String category;
	private String applicationId;
	private String lastDateOfPayMent;
	
	public String getFeeType() {
		return feeType;
	}
	
	public void setFeeType(String feeType) {
		this.feeType = feeType;
	}
	
	public String getChallanNo() {
		return challanNo;
	}
	
	public void setChallanNo(String challanNo) {
		this.challanNo = challanNo;
	}
	
	public String getDob() {
		return dob;
	}
	
	public void setDob(String dob) {
		this.dob = dob;
	}
	
	public String getMsrtcAccountNumber() {
		return msrtcAccountNumber;
	}
	
	public void setMsrtcAccountNumber(String msrtcAccountNumber) {
		this.msrtcAccountNumber = msrtcAccountNumber;
	}
	
	public String getAmount() {
		return amount;
	}
	
	public void setAmount(String amount) {
		this.amount = amount;
	}
	
	public String getBranchCode() {
		return branchCode;
	}
	
	public void setBranchCode(String branchCode) {
		this.branchCode = branchCode;
	}
	
	public String getApplicantName() {
		return applicantName;
	}
	
	public void setApplicantName(String applicantName) {
		this.applicantName = applicantName;
	}
	
	public String getAppliedPostId() {
		return appliedPostId;
	}
	
	public void setAppliedPostId(String appliedPostId) {
		this.appliedPostId = appliedPostId;
	}
	
	public String getCategory() {
		return category;
	}
	
	public void setCategory(String category) {
		this.category = category;
	}
	
	public String getApplicationId() {
		return applicationId;
	}
	
	public void setApplicationId(String applicationId) {
		this.applicationId = applicationId;
	}
	
	public String getLastDateOfPayMent() {
		return lastDateOfPayMent;
	}

	public void setLastDateOfPayMent(String lastDateOfPayMent) {
		this.lastDateOfPayMent = lastDateOfPayMent;
	}
	
}
