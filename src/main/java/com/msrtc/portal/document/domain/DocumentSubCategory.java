package com.msrtc.portal.document.domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.msrtc.portal.core.audit.domain.AbstractAuditingEntity;

@Entity
@Table(name = "document_subcategory")
public class DocumentSubCategory extends AbstractAuditingEntity implements Serializable {

	private static final long serialVersionUID = 1L;

	@Column(name="document_type")
	private Integer documentType;
	
	@Column(name="category_type")
	private Integer categoryType;
	
	@Column(name="subcategory_title")
	private String subCategoryTitle;
	
	@Column(name="subcategory_title_marathi")
	private String subCategoryTitleMarathi;
	
	@Column(name="active")
	private boolean active;
	
	@Transient
	private String documentTypeLable;
	
	@Transient
	private String categoryTypeLable;
	

	public Integer getDocumentType() {
		return documentType;
	}

	public void setDocumentType(Integer documentType) {
		this.documentType = documentType;
	}

	public Integer getCategoryType() {
		return categoryType;
	}

	public void setCategoryType(Integer categoryType) {
		this.categoryType = categoryType;
	}

	public String getSubCategoryTitle() {
		return subCategoryTitle;
	}

	public void setSubCategoryTitle(String subCategoryTitle) {
		this.subCategoryTitle = subCategoryTitle;
	}

	public String getSubCategoryTitleMarathi() {
		return subCategoryTitleMarathi;
	}

	public void setSubCategoryTitleMarathi(String subCategoryTitleMarathi) {
		this.subCategoryTitleMarathi = subCategoryTitleMarathi;
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

	public String getCategoryTypeLable() {
		return categoryTypeLable;
	}

	public void setCategoryTypeLable(String categoryTypeLable) {
		this.categoryTypeLable = categoryTypeLable;
	}
	
	
	

}
