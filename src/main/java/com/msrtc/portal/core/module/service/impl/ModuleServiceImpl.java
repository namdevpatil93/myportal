package com.msrtc.portal.core.module.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.msrtc.portal.core.module.domain.Module;
import com.msrtc.portal.core.module.domain.ModuleOperation;
import com.msrtc.portal.core.module.repository.ModuleOperationRepository;
import com.msrtc.portal.core.module.repository.ModuleRepository;
import com.msrtc.portal.core.module.service.ModuleService;

import java.util.List;

@Service("moduleService")
public class ModuleServiceImpl implements ModuleService {

 	@Autowired
	private ModuleRepository moduleRepository;

    @Autowired
    private ModuleOperationRepository moduleOperationRepository;

	@Override
	public List<Module> findAllModules() {
 		return moduleRepository.findAllModules();
	}

    @Override
    public List<ModuleOperation> findModuleOperationsByRoleId(Long roleId){
        return moduleOperationRepository.findByRoleId(roleId);
    }
}
