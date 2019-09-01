package com.msrtc.portal.document.repository.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;

import com.msrtc.portal.applicant.domain.ApplicantPostAssoc;
import com.msrtc.portal.core.common.util.PageDetail;
import com.msrtc.portal.document.domain.DocumentCategory;
import com.msrtc.portal.document.repository.DocumentCategoryRepository;
import com.msrtc.portal.document.repository.DocumentCategoryRepositoryCustom;
import com.msrtc.portal.document.repository.DocumentRepository;

public class DocumentCategoryRepositoryImpl implements DocumentCategoryRepositoryCustom{

	 @Autowired
	    private DocumentCategoryRepository documentCategoryRepository;
	
	@Override
	public Page<DocumentCategory> searchCategory(Pageable pageable) {
		
		return documentCategoryRepository.findAll(pageable);
	}



	
	
	
}
