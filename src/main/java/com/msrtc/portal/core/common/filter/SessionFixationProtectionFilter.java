package com.msrtc.portal.core.common.filter;

import com.msrtc.portal.core.common.util.CommonUtils;
import com.msrtc.portal.core.common.util.CookieUtils;
import com.msrtc.portal.core.common.util.EncryptorUtils;
import com.msrtc.portal.core.common.util.RandomGenerator;
import com.msrtc.portal.core.user.security.SecurityUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.ServletWebRequest;
import org.springframework.web.filter.GenericFilterBean;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;

import javax.annotation.Resource;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SessionFixationProtectionFilter extends GenericFilterBean {

    private static final Log LOG = LogFactory.getLog(SessionFixationProtectionFilter.class);

    protected static final String SESSION_ATTR = "SFP-ActiveID";

    private final RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    @Override
    public void doFilter(ServletRequest sRequest, ServletResponse sResponse, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) sRequest;
        HttpServletResponse response = (HttpServletResponse) sResponse;
        HttpSession session = request.getSession(false);

        if (SecurityContextHolder.getContext() == null) {
            chain.doFilter(request, response);
        }

        String activeIdSessionValue = (session == null) ? null : (String) session.getAttribute(SESSION_ATTR);

        if (StringUtils.isNotBlank(activeIdSessionValue) && SecurityUtils.isAuthenticated()) {
            String activeIdCookieValue = CookieUtils.getCookieValue(request, SessionFixationProtectionCookie.COOKIE_NAME);
            String decryptedActiveIdValue = EncryptorUtils.decrypt(activeIdCookieValue);

            String ipAddress = CommonUtils.getClientIpAddr(request);

            if (!ipAddress .equals(decryptedActiveIdValue)) {
                abortUser(request, response);
                LOG.info("Session has been terminated. ActiveID did not match expected value.");
                return;
            }
        }

        chain.doFilter(request, response);
    }

    protected void abortUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        SecurityContextHolder.clearContext();
        CookieUtils.invalidateCookie(response, SessionFixationProtectionCookie.COOKIE_NAME);
        redirectStrategy.sendRedirect(request, response, "/");
    }

}
