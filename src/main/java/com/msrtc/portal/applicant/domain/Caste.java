package com.msrtc.portal.applicant.domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "castes")
public class Caste implements Serializable{

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 6873259943878833873L;

	@Id
	@Column(name = "id", nullable = false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Long id;
	
	@Column(name="caste_title")
	private String casteTitle;
	
	@Column(name="message_key")
	private String messageKey;

	@Column(name="post_fees", nullable=false)
	private Integer postFees;
	
	@Column(name="caste_order")
	private Integer casteOrder;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getCasteTitle() {
		return casteTitle;
	}

	public void setCasteTitle(String casteTitle) {
		this.casteTitle = casteTitle;
	}

	public String getMessageKey() {
		return messageKey;
	}

	public void setMessageKey(String messageKey) {
		this.messageKey = messageKey;
	}

	public Integer getPostFees() {
		return postFees;
	}

	public void setPostFees(Integer postFees) {
		this.postFees = postFees;
	}
	
	public Integer getCasteOrder() {
		return casteOrder;
	}

	public void setCasteOrder(Integer casteOrder) {
		this.casteOrder = casteOrder;
	}

	@Override
	    public String toString() {
	        return "CasteDetails{" +
	                "casteTitle='" + casteTitle + '\'' +
	                ", messageKey='" + messageKey + '\'' +
	                ", casteId=" + getId() +
	                '}';
	    }

}
