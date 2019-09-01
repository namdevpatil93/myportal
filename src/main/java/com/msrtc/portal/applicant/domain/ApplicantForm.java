package com.msrtc.portal.applicant.domain;

import com.msrtc.portal.core.user.domain.User;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDateTime;

@Entity
@Table(name = "applicant_forms")
public class ApplicantForm implements Serializable{

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 6873259943878833873L;

	@Id
	@Column(name = "id", nullable = false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Long id;

	@Column(name = "name")
	private String name;

	@Column(name = "post_id")
	private Long postId;

	@Column(name = "location")
	private String location;

	@Column(name = "created_by")
	private Long createdBy;

	@Column(name = "created_date")
	private LocalDateTime createdDate = LocalDateTime.now();

	@Transient
	private User user;

	@Transient
	private Post post;

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Post getPost() {
		return post;
	}

	public void setPost(Post post) {
		this.post = post;
	}

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

	public Long getPostId() {
		return postId;
	}

	public void setPostId(Long postId) {
		this.postId = postId;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public Long getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(Long createdBy) {
		this.createdBy = createdBy;
	}

	public LocalDateTime getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(LocalDateTime createdDate) {
		this.createdDate = createdDate;
	}
}
