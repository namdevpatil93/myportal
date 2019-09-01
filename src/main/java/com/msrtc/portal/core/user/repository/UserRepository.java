package com.msrtc.portal.core.user.repository;

import com.msrtc.portal.core.common.repository.BaseRepository;
import com.msrtc.portal.core.user.domain.User;

public interface UserRepository extends BaseRepository<User, Long>, UserRepositoryCustom {

    User findByEmail(String email);

}
