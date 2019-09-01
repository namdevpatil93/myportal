package com.msrtc.portal.payment.repository;

import com.msrtc.portal.applicant.domain.Applicant;
import com.msrtc.portal.core.common.repository.BaseRepository;
import com.msrtc.portal.payment.domain.PaymentTransaction;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.math.BigDecimal;
import java.util.List;

public interface PaymentTransactionRepository extends BaseRepository<PaymentTransaction, Long> {

    @Modifying(clearAutomatically = true)
    @Query("Update PaymentTransaction " +
            "set status = :status, " +
            "responseMessage=:responseMessage, " +
            "txnReferenceNo=:txnReferenceNo, " +
            "authStatus=:authStatus " +
            "where status=0 and orderNo=:orderNo and amount=:txnAmount")
    void updatePaymentTransactionStatus(@Param("orderNo") String orderNo,
                                        @Param("txnAmount") BigDecimal txnAmount,
                                        @Param("status") int status,
                                        @Param("responseMessage")String responseMessage,
                                        @Param("txnReferenceNo")String txnReferenceNo,
                                        @Param("authStatus")String authStatus);

    @Modifying(clearAutomatically = true)
    @Query("Update PaymentTransaction " +
            "set status = :status " +
            "where orderNo=:orderNo")
    void updatePaymentTransactionStatus(@Param("orderNo") String orderNo,
                                        @Param("status") int status);

    PaymentTransaction findPaymentTransactionByOrderNo(String orderNo);

    Long countByPaymentMode(int paymentMode);
    Long countByPaymentModeAndStatus(int paymentMode, int status);

    @Query("select sum(amount) from PaymentTransaction pt where pt.paymentMode = :paymentMode")
    BigDecimal findTotalAmountByPaymentMode(@Param("paymentMode") int paymentMode);

    @Modifying(clearAutomatically = true)
    @Query("Update PaymentTransaction " +
            "set status = :status " +
            "where status=0 and orderNo=:orderNo")
    void updateOfflinePaymentTransactionStatus(@Param("orderNo") String orderNo,
                                        @Param("status") int status);
    
    @Query("select sum(amount) from PaymentTransaction pt where pt.paymentMode = :paymentMode and pt.status = :status")
    BigDecimal findTotalAmountByPaymentModeAndStatus(@Param("paymentMode") int paymentMode, @Param("status") int status);
    
    List<PaymentTransaction> findPaymentTransactionByapplicantId(Long applicantId);

    @Modifying(clearAutomatically = true)
    @Query("Update PaymentTransaction " +
            "set status = :status " +
            "where status=0 and orderNo in :orderNos")
    void updateOfflinePaymentTransactionStatus(@Param("orderNos") List<String> orderNos,
                                               @Param("status") int status);

    @Query("select orderNo from PaymentTransaction pt where pt.orderNo in :orderNos")
    List<String> findByOrderNos(@Param("orderNos") List<String> orderNos);

    @Query(value = "SELECT a.first_name, a.last_name, a.email_address, a.mobile_number, a.application_id, pt.amount, pt.order_no FROM payment_transactions pt LEFT JOIN applicants a ON pt.applicant_id = a.id  where pt.order_no in :orderNos", nativeQuery = true)
    List<Object[]> findApplicantDetailsByOrderNos(@Param("orderNos") List<String> orderNos);
    
    @Query(value="select sum(amount) from payment_transactions pt, applicant_post_assoc apa where pt.order_no = apa.txn_order_no and pt.payment_mode = :paymentMode and pt.status = :status AND CONVERT(apa.submitted_date, DATE) BETWEEN CONVERT(:fromDate, DATE) AND CONVERT(:toDate, DATE)", nativeQuery = true)
    BigDecimal findTotalAmountByPaymentModeAndStatusBetweenDates(@Param("paymentMode") int paymentMode, @Param("status") int status, @Param("fromDate") String fromDate, @Param("toDate") String toDate);

    @Query(value="select sum(pt.amount) from payment_transactions pt where pt.payment_mode = :paymentMode and pt.status = :status AND CONVERT(pt.created_date, DATE) BETWEEN CONVERT(:fromDate, DATE) AND CONVERT(:toDate, DATE)", nativeQuery = true)
    BigDecimal findTotalOnlineAmountByPaymentModeAndStatusBetweenDates(@Param("paymentMode") int paymentMode, @Param("status") int status, @Param("fromDate") String fromDate, @Param("toDate") String toDate);

    @Query(value="SELECT SUM(amnt) FROM (SELECT DISTINCT(pt.id), amount AS amnt FROM payment_transactions pt LEFT JOIN applicant_post_assoc apa ON pt.order_no =  apa.txn_order_no WHERE pt.payment_mode = :paymentMode and pt.status = :status  AND CONVERT(apa.submitted_date, DATE) BETWEEN CONVERT(:fromDate, DATE) AND CONVERT(:toDate, DATE)) AS temp", nativeQuery = true)
    BigDecimal findTotalOfflineAmountByPaymentModeAndStatusBetweenDates(@Param("paymentMode") int paymentMode, @Param("status") int status, @Param("fromDate") String fromDate, @Param("toDate") String toDate);

    List<PaymentTransaction> findByApplicantId(Long applicantId);
    
    @Query(value="Select * from payment_transactions pt where pt.payment_mode = :paymentMode and pt.status = :status AND CONVERT(pt.created_date, DATE) BETWEEN CONVERT(:fromDate, DATE) AND CONVERT(:toDate, DATE)", nativeQuery = true)
    List<PaymentTransaction> findPendingOfflinePaymentsBetweenDates(@Param("paymentMode") int paymentMode, @Param("status") int status, @Param("fromDate") String fromDate, @Param("toDate") String toDate);
    
    @Modifying(clearAutomatically = true)
    @Query(value = "Update PaymentTransaction set orderNo = :newOrderNo where orderNo = :oldOrderNo")
    void updateOfflinePaymentTransactionOrderNo(@Param("oldOrderNo") String oldOrderNo, @Param("newOrderNo") String newOrderNo);
    
    @Query(value = "SELECT  DISTINCT eaa.admit_card_url FROM ep_exam_applicant_assoc eaa JOIN  ep_exams e  ON e.id = eaa.exam_id JOIN  ep_exam_post_assoc epa ON epa.exam_id=eaa.exam_id WHERE epa.post_id  =:postId AND e.drive_id =:systemDriveId AND eaa.applicant_id =:applicantId AND e.active = 1 ORDER BY e.`id` LIMIT 1", nativeQuery = true)
    String findAdmitCardURLByPostIdAndApplicantId(@Param("postId") Long postId, @Param("applicantId") Long applicantId,@Param("systemDriveId") Integer systemDriveId);
    
    @Query(value="SELECT * FROM payment_transactions WHERE status IN (0) AND created_date BETWEEN :fromdate AND :toDate", nativeQuery=true)
    List<PaymentTransaction> findListPaymentTranscationNoBetweenDates(@Param("fromdate") String fromDate,@Param("toDate") String toDate);
}
