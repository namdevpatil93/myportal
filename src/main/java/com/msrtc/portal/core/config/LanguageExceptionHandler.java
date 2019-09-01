package com.msrtc.portal.core.config;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.support.RequestContextUtils;

public class LanguageExceptionHandler extends LocaleChangeInterceptor{

	private static final String LOCALE_MR = "mr";
	private static final String LOCALE_EN = "en";
	
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
		LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
        try {
            super.preHandle(request, response, handler);
        } catch (ServletException e) {
        	if(request.getRequestURI()!=null && request.getRequestURI()!="" && request.getRequestURI().contains("showAdminLogin")){
        		localeResolver.setLocale(request, response, parseLocaleValue(LOCALE_EN));
        	}else{
        		localeResolver.setLocale(request, response, parseLocaleValue(LOCALE_MR));
        	}
            e.printStackTrace();
        } catch (IllegalArgumentException e) {
        	if(request.getRequestURI()!=null && request.getRequestURI()!="" && request.getRequestURI().contains("showAdminLogin")){
        		localeResolver.setLocale(request, response, parseLocaleValue(LOCALE_EN));
        	}else{
        		localeResolver.setLocale(request, response, parseLocaleValue(LOCALE_MR));
        	}
            e.printStackTrace();
        }
        return true;
    }
}
