package com.msrtc.portal.core.user.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDecisionVoter;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.FilterInvocation;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import com.msrtc.portal.core.module.service.ModuleService;

import javax.servlet.http.HttpServletRequest;
import java.util.Collection;

@Component
public class AccessDecisionVoterImpl implements AccessDecisionVoter {

    @Autowired
    private ModuleService moduleService;

    @Override
    public boolean supports(ConfigAttribute attribute) {
        return true;
    }

    @Override
    public boolean supports(Class clazz) {
        return true;
    }

    @Override
    public int vote(Authentication authentication, Object object, Collection collection) {

        HttpServletRequest request = ((FilterInvocation) object).getHttpRequest();
        String requestedOperation = request.getParameter("operation");

        if (!StringUtils.isEmpty(requestedOperation)){
            String contextPath = request.getContextPath();
            String [] requestURISplit = request.getRequestURI().split("/");
            String requestedModuleName = "";

            if(StringUtils.isEmpty(contextPath)) {
                requestedModuleName = requestURISplit[1];
            } else {
                requestedModuleName = requestURISplit[2];
            }

            if(SecurityUtils.hasPermission(requestedModuleName, requestedOperation)){
               return ACCESS_GRANTED;
            }
        } else {
            return ACCESS_GRANTED;
        }

        return ACCESS_DENIED;
    }
}
