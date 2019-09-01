package com.msrtc.portal.payment.service.impl;

import com.msrtc.portal.applicant.domain.Applicant;
import com.msrtc.portal.applicant.domain.ApplicantPostAssoc;
import com.msrtc.portal.applicant.domain.StatusEnum;
import com.msrtc.portal.applicant.service.ApplicantService;
import com.msrtc.portal.core.common.util.Constants;
import com.msrtc.portal.core.common.util.ExcelWriterUtils;
import com.msrtc.portal.core.common.util.FileUtils;
import com.msrtc.portal.core.common.util.HttpUtils;
import com.msrtc.portal.core.config.ApplicationProperties;
import com.msrtc.portal.email.service.SendEmailService;
import com.msrtc.portal.payment.domain.AuthStatusEnum;
import com.msrtc.portal.payment.domain.PaymentTransaction;
import com.msrtc.portal.payment.domain.PaymentTransactionStatusEnum;
import com.msrtc.portal.payment.domain.RefundStatusEnum;
import com.msrtc.portal.payment.dto.OnlineQueryApiResponse;
import com.msrtc.portal.payment.dto.PaymentTransactionResponse;
import com.msrtc.portal.payment.repository.PaymentTransactionRepository;
import com.msrtc.portal.payment.service.PaymentTransactionService;
import com.msrtc.portal.payment.util.ChecksumUtils;
import com.msrtc.portal.sms.service.SentSMSService;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

import javax.servlet.http.HttpServletResponse;

@Service(value = "paymentTransactionService")
@Transactional(readOnly = true)
public class PaymentTransactionServiceImpl implements PaymentTransactionService {

	private final Logger log = LoggerFactory.getLogger(getClass());

    @Autowired
    private PaymentTransactionRepository paymentTransactionRepository;

    @Autowired
    private ApplicationProperties applicationProperties;

    @Autowired
    private ApplicantService applicantService;

    @Autowired
    private SendEmailService sendEmailService;

    @Autowired
    private SentSMSService sentSMSService;

    //int count =1;
    
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
    public void savePaymentTransaction(List<ApplicantPostAssoc> postsAppliedFor, PaymentTransaction paymentTransaction){
        log.debug("saving a payment transaction for applicant id", paymentTransaction.getApplicantId());
        paymentTransactionRepository.save(paymentTransaction);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
    public PaymentTransactionResponse processPaymentTransactionResponse(String paymentResponseStr){
        paymentResponseStr = paymentResponseStr != null ? paymentResponseStr.trim() : "";
        PaymentTransactionResponse paymentTransactionResponse = parsePaymentTransactionResponse(paymentResponseStr);
        if(paymentTransactionResponse != null){

            log.info("Response string returned from the Billdesk : "+ paymentResponseStr);
            log.info("Checksum value in the Billdesk Response : ["+ paymentTransactionResponse.getChecksum() + "]");

            boolean isChecksumValid = isChecksumValid(paymentResponseStr, paymentTransactionResponse.getChecksum());

            log.info("Is checksum valid : " + isChecksumValid);
            log.info("Payment Transaction Response : " + paymentTransactionResponse );

            if(isChecksumValid){
                BigDecimal txnAmount = new BigDecimal(paymentTransactionResponse.getTxnAmount());
                int intTxnAmount = txnAmount != null ? txnAmount.intValue() : 0;
                int status = PaymentTransactionStatusEnum.FAILURE.getId();

                if(paymentTransactionResponse.getAuthStatus().equals(AuthStatusEnum.S_0300.getStatus())){
                    status = PaymentTransactionStatusEnum.SUCCESS.getId();
                    updatePaymentStatusOfPostsWithOrderNo(paymentTransactionResponse.getOrderNo(), StatusEnum.SUBMITTED.getId());
                }

                paymentTransactionRepository.updatePaymentTransactionStatus(paymentTransactionResponse.getOrderNo(),
                        new BigDecimal(intTxnAmount), status, paymentTransactionResponse.getErrorDescription(),
                        paymentTransactionResponse.getTxnReferenceNo(), paymentTransactionResponse.getAuthStatus());
            }
        }
        return paymentTransactionResponse;
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
    public void updatePaymentStatusOfPostsWithOrderNo(String orderNO, int status) {
/*
        List<ApplicantPostAssoc> postsAppliedFor = applicantService.findByTxnOrderNo(orderNO);

        if(postsAppliedFor != null && postsAppliedFor.size() > 0){
            for(ApplicantPostAssoc postAppliedFor : postsAppliedFor){
                postAppliedFor.setStatus((long) status);
                postAppliedFor.setSubmittedDate(LocalDate.now());
                applicantService.saveApplicantPostAssoc(postAppliedFor);
            }
        }
*/
        applicantService.updateStatusByTxnOrderNo(Long.valueOf(StatusEnum.SUBMITTED.getId()), orderNO);
    }

    @Override
    public PaymentTransactionResponse parsePaymentTransactionResponse(String paymentResponseStr) {
        if(!StringUtils.isEmpty(paymentResponseStr)){

            paymentResponseStr = paymentResponseStr != null ? paymentResponseStr.trim() : "";

            PaymentTransactionResponse paymentTransactionResponse = new PaymentTransactionResponse();

            String[] paymentResponseArray = paymentResponseStr.split("[|]");

            paymentTransactionResponse.setMerchantId(paymentResponseArray[0]);
            paymentTransactionResponse.setOrderNo(paymentResponseArray[1]);
            paymentTransactionResponse.setTxnReferenceNo(paymentResponseArray[2]);
            paymentTransactionResponse.setTxnAmount(paymentResponseArray[4]);
            paymentTransactionResponse.setAuthStatus(paymentResponseArray[14]);
            paymentTransactionResponse.setMobileNo(paymentResponseArray[16]);
            paymentTransactionResponse.setEmailAddress(paymentResponseArray[17]);
            paymentTransactionResponse.setErrorDescription(paymentResponseArray[24]);
            paymentTransactionResponse.setChecksum(paymentResponseArray[25]);

            return paymentTransactionResponse;
        } else {
            return null;
        }

    }

    @Override
    public boolean isChecksumValid(String paymentResponseStr, String checksumValueFromResponse){
        paymentResponseStr = paymentResponseStr != null ? paymentResponseStr.trim() : "";
        String checksumKey = applicationProperties.getBillDeskPaymentGateway().getChecksumKey();
        int lastIndexOfBar = paymentResponseStr.lastIndexOf('|');
        String responseStrWithoutChecksum = paymentResponseStr.substring(0, lastIndexOfBar);
        String checksumGeneratedAtOurEnd  = ChecksumUtils.HmacSHA256(responseStrWithoutChecksum, checksumKey);

        if(StringUtils.isEmpty(checksumGeneratedAtOurEnd)){
            return false;
        }

        return checksumGeneratedAtOurEnd.equals(checksumValueFromResponse);
    }

	@Override
	public PaymentTransaction findPaymentTransactionByOrderNo(String orderNo) {
		return paymentTransactionRepository.findPaymentTransactionByOrderNo(orderNo);
	}

	@Override
    public Long countByPaymentMode(int paymentMode){
        log.debug("finding no. of transactions by payment mode", paymentMode);
        return paymentTransactionRepository.countByPaymentMode(paymentMode);
    }

    @Override
    public BigDecimal findTotalAmountByPaymentMode(int paymentMode){
        log.debug("finding total amount of transactions by payment mode", paymentMode);
        return paymentTransactionRepository.findTotalAmountByPaymentMode(paymentMode);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
    public void updateOfflinePaymentTransactionStatus(String orderNo, BigDecimal txnAmount, int status){
        log.debug("updating offline payment transaction Status for order no", orderNo);
        paymentTransactionRepository.updateOfflinePaymentTransactionStatus(orderNo, status );
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
    public void updateOfflinePaymentTransactionStatus(List<String> orderNos, BigDecimal txnAmount, int status){
        log.debug("updating offline payment transaction Status for order nos", orderNos);
        paymentTransactionRepository.updateOfflinePaymentTransactionStatus(orderNos, status );
    }

    @Override
    public OnlineQueryApiResponse getOnlineQueryResponse(String orderNo){
        OnlineQueryApiResponse onlineQueryApiResponse = new OnlineQueryApiResponse();

        String requestType = "0122";
        String merchantId = applicationProperties.getBillDeskPaymentGateway().getMerchantId();

        LocalDateTime now = LocalDateTime.now();
        String timestamp = String.valueOf(now.getYear())
                + String.valueOf(now.getMonthValue())
                + String.valueOf(now.getDayOfMonth())
                + String.valueOf(now.getHour())
                + String.valueOf(now.getMinute())
                + String.valueOf(now.getSecond());

        StringBuilder msg = new StringBuilder();
        msg.append(requestType);
        msg.append("|");
        msg.append(merchantId);
        msg.append("|");
        msg.append(orderNo);
        msg.append("|");
        msg.append(timestamp);

        String checksumKey = applicationProperties.getBillDeskPaymentGateway().getChecksumKey();
        String checksum = ChecksumUtils.HmacSHA256(msg.toString(), checksumKey);

        msg.append("|");
        msg.append(checksum);

        Map<String, String> params = new HashMap<>();

        params.put("msg", msg.toString());

        String queryApiURL = "https://www.billdesk.com/pgidsk/PGIQueryController";//applicationProperties.getBillDeskPaymentGateway().getQueryApiUrl();

        try {
            String response = HttpUtils.sendPostRequest(queryApiURL, Collections.<String, String>emptyMap(), params);

            if(!StringUtils.isEmpty(response)){
                String[] onlineQueryApiResponseArray = response.split("[|]");
                onlineQueryApiResponse.setRequestType(onlineQueryApiResponseArray[0]);
                onlineQueryApiResponse.setMerchantID(onlineQueryApiResponseArray[1]);
                onlineQueryApiResponse.setOrderNo(onlineQueryApiResponseArray[2]);
                onlineQueryApiResponse.setTxnReferenceNo(onlineQueryApiResponseArray[3]);
                onlineQueryApiResponse.setTxnAmount(onlineQueryApiResponseArray[5]);
                onlineQueryApiResponse.setAuthStatus(onlineQueryApiResponseArray[15]);
                onlineQueryApiResponse.setMobile(onlineQueryApiResponseArray[17]);
                onlineQueryApiResponse.setEmail(onlineQueryApiResponseArray[18]);
                onlineQueryApiResponse.setErrorStatus(onlineQueryApiResponseArray[24]);
                onlineQueryApiResponse.setErrorDescription(onlineQueryApiResponseArray[25]);
                onlineQueryApiResponse.setRefundStatus(onlineQueryApiResponseArray[27]);
                onlineQueryApiResponse.setQueryStatus(onlineQueryApiResponseArray[31]);
                onlineQueryApiResponse.setChecksum(onlineQueryApiResponseArray[32]);

                // Payment status (0300) is success and is currently not refunded or cancelled (NA).
                if( onlineQueryApiResponse.getRefundStatus().equals(RefundStatusEnum.S_NA.getStatus())
                        && onlineQueryApiResponse.getAuthStatus().equals(AuthStatusEnum.S_0300.getStatus())){
                    onlineQueryApiResponse.setSuccess(Boolean.TRUE);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return onlineQueryApiResponse;
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
    public void updatePaymentTransactionStatusWithOrderNo(String orderNo, int status){
        paymentTransactionRepository.updatePaymentTransactionStatus(orderNo, status);
    }
    
    @Override
    public Long countByPaymentModeAndStatus(int paymentMode, int status){
        log.debug("finding no. of transactions by payment mode and status", paymentMode, status);
        return paymentTransactionRepository.countByPaymentModeAndStatus(paymentMode, status);
    }
    
    @Override
    public BigDecimal findTotalAmountByPaymentModeAndStatus(int paymentMode, int status){
        log.debug("finding total amount of transactions by payment mode and status", paymentMode, status);
        return paymentTransactionRepository.findTotalAmountByPaymentModeAndStatus(paymentMode, status);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
    public void updatePaymentStatusOfPostsWithOrderNo(List<String> orderNOs, int status) {
        applicantService.updateStatusByTxnOrderNo(Long.valueOf(StatusEnum.SUBMITTED.getId()), orderNOs);
    }

    @Override
    public List<String> findByOrderNos(List<String> orderNos){
        return  paymentTransactionRepository.findByOrderNos(orderNos);
    }

    @Override
    public List<Object[]> findApplicantDetailsByOrderNos(List<String> orderNos){
        return paymentTransactionRepository.findApplicantDetailsByOrderNos(orderNos);
    }

    @Override
    public List<PaymentTransaction> findAllPaymentsDoneByApplicant(Long applicantId){
        return paymentTransactionRepository.findByApplicantId(applicantId);
    }


    @Override
    public BigDecimal findTotalOfflineAmountByPaymentModeAndStatusBetweenDates(int paymentMode, int status,String fromDate, String toDate){
    	log.debug("finding total amount of transactions by payment mode and status between dates", paymentMode, status, fromDate, toDate);
        return paymentTransactionRepository.findTotalOfflineAmountByPaymentModeAndStatusBetweenDates(paymentMode, status, fromDate, toDate);
    }

    @Override
    public BigDecimal findTotalOnlineAmountByPaymentModeAndStatusBetweenDates(int paymentMode, int status,String fromDate, String toDate){
    	log.debug("finding total online amount of transactions by payment mode and status between dates", paymentMode, status, fromDate, toDate);
        return paymentTransactionRepository.findTotalOnlineAmountByPaymentModeAndStatusBetweenDates(paymentMode, status, fromDate, toDate);
    }

	@Override
	public List<PaymentTransaction> findPendingOfflinePaymentsBetweenDates(int paymentMode, int status, String fromDate, String toDate) {
		log.debug("finding offline pending transactions by payment mode and status between dates", paymentMode, status, fromDate, toDate);
		return paymentTransactionRepository.findPendingOfflinePaymentsBetweenDates(paymentMode, status, fromDate, toDate);
	}
	
	@Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
	public void updateOfflinePaymentTransactionOrderNo(String oldOrderNo, String newOrderNo){
        log.debug("updating offline payment transaction order no for order nos", oldOrderNo);
        paymentTransactionRepository.updateOfflinePaymentTransactionOrderNo(oldOrderNo, newOrderNo);
    }

	@Override
	public String findAdmitCardURLByPostIdAndApplicantId(Long postId, Long applicantId, Integer systemDriveId) {
		return paymentTransactionRepository.findAdmitCardURLByPostIdAndApplicantId(postId,applicantId,systemDriveId);
	}

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
    public void handleServerToServerPaymentResponse(String msg) {
        PaymentTransactionResponse paymentTransactionResponse = processPaymentTransactionResponse(msg);
        Applicant applicant = applicantService.findApplicantByEmailAddress(paymentTransactionResponse.getEmailAddress());
        if(applicant != null){
            if(paymentTransactionResponse.getAuthStatus().equals(AuthStatusEnum.S_0300.getStatus())){
                // Send successful mail in online payment status is 'SUCCESS'
                sendEmailService.sendSuccessfulPaymentEmail(applicant, paymentTransactionResponse);
                // Send sms in online payment status 'SUCCESS'
                sentSMSService.sendSuccessfulOnlinePaymentSMS(applicant.getMobileNumber(), applicant.getFirstName());
            } else {
                // Send unsuccessful mail in online payment status is 'FAILED'
                sendEmailService.sendFailedPaymentEmail(applicant, paymentTransactionResponse);
            }
        }
    }
    
    public List<OnlineQueryApiResponse> getListOnlineQueryResponse(List<String> orderNoList, List<PaymentTransaction> listofPaymentTranscation){
		
    	List<OnlineQueryApiResponse> listOfQueryApiResponse = new ArrayList<OnlineQueryApiResponse>();
    	for (PaymentTransaction paymentTransaction : listofPaymentTranscation) {
			
		
    	OnlineQueryApiResponse onlineQueryApiResponse = new OnlineQueryApiResponse();

        String requestType = "0122";
        String merchantId = applicationProperties.getBillDeskPaymentGateway().getMerchantId();

        LocalDateTime now = LocalDateTime.now();
        String timestamp = String.valueOf(now.getYear())
                + String.valueOf(now.getMonthValue())
                + String.valueOf(now.getDayOfMonth())
                + String.valueOf(now.getHour())
                + String.valueOf(now.getMinute())
                + String.valueOf(now.getSecond());

        StringBuilder msg = new StringBuilder();
        msg.append(requestType);
        msg.append("|");
        msg.append(merchantId);
        msg.append("|");
        msg.append(paymentTransaction.getOrderNo());
        msg.append("|");
        msg.append(timestamp);

        String checksumKey = applicationProperties.getBillDeskPaymentGateway().getChecksumKey();
        String checksum = ChecksumUtils.HmacSHA256(msg.toString(), checksumKey);

        msg.append("|");
        msg.append(checksum);

        Map<String, String> params = new HashMap<>();

        params.put("msg", msg.toString());

        String queryApiURL = "https://www.billdesk.com/pgidsk/PGIQueryController";//applicationProperties.getBillDeskPaymentGateway().getQueryApiUrl();

        try {
            String response = HttpUtils.sendPostRequest(queryApiURL, Collections.<String, String>emptyMap(), params);

            if(!StringUtils.isEmpty(response)){
                String[] onlineQueryApiResponseArray = response.split("[|]");
                onlineQueryApiResponse.setRequestType(onlineQueryApiResponseArray[0]);
                onlineQueryApiResponse.setMerchantID(onlineQueryApiResponseArray[1]);
                onlineQueryApiResponse.setOrderNo(onlineQueryApiResponseArray[2]);
                onlineQueryApiResponse.setTxnReferenceNo(onlineQueryApiResponseArray[3]);
                onlineQueryApiResponse.setTxnAmount(onlineQueryApiResponseArray[5]);
                onlineQueryApiResponse.setAuthStatus(onlineQueryApiResponseArray[15]);
                onlineQueryApiResponse.setMobile(onlineQueryApiResponseArray[17]);
                onlineQueryApiResponse.setEmail(onlineQueryApiResponseArray[18]);
                onlineQueryApiResponse.setErrorStatus(onlineQueryApiResponseArray[24]);
                onlineQueryApiResponse.setErrorDescription(onlineQueryApiResponseArray[25]);
                onlineQueryApiResponse.setRefundStatus(onlineQueryApiResponseArray[27]);
                onlineQueryApiResponse.setQueryStatus(onlineQueryApiResponseArray[31]);
                onlineQueryApiResponse.setChecksum(onlineQueryApiResponseArray[32]);
                //Setting DB Status
                onlineQueryApiResponse.setDbApplicantionId(applicantService.findApplicationIdById(paymentTransaction.getApplicantId()));
                onlineQueryApiResponse.setDbAmount(paymentTransaction.getAmount());
                onlineQueryApiResponse.setDbauthStatus(paymentTransaction.getAuthStatus());
                onlineQueryApiResponse.setDbOrderNo(paymentTransaction.getOrderNo());
                onlineQueryApiResponse.setDbResponseMessage(paymentTransaction.getResponseMessage());
                onlineQueryApiResponse.setDbStatus(paymentTransaction.getStatus());
                onlineQueryApiResponse.setDbTxnReferenceNo(paymentTransaction.getTxnReferenceNo());
                // Payment status (0300) is success and is currently not refunded or cancelled (NA).
                if( onlineQueryApiResponse.getRefundStatus().equals(RefundStatusEnum.S_NA.getStatus())
                        && onlineQueryApiResponse.getAuthStatus().equals(AuthStatusEnum.S_0300.getStatus())){
                    onlineQueryApiResponse.setSuccess(Boolean.TRUE);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        listOfQueryApiResponse.add(onlineQueryApiResponse);
    	}
    	
    	return listOfQueryApiResponse;
    	
    }

	@Override
	public List<PaymentTransaction> findListPaymentTranscationNoBetweenDates(String fromDate,
			String toDate) {
		
		return paymentTransactionRepository.findListPaymentTranscationNoBetweenDates(fromDate, toDate);
	}
	
	public void generateQueryApiResponseExcel(List<String> orderNo){
		
	}
	
	
	public String generateonlineQueryApiResponseExcel(List<OnlineQueryApiResponse> onlineQueryApiResponses,String reportName) throws IOException{
		String reportLocation = applicationProperties.getResources().getBasePath()+ 
				File.separator + Constants.BASE_DOWNLOAD_DIR + File.separator + Constants.ONLINE_QUERY_API_BASE_DIR;
		File dir = new File(reportLocation);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        reportName = reportName+"onlineQueryApiResp.xlsx";
        String reportNameWithPath = reportLocation+ File.separator + reportName;
		XSSFWorkbook queryApiResponseExcel = ExcelWriterUtils.createWorkbook();
		Sheet sheet = ExcelWriterUtils.createSheet(queryApiResponseExcel, "queryApiResponseExcelSheet");
		Row row0 = ExcelWriterUtils.createRow(sheet, 0);
		Cell row0cell5 = ExcelWriterUtils.createCell(row0, 5, "Bill Desk Response", ExcelWriterUtils.getColoredCellStyle(queryApiResponseExcel, IndexedColors.ROSE.getIndex()));
		Cell row0cell11 = ExcelWriterUtils.createCell(row0, 11, "DataBase Response", ExcelWriterUtils.getColoredCellStyle(queryApiResponseExcel, IndexedColors.ROSE.getIndex()));
		
		Row row1 = ExcelWriterUtils.createRow(sheet, 1);
		Cell row1cell0 = ExcelWriterUtils.createCell(row1, 0, "Sr.No", ExcelWriterUtils.getBoldCellStyleLeftAligned(queryApiResponseExcel));
		Cell row1cell1 = ExcelWriterUtils.createCell(row1, 1, "Order No", ExcelWriterUtils.getBoldCellStyleLeftAligned(queryApiResponseExcel));
		Cell row1cell2 = ExcelWriterUtils.createCell(row1, 2, "Txn Reference No", ExcelWriterUtils.getBoldCellStyleLeftAligned(queryApiResponseExcel));
		Cell row1cell3 = ExcelWriterUtils.createCell(row1, 3, "Txn Amount", ExcelWriterUtils.getBoldCellStyleLeftAligned(queryApiResponseExcel));
		Cell row1cell4 = ExcelWriterUtils.createCell(row1, 4, "Auth Status", ExcelWriterUtils.getBoldCellStyleLeftAligned(queryApiResponseExcel));
		Cell row1cell5 = ExcelWriterUtils.createCell(row1, 5, "Refund Status", ExcelWriterUtils.getBoldCellStyleLeftAligned(queryApiResponseExcel));
		Cell row1cell6 = ExcelWriterUtils.createCell(row1, 6, "Mobile", ExcelWriterUtils.getBoldCellStyleLeftAligned(queryApiResponseExcel));
		Cell row1cell7 = ExcelWriterUtils.createCell(row1, 7, "Email", ExcelWriterUtils.getBoldCellStyleLeftAligned(queryApiResponseExcel));
		Cell row1cell8 = ExcelWriterUtils.createCell(row1, 8, "Error Status", ExcelWriterUtils.getBoldCellStyleLeftAligned(queryApiResponseExcel));
		Cell row1cell9 = ExcelWriterUtils.createCell(row1, 9, "Error Description", ExcelWriterUtils.getBoldCellStyleLeftAligned(queryApiResponseExcel));
		Cell row1cell11 = ExcelWriterUtils.createCell(row1, 11, "Application Id", ExcelWriterUtils.getColoredCellStyle(queryApiResponseExcel,IndexedColors.LIGHT_BLUE.getIndex()));
		Cell row1cell12 = ExcelWriterUtils.createCell(row1, 12, "Db Order No", ExcelWriterUtils.getBoldCellStyleLeftAligned(queryApiResponseExcel));
		Cell row1cell13 = ExcelWriterUtils.createCell(row1, 13, "Db Amount", ExcelWriterUtils.getBoldCellStyleLeftAligned(queryApiResponseExcel));
		Cell row1cell14 = ExcelWriterUtils.createCell(row1, 14, "Db Status", ExcelWriterUtils.getBoldCellStyleLeftAligned(queryApiResponseExcel));
		Cell row1cell15 = ExcelWriterUtils.createCell(row1, 15, "Db Auth Status", ExcelWriterUtils.getBoldCellStyleLeftAligned(queryApiResponseExcel));
		Cell row1cell16 = ExcelWriterUtils.createCell(row1, 16, "Db TxnReferenceNo", ExcelWriterUtils.getBoldCellStyleLeftAligned(queryApiResponseExcel));
		Cell row1cell17 = ExcelWriterUtils.createCell(row1, 17, "Db ResponseMessage", ExcelWriterUtils.getBoldCellStyleLeftAligned(queryApiResponseExcel));
		
		int count = 2;
		int srNo = 1;
		for (OnlineQueryApiResponse oqApiRespo : onlineQueryApiResponses) {
			
			if(oqApiRespo.getDbauthStatus() == null){
				oqApiRespo.setDbauthStatus("NA");
			}
			Row row = ExcelWriterUtils.createRow(sheet, count);
			Cell oqApiRcell0 = ExcelWriterUtils.createCell(row, 0,Integer.toString(srNo), ExcelWriterUtils.getDefaultCellStyleLeftAligned(queryApiResponseExcel));
			Cell oqApiRcell1 = ExcelWriterUtils.createCell(row, 1, oqApiRespo.getOrderNo(), ExcelWriterUtils.getDefaultCellStyleLeftAligned(queryApiResponseExcel));
			Cell oqApiRcell2 = ExcelWriterUtils.createCell(row, 2, oqApiRespo.getTxnReferenceNo(), ExcelWriterUtils.getDefaultCellStyleLeftAligned(queryApiResponseExcel));
			Cell oqApiRcell3 = ExcelWriterUtils.createCell(row, 3, oqApiRespo.getTxnAmount(), ExcelWriterUtils.getDefaultCellStyleLeftAligned(queryApiResponseExcel));
			Cell oqApiRcell4 = ExcelWriterUtils.createCell(row, 4, oqApiRespo.getAuthStatus(), ExcelWriterUtils.getDefaultCellStyleLeftAligned(queryApiResponseExcel));
			Cell oqApiRcell5 = ExcelWriterUtils.createCell(row, 5, oqApiRespo.getRefundStatus(), ExcelWriterUtils.getDefaultCellStyleLeftAligned(queryApiResponseExcel));
			Cell oqApiRcell6 = ExcelWriterUtils.createCell(row, 6, oqApiRespo.getMobile(), ExcelWriterUtils.getDefaultCellStyleLeftAligned(queryApiResponseExcel));
			Cell oqApiRcell7 = ExcelWriterUtils.createCell(row, 7, oqApiRespo.getEmail(), ExcelWriterUtils.getDefaultCellStyleLeftAligned(queryApiResponseExcel));
			Cell oqApiRcell8 = ExcelWriterUtils.createCell(row, 8, oqApiRespo.getErrorStatus(), ExcelWriterUtils.getDefaultCellStyleLeftAligned(queryApiResponseExcel));
			Cell oqApiRcell9 = ExcelWriterUtils.createCell(row, 9, oqApiRespo.getErrorDescription(), ExcelWriterUtils.getDefaultCellStyleLeftAligned(queryApiResponseExcel));
			if(oqApiRespo.getAuthStatus().equals(oqApiRespo.getDbauthStatus())){
			Cell oqApiRcell11 = ExcelWriterUtils.createCell(row, 11, oqApiRespo.getDbApplicantionId(), ExcelWriterUtils.getDefaultCellStyleLeftAligned(queryApiResponseExcel));
			Cell oqApiRcell12 = ExcelWriterUtils.createCell(row, 12, oqApiRespo.getDbOrderNo(), ExcelWriterUtils.getDefaultCellStyleLeftAligned(queryApiResponseExcel));
			Cell oqApiRcell13 = ExcelWriterUtils.createCell(row, 13, oqApiRespo.getDbAmount(), ExcelWriterUtils.getDefaultCellStyleLeftAligned(queryApiResponseExcel));
			Cell oqApiRcell14 = ExcelWriterUtils.createCell(row, 14, Integer.toString(oqApiRespo.getDbStatus()), ExcelWriterUtils.getDefaultCellStyleLeftAligned(queryApiResponseExcel));
			Cell oqApiRcell15 = ExcelWriterUtils.createCell(row, 15, oqApiRespo.getDbauthStatus(), ExcelWriterUtils.getDefaultCellStyleLeftAligned(queryApiResponseExcel));
			Cell oqApiRcell16 = ExcelWriterUtils.createCell(row, 16, oqApiRespo.getDbTxnReferenceNo(), ExcelWriterUtils.getDefaultCellStyleLeftAligned(queryApiResponseExcel));
			Cell oqApiRcell17 = ExcelWriterUtils.createCell(row, 17, oqApiRespo.getDbResponseMessage(), ExcelWriterUtils.getDefaultCellStyleLeftAligned(queryApiResponseExcel));
			}else{
				
			Cell oqApiRcell11 = ExcelWriterUtils.createCell(row, 11, oqApiRespo.getDbApplicantionId(), ExcelWriterUtils.getColoredCellStyle(queryApiResponseExcel,IndexedColors.LIGHT_ORANGE.getIndex()));
			Cell oqApiRcell12 = ExcelWriterUtils.createCell(row, 12, oqApiRespo.getDbOrderNo(), ExcelWriterUtils.getColoredCellStyle(queryApiResponseExcel,IndexedColors.LIGHT_ORANGE.getIndex()));
			Cell oqApiRcell13 = ExcelWriterUtils.createCell(row, 13, oqApiRespo.getDbAmount(), ExcelWriterUtils.getColoredCellStyle(queryApiResponseExcel,IndexedColors.LIGHT_ORANGE.getIndex()));
			Cell oqApiRcell14 = ExcelWriterUtils.createCell(row, 14, Integer.toString(oqApiRespo.getDbStatus()), ExcelWriterUtils.getColoredCellStyle(queryApiResponseExcel,IndexedColors.LIGHT_ORANGE.getIndex()));
			Cell oqApiRcell15 = ExcelWriterUtils.createCell(row, 15, oqApiRespo.getDbauthStatus(), ExcelWriterUtils.getColoredCellStyle(queryApiResponseExcel,IndexedColors.LIGHT_ORANGE.getIndex()));
			Cell oqApiRcell16 = ExcelWriterUtils.createCell(row, 16, oqApiRespo.getDbTxnReferenceNo(), ExcelWriterUtils.getColoredCellStyle(queryApiResponseExcel,IndexedColors.LIGHT_ORANGE.getIndex()));
			Cell oqApiRcell17 = ExcelWriterUtils.createCell(row, 17, oqApiRespo.getDbResponseMessage(), ExcelWriterUtils.getColoredCellStyle(queryApiResponseExcel,IndexedColors.LIGHT_ORANGE.getIndex()));
			
			}
			count++;
			srNo++;
		}
		
		FileOutputStream fileOut = new FileOutputStream(reportNameWithPath);
		queryApiResponseExcel.write(fileOut);
        fileOut.close();
        
		return reportNameWithPath;
        
	}
	
	public void generateQueryApiResponse(List<PaymentTransaction> listOfPaymentTransaction, String reportName){
		processList(listOfPaymentTransaction, reportName);
	}
	
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = { "java.lang.Exception" })
	private void processList(List<PaymentTransaction> listOfPaymentTransaction, String reportName){
		int noOfThreads = 1;
		
		int noOfOrders= listOfPaymentTransaction.size();
		
		if(noOfOrders >10){
			noOfThreads =4;
			
		}
		
		ExecutorService exec = Executors.newFixedThreadPool(noOfThreads);
		
		int minItemsPerThread = noOfOrders / noOfThreads;
		int start = 0;

		List<Future<?>> futures = new ArrayList<>(noOfOrders);
		
		for (int i = 0; i < noOfThreads; i++) {
			int end = start + minItemsPerThread;
			if (!listOfPaymentTransaction.subList(start, end).isEmpty()) {
				Runnable r = new Processor(listOfPaymentTransaction, reportName);
				futures.add(exec.submit(r));
			}
			start = end;
		}
		
		for (Future<?> f : futures) {
			try {
				f.get();
			} catch (InterruptedException e) {
				e.printStackTrace();
			} catch (ExecutionException e) {
				e.printStackTrace();
			}
		}

		exec.shutdown();
		
	}
	
	class Processor implements Runnable {

		private List<PaymentTransaction> listOfPaymentTransaction;
		private String reportName;
		public Processor( List<PaymentTransaction> listOfPaymentTransaction, String reportName) {
			this.listOfPaymentTransaction = listOfPaymentTransaction;
			this.reportName = reportName;
		}

		@Override
		public void run() {
			
			if(listOfPaymentTransaction != null && listOfPaymentTransaction.size()>0){
				List<String> orderNoList= new ArrayList<String>();
				for (PaymentTransaction paymentTransaction : listOfPaymentTransaction) {
					orderNoList.add(paymentTransaction.getOrderNo());
				}
			List<OnlineQueryApiResponse> listOfOnlineQueryApiResponse =getListOnlineQueryResponse(orderNoList,listOfPaymentTransaction);
			try {
				String fileNameWithPath = generateonlineQueryApiResponseExcel(listOfOnlineQueryApiResponse, reportName);
			} catch (IOException e) {
				
				e.printStackTrace();
			}
			}
			
		}
		
	}
//===============================================
	
	
	public void generateQueryApiResponse2(List<PaymentTransaction> listOfPaymentTransaction, String reportName, HttpServletResponse response){
		
		ExecutorService fixedPool = Executors.newFixedThreadPool(1);
		Runnable aRunnable = new Runnable(){

            @Override
            public void run() {
                
               

                if(listOfPaymentTransaction != null && !listOfPaymentTransaction.isEmpty()){
                	processList2(listOfPaymentTransaction, reportName , response);
                   
                }
            }
        };

        Future<?> runnableFuture = fixedPool.submit(aRunnable);
        try {
			runnableFuture.get();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ExecutionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        fixedPool.shutdown();
		
		
		
	}
	
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = { "java.lang.Exception" })
	private HttpServletResponse processList2(List<PaymentTransaction> listOfPaymentTransaction, String reportName , HttpServletResponse response){
		int noOfThreads = 1;
		
		int noOfOrders= listOfPaymentTransaction.size();
		
		if(noOfOrders >10){
			noOfThreads =noOfOrders/10;
			
		}
		
		ExecutorService exec = Executors.newFixedThreadPool(noOfThreads);
		
		int minItemsPerThread = noOfOrders / noOfThreads;
		int start = 0;

		
		
		List<Future<?>> futures = new ArrayList<>(noOfOrders);
		
		for (int i = 0; i < noOfThreads; i++) {
			int end = start + minItemsPerThread;
			if (!listOfPaymentTransaction.subList(start, end).isEmpty()) {
				Runnable r = new Processor2(listOfPaymentTransaction, reportName , response);
				futures.add(exec.submit(r));
			}
			start = end;
		}
		
		for (Future<?> f : futures) {
			try {
				f.get();
			} catch (InterruptedException e) {
				e.printStackTrace();
			} catch (ExecutionException e) {
				e.printStackTrace();
			}
		}
		
		exec.shutdown();
		return response;
		
	}
	
	class Processor2 implements Runnable {

		private List<PaymentTransaction> listOfPaymentTransaction;
		private String reportName;
		HttpServletResponse response;
		public Processor2( List<PaymentTransaction> listOfPaymentTransaction, String reportName, HttpServletResponse response) {
			this.listOfPaymentTransaction = listOfPaymentTransaction;
			this.reportName = reportName;
			this.response = response;
		}

		@Override
		public void run() {
			
			if(listOfPaymentTransaction != null && listOfPaymentTransaction.size()>0){
				List<String> orderNoList= new ArrayList<String>();
				for (PaymentTransaction paymentTransaction : listOfPaymentTransaction) {
					orderNoList.add(paymentTransaction.getOrderNo());
				}
			List<OnlineQueryApiResponse> listOfOnlineQueryApiResponse =getListOnlineQueryResponse(orderNoList,listOfPaymentTransaction);
			try {
				String fileNameWithPath = generateonlineQueryApiResponseExcel(listOfOnlineQueryApiResponse, reportName);
				FileUtils.downloadFile(response, fileNameWithPath, reportName, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
			} catch (IOException e) {
				
				e.printStackTrace();
			}
			}
			
		}
		
	}

	
	
    
	
}