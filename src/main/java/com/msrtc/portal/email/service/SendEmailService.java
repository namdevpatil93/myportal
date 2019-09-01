package com.msrtc.portal.email.service;

import java.util.List;

import com.msrtc.portal.applicant.domain.Applicant;
import com.msrtc.portal.email.domain.Attachment;
import com.msrtc.portal.payment.domain.PaymentTransaction;
import com.msrtc.portal.payment.dto.PaymentTransactionResponse;




public interface SendEmailService {

    void sendPasswordResetEmail(Applicant applicant,String restLink);

    void sendSuccessfulRegistrationEmail(Applicant applicant);

    void sendSuccessfulPaymentEmail(Applicant applicant, PaymentTransactionResponse paymentTransactionResponse);

    void sendFailedPaymentEmail(Applicant applicant, PaymentTransactionResponse paymentTransactionResponse);
    
    void sendSuccessfullOfflinePaymentEmail(Applicant applicant, String orderNo, PaymentTransaction paymentTransaction);

    void sendingEmailsWithAttachments(String[] to, String subject, String from, String Content,
			List<Attachment> attachments);

	void sendingChallanAsEmail(String fileLoc);
	
	void sendingReportAsEmail(List<Attachment> attachment);
	
	void sendingPaymentReportAsEmail(String fileLocation);
	
	void sendingPrefferedCityListAsEmail(String fileLocation);
}
