package com.msrtc.portal.core.config.listener;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * The type Session listener.
 */
public class SessionListener implements HttpSessionListener {

    private static final String APPLICATION_SESSION_TIMEOUT = "applicationSessionTimeout";

    @Override
    public void sessionCreated(HttpSessionEvent event) {
        HttpSession session = event.getSession();
        ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
        Integer applicationSessionTimeout = (Integer) ctx.getBean(APPLICATION_SESSION_TIMEOUT);
        event.getSession().setMaxInactiveInterval(applicationSessionTimeout * 60 );
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent event) {

    }
}
