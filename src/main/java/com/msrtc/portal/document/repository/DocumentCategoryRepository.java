package com.msrtc.portal.document.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.msrtc.portal.core.common.repository.BaseRepository;
import com.msrtc.portal.document.domain.DocumentCategory;


public interface DocumentCategoryRepository extends BaseRepository<DocumentCategory, Long>,DocumentCategoryRepositoryCustom{

	List<DocumentCategory> findByDocumentType(int id);


	DocumentCategory findById(Long cid);

	@Query("select a from DocumentCategory a where a.documentType=:documentType AND (a.categoryTitle=:categoryTitle OR a.categoryTitleMarathi=:categoryTitleMarathi)")
	List<DocumentCategory> findDocumentCategoryByCategoryTitleAndCategoryTitleMarathiAndDocumentType(
			 @Param("categoryTitle")  String categoryTitle, @Param("categoryTitleMarathi") String categoryTitleMarathi,@Param("documentType") Integer documentType);

	@Query("select a from DocumentCategory a where a.id<>:id AND a.documentType=:documentType AND ( a.categoryTitle=:categoryTitle OR a.categoryTitleMarathi=:categoryTitleMarathi)")
	List<DocumentCategory> findDocumentCategoryByCategoryTitleAndCategoryTitleMarathiAndIdAndDocumentType(
			@Param("categoryTitle") String categoryTitle,@Param("categoryTitleMarathi")  String categoryTitleMarathi, @Param("id") long id,@Param("documentType") Integer documentType);


	List<DocumentCategory> findByDocumentTypeAndActive(int id, Boolean true1);

}
