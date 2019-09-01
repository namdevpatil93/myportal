package com.msrtc.portal.core.common.interceptor;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * The type Menu option param interceptor.
 */
public class MenuOptionParamInterceptor extends HandlerInterceptorAdapter {

    /**
     * The constant MENU_OPTION_PARAM_NAME.
     */
    public static final String MENU_OPTION_PARAM_NAME = "menu";

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        request.setAttribute(MENU_OPTION_PARAM_NAME, request.getParameter(MENU_OPTION_PARAM_NAME));
        return true;
    }

    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        Object value = request.getAttribute(MENU_OPTION_PARAM_NAME);
        if(modelAndView != null && value != null) {
            modelAndView.addObject(MENU_OPTION_PARAM_NAME, String.valueOf(value));
        }
    }

}
