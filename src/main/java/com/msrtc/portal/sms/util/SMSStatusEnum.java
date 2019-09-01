package com.msrtc.portal.sms.util;

public enum SMSStatusEnum {
		SUCCESS("SUCCESS"),
		PENDING("PENDING"),
		FAILED("FAILED");
		
		private String value;
		
		private SMSStatusEnum(String value)
		{
			this.value = value;
		}
		
		public String getValue()
		{
			return value;
		}
}
