package com.msrtc.portal.applicant.service.impl;


import com.msrtc.portal.applicant.repository.ApplicantPostAssocRepository;
import com.msrtc.portal.applicant.service.ApplicantPostAssocService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service(value = "applicantPostAssocService")
@Transactional(readOnly = true)
public class ApplicantPostAssocServiceImpl implements ApplicantPostAssocService {

    @Autowired
    private ApplicantPostAssocRepository applicantPostAssocRepository;

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, noRollbackForClassName =  {"java.lang.Exception" })
    public int updatePdfGeneratedStatus(Long applicantId, Long postId){
        return applicantPostAssocRepository.updatePdfGeneratedStatus(applicantId, postId);
    }

	@Override
	public Long countApplicantPostAssocByPaymentModePaymentStatusBetweenDates(Integer paymentMode, Integer paymentStatus, String fromDate, String toDate) {
		return applicantPostAssocRepository.countApplicantPostAssocByPaymentModePaymentStatusBetweenDates(paymentMode, paymentStatus, fromDate, toDate);
	}

}
