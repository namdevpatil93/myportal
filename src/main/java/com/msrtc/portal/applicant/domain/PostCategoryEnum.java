package com.msrtc.portal.applicant.domain;

public enum PostCategoryEnum {

	UnitCategoryPost(1), Technical(2), NonTechnical(3), Manager(4), TechnicalForOfficer(6), NonTechnicalForOfficer(7);
	
	private int postCategoryId;
	
	private PostCategoryEnum(int postCategoryId) {
		this.postCategoryId = postCategoryId;
	}
	
	public long getPostCategoryId(){
		return postCategoryId;
	}
}
