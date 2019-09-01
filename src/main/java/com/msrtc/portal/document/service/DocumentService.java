package com.msrtc.portal.document.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.multipart.MultipartFile;

import com.msrtc.portal.advertisement.domain.Advertisement;
import com.msrtc.portal.document.domain.DocumentCategory;
import com.msrtc.portal.document.domain.Document;
import com.msrtc.portal.document.dto.DocumentSearchDTO;

public interface DocumentService {

    List<Document> findAllDocuments();

    Page<Document> searchDocuments(DocumentSearchDTO documentSearchDTO, Pageable pageable);

    Document findDocumentById(Long id) ;

    void saveDocument(Document document, MultipartFile pdfUpload, MultipartFile pdfUploadMarathi);

    void deleteDocument(Long id);

    void changeStatus(Long documentId, boolean active);
    
    List<Document> getDocumentListByDocumentType(int documentType);

    

    List<Document> getDocumentListByDocumentTypeAndCategoryTypeAndSubCategoryType(
			int documentType, int id, int sid);

	List<Document> findDocumentByCategoryType(int documentCategoryId);

	List<Document> findDocumentBySubCategoryType(Long documentSubCategoryId);

	 

	
	

	
    
}

