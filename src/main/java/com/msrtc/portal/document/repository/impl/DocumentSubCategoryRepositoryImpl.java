package com.msrtc.portal.document.repository.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.msrtc.portal.document.domain.DocumentSubCategory;
import com.msrtc.portal.document.repository.DocumentSubCategoryRepository;
import com.msrtc.portal.document.repository.DocumentSubCategoryRepositoryCustom;

public class DocumentSubCategoryRepositoryImpl implements DocumentSubCategoryRepositoryCustom {

	@Autowired
	DocumentSubCategoryRepository documentSubCategoryRepository;

	

	@Override
	public Page<DocumentSubCategory> searchDocumentSubCategory(Pageable pageable) {
		
		return documentSubCategoryRepository.findAll(pageable);
	}
}
