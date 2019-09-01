package com.msrtc.portal.reports.dto;

public class PostReportDataDTO {

	private Integer postId;
	private String postTitle;
	private String totalApplicationCount;
	private String totalOnlinePaidMaleApplicationCount;
	private String totalOnlinePaidFemaleApplicationCount;
	private String totalOnlinePaidApplicationCount;
	private String totalOfflinePaidMaleApplivationCount;
	private String totalOfflinePaidFemaleApplivationCount;
	private String totalOfflinePaidApplicationCount;
	private String totalOpenCategoryPaidMaleApplicationCount;
	private String totalOpenCategoryPaidFemaleApplicationCount;
	private String totalReservedCategoryPaidMaleApplicationCount;
	private String totalReservedCategoryPaidFemaleApplicationCount;
	private String totalPaidMaleApplicationCount;
	private String totalPaidFealeApplicationCount;
	private String totalPaidApplicantCount;
	
	public PostReportDataDTO(Integer postId, String postTitle) {
		super();
		this.postId = postId;
		this.postTitle = postTitle;
	}
	
	
	public PostReportDataDTO() {
		super();
		// TODO Auto-generated constructor stub
	}


	public Integer getPostId() {
		return postId;
	}
	public void setPostId(Integer postId) {
		this.postId = postId;
	}
	public String getPostTitle() {
		return postTitle;
	}
	public void setPostTitle(String postTitle) {
		this.postTitle = postTitle;
	}
	public String getTotalApplicationCount() {
		return totalApplicationCount;
	}
	public void setTotalApplicationCount(String totalApplicationCount) {
		this.totalApplicationCount = totalApplicationCount;
	}
	public String getTotalOnlinePaidMaleApplicationCount() {
		return totalOnlinePaidMaleApplicationCount;
	}
	public void setTotalOnlinePaidMaleApplicationCount(
			String totalOnlinePaidMaleApplicationCount) {
		this.totalOnlinePaidMaleApplicationCount = totalOnlinePaidMaleApplicationCount;
	}
	public String getTotalOnlinePaidFemaleApplicationCount() {
		return totalOnlinePaidFemaleApplicationCount;
	}
	public void setTotalOnlinePaidFemaleApplicationCount(
			String totalOnlinePaidFemaleApplicationCount) {
		this.totalOnlinePaidFemaleApplicationCount = totalOnlinePaidFemaleApplicationCount;
	}
	public String getTotalOnlinePaidApplicationCount() {
		return totalOnlinePaidApplicationCount;
	}
	public void setTotalOnlinePaidApplicationCount(
			String totalOnlinePaidApplicationCount) {
		this.totalOnlinePaidApplicationCount = totalOnlinePaidApplicationCount;
	}
	public String getTotalOfflinePaidMaleApplivationCount() {
		return totalOfflinePaidMaleApplivationCount;
	}
	public void setTotalOfflinePaidMaleApplivationCount(
			String totalOfflinePaidMaleApplivationCount) {
		this.totalOfflinePaidMaleApplivationCount = totalOfflinePaidMaleApplivationCount;
	}
	public String getTotalOfflinePaidFemaleApplivationCount() {
		return totalOfflinePaidFemaleApplivationCount;
	}
	public void setTotalOfflinePaidFemaleApplivationCount(
			String totalOfflinePaidFemaleApplivationCount) {
		this.totalOfflinePaidFemaleApplivationCount = totalOfflinePaidFemaleApplivationCount;
	}
	public String getTotalOfflinePaidApplicationCount() {
		return totalOfflinePaidApplicationCount;
	}
	public void setTotalOfflinePaidApplicationCount(
			String totalOfflinePaidApplicationCount) {
		this.totalOfflinePaidApplicationCount = totalOfflinePaidApplicationCount;
	}
	public String getTotalOpenCategoryPaidMaleApplicationCount() {
		return totalOpenCategoryPaidMaleApplicationCount;
	}
	public void setTotalOpenCategoryPaidMaleApplicationCount(
			String totalOpenCategoryPaidMaleApplicationCount) {
		this.totalOpenCategoryPaidMaleApplicationCount = totalOpenCategoryPaidMaleApplicationCount;
	}
	public String getTotalOpenCategoryPaidFemaleApplicationCount() {
		return totalOpenCategoryPaidFemaleApplicationCount;
	}
	public void setTotalOpenCategoryPaidFemaleApplicationCount(
			String totalOpenCategoryPaidFemaleApplicationCount) {
		this.totalOpenCategoryPaidFemaleApplicationCount = totalOpenCategoryPaidFemaleApplicationCount;
	}
	public String getTotalReservedCategoryPaidMaleApplicationCount() {
		return totalReservedCategoryPaidMaleApplicationCount;
	}
	public void setTotalReservedCategoryPaidMaleApplicationCount(
			String totalReservedCategoryPaidMaleApplicationCount) {
		this.totalReservedCategoryPaidMaleApplicationCount = totalReservedCategoryPaidMaleApplicationCount;
	}
	public String getTotalReservedCategoryPaidFemaleApplicationCount() {
		return totalReservedCategoryPaidFemaleApplicationCount;
	}
	public void setTotalReservedCategoryPaidFemaleApplicationCount(
			String totalReservedCategoryPaidFemaleApplicationCount) {
		this.totalReservedCategoryPaidFemaleApplicationCount = totalReservedCategoryPaidFemaleApplicationCount;
	}
	public String getTotalPaidMaleApplicationCount() {
		return totalPaidMaleApplicationCount;
	}
	public void setTotalPaidMaleApplicationCount(
			String totalPaidMaleApplicationCount) {
		this.totalPaidMaleApplicationCount = totalPaidMaleApplicationCount;
	}
	public String getTotalPaidFealeApplicationCount() {
		return totalPaidFealeApplicationCount;
	}
	public void setTotalPaidFealeApplicationCount(
			String totalPaidFealeApplicationCount) {
		this.totalPaidFealeApplicationCount = totalPaidFealeApplicationCount;
	}
	public String getTotalPaidApplicantCount() {
		return totalPaidApplicantCount;
	}
	public void setTotalPaidApplicantCount(String totalPaidApplicantCount) {
		this.totalPaidApplicantCount = totalPaidApplicantCount;
	}

	@Override
	public String toString() {
		final StringBuilder sb = new StringBuilder("PostReportDataDTO{");
		sb.append("postId='").append(postId).append('\'');
		sb.append('}');
		return sb.toString();
	}
}
