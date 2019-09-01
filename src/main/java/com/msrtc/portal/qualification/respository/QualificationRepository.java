package com.msrtc.portal.qualification.respository;

import java.util.List;

import com.msrtc.portal.core.common.repository.BaseRepository;
import com.msrtc.portal.qualification.domain.Qualification;

public interface QualificationRepository extends BaseRepository<Qualification, Long>, QualificationRepositoryCustom{

	List<Qualification> findAllByOrderByPriorityDesc();
	
	Qualification findByTitle(String title);
	
	Qualification findByTitleInMarathi(String titleInMarathi);

	List<Qualification> findByActiveTrueOrderByPriorityDesc();

}

