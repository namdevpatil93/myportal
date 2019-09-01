package com.msrtc.portal.core.common.web;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.msrtc.portal.document.domain.Document;
import com.msrtc.portal.document.domain.DocumentCategory;
import com.msrtc.portal.document.domain.DocumentEnum;
import com.msrtc.portal.document.domain.DocumentSubCategory;
import com.msrtc.portal.document.service.DocumentCategoryService;
import com.msrtc.portal.document.service.DocumentService;
import com.msrtc.portal.document.service.DocumentSubCategoryService;


@Controller
/*@RequestMapping(value = { StaticPagesController.STATIC_CONTROLLER_URL })*/
public class StaticPagesController {
	
	/*static final String STATIC_CONTROLLER_URL = "/";*/
	
	@Autowired
	private DocumentService documentService;

	@Autowired
	private DocumentCategoryService documentcategoryService; 
	
	@Autowired
	private DocumentSubCategoryService documentsubcategoryService;
	
	@GetMapping(value = "/recruitmentFee")
	public String recruitmentFee(Model model) {
		int documentType = DocumentEnum.RECRUITMENT_FEE.getDocumentId();
		List<Object> announcementList = new ArrayList<>();
		List<Object> docCategoryList=new ArrayList<>();
		List<Object> subdocCategoryList=new ArrayList<>();
		createDocumentList(documentType, announcementList,docCategoryList,subdocCategoryList);
		model.addAttribute("docCategoryList", docCategoryList);
		model.addAttribute("subdocCategoryList", subdocCategoryList);
		model.addAttribute("documentList", announcementList);
			//model.addAttribute("documentList", documentService.getDocumentListByDocumentType(documentType));
		model.addAttribute("headerTitle", DocumentEnum.getDocumentTypeById(documentType));
		return "menuPdfList";
	}

	private void createDocumentList(int documentType, List<Object> announcementList,List<Object> docCategoryList,List<Object> subdocCategoryList) {
		String locale = LocaleContextHolder.getLocale().toString();
		List<Object> categoryList = new ArrayList<>();
		List<Object> subCategoryList = new ArrayList<>();
		List<Document> documentList=documentService.getDocumentListByDocumentTypeAndCategoryTypeAndSubCategoryType(documentType,0,0);
		if ((documentList != null) && !documentList.isEmpty() ){
		for (Document document : documentList) {
			
			List<Object> localList = new ArrayList<>();
		
				localList.add(0, document.getId());
				if ( "en".equals(locale) ) {					
					localList.add(1, document.getTitle());
					localList.add(2, document.getDescription());
					localList.add(3,document.getCategoryType());
					localList.add(4,document.getSubCategoryType());
					categoryList.add(0,0);
					categoryList.add(1,"");
					subCategoryList.add(0,document.getCategoryType());
					subCategoryList.add(1,"");
					subCategoryList.add(2,0);
					//localList.add(3, document.getDocumentName());
				} else {
					localList.add(1, document.getTitleMarathi());
					localList.add(2, document.getDescriptionMarathi());
					localList.add(3,document.getCategoryType());
					localList.add(4,document.getSubCategoryType());
					categoryList.add(0,0);
					categoryList.add(1,"");
					subCategoryList.add(0,document.getCategoryType());
					subCategoryList.add(1,"");
					subCategoryList.add(2,0);
					//localList.add(3, document.getDocumentNameMarathi());
				}
				//localList.add(4, document.getDocumentType());
			
				announcementList.add(localList);
				
			}
		
		docCategoryList.add(categoryList);
		subdocCategoryList.add(subCategoryList);
		}
		
		
		for(DocumentCategory category:documentcategoryService.findByDocumentType(documentType)){
			
			List<Object> catList = new ArrayList<>();
			List<Object> subList=new ArrayList<>();
			long subCategoryId=0;
			long categoryId=category.getId();	
			List<Document> list=documentService.getDocumentListByDocumentTypeAndCategoryTypeAndSubCategoryType(documentType,(int) categoryId,0);
			if((list!=null) && !list.isEmpty() ){
			for (Document document : list) {
				
				List<Object> localList = new ArrayList<>();
				
					localList.add(0, document.getId());
					if ( "en".equals(locale) ) {
						
						localList.add(1, document.getTitle());
						localList.add(2, document.getDescription());
						localList.add(3,document.getCategoryType());
						localList.add(4,document.getSubCategoryType());
						catList.add(0,category.getId());
						catList.add(1,category.getCategoryTitle());
						subList.add(0,document.getCategoryType());
						subList.add(1,"");
						subList.add(2,0);
						//localList.add(3, document.getDocumentName());
					} else {
						localList.add(1, document.getTitleMarathi());
						localList.add(2, document.getDescriptionMarathi());
						localList.add(3,document.getCategoryType());
						localList.add(4,document.getSubCategoryType());
						catList.add(0,category.getId());
						catList.add(1,category.getCategoryTitleMarathi());
						subList.add(0,document.getCategoryType());
						subList.add(1,"");
						subList.add(2,0);
						//localList.add(3, document.getDocumentNameMarathi());
					}
					//localList.add(4, document.getDocumentType());
					
					announcementList.add(localList);
					
				}
			
			subdocCategoryList.add(subList);
			//docCategoryList.add(catList);
			}
			
			for(DocumentSubCategory subcategory:documentsubcategoryService.findByDocumentTypeAndCategoryType(documentType, (int)categoryId)){
				List<Object> subCatList = new ArrayList<>();
			
				 subCategoryId=subcategory.getId();
				 List<Document> elist=documentService.getDocumentListByDocumentTypeAndCategoryTypeAndSubCategoryType(documentType,(int) categoryId,(int) subCategoryId);
						 if((elist!=null) && !elist.isEmpty() ){
						 for (Document document :elist ) {
		
		List<Object> localList = new ArrayList<>();
			localList.add(0, document.getId());
			if ( "en".equals(locale) ) {
				
				localList.add(1, document.getTitle());
				localList.add(2, document.getDescription());
				localList.add(3,document.getCategoryType());
				localList.add(4,document.getSubCategoryType());
				catList.add(0,category.getId());
				catList.add(1,category.getCategoryTitle());
				subCatList.add(0,subcategory.getCategoryType());
				subCatList.add(1,subcategory.getSubCategoryTitle());
				subCatList.add(2,subcategory.getId());
				//localList.add(3, document.getDocumentName());
			} else {
				localList.add(1, document.getTitleMarathi());
				localList.add(2, document.getDescriptionMarathi());
				localList.add(3,document.getCategoryType());
				localList.add(4,document.getSubCategoryType());
				catList.add(0,category.getId());
				catList.add(1,category.getCategoryTitleMarathi());
				subCatList.add(0,subcategory.getCategoryType());
				subCatList.add(1,subcategory.getSubCategoryTitleMarathi());
				subCatList.add(2,subcategory.getId());
				//localList.add(3, document.getDocumentNameMarathi());
			}
			//localList.add(4, document.getDocumentType());
			announcementList.add(localList);
		}
		subdocCategoryList.add(subCatList);
			}
			}
			
		docCategoryList.add(catList);
		}
		
		
		}
		
		
	
	@GetMapping(value = "/importantInformation")
	public String importantInfo(Model model) {
		int documentType = DocumentEnum.INFORMATION.getDocumentId();
		
		List<Object> announcementList = new ArrayList<>();
		List<Object> docCategoryList=new ArrayList<>();
		List<Object> subdocCategoryList=new ArrayList<>();
		createDocumentList(documentType, announcementList,docCategoryList,subdocCategoryList);
		model.addAttribute("docCategoryList", docCategoryList);
		model.addAttribute("subdocCategoryList", subdocCategoryList);
		model.addAttribute("documentList", announcementList);
		model.addAttribute("headerTitle", DocumentEnum.getDocumentTypeById(documentType));
		return "menuPdfList";
	}

	@GetMapping(value = "/instructionForRegistration")
	public String instructionForRegistration(Model model) {
		int documentType = DocumentEnum.INSTRUCTIONS.getDocumentId();
		
		List<Object> announcementList = new ArrayList<>();
		List<Object> docCategoryList=new ArrayList<>();
		List<Object> subdocCategoryList=new ArrayList<>();
		createDocumentList(documentType, announcementList,docCategoryList,subdocCategoryList);
		model.addAttribute("docCategoryList", docCategoryList);
		model.addAttribute("subdocCategoryList", subdocCategoryList);
		model.addAttribute("documentList", announcementList);
		model.addAttribute("headerTitle", DocumentEnum.getDocumentTypeById(documentType));
		return "menuPdfList";
	}

	@GetMapping(value = "/timetable")
	public String timetable(Model model) {
		int documentType = DocumentEnum.TIMETABLE.getDocumentId();
		
		List<Object> announcementList = new ArrayList<>();
		List<Object> docCategoryList=new ArrayList<>();
		List<Object> subdocCategoryList=new ArrayList<>();
		createDocumentList(documentType, announcementList,docCategoryList,subdocCategoryList);
		model.addAttribute("docCategoryList", docCategoryList);
		model.addAttribute("subdocCategoryList", subdocCategoryList);
		model.addAttribute("documentList", announcementList);
		model.addAttribute("headerTitle", DocumentEnum.getDocumentTypeById(documentType));
		return "menuPdfList";
	}
	
	@GetMapping(value = "/result")
	public String result(Model model) {
		int documentType = DocumentEnum.RESULT.getDocumentId();
		
		List<Object> announcementList = new ArrayList<>();
		List<Object> docCategoryList=new ArrayList<>();
		List<Object> subdocCategoryList=new ArrayList<>();
		createDocumentList(documentType, announcementList,docCategoryList,subdocCategoryList);
		model.addAttribute("docCategoryList", docCategoryList);
		model.addAttribute("subdocCategoryList", subdocCategoryList);
		model.addAttribute("documentList", announcementList);
		model.addAttribute("headerTitle", DocumentEnum.getDocumentTypeById(documentType));
		return "menuPdfList";
	}

	@GetMapping(value = "/aboutUs")
	public String aboutUs() {
		return "aboutUs";
	}

}
