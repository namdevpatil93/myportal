package com.msrtc.portal.challan.service.impl;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.msrtc.portal.applicant.domain.StatusEnum;
import com.msrtc.portal.applicant.service.ApplicantService;
import com.msrtc.portal.challan.domain.Challan;
import com.msrtc.portal.challan.domain.ChallanFile;
import com.msrtc.portal.challan.dto.ChallanFileSearchDTO;
import com.msrtc.portal.challan.dto.ChallanSearchDTO;
import com.msrtc.portal.challan.repository.ChallanFileRepository;
import com.msrtc.portal.challan.repository.ChallanRepository;
import com.msrtc.portal.challan.service.ChallanService;
import com.msrtc.portal.core.common.util.CSVReaderUtils;
import com.msrtc.portal.core.common.util.Constants;
import com.msrtc.portal.core.common.util.FileUtils;
import com.msrtc.portal.core.config.ApplicationProperties;
import com.msrtc.portal.core.systemsetting.service.SystemSettingService;
import com.msrtc.portal.core.systemsetting.util.SystemSettingEnum;
import com.msrtc.portal.email.service.SendEmailService;
import com.msrtc.portal.payment.domain.PaymentTransaction;
import com.msrtc.portal.payment.domain.PaymentTransactionStatusEnum;
import com.msrtc.portal.payment.service.PaymentTransactionService;
import com.msrtc.portal.sms.service.SentSMSService;

@Service(value = "challanService")
@Transactional(readOnly = true)
public class ChallanServiceImpl implements ChallanService {

	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	private ChallanRepository challanRepository;

	@Autowired
	private ChallanFileRepository challanFileRepository;

	@Autowired
	private ApplicationProperties applicationProperties;

	@Autowired
	private PaymentTransactionService paymentTransactionService;
	
	@Autowired ApplicantService applicantService;
	
	@Autowired
	private SystemSettingService systemSettingService;
	
	@Autowired
    private SendEmailService sendEmailService;

	@Autowired
	private SentSMSService sentSMSService;

	@Override
	public Page<Challan> searchChallans(ChallanSearchDTO challanSearchDTO, Pageable pageable){
		return challanRepository.searchChallans(challanSearchDTO, pageable);
	}

	@Override
	public Page<ChallanFile> searchChallanFiles(ChallanFileSearchDTO challanFileSearchDTO, Pageable pageable){
		return challanFileRepository.searchChallanFiles(challanFileSearchDTO, pageable);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
	public void saveChallan(Challan challan){
		challanRepository.save(challan);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
	public void saveChallanFile(ChallanFile challanFile){
		challanFileRepository.save(challanFile);
	}

	@Override
	public ChallanFile findChallanFileByChallanFileId(Long challanFileId){
		return challanFileRepository.findOne(challanFileId);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
	public Map<String, String> uploadChallan(MultipartFile challanFile, Long userId) throws IOException {
		log.debug("Uploading Challan");
		
		Map<String, String> errorMap = new HashMap<>();
		
		Integer notUploadedCount = 0;
		Integer alreadyUploadCount = 0;
		
		String basePath = applicationProperties.getResources().getBasePath();

		//String challanFileName = challanFile != null ? UUID.randomUUID().toString() + "_" + challanFile.getOriginalFilename() : null;
		String challanFileExtension = challanFile != null ? challanFile.getOriginalFilename().substring(challanFile.getOriginalFilename().lastIndexOf(".")) : null;
		String challanFileName = challanFile != null ? UUID.randomUUID().toString() +challanFileExtension : null;
		String challanFileLocation = basePath + File.separator + Constants.BASE_UPLOAD_DIR + File.separator + Constants.CHALLANS_UPLOAD_BASE_DIR;
		
		if (challanFileName != null) {
			FileUtils.saveFile(challanFile, challanFileName, challanFileLocation);
			ChallanFile challanFileObj = new ChallanFile(challanFileName, challanFile.getOriginalFilename(), 1L);
			this.saveChallanFile(challanFileObj);
			//List<Challan> challanList = ExcelReaderUtils.extractRowsFromExcel(challanFileLocation + File.separator + challanFileName, Challan.class, 0, 2, 3);
			List<Challan> challanList = CSVReaderUtils.parseCSV(challanFileLocation + File.separator + challanFileName, Challan.class);
			
			if (challanList != null && challanList.size() > 0) {
				Challan lastIndexChallanData = challanList.remove(challanList.size() - 1);
				
				Long totalAmount = 0L;
				
				if (challanList != null && challanList.size() > 0) {
					String notUploadedList = "";
					String alreadyUploadList = "";

					List<String> orderNoList = new ArrayList<>();

					//for(Challan challan : challanList) {
					for (int i = 0; i < challanList.size(); i++) {
						Challan challan = challanList.get(i);
						
						// '+3' to get row no at CSV
						Integer rowNoAtCSV = i+3;
						
						String orderNo = challan.getApplicationNo();
						
						orderNo = StringUtils.leftPad(orderNo, 20, '0');
						
						if ( !org.apache.commons.lang3.StringUtils.isBlank(orderNo) ) {
							orderNo = orderNo.trim();
							orderNo = orderNo.substring(10);
						}

						orderNoList.add(orderNo);

					}

					if (orderNoList != null && orderNoList.size() > 0) {
						paymentTransactionService.updateOfflinePaymentTransactionStatus(orderNoList, null, PaymentTransactionStatusEnum.SUCCESS.getId());
						int status = StatusEnum.SUBMITTED.getId();
						paymentTransactionService.updatePaymentStatusOfPostsWithOrderNo(orderNoList, status);

						List<String> dbOrderNos = paymentTransactionService.findByOrderNos(orderNoList);
//						List<String> ordersNotFoundInDB = new ArrayList<>();

//						if (dbOrderNos  != null && dbOrderNos .size() > 0) {
//							for (String orderNo :  orderNoList) {
//                                if (!dbOrderNos.contains(orderNo)) {
//                                    ordersNotFoundInDB.add(orderNo);
//                                }
//                            }
//						}

						/*List<Object[]> applicantList = paymentTransactionService.findApplicantDetailsByOrderNos(dbOrderNos);

						if (applicantList  != null && applicantList .size() > 0) {
							for (Object[] objectArray : applicantList ) {

								String firstName = String.valueOf(objectArray[0]);
								String lastName = String.valueOf(objectArray[1]);
								String emailAddress = String.valueOf(objectArray[2]);
								String mobileNumber = String.valueOf(objectArray[3]);
								String applicationId = String.valueOf(objectArray[4]);
								String amount = String.valueOf(objectArray[5]);
								String orderNo = String.valueOf(objectArray[6]);

								Applicant applicant = new Applicant();
								applicant.setFirstName(firstName);
								applicant.setLastName(lastName);
								applicant.setEmailAddress(emailAddress);
								applicant.setApplicationId(applicationId);

								PaymentTransaction paymentTransaction = new PaymentTransaction();
								paymentTransaction.setAmount(new BigDecimal(amount));

								// sendEmailService.sendSuccessfullOfflinePaymentEmail(applicant, orderNo, paymentTransaction);
								// sentSMSService.sendSuccessfulOfflinePaymentSMS(mobileNumber, firstName);
							}
						}*/

//						String ordersNotFoundInDBCommaSeparated = ordersNotFoundInDB.stream().collect(Collectors.joining(","));
//						errorMap.put("notUploadedList", ordersNotFoundInDBCommaSeparated);
						errorMap.put("totalUploaded", String.valueOf(dbOrderNos.size()));
						errorMap.put("totalRecordsGiven", String.valueOf(lastIndexChallanData.getTranTime()));
						errorMap.put("totalRecordsFound", String.valueOf(challanList.size()));

					}

				}
			}
		}
		
		return errorMap;
	}

	@Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
    public void updatePaymentStatusViaQueryApi(String orderNo, int status){
        paymentTransactionService.updatePaymentTransactionStatusWithOrderNo(orderNo, status);
        
        if ( status == PaymentTransactionStatusEnum.SUCCESS.getId() ) {
        	paymentTransactionService.updatePaymentStatusOfPostsWithOrderNo(orderNo, status);
        }
    }

	@Override
	public List<Object[]> downloadChallanData(String fromDate, String toDate) {
		List<Object[]> challanDataList = challanRepository.findChallanDataList(fromDate, toDate);
		return challanDataList;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
	public void markPostAsSubmitted(Long postAssocId, String orderNo){
		applicantService.markPostAsSubmitted(postAssocId, orderNo);
	}
	
	public  Date getStartDateString() {
        Calendar yestarday = Calendar.getInstance();
        yestarday.set(Calendar.HOUR_OF_DAY,0);
        yestarday.set(Calendar.MINUTE, 0);
        yestarday.set(Calendar.SECOND, 0); 
        yestarday.add(Calendar.DATE, -1);    
        Date date=yestarday.getTime();
        return date;
}

	public  Date getEndDateString() {
        Calendar today = Calendar.getInstance();
        today.set(Calendar.HOUR_OF_DAY,23);
        today.set(Calendar.MINUTE, 59);
        today.set(Calendar.SECOND, 59); 
        today.add(Calendar.DATE, -1);
        Date date = today.getTime();
        return date;
}
	
	
	/*==============================================================================*/
	
	
	public String saveChallanData() throws IOException, ParseException {

		Date endDate = getEndDateString();
		
		Date startDate = getStartDateString();
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		
		
		String parsedFromDate = formatter.format(startDate);
		String parsedtoDate = formatter.format(endDate);
		List<Object[]> challanDataList = downloadChallanData(parsedFromDate,
				parsedtoDate);
		String reportName = "MSRTC_" + parsedtoDate + ".txt";

		List<String> rows = new ArrayList<String>();

		StringBuilder srtBldr = null;

		String paymentDate = systemSettingService
				.getSystemSetting(SystemSettingEnum.OFFLINE_LAST_DATE_OF_PAYMENT);
		LocalDate localDate = LocalDate.parse(
				paymentDate != null ? paymentDate : LocalDate.now().format(
						DateTimeFormatter.ofPattern("dd/MM/yyyy")),
				DateTimeFormatter.ofPattern("dd/MM/yyyy").withLocale(
						Locale.ENGLISH));
		String lastDateOfPayment = localDate.format(DateTimeFormatter
				.ofPattern("ddMMyyyy"));

		for (Object obj[] : challanDataList) {
			StringBuilder postIdBuilder = new StringBuilder();

			String challanNumber = (String) obj[1];

			srtBldr = new StringBuilder();

			srtBldr.append(StringUtils.leftPad((String) obj[0], 6, '0'));
			srtBldr.append(StringUtils.leftPad((String) obj[1], 20, '0'));

			DateTimeFormatter formatteDate = DateTimeFormatter
					.ofPattern("ddMMyyyy");
			String formattedDateTime = ((LocalDate) obj[2])
					.format(formatteDate);

			srtBldr.append(formattedDateTime);
			srtBldr.append(StringUtils.leftPad((String) obj[3], 17, '0'));
			srtBldr.append(StringUtils.leftPad((String) obj[4].toString()
					+ "000", 17, '0'));
			srtBldr.append(StringUtils.leftPad((String) obj[5], 5, '0'));

			String applicantName = (String) obj[6];

			if (applicantName.length() > 30) {
				applicantName = applicantName.substring(0, 30);
			}

			srtBldr.append(StringUtils.rightPad(applicantName, 30, ' '));
			srtBldr.append(StringUtils.rightPad(postIdBuilder.toString(), 30,
					' '));

			String casteTitle = obj[7].toString();
			srtBldr.append(StringUtils.rightPad(casteTitle, 30, ' '));
			srtBldr.append(StringUtils.rightPad((String) obj[8], 30, ' '));
			srtBldr.append(StringUtils.repeat(" ", 70));

			srtBldr.append(lastDateOfPayment);

			rows.add(srtBldr.toString());
			rows.add(System.getProperty("line.separator"));
		}

		String basePath = applicationProperties.getResources().getBasePath();
		String fileLocation = basePath + File.separator
				+ Constants.BASE_DOWNLOAD_DIR + File.separator
				+ Constants.CHALLAN_SEND_AS_EMAIL;
		String reportNameWithPath = fileLocation + File.separator + reportName;

		Iterator<String> iter = rows.iterator();
		BufferedWriter out = null;
		try {
			File file = new File(fileLocation);
			if (!file.exists()) {
				file.mkdirs();
			}
			if(iter.hasNext()){
			out = new BufferedWriter(new FileWriter(new File(reportNameWithPath), true));
			
			/*out.write(endDate.toString());
			out.write("Hello");*/
			
			while (iter.hasNext()) {
				String outputString = (String) iter.next();

				out.write(outputString);
			}
			

			out.close();
			
			}

		} catch (Exception e) {

		}
		
		
		return reportNameWithPath;
	}
	
	public void submitQueryList(Date startdate, Date endDate) throws ParseException, IOException{
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String parsedFromDate = formatter.format(startdate);
		String parsedtoDate = formatter.format(endDate);
		List<PaymentTransaction> listOfOPaymentTranscation = paymentTransactionService.findListPaymentTranscationNoBetweenDates(parsedFromDate, parsedtoDate);
		String reportName =parsedFromDate+"_to_"+parsedtoDate;
		paymentTransactionService.generateQueryApiResponse(listOfOPaymentTranscation,reportName);
		String reportLocation = applicationProperties.getResources().getBasePath()+ 
				File.separator + Constants.BASE_DOWNLOAD_DIR + File.separator + Constants.ONLINE_QUERY_API_BASE_DIR;
		sendEmailService.sendingPaymentReportAsEmail(reportLocation+File.separator+reportName+"onlineQueryApiResp.xlsx");
	}
	
	/*@Override
	public List<String> getChallanDataRows(Date startDate, Date endDate){
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		
		String parsedFromDate = formatter.format(startDate);
		String parsedtoDate = formatter.format(endDate);
		
		List<Object[]> challanDataList = downloadChallanData(parsedFromDate,
				parsedtoDate);
		
		List<String> rows = new ArrayList<String>();

		StringBuilder srtBldr = null;

		String paymentDate = systemSettingService
				.getSystemSetting(SystemSettingEnum.OFFLINE_LAST_DATE_OF_PAYMENT);
		LocalDate localDate = LocalDate.parse(
				paymentDate != null ? paymentDate : LocalDate.now().format(
						DateTimeFormatter.ofPattern("dd/MM/yyyy")),
				DateTimeFormatter.ofPattern("dd/MM/yyyy").withLocale(
						Locale.ENGLISH));
		String lastDateOfPayment = localDate.format(DateTimeFormatter
				.ofPattern("ddMMyyyy"));

		for (Object obj[] : challanDataList) {
			StringBuilder postIdBuilder = new StringBuilder();

			String challanNumber = (String) obj[1];
			srtBldr = new StringBuilder();

			srtBldr.append(StringUtils.leftPad((String) obj[0], 6, '0'));
			srtBldr.append(StringUtils.leftPad((String) obj[1], 20, '0'));

			DateTimeFormatter formatteDate = DateTimeFormatter
					.ofPattern("ddMMyyyy");
			String formattedDateTime = ((LocalDate) obj[2])
					.format(formatteDate);

			srtBldr.append(formattedDateTime);
			srtBldr.append(StringUtils.leftPad((String) obj[3], 17, '0'));
			srtBldr.append(StringUtils.leftPad((String) obj[4].toString()
					+ "000", 17, '0'));
			srtBldr.append(StringUtils.leftPad((String) obj[5], 5, '0'));

			String applicantName = (String) obj[6];

			if (applicantName.length() > 30) {
				applicantName = applicantName.substring(0, 30);
			}

			srtBldr.append(StringUtils.rightPad(applicantName, 30, ' '));
			srtBldr.append(StringUtils.rightPad(postIdBuilder.toString(), 30,
					' '));

			String casteTitle = obj[7].toString();
			srtBldr.append(StringUtils.rightPad(casteTitle, 30, ' '));
			srtBldr.append(StringUtils.rightPad((String) obj[8], 30, ' '));
			srtBldr.append(StringUtils.repeat(" ", 70));

			srtBldr.append(lastDateOfPayment);

			rows.add(srtBldr.toString());
			rows.add(System.getProperty("line.separator"));
		}
		
		return rows;
		
	}*/

}

