package com.msrtc.portal.applicant.domain;

import javax.persistence.*;

import java.io.Serializable;

@Entity
@Table(name = "trades")
public class Trade implements Serializable{

	private static final long serialVersionUID = -1427381684360057174L;

	@Id
	@Column(name = "id", nullable = false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Long id;
	
	@Column(name="title")
	private String title;
	
	@Column(name="message_key")
	private String messageKey;
	
	@Column(name="trade_order")
	private Integer tradeOrder;
	
	@Column(name="active", nullable=false)
	private Boolean active = true;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getMessageKey() {
		return messageKey;
	}

	public void setMessageKey(String messageKey) {
		this.messageKey = messageKey;
	}

	public Integer getTradeOrder() {
		return tradeOrder;
	}

	public void setTradeOrder(Integer tradeOrder) {
		this.tradeOrder = tradeOrder;
	}

	public Boolean getActive() {
		return active;
	}

	public void setActive(Boolean active) {
		this.active = active;
	}
	
}
