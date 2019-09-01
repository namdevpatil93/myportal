package com.msrtc.portal.document.repository.impl;

import com.msrtc.portal.document.domain.Document;
import com.msrtc.portal.document.domain.QDocument;
import com.msrtc.portal.document.dto.DocumentSearchDTO;
import com.msrtc.portal.document.repository.DocumentRepository;
import com.msrtc.portal.document.repository.DocumentRepositoryCustom;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public class DocumentRepositoryImpl implements DocumentRepositoryCustom {

    @Autowired
    private DocumentRepository documentRepository;

    @Override
    public Page<Document> searchDocuments(DocumentSearchDTO documentSearchDTO, Pageable pageable) {
        QDocument document = QDocument.document;
        return documentRepository.findAll(document.documentType.eq(documentSearchDTO.getDocumentType()), pageable);
    }
}

