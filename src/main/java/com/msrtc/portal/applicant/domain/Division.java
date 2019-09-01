package com.msrtc.portal.applicant.domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "divisions")
public class Division implements Serializable{

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 7209779924521273029L;

	@Id
	@Column(name = "division_id", nullable = false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Long divisionId;
	
	@Column(name="division_title")
	private String divisionTitle;
	
	@Column(name="message_key")
	private String messageKey;
	
	@Column(name="division_order")
	private Integer divisionOrder;
	
	@Column(name="is_drought_affected")
    private Boolean isDroughtAffected;
	
	 public Long getDivisionId() {
		return divisionId;
	}

	public void setDivisionId(Long divisionId) {
		this.divisionId = divisionId;
	}

	public String getDivisionTitle() {
		return divisionTitle;
	}

	public void setDivisionTitle(String divisionTitle) {
		this.divisionTitle = divisionTitle;
	}

	public String getMessageKey() {
		return messageKey;
	}

	public void setMessageKey(String messageKey) {
		this.messageKey = messageKey;
	}
	
	public Integer getDivisionOrder() {
		return divisionOrder;
	}

	public void setDivisionOrder(Integer divisionOrder) {
		this.divisionOrder = divisionOrder;
	}
	

	public Boolean getIsDroughtAffected() {
		return isDroughtAffected;
	}

	public void setIsDroughtAffected(Boolean isDroughtAffected) {
		this.isDroughtAffected = isDroughtAffected;
	}

	@Override
	    public String toString() {
	        return "DivisionDetails{" +
	                "divisionTitle='" + divisionTitle + '\'' +
	                ", messageKey='" + messageKey + '\'' +
	                ", divisionId=" + getDivisionId() +
	                '}';
	    }

}
