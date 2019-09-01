package com.msrtc.portal.advertisement.service;

import java.util.List;

import com.msrtc.portal.advertisement.domain.Advertisement;
import com.msrtc.portal.advertisement.dto.AdvertisementSearchDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.multipart.MultipartFile;

public interface AdvertisementService {

    List<Advertisement> findAllAdvertisements();

    Page<Advertisement> searchAdvertisements(AdvertisementSearchDTO advertisementSearchDTO, Pageable pageable);

    Advertisement findAdvertisementById(Long id) ;

    void saveAdvertisement(Advertisement advertisement, MultipartFile pdfUpload, MultipartFile pdfUploadMarathi);

    void deleteAdvertisement(Long id);

	void changeStatus(Long advertisementId, boolean active);
	
	List<Advertisement> getAdvertisementList();
}

