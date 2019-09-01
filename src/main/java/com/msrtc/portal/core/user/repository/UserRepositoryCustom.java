package com.msrtc.portal.core.user.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.msrtc.portal.core.user.domain.User;
import com.msrtc.portal.core.user.dto.UserSearchDTO;

public interface UserRepositoryCustom {

    Page<User> searchUsers(UserSearchDTO userSearchDTO, Pageable pageable);

}
