package com.msrtc.portal.email.service.impl;

import java.io.File;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.apache.commons.codec.CharEncoding;
import org.apache.velocity.app.VelocityEngine;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.ui.velocity.VelocityEngineUtils;

import com.msrtc.portal.applicant.domain.Applicant;
import com.msrtc.portal.challan.service.ChallanService;
import com.msrtc.portal.core.common.util.Constants;
import com.msrtc.portal.core.config.ApplicationProperties;
import com.msrtc.portal.core.systemsetting.service.SystemSettingService;
import com.msrtc.portal.core.systemsetting.util.SystemSettingEnum;
import com.msrtc.portal.email.domain.Attachment;
import com.msrtc.portal.email.service.SendEmailService;
import com.msrtc.portal.payment.domain.PaymentTransaction;
import com.msrtc.portal.payment.dto.PaymentTransactionResponse;


@Service("sendEmailService")
public class SendEmailServiceImpl implements SendEmailService {

    private final Logger log = LoggerFactory.getLogger(this.getClass());

    @Autowired
	private SystemSettingService systemSettingService;
    
    @Autowired
	private ChallanService challanService;
    
    @Autowired
    private JavaMailSender javaMailSender;

    @Autowired
    private VelocityEngine velocityEngine;

    @Autowired
    private MessageSource messageSource;

    @Autowired
    private ApplicationProperties applicationProperties;

    private void sendEmail(String to, String subject, String content, String from, boolean isMultipart, boolean isHtml) {
        log.debug("Send e-mail[multipart '{}' and html '{}'] to '{}' with subject '{}'", isMultipart, isHtml, to, subject);
        MimeMessage mimeMessage = javaMailSender.createMimeMessage();
        try {
            MimeMessageHelper message = new MimeMessageHelper(mimeMessage, isMultipart, CharEncoding.UTF_8);
            message.setTo(to);
            message.setFrom(from);
            message.setSubject(subject);
            message.setText(content, isHtml);
            javaMailSender.send(mimeMessage);
            log.debug("Sent e-mail to User '{}'", to);
        } catch (Exception e) {
            log.warn("E-mail could not be sent to user '{}', exception is: {}", to, e.getMessage());
        }
    }

    @Override
    public void sendPasswordResetEmail(Applicant applicant,String resetLink) {
        log.debug("Sending password reset e-mail to '{}'", applicant.getEmailAddress());
        Locale locale = LocaleContextHolder.getLocale();
        Map model = new HashMap();
        model.put("applicant", applicant);
        model.put("resetLink", resetLink);
        model.put("expiryDate",LocalDate.now().plusDays(1));

        String content = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "emails/passwordResetEmail.vm", "UTF-8", model);
        String subject = messageSource.getMessage("forgotPassword.emailSubject", null, LocaleContextHolder.getLocale());
        String from = applicationProperties.getMail().getFrom();
        sendEmail(applicant.getEmailAddress(), subject, content, from ,false, true);
    }

    @Override
    public void sendSuccessfulRegistrationEmail(Applicant applicant) {
        log.debug("Sending successful registration e-mail to '{}'", applicant.getEmailAddress());
        Locale locale = LocaleContextHolder.getLocale();
        Map model = new HashMap();
        model.put("applicant", applicant);
        String content = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "emails/successfulRegistrationEmail.vm", "UTF-8", model);
        String subject = messageSource.getMessage("email.successfulRegistration.subject", null, locale);
        String from = applicationProperties.getMail().getFrom();
        sendEmail(applicant.getEmailAddress(), subject, content, from ,false, true);
    }

    @Override
    public void sendSuccessfulPaymentEmail(Applicant applicant, PaymentTransactionResponse paymentTransactionResponse) {
        log.debug("Sending successful payment e-mail to '{}'", applicant.getEmailAddress());
        Locale locale = LocaleContextHolder.getLocale();
        Map model = new HashMap();
        model.put("applicant", applicant);
        model.put("paymentTransactionResponse", paymentTransactionResponse);
        String content = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "emails/successfulPaymentEmail.vm", "UTF-8", model);
        String subject = "MSRTC - Payment successful for Transaction ID "+ paymentTransactionResponse.getOrderNo();
        String from = applicationProperties.getMail().getFrom();
        sendEmail(applicant.getEmailAddress(), subject, content, from ,false, true);
    }

    @Override
    public void sendFailedPaymentEmail(Applicant applicant, PaymentTransactionResponse paymentTransactionResponse) {
        log.debug("Sending failed payment e-mail to '{}'", applicant.getEmailAddress());
        Locale locale = LocaleContextHolder.getLocale();
        Map model = new HashMap();
        model.put("applicant", applicant);
        model.put("paymentTransactionResponse", paymentTransactionResponse);
        String content = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "emails/failedPaymentEmail.vm", "UTF-8", model);
        String subject = "MSRTC - Transaction Failed for Transaction ID "+ paymentTransactionResponse.getOrderNo();
        String from = applicationProperties.getMail().getFrom();
        sendEmail(applicant.getEmailAddress(), subject, content, from ,false, true);
    }
    
    @Override
    public void sendSuccessfullOfflinePaymentEmail(Applicant applicant, String orderNo, PaymentTransaction paymentTransaction) {
        log.debug("Sending successful offline payment e-mail to '{}'", applicant.getEmailAddress());
        Locale locale = LocaleContextHolder.getLocale();
        Map model = new HashMap();
        model.put("applicant", applicant);
        model.put("orderNo", orderNo);
        model.put("paymentTransaction", paymentTransaction);
        String content = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "emails/successfulOfflinePaymentEmail.vm", "UTF-8", model);
        String subject = "MSRTC - Payment Successful for Order Number "+ orderNo;
        String from = applicationProperties.getMail().getFrom();
        sendEmail(applicant.getEmailAddress(), subject, content, from ,false, true);
    }

   
	
	
	@Override
	public void sendingEmailsWithAttachments(String[] to, String subject, String from, String Content, List<Attachment> attachments) {

		log.debug("Sending Challan Data As Email Sucessfully '{}'", to,
				subject, from);

		MimeMessage mimeMessage = javaMailSender.createMimeMessage();

		try {

			MimeMessageHelper message = new MimeMessageHelper(mimeMessage,CharEncoding.UTF_8);
			message.setFrom(from);
			message.setSubject(subject);
			message.setText(Content, true);

			BodyPart bodyPart = new MimeBodyPart();
			bodyPart.setContent(Content, "text/html");

			Multipart multipart = new MimeMultipart();
			multipart.addBodyPart(bodyPart);
			if(attachments.isEmpty()){
				message.setText("No Records for today!!", true);
			}else{
			
			for (Attachment attachment : attachments) {
				multipart.addBodyPart(addAttachment(attachment));
			}
			
			mimeMessage.setContent(multipart);
			}
			for (String email : to) {
				try {
					message.setTo(email);
					javaMailSender.send(mimeMessage);

				} catch (Exception e) {
					e.printStackTrace();
					email = email + "\n";

				}
			}

			log.debug("Sent e-mail to User '{}'", to);

		} catch (Exception e) {
			log.warn("E-mail could not be sent to user '{}', exception is: {}",to, e.getMessage());
		}
	}
	
	

	private BodyPart addAttachment(Attachment attachment) {
		BodyPart messageBodyPart = new MimeBodyPart();

		DataSource source = new FileDataSource(attachment.getFullPath());
		try {
			messageBodyPart.setDataHandler(new DataHandler(source));
			messageBodyPart.setFileName(attachment.getName());
		} catch (MessagingException e) {
			e.printStackTrace();
		}

		return messageBodyPart;
	}
	
	
	@Override
	public void sendingChallanAsEmail(String fileLocation) {
		Map model = new HashMap();
		model.put("content", systemSettingService.getSystemSetting(SystemSettingEnum.CHALLAN_EMAIL_BODY));
		String from = applicationProperties.getMail().getFrom();
		String subject = systemSettingService.getSystemSetting(SystemSettingEnum.CHALLAN_EMAIL_SUBJECT);
		String content = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "emails/challanSendAsEmail.vm", "UTF-8", model);
		String emailIds = systemSettingService.getSystemSetting(SystemSettingEnum.CHALLAN_EMAIL_IDS);

		emailIds.replaceAll("\\s+", "");
		
		Date date = new Date();  
		SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
	    String currentDate= formatter.format(date);

		String[] listOfEmailIds = emailIds.split(",");
		List<Attachment> attachmentList = new ArrayList<Attachment>();
		
		File file = new File(fileLocation);
		if(file.exists()){
		
		Attachment attachment = new Attachment("MSRTC_"+currentDate+".txt", fileLocation);
		attachmentList.add(attachment);
		}
		sendingEmailsWithAttachments(listOfEmailIds, subject, from, content,attachmentList);

	}
			
	public void sendingReportAsEmail(List<Attachment> attachment) {
		Map model = new HashMap();
		model.put("content", systemSettingService.getSystemSetting(SystemSettingEnum.REPORT_EMAIL_BODY));
		String from = applicationProperties.getMail().getFrom();
		String subject = systemSettingService.getSystemSetting(SystemSettingEnum.REPORT_EMAIL_SUBJECT);
		String content = VelocityEngineUtils.mergeTemplateIntoString(
				velocityEngine, "emails/reportSendAsEmail.vm", "UTF-8", model);
		String emailIds = systemSettingService.getSystemSetting(SystemSettingEnum.APPLICATION_REPORT_EMAIL_IDS);
		emailIds.replaceAll("\\s+", "");

		String[] listOfEmailIds = emailIds.split(",");
		sendingEmailsWithAttachments(listOfEmailIds, subject, from, content,attachment);
	}

	@Override
	public void sendingPaymentReportAsEmail(String fileLocation) {
		
		
		Map model = new HashMap();
		model.put("content", systemSettingService.getSystemSetting(SystemSettingEnum.PAYMENT_REPORT_EMAIL_BODY));
		String from = applicationProperties.getMail().getFrom();
		String subject = systemSettingService.getSystemSetting(SystemSettingEnum.PAYMENT_REPORT_EMAIL_SUBJECT);
		String content = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "emails/PaymentReportAsEmail.vm", "UTF-8", model);
		String emailIds = systemSettingService.getSystemSetting(SystemSettingEnum.PAYMENT_REPORT_EMAIL_IDS);

		emailIds.replaceAll("\\s+", "");
		
		Date date = new Date();  
		SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
	    String currentDate= formatter.format(date);

		String[] listOfEmailIds = emailIds.split(",");
		List<Attachment> attachmentList = new ArrayList<Attachment>();
		
		File file = new File(fileLocation);
		if(file.exists()){
		
		Attachment attachment = new Attachment("onlineQueryApiResp.xlsx", fileLocation);
		attachmentList.add(attachment);
		}
		sendingEmailsWithAttachments(listOfEmailIds, subject, from, content,attachmentList);

		
	}
	
	
	@Override
	public void sendingPrefferedCityListAsEmail(String fileLocation) {
		
		
		Map model = new HashMap();
		model.put("content", systemSettingService.getSystemSetting(SystemSettingEnum.PREFFERED_CITY_EMAIL_BODY));
		String from = applicationProperties.getMail().getFrom();
		String subject = systemSettingService.getSystemSetting(SystemSettingEnum.PREFFERED_CITY_EMAIL_SUBJECT);
		String content = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "emails/PrefferedCityData.vm", "UTF-8", model);
		String emailIds = systemSettingService.getSystemSetting(SystemSettingEnum.PREFFERED_CITY_EMAIL_IDS);

		emailIds.replaceAll("\\s+", "");
		
		Date date = new Date();  
		SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
	    String currentDate= formatter.format(date);

		String[] listOfEmailIds = emailIds.split(",");
		List<Attachment> attachmentList = new ArrayList<Attachment>();
		
		File file = new File(fileLocation);
		if(file.exists()){
		
		Attachment attachment = new Attachment("prefferedCityList.csv", fileLocation);
		attachmentList.add(attachment);
		}
		sendingEmailsWithAttachments(listOfEmailIds, subject, from, content,attachmentList);

		
	}


		
	}


