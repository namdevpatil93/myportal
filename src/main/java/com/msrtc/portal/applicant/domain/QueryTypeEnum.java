package com.msrtc.portal.applicant.domain;

/**
 * @author veena.lalwani
 *
 */
public enum QueryTypeEnum {

	Registration(1,"Registration"), Application(2,"Application"), Post(3,"Post"), OnlinePayment(4,"Online Payment"),
	OfflinePayment(5,"Offline Payment"), AdmitCard(6,"Admit Card"), Result(7,"Result"), Others(8,"Others");
	private int value;
	private String queryType;
	
	private QueryTypeEnum(int value, String queryType) {
		this.value = value;
		this.queryType = queryType;
	}

	public int getValue() {
		return value;
	}

	public void setValue(int value) {
		this.value = value;
	}

	public String getQueryType() {
		return queryType;
	}

	public void setQueryType(String queryType) {
		this.queryType = queryType;
	}
	
	
}
