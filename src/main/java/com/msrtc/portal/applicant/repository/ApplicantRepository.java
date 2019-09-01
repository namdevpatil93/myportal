package com.msrtc.portal.applicant.repository;

import java.util.List;

import com.msrtc.portal.applicant.domain.Applicant;
import com.msrtc.portal.core.common.repository.BaseRepository;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ApplicantRepository extends BaseRepository<Applicant, Long>, ApplicantRepositoryCustom {

    Applicant findByApplicationId(String applicationId);
   
    @Query(value="SELECT application_id FROM applicants WHERE id = :id", nativeQuery=true)
    String findApplicationIdById(@Param("id") Long id);
    
    @Modifying(clearAutomatically = true)
    @Query("UPDATE Applicant a SET a.password = :password, firstLogin = false WHERE a.id = :id")
    int updatePassword(@Param("id") Long id, @Param("password") String password);
    
    Applicant findByEmailAddress(String email);
    
    @Query(value="SELECT COUNT(*) FROM applicants WHERE CONVERT(created_date, DATE) BETWEEN CONVERT(:fromDate, DATE) AND CONVERT(:toDate, DATE)", nativeQuery=true)
	Long totalRegisteredApplicantsCount(@Param("fromDate") String fromDate, @Param("toDate") String toDate);
	
	@Query(value="SELECT gender AS Gender, COUNT(*) AS ApplicantCount FROM applicants WHERE CONVERT(created_date, DATE) BETWEEN CONVERT(:fromDate, DATE) AND CONVERT(:toDate, DATE) GROUP BY gender", nativeQuery=true)
	List<Object[]> totalApplicantCountByGender(@Param("fromDate") String fromDate, @Param("toDate") String toDate);
	
	@Query(value="SELECT COUNT(*) FROM payment_transactions WHERE payment_mode=2 AND CONVERT(created_date, DATE) BETWEEN CONVERT(:fromDate, DATE) AND CONVERT(:toDate, DATE)", nativeQuery=true)
	Long totalChallanGeneratedCount(@Param("fromDate") String fromDate, @Param("toDate") String toDate);
	
	@Query(value="SELECT "+
			" CASE WHEN apa.post_id=1 THEN apa.post_id "+
			" WHEN apa.post_id=2 THEN apa.post_id "+
			" WHEN apa.post_id=3 THEN apa.post_id "+
			" WHEN apa.post_id=4 THEN apa.post_id "+
			" WHEN apa.post_id=5 THEN apa.post_id "+
			" WHEN apa.post_id=6 THEN apa.post_id "+
			" WHEN apa.post_id=7 THEN apa.post_id "+
			" WHEN apa.post_id=8 THEN apa.post_id "+
			" WHEN apa.post_id=9 THEN apa.post_id "+
			" WHEN apa.post_id=10 THEN apa.post_id "+
			" WHEN apa.post_id=11 THEN apa.post_id "+
			" WHEN apa.post_id=12 THEN apa.post_id "+
			" WHEN apa.post_id=13 THEN apa.post_id "+
			" WHEN apa.post_id=14 THEN apa.post_id "+
			" WHEN apa.post_id=15 THEN apa.post_id "+
			" WHEN apa.post_id=16 THEN apa.post_id "+
			" WHEN apa.post_id=17 THEN apa.post_id "+
			" WHEN apa.post_id=18 THEN apa.post_id "+
			" WHEN apa.post_id=19 THEN apa.post_id "+
			" WHEN apa.post_id=20 THEN apa.post_id "+
			" WHEN apa.post_id=21 THEN apa.post_id "+
			" WHEN apa.post_id=22 THEN apa.post_id "+
			" WHEN apa.post_id=23 THEN apa.post_id "+
			" WHEN apa.post_id=24 THEN apa.post_id "+
			" WHEN apa.post_id=25 THEN apa.post_id "+
			" WHEN apa.post_id=26 THEN apa.post_id "+
			" WHEN apa.post_id=27 THEN apa.post_id "+
			" WHEN apa.post_id=28 THEN apa.post_id "+
			" WHEN apa.post_id=29 THEN apa.post_id "+
			" WHEN apa.post_id=30 THEN apa.post_id "+
			" WHEN apa.post_id=31 THEN apa.post_id END AS Post, "+
			" CASE WHEN a.gender=0 THEN a.gender "+
			" WHEN a.gender=1 THEN a.gender END AS Gender, "+
			" COUNT(apa.post_id) AS ApplicationCount FROM applicant_post_assoc apa "+ 
			" JOIN applicants a ON apa.applicant_id=a.id   "+
			" JOIN posts p ON p.post_id=apa.post_id"+
			" WHERE apa.status=2 AND p.active=1 AND CONVERT(apa.submitted_date, DATE) BETWEEN CONVERT(:fromDate, DATE) AND CONVERT(:toDate, DATE) GROUP BY apa.post_id, a.gender", nativeQuery=true)
	List<Object[]> successfulApplicantCountPostWiseGenderWise(@Param("fromDate") String fromDate, @Param("toDate") String toDate);
	
	@Query(value="SELECT "+
			" CASE WHEN apa.post_id=1 THEN apa.post_id "+
			" WHEN apa.post_id=2 THEN apa.post_id "+
			" WHEN apa.post_id=3 THEN apa.post_id "+
			" WHEN apa.post_id=4 THEN apa.post_id "+
			" WHEN apa.post_id=5 THEN apa.post_id "+
			" WHEN apa.post_id=6 THEN apa.post_id "+
			" WHEN apa.post_id=7 THEN apa.post_id "+
			" WHEN apa.post_id=8 THEN apa.post_id "+
			" WHEN apa.post_id=9 THEN apa.post_id "+
			" WHEN apa.post_id=10 THEN apa.post_id "+
			" WHEN apa.post_id=11 THEN apa.post_id "+
			" WHEN apa.post_id=12 THEN apa.post_id "+
			" WHEN apa.post_id=13 THEN apa.post_id "+
			" WHEN apa.post_id=14 THEN apa.post_id "+
			" WHEN apa.post_id=15 THEN apa.post_id "+
			" WHEN apa.post_id=16 THEN apa.post_id "+
			" WHEN apa.post_id=17 THEN apa.post_id "+
			" WHEN apa.post_id=18 THEN apa.post_id "+
			" WHEN apa.post_id=19 THEN apa.post_id "+
			" WHEN apa.post_id=20 THEN apa.post_id "+
			" WHEN apa.post_id=21 THEN apa.post_id "+
			" WHEN apa.post_id=22 THEN apa.post_id "+
			" WHEN apa.post_id=23 THEN apa.post_id "+
			" WHEN apa.post_id=24 THEN apa.post_id "+
			" WHEN apa.post_id=25 THEN apa.post_id "+
			" WHEN apa.post_id=26 THEN apa.post_id "+
			" WHEN apa.post_id=27 THEN apa.post_id "+
			" WHEN apa.post_id=28 THEN apa.post_id "+
			" WHEN apa.post_id=29 THEN apa.post_id "+
			" WHEN apa.post_id=30 THEN apa.post_id "+
			" WHEN apa.post_id=31 THEN apa.post_id END AS Post, "+
			" COUNT(apa.post_id) AS ApplicationCount FROM applicant_post_assoc apa "+ 
			" JOIN posts p ON p.post_id=apa.post_id"+
			" WHERE p.active=1 AND  CONVERT(apa.created_date, DATE) BETWEEN CONVERT(:fromDate, DATE) AND CONVERT(:toDate, DATE) GROUP BY apa.post_id", nativeQuery=true)
	List<Object[]> applicantCountPostWise(@Param("fromDate") String fromDate, @Param("toDate") String toDate);
	
	@Query(value="SELECT "+
			" CASE WHEN apa.post_id=1 THEN apa.post_id "+
			" WHEN apa.post_id=2 THEN apa.post_id "+
			" WHEN apa.post_id=3 THEN apa.post_id "+
			" WHEN apa.post_id=4 THEN apa.post_id "+
			" WHEN apa.post_id=5 THEN apa.post_id "+
			" WHEN apa.post_id=6 THEN apa.post_id "+
			" WHEN apa.post_id=7 THEN apa.post_id "+
			" WHEN apa.post_id=8 THEN apa.post_id "+
			" WHEN apa.post_id=9 THEN apa.post_id "+
			" WHEN apa.post_id=10 THEN apa.post_id "+
			" WHEN apa.post_id=11 THEN apa.post_id "+
			" WHEN apa.post_id=12 THEN apa.post_id "+
			" WHEN apa.post_id=13 THEN apa.post_id "+
			" WHEN apa.post_id=14 THEN apa.post_id "+
			" WHEN apa.post_id=15 THEN apa.post_id "+
			" WHEN apa.post_id=16 THEN apa.post_id "+
			" WHEN apa.post_id=17 THEN apa.post_id "+
			" WHEN apa.post_id=18 THEN apa.post_id "+
			" WHEN apa.post_id=19 THEN apa.post_id "+
			" WHEN apa.post_id=20 THEN apa.post_id "+
			" WHEN apa.post_id=21 THEN apa.post_id "+
			" WHEN apa.post_id=22 THEN apa.post_id "+
			" WHEN apa.post_id=23 THEN apa.post_id "+
			" WHEN apa.post_id=24 THEN apa.post_id "+
			" WHEN apa.post_id=25 THEN apa.post_id "+
			" WHEN apa.post_id=26 THEN apa.post_id "+
			" WHEN apa.post_id=27 THEN apa.post_id "+
			" WHEN apa.post_id=28 THEN apa.post_id "+
			" WHEN apa.post_id=29 THEN apa.post_id "+
			" WHEN apa.post_id=30 THEN apa.post_id "+
			" WHEN apa.post_id=31 THEN apa.post_id END AS Post, "+
			" CASE WHEN a.gender=0 THEN a.gender "+
			" WHEN a.gender=1 THEN a.gender END AS Gender, "+
			" COUNT(apa.post_id) AS ApplicationCount FROM applicant_post_assoc apa "+ 
			" JOIN applicants a ON apa.applicant_id=a.id   "+
			" JOIN payment_transactions pt ON apa.txn_order_no = pt.order_no "+
			" JOIN posts p ON p.post_id=apa.post_id"+
			" WHERE apa.status=2 AND  p.active=1 AND pt.payment_mode=1 AND  CONVERT(apa.submitted_date, DATE) BETWEEN CONVERT(:fromDate, DATE) AND CONVERT(:toDate, DATE) GROUP BY apa.post_id, a.gender", nativeQuery=true)
	List<Object[]> successFulApplicantCountOnlineModePostWiseGenderWise(@Param("fromDate") String fromDate, @Param("toDate") String toDate);
	
	@Query(value="SELECT "+
			" CASE WHEN apa.post_id=1 THEN apa.post_id "+
			" WHEN apa.post_id=2 THEN apa.post_id "+
			" WHEN apa.post_id=3 THEN apa.post_id "+
			" WHEN apa.post_id=4 THEN apa.post_id "+
			" WHEN apa.post_id=5 THEN apa.post_id "+
			" WHEN apa.post_id=6 THEN apa.post_id "+
			" WHEN apa.post_id=7 THEN apa.post_id "+
			" WHEN apa.post_id=8 THEN apa.post_id "+
			" WHEN apa.post_id=9 THEN apa.post_id "+
			" WHEN apa.post_id=10 THEN apa.post_id "+
			" WHEN apa.post_id=11 THEN apa.post_id "+
			" WHEN apa.post_id=12 THEN apa.post_id "+
			" WHEN apa.post_id=13 THEN apa.post_id "+
			" WHEN apa.post_id=14 THEN apa.post_id "+
			" WHEN apa.post_id=15 THEN apa.post_id "+
			" WHEN apa.post_id=16 THEN apa.post_id "+
			" WHEN apa.post_id=17 THEN apa.post_id "+
			" WHEN apa.post_id=18 THEN apa.post_id "+
			" WHEN apa.post_id=19 THEN apa.post_id "+
			" WHEN apa.post_id=20 THEN apa.post_id "+
			" WHEN apa.post_id=21 THEN apa.post_id "+
			" WHEN apa.post_id=22 THEN apa.post_id "+
			" WHEN apa.post_id=23 THEN apa.post_id "+
			" WHEN apa.post_id=24 THEN apa.post_id "+
			" WHEN apa.post_id=25 THEN apa.post_id "+
			" WHEN apa.post_id=26 THEN apa.post_id "+
			" WHEN apa.post_id=27 THEN apa.post_id "+
			" WHEN apa.post_id=28 THEN apa.post_id "+
			" WHEN apa.post_id=29 THEN apa.post_id "+
			" WHEN apa.post_id=30 THEN apa.post_id "+
			" WHEN apa.post_id=31 THEN apa.post_id END AS Post, "+
			" CASE WHEN a.gender=0 THEN a.gender "+
			" WHEN a.gender=1 THEN a.gender END AS Gender, "+
			" COUNT(apa.post_id) AS ApplicationCount FROM applicant_post_assoc apa "+ 
			" JOIN applicants a ON apa.applicant_id=a.id   "+
			" JOIN payment_transactions pt ON apa.txn_order_no = pt.order_no "+
			" JOIN posts p ON p.post_id=apa.post_id"+
			" WHERE apa.status=2 AND  p.active=1  AND pt.payment_mode=2 AND  CONVERT(apa.submitted_date, DATE) BETWEEN CONVERT(:fromDate, DATE) AND CONVERT(:toDate, DATE) GROUP BY apa.post_id, a.gender", nativeQuery=true)
	List<Object[]> successfulApplicantCountOfflineModePostWiseGenderWise(@Param("fromDate") String fromDate, @Param("toDate") String toDate);
	
	@Query(value="SELECT "+
			" CASE WHEN apa.post_id=1 THEN apa.post_id "+
			" WHEN apa.post_id=2 THEN apa.post_id "+
			" WHEN apa.post_id=3 THEN apa.post_id "+
			" WHEN apa.post_id=4 THEN apa.post_id "+
			" WHEN apa.post_id=5 THEN apa.post_id "+
			" WHEN apa.post_id=6 THEN apa.post_id "+
			" WHEN apa.post_id=7 THEN apa.post_id "+
			" WHEN apa.post_id=8 THEN apa.post_id "+
			" WHEN apa.post_id=9 THEN apa.post_id "+
			" WHEN apa.post_id=10 THEN apa.post_id "+
			" WHEN apa.post_id=11 THEN apa.post_id "+
			" WHEN apa.post_id=12 THEN apa.post_id "+
			" WHEN apa.post_id=13 THEN apa.post_id "+
			" WHEN apa.post_id=14 THEN apa.post_id "+
			" WHEN apa.post_id=15 THEN apa.post_id "+
			" WHEN apa.post_id=16 THEN apa.post_id "+
			" WHEN apa.post_id=17 THEN apa.post_id "+
			" WHEN apa.post_id=18 THEN apa.post_id "+
			" WHEN apa.post_id=19 THEN apa.post_id "+
			" WHEN apa.post_id=20 THEN apa.post_id "+
			" WHEN apa.post_id=21 THEN apa.post_id "+
			" WHEN apa.post_id=22 THEN apa.post_id "+
			" WHEN apa.post_id=23 THEN apa.post_id "+
			" WHEN apa.post_id=24 THEN apa.post_id "+
			" WHEN apa.post_id=25 THEN apa.post_id "+
			" WHEN apa.post_id=26 THEN apa.post_id "+
			" WHEN apa.post_id=27 THEN apa.post_id "+
			" WHEN apa.post_id=28 THEN apa.post_id "+
			" WHEN apa.post_id=29 THEN apa.post_id "+
			" WHEN apa.post_id=30 THEN apa.post_id "+
			" WHEN apa.post_id=31 THEN apa.post_id END AS Post, "+
			" CASE WHEN a.gender=0 THEN a.gender "+
			" WHEN a.gender=1 THEN a.gender END AS Gender, "+
			" COUNT(apa.post_id) AS ApplicationCount FROM applicant_post_assoc apa "+ 
			" JOIN applicants a ON apa.applicant_id=a.id   "+
			" JOIN posts p ON p.post_id=apa.post_id"+
			" WHERE a.caste_id=1 AND  p.active=1  AND apa.status=2 AND CONVERT(apa.submitted_date, DATE) BETWEEN CONVERT(:fromDate, DATE) AND CONVERT(:toDate, DATE) GROUP BY apa.post_id, a.gender", nativeQuery=true)
	List<Object[]> successfulApplicantCountOpenCategoryPostWiseGenderWise(@Param("fromDate") String fromDate, @Param("toDate") String toDate);
	
	@Query(value="SELECT "+
			" CASE WHEN apa.post_id=1 THEN apa.post_id "+
			" WHEN apa.post_id=2 THEN apa.post_id "+
			" WHEN apa.post_id=3 THEN apa.post_id "+
			" WHEN apa.post_id=4 THEN apa.post_id "+
			" WHEN apa.post_id=5 THEN apa.post_id "+
			" WHEN apa.post_id=6 THEN apa.post_id "+
			" WHEN apa.post_id=7 THEN apa.post_id "+
			" WHEN apa.post_id=8 THEN apa.post_id "+
			" WHEN apa.post_id=9 THEN apa.post_id "+
			" WHEN apa.post_id=10 THEN apa.post_id "+
			" WHEN apa.post_id=11 THEN apa.post_id "+
			" WHEN apa.post_id=12 THEN apa.post_id "+
			" WHEN apa.post_id=13 THEN apa.post_id "+
			" WHEN apa.post_id=14 THEN apa.post_id "+
			" WHEN apa.post_id=15 THEN apa.post_id "+
			" WHEN apa.post_id=16 THEN apa.post_id "+
			" WHEN apa.post_id=17 THEN apa.post_id "+
			" WHEN apa.post_id=18 THEN apa.post_id "+
			" WHEN apa.post_id=19 THEN apa.post_id "+
			" WHEN apa.post_id=20 THEN apa.post_id "+
			" WHEN apa.post_id=21 THEN apa.post_id "+
			" WHEN apa.post_id=22 THEN apa.post_id "+
			" WHEN apa.post_id=23 THEN apa.post_id "+
			" WHEN apa.post_id=24 THEN apa.post_id "+
			" WHEN apa.post_id=25 THEN apa.post_id "+
			" WHEN apa.post_id=26 THEN apa.post_id "+
			" WHEN apa.post_id=27 THEN apa.post_id "+
			" WHEN apa.post_id=28 THEN apa.post_id "+
			" WHEN apa.post_id=29 THEN apa.post_id "+
			" WHEN apa.post_id=30 THEN apa.post_id "+
			" WHEN apa.post_id=31 THEN apa.post_id END AS Post, "+
			" CASE WHEN a.gender=0 THEN a.gender "+
			" WHEN a.gender=1 THEN a.gender END AS Gender, "+
			" COUNT(apa.post_id) AS ApplicationCount FROM applicant_post_assoc apa "+ 
			" JOIN applicants a ON apa.applicant_id=a.id   "+
			" JOIN posts p ON p.post_id=apa.post_id"+
			" WHERE a.caste_id!=1 AND apa.status=2  AND  p.active=1 AND CONVERT(apa.submitted_date, DATE) BETWEEN CONVERT(:fromDate, DATE) AND CONVERT(:toDate, DATE) GROUP BY apa.post_id, a.gender", nativeQuery=true)
	List<Object[]> successfulApplicantCountReservedCategoryPostWiseGenderWise(@Param("fromDate") String fromDate, @Param("toDate") String toDate);

	@Query(value="SELECT  CONCAT( DATE_FORMAT(eaa.`assigned_exam_date`,'%d/%m/%Y'), '_' , s.`shift_name` ) AS 'group_name', a.`email_address`, a.`application_id` FROM applicant_post_assoc apa JOIN  ep_exam_post_assoc epa ON epa.post_id=apa.post_id and epa.post_id=:postId JOIN  `ep_exam_applicant_assoc` eaa ON eaa.exam_id=epa.exam_id AND eaa.applicant_id=apa.applicant_id LEFT JOIN ep_exams e ON e.id = eaa.`exam_id` LEFT JOIN ep_shifts s ON s.`id` = eaa.`assigned_shift_id` LEFT JOIN applicants a ON a.id = apa.applicant_id WHERE  apa.id=:Id AND  eaa.assigned_center_id IS NOT NULL AND e.active = 1 AND e.`drive_id` = :driveId ORDER BY e.id LIMIT 1", nativeQuery=true)
	List<Object[]> userExamRequestData(@Param("Id") Integer applicantPostAssocId,@Param("driveId") Integer driveId,@Param("postId") Integer postId);
	
	@Query(value="SELECT `applicants`.`application_id`,`applicants`.`first_name`,`applicants`.`middle_name`,`applicants`.`last_name`,CASE WHEN `applicants`.`gender` = 1 THEN \"Male\" ELSE \"Female\" END ,`applicants`.`email_address`,`applicants`.`mobile_number`, GROUP_CONCAT((SELECT `post_title` FROM `posts` WHERE `post_id` = applicant_post_assoc.post_id)) AS postTitle,applicant_post_assoc.status, (SELECT cities.city_name FROM cities WHERE cities.id=applicant_other_information.city_id_first_preference) AS First_Preference, (SELECT cities.city_name FROM cities WHERE cities.id=applicant_other_information.city_id_second_preference)AS Second_Preference, (SELECT cities.city_name FROM cities WHERE cities.id=applicant_other_information.city_id_third_preference) AS Third_Preference FROM`applicant_post_assoc`INNER JOIN `applicants` ON (`applicant_post_assoc`.`applicant_id` = `applicants`.`id`)INNER JOIN `applicant_other_information` ON (`applicant_other_information`.`applicant_id` = `applicants`.`id`) WHERE applicant_post_assoc.post_id IN (5,8,13,14,15,18,23,24,25,26,27,28,29,30,31) AND applicant_post_assoc.status =2    GROUP BY `applicants`.`application_id`",nativeQuery=true)
	List<Object[]> getPrefferedCityData();
	
}

