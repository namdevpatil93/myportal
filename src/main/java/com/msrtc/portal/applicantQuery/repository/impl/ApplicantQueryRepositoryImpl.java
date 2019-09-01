package com.msrtc.portal.applicantQuery.repository.impl;

import com.msrtc.portal.applicantQuery.domain.QApplicantQuery;
import com.querydsl.core.BooleanBuilder;
import com.msrtc.portal.applicantQuery.domain.ApplicantQuery;
import com.msrtc.portal.applicantQuery.dto.ApplicantQuerySearchDTO;
import com.msrtc.portal.applicantQuery.repository.ApplicantQueryRepository;
import com.msrtc.portal.applicantQuery.repository.ApplicantQueryRepositoryCustom;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.util.StringUtils;

public class ApplicantQueryRepositoryImpl implements ApplicantQueryRepositoryCustom {

    @Autowired
    private ApplicantQueryRepository applicantQueryRepository;

    @Override
    public Page<ApplicantQuery> searchApplicantQueries(ApplicantQuerySearchDTO applicantQuerySearchDTO, Pageable pageable, Long id) {
        QApplicantQuery applicantQuery = QApplicantQuery.applicantQuery;

        BooleanBuilder queryBuilder = new BooleanBuilder();
        if(id > 0)
        {	
        	queryBuilder.or(applicantQuery.applicantId.eq(id));
        }
        int searchType = applicantQuerySearchDTO.getSearchType();

        if(searchType == 1){
            String searchText = applicantQuerySearchDTO.getSearchText();
            if(!StringUtils.isEmpty(searchText)){
                queryBuilder.or(applicantQuery.typeOther.containsIgnoreCase(searchText));
                queryBuilder.or(applicantQuery.title.containsIgnoreCase(searchText));
                queryBuilder.or(applicantQuery.description.containsIgnoreCase(searchText));
            }
        }

        return applicantQueryRepository.findAll(queryBuilder.getValue(), pageable);
    }
}

