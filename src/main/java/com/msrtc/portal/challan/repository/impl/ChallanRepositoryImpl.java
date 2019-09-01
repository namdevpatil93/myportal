package com.msrtc.portal.challan.repository.impl;

import com.querydsl.core.BooleanBuilder;
import com.msrtc.portal.challan.domain.QChallan;
import com.msrtc.portal.challan.domain.Challan;
import com.msrtc.portal.challan.dto.ChallanSearchDTO;
import com.msrtc.portal.challan.repository.ChallanRepository;
import com.msrtc.portal.challan.repository.ChallanRepositoryCustom;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.util.StringUtils;

public class ChallanRepositoryImpl implements ChallanRepositoryCustom {

    @Autowired
    private ChallanRepository challanRepository;

    @Override
    public Page<Challan> searchChallans(ChallanSearchDTO challanSearchDTO, Pageable pageable) {
        QChallan challan = QChallan.challan;

        BooleanBuilder queryBuilder = new BooleanBuilder();

        int searchType = challanSearchDTO.getSearchType();

        if(searchType == 1){
            String searchText = challanSearchDTO.getSearchText();
            if(!StringUtils.isEmpty(searchText)){
                queryBuilder.or(challan.jrnlNo.containsIgnoreCase(searchText));
                queryBuilder.or(challan.tranMode.containsIgnoreCase(searchText));
                queryBuilder.or(challan.fromAccountSys.containsIgnoreCase(searchText));
                queryBuilder.or(challan.fromAcctNo.containsIgnoreCase(searchText));
                queryBuilder.or(challan.feeType.containsIgnoreCase(searchText));
                queryBuilder.or(challan.applicationNo.containsIgnoreCase(searchText));
                queryBuilder.or(challan.tranDate.containsIgnoreCase(searchText));
                queryBuilder.or(challan.tranBranch.containsIgnoreCase(searchText));
                queryBuilder.or(challan.tranTime.containsIgnoreCase(searchText));
                queryBuilder.or(challan.accountNo.containsIgnoreCase(searchText));
                queryBuilder.or(challan.amount.containsIgnoreCase(searchText));
                queryBuilder.or(challan.applicantName.containsIgnoreCase(searchText));
                queryBuilder.or(challan.category.containsIgnoreCase(searchText));
            }
        }

        return challanRepository.findAll(queryBuilder.getValue(), pageable);
    }
}

