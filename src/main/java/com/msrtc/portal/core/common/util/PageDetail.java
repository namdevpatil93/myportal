package com.msrtc.portal.core.common.util;

import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

public class PageDetail {

    private int pageNumber = 1;

    private int size = 10;

    private String sortBy = "id";

    private String sortOrder = "ASC";

    private boolean newPage = false;

    public int getPageNumber() {
        return pageNumber;
    }

    public void setPageNumber(int pageNumber) {
        this.pageNumber = pageNumber;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    public String getSortBy() {
        return sortBy;
    }

    public void setSortBy(String sortBy) {
        this.sortBy = sortBy;
    }

    public String getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(String sortOrder) {
        this.sortOrder = sortOrder;
    }

    public boolean isNewPage() {
        return newPage;
    }

    public void setNewPage(boolean newPage) {
        this.newPage = newPage;
    }

    public Pageable getPageable() {
        if("ASC".equalsIgnoreCase(this.getSortOrder())){
            return new PageRequest(this.getPageNumber() - 1, this.getSize(), new Sort(Sort.Direction.ASC, this.getSortBy()));
        } else {
            return new PageRequest(this.getPageNumber() - 1, this.getSize(), new Sort(Sort.Direction.DESC, this.getSortBy()));
        }
    }

    @Override
    public String toString() {
        return "PageDetail{" +
                "pageNumber=" + pageNumber +
                ", size=" + size +
                ", sortBy='" + sortBy + '\'' +
                ", sortOrder='" + sortOrder + '\'' +
                ", newPage=" + newPage +
                '}';
    }
    
	public int getBeginIndex(int pageNumber) {
		return Math.max(1, pageNumber + 1 - 5);
	}
	
	public long getEndIndex(int totalPages, int beginIndex) {
		return Math.min(beginIndex + 10, Long.valueOf(totalPages));
	}
}
