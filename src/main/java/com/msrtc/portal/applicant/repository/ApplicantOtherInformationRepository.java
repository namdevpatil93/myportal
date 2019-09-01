package com.msrtc.portal.applicant.repository;

import com.msrtc.portal.applicant.domain.Applicant;
import com.msrtc.portal.applicant.domain.ApplicantOtherInformation;
import com.msrtc.portal.core.common.repository.BaseRepository;

public interface ApplicantOtherInformationRepository extends BaseRepository<ApplicantOtherInformation, Long>{
	
	ApplicantOtherInformation findApplicantOtherInformationByApplicant(Applicant applicant);
}
