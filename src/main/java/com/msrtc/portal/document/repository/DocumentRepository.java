package com.msrtc.portal.document.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.msrtc.portal.core.common.repository.BaseRepository;
import com.msrtc.portal.document.domain.Document;

public interface DocumentRepository extends BaseRepository<Document, Long>, DocumentRepositoryCustom {
	
	
	List<Document> findByDocumentTypeAndActive( int documentType, boolean active);


	List<Document> findByDocumentTypeAndCategoryTypeAndSubCategoryTypeAndActive(
			int documentType, int id, int sid, Boolean active);


	List<Document> findDocumentByCategoryType(int documentCategoryId);


	List<Document> findDocumentBySubCategoryType(int subCategoryId);


	


	

	
	
}

