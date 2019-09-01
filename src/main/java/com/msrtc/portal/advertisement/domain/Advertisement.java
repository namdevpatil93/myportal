package com.msrtc.portal.advertisement.domain;

import com.msrtc.portal.core.audit.domain.AbstractAuditingEntity;
import javax.persistence.*;
import java.io.Serializable;
import java.util.List;
import java.time.LocalDate;
import java.time.LocalDate;

@Entity
@Table(name = "advertisements")
public class Advertisement extends AbstractAuditingEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    @Column(name = "title")
    private String title;

    @Column(name = "description")
    private String description;

    @Column(name = "document_name")
    private String documentName;

    @Column(name = "start_date")
    private LocalDate startDate;

    @Column(name = "closing_date")
    private LocalDate closingDate;
    
    @Column(name = "advertisement_no")
    private String advertisementNo;
    
    @Column(name = "is_active")
    private Boolean active;
    
    @Column(name = "title_marathi")
    private String titleMarathi;

    @Column(name = "description_marathi")
    private String descriptionMarathi;

    @Column(name = "document_name_marathi")
    private String documentNameMarathi;
    
    @Column(name = "advertisement_no_marathi")
    private String advertisementNoMarathi;

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
    public String getDocumentName() {
        return this.documentName;
    }

    public void setDocumentName(String documentName) {
        this.documentName = documentName;
    }
    public LocalDate getStartDate() {
        return this.startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }
    public LocalDate getClosingDate() {
        return this.closingDate;
    }

    public void setClosingDate(LocalDate closingDate) {
        this.closingDate = closingDate;
    }
    
    public String getAdvertisementNo() {
		return advertisementNo;
	}

	public void setAdvertisementNo(String advertisementNo) {
		this.advertisementNo = advertisementNo;
	}
	
    public Boolean getActive() {
		return active;
	}

	public void setActive(Boolean active) {
		this.active = active;
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

	public String getAdvertisementNoMarathi() {
		return advertisementNoMarathi;
	}

	public void setAdvertisementNoMarathi(String advertisementNoMarathi) {
		this.advertisementNoMarathi = advertisementNoMarathi;
	}

	@Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("Advertisement{");
        sb.append("id='").append(getId()).append('\'');
        sb.append(", title='").append(title).append('\'');
        sb.append(", description='").append(description).append('\'');
        sb.append(", documentName='").append(documentName).append('\'');
        sb.append(", startDate='").append(startDate).append('\'');
        sb.append(", closingDate='").append(closingDate).append('\'');
        sb.append('}');
        return sb.toString();
    }

}

