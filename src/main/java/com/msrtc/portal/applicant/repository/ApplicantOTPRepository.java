package com.msrtc.portal.applicant.repository;

import com.msrtc.portal.applicant.domain.ApplicantOTP;
import com.msrtc.portal.core.common.repository.BaseRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ApplicantOTPRepository extends BaseRepository<ApplicantOTP, Long>{

	ApplicantOTP findByApplicantId(Long applicantId);

	@Modifying(clearAutomatically = true)
	@Query("update ApplicantOTP set otp = :otp where applicantId = :applicantId")
	void updateApplicantOTP(@Param("applicantId") Long applicantId, @Param("otp") String otp);

}
