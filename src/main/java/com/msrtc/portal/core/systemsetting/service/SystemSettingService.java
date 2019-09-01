package com.msrtc.portal.core.systemsetting.service;

import com.msrtc.portal.core.systemsetting.domain.SystemSetting;
import com.msrtc.portal.core.systemsetting.util.SystemSettingEnum;

import java.util.List;

/**
 * The interface System setting service.
 */
public interface SystemSettingService {

	/**
	 * Gets system setting.
	 *
	 * @param systemSettingEnum the system setting enum
	 * @return the system setting
	 */
	String getSystemSetting(SystemSettingEnum systemSettingEnum);

	/**
	 * Sets system setting.
	 *
	 * @param systemSettingId    the system setting id
	 * @param systemSettingValue the system setting value
	 */
	void setSystemSetting(long systemSettingId, String systemSettingValue);

	List<SystemSetting> findAll();

}
