package com.msrtc.portal.applicant.service.impl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.msrtc.portal.applicant.domain.ChangePasswordRequest;
import com.msrtc.portal.applicant.repository.ChangePasswordRequestRepository;
import com.msrtc.portal.applicant.service.ChangePasswordRequestService;

@Service(value = "changePasswordRequestService")
@Transactional(readOnly = false)
public class ChangePasswordRequestServiceImpl implements ChangePasswordRequestService {

	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	private ChangePasswordRequestRepository changePasswordRequestRepository;

	@Override
	public List<ChangePasswordRequest> findAllChangePasswordRequests() {
		log.debug("Finding all Change Password Request entries");
		return (List<ChangePasswordRequest>) changePasswordRequestRepository.findAll();
	}

	@Override
	public ChangePasswordRequest findChangePasswordRequestById(Long id) {
		log.debug("Finding Change Password Request entry with the applicant id: {}",id);
		return changePasswordRequestRepository.findOne(id);
	}

	@Override
	public void saveChangePasswordRequest(ChangePasswordRequest changePasswordRequest) {
		log.debug("Saving Change Password Request with the information: {}",
				changePasswordRequest);

		boolean isNew = changePasswordRequest.getId() == null
				|| changePasswordRequest.getId() == 0;

		if (isNew) {
			changePasswordRequestRepository.save(changePasswordRequest);
		} else {
			ChangePasswordRequest dbChangePasswordRequest = changePasswordRequestRepository
					.findOne(changePasswordRequest.getId());

			dbChangePasswordRequest.setEmailAddress(changePasswordRequest.getEmailAddress());
			dbChangePasswordRequest.setUserType(changePasswordRequest.getUserType());
			dbChangePasswordRequest.setToken(changePasswordRequest.getToken());
			dbChangePasswordRequest.setCreatedDate(changePasswordRequest.getCreatedDate());

			changePasswordRequestRepository.save(dbChangePasswordRequest);
		}
	}

	@Override
	public void deleteChangePasswordRequest(Long id) {
		changePasswordRequestRepository.delete(id);
	}

	@Override
	public ChangePasswordRequest findChangePasswordRequestByToken(String token) {
		return changePasswordRequestRepository.findByToken(token);
	}

}
