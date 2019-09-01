package com.msrtc.portal.applicant.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.msrtc.portal.applicant.domain.Applicant;
import com.msrtc.portal.applicant.domain.ApplicantPostAssoc;
import com.msrtc.portal.applicant.dto.AdmitCardDownload;
import com.msrtc.portal.applicant.dto.ApplicantPostAssocSearchDTO;
import com.msrtc.portal.challan.domain.ApplicantPostPaymentMismatch;
import com.msrtc.portal.core.common.util.PageDetail;

public interface ApplicantPostAssocRepositoryCustom {

	Page<ApplicantPostAssoc> searchApplicantPostAssocs(ApplicantPostAssocSearchDTO applicantPostAssocSearchDTO, Pageable pageable);
	
	Page<ApplicantPostAssoc> filterApplicantPostAssocsList(ApplicantPostAssocSearchDTO applicantPostAssocSearchDTO, PageDetail pageDetail);
	
	Integer filterApplicantPostAssocsListSize(ApplicantPostAssocSearchDTO applicantPostAssocSearchDTO);
	
	List<Object[]> findAllApplicantPostAssoc(ApplicantPostAssocSearchDTO applicantPostAssocSearchDTO);
	
	List<Integer> filterApplicantIdList(ApplicantPostAssocSearchDTO applicantPostAssocSearchDTO);
	
	Integer filterApplicantPostPaymentMismatchListSize(String fromDate, String toDate);
	
	Page<ApplicantPostPaymentMismatch> filterApplicantPostPaymentMismatchList(String fromDate, String toDate, PageDetail pageDetail);
	Object[]  getAdmitCardUrl(Long applicantId, Long postId);
}
