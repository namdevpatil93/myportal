package com.msrtc.portal.document.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.msrtc.portal.core.common.util.PageDetail;
import com.msrtc.portal.document.domain.Document;
import com.msrtc.portal.document.domain.DocumentCategory;
import com.msrtc.portal.document.domain.DocumentEnum;
import com.msrtc.portal.document.domain.DocumentSubCategory;
import com.msrtc.portal.document.dto.DocumentSearchDTO;
import com.msrtc.portal.document.service.DocumentCategoryService;
import com.msrtc.portal.document.service.DocumentService;
import com.msrtc.portal.document.service.DocumentSubCategoryService;

@Controller
@RequestMapping(value = { "/documents"})
public class DocumentController {

	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	private DocumentService documentService;
	
	@Autowired
	private DocumentCategoryService documentcategoryService;
	
	@Autowired
	private DocumentSubCategoryService documentsubcategoryService;
	

	@RequestMapping(params = "operation=allDocuments")
	public String allDocuments(Model model) {
		log.debug("Showing all documents");
		return "allDocuments";
	}
	
	@RequestMapping(params = "operation=categoryList")
	public String documentCategory(Model model,DocumentCategory documentType,PageDetail pageDetail) {
		log.debug("Showing all documentCategory category");
		Page<DocumentCategory> page=documentcategoryService.searchCategory(pageDetail.getPageable());
	
		int beginIndex = pageDetail.getBeginIndex(page.getNumber());
		model.addAttribute("beginIndex", beginIndex);
		model.addAttribute("endIndex", pageDetail.getEndIndex(page.getTotalPages(), beginIndex));

		model.addAttribute("page", page);
		model.addAttribute("pageDetail", pageDetail);
		if(pageDetail.isNewPage()){
			return "categoryListResult";
		} else {
			return "categoryList";
		}
		
	}

	@RequestMapping(params = "operation=documentList")
	public String documentList(Model model, DocumentSearchDTO documentSearchDTO, PageDetail pageDetail) {
		log.debug("Finding all document entries");
        Page<Document> page = documentService.searchDocuments(documentSearchDTO, pageDetail.getPageable());
        for(Document document:page){
        	model.addAttribute("documentType", document.getDocumentType());
        }
		int beginIndex = pageDetail.getBeginIndex(page.getNumber());
		model.addAttribute("beginIndex", beginIndex);
		model.addAttribute("endIndex", pageDetail.getEndIndex(page.getTotalPages(), beginIndex));

		model.addAttribute("page", page);
		model.addAttribute("pageDetail", pageDetail);
		model.addAttribute("documentSearchDTO", documentSearchDTO);

		if(pageDetail.isNewPage()){
            return "documentListResult";
		} else {
            return "documentList";
		}
	}
	
	@RequestMapping(params = "operation=subCategoryList")
	public String documentSubCategoryList(Model model, PageDetail pageDetail) {
		log.debug("Finding all documentSubCategory entries");
        Page<DocumentSubCategory> page = documentsubcategoryService.searchSubCategory( pageDetail.getPageable());

		int beginIndex = pageDetail.getBeginIndex(page.getNumber());
		model.addAttribute("beginIndex", beginIndex);
		model.addAttribute("endIndex", pageDetail.getEndIndex(page.getTotalPages(), beginIndex));

		model.addAttribute("page", page);
		model.addAttribute("pageDetail", pageDetail);
		

		if(pageDetail.isNewPage()){
            return "subCategoryListResult";
		} else {
            return "subCategoryList";
		}
	}

	@RequestMapping(params = "operation=newDocument")
	public String newDocument(Model model, int documentType) {
		log.debug("Showing form to create new document entry");
		model.addAttribute("documentType", documentType);
		List<DocumentCategory> categorytype=documentcategoryService.findByDocumentType(documentType);
		model.addAttribute("categorytype", categorytype);
		return "documentForm";
	}
	
	@RequestMapping(params = "operation=newCategory")
	public String newCategory(Model model) {
		log.debug("Showing form to create new category entry");
		 DocumentEnum[] document=DocumentEnum.values();
		 model.addAttribute("document", document);
		return "categoryForm";
	}
	
	@RequestMapping(params = "operation=newSubCategory")
	public String newSubCategory(Model model) {
		log.debug("Showing form to create new sub category entry");
		 DocumentEnum[] document=DocumentEnum.values();
		 model.addAttribute("document", document);
		return "subCategoryForm";
	}

	@RequestMapping(params = "operation=editDocument")
	public String editDocument(Long id , int documentType, Model model) {
		log.debug("Finding document entry with the document id: {}", id);
		Document document= documentService.findDocumentById(id);
		List<DocumentCategory> categorytype=documentcategoryService.findByDocumentType(documentType);
		int categoryid=document.getCategoryType();
		List<DocumentSubCategory> subcategorytype=documentsubcategoryService.findByCategoryType(categoryid);
		/*for(DocumentCategory category:categorytype){
			long cid=category.getId();
			List<DocumentSubCategory> subcategorytype=documentsubcategoryService.findByCategoryType((int)cid);
		}*/
	
		model.addAttribute("document", document);
		model.addAttribute("categorytype", categorytype);
		model.addAttribute("subcategorytype", subcategorytype);
		model.addAttribute("documentType", documentType);
		return "documentForm";
	}
	
	@RequestMapping(params = "operation=editCategory")
	public String editCategory(Long id , Model model) {
		log.debug("Finding documentCategory entry with the document id: {}", id);
		DocumentCategory allcategory=documentcategoryService.findDocumentCategoryById(id);
		model.addAttribute("DocumentCategory", allcategory);
		DocumentEnum[] document= DocumentEnum.values();
		 model.addAttribute("document", document);
		 return "categoryForm";
	}
	
	@RequestMapping(params = "operation=editSubCategory")
	public String editSubCategory(int id , Model model) {
		log.debug("Finding documentSubCategory entry with the document id: {}", id);
		DocumentSubCategory allsubcategory=documentsubcategoryService.findDocumentSubCategoryById(id);
		List<DocumentCategory> category=documentcategoryService.findByDocumentType(allsubcategory.getDocumentType());
		model.addAttribute("DocumentSubCategory", allsubcategory);
		DocumentEnum[] document= DocumentEnum.values();
		 model.addAttribute("document", document);
		 model.addAttribute("categorytype", category);
		 return "subCategoryForm";
	}

	@RequestMapping(params = "operation=saveDocument")
	public @ResponseBody Map saveDocument(Document document, @RequestParam(required=false) MultipartFile pdfUpload, @RequestParam(required=false) MultipartFile pdfUploadMarathi) {
		log.debug("Saving Document with the information: {}", document);
	
		Map<String, Object> result = new HashMap<>();
		boolean success = true;
		try {
			documentService.saveDocument(document, pdfUpload, pdfUploadMarathi);
		} catch(Exception e){
			log.error(e.getMessage());
			success = false;
		}
		result.put("document", document);
		result.put("success", success);
		return result;
	}
	
	@RequestMapping(params = "operation=saveCategory")	
	public @ResponseBody Map saveCategory(Model model, DocumentCategory category) {
		Map<String, Object> result = new HashMap<>();
		boolean success = true;
		boolean documentCategoryexists=false;
			log.debug("Saving DocumentCategory with the information: {}", category);			
			try{
				documentCategoryexists=documentcategoryService.saveCategory(category );				
			}catch(Exception e){
				e.printStackTrace();
				log.error(e.getMessage());
				success = false;
			}
			
			result.put("category", category);
			result.put("success", success);
			result.put("documentCategoryexists",documentCategoryexists);
			return result;
		
	}
	
	@RequestMapping(params = "operation=saveSubCategory")	
	public @ResponseBody Map saveSubCategory(Model model,DocumentSubCategory subcategory) {
		Map<String, Object> result = new HashMap<>();
		boolean success = true;
		boolean documentSubCategoryexists=false;
			log.debug("Saving DocumentSubCategory with the information: {}", subcategory);
			try{
				
				documentSubCategoryexists=documentsubcategoryService.saveSubCategory(subcategory );				
			}catch(Exception e){
				e.printStackTrace();
				log.error(e.getMessage());
				success = false;
			}
			
			result.put("subcategory", subcategory);
			result.put("success", success);
			result.put("documentSubCategoryexists",documentSubCategoryexists);
			return result;
		
	}
	
	@RequestMapping(params = "operation=documentSubCategoryfetch")
	public  @ResponseBody List<DocumentCategory> fetch(Model model,int id) {
		List<DocumentCategory> category= documentcategoryService.findByDocumentType(id);
		model.addAttribute("category", category);
		return category;
	}
	
	@RequestMapping(params = "operation=documentSubCategoryfetchById")
	public  @ResponseBody List<DocumentSubCategory> fetchbyId(Model model,int id) {
		List<DocumentSubCategory> subcategory= documentsubcategoryService.getByCategoryType(id);
		model.addAttribute("subcategory", subcategory);
		return subcategory;
	}
	
	@RequestMapping(params = "operation=changeStatus")
	public @ResponseBody Map changeStatus(Long documentId, boolean active) {
		log.debug("Changing the status of the document with ID: {}", documentId);
		Map<String, Object> result = new HashMap<>();
		boolean success = true;
		try {
			documentService.changeStatus(documentId, active);
		} catch(Exception e){
			log.error(e.getMessage());
			success = false;
		}
		result.put("success", success);
		return result;
	}
	
	@RequestMapping(params = "operation=changeCategoryStatus")
	public @ResponseBody Map changeCategoryStatus(Long categoryId, boolean active) {
		log.debug("Changing the status of the category with ID: {}", categoryId);
		Map<String, Object> result = new HashMap<>();
		boolean success = true;
		try {
			documentcategoryService.changeCategoryStatus(categoryId, active);
		} catch(Exception e){
			log.error(e.getMessage());
			success = false;
		}
		result.put("success", success);
		return result;
	}
	
	@RequestMapping(params = "operation=changeSubCategoryStatus")
	public @ResponseBody Map changeSubCategoryStatus(Long subCategoryId, boolean active) {
		
		log.debug("Changing the status of the subcategory with ID: {}", subCategoryId);
		Map<String, Object> result = new HashMap<>();
		boolean success = true;
		try {
			documentsubcategoryService.changeSubCategoryStatus(subCategoryId, active);
			
		} catch(Exception e){
			log.error(e.getMessage());
			success = false;
		}
		result.put("success", success);
		return result;
	}
	
	@RequestMapping(params = "operation=deleteDocument")
	public @ResponseBody Map deleteDocument(@RequestParam("documentId") Long documentId, @RequestParam("documentType") int documentType) {
		log.debug("Delete document entry with the document id: {}", documentId);
		Map<String, Object> result = new HashMap<>();
		boolean success = true;
		try {
			documentService.deleteDocument(documentId);
		} catch(Exception e){
			log.error(e.getMessage());
			success = false;
		}
		result.put("documentType", documentType);
		result.put("success", success);
		return result;
	}
	
	@RequestMapping(params = "operation=deleteDocumentCategory")
	public @ResponseBody Map deleteDocumentCategory(@RequestParam("id") int documentCategoryId, @RequestParam("documentType") int documentType) {
		log.debug("Delete documentCategory entry with the document id: {}", documentCategoryId);
		Map<String, Object> result = new HashMap<>();
		boolean success = true;	
		boolean categoryExists = true;
		boolean documentExists = true;
		try {	
			List<DocumentSubCategory> subcategorylist=documentsubcategoryService.findByCategoryType(documentCategoryId);
			List<Document> document=documentService.findDocumentByCategoryType(documentCategoryId);
			if ((subcategorylist != null) && !subcategorylist.isEmpty()){
				categoryExists=false;
			}						
			else if ((document != null) && !document.isEmpty()){
				documentExists=false;
			} 
			else{
				documentcategoryService.deleteDocumentCategory(documentCategoryId);
				
			}
		} catch(Exception e){
			log.error(e.getMessage());
			success = false;
		}
			
		
		result.put("documentType", documentType);
		result.put("success", success);
		result.put("documentExists", documentExists);
		result.put("categoryExists", categoryExists);
		
		return result;
	}
	
	@RequestMapping(params = "operation=deleteDocumentSubCategory")
	public @ResponseBody Map deleteDocumentSubCategory(@RequestParam("id") Long documentSubCategoryId) {
		log.debug("Delete documentSubCategory entry with the document id: {}", documentSubCategoryId);
		Map<String, Object> result = new HashMap<>();
		boolean success = true;
		boolean documentExists = true;
		try {
			List<Document> document=documentService.findDocumentBySubCategoryType(documentSubCategoryId);
			
			 if ((document != null) && !document.isEmpty()){
					documentExists=false;
				} 
				else{
			documentsubcategoryService.deleteDocumentSubCategory(documentSubCategoryId);
				}
		} catch(Exception e){
			log.error(e.getMessage());
			success = false;
		}
		result.put("success", success);
		result.put("documentExists", documentExists);
		return result;
	}
	
	
	@GetMapping(value="/viewAnnouncementList")
	public String showDocuments(Model model) {
	log.debug("Show all document entries");
		
		int documentType = DocumentEnum.ANNOUNCEMENTS.getDocumentId();
		String locale = LocaleContextHolder.getLocale().toString();
		
		
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
		
		return "documents";
	}
	
	

}

