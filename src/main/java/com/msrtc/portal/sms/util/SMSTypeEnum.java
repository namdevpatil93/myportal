package com.msrtc.portal.sms.util;

public enum SMSTypeEnum {
	
	USER_REGISTRATION("USER_REGISTRATION"),
	RE_SEND_OTP("RE_SEND_OTP"),
	SUCCESSFUL_OFFLINE_PAYMENT("SUCCESSFUL_OFFLINE_PAYMENT"),
	SUCCESSFUL_ONLINE_PAYMENT("SUCCESSFUL_ONLINE_PAYMENT");
	
	private String value;
	
	private SMSTypeEnum(String value)
	{
		this.value = value;
	}
	
	public String getValue()
	{
		return value;
	}
}
