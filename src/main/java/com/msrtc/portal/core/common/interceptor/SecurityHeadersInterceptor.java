package com.msrtc.portal.core.common.interceptor;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SecurityHeadersInterceptor extends HandlerInterceptorAdapter {

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

//        response.setHeader("Strict-Transport-Security","max-age=31536000 ; includeSubDomains");
//        response.setHeader("X-Content-Type-Options", "nosniff");
        response.setHeader("X-Frame-Options", "SAMEORIGIN");
//        response.setHeader("X-XSS-Protection", "1; mode=block");

        super.postHandle(request, response, handler, modelAndView);
    }
}