package com.msrtc.portal.core.role.repository;

import com.msrtc.portal.core.role.domain.Role;
import com.msrtc.portal.core.role.dto.RoleSearchDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface RoleRepositoryCustom {

	Page<Role> searchRoles(RoleSearchDTO roleSearchDTO, Pageable pageable);

}
