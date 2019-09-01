package com.msrtc.portal.applicantQuery.repository;

import com.msrtc.portal.applicantQuery.domain.ApplicantQuery;
import com.msrtc.portal.applicantQuery.dto.ApplicantQuerySearchDTO;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface ApplicantQueryRepositoryCustom {

    Page<ApplicantQuery> searchApplicantQueries(ApplicantQuerySearchDTO applicantQuerySearchDTO, Pageable pageable, Long id);

}

