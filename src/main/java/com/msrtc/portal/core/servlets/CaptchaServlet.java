package com.msrtc.portal.core.servlets;

import cn.apiclub.captcha.Captcha;
import cn.apiclub.captcha.servlet.CaptchaServletUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "CaptchaServlet", urlPatterns = "/captcha")
public class CaptchaServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        java.util.List<Color> colors = new ArrayList<Color> ();
        colors.add(Color.black);
        colors.add(Color.red);

        java.util.List<Font> fonts = new ArrayList<Font>();
        fonts.add(new Font("Arial", Font.ITALIC, 40));

        /*Captcha captcha = new Captcha.Builder(120, 50)
                .addText(new DefaultWordRenderer(colors, fonts))
                .addBackground(new GradiatedBackgroundProducer(Color.white, Color.white))
                .gimp()
                .addBorder()
                .build();*/
/*
        Captcha captcha = new Captcha.Builder(200, 50)
             .addText()
             .addBackground()
             .addNoise()
             .gimp()
             .addBorder()
             .build(); // Required.*/

        Captcha captcha = new Captcha.Builder(200, 50)
             .addText()
             .addBorder()
             .build();

        // display the image produced
        CaptchaServletUtil.writeImage(response, captcha.getImage());

        // save the captcha value on session
        request.getSession().setAttribute("simpleCaptcha", captcha);
    }
}
