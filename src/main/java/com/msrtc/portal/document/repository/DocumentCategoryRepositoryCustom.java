package com.msrtc.portal.document.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.msrtc.portal.core.common.util.PageDetail;
import com.msrtc.portal.document.domain.DocumentCategory;

public interface DocumentCategoryRepositoryCustom {
	
	Page<DocumentCategory> searchCategory(Pageable pageable);
	
	

}
