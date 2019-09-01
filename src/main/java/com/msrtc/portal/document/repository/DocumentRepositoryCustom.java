package com.msrtc.portal.document.repository;

import com.msrtc.portal.document.domain.Document;
import com.msrtc.portal.document.dto.DocumentSearchDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface DocumentRepositoryCustom {

    Page<Document> searchDocuments(DocumentSearchDTO documentSearchDTO, Pageable pageable);

}

