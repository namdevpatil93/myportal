package com.msrtc.portal.challan.repository.impl;

import com.msrtc.portal.challan.domain.ChallanFile;
import com.msrtc.portal.challan.domain.QChallanFile;
import com.msrtc.portal.challan.dto.ChallanFileSearchDTO;
import com.msrtc.portal.challan.repository.ChallanFileRepository;
import com.msrtc.portal.challan.repository.ChallanFileRepositoryCustom;
import com.querydsl.core.BooleanBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.util.StringUtils;

public class ChallanFileRepositoryImpl implements ChallanFileRepositoryCustom {

    @Autowired
    private ChallanFileRepository challanFileRepository;

    @Override
    public Page<ChallanFile> searchChallanFiles(ChallanFileSearchDTO challanFileSearchDTO, Pageable pageable) {
        QChallanFile challanFile = QChallanFile.challanFile;

        BooleanBuilder queryBuilder = new BooleanBuilder();

        int searchType = challanFileSearchDTO.getSearchType();

        if(searchType == 1){
            String searchText = challanFileSearchDTO.getSearchText();
            if(!StringUtils.isEmpty(searchText)){
                queryBuilder.or(challanFile.fileName.containsIgnoreCase(searchText));
                queryBuilder.or(challanFile.originalFileName.containsIgnoreCase(searchText));
            }
        }

        return challanFileRepository.findAll(queryBuilder.getValue(), pageable);
    }
}

