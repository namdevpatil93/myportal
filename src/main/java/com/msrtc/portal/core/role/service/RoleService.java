package com.msrtc.portal.core.role.service;

import java.util.List;

import com.msrtc.portal.core.role.domain.Role;
import com.msrtc.portal.core.role.dto.RoleSearchDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.msrtc.portal.core.module.domain.Module;
import com.msrtc.portal.core.role.domain.RoleModuleOperation;

public interface RoleService {

	List<Role> findAllRoles();
	
	Page<Role> searchRoles(RoleSearchDTO roleSearchDTO, Pageable pageable);

	Role findRoleById(Long roleId);

	List<Module> findModulesWithModuleOperationsByRoleId(Long roleId);

    List<RoleModuleOperation> findRoleModuleOperationsByRoleId(Long roleId);

	void saveRole(Role role);

	void deleteRole(Long roleId);
}
