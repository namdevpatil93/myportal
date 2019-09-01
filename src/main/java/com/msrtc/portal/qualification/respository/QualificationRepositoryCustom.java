package com.msrtc.portal.qualification.respository;

import com.msrtc.portal.qualification.domain.Qualification;
import com.msrtc.portal.qualification.dto.QualificationSearchDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface QualificationRepositoryCustom {

    Page<Qualification> searchQualifications(QualificationSearchDTO qualificationSearchDTO, Pageable pageable);

}

