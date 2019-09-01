package com.msrtc.portal.document.service.impl;

import java.io.File;
import java.util.List;
import java.util.UUID;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.msrtc.portal.core.common.util.Constants;
import com.msrtc.portal.core.common.util.FileUtils;
import com.msrtc.portal.core.config.ApplicationProperties;
import com.msrtc.portal.document.domain.Document;
import com.msrtc.portal.document.domain.DocumentCategory;
import com.msrtc.portal.document.domain.DocumentEnum;
import com.msrtc.portal.document.domain.DocumentSubCategory;
import com.msrtc.portal.document.dto.DocumentSearchDTO;
import com.msrtc.portal.document.repository.DocumentRepository;
import com.msrtc.portal.document.repository.DocumentSubCategoryRepository;
import com.msrtc.portal.document.service.DocumentCategoryService;
import com.msrtc.portal.document.service.DocumentService;
import com.msrtc.portal.document.service.DocumentSubCategoryService;

@Service(value = "documentService")
@Transactional(readOnly = true)
public class DocumentServiceImpl implements DocumentService {

	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	private DocumentRepository documentRepository;
	
	@Autowired
	private DocumentSubCategoryService documentsubcategoryService;
	
	
	@Autowired
	private DocumentCategoryService documentcategoryService;
	
	
	@Autowired
    private ApplicationProperties applicationProperties;

	@Override
	public List<Document> findAllDocuments() {
		log.debug("Finding all document entries");
		return (List<Document>) documentRepository.findAll();
	}

	
	
	@Override
	public Page<Document> searchDocuments(DocumentSearchDTO documentSearchDTO, Pageable pageable){
		Page<Document> page= documentRepository.searchDocuments(documentSearchDTO, pageable);
		for(Document document:page){
			if(document.getCategoryType()!=0){
			int id=document.getCategoryType();
			DocumentCategory category=documentcategoryService.findById(id);
			document.setLableCategoryTitle(category.getCategoryTitle());
			document.setLableCategoryTitleMarathi(category.getCategoryTitleMarathi());
			}
		 if(document.getSubCategoryType()!=0){
			int subid=document.getSubCategoryType();
			DocumentSubCategory subCategory=documentsubcategoryService.findDocumentSubCategoryById(subid);
			document.setLableSubCategoryTitle(subCategory.getSubCategoryTitle());
			document.setLableSubCategoryTitleMarathi(subCategory.getSubCategoryTitleMarathi());
			}
		}
		return page;
	}

	@Override
	public Document findDocumentById(Long id) {
		log.debug("Finding document entry with the document id: {}", id);
		return documentRepository.findOne(id);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
	public void saveDocument(Document document, MultipartFile pdfUpload, MultipartFile pdfUploadMarathi) {
		log.debug("Saving Document with the information: {}", document);

		String basePath = applicationProperties.getResources().getBasePath();
		
		//String pdfUploadName = pdfUpload != null ? UUID.randomUUID().toString() + "_" + pdfUpload.getOriginalFilename() : null;
		String pdfFileExtension = pdfUpload != null ? pdfUpload.getOriginalFilename().substring(pdfUpload.getOriginalFilename().lastIndexOf(".")) : null;
		String pdfUploadName = pdfUpload != null ? UUID.randomUUID().toString()+pdfFileExtension : null;
		//String pdfUploadMarathiName = pdfUploadMarathi != null ? UUID.randomUUID().toString() + "_" + pdfUploadMarathi.getOriginalFilename() : null;
		String pdfMarathiFileExtension = pdfUploadMarathi != null ?  pdfUploadMarathi.getOriginalFilename().substring(pdfUploadMarathi.getOriginalFilename().lastIndexOf(".")) : null;
		String pdfUploadMarathiName = pdfUploadMarathi != null ? UUID.randomUUID().toString()+pdfMarathiFileExtension : null;
        

        boolean isNew = document.getId() == null ||  document.getId() == 0;
        Long documentId = null;
		if(isNew){
			document.setDocumentName(pdfUploadName);
			document.setDocumentNameMarathi(pdfUploadMarathiName);
			documentRepository.save(document);
			documentId = document.getId();
		} else {
			Document dbDocument = documentRepository.findOne(document.getId());

            dbDocument.setTitle(document.getTitle());
            dbDocument.setDescription(document.getDescription());
            dbDocument.setDocumentType(document.getDocumentType());
            dbDocument.setActive(document.isActive());
            dbDocument.setCategoryType(document.getCategoryType());
            dbDocument.setSubCategoryType(document.getSubCategoryType());
            if (!StringUtils.isBlank(pdfUploadName)) {
            	dbDocument.setDocumentName(pdfUploadName);
            }
            dbDocument.setTitleMarathi(document.getTitleMarathi());
            dbDocument.setDescriptionMarathi(document.getDescriptionMarathi());
            if (!StringUtils.isBlank(pdfUploadMarathiName)) {
            	dbDocument.setDocumentNameMarathi(pdfUploadMarathiName);
            }
            
            documentRepository.save(dbDocument);
            documentId = dbDocument.getId();
		}
		
		String pdfUploadLocation = basePath + File.separator + Constants.BASE_UPLOAD_DIR + File.separator + Constants.ADMIN_DIR + File.separator + Constants.DOCUMENT_DIR + File.separator + DocumentEnum.getDocumentTypeById(document.getDocumentType()) + File.separator + documentId;
        
        if (pdfUpload != null && !StringUtils.isBlank(pdfUploadName)) {
        	FileUtils.saveFile(pdfUpload, pdfUploadName, pdfUploadLocation);
        }
        
        if (pdfUploadMarathi != null && !StringUtils.isBlank(pdfUploadMarathiName)) {
        	FileUtils.saveFile(pdfUploadMarathi, pdfUploadMarathiName, pdfUploadLocation);
        }
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
	public void deleteDocument(Long id) {
		log.debug("Deleting document entry with the document id: {}", id);
		documentRepository.delete(id);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
	public void changeStatus(Long documentId, boolean active) {
		log.debug("Changing the status of the document entry with the document id: {}", documentId);
		Document document = documentRepository.findOne(documentId);
		document.setActive(active);
		documentRepository.save(document);
	}
	
	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
	public List<Document> getDocumentListByDocumentType(int documentType) {
		log.debug("Getting the list of Document by document type: {}", documentType);
		
		return documentRepository.findByDocumentTypeAndActive(documentType, Boolean.TRUE);
	}



	@Override
	public List<Document> getDocumentListByDocumentTypeAndCategoryTypeAndSubCategoryType(
			int documentType, int id,int sid) {
		
		return documentRepository.findByDocumentTypeAndCategoryTypeAndSubCategoryTypeAndActive(documentType,id,sid, Boolean.TRUE);
	}



	@Override
	public List<Document> findDocumentByCategoryType(int documentCategoryId) {
		
		return documentRepository.findDocumentByCategoryType( documentCategoryId);
	}



	@Override
	public List<Document> findDocumentBySubCategoryType(
			Long documentSubCategoryId) {
		long subCategoryId=documentSubCategoryId;
		return documentRepository.findDocumentBySubCategoryType((int)subCategoryId);
	}



	






	



	



	

}

