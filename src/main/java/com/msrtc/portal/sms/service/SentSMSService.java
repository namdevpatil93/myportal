package com.msrtc.portal.sms.service;

public interface SentSMSService {
	
	void sendSuccessfulRegistrationSMS(String mobileNo, String firstName, Integer otpNo);
	
	void reSendOTP(String mobileNo, String firstName, Integer otpNo);
	
	void sendSuccessfulOfflinePaymentSMS( String mobileNo, String firstName );
	
	void sendSuccessfulOnlinePaymentSMS( String mobileNo, String firstName  );
}
