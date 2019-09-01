package com.msrtc.portal.core.role.service.impl;

import java.util.List;

import com.msrtc.portal.core.role.domain.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.msrtc.portal.core.module.domain.Module;
import com.msrtc.portal.core.module.domain.ModuleOperation;
import com.msrtc.portal.core.module.service.ModuleService;
import com.msrtc.portal.core.role.domain.RoleModuleOperation;
import com.msrtc.portal.core.role.dto.RoleSearchDTO;
import com.msrtc.portal.core.role.repository.RoleModuleOperationRepository;
import com.msrtc.portal.core.role.repository.RoleRepository;
import com.msrtc.portal.core.role.service.RoleService;

@Service("roleService")
@Transactional(readOnly = true)
public class RoleServiceImpl implements RoleService {

	@Autowired
	private RoleRepository roleRepository;

    @Autowired
    private RoleModuleOperationRepository roleModuleOperationRepository;

    @Autowired
    private ModuleService moduleService;

    @Override
    public List<Role> findAllRoles() {
        return (List<Role>) roleRepository.findAll();
    }

	@Override
	public Role findRoleById(Long roleId) {
		return roleRepository.findOne(roleId);
	}

    @Override
    public List<RoleModuleOperation> findRoleModuleOperationsByRoleId(Long roleId){
        return roleModuleOperationRepository.findRoleModuleOperationsByRoleId(roleId);
    }

	@Override
	public List<Module> findModulesWithModuleOperationsByRoleId(Long roleId){
        List<Module> allModules = moduleService.findAllModules();
        List<RoleModuleOperation> rmOperationList = findRoleModuleOperationsByRoleId(roleId);

        if(allModules != null && allModules.size() > 0){
            for(Module module : allModules){
                if(module.getModuleOperationList() != null && module.getModuleOperationList().size() > 0){
                    for(ModuleOperation moduleOperation : module.getModuleOperationList()){
                        for(RoleModuleOperation rmo : rmOperationList){
                            if(moduleOperation.getModuleOperationId().equals(rmo.getModuleOperationId())){
                                moduleOperation.setRoleHasAccess(true);
                            }
                        }
                    }
                }
            }
        }

        return allModules;
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
    public void saveRole(Role role) {
        boolean isRoleNew = role.getId() == null || role.getId() == 0;

        if(isRoleNew){
            roleRepository.save(role);
        } else {
            Role dbRole = roleRepository.findOne(role.getId());

            dbRole.setTitle(role.getTitle());
            dbRole.setDescription(role.getDescription());
            dbRole.setEnabled(role.isEnabled());

            dbRole.setRoleModuleOperationList(role.getRoleModuleOperationList());

            roleRepository.save(dbRole);
        }
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
    public void deleteRole(Long roleId) {
        roleRepository.delete(roleId);
    }

	@Override
	public Page<Role> searchRoles(RoleSearchDTO roleSearchDTO, Pageable pageable) {
        Page<Role> rolePage = roleRepository.searchRoles(roleSearchDTO, pageable);
        return rolePage;
	}


}
