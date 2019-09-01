package com.msrtc.portal.applicant.dto;

public class ApplicantSearchDTO {

    private String searchText;

    private int searchType;

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
        return "ApplicantSearchDTO{" +
            "searchText='" + searchText + '\'' +
            ", searchType=" + searchType +
            '}';
    }
}
