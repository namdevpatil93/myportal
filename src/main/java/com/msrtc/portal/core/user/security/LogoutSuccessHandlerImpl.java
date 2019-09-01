package com.msrtc.portal.core.user.security;

import com.msrtc.portal.core.common.util.Constants;
import com.msrtc.portal.core.user.domain.UserRole;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.logout.SimpleUrlLogoutSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LogoutSuccessHandlerImpl extends SimpleUrlLogoutSuccessHandler {

    private final RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    @Override
    public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        Long currentUserParentRoleId = 2L;

        if (authentication != null) {
            if (authentication.getPrincipal() instanceof SecurityUser) {
                currentUserParentRoleId = ((SecurityUser) authentication.getPrincipal()).getRole().getParentRoleId() ;
            }
        }

        HttpSession session= request.getSession(false);
        if(session != null) {
            session.invalidate();
        }

        SecurityContextHolder.clearContext();

        for(Cookie cookie : request.getCookies()) {
            cookie.setMaxAge(0);
            cookie.setValue(null);
            cookie.setPath("/");
            response.addCookie(cookie);
        }

        String isIdleTimeOut = request.getParameter("idleTimeout");

        request.setAttribute("idleTimeout", "idleTimeout");

        String redirectURL = "";

        if(currentUserParentRoleId == UserRole.ADMIN.getId()){
            redirectURL = Constants.ADMIN_LOGIN_URL + "?isLoggedOut=true";
        } else {
            redirectURL = Constants.APPLICANT_LOGIN_URL + "?isLoggedOut=true";
        }

        if (isIdleTimeOut != null && "true".equalsIgnoreCase(isIdleTimeOut)) {
            redirectURL += "&idleTimeout=" + isIdleTimeOut;
        }

        redirectStrategy.sendRedirect(request, response, redirectURL);
    }
}
