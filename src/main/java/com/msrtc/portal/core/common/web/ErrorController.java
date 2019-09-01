package com.msrtc.portal.core.common.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.web.AbstractErrorController;
import org.springframework.boot.autoconfigure.web.ErrorAttributes;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

@Controller
public class ErrorController extends AbstractErrorController {

	private static final String ERROR_PATH = "/error";

	@Autowired
	public ErrorController(ErrorAttributes errorAttributes) {
		super(errorAttributes);
	}

    @Override
    public String getErrorPath() {
        return ERROR_PATH;
    }

    @RequestMapping(ERROR_PATH)
    public String handleErrors(HttpServletRequest request, Model model) {
        HttpStatus status = getStatus(request);

        if (status.equals(HttpStatus.NOT_FOUND))
            throw new NotFoundException();

        model.addAttribute("errorAttributes", getErrorAttributes(request, false));

        return "500";
    }

    @ExceptionHandler(NotFoundException.class)
    public String pageNotFound(Exception e, Model model) {
        model.addAttribute("exception", e);
        return "404";
    }

    @RequestMapping(value = "/accessDenied", method = { RequestMethod.GET, RequestMethod.POST })
    public String accessDenied() {
        return "accessDenied";
    }

}

class NotFoundException extends RuntimeException {}