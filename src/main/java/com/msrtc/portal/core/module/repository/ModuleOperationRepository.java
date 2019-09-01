package com.msrtc.portal.core.module.repository;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.msrtc.portal.core.common.repository.BaseRepository;
import com.msrtc.portal.core.module.domain.ModuleOperation;

import java.util.List;

public interface ModuleOperationRepository extends BaseRepository<ModuleOperation, Long> {

    List<ModuleOperation> findByModuleId(Integer moduleId);

    @Query("SELECT DISTINCT(mo) FROM ModuleOperation mo, RoleModuleOperation rmo where mo.moduleOperationId = rmo.moduleOperationId and rmo.roleId = :roleId")
    List<ModuleOperation> findByRoleId(@Param("roleId") Long roleId);
}
