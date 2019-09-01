package com.msrtc.portal.core.user.security;

import com.msrtc.portal.core.common.util.Constants;
import com.msrtc.portal.core.user.domain.UserRole;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.util.StringUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class LoginFailureHandlerImpl extends SimpleUrlAuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(HttpServletRequest request,
                                        HttpServletResponse response,
                                        AuthenticationException exception) throws IOException, ServletException {
        String username = request.getParameter("username");
        int userType = 2;
        if(!StringUtils.isEmpty(username)){
            String[] userDetails = username.split("|");
            if(userDetails != null && userDetails.length > 1){
                userType = Integer.parseInt(userDetails[0]);
            }
        }

        if(userType == UserRole.ADMIN.getId()){
            setDefaultFailureUrl(Constants.ADMIN_LOGIN_URL + "?login_error=1");
        } else {
            setDefaultFailureUrl(Constants.APPLICANT_LOGIN_URL  + "?login_error=1");
        }

        super.onAuthenticationFailure(request, response, exception);
    }
}

