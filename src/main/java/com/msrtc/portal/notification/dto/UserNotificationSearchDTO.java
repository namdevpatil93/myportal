package com.msrtc.portal.notification.dto;

public class UserNotificationSearchDTO {
	
	private String searchText;

    private int searchType;
    
    private long applicantId;

    public long getApplicantId() {
		return applicantId;
	}

	public void setApplicantId(long applicantId) {
		this.applicantId = applicantId;
	}

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

	@Override
	public String toString() {
		return "UserNotificationSearchDTO [searchText=" + searchText
				+ ", searchType=" + searchType + "]";
	}
    
    
}
