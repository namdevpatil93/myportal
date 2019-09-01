package com.msrtc.portal.core.audit.util;

import com.msrtc.portal.core.user.security.SecurityUtils;
import org.springframework.stereotype.Component;

@Component("auditorAware")
public class AuditorAware implements org.springframework.data.domain.AuditorAware<Long> {

    /**
     * Returns the current auditor of the applicant.
     *
     * @return the current auditor
     */
    @Override
    public Long getCurrentAuditor() {
        return SecurityUtils.getCurrentUser().getUser().getId();
    }
}
