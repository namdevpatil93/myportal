package com.msrtc.portal.advertisement.service.impl;

import java.io.File;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.msrtc.portal.advertisement.domain.Advertisement;
import com.msrtc.portal.advertisement.dto.AdvertisementSearchDTO;
import com.msrtc.portal.advertisement.repository.AdvertisementRepository;
import com.msrtc.portal.advertisement.service.AdvertisementService;
import com.msrtc.portal.core.common.util.Constants;
import com.msrtc.portal.core.common.util.FileUtils;
import com.msrtc.portal.core.config.ApplicationProperties;
import com.msrtc.portal.document.domain.Document;
import com.msrtc.portal.document.domain.DocumentEnum;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

@Service(value = "advertisementService")
@Transactional(readOnly = true)
public class AdvertisementServiceImpl implements AdvertisementService {

	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	private AdvertisementRepository advertisementRepository;
	
	@Autowired
    private ApplicationProperties applicationProperties;

	@Override
	public List<Advertisement> findAllAdvertisements() {
		log.debug("Finding all advertisement entries");
		return (List<Advertisement>) advertisementRepository.findAll();
	}

	@Override
	public Page<Advertisement> searchAdvertisements(AdvertisementSearchDTO advertisementSearchDTO, Pageable pageable){
		return advertisementRepository.searchAdvertisements(advertisementSearchDTO, pageable);
	}

	@Override
	public Advertisement findAdvertisementById(Long id) {
		log.debug("Finding advertisement entry with the advertisement id: {}", id);
		return advertisementRepository.findOne(id);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
	public void saveAdvertisement(Advertisement advertisement, MultipartFile pdfUpload, MultipartFile pdfUploadMarathi) {
		log.debug("Saving Advertisement with the information: {}", advertisement);
		
		String basePath = applicationProperties.getResources().getBasePath();
		
		//String pdfUploadName = pdfUpload != null ? UUID.randomUUID().toString() + "_" + pdfUpload.getOriginalFilename() : null;
		String pdfFileExtension = pdfUpload != null ? pdfUpload.getOriginalFilename().substring(pdfUpload.getOriginalFilename().lastIndexOf(".")) : null;
		String pdfUploadName = pdfUpload != null ? UUID.randomUUID().toString()+pdfFileExtension : null;
		//String pdfUploadMarathiName = pdfUploadMarathi != null ? UUID.randomUUID().toString() + "_" + pdfUploadMarathi.getOriginalFilename() : null;
		String pdfMarathiFileExtension = pdfUploadMarathi != null ?  pdfUploadMarathi.getOriginalFilename().substring(pdfUploadMarathi.getOriginalFilename().lastIndexOf(".")) : null;
		String pdfUploadMarathiName = pdfUploadMarathi != null ? UUID.randomUUID().toString()+pdfMarathiFileExtension : null;
        

		boolean isNew = advertisement.getId() == null ||  advertisement.getId() == 0;
		Long advertisementId = null;
		if(isNew){
			advertisement.setDocumentName(pdfUploadName);
			advertisement.setDocumentNameMarathi(pdfUploadMarathiName);
			advertisementRepository.save(advertisement);
			advertisementId = advertisement.getId();
		} else {
			Advertisement dbAdvertisement = advertisementRepository.findOne(advertisement.getId());

            dbAdvertisement.setTitle(advertisement.getTitle());
            dbAdvertisement.setDescription(advertisement.getDescription());
            dbAdvertisement.setStartDate(advertisement.getStartDate());
            dbAdvertisement.setClosingDate(advertisement.getClosingDate());
            dbAdvertisement.setAdvertisementNo(advertisement.getAdvertisementNo());
            if (!StringUtils.isBlank(pdfUploadName)) {
            	dbAdvertisement.setDocumentName(pdfUploadName);
            }
            dbAdvertisement.setTitleMarathi(advertisement.getTitleMarathi());
            dbAdvertisement.setDescriptionMarathi(advertisement.getDescriptionMarathi());
            dbAdvertisement.setAdvertisementNoMarathi(advertisement.getAdvertisementNoMarathi());
            if (!StringUtils.isBlank(pdfUploadMarathiName)) {
            	dbAdvertisement.setDocumentNameMarathi(pdfUploadMarathiName);
            }
            dbAdvertisement.setActive(advertisement.getActive());
            advertisementRepository.save(dbAdvertisement);
            
            advertisementId = dbAdvertisement.getId();
		}
		
		String pdfUploadLocation = basePath + File.separator + Constants.BASE_UPLOAD_DIR + File.separator + Constants.ADMIN_DIR + File.separator + Constants.DOCUMENT_DIR + File.separator + DocumentEnum.getDocumentTypeById(DocumentEnum.ADVERTISEMENTS.getDocumentId()) + File.separator + advertisementId;
        
        if (pdfUpload != null && !StringUtils.isBlank(pdfUploadName)) {
        	FileUtils.saveFile(pdfUpload, pdfUploadName, pdfUploadLocation);
        }
        
        if (pdfUploadMarathi != null && !StringUtils.isBlank(pdfUploadMarathiName)) {
        	FileUtils.saveFile(pdfUploadMarathi, pdfUploadMarathiName, pdfUploadLocation);
        }
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
	public void deleteAdvertisement(Long id) {
		log.debug("Deleting advertisement entry with the advertisement id: {}", id);
		advertisementRepository.delete(id);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
	public void changeStatus(Long advertisementId, boolean active) {
		log.debug("Changing the status of the document entry with the document id: {}", advertisementId);
		Advertisement advertisement = advertisementRepository.findOne(advertisementId);
		advertisement.setActive(active);
		advertisementRepository.save(advertisement);
		
	}
	
	@Override
	public List<Advertisement> getAdvertisementList() {
		log.debug("Getting the list of Advertisement");
		return advertisementRepository.findByActiveTrueAndClosingDateGreaterThan(LocalDate.now());
	}

}

