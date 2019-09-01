package com.msrtc.portal.core.systemsetting.service.impl;

import com.msrtc.portal.core.systemsetting.domain.SystemSetting;
import com.msrtc.portal.core.systemsetting.repository.SystemSettingRepository;
import com.msrtc.portal.core.systemsetting.service.SystemSettingService;
import com.msrtc.portal.core.systemsetting.util.SystemSettingEnum;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * The type System setting service.
 */
@Service("systemSettingService")
@Transactional(readOnly = true)
public class SystemSettingServiceImpl implements SystemSettingService {

	@Autowired
	private SystemSettingRepository systemSettingRepository;

	@Override
	public String getSystemSetting(SystemSettingEnum systemSettingEnum){
		SystemSetting systemSetting = systemSettingRepository.findById(systemSettingEnum.getValue());

        if (systemSetting == null ) {
            throw new RuntimeException("Unable to find System Setting the with id {" + systemSettingEnum.getValue() + "}");
        }

		return systemSetting.getValue();
	}

	@Override
    @Transactional( propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
	public void setSystemSetting(long systemSettingId, String systemSettingValue) {
		SystemSetting systemSetting = new SystemSetting(systemSettingId, systemSettingValue);
		systemSettingRepository.save(systemSetting);
	}

	@Autowired
	public List<SystemSetting> findAll(){
		return (List<SystemSetting>) systemSettingRepository.findAll();
	}
}
