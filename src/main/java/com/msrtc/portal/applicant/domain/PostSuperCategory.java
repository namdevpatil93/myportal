package com.msrtc.portal.applicant.domain;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="post_super_category")
public class PostSuperCategory implements Serializable{

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 6457889471634934950L;

	@Id
	@Column(name = "id", nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;
	
	@Column(name="super_category_title")
	private String categoryTitle;
	
	@Column(name="message_key")
	private String messageKey;
	
	@OneToMany(mappedBy="postSuperCategory", fetch = FetchType.EAGER)
	private List<PostCategory> posCategorytList;
	
	@Column(name="super_category_order")
	private int superCategoryOrder;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getCategoryTitle() {
		return categoryTitle;
	}

	public void setCategoryTitle(String categoryTitle) {
		this.categoryTitle = categoryTitle;
	}

	public String getMessageKey() {
		return messageKey;
	}

	public void setMessageKey(String messageKey) {
		this.messageKey = messageKey;
	}

	public List<PostCategory> getPosCategorytList() {
		return posCategorytList;
	}

	public void setPosCategorytList(List<PostCategory> posCategorytList) {
		this.posCategorytList = posCategorytList;
	}

	public int getSuperCategoryOrder() {
		return superCategoryOrder;
	}

	public void setSuperCategoryOrder(int superCategoryOrder) {
		this.superCategoryOrder = superCategoryOrder;
	}
	
}
