package com.msrtc.portal.core.systemsetting.web;

import com.msrtc.portal.core.systemsetting.domain.SystemSetting;
import com.msrtc.portal.core.systemsetting.service.SystemSettingService;
import com.msrtc.portal.qualification.domain.Qualification;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = { "/systemSettings"})
public class SystemSettingsController {

	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	private SystemSettingService systemSettingService;

	@RequestMapping(params = "operation=viewSystemSettings")
	public String viewSystemSettings(Model model) {
		List<SystemSetting> systemSettingList = systemSettingService.findAll();
		model.addAttribute("systemSettingList", systemSettingList);
		return "systemSettings";
	}

	@RequestMapping(params = "operation=saveSystemSetting")
	@ResponseBody
	public Map<String, Object> saveSystemSetting(SystemSetting systemSetting) {
		log.debug("Saving Qualification with the information: {}", systemSetting);

		Map<String, Object> result = new HashMap<>();
		boolean success = true;
		try {
			systemSettingService.setSystemSetting(systemSetting.getId(), systemSetting.getValue());
		} catch(Exception e){
			log.error(e.getMessage());
			success = false;
		}
		result.put("success", success);
		return result;
	}

}

