package com.msrtc.portal.document.domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.msrtc.portal.core.audit.domain.AbstractAuditingEntity;

@Entity
@Table(name = "document_category")
public class DocumentCategory extends AbstractAuditingEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	 @Column(name = "category_title", unique=true)
	private String categoryTitle;
	 
	 @Column(name = "category_title_marathi",unique=true)
	private String categoryTitleMarathi;
	 
	 @Column(name = "document_type")
	private Integer documentType;
	 
	 @Column(name = "active")
	private boolean active;
	 
	 @Transient
	 private String documentTypeLable;

	public String getCategoryTitle() {
		return categoryTitle;
	}

	public void setCategoryTitle(String categoryTitle) {
		this.categoryTitle = categoryTitle;
	}

	public String getCategoryTitleMarathi() {
		return categoryTitleMarathi;
	}

	public void setCategoryTitleMarathi(String categoryTitleMarathi) {
		this.categoryTitleMarathi = categoryTitleMarathi;
	}

	public Integer getDocumentType() {
		return documentType;
	}

	public void setDocumentType(Integer documentType) {
		this.documentType = documentType;
	}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	public String getDocumentTypeLable() {
		return documentTypeLable;
	}

	public void setDocumentTypeLable(String documentTypeLable) {
		this.documentTypeLable = documentTypeLable;
	}
	 
	
	 
	
}
