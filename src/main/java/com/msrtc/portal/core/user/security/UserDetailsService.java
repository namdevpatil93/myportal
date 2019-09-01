package com.msrtc.portal.core.user.security;

import com.msrtc.portal.applicant.domain.Applicant;
import com.msrtc.portal.applicant.service.ApplicantService;
import com.msrtc.portal.core.module.domain.ModuleOperation;
import com.msrtc.portal.core.user.domain.User;
import com.msrtc.portal.core.user.domain.UserRole;
import com.msrtc.portal.core.user.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.msrtc.portal.core.module.domain.Module;
import com.msrtc.portal.core.module.service.ModuleService;
import org.springframework.util.StringUtils;

import java.util.*;

@Service("userDetailsService")
public class UserDetailsService implements org.springframework.security.core.userdetails.UserDetailsService {

	private static final Logger log = LoggerFactory.getLogger(UserDetailsService.class);

	@Autowired
	private UserService userService;

    @Autowired
    private ApplicantService applicantService;

    @Autowired
    private ModuleService moduleService;

	@Override
	public UserDetails loadUserByUsername(final String loginName) throws UsernameNotFoundException, DataAccessException {
		int userType = UserRole.APPLICANT.getId();
		String userName = "";

		if(!StringUtils.isEmpty(loginName) && loginName.contains("|")){
			String[] parts = loginName.split("[|]");
			if(parts != null && parts.length > 1){
				userType = Integer.parseInt(parts[0]);
				userName = parts[1];
			}
		}

        log.debug("Authenticating : {}", userName);

        SecurityUser securityUser = null;

		try {
            if( userType == UserRole .ADMIN.getId()) {
                securityUser = authenticateAdmin(userName, securityUser);
                securityUser.setParentRoleId((long) UserRole.ADMIN.getId());
            } else if(userType == UserRole .APPLICANT.getId()){
                securityUser = authenticateApplicant(userName, securityUser);
                securityUser.setParentRoleId((long) UserRole.APPLICANT.getId());
            }
        } catch (Exception e) {
			log.error(e.getMessage(), e);
		}

		return securityUser;
	}

    private SecurityUser authenticateApplicant(String userName, SecurityUser securityUser) {
        Applicant applicant = applicantService.findApplicantByApplicationId(userName);

        if (applicant  != null) {
            log.debug("Applicant with the applicant ID {} FOUND ", userName);
            securityUser = new SecurityUser(applicant.getApplicationId(), applicant.getPassword(), applicant.getRole(), getGrantedAuthorities(applicant.getRole().getId()));
            securityUser.setApplicant(applicant);
        } else {
            log.debug("User with the username {}  NOT FOUND", userName);
            throw new UsernameNotFoundException("Username not found.");
        }

        return securityUser;
    }

    private SecurityUser authenticateAdmin(String userName, SecurityUser securityUser) {
        User user = userService.findUserByEmail(userName);

        if (user != null) {
            log.debug("User with the username {} FOUND ", userName);
            securityUser = new SecurityUser(user.getEmail(), user.getPassword(), user.getRole(), getGrantedAuthorities(user.getRole().getId()));
            securityUser.setUser(user);
        } else {
            log.debug("User with the username {}  NOT FOUND", userName);
            throw new UsernameNotFoundException("Username not found.");
        }
        return securityUser;
    }

    private List<GrantedAuthority> getGrantedAuthorities(Long roleId) {
        log.debug("Populating user authorities");

		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		List<Module> allModules = moduleService.findAllModules();
		Map<Long, Module> moduleMap = new HashMap<Long, Module>();

		for(Module module : allModules){
			moduleMap.put(module.getModuleId(), module);
		}

		List<ModuleOperation> moduleOperationList = moduleService.findModuleOperationsByRoleId(roleId);

		for (ModuleOperation moduleOperation : moduleOperationList) {
			moduleOperation.setModuleName(moduleMap.get(moduleOperation.getModuleId()).getModuleName());
			authorities.add(moduleOperation);
		}

		return authorities;
	}
}
