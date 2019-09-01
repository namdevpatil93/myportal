package com.msrtc.portal.document.domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.msrtc.portal.core.audit.domain.AbstractAuditingEntity;

@Entity
@Table(name = "documents")
public class Document extends AbstractAuditingEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    @Column(name = "title")
    private String title;

    @Column(name = "description")
    private String description;

    @Column(name = "document_type")
    private Integer documentType;

    @Column(name = "active")
    private boolean active;
    
    @Column(name = "document_name")
    private String documentName;
    
    @Column(name = "title_mr")
    private String titleMarathi;

    @Column(name = "description_mr")
    private String descriptionMarathi;
    
    @Column(name = "document_name_mr")
    private String documentNameMarathi;
    
    @Column(name="category_type")
    private Integer categoryType;
    
    @Column(name="sub_category_type")
    private Integer subCategoryType;
 
    @Transient
    private String lableCategoryTitle="";
    
    @Transient
    private String lableCategoryTitleMarathi="";
    
    @Transient
    private String lableSubCategoryTitle="";
    
    @Transient
    private String lableSubCategoryTitleMarathi="";
    
    public String getTitle() {
        return this.title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
    public String getDescription() {
        return this.description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    public Integer getDocumentType() {
        return this.documentType;
    }

    public void setDocumentType(Integer documentType) {
        this.documentType = documentType;
    }
    public boolean isActive() {
        return this.active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }
    
    public String getDocumentName() {
		return documentName;
	}

	public void setDocumentName(String documentName) {
		this.documentName = documentName;
	}
	
	public String getTitleMarathi() {
		return titleMarathi;
	}

	public void setTitleMarathi(String titleMarathi) {
		this.titleMarathi = titleMarathi;
	}

	public String getDescriptionMarathi() {
		return descriptionMarathi;
	}

	public void setDescriptionMarathi(String descriptionMarathi) {
		this.descriptionMarathi = descriptionMarathi;
	}

	public String getDocumentNameMarathi() {
		return documentNameMarathi;
	}

	public void setDocumentNameMarathi(String documentNameMarathi) {
		this.documentNameMarathi = documentNameMarathi;
	}
	
	

	public Integer getCategoryType() {
		return categoryType;
	}

	public void setCategoryType(Integer categoryType) {
		this.categoryType = categoryType;
	}

	public Integer getSubCategoryType() {
		return subCategoryType;
	}

	public void setSubCategoryType(Integer subCategoryType) {
		this.subCategoryType = subCategoryType;
	}
	

	public String getLableCategoryTitle() {
		return lableCategoryTitle;
	}

	public void setLableCategoryTitle(String lableCategoryTitle) {
		this.lableCategoryTitle = lableCategoryTitle;
	}

	public String getLableCategoryTitleMarathi() {
		return lableCategoryTitleMarathi;
	}

	public void setLableCategoryTitleMarathi(String lableCategoryTitleMarathi) {
		this.lableCategoryTitleMarathi = lableCategoryTitleMarathi;
	}

	public String getLableSubCategoryTitle() {
		return lableSubCategoryTitle;
	}

	public void setLableSubCategoryTitle(String lableSubCategoryTitle) {
		this.lableSubCategoryTitle = lableSubCategoryTitle;
	}

	public String getLableSubCategoryTitleMarathi() {
		return lableSubCategoryTitleMarathi;
	}

	public void setLableSubCategoryTitleMarathi(String lableSubCategoryTitleMarathi) {
		this.lableSubCategoryTitleMarathi = lableSubCategoryTitleMarathi;
	}
	

	@Override
	public String toString() {
		return "Document [title=" + title + ", description=" + description + ", documentType=" + documentType
				+ ", active=" + active + ", documentName=" + documentName + "]";
	}

}

