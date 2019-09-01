package com.msrtc.portal.applicant.domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "applicant_otps")
public class ApplicantOTP implements Serializable {
	
	private static final long serialVersionUID = -7555701403065364434L;

	@Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;
	
	@Column(name = "applicant_id", nullable = false)
	private Long applicantId;
	
	@Column(name = "otp", nullable = false)
	private String otp;
	
	public ApplicantOTP() {
		
	}
	
	public Long getId() {
		return id;
	}

	@Override
	public String toString() {
		return "ApplicantOTP [id=" + id + ", applicantId=" + applicantId + ", otp=" + otp + "]";
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getApplicantId() {
		return applicantId;
	}

	public void setApplicantId(Long applicantId) {
		this.applicantId = applicantId;
	}

	public String getOtp() {
		return otp;
	}

	public void setOtp(String otp) {
		this.otp = otp;
	}

}
