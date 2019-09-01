package com.msrtc.portal.core.module.service;

import java.util.List;

import com.msrtc.portal.core.module.domain.ModuleOperation;
import com.msrtc.portal.core.module.domain.Module;

public interface ModuleService {

	List<Module> findAllModules();

	List<ModuleOperation> findModuleOperationsByRoleId(Long roleId);
}
