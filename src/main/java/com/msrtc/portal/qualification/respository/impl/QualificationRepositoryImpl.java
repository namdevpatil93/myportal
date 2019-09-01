package com.msrtc.portal.qualification.respository.impl;

import com.msrtc.portal.qualification.domain.Qualification;
import com.msrtc.portal.qualification.dto.QualificationSearchDTO;
import com.msrtc.portal.qualification.respository.QualificationRepository;
import com.msrtc.portal.qualification.respository.QualificationRepositoryCustom;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public class QualificationRepositoryImpl implements QualificationRepositoryCustom {

    @Autowired
    private QualificationRepository qualificationRepository;

    @Override
    public Page<Qualification> searchQualifications(QualificationSearchDTO qualificationSearchDTO, Pageable pageable) {
        return qualificationRepository.findAll(pageable);
    }
}
