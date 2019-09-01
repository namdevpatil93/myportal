package com.msrtc.portal.applicant.domain;

import java.io.Serializable;
import java.time.LocalDate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "change_password_requests")
public class ChangePasswordRequest implements Serializable {

	@Id
	@Column(name = "id", nullable = false)
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	@Column(name = "email_address")
	private String emailAddress;

	@Column(name = "user_type")
	private Integer userType;

	@Column(name = "token")
	private String token;

	@Column(name = "created_date")
	private LocalDate createdDate;
	
	@Column(name = "expired")
	private boolean expired;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getEmailAddress() {
		return emailAddress;
	}

	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}

	public Integer getUserType() {
		return userType;
	}

	public void setUserType(Integer userType) {
		this.userType = userType;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public LocalDate getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(LocalDate createdDate) {
		this.createdDate = createdDate;
	}

	public boolean getExpired() {
		return expired;
	}

	public void setExpired(boolean expired) {
		this.expired = expired;
	}

	@Override
	public String toString() {
		return "ChangePasswordRequest [id=" + id + ", emailAddress="
				+ emailAddress + ", userType=" + userType + ", token=" + token
				+ ", createdDate=" + createdDate + ", expired=" + expired + "]";
	}

	

}
