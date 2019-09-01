package com.msrtc.portal.applicant.repository;

import com.msrtc.portal.applicant.domain.ApplicantFiles;
import com.msrtc.portal.core.common.repository.BaseRepository;

public interface ApplicantFilesRepository extends BaseRepository<ApplicantFiles, Long> {

	ApplicantFiles findByApplicantId(Long applicantId);
}

