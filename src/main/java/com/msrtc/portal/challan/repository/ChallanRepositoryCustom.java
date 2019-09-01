package com.msrtc.portal.challan.repository;

import com.msrtc.portal.challan.domain.Challan;
import com.msrtc.portal.challan.dto.ChallanSearchDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface ChallanRepositoryCustom {

    Page<Challan> searchChallans(ChallanSearchDTO challanSearchDTO, Pageable pageable);

}

