package com.msrtc.portal.document.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.msrtc.portal.core.common.repository.BaseRepository;
import com.msrtc.portal.document.domain.Document;
import com.msrtc.portal.document.domain.DocumentCategory;
import com.msrtc.portal.document.domain.DocumentSubCategory;


public interface DocumentSubCategoryRepository extends BaseRepository<DocumentSubCategory, Long>, DocumentSubCategoryRepositoryCustom{

	List<DocumentSubCategory> findByCategoryType(int documentCategoryId);
	
	@Query("select a from DocumentSubCategory a where a.documentType=:documentType AND categoryType=:categoryType AND (a.subCategoryTitle=:subCategoryTitle OR a.subCategoryTitleMarathi=:subCategoryTitleMarathi)")
	List<DocumentSubCategory> findDocumentSubCategoryBySubCategoryTitleAndSubCategoryTitleMarathiAndDocumentTypeAndCategoryType(
			 @Param("subCategoryTitle")	String subCategoryTitle, @Param("subCategoryTitleMarathi") String subCategoryTitleMarathi, @Param("documentType") Integer documentType,@Param("categoryType") Integer categoryType);

	@Query("select a from DocumentSubCategory a where a.id<>:id AND  a.documentType=:documentType AND categoryType=:categoryType AND(a.subCategoryTitle=:subCategoryTitle OR a.subCategoryTitleMarathi=:subCategoryTitleMarathi) ")
	List<DocumentSubCategory> findDocumentSubCategoryBySubCategoryTitleAndSubCategoryTitleMarathiAndIdAndDocumentTypeAndCategoryType(
			 @Param("subCategoryTitle")	String subCategoryTitle, @Param("subCategoryTitleMarathi") String subCategoryTitleMarathi,@Param("id") long id,@Param("documentType") Integer documentType,@Param("categoryType") Integer categoryType);

	List<DocumentSubCategory> findByDocumentTypeAndCategoryType(
			int documentType, int id);

	List<DocumentSubCategory> getByCategoryTypeAndActive(int id, Boolean active);

	}