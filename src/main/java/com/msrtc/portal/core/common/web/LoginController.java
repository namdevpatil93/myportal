package com.msrtc.portal.core.common.web;

import com.msrtc.portal.core.common.aop.NoLogging;
import com.msrtc.portal.core.common.filter.SessionFixationProtectionCookie;
import com.msrtc.portal.core.common.util.CommonUtils;
import com.msrtc.portal.core.common.util.CookieUtils;
import com.msrtc.portal.core.common.util.EncryptorUtils;
import com.msrtc.portal.core.common.util.RandomGenerator;
import com.msrtc.portal.core.user.domain.UserRole;
import com.msrtc.portal.core.user.security.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;

@Controller
public class LoginController {

    protected static final String SESSION_ATTR = "SFP-ActiveID";

    @RequestMapping(value = {"/adminLogin" }, method = RequestMethod.GET)
    public String adminLogin() {
    	return "redirect:/showAdminLogin?lang=en";
    }
    
    @RequestMapping(value="/showAdminLogin")
    public String showAdminLogin(){
    	return "adminLogin";
    }

    @GetMapping(value = "/dashboard")
    public String dashboard(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
        Long currentUserParentRoleId = SecurityUtils.getCurrentUserParentRoleId();

        String ipAddress = "";
        try {
            ipAddress = CommonUtils.getClientIpAddr(request); //RandomGenerator.generateRandomId("SHA1PRNG", 32);
        } catch (Exception e) {
            e.printStackTrace();
        }

        String encryptedIpAddress = EncryptorUtils.encrypt(ipAddress);

        session.setAttribute(SESSION_ATTR, ipAddress);
        CookieUtils.setCookieValue(response, SessionFixationProtectionCookie.COOKIE_NAME, encryptedIpAddress, "/", -1, true);

        if(currentUserParentRoleId == UserRole.ADMIN.getId()){
            //return "redirect:/admin?operation=adminDashboard&menu=adminDashboard";
            return "redirect:/reports?operation=viewReports&menu=viewReports";
        } else {
            return "redirect:/applicant?operation=applicantDashboard&menu=applicantDashboard";
        }
    }

    @NoLogging
    @RequestMapping("/keepAlive")
    public String keepAlive(Model model, HttpServletResponse response){
        sendResponse(response);
        return null;
    }

    @NoLogging
    @RequestMapping("/continueSession")
    public String continueSession(HttpServletResponse response){
        sendResponse(response);
        return null;
    }

    private void sendResponse(HttpServletResponse response) {
        ServletOutputStream out = null;
        try {
            out = response.getOutputStream();
            out.write("OK".getBytes());
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                out.flush();
                out.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
