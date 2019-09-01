package com.msrtc.portal.applicant.dto;

import com.msrtc.portal.applicant.domain.Post;

public class PostSubmissionErrorsDTO {
	private Post post = new Post();
	private Boolean postValid  = true;
	private Boolean prioritySet = true;
	private Boolean formValid = true;
	
	public PostSubmissionErrorsDTO() {
		
	}

	public Post getPost() {
		return post;
	}

	public void setPost(Post post) {
		this.post = post;
	}

	public Boolean getPostValid() {
		return postValid;
	}

	public void setPostValid(Boolean postValid) {
		this.postValid = postValid;
	}

	public Boolean getPrioritySet() {
		return prioritySet;
	}

	public void setPrioritySet(Boolean prioritySet) {
		this.prioritySet = prioritySet;
	}

	public Boolean getFormValid() {
		return formValid;
	}

	public void setFormValid(Boolean formValid) {
		this.formValid = formValid;
	}

}
