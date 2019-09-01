package com.msrtc.portal.notification.dto;

public class NotificationSearchDTO {

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
        return "NotificationSearchDTO{" +
            "searchText='" + searchText + '\'' +
            ", searchType=" + searchType +
            '}';
    }
}

