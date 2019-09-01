package com.msrtc.portal.core.role.web;

import java.util.ArrayList;
import java.util.List;

import com.msrtc.portal.core.common.util.PageDetail;
import com.msrtc.portal.core.role.domain.Role;
import com.msrtc.portal.core.role.dto.RoleSearchDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.msrtc.portal.core.module.service.ModuleService;
import com.msrtc.portal.core.role.domain.RoleModuleOperation;
import com.msrtc.portal.core.role.service.RoleService;

@Controller
@RequestMapping(value = { "/role" })
public class RoleController {

	private final Logger log = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private RoleService roleService;
	
	@Autowired
	private ModuleService moduleService;

	@Autowired
	private MessageSource messageSource;

	@RequestMapping(params = "operation=roleList")
	public String roleList(Model model, RoleSearchDTO roleSearchDTO, PageDetail pageDetail) {
		Page<Role> page = roleService.searchRoles(roleSearchDTO, pageDetail.getPageable());

		model.addAttribute("page", page);
		model.addAttribute("pageDetail", pageDetail);
		model.addAttribute("roleSearchDTO", roleSearchDTO);

		int beginIndex = pageDetail.getBeginIndex(page.getNumber());
        model.addAttribute("beginIndex", beginIndex);
        model.addAttribute("endIndex", pageDetail.getEndIndex(page.getTotalPages(), beginIndex));
        
		if (pageDetail.isNewPage()) {
			return "roleListResult";
		} else {
			return "roleList";
		}
	}

	@RequestMapping(params = "operation=newRole")
	public String newRole(Model model) {
		model.addAttribute("allModules", moduleService.findAllModules());
		return "roleForm";
	}

	@RequestMapping(params = "operation=editRole")
	public String editRole(Long roleId, Model model) {
		model.addAttribute("role", roleService.findRoleById(roleId));
        model.addAttribute("allModules", roleService.findModulesWithModuleOperationsByRoleId(roleId));
		return "roleForm";
	}

	@RequestMapping(params = "operation=saveRole")
	public String saveRole(Role role, @RequestParam(value="operationId", required = false) String[] operationIds, final RedirectAttributes redirectAttributes) {
		boolean isNew = role.getId() == null || role.getId() == 0;
		try {
			if(operationIds != null){
	            List<RoleModuleOperation> roleModuleOperationList = new ArrayList<RoleModuleOperation>();
	            for(String operationId : operationIds){
	                RoleModuleOperation roleModuleOperation = new RoleModuleOperation();
	                roleModuleOperation.setModuleOperationId(Long.parseLong(operationId));
	                roleModuleOperationList.add(roleModuleOperation);
	            }
	            role.setRoleModuleOperationList(roleModuleOperationList);
	        }
			roleService.saveRole(role);
			if (isNew) {
				redirectAttributes.addFlashAttribute("message",
						messageSource.getMessage("role.created", null, LocaleContextHolder.getLocale()));
			} else {
				redirectAttributes.addFlashAttribute("message",
						messageSource.getMessage("role.updated", null, LocaleContextHolder.getLocale()));
			}
		} catch (Exception e) {
			log.error("Exception while saving role. " + e, e);
			redirectAttributes.addFlashAttribute("error",
					messageSource.getMessage("role.save.failed", null, LocaleContextHolder.getLocale()));
		}
		return "redirect:/role?operation=roleList";
	}

	@RequestMapping(params = "operation=deleteRole")
	public String deleteRole(Long roleId, final RedirectAttributes redirectAttributes) {
		try {
			roleService.deleteRole(roleId);
			redirectAttributes.addFlashAttribute("message",
					messageSource.getMessage("role.deleted", null, LocaleContextHolder.getLocale()));
		} catch (Exception e) {
			log.error("Exception while deleting role with id " + roleId + ". " + e, e);
			redirectAttributes.addFlashAttribute("error",
					messageSource.getMessage("role.delete.failed", null, LocaleContextHolder.getLocale()));
		}

		return "redirect:/role?operation=roleList";
	}
}
