package com.msrtc.portal.applicant.service;

import com.msrtc.portal.applicant.domain.Applicant;
import com.msrtc.portal.applicant.dto.AgeValidationCriteria;

public interface AgeValidatorService {

    boolean isApplicantOfValidAgeToApplyForPost(Applicant applicant, long postId, boolean isDifferentlyAbled);

    boolean isAgeWithinRange(AgeValidationCriteria ageValidationCriteria, boolean isDifferentlyAbled);
}
