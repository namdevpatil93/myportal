package com.msrtc.portal.core.module.repository;

import org.springframework.data.jpa.repository.Query;

import com.msrtc.portal.core.common.repository.BaseRepository;
import com.msrtc.portal.core.module.domain.Module;

import java.util.List;

public interface ModuleRepository extends BaseRepository<Module, Long> {

    @Query("SELECT m FROM Module m ORDER BY m.moduleName ASC")
    List<Module> findAllModules();

}
