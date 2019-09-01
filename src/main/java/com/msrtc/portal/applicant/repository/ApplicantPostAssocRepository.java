package com.msrtc.portal.applicant.repository;

import com.msrtc.portal.applicant.domain.ApplicantPostAssoc;
import com.msrtc.portal.core.common.repository.BaseRepository;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import javax.transaction.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

public interface ApplicantPostAssocRepository extends BaseRepository<ApplicantPostAssoc, Long>, ApplicantPostAssocRepositoryCustom {

	List<ApplicantPostAssoc> findByApplicantId(Long applicantId);

	@Query("select postId from ApplicantPostAssoc where applicantId = :applicantId")
	List<Long> findApplicantPostAssocByApplicantId(@Param("applicantId") Long applicantId);

	void deleteByApplicantIdAndPostId(Long applicantId, Long postId);
	
	@Query("select apa from ApplicantPostAssoc as apa, Post as p where apa.applicantId = :applicantId and apa.postId = p.id order by p.postOrder ASC")
	List<ApplicantPostAssoc> findApplicantPostAssocsByApplicantIdOrderByPostCategory(@Param("applicantId") Long applicantId);

	List<ApplicantPostAssoc> findByTxnOrderNo(String txnOrderNo);
	
	@Query("from ApplicantPostAssoc where applicantId = :applicantId and status = :status")
	List<ApplicantPostAssoc> findApplicantPostAssocsByApplicantIdAndStatus(@Param("applicantId") Long applicantId, @Param("status") Long status);

	@Query("from ApplicantPostAssoc where applicantId = :applicantId and (status = 1 or status = 3)")
	List<ApplicantPostAssoc> findPostsAppliedForPayment(@Param("applicantId") Long applicantId);

	@Modifying(clearAutomatically = true)
	@Query("UPDATE ApplicantPostAssoc a SET a.status = :status, submittedDate = :submittedDate  WHERE a.txnOrderNo = :txnOrderNo")
	int updateStatusByTxnOrderNo(@Param("status") Long status, @Param("submittedDate") LocalDate submittedDate, @Param("txnOrderNo") String txnOrderNo);

	@Modifying(clearAutomatically = true)
	@Query("UPDATE ApplicantPostAssoc a SET a.status = :status, submittedDate = :submittedDate  WHERE a.txnOrderNo in :txnOrderNos")
	int updateStatusByTxnOrderNo(@Param("status") Long status, @Param("submittedDate") LocalDate submittedDate, @Param("txnOrderNos") List<String> txnOrderNos);

	@Query("select apa from ApplicantPostAssoc apa where apa.applicantId = :applicantId and apa.postId = :postId")
	ApplicantPostAssoc findApplicantPostAssocByApplicantIdAndPostId(@Param("applicantId") Long applicantId, @Param("postId") Long postId);

	@Modifying(clearAutomatically = true)
	@Query("UPDATE ApplicantPostAssoc a SET a.status = :status, submittedDate = :submittedDate, txnOrderNo = :txnOrderNo  WHERE a.id = :id")
	int markPostAsSubmitted(@Param("status") Long status, @Param("submittedDate") LocalDate submittedDate, @Param("txnOrderNo") String txnOrderNo, @Param("id") Long postAssocId);
	
	Long countByStatusAndTxnOrderNo(Long status, String orderNo);
	
	@Modifying(clearAutomatically = true)
    @Query(value = "Update ApplicantPostAssoc set txnOrderNo = :newOrderNo where txnOrderNo = :oldOrderNo")
	void updateApplicantPostAssocTransactionOrderNo(@Param("oldOrderNo") String oldOrderNo, @Param("newOrderNo") String newOrderNo);

	@Modifying
	@Query("UPDATE ApplicantPostAssoc apa SET apa.pdfGenerated = 1 WHERE apa.applicantId = :applicantId and apa.postId = :postId")
	int updatePdfGeneratedStatus(@Param("applicantId") Long applicantId, @Param("postId") Long postId);
	
	@Query(value="SELECT COUNT(*) FROM applicant_post_assoc apa JOIN payment_transactions pt ON apa.txn_order_no = pt.order_no WHERE pt.status = :status AND pt.payment_mode = :paymentMode AND CONVERT(apa.submitted_date, DATE) BETWEEN CONVERT(:fromDate, DATE) AND CONVERT(:toDate, DATE)", nativeQuery = true)
	Long countApplicantPostAssocByPaymentModePaymentStatusBetweenDates(@Param("paymentMode") int paymentMode, @Param("status") int status, @Param("fromDate") String fromDate, @Param("toDate") String toDate);

	@Query(value="SELECT `ep_exams`.`exam_code` FROM `ep_exams` WHERE `ep_exams`.`id` IN (SELECT `ep_exam_post_assoc`.`exam_id` FROM `ep_exam_post_assoc` WHERE `ep_exam_post_assoc`.`post_id` = :postId)", nativeQuery = true)
	String getExamCode(@Param("postId") Integer postId); 
	
	@Query(value="SELECT `ep_exam_applicant_assoc`.`assigned_exam_date` FROM `ep_exam_applicant_assoc` WHERE `ep_exam_applicant_assoc`.`applicant_id` = :applicant_Id AND `ep_exam_applicant_assoc`.`exam_id` IN(SELECT `ep_exams`.`id` FROM `ep_exams` WHERE `ep_exams`.`exam_code` = :exam_code)" , nativeQuery = true)
	Date getExamDate(@Param("applicant_Id") Integer applicantId, @Param("exam_code") String examCode);
	
	@Query(value="SELECT `ep_shifts`.`shift_name` FROM `ep_shifts` WHERE `ep_shifts`.`id` IN (SELECT `ep_exam_applicant_assoc`.`assigned_shift_id` FROM `ep_exam_applicant_assoc`  WHERE `ep_exam_applicant_assoc`.`applicant_id` = :applicant_Id AND `ep_exam_applicant_assoc`.`exam_id` IN(SELECT `ep_exams`.`id` FROM `ep_exams` WHERE `ep_exams`.`exam_code` = :exam_code) )" , nativeQuery = true)
	String getShiftName(@Param("applicant_Id") Integer applicantId,  @Param("exam_code") String examCode);
	
	@Query(value="SELECT `applicant_post_assoc`.`applicant_id` FROM `applicant_post_assoc` WHERE `applicant_post_assoc`.`id` = :applicantPostAssocId AND `applicant_post_assoc`.`post_id`= :postId" , nativeQuery= true)
	Integer getApplicantId(@Param("applicantPostAssocId") Integer applicantPostAssocId, @Param("postId") Integer postId);
	
	@Query(value="SELECT `ep_applicants`.`application_id` FROM `ep_applicants` WHERE `ep_applicants`.`id` = :applicant_Id", nativeQuery = true)
	String getApplicationId(@Param("applicant_Id") Integer applicantId);

	List<ApplicantPostAssoc> findApplicantPostAssocByTxnOrderNo(String txnOrderNum);
	
	
}
