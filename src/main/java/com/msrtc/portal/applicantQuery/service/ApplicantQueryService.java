package com.msrtc.portal.applicantQuery.service;

import java.util.List;

import com.msrtc.portal.applicant.domain.Applicant;
import com.msrtc.portal.applicantQuery.domain.ApplicantQuery;
import com.msrtc.portal.applicantQuery.domain.ApplicantQueryReply;
import com.msrtc.portal.applicantQuery.dto.ApplicantQuerySearchDTO;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.multipart.MultipartFile;

public interface ApplicantQueryService {

    List<ApplicantQuery> findAllApplicantQueries();

    Page<ApplicantQuery> searchApplicantQueries(ApplicantQuerySearchDTO applicantQuerySearchDTO, Pageable pageable, Long id);

    ApplicantQuery findApplicantQueryByQId(Long id) ;

    void saveApplicantQuery(ApplicantQuery applicantQuery, Applicant applicant, MultipartFile attachment);

    void deleteApplicantQuery(Long id);

	void saveApplicantQueryReply(ApplicantQueryReply applicantQueryReply, MultipartFile attachment);

	List<ApplicantQueryReply> findApplicantQueryReplyById(Long id);

	List<Long> findApplicantQueryOrderByQId(Long id);
	
	int getCountofUnreadQueryReplies(Long userid);

	void updateQueryReplyStatusToRead(Long id);
	
	ApplicantQueryReply findApplicantQueryReply(Long id);
}

