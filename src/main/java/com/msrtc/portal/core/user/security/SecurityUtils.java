package com.msrtc.portal.core.user.security;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;

import com.msrtc.portal.core.module.domain.ModuleOperation;

import java.util.Collection;

/**
 * Utility class for Spring Security.
 */
public class SecurityUtils {

    private SecurityUtils() {
    }

    /**
     * Return the current user, or throws an exception, if the user is not
     * authenticated yet.
     *
     * @return the current user
     */
    public static SecurityUser getCurrentUser() {
        SecurityContext securityContext = SecurityContextHolder.getContext();
        Authentication authentication = securityContext.getAuthentication();
        if (authentication != null) {
            if (authentication.getPrincipal() instanceof SecurityUser) {
                return (SecurityUser) authentication.getPrincipal();
            }
        }
        throw new IllegalStateException("User not found!");
    }

    public static Long getCurrentUserRoleId() {
        return SecurityUtils.getCurrentUser().getRole().getId();
    }

    public static Long getCurrentUserParentRoleId() {
        return SecurityUtils.getCurrentUser().getRole().getParentRoleId();
    }
    /**
     * Has permission boolean.
     *
     * @param requestedModuleName the requested module name
     * @param requestedOperation  the requested operation
     * @return the boolean
     */
    public static boolean hasPermission(String requestedModuleName, String requestedOperation) {
        SecurityUser loggedInUser = getCurrentUser();
        if (loggedInUser != null) {
            Collection<? extends GrantedAuthority> authorities = loggedInUser.getAuthorities();
            if(authorities != null && authorities.size() > 0){
                for(GrantedAuthority authority : authorities){
                    ModuleOperation operation = (ModuleOperation) authority;
                    if(moduleMatches(requestedModuleName, operation.getModuleName()) && operationMatches(requestedOperation, operation)){
                        return true;
                    }
                }
            }
        }

        return false;
    }

    private static boolean moduleMatches(String requestedModuleName, String moduleName) {
        return requestedModuleName.equals(moduleName);
    }

    private static boolean operationMatches(String requestedOperation, ModuleOperation moduleOperation) {
        return moduleOperation.getModuleOperationName().indexOf(requestedOperation) >= 0;
    }

    public static boolean isAuthenticated() {
        SecurityContext securityContext = SecurityContextHolder.getContext();
        Authentication authentication = securityContext.getAuthentication();
        if (authentication != null) {
            return authentication.getAuthorities().stream()
                    .noneMatch(grantedAuthority -> grantedAuthority.getAuthority().equals(AuthoritiesConstants.ANONYMOUS));
        }
        return false;
    }
}
