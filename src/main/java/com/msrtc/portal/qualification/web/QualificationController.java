package com.msrtc.portal.qualification.web;

import com.msrtc.portal.qualification.custom.exception.DuplicateCheckInQualification;
import com.msrtc.portal.qualification.custom.exception.QualificationFileEmptyException;
import com.msrtc.portal.qualification.domain.Qualification;
import com.msrtc.portal.qualification.dto.QualificationSearchDTO;
import com.msrtc.portal.qualification.respository.QualificationRepository;
import com.msrtc.portal.qualification.service.QualificationService;
import com.msrtc.portal.core.common.util.Constants;
import com.msrtc.portal.core.common.util.FileUtils;
import com.msrtc.portal.core.common.util.PageDetail;
import com.msrtc.portal.core.config.ApplicationProperties;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping(value = { "/qualifications"})
public class QualificationController {

	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	private QualificationService qualificationService;
	
	
	
	@Autowired
	private ApplicationProperties applicationProperties;

	@RequestMapping(params = "operation=qualificationList")
	public String qualificationList(Model model, QualificationSearchDTO qualificationSearchDTO, PageDetail pageDetail) {
		log.debug("Finding all qualification entries");
		Page<Qualification> page = qualificationService.searchQualifications(qualificationSearchDTO, pageDetail.getPageable());

		int beginIndex = pageDetail.getBeginIndex(page.getNumber());
		model.addAttribute("beginIndex", beginIndex);
		model.addAttribute("endIndex", pageDetail.getEndIndex(page.getTotalPages(), beginIndex));

		model.addAttribute("page", page);
		model.addAttribute("pageDetail", pageDetail);
		model.addAttribute("qualificationSearchDTO", qualificationSearchDTO);

		if(pageDetail.isNewPage()){
			return "qualificationListResult";
		} else {
			return "qualificationList";
		}
	}

	@RequestMapping(params = "operation=newQualification")
	public String newQualification() {
		log.debug("Showing form to create new qualification entry");
		return "qualificationForm";
	}

	@RequestMapping(params = "operation=editQualification")
	public String editQualification(Long id , Model model) {
		log.debug("Finding qualification entry with the qualification id: {}", id);
		model.addAttribute("qualification", qualificationService.findQualificationById(id));
		return "qualificationForm";
	}

	@RequestMapping(params = "operation=saveQualification")
	public @ResponseBody Map<String, Object> saveQualification(Qualification qualification) {
		log.debug("Saving Qualification with the information: {}", qualification);

		Map<String, Object> result = new HashMap<>();
		boolean success = true;
		boolean exist=false;
		try {
			
			 exist=qualificationService.saveQualification(qualification);
        	
		} catch(Exception e){
			log.error(e.getMessage());
			success = false;
		}
		result.put("exist", exist);
		result.put("qualification", qualification);
		result.put("success", success);
		return result;

	}

	@RequestMapping(params = "operation=deleteQualification")
	public @ResponseBody Map<String, Object> deleteQualification(@RequestParam("id") Long id) {
		log.debug("Deleting qualification entry with the qualification id: {}", id);
		Map<String, Object> result = new HashMap<>();
		boolean success = true;
		try {
			qualificationService.deleteQualification(id);
		} catch(Exception e){
			log.error(e.getMessage());
			success = false;
		}
		result.put("success", success);
		return result;
	}
	
	@RequestMapping(params = "operation=uploadQualificationExcel")
	public @ResponseBody Map<String, Object> uploadQualificationExcel(@RequestParam MultipartFile bulkQualificationUploadfile) {
		log.debug("Saving Qualification with the information: {}");
		Map<String, Object> result = new HashMap<>();
		boolean success = true;		
		
		String basePath = applicationProperties.getResources().getBasePath();

        String fileExtension = bulkQualificationUploadfile.getOriginalFilename().substring(bulkQualificationUploadfile.getOriginalFilename().lastIndexOf("."));
        String fileName = UUID.randomUUID().toString() + "_" + bulkQualificationUploadfile.getOriginalFilename();
        String fileLocation = basePath + File.separator + Constants.BASE_UPLOAD_DIR + File.separator + Constants.QUALIFICATION_UPLOAD;

        FileUtils.saveFile(bulkQualificationUploadfile, fileName, fileLocation);
		
       boolean exist = false;
       boolean fileIsEmpty=false;
       boolean duplicateEntry=false;
	try {
		exist = qualificationService.processMultipleQualification(fileLocation, fileName, fileExtension);
	}catch(QualificationFileEmptyException qce){
		fileIsEmpty=true;
		result.put("fileIsEmpty", fileIsEmpty);
		log.debug("File not uploaded!");
		return result;
	}
	catch(DuplicateCheckInQualification dcq){
		duplicateEntry=true;
		result.put("duplicateEntry", duplicateEntry);
		return result;
	}
	catch (Exception e) {
		success=false;
		
		e.printStackTrace();
		result.put("success", success);
		return result;
	}
		
       result.put("success", success);
       result.put("exist", exist);
       return result;
       
       // return "redirect:admin?operation=administration&menu=administration";
	}
		
	

	}
	
	
	


