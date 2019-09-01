package com.msrtc.portal.core.common.web;

import java.util.ArrayList;
import java.util.List;

import com.msrtc.portal.core.systemsetting.service.SystemSettingService;
import com.msrtc.portal.core.systemsetting.util.SystemSettingEnum;
import com.msrtc.portal.message.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.msrtc.portal.advertisement.domain.Advertisement;
import com.msrtc.portal.advertisement.service.AdvertisementService;
import com.msrtc.portal.document.domain.Document;
import com.msrtc.portal.document.domain.DocumentEnum;
import com.msrtc.portal.document.service.DocumentService;

@Controller
public class CommonController {
	
	@Autowired
	private AdvertisementService advertisementService;

	@Autowired
	private DocumentService documentService;

	@Autowired
	private SystemSettingService systemSettingService;

	@Autowired
	private MessageService messageService;

	@GetMapping(value = "/")
	public String landingPage(Model model) {
		int documentType = DocumentEnum.ANNOUNCEMENTS.getDocumentId();
		String locale = LocaleContextHolder.getLocale().toString();
		
		List<Object> advertisementList = new ArrayList<>();
		for (Advertisement advertisement : advertisementService.getAdvertisementList()) {
			List<Object> localList = new ArrayList<>();
			localList.add(0, advertisement.getId());
			if ( "en".equals(locale) ) {
				localList.add(1, advertisement.getAdvertisementNo());
				localList.add(2, advertisement.getTitle());
				localList.add(3, advertisement.getDescription());
			} else {
				localList.add(1, advertisement.getAdvertisementNoMarathi());
				localList.add(2, advertisement.getTitleMarathi());
				localList.add(3, advertisement.getDescriptionMarathi());
			}
			localList.add(4, advertisement.getStartDate());
			localList.add(5, advertisement.getClosingDate());
			advertisementList.add(localList);
		}
		
		model.addAttribute("advertisementList", advertisementList);
		
		List<Object> announcementList = new ArrayList<>();
		for (Document document : documentService.getDocumentListByDocumentType(documentType)) {
			List<Object> localList = new ArrayList<>();
			localList.add(0, document.getId());
			if ( "en".equals(locale) ) {
				localList.add(1, document.getTitle());
				localList.add(2, document.getDescription());
				//localList.add(3, document.getDocumentName());
			} else {
				localList.add(1, document.getTitleMarathi());
				localList.add(2, document.getDescriptionMarathi());
				//localList.add(3, document.getDocumentNameMarathi());
			}
			//localList.add(4, document.getDocumentType());
			announcementList.add(localList);
		}
		model.addAttribute("announcementList", announcementList);

		String disableNewRegistration = systemSettingService.getSystemSetting(SystemSettingEnum.DISABLE_NEW_REGISTRATION);
		model.addAttribute("disableNewRegistration", disableNewRegistration);

		model.addAttribute("activeMessages", messageService.findAllActiveMessages());

		return "landingPage";
	}

}
