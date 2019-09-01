package com.msrtc.portal.payment.service;

import com.msrtc.portal.applicant.domain.Applicant;
import com.msrtc.portal.applicant.domain.ApplicantPostAssoc;
import com.msrtc.portal.payment.domain.PaymentTransaction;
import com.msrtc.portal.payment.dto.OnlineQueryApiResponse;
import com.msrtc.portal.payment.dto.PaymentTransactionResponse;

import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

public interface PaymentTransactionService {

    void savePaymentTransaction(List<ApplicantPostAssoc> postsAppliedFor, PaymentTransaction paymentTransaction);

    PaymentTransactionResponse processPaymentTransactionResponse(String paymentResponse);

    void updatePaymentStatusOfPostsWithOrderNo(String orderNO, int status);

    PaymentTransactionResponse parsePaymentTransactionResponse(String paymentResponseStr);

    boolean isChecksumValid(String paymentResponseStr, String checksumValueFromResponse);
    
    PaymentTransaction findPaymentTransactionByOrderNo(String orderNo);

    Long countByPaymentMode(int paymentMode);

    BigDecimal findTotalAmountByPaymentMode(int paymentMode);
    
    String findAdmitCardURLByPostIdAndApplicantId(Long postId,Long applicantId,Integer systemDriveId );

    void updateOfflinePaymentTransactionStatus(String orderNo, BigDecimal txnAmount, int status);

    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
    void updateOfflinePaymentTransactionStatus(List<String> orderNos, BigDecimal txnAmount, int status);

    OnlineQueryApiResponse getOnlineQueryResponse(String orderNo);

    void updatePaymentTransactionStatusWithOrderNo(String orderNo, int status);
    
    Long countByPaymentModeAndStatus(int paymentMode, int status);
    
    BigDecimal findTotalAmountByPaymentModeAndStatus(int paymentMode, int status);

    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
    void updatePaymentStatusOfPostsWithOrderNo(List<String> orderNOs, int status);

    List<String> findByOrderNos(List<String> orderNos);

    List<Object[]> findApplicantDetailsByOrderNos(List<String> orderNos);

    List<PaymentTransaction> findAllPaymentsDoneByApplicant(Long applicantid);

    BigDecimal findTotalOfflineAmountByPaymentModeAndStatusBetweenDates(int paymentMode, int status,String fromDate, String toDate);
    
    BigDecimal findTotalOnlineAmountByPaymentModeAndStatusBetweenDates(int paymentMode, int status,String fromDate, String toDate);
    
    List<PaymentTransaction> findPendingOfflinePaymentsBetweenDates(int paymentMode,int status, String fromDate, String toDate);
    
    void updateOfflinePaymentTransactionOrderNo(String oldOrderNo, String newOrderNo);

    void handleServerToServerPaymentResponse(String msg);
    
    List<OnlineQueryApiResponse> getListOnlineQueryResponse(List<String> orderNo, List<PaymentTransaction> listOfPaymentTrancation);
    
    List<PaymentTransaction> findListPaymentTranscationNoBetweenDates(String fromDate,String toDate);
    
    String generateonlineQueryApiResponseExcel(List<OnlineQueryApiResponse> onlineQueryApiResponses, String reportName) throws IOException;
    
   // void generateQueryApiResponse(List<String> orderNoList);
    
    void generateQueryApiResponse(List<PaymentTransaction> listOfPaymentTransaction, String reportName);
    
    void generateQueryApiResponse2(List<PaymentTransaction> listOfPaymentTransaction, String reportName, HttpServletResponse response);
}

