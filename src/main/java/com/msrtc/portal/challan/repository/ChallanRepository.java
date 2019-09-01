package com.msrtc.portal.challan.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.msrtc.portal.challan.domain.Challan;
import com.msrtc.portal.core.common.repository.BaseRepository;

public interface ChallanRepository extends BaseRepository<Challan, Long>, ChallanRepositoryCustom {

	@Query("SELECT '248' AS FeeType, " +
			"pt.orderNo AS ReferenceNo, " +
			"a.birthDate AS DOB, " +
			"'33501573773' AS AccountNumber, " +
			"pt.amount AS Amount, " +
			"'300' AS BranchCode," +
			"CONCAT(a.firstName,' ',a.middleName,' ',a.lastName) AS ApplicantName, " +
			"a.caste.casteTitle AS Category, " +
			"a.applicationId AS ApplicantId " +
			"FROM ApplicantPostAssoc apa, Applicant a, PaymentTransaction pt  " +
			"WHERE " +
			"apa.applicantId = a.id AND pt.applicantId=a.id AND pt.paymentMode=2 AND pt.orderNo=apa.txnOrderNo AND  CONVERT(pt.createdDate, DATE) BETWEEN CONVERT(:fromDate, DATE) AND CONVERT(:toDate, DATE)  GROUP BY pt.orderNo")
	List<Object[]> findChallanDataList(@Param("fromDate") String fromDate, @Param("toDate") String toDate);
	
	Long countByApplicationNo(String applicationNo);
}

