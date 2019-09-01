package com.msrtc.portal.applicant.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;

import com.msrtc.portal.applicant.domain.Trade;
import com.msrtc.portal.core.common.repository.BaseRepository;

public interface TradeRepository extends BaseRepository<Trade, Long> {

	@Query("select t from Trade t where t.active=true order by t.tradeOrder asc")
	List<Trade> findAll();

}

