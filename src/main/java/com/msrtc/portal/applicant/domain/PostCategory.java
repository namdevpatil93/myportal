package com.msrtc.portal.applicant.domain;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name="post_category")
public class PostCategory implements Serializable{

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 5586814713219686409L;
	
	@Id
	@Column(name = "id", nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;
	
	@Column(name="category_title")
	private String categoryTitle;
	
	@Column(name="message_key")
	private String messageKey;
	
	@OneToMany(mappedBy="postCategory", fetch = FetchType.EAGER)
	private List<Post> postList;
	
	@ManyToOne
	@JoinColumn(name="post_super_category")
	private PostSuperCategory postSuperCategory;
	
	@Transient
	private List<ApplicantPostAssoc> applicantPostAssocs;

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

	public List<Post> getPostList() {
		return postList;
	}

	public void setPostList(List<Post> postList) {
		this.postList = postList;
	}

	public PostSuperCategory getPostSuperCategory() {
		return postSuperCategory;
	}

	public void setPostSuperCategory(PostSuperCategory postSuperCategory) {
		this.postSuperCategory = postSuperCategory;
	}

	public List<ApplicantPostAssoc> getApplicantPostAssocs() {
		return applicantPostAssocs;
	}

	public void setApplicantPostAssocs(List<ApplicantPostAssoc> applicantPostAssocs) {
		this.applicantPostAssocs = applicantPostAssocs;
	}
	
}
