package com.msrtc.portal.applicant.repository;

import com.msrtc.portal.applicant.domain.Applicant;
import com.msrtc.portal.applicant.dto.ApplicantSearchDTO;
import com.msrtc.portal.applicant.dto.UndertakingDTO;
import com.msrtc.portal.core.common.util.PageDetail;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface ApplicantRepositoryCustom {

    Page<Applicant> searchApplicants(ApplicantSearchDTO applicantSearchDTO, Pageable pageable);

    List<UndertakingDTO> findApplicationDetailsByPostId(List<String> applicationIds, Long postId, PageDetail pageDetail);
}

