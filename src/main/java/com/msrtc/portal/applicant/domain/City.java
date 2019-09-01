package com.msrtc.portal.applicant.domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "cities")
public class City implements Serializable{

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = -3022550544386434841L;

	@Id
	@Column(name = "id", nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;
	
	@Column(name="city_name")
	private String cityName;
	
	@Column(name="message_key")
	private String messageKey;
	
	@Column(name="city_order")
	private Integer cityOrder;
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getCityName() {
		return cityName;
	}

	public void setCityName(String cityName) {
		this.cityName = cityName;
	}

	public String getMessageKey() {
		return messageKey;
	}

	public void setMessageKey(String messageKey) {
		this.messageKey = messageKey;
	}

	public Integer getCityOrder() {
		return cityOrder;
	}

	public void setCityOrder(Integer cityOrder) {
		this.cityOrder = cityOrder;
	}
	
}
