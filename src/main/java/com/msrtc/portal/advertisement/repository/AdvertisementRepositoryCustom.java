package com.msrtc.portal.advertisement.repository;

import com.msrtc.portal.advertisement.domain.Advertisement;
import com.msrtc.portal.advertisement.dto.AdvertisementSearchDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface AdvertisementRepositoryCustom {

    Page<Advertisement> searchAdvertisements(AdvertisementSearchDTO advertisementSearchDTO, Pageable pageable);

}

