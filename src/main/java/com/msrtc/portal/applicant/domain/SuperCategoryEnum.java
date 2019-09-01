package com.msrtc.portal.applicant.domain;

public enum SuperCategoryEnum {
	
	Others(1), Supervisor(2), Manager(3), Officers(5);
	
	private int superCategoryId;
	
	SuperCategoryEnum(int superCategoryId) {
		this.superCategoryId = superCategoryId;
	}

	public int getSuperCategoryId() {
		return superCategoryId;
	}

}
