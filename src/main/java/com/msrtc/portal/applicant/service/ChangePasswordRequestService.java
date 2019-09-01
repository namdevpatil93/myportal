package com.msrtc.portal.applicant.service;

import java.util.List;

import com.msrtc.portal.applicant.domain.ChangePasswordRequest;

public interface ChangePasswordRequestService {
	
	List<ChangePasswordRequest> findAllChangePasswordRequests();

	ChangePasswordRequest findChangePasswordRequestById(Long id);
	
	ChangePasswordRequest findChangePasswordRequestByToken(String token);

	void deleteChangePasswordRequest(Long id);

	void saveChangePasswordRequest(ChangePasswordRequest changePasswordRequest);
}
