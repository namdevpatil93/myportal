package com.msrtc.portal.applicant.dto;

public class ApplicantPostAssocSearchDTO {

	private String searchText;

    private int searchType;
    
    private String name;
    
    private String applicantId;
    
    private Long caste;
    
    //private Boolean differentlyAbled;
    
    private Integer gender;
    
    private Integer paidUnpaid;
    
    private Integer onlineOffline;
    
    private Long post;
    
    private Long district;
    
    private Boolean projectAffected;
    
    private Boolean earthQuickAffected;
    
    private Boolean exServiceMan;
    
    private Boolean partTimeEmployee;
    
    private Boolean sportsPerson;
    
    private Boolean sTEmployee;
    
    private String differentlyAbledSelect;
    
    private String mobileNumber;
    
    private String emailId;

    public String getSearchText() {
        return searchText;
    }

    public void setSearchText(String searchText) {
        this.searchText = searchText;
    }

    public int getSearchType() {
        return searchType;
    }

    public void setSearchType(int searchType) {
        this.searchType = searchType;
    }

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getApplicantId() {
		return applicantId;
	}

	public void setApplicantId(String applicantId) {
		this.applicantId = applicantId;
	}

	public Long getCaste() {
		return caste;
	}

	public void setCaste(Long caste) {
		this.caste = caste;
	}

//	public Boolean getDifferentlyAbled() {
//		return differentlyAbled;
//	}
//
//	public void setDifferentlyAbled(Boolean differentlyAbled) {
//		this.differentlyAbled = differentlyAbled;
//	}

	public Integer getGender() {
		return gender;
	}

	public void setGender(Integer gender) {
		this.gender = gender;
	}

	public Integer getPaidUnpaid() {
		return paidUnpaid;
	}

	public void setPaidUnpaid(Integer paidUnpaid) {
		this.paidUnpaid = paidUnpaid;
	}

	public Integer getOnlineOffline() {
		return onlineOffline;
	}

	public void setOnlineOffline(Integer onlineOffline) {
		this.onlineOffline = onlineOffline;
	}

	public Long getPost() {
		return post;
	}

	public void setPost(Long post) {
		this.post = post;
	}

	public Long getDistrict() {
		return district;
	}

	public void setDistrict(Long district) {
		this.district = district;
	}

	public Boolean getProjectAffected() {
		return projectAffected;
	}

	public void setProjectAffected(Boolean projectAffected) {
		this.projectAffected = projectAffected;
	}

	public Boolean getEarthQuickAffected() {
		return earthQuickAffected;
	}

	public void setEarthQuickAffected(Boolean earthQuickAffected) {
		this.earthQuickAffected = earthQuickAffected;
	}

	public Boolean getExServiceMan() {
		return exServiceMan;
	}

	public void setExServiceMan(Boolean exServiceMan) {
		this.exServiceMan = exServiceMan;
	}

	public Boolean getPartTimeEmployee() {
		return partTimeEmployee;
	}

	public void setPartTimeEmployee(Boolean partTimeEmployee) {
		this.partTimeEmployee = partTimeEmployee;
	}

	public Boolean getSportsPerson() {
		return sportsPerson;
	}

	public void setSportsPerson(Boolean sportsPerson) {
		this.sportsPerson = sportsPerson;
	}

	public Boolean getsTEmployee() {
		return sTEmployee;
	}

	public void setsTEmployee(Boolean sTEmployee) {
		this.sTEmployee = sTEmployee;
	}
	
	public String getDifferentlyAbledSelect() {
		return differentlyAbledSelect;
	}

	public void setDifferentlyAbledSelect(String differentlyAbledSelect) {
		this.differentlyAbledSelect = differentlyAbledSelect;
	}
	
	public String getMobileNumber() {
		return mobileNumber;
	}

	public void setMobileNumber(String mobileNumber) {
		this.mobileNumber = mobileNumber;
	}

	public String getEmailId() {
		return emailId;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}

	@Override
	public String toString() {
		return "ApplicantPostAssocSearchDTO [searchText=" + searchText + ", searchType=" + searchType + ", name=" + name
				+ ", applicantId=" + applicantId + ", caste=" + caste + ", gender=" + gender + ", paidUnpaid="
				+ paidUnpaid + ", onlineOffline=" + onlineOffline + ", post=" + post + ", district=" + district
				+ ", projectAffected=" + projectAffected + ", earthQuickAffected=" + earthQuickAffected
				+ ", exServiceMan=" + exServiceMan + ", partTimeEmployee=" + partTimeEmployee + ", sportsPerson="
				+ sportsPerson + ", sTEmployee=" + sTEmployee + ", differentlyAbledSelect=" + differentlyAbledSelect
				+ ", mobileNumber=" + mobileNumber+ ", emailId=" + emailId
				+ "]";
	}
	
}
