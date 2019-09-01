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

















import com.msrtc.portal.document.domain.Document;
import com.msrtc.portal.document.domain.DocumentCategory;
import com.msrtc.portal.document.domain.DocumentEnum;
import com.msrtc.portal.document.domain.DocumentSubCategory;
import com.msrtc.portal.document.repository.DocumentCategoryRepository;
import com.msrtc.portal.document.repository.DocumentSubCategoryRepository;
import com.msrtc.portal.document.service.DocumentCategoryService;
import com.msrtc.portal.document.service.DocumentSubCategoryService;

@Service(value = "documentsubcategoryService")
@Transactional(readOnly = true)
public class DocumentSubCategoryServiceImpl implements DocumentSubCategoryService{
	
	private final Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	DocumentSubCategoryRepository documentSubCategoryRepository;
	
	@Autowired
	private DocumentCategoryService documentcategoryService;

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
	public boolean saveSubCategory(DocumentSubCategory subcategory) {
		boolean exists=false;
		boolean isNew = subcategory.getId() == null ||  subcategory.getId() == 0;
		   Long documentSubCategoryId = null;
	
		
		if(isNew){
			List<DocumentSubCategory> list=documentSubCategoryRepository.findDocumentSubCategoryBySubCategoryTitleAndSubCategoryTitleMarathiAndDocumentTypeAndCategoryType(subcategory.getSubCategoryTitle(),subcategory.getSubCategoryTitleMarathi(),subcategory.getDocumentType(),subcategory.getCategoryType());
			if ((list != null) && !list.isEmpty() ){
				exists=true;
			}
			else{
			documentSubCategoryRepository.save(subcategory);
			documentSubCategoryId = subcategory.getId();
			}
			
		} else {
			DocumentSubCategory dbSubCategory = documentSubCategoryRepository.findOne(subcategory.getId());
			
            List<DocumentSubCategory> editlist=documentSubCategoryRepository.findDocumentSubCategoryBySubCategoryTitleAndSubCategoryTitleMarathiAndIdAndDocumentTypeAndCategoryType(subcategory.getSubCategoryTitle(),subcategory.getSubCategoryTitleMarathi(),subcategory.getId(),subcategory.getDocumentType(),subcategory.getCategoryType());
              if ((editlist != null) && !editlist.isEmpty() ){
            	exists=true;
              } else{
            	  dbSubCategory.setSubCategoryTitle(subcategory.getSubCategoryTitle());
            	  dbSubCategory.setSubCategoryTitleMarathi(subcategory.getSubCategoryTitleMarathi());
            	  dbSubCategory.setDocumentType(subcategory.getDocumentType());
            	  dbSubCategory.setActive(subcategory.isActive());
            	  dbSubCategory.setCategoryType(subcategory.getCategoryType());
            	documentSubCategoryRepository.save(dbSubCategory);	 
	           }
           	
		}
		
		return exists;
	}

	@Override
	public Page<DocumentSubCategory> searchSubCategory(Pageable pageable) {
		Page<DocumentSubCategory> page= documentSubCategoryRepository.searchDocumentSubCategory(pageable);
		for(DocumentSubCategory documentSubCategory:page){
			documentSubCategory.setDocumentTypeLable(DocumentEnum.getDocumentTypeById(documentSubCategory.getDocumentType()));
			int id=documentSubCategory.getCategoryType();
			DocumentCategory category=documentcategoryService.findById(id);
			documentSubCategory.setCategoryTypeLable(category.getCategoryTitle());
		}
		
		return page;
	}

	@Override
	public DocumentSubCategory findDocumentSubCategoryById(int id) {
		
		return documentSubCategoryRepository.findOne((long) id);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
	public void deleteDocumentSubCategory(Long documentSubCategoryId) {
		documentSubCategoryRepository.delete(documentSubCategoryId);
		
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
	public void changeSubCategoryStatus(Long subCategoryId, boolean active) {
		DocumentSubCategory sub=documentSubCategoryRepository.findOne(subCategoryId);
		sub.setActive(active);
		documentSubCategoryRepository.save(sub);
	}

	@Override
	public List<DocumentSubCategory> findByCategoryType(int documentCategoryId) {
		
		return documentSubCategoryRepository.findByCategoryType(documentCategoryId);
	}

	@Override
	public List<DocumentSubCategory> findByDocumentTypeAndCategoryType(int documentType, int id) {
		
		return documentSubCategoryRepository.findByDocumentTypeAndCategoryType(documentType,id);
	}

	@Override
	public List<DocumentSubCategory> getByCategoryType(int id) {
		
		return documentSubCategoryRepository.getByCategoryTypeAndActive(id,Boolean.TRUE);
	}

	

	
	

	

	

}
