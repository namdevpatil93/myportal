package com.msrtc.portal.core.role.repository;

import com.msrtc.portal.core.role.domain.Role;
import com.msrtc.portal.core.common.repository.BaseRepository;

public interface RoleRepository extends BaseRepository<Role, Long>, RoleRepositoryCustom {

}
