package com.msrtc.portal.applicantQuery.repository;
import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.msrtc.portal.applicantQuery.domain.ApplicantQueryReply;
import com.msrtc.portal.core.common.repository.BaseRepository;

public interface ApplicantQueryReplyRepository extends BaseRepository<ApplicantQueryReply, Long> 
{
	@Query("select aqr from ApplicantQueryReply aqr where queryId = :id")
	public List<ApplicantQueryReply> findApplicantQueryReplyById(@Param("id") Long id);
	
	@Query("select aqr.id from ApplicantQueryReply aqr where queryId = :queryId order by id DESC")
	public List<Long> findApplicantQueryOrderByQId(@Param("queryId") Long queryId);

	@Query("select count(aqr.id) from ApplicantQueryReply aqr where userId = :userId and userType=1 and status =0")
	public int getCountofUnreadQueryReplies(@Param("userId") Long userId);

	@Modifying(clearAutomatically = true)
	@Query("UPDATE ApplicantQueryReply aqr SET aqr.status=1 WHERE aqr.queryId =:id")
	public void updateQueryReplyStatusToRead(@Param("id") Long id);
	
	public ApplicantQueryReply findByQueryId(Long ApplicantQueryId);
	
}
