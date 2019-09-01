package com.msrtc.portal.advertisement.web;

import com.msrtc.portal.advertisement.domain.Advertisement;
import com.msrtc.portal.advertisement.dto.AdvertisementSearchDTO;
import com.msrtc.portal.advertisement.service.AdvertisementService;
import com.msrtc.portal.core.common.util.PageDetail;
import com.msrtc.portal.document.domain.DocumentEnum;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping(value = { "/advertisement"})
public class AdvertisementController {

	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	private AdvertisementService advertisementService;


    @Autowired
    private MessageSource messageSource;

	@RequestMapping(params = "operation=advertisementList")
	public String advertisementList(Model model, AdvertisementSearchDTO advertisementSearchDTO, PageDetail pageDetail) {
		log.debug("Finding all advertisement entries");
		Page<Advertisement> page = advertisementService.searchAdvertisements(advertisementSearchDTO, pageDetail.getPageable());

		int beginIndex = pageDetail.getBeginIndex(page.getNumber());
		model.addAttribute("beginIndex", beginIndex);
		model.addAttribute("endIndex", pageDetail.getEndIndex(page.getTotalPages(), beginIndex));

		model.addAttribute("page", page);
		model.addAttribute("pageDetail", pageDetail);
		model.addAttribute("advertisementSearchDTO", advertisementSearchDTO);
		model.addAttribute("documentType", DocumentEnum.ADVERTISEMENTS.getDocumentId());

		if(pageDetail.isNewPage()){
			return "advertisementListResult";
		} else {
			return "advertisementList";
		}
	}

	@RequestMapping(params = "operation=newAdvertisement")
	public String newAdvertisement(Model model) {
		log.debug("Showing form to create new advertisement entry");
		model.addAttribute("documentType", DocumentEnum.ADVERTISEMENTS.getDocumentId());
		return "advertisementForm";
	}

	@RequestMapping(params = "operation=editAdvertisement")
	public String editAdvertisement(Long id , Model model) {
		log.debug("Finding advertisement entry with the advertisement id: {}", id);
		model.addAttribute("advertisement", advertisementService.findAdvertisementById(id));
		model.addAttribute("documentType", DocumentEnum.ADVERTISEMENTS.getDocumentId());
		return "advertisementForm";
	}

	@RequestMapping(params = "operation=saveAdvertisement")
	public @ResponseBody Map<String, Object> saveAdvertisement(Advertisement advertisement, @RequestParam(required=false) MultipartFile pdfUpload, @RequestParam(required=false) MultipartFile pdfUploadMarathi) {
		log.debug("Saving Advertisement with the information: {}", advertisement);

		Map<String, Object> result = new HashMap<>();
		boolean success = true;
		try {
        	advertisementService.saveAdvertisement(advertisement, pdfUpload, pdfUploadMarathi);
		} catch(Exception e){
			log.error(e.getMessage());
			success = false;
		}
		result.put("advertisement", advertisement);
		result.put("success", success);
		return result;

	}

//	@RequestMapping(params = "operation=deleteAdvertisement")
//	public String deleteAdvertisement(Long id, final RedirectAttributes redirectAttributes) {
//		log.debug("Deleting advertisement entry with the advertisement id: {}", id);
//        try {
//            advertisementService.deleteAdvertisement(id);
//            redirectAttributes.addFlashAttribute("message", messageSource.getMessage("advertisement.deleted", null, LocaleContextHolder.getLocale()));
//        } catch(Exception e){
//            log.error(e.getMessage());
//            redirectAttributes.addFlashAttribute("error", messageSource.getMessage("advertisement.delete.failed", null, LocaleContextHolder.getLocale()));
//        }
//        return "redirect:/advertisement?operation=advertisementList";
//	}
	
	@RequestMapping(params = "operation=deleteAdvertisement")
	public @ResponseBody Map<String, Object> deleteDocument(@RequestParam("id") Long id) {
		log.debug("Deleting advertisement entry with the advertisement id: {}", id);
		Map<String, Object> result = new HashMap<>();
		boolean success = true;
		try {
			advertisementService.deleteAdvertisement(id);
		} catch(Exception e){
			log.error(e.getMessage());
			success = false;
		}
		result.put("documentType", DocumentEnum.ADVERTISEMENTS.getDocumentId());
		result.put("success", success);
		return result;
	}
	
	@RequestMapping(params = "operation=changeStatus")
	public @ResponseBody Map<String, Object> changeStatus(Long advertisementId, boolean active) {
		log.debug("Changing the status of the advertisementId with ID: {}", advertisementId);
		Map<String, Object> result = new HashMap<>();
		boolean success = true;
		try {
			advertisementService.changeStatus(advertisementId, active);
		} catch(Exception e){
			log.error(e.getMessage());
			success = false;
		}
		result.put("success", success);
		return result;
	}

}

