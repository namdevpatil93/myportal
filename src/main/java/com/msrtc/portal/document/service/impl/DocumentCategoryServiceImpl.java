package com.msrtc.portal.document.service.impl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.msrtc.portal.document.domain.DocumentCategory;
import com.msrtc.portal.document.domain.DocumentEnum;
import com.msrtc.portal.document.repository.DocumentCategoryRepository;
import com.msrtc.portal.document.service.DocumentCategoryService;


@Service(value = "documentcategoryService")
@Transactional(readOnly = true)
public class DocumentCategoryServiceImpl implements DocumentCategoryService{
	
	@Autowired
	DocumentCategoryRepository documentCategoryRepository;
	
	private final Logger log = LoggerFactory.getLogger(getClass());

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
	public boolean saveCategory(DocumentCategory category) {
		boolean exists=false;
			boolean isNew = category.getId() == null ||  category.getId() == 0;
	        Long documentCategoryId = null;
		if(isNew){
				 List<DocumentCategory> list= documentCategoryRepository.findDocumentCategoryByCategoryTitleAndCategoryTitleMarathiAndDocumentType(category.getCategoryTitle(),category.getCategoryTitleMarathi(),category.getDocumentType());
				if ((list != null) && !list.isEmpty()){
						exists=true;
				}else{
				category.setDocumentTypeLable(DocumentEnum.getDocumentTypeById(category.getDocumentType()));
				documentCategoryRepository.save(category);
				documentCategoryId = category.getId();
						}
			} else {
				DocumentCategory dbCategory = documentCategoryRepository.findOne(category.getId());
				 List<DocumentCategory> list= documentCategoryRepository.findDocumentCategoryByCategoryTitleAndCategoryTitleMarathiAndIdAndDocumentType(category.getCategoryTitle(),category.getCategoryTitleMarathi(),category.getId(),category.getDocumentType());
					if ((list != null) && !list.isEmpty()){
							exists=true;
					}else{
				dbCategory.setDocumentTypeLable(DocumentEnum.getDocumentTypeById(category.getDocumentType()));
				dbCategory.setCategoryTitle(category.getCategoryTitle());
				dbCategory.setCategoryTitleMarathi(category.getCategoryTitleMarathi());
				dbCategory.setDocumentType(category.getDocumentType());
				dbCategory.setActive(category.isActive());
	            documentCategoryRepository.save(dbCategory);
	            documentCategoryId = dbCategory.getId();
					}
			}
		
		return exists;
	}


	@Override
	public Page<DocumentCategory> searchCategory(Pageable pageable) {
		Page<DocumentCategory> page=documentCategoryRepository.searchCategory(pageable);
		for (DocumentCategory documentCategory : page) {
			documentCategory.setDocumentTypeLable(DocumentEnum.getDocumentTypeById(documentCategory.getDocumentType()));
			
		}
		return page;
	}


	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
	public void changeCategoryStatus(Long categoryId, boolean active) {
		DocumentCategory category = documentCategoryRepository.findOne(categoryId);
		category.setActive(active);
		documentCategoryRepository.save(category);
		
	}


	@Override
	public DocumentCategory findDocumentCategoryById(Long id) {
		
		return documentCategoryRepository.findOne(id);
	}


	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
	public void deleteDocumentCategory(int documentCategoryId) {
		documentCategoryRepository.delete((long) documentCategoryId);
	}




	


	@Override
	public List<DocumentCategory> findByDocumentType(int id) {
		// TODO Auto-generated method stub
		return documentCategoryRepository.findByDocumentTypeAndActive(id,Boolean.TRUE);
	}


	@Override
	public DocumentCategory findById(int id) {
		Long cid=(long) id;
		return documentCategoryRepository.findById(cid);
	}


	@Override
	public List<DocumentCategory> findall() {
		
		return (List<DocumentCategory>) documentCategoryRepository.findAll();
	}






	


	


	


	

	


	

}
