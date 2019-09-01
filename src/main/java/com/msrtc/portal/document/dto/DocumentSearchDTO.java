package com.msrtc.portal.document.dto;

public class DocumentSearchDTO {

    private String searchText;

    private int searchType;

    private int documentType;

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

    public int getDocumentType() {
        return documentType;
    }

    public void setDocumentType(int documentType) {
        this.documentType = documentType;
    }

    @Override
    public String toString() {
        return "DocumentSearchDTO{" +
            "searchText='" + searchText + '\'' +
            ", searchType=" + searchType +
            '}';
    }
}

