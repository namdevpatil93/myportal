package com.msrtc.portal.document.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.msrtc.portal.document.domain.Document;
import com.msrtc.portal.document.domain.DocumentCategory;
import com.msrtc.portal.document.domain.DocumentSubCategory;

public interface DocumentSubCategoryService {

	boolean saveSubCategory(DocumentSubCategory subcategory);

	Page<DocumentSubCategory> searchSubCategory(Pageable pageable);

	DocumentSubCategory findDocumentSubCategoryById(int id);

	void deleteDocumentSubCategory(Long documentSubCategoryId);

	void changeSubCategoryStatus(Long subCategoryId, boolean active);

	List<DocumentSubCategory> findByCategoryType(int documentCategoryId);

	List<DocumentSubCategory> findByDocumentTypeAndCategoryType(int documentType, int id);

	List<DocumentSubCategory> getByCategoryType(int id);

	

	
	

	

	

}
