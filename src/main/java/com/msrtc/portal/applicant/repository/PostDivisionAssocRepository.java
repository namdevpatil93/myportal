package com.msrtc.portal.applicant.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.msrtc.portal.applicant.domain.PostDivisionAssoc;
import com.msrtc.portal.core.common.repository.BaseRepository;

public interface PostDivisionAssocRepository extends BaseRepository<PostDivisionAssoc, Long>{

	@Query("select pda from PostDivisionAssoc pda, Division d where pda.postId = :postId and pda.divisionId = d.divisionId and pda.active=true order by d.divisionOrder asc")
	List<PostDivisionAssoc> findByPostId(@Param("postId") Long postId);
}
