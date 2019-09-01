package com.msrtc.portal.applicantQuery.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.data.annotation.CreatedDate;

@Entity
@Table(name="replies")
public class ApplicantQueryReply implements Serializable {

	private static final long serialVersionUID = 5927821011139778992L;

	@Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Long id;
	
	@Column(name = "query_id", nullable = false)
	private Long queryId;

	@Column(name = "parent_reply_id")
	private Long parentReplyId;
	
	@Column(name = "reply")
	private String reply;
	
	@Column(name = "user_id")
	private Long userId;
	
	@Column(name = "user_type")
	private Integer userType;
	
	@CreatedDate
    @Column(name = "created_date", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdDate = new Date();

	@Column(name = "status")
	private boolean status = false;
	
	@Column(name = "add_attachment")
	private String addAttachment;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getQueryId() {
		return queryId;
	}

	public void setQueryId(Long queryId) {
		this.queryId = queryId;
	}

	public Long getParentReplyId() {
		return parentReplyId;
	}

	public void setParentReplyId(Long parentReplyId) {
		this.parentReplyId = parentReplyId;
	}

	public String getReply() {
		return reply;
	}

	public void setReply(String reply) {
		this.reply = reply;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Integer getUserType() {
		return userType;
	}

	public void setUserType(Integer userType) {
		this.userType = userType;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public boolean isStatus() {
		return status;
	}

	public void setStatus(boolean status) {
		this.status = status;
	}

	public String getAddAttachment() {
		return addAttachment;
	}

	public void setAddAttachment(String addAttachment) {
		this.addAttachment = addAttachment;
	}

	@Override
	public String toString() {
		return "ApplicantQueryReply [id=" + id + ", queryId=" + queryId + ", parentReplyId=" + parentReplyId
				+ ", reply=" + reply + ", userId=" + userId + ", userType=" + userType + ", createdDate=" + createdDate
				+ ", status=" + status + ", addAttachment=" + addAttachment + "]";
	}
	
}
