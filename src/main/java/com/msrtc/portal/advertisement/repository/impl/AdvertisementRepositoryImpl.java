package com.msrtc.portal.advertisement.repository.impl;

import com.querydsl.core.BooleanBuilder;
import com.msrtc.portal.advertisement.domain.QAdvertisement;
import com.msrtc.portal.advertisement.domain.Advertisement;
import com.msrtc.portal.advertisement.dto.AdvertisementSearchDTO;
import com.msrtc.portal.advertisement.repository.AdvertisementRepository;
import com.msrtc.portal.advertisement.repository.AdvertisementRepositoryCustom;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.util.StringUtils;

public class AdvertisementRepositoryImpl implements AdvertisementRepositoryCustom {

    @Autowired
    private AdvertisementRepository advertisementRepository;

    @Override
    public Page<Advertisement> searchAdvertisements(AdvertisementSearchDTO advertisementSearchDTO, Pageable pageable) {
        QAdvertisement advertisement = QAdvertisement.advertisement;

        BooleanBuilder queryBuilder = new BooleanBuilder();

        int searchType = advertisementSearchDTO.getSearchType();

        if(searchType == 1){
            String searchText = advertisementSearchDTO.getSearchText();
            if(!StringUtils.isEmpty(searchText)){
                queryBuilder.or(advertisement.title.containsIgnoreCase(searchText));
                queryBuilder.or(advertisement.description.containsIgnoreCase(searchText));
                queryBuilder.or(advertisement.documentName.containsIgnoreCase(searchText));
            }
        }

        return advertisementRepository.findAll(queryBuilder.getValue(), pageable);
    }
}

