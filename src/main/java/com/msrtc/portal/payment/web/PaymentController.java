package com.msrtc.portal.payment.web;

import com.msrtc.portal.applicant.domain.Applicant;
import com.msrtc.portal.applicant.domain.ApplicantPostAssoc;
import com.msrtc.portal.applicant.domain.StatusEnum;
import com.msrtc.portal.applicant.service.ApplicantService;
import com.msrtc.portal.core.common.util.CommonUtils;
import com.msrtc.portal.core.config.ApplicationProperties;
import com.msrtc.portal.core.systemsetting.service.SystemSettingService;
import com.msrtc.portal.core.systemsetting.util.SystemSettingEnum;
import com.msrtc.portal.core.user.security.SecurityUtils;
import com.msrtc.portal.email.service.SendEmailService;
import com.msrtc.portal.payment.domain.AuthStatusEnum;
import com.msrtc.portal.payment.domain.PaymentModeEnum;
import com.msrtc.portal.payment.domain.PaymentTransaction;
import com.msrtc.portal.payment.domain.PaymentTransactionStatusEnum;
import com.msrtc.portal.payment.dto.PaymentTransactionResponse;
import com.msrtc.portal.payment.service.PaymentTransactionService;
import com.msrtc.portal.payment.util.BillDeskConstants;
import com.msrtc.portal.payment.util.ChecksumUtils;
import com.msrtc.portal.sms.service.SentSMSService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

@Controller
@RequestMapping(value = { PaymentController.PaymentController })
public class PaymentController {

    private final Logger log = LoggerFactory.getLogger(getClass());

    static final String PaymentController = "/payment";

    @Autowired
    private ApplicantService applicantService;

    @Autowired
    private SystemSettingService systemSettingService;

    @Autowired
    private ApplicationProperties applicationProperties;

    @Autowired
    private PaymentTransactionService paymentTransactionService;

    @RequestMapping(params = "operation=showPayment")
    public String selectPaymentMode(Model model){
        Applicant applicant = SecurityUtils.getCurrentUser().getApplicant();

        // Getting all the posts with status = 1(SAVED) and status = 3(PENDING)
        List<ApplicantPostAssoc> postsAppliedFor = applicantService.findPostsAppliedForPayment(applicant.getId());

        /*if(postsAppliedFor != null && postsAppliedFor.size() > 0){
            postsAppliedFor.forEach(postAppliedFor-> {
                postAppliedFor.setPost(applicantService.findPostByPostId(postAppliedFor.getPostId()));
            });
        }*/

        model.addAttribute("postsAppliedFor", postsAppliedFor);
        return "selectPaymentMode";
    }
    
    @RequestMapping(params = "operation=makePayment")
    public String makePayment(Model model, HttpServletRequest request){
    	
        Applicant applicant = applicantService.findApplicantById(SecurityUtils.getCurrentUser().getApplicant().getId());
        int paymentMode = Integer.valueOf(request.getParameter("paymentMode"));
        String[] selectedPostAssocIds = request.getParameterValues("selectedPostAssocIds");
       ArrayList<Long> postId=new ArrayList<Long>();
        List<ApplicantPostAssoc> postsAppliedFor = new ArrayList<>();

        String orderID = applicantService.getRandomNo(); //UUID.randomUUID().toString();
        
        //Integer postFees=0;
        
        if(selectedPostAssocIds != null && selectedPostAssocIds.length > 0){
            for(String selectedPostAssocId : selectedPostAssocIds){
            	//Integer PostFessForSinglePost=0;
                ApplicantPostAssoc applicantPostAssoc = applicantService.findApplicantPostAssocByApplicantPostAssocIdWithDetails(Long.parseLong(selectedPostAssocId), 1);
                applicantPostAssoc.setStatus((long)StatusEnum.PENDING.getId());
                applicantPostAssoc.setTxnOrderNo(orderID);
                applicantService.saveApplicantPostAssoc(applicantPostAssoc);
                postId.add(applicantPostAssoc.getPostId());
                /*if(applicantPostAssoc.getAdvtNo()!=null && applicantPostAssoc.getAdvtNo()>0 && applicantPostAssoc.getAdvtNo()==2){
                	 PostFessForSinglePost=applicantService.getPostFeesAsPerAdvertisementNumber(applicant);
                }else{
                PostFessForSinglePost=applicantService.getPostFees(applicant) ;}
                postFees=postFees+PostFessForSinglePost;*/
                postsAppliedFor.add(applicantPostAssoc);
            }
        }
        List<Long> UniquePostType=applicantService.findUniquePostByPostType(postId);
        Integer postFees = applicantService.getPostFees(applicant) ;
		postFees = postFees * UniquePostType.size();
        
        if(paymentMode == PaymentModeEnum.ONLINE.getId()){

            BigDecimal txnAmount = new BigDecimal(postFees);
            // BigDecimal txnAmount = new BigDecimal(2);

            String msg = getPaymentRequestMessage(applicant, orderID, txnAmount, getReturnURL(request));

            String checksum = ChecksumUtils.HmacSHA256(msg, applicationProperties.getBillDeskPaymentGateway().getChecksumKey());
            msg = msg + BillDeskConstants.SEPARATOR + checksum;

            PaymentTransaction paymentTransaction = new PaymentTransaction(applicant.getId(), orderID, txnAmount, PaymentTransactionStatusEnum.PENDING.getId(), PaymentModeEnum.ONLINE.getId());
            paymentTransactionService.savePaymentTransaction(postsAppliedFor, paymentTransaction);

            model.addAttribute("msg", msg);
            model.addAttribute("billDeskURL", applicationProperties.getBillDeskPaymentGateway().getBillDeskURL());
            return "onlinePayment";
        } else {
            String feesType = systemSettingService.getSystemSetting(SystemSettingEnum.OFFLINE_PAYMENT_FEES_TYPE);
            String bankCharges = systemSettingService.getSystemSetting(SystemSettingEnum.OFFLINE_PAYMENT_BANK_CHARGES);

            BigDecimal totalFees = new BigDecimal(postFees).add(new BigDecimal(bankCharges));

            PaymentTransaction paymentTransaction = new PaymentTransaction(applicant.getId(), orderID, totalFees, PaymentTransactionStatusEnum.PENDING.getId(), PaymentModeEnum.OFFLINE.getId());
            paymentTransactionService.savePaymentTransaction(postsAppliedFor, paymentTransaction);

            model.addAttribute("feesType", feesType);
            model.addAttribute("bankCharges", bankCharges);
            model.addAttribute("postFees", postFees);
            model.addAttribute("totalFees", totalFees);
            model.addAttribute("applicant", applicant);
            model.addAttribute("applicantPostAssociation", postsAppliedFor);
            model.addAttribute("applicationNo", postsAppliedFor.iterator().next().getTxnOrderNo());
            model.addAttribute("challanDate", CommonUtils.getLocalDateFormat(LocalDate.now(), "dd/MM/yyyy"));
            //----------------  last date of payment implementation
            String  paymentDate = systemSettingService.getSystemSetting(SystemSettingEnum.OFFLINE_LAST_DATE_OF_PAYMENT);
	        String lastDateOfPayment = CommonUtils.getLocalDateFormat(LocalDate.parse(paymentDate !=null ? paymentDate : CommonUtils.getLocalDateFormat(LocalDate.now(), "dd/MM/yyyy")  , DateTimeFormatter.ofPattern("dd/MM/yyyy").withLocale(Locale.ENGLISH)), "dd/MM/yyyy");
	        model.addAttribute("lastDateOfPayment", lastDateOfPayment);
	        // ---------------------------------------------
            model.addAttribute("viewChallan", false);
            model.addAttribute("isOpenCategoryFeesApplicable", applicantService.isOpenCategoryFeesApplicable(applicant));
            
            return "offlinePayment";
        }
    }

    @RequestMapping(value = "/handlePaymentResponse")
    public String handlePaymentResponse(Model model, HttpServletRequest request) {
    	
        String msg = request.getParameter("msg");

        PaymentTransactionResponse paymentTransactionResponse = paymentTransactionService.parsePaymentTransactionResponse(msg);

        boolean isChecksumValid = paymentTransactionService.isChecksumValid(msg, paymentTransactionResponse.getChecksum());
        boolean txnFailed = true;

        if(isChecksumValid){
//            Applicant applicant = SecurityUtils.getCurrentUser().getApplicant();
//            BigDecimal txnAmount = new BigDecimal(paymentTransactionResponse.getTxnAmount());
            if(paymentTransactionResponse.getAuthStatus().equals(AuthStatusEnum.S_0300.getStatus())){
                //sendEmailService.sendSuccessfulPaymentEmail(applicant, paymentTransactionResponse);
                txnFailed = false;
             // Send sms in online payment status 'SUCCESS'
//                sentSMSService.sendSuccessfulOnlinePaymentSMS(applicant.getMobileNumber(), applicant.getFirstName());
                
            } 
//            else {
//                sendEmailService.sendFailedPaymentEmail(applicant, paymentTransactionResponse);
//            }
        }

        model.addAttribute("txnFailed", txnFailed);
        model.addAttribute("paymentTransactionResponse", paymentTransactionResponse);
        return "paymentResponse";
    }

    @RequestMapping(value="/handleServerToServerPaymentResponse")
    public void handleServerToServerPaymentResponse(HttpServletRequest request) {
        String msg = request.getParameter("msg");
        paymentTransactionService.handleServerToServerPaymentResponse(msg);
    }

    private String getPaymentRequestMessage(Applicant applicant, String orderID, BigDecimal txnAmount, String returnURL) {
        final String merchantId = applicationProperties.getBillDeskPaymentGateway().getMerchantId();
        final String securityId = applicationProperties.getBillDeskPaymentGateway().getSecurityId();

        return merchantId+"|"+orderID+"|"+"NA"+"|"+txnAmount+"|"+"NA"+"|"+"NA"+"|"+"NA"+"|"+
                BillDeskConstants.CURRENCY_TYPE +"|"+"NA"+"|"+BillDeskConstants.TYPE_FIELD_1 +"|"+securityId+"|"+"NA"+"|"+"NA"+"|"
                + BillDeskConstants.TYPE_FIELD_2 +"|" + applicant.getMobileNumber() +"|"+applicant.getEmailAddress() +"|"+"NA"+"|"
                +"NA"+"|"+"NA"+"|"+"NA"+"|"+"NA"+"|"+returnURL;
    }

    private String getReturnURL(HttpServletRequest request) {
        return request.getHeader("x-forwarded-proto")
                + "://"+request.getServerName()
                + request.getContextPath()
                + "/payment/handlePaymentResponse";
    }
}
