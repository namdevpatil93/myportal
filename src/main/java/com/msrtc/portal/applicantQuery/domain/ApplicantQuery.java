package com.msrtc.portal.applicantQuery.domain;

import com.msrtc.portal.applicant.domain.Applicant;
import com.msrtc.portal.core.audit.domain.AbstractAuditingEntity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;

import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "queries")
public class ApplicantQuery implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Long id;

    @CreatedBy
    @Column(name = "created_by", nullable = false)
    private Long createdBy;

    @CreatedDate
    @Column(name = "created_date", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdDate = new Date();

    @LastModifiedBy
    @Column(name = "last_modified_by", nullable = false)
    private Long lastModifiedBy;

    @LastModifiedDate
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "last_modified_date", nullable = false)
    private Date lastModifiedDate = new Date();

    @Transient
    Applicant applicant;
    
    @Column(name = "type")
    private Integer type;

    @Column(name = "type_other")
    private String typeOther;

    @Column(name = "title")
    private String title;

    @Column(name = "description")
    private String description;

    @Column(name = "applicant_id")
    private Long applicantId;
    
    @Column(name = "add_attachment")
    private String addAttachment;

    public Integer getType() {
        return this.type;
    }

    public void setType(Integer type) {
        this.type = type;
    }
    public String getTypeOther() {
        return this.typeOther;
    }

    public void setTypeOther(String typeOther) {
        this.typeOther = typeOther;
    }
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
    public Long getApplicantId() {
        return this.applicantId;
    }

    public void setApplicantId(Long applicantId) {
        this.applicantId = applicantId;
    }

    public Applicant getApplicant() {
		return applicant;
	}

	public void setApplicant(Applicant applicant) {
		this.applicant = applicant;
	}

	 public Long getId() {
	        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(Long createdBy) {
        this.createdBy = createdBy;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Long getLastModifiedBy() {
        return lastModifiedBy;
    }

    public void setLastModifiedBy(Long lastModifiedBy) {
        this.lastModifiedBy = lastModifiedBy;
    }

    public Date getLastModifiedDate() {
        return lastModifiedDate;
    }

    public void setLastModifiedDate(Date lastModifiedDate) {
        this.lastModifiedDate = lastModifiedDate;
    }
    
    
	public String getAddAttachment() {
		return addAttachment;
	}

	public void setAddAttachment(String addAttachment) {
		this.addAttachment = addAttachment;
	}

	@Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("ApplicantQuery{");
        sb.append("id='").append(getId()).append('\'');
        sb.append(", type='").append(type).append('\'');
        sb.append(", typeOther='").append(typeOther).append('\'');
        sb.append(", title='").append(title).append('\'');
        sb.append(", description='").append(description).append('\'');
        sb.append(", applicantId='").append(applicantId).append('\'');
        sb.append(", createdby='").append(getCreatedBy()).append('\'');
        sb.append(", createddate='").append(getCreatedDate()).append('\'');
        sb.append(", modifieddate='").append(getLastModifiedDate()).append('\'');
        sb.append(", modifiedBy='").append(getLastModifiedBy()).append('\'');
        
        sb.append('}');
        return sb.toString();
    }

}

