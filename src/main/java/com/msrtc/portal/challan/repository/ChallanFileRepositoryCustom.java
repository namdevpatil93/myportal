package com.msrtc.portal.challan.repository;

import com.msrtc.portal.challan.domain.ChallanFile;
import com.msrtc.portal.challan.dto.ChallanFileSearchDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface ChallanFileRepositoryCustom {

    Page<ChallanFile> searchChallanFiles(ChallanFileSearchDTO challanFileSearchDTO, Pageable pageable);

}

