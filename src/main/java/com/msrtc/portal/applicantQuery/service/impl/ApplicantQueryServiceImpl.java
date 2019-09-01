package com.msrtc.portal.applicantQuery.service.impl;

import java.io.File;
import java.util.List;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.msrtc.portal.applicant.domain.Applicant;
import com.msrtc.portal.applicantQuery.domain.ApplicantQuery;
import com.msrtc.portal.applicantQuery.domain.ApplicantQueryReply;
import com.msrtc.portal.applicantQuery.dto.ApplicantQuerySearchDTO;
import com.msrtc.portal.applicantQuery.repository.ApplicantQueryReplyRepository;
import com.msrtc.portal.applicantQuery.repository.ApplicantQueryRepository;
import com.msrtc.portal.applicantQuery.service.ApplicantQueryService;
import com.msrtc.portal.core.common.util.Constants;
import com.msrtc.portal.core.common.util.FileUtils;
import com.msrtc.portal.core.config.ApplicationProperties;

@Service(value = "applicantQueryService")
@Transactional(readOnly = true)
public class ApplicantQueryServiceImpl implements ApplicantQueryService {

	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	private ApplicantQueryRepository applicantQueryRepository;

	@Autowired
	private ApplicantQueryReplyRepository applicantQueryReplyRepository;
	
	@Autowired
    private ApplicationProperties applicationProperties;
	
	@Override
	public List<ApplicantQuery> findAllApplicantQueries() {
		log.debug("Finding all applicantQuery entries");
		return (List<ApplicantQuery>) applicantQueryRepository.findAll();
	}

	@Override
	public Page<ApplicantQuery> searchApplicantQueries(ApplicantQuerySearchDTO applicantQuerySearchDTO, Pageable pageable, Long id){
		return applicantQueryRepository.searchApplicantQueries(applicantQuerySearchDTO, pageable, id);
	}

	@Override
	public ApplicantQuery findApplicantQueryByQId(Long id) {
		log.debug("Finding applicantQuery entry with the applicantQuery id: {}", id);
		return applicantQueryRepository.findOne(id);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
	public void saveApplicantQuery(ApplicantQuery applicantQuery, Applicant applicant, MultipartFile attachment) {
		log.debug("Saving ApplicantQuery with the information: {}", applicantQuery);
		String basePath = applicationProperties.getResources().getBasePath();
		String attachmentName = (attachment != null && !org.apache.commons.lang3.StringUtils.isBlank(attachment.getOriginalFilename()))
								? UUID.randomUUID().toString() + attachment.getOriginalFilename().substring(attachment.getOriginalFilename().lastIndexOf("."))
								: null;
		
		Long applicantQueryId = null;
		boolean isNew = applicantQuery.getId() == null ||  applicantQuery.getId() == 0;
		
		applicantQuery.setApplicantId(applicant.getId());
		
		if(applicantQuery.getCreatedBy() == null) {
			applicantQuery.setCreatedBy(applicantQuery.getApplicantId());
			applicantQuery.setLastModifiedBy(applicantQuery.getApplicantId());
		}
		
		if(isNew) {
			applicantQuery.setAddAttachment(attachmentName);
			applicantQueryRepository.save(applicantQuery);
			applicantQueryId = applicantQuery.getId();
		} else {
			ApplicantQuery dbApplicantQuery = applicantQueryRepository.findOne(applicantQuery.getId());

            dbApplicantQuery.setType(applicantQuery.getType());
            dbApplicantQuery.setTypeOther(applicantQuery.getTypeOther());
            dbApplicantQuery.setTitle(applicantQuery.getTitle());
            dbApplicantQuery.setDescription(applicantQuery.getDescription());
            dbApplicantQuery.setApplicantId(applicantQuery.getApplicantId());
            if ( !org.apache.commons.lang3.StringUtils.isBlank(attachmentName) ) {
            	dbApplicantQuery.setAddAttachment(attachmentName);
            }

            applicantQueryRepository.save(dbApplicantQuery);
            applicantQueryId = dbApplicantQuery.getId();
		}
		
        String attachmentLocation = basePath + File.separator + Constants.BASE_UPLOAD_DIR + File.separator + Constants.QUERY_DIR + File.separator + applicantQueryId;
        
        if ( attachment != null && !org.apache.commons.lang3.StringUtils.isBlank(attachmentName) ) {
        	FileUtils.deletePreviousFiles(attachmentLocation, attachmentName);
        	FileUtils.saveFile(attachment, attachmentName, attachmentLocation);
        }
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
	public void deleteApplicantQuery(Long id) {
		log.debug("Deleting applicantQuery entry with the applicantQuery id: {}", id);
		applicantQueryRepository.delete(id);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRES_NEW, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
	public void saveApplicantQueryReply(ApplicantQueryReply applicantQueryReply, MultipartFile attachment) {
		log.debug("Saving ApplicantQuery with the information: {}", applicantQueryReply);
		String basePath = applicationProperties.getResources().getBasePath();
		String attachmentName = (attachment != null && !org.apache.commons.lang3.StringUtils.isBlank(attachment.getOriginalFilename()))
				? UUID.randomUUID().toString() + attachment.getOriginalFilename().substring(attachment.getOriginalFilename().lastIndexOf("."))
				: null;
		applicantQueryReply.setAddAttachment(attachmentName);
        applicantQueryReplyRepository.save(applicantQueryReply);
        
        String attachmentLocation = basePath + File.separator + Constants.BASE_UPLOAD_DIR + File.separator + Constants.QUERY_DIR + File.separator + applicantQueryReply.getQueryId();
        
        if ( attachment != null && !org.apache.commons.lang3.StringUtils.isBlank(attachmentName) ) {
        	//FileUtils.deletePreviousFiles(attachmentLocation, attachmentName);
        	FileUtils.saveFile(attachment, attachmentName, attachmentLocation);
        }
	}
	
	@Override
	public List<ApplicantQueryReply> findApplicantQueryReplyById(Long id) {
		log.debug("Finding applicantQueryReply entry with the applicantQueryReply id: {}", id);
		return applicantQueryReplyRepository.findApplicantQueryReplyById(id);
	}
	
	public List<Long> findApplicantQueryOrderByQId(Long id)
	{
		return applicantQueryReplyRepository.findApplicantQueryOrderByQId(id);
	}
	
	public int getCountofUnreadQueryReplies(Long userId)
	{
		return applicantQueryReplyRepository.getCountofUnreadQueryReplies(userId);
	}
	
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
	public void updateQueryReplyStatusToRead(Long queryId)
	{
		applicantQueryReplyRepository.updateQueryReplyStatusToRead(queryId);
	}
	
	public ApplicantQueryReply findApplicantQueryReply(Long id) {
		return applicantQueryReplyRepository.findOne(id);
	}
}

