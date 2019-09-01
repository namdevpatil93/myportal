package com.msrtc.portal.core.role.repository;

import com.msrtc.portal.core.common.repository.BaseRepository;
import com.msrtc.portal.core.role.domain.RoleModuleOperation;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface RoleModuleOperationRepository extends BaseRepository<RoleModuleOperation, Long> {

    @Query("FROM RoleModuleOperation WHERE roleId = :roleId")
    List<RoleModuleOperation> findRoleModuleOperationsByRoleId(@Param("roleId") Long roleId);

}
