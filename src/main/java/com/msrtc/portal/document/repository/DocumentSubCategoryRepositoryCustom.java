package com.msrtc.portal.document.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.msrtc.portal.document.domain.Document;
import com.msrtc.portal.document.domain.DocumentSubCategory;



public interface DocumentSubCategoryRepositoryCustom {
	
	Page<DocumentSubCategory> searchDocumentSubCategory(Pageable pageable);
	
}
