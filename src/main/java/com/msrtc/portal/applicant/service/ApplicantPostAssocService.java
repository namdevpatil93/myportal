package com.msrtc.portal.applicant.service;

import org.springframework.data.repository.query.Param;

public interface ApplicantPostAssocService {

    int updatePdfGeneratedStatus(Long applicantId, Long postId);
    Long countApplicantPostAssocByPaymentModePaymentStatusBetweenDates(Integer paymentMode, Integer paymentStatus, String fromDate, String toDate);
}

