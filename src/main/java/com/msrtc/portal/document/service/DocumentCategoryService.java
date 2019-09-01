package com.msrtc.portal.document.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.msrtc.portal.document.domain.DocumentCategory;

public interface DocumentCategoryService {

	boolean saveCategory(DocumentCategory category);

	Page<DocumentCategory> searchCategory(Pageable pageable);

	void changeCategoryStatus(Long categoryId, boolean active);

	DocumentCategory findDocumentCategoryById(Long id);

	void deleteDocumentCategory(int documentCategoryId);

	

	List<DocumentCategory> findByDocumentType(int id);

	

	DocumentCategory findById(int id);

	List<DocumentCategory> findall();

	

	

	

	

	

	

	

}
