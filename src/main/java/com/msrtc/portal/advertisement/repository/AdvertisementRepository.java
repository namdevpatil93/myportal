package com.msrtc.portal.advertisement.repository;

import java.time.LocalDate;
import java.util.List;

import com.msrtc.portal.advertisement.domain.Advertisement;
import com.msrtc.portal.core.common.repository.BaseRepository;

public interface AdvertisementRepository extends BaseRepository<Advertisement, Long>, AdvertisementRepositoryCustom {
	
	List<Advertisement> findByActiveTrueAndClosingDateGreaterThan(LocalDate now);
	
}

