package com.msrtc.portal.applicant.domain;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "posts")
public class Post implements Serializable{

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 4210728368139410032L;
	
	@Id
	@Column(name = "post_id", nullable = false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Long postId;
	
	@Column(name="post_title")
	private String postTitle;

	@Column(name="post_code")
	private String postCode;

	@Column(name="message_key")
	private String messageKey;
	
	@ManyToOne
	@JoinColumn(name="post_type")
	private PostCategory postCategory;
	
	@Column(name="post_order")
	private Integer postOrder;
	
	@Column(name="active")
	private Boolean active;

	@Column(name="show_admit_card")
	private Boolean showAdmitCard;
	
	@Column(name="post_last_date_of_application")
	private String postLastDateOfApplication;
	
	

	public String getPostLastDateOfApplication() {
		return postLastDateOfApplication;
	}

	public void setPostLastDateOfApplication(String postLastDateOfApplication) {
		this.postLastDateOfApplication = postLastDateOfApplication;
	}

	public Boolean getShowAdmitCard() {
		return showAdmitCard;
	}

	public void setShowAdmitCard(Boolean showAdmitCard) {
		this.showAdmitCard = showAdmitCard;
	}

	@Column(name="show_user_response")
	private Boolean showUserResponse;

	public Boolean getShowUserResponse() {
		return showUserResponse;
	}

	public void setShowUserResponse(Boolean showUserResponse) {
		this.showUserResponse = showUserResponse;
	}

	public Post() {
		super();
	}

	public Post(Long postId) {
		super();
		this.postId = postId;
	}

	public Long getPostId() {
		return postId;
	}

	public void setPostId(Long postId) {
		this.postId = postId;
	}

	public String getPostTitle() {
		return postTitle;
	}

	public void setPostTitle(String postTitle) {
		this.postTitle = postTitle;
	}

	public String getMessageKey() {
		return messageKey;
	}

	public void setMessageKey(String messageKey) {
		this.messageKey = messageKey;
	}
	
	public PostCategory getPostCategory() {
		return postCategory;
	}

	public void setPostCategory(PostCategory postCategory) {
		this.postCategory = postCategory;
	}

	public Integer getPostOrder() {
		return postOrder;
	}

	public void setPostOrder(Integer postOrder) {
		this.postOrder = postOrder;
	}
	
	public Boolean getActive() {
		return active;
	}

	public void setActive(Boolean active) {
		this.active = active;
	}

	public String getPostCode() {
		return postCode;
	}

	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}

	@Override
	public String toString() {
	        return "Post{" +
	                "postTitle='" + postTitle + '\'' +
	                ", messageKey='" + messageKey + '\'' +
	                ", postType='" + postCategory + '\'' +
	                ", postId=" + getPostId() +
	                '}';
	    }
}
