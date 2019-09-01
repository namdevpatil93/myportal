package com.msrtc.portal.core.systemsetting.repository;

import com.msrtc.portal.core.common.repository.BaseRepository;
import com.msrtc.portal.core.systemsetting.domain.SystemSetting;

/**
 * The interface System setting repository.
 */
public interface SystemSettingRepository extends BaseRepository<SystemSetting, Long> {

    /**
     * Find by id system setting.
     *
     * @param id the id
     * @return the system setting
     */
    SystemSetting findById(Long id);

}
