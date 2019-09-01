package com.msrtc.portal.applicant.domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "districts")
public class District implements Serializable {

	private static final long serialVersionUID = 2205481367412387348L;
	
	@Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(name = "name")
    private String name;

    @Column(name = "message_key")
    private String messageKey;
    
    @Column(name="district_order")
    private Integer districtOrder;
    
    

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getMessageKey() {
		return messageKey;
	}

	public void setMessageKey(String messageKey) {
		this.messageKey = messageKey;
	}

	public Integer getDistrictOrder() {
		return districtOrder;
	}

	public void setDistrictOrder(Integer districtOrder) {
		this.districtOrder = districtOrder;
	}

	

	
    
}
