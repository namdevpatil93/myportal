package com.msrtc.portal.sms.service.impl;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

import org.apache.velocity.app.VelocityEngine;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.velocity.VelocityEngineUtils;

import com.msrtc.portal.core.systemsetting.service.SystemSettingService;
import com.msrtc.portal.core.systemsetting.util.SystemSettingEnum;
import com.msrtc.portal.sms.domain.SmsSentHistory;
import com.msrtc.portal.sms.repository.SmsSentHistoryRepository;
import com.msrtc.portal.sms.service.SentSMSService;
import com.msrtc.portal.sms.util.SMSStatusEnum;
import com.msrtc.portal.sms.util.SMSTypeEnum;

@Service("sentSMSService")
public class SentSMSServiceImpl implements SentSMSService {
	
	private final Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private SystemSettingService systemSettingService;
	
	@Autowired
	private SmsSentHistoryRepository smsSentHistoryRepository;
	
	@Autowired
    private VelocityEngine velocityEngine;

	private Map<String, String> propertiesMap = new HashMap<String, String>();
	
	@Override
	public void sendSuccessfulRegistrationSMS(String mobileNo, String firstName, Integer otpNo) {
		
		Map model = new HashMap();
		model.put("firstName", firstName);
		model.put("otpNumber", otpNo);

		StringBuilder template = new StringBuilder(VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "sms_service/successfulRegistrationTemplate.vm", "UTF-8", model));
		
		if(template != null && !template.toString().isEmpty())
		{
			send(mobileNo, template.toString(), SMSTypeEnum.USER_REGISTRATION.getValue());
		}
	}
	
	private void send(String mobileNo, String message, String smsType) {
		
		SmsSentHistory smsSH = createSmsSentHistory(mobileNo, smsType);

		try{
			StringBuilder encodedMessage = new StringBuilder(createEncodedPostMessage(mobileNo, message));
//			System.out.println("encodedMessage: "+encodedMessage);
			URL url = new URL(systemSettingService.getSystemSetting(SystemSettingEnum.SMS_GUPSHUP_BASEURL));

			URLConnection urlConn = url.openConnection();
			HttpURLConnection conn = (HttpURLConnection)urlConn;
			conn.setReadTimeout(10000);
			conn.setConnectTimeout(10000);
			conn.setRequestMethod("POST");
			conn.setDoInput(true);
			conn.setDoOutput(true);
			
			//setting http request headers
			String lengthString = String.valueOf(encodedMessage.length());
			conn.setRequestProperty("User-Agent", "Mozilla/5.0");
			conn.setRequestProperty("Content-Length", lengthString);
	        conn.setRequestProperty("Context-Type", "text/html"); //or any other mime type
	        conn.setRequestProperty("Accept-Language", "en-US");
	        
	      //enable or disable data cache use
	        conn.setUseCaches(false);
	        
			OutputStream os = conn.getOutputStream();
			BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(os, "UTF-8"));
			writer.write(encodedMessage.toString());
			writer.flush();
			writer.close();
			os.close();
			conn.connect();
	
			int responseCode = conn.getResponseCode();
			if(responseCode == HttpsURLConnection.HTTP_OK)
			{
				String line;
				BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
				while((line=reader.readLine()) != null)
				{
					log.info("["+this.getClass()+"] Response: "+line);
					if(line.indexOf("error") == -1)
					{
						smsSH.setStatus(SMSStatusEnum.SUCCESS.getValue());
						break;
					}
					else
					{
						smsSH.setStatus(SMSStatusEnum.FAILED.getValue());
						break;
					}
				}
				reader.close();
				
			}else
			{
				log.info("["+this.getClass()+"] ResponseCode: "+responseCode);
				smsSH.setStatus(SMSStatusEnum.FAILED.getValue());
			}
		}catch(Exception ex)
		{
			log.error("Error in ["+this.getClass()+"]: ",ex);
			smsSH.setStatus(SMSStatusEnum.FAILED.getValue());
		}
		//smsSentHistoryRepository.save(smsSH);
	}
	
	private  String createEncodedPostMessage(String mobileNo, String msg) 
	{
		StringBuilder builder = new StringBuilder();
		try{
			
			setProperties();
			appendURLParam(builder, "send_to", mobileNo);
			appendURLParam(builder, "msg", msg);
			appendURLParam(builder, "method", propertiesMap.get("method"));
			appendURLParam(builder, "userid", propertiesMap.get("userid"));
			appendURLParam(builder, "password", propertiesMap.get("password"));
			appendURLParam(builder, "v", propertiesMap.get("v"));
			appendURLParam(builder, "msg_type", propertiesMap.get("msg_type"));
			appendURLParam(builder, "auth_scheme", propertiesMap.get("auth_scheme"));
			appendURLParam(builder, "mask", propertiesMap.get("mask"));
			
		}
		catch(Exception ex)
		{
			log.error("Exception in ["+this.getClass()+"] ",ex);
		}
		return builder.toString();
	}

	/**
	 * @param builder
	 * @throws UnsupportedEncodingException
	 */
	private void appendURLParam(StringBuilder builder, String key, String value)
			throws UnsupportedEncodingException 
	{
		builder.append("&");
		builder.append(key).append("=").append(URLEncoder.encode(value, "UTF-8"));
	}

	private SmsSentHistory createSmsSentHistory(String mobileNo, String smsType)
	{
		SmsSentHistory smsSH = new SmsSentHistory();
		smsSH.setSmsType(smsType);
		smsSH.setStatus(SMSStatusEnum.PENDING.getValue());
		smsSH.setSentTo(mobileNo);
		smsSH.setSentTime(LocalDateTime.now());
		return smsSH;
	}

	private synchronized void setProperties()
	{
		if(propertiesMap.isEmpty())
		{
			propertiesMap.put("method", systemSettingService.getSystemSetting(SystemSettingEnum.SMS_GUPSHUP_METHOD));
			propertiesMap.put("userid", systemSettingService.getSystemSetting(SystemSettingEnum.SMS_GUPSHUP_USERID));
			propertiesMap.put("password", systemSettingService.getSystemSetting(SystemSettingEnum.SMS_GUPSHUP_PASSWORD));
			propertiesMap.put("v", systemSettingService.getSystemSetting(SystemSettingEnum.SMS_GUPSHUP_VERSION));
			propertiesMap.put("msg_type", systemSettingService.getSystemSetting(SystemSettingEnum.SMS_GUPSHUP_MSG_TYPE));
			propertiesMap.put("auth_scheme", systemSettingService.getSystemSetting(SystemSettingEnum.SMS_GUPSHUP_AUTY_SCHEME));
			propertiesMap.put("mask", systemSettingService.getSystemSetting(SystemSettingEnum.SMS_GUPSHUP_MASK));

		}
	}

	@Override
	public void reSendOTP(String mobileNo, String firstName, Integer otpNo) {
		
		Map model = new HashMap();
		model.put("firstName", firstName);
		model.put("otpNumber", otpNo);

		StringBuilder template = new StringBuilder(VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "sms_service/reSendOTPTemplate.vm", "UTF-8", model));
		
		if(template != null && !template.toString().isEmpty())
		{
			send(mobileNo, template.toString(), SMSTypeEnum.RE_SEND_OTP.getValue());
		}
	}

	@Override
	public synchronized void sendSuccessfulOfflinePaymentSMS(String mobileNo, String firstName) {
		Map model = new HashMap();
		model.put("firstName", firstName);
		
		StringBuilder template = new StringBuilder(VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "sms_service/paymentChallanUploadTemplate.vm", "UTF-8", model));
		
		if(template != null && !template.toString().isEmpty())
		{
			send(mobileNo, template.toString(), SMSTypeEnum.SUCCESSFUL_OFFLINE_PAYMENT.getValue());
		}
	}

	@Override
	public void sendSuccessfulOnlinePaymentSMS(String mobileNo, String firstName) {
		Map model = new HashMap();
		model.put("firstName", firstName);
		
		StringBuilder template = new StringBuilder(VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "sms_service/successfulOnlinePaymentTemplate.vm", "UTF-8", model));
		
		if(template != null && !template.toString().isEmpty()) 
		{
			send(mobileNo, template.toString(), SMSTypeEnum.SUCCESSFUL_ONLINE_PAYMENT.getValue());
		}
		
	}
	
}
