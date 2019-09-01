package com.msrtc.portal.challan.web;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.spi.LoggerFactory;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.msrtc.portal.applicant.service.ApplicantService;
import com.msrtc.portal.challan.service.ChallanService;
import com.msrtc.portal.core.common.util.CommonUtils;
import com.msrtc.portal.core.common.util.Constants;
import com.msrtc.portal.core.config.ApplicationProperties;
import com.msrtc.portal.core.systemsetting.service.SystemSettingService;
import com.msrtc.portal.core.systemsetting.util.SystemSettingEnum;
import com.msrtc.portal.email.domain.Attachment;
import com.msrtc.portal.email.service.SendEmailService;
import com.msrtc.portal.reports.service.Impl.ReportServiceImpl;

@Component
public class ScheduledTasksChallanAndReports{

	@Autowired
	private ChallanService challanService;

	@Autowired
	private SystemSettingService systemSettingService;

	@Autowired
	SendEmailService sendEmailService;

	@Autowired
	ReportServiceImpl reportService;
	
	@Autowired
	ApplicationProperties applicationProperties;
	
	@Autowired
	private ApplicantService applicantService;

	@Bean
	public String getChallanCronValue() {
		
		String cron= systemSettingService
				.getSystemSetting(SystemSettingEnum.CHALLAN_CRON_VALUE);
		
		return cron;
	}
	
	@Bean
	public String getReportCronValue() {
		
		String cron= systemSettingService
				.getSystemSetting(SystemSettingEnum.REPORT_CRON_VALUE);
		
		return cron;
	}
	
	@Bean
	public String getPaymentReportCronValue() {
		
		String cron= systemSettingService
				.getSystemSetting(SystemSettingEnum.PAYMENT_REPORT_CRON_VALUE);
		
		return cron;
	}
	
	@Bean
	public String getPrefferedCityCronValue() {
		
		String cron= systemSettingService
				.getSystemSetting(SystemSettingEnum.PREFFERED_CITY_CRON_VALUE);
		
		return cron;
	}
	
	@Scheduled(cron ="#{@getChallanCronValue}")
	public void sendingChallanAtSpecificTime() throws IOException, ParseException {

		String challanAutomaticEmail = systemSettingService
				.getSystemSetting(SystemSettingEnum.ENABLE_SENDING_CHALLAN_EMAIL_AUTOMATIC);

		if (!StringUtils.isBlank(challanAutomaticEmail) && "1".equals(challanAutomaticEmail)) {
			
			String savedLocation= challanService.saveChallanData();
			
			sendEmailService.sendingChallanAsEmail(savedLocation);
			
		
		} 
	}
	
	@Scheduled(cron ="#{@getReportCronValue}")
	public void sendingReportsAsEmail() throws ParseException, IOException{
		String startDateOfRegistrationString = systemSettingService
				.getSystemSetting(SystemSettingEnum.START_DATE_REPORT_GENERATION);

		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		SimpleDateFormat formatter2 = new SimpleDateFormat("dd-MM-yyyy");
		Date startDateOfRegistration = formatter
				.parse(startDateOfRegistrationString);

		Date endDate = challanService.getEndDateString();

		Date startDate = challanService.getStartDateString();

		String parsedEndDate = formatter2.format(endDate);

		String parsedStartDate = formatter2.format(startDate);

		String parsedstStartDateOfRegistration = formatter2.format(startDateOfRegistration);

		String basePath = applicationProperties.getResources().getBasePath();
		String reportLocation = basePath + File.separator
				+ Constants.BASE_DOWNLOAD_DIR + File.separator
				+ Constants.REPORTS_TO_MAIL;
		String reportFileName = parsedStartDate + "-to-" + parsedEndDate + "_DailyReport.xlsx";
		String commulativeReportName = parsedstStartDateOfRegistration + "-to-" + parsedEndDate + "_ComulativeReport.xlsx";

		String reportAutomaticEmail = systemSettingService.getSystemSetting(SystemSettingEnum.ENABLE_SENDING_REPORT_EMAIL_AUTOMATIC);

		if (!StringUtils.isBlank(reportAutomaticEmail) && "1".equals(reportAutomaticEmail)) {
		
		reportService.genearteReports(startDate, endDate, reportLocation, reportFileName);
		
		reportService.genearteReports(startDateOfRegistration, endDate, reportLocation, commulativeReportName);
		
		
		Attachment attachment1 = new Attachment(reportFileName+".xlsx", reportLocation + File.separator + reportFileName);
		Attachment attachment2 = new Attachment(commulativeReportName+".xlsx", reportLocation + File.separator + commulativeReportName);
		
		List<Attachment> attachment = new ArrayList<Attachment>();
		attachment.add(attachment1);
		attachment.add(attachment2);
		
		sendEmailService.sendingReportAsEmail(attachment);
		
		
		
		} 

	}
	
	@Scheduled(cron ="#{@getPrefferedCityCronValue}")
	public void sendPreferedCityEmail(){
		
		Date endDate = challanService.getEndDateString();
		SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
		String parsedEndDate = formatter.format(endDate);
		
		String enablePrefferedCityEmail = systemSettingService
				.getSystemSetting(SystemSettingEnum.ENABLE_PREFFERED_CITY_EMAIL);
		if (!StringUtils.isBlank(enablePrefferedCityEmail) && "1".equals(enablePrefferedCityEmail)) {
		
		try {
			//String fileLocation = applicantService.generatePreferedCityReport(parsedEndDate);
			String fileLocation = applicantService.generatePrefferedCityReportCsv(parsedEndDate);
			sendEmailService.sendingPrefferedCityListAsEmail(fileLocation);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		}
		
	}
	
	/*@Scheduled(cron ="#{@getPaymentReportCronValue}")
	public void sendingPaymentReportAtSpecificTime() throws IOException, ParseException {

		String enableAutomaticPaymentReport = systemSettingService
				.getSystemSetting(SystemSettingEnum.ENABLE_AUTOMATIC_PAYMENT_REPORT);

		if (!StringUtils.isBlank(enableAutomaticPaymentReport) && "1".equals(enableAutomaticPaymentReport)) {
			
			Calendar today = Calendar.getInstance();
	        today.set(Calendar.HOUR_OF_DAY,23);
	        today.set(Calendar.MINUTE, 59);
	        today.set(Calendar.SECOND, 59); 
	        today.add(Calendar.DATE, 0);
	        Date endDate = today.getTime();
			
			//Date endDate = challanService.getEndDateString();

			Date startDate = challanService.getStartDateString();
			
			challanService.submitQueryList(startDate, endDate);
			
		
		} 
	}*/

}
