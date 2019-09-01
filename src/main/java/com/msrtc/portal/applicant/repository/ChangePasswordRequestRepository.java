package com.msrtc.portal.applicant.repository;

import com.msrtc.portal.applicant.domain.ChangePasswordRequest;
import com.msrtc.portal.core.common.repository.BaseRepository;

public interface ChangePasswordRequestRepository extends BaseRepository<ChangePasswordRequest, Long> {

	ChangePasswordRequest findByToken(String token);
}
