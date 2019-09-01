package com.msrtc.portal.notification.web;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.msrtc.portal.applicant.domain.Applicant;
import com.msrtc.portal.applicant.dto.ApplicantPostAssocSearchDTO;
import com.msrtc.portal.applicant.service.ApplicantService;
import com.msrtc.portal.core.common.util.PageDetail;
import com.msrtc.portal.core.user.security.SecurityUtils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.msrtc.portal.notification.domain.Notification;
import com.msrtc.portal.notification.domain.UserNotification;
import com.msrtc.portal.notification.dto.NotificationSearchDTO;
import com.msrtc.portal.notification.dto.UserNotificationSearchDTO;
import com.msrtc.portal.notification.service.NotificationService;

@Controller
@RequestMapping(value = { "/notification"})
public class NotificationController {

	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	private NotificationService notificationService;
	
    @Autowired
    private MessageSource messageSource;
    
    @Autowired
	private ApplicantService applicantService;

    @RequestMapping(params = "operation=viewQueriesAndNotifications")
    public String viewQueriesAndNotifications(Model model, HttpServletRequest request) {
        log.debug("Showing Queries And Notifications");
        model.addAttribute("viewNotificationsPage", request.getParameter("viewNotificationsPage"));
        return "queriesAndNotifications";
    }

	@RequestMapping(params = "operation=notificationList")
	public String notificationList(Model model, NotificationSearchDTO notificationSearchDTO, PageDetail pageDetail) {
		log.debug("Finding all notification entries");
		Page<Notification> page = notificationService.searchNotifications(notificationSearchDTO, pageDetail.getPageable());

		model.addAttribute("page", page);
		model.addAttribute("pageDetail", pageDetail);
		model.addAttribute("notificationSearchDTO", notificationSearchDTO);

		int beginIndex = pageDetail.getBeginIndex(page.getNumber());
		model.addAttribute("beginIndex", beginIndex);
		model.addAttribute("endIndex", pageDetail.getEndIndex(page.getTotalPages(), beginIndex));
		
		if(pageDetail.isNewPage()){
			return "notificationListResult";
		} else {
			return "notificationList";
		}
	}

	@RequestMapping(params = "operation=newNotification")
	public String newNotification(Model model) {
		log.debug("Showing form to create new notification entry");
		
		model.addAttribute("castes", applicantService.findAllCastes());
    	model.addAttribute("posts", applicantService.findAllActivePost());
    	model.addAttribute("districts", applicantService.findAllDistricts());
		model.addAttribute("isNotifications", true);
		
		return "notificationForm";
	}

	@RequestMapping(params = "operation=saveNotification")
	public String saveNotification(Notification notification, final RedirectAttributes redirectAttributes, ApplicantPostAssocSearchDTO applicantPostAssocSearchDTO) {
		log.debug("Saving Notification with the information: {}", notification);

        boolean isNew = notification.getId() == null ||  notification.getId() == 0;

		try {
			notificationService.saveNotification(notification);
			if (isNew) {
				List<Integer> applicantIds = applicantService.filterApplicantIdList(applicantPostAssocSearchDTO);
				if ( applicantIds != null ) {
					applicantIds.forEach(applicantId -> {
						UserNotification userNotification = new UserNotification();
						userNotification.setNotificationId(notification.getId());
						userNotification.setApplicantId(new Long(applicantId));
						userNotification.setNotificationRead(false);
						userNotification.setSentOn(LocalDateTime.now());
						notificationService.saveUserNotification(userNotification);
					});
				}
			
				redirectAttributes.addFlashAttribute("message", messageSource.getMessage("notification.created", null, LocaleContextHolder.getLocale()));
			} else {
				redirectAttributes.addFlashAttribute("message", messageSource.getMessage("notification.updated", null, LocaleContextHolder.getLocale()));
			}
		} catch(Exception e){
			log.error(e.getMessage());
			redirectAttributes.addFlashAttribute("error", messageSource.getMessage("notification.save.failed", null, LocaleContextHolder.getLocale()));
		}
		
        return "redirect:/notification?operation=viewQueriesAndNotifications&viewNotificationsPage=true&menu=viewQueriesAndNotifications";
	}

	@RequestMapping(params = "operation=deleteNotification")
	public String deleteNotification(Long id, final RedirectAttributes redirectAttributes) {
		log.debug("Deleting notification entry with the notification id: {}", id);
        try {
            notificationService.deleteNotification(id);
            notificationService.deleteUserNotificationByNotificationId(id);
            redirectAttributes.addFlashAttribute("message", messageSource.getMessage("notification.deleted", null, LocaleContextHolder.getLocale()));
        } catch(Exception e){
            log.error(e.getMessage());
            redirectAttributes.addFlashAttribute("error", messageSource.getMessage("notification.delete.failed", null, LocaleContextHolder.getLocale()));
        }
        return "redirect:/notification?operation=viewQueriesAndNotifications&viewNotificationsPage=true&menu=viewQueriesAndNotifications";
	}
	
	@RequestMapping(params = "operation=userNotificationList")
	public String userNotificationList(Model model,UserNotificationSearchDTO userNotificationSearchDTO,PageDetail pageDetail) {
		log.debug("Finding all user notification entries");
		Long applicantId = SecurityUtils.getCurrentUser().getApplicant().getId();

		userNotificationSearchDTO.setApplicantId(applicantId);
		
		Page<UserNotification> page = notificationService.searchUserNotifications(userNotificationSearchDTO, pageDetail.getPageable());
		
		model.addAttribute("page", page);
		model.addAttribute("pageDetail", pageDetail);
		model.addAttribute("userNotificationSearchDTO", userNotificationSearchDTO);

		int beginIndex = pageDetail.getBeginIndex(page.getNumber());
		model.addAttribute("beginIndex", beginIndex);
		model.addAttribute("endIndex", pageDetail.getEndIndex(page.getTotalPages(), beginIndex));
		//model.addAttribute("userNotificationCount", notificationService.countUserNotificationsByApplicantId(applicantId));
		// List<UserNotification> userNotifications = notificationService.findUserNotificationsByApplicantId(applicantId);
		
		for (UserNotification userNotification : page.getContent()) {
			Notification notification = notificationService.findNotificationById(userNotification.getNotificationId());
			userNotification.setNotification(notification);
		}
		
		if (pageDetail.isNewPage()) {
			return "userNotificationListResult";
		} else {
			return "userNotificationList";
		}

	}
	
	@RequestMapping(params = "operation=markUserNotificationAsRead")
	public @ResponseBody Map<String, Object> markUserNotificationAsRead(@RequestParam("userNotificationId") Long userNotificationId,HttpServletRequest request ) {
		log.debug("Marking User Notification As Read " , userNotificationId);
		Map<String, Object> result = new HashMap<>();
		UserNotification userNotification=notificationService.findUserNotificationById(userNotificationId);
		boolean success = true;
		try {
			notificationService.markUserNotificationAsRead(userNotificationId);
			int unreadUserNotification = notificationService.countUserNotificationsByApplicantId(userNotification.getApplicantId());
			result.put("unreadUserNotification", unreadUserNotification);
		} catch(Exception e){
			log.error(e.getMessage());
			success = false;
		}
		HttpSession session = request.getSession();
		session.setAttribute("userNotificationCount", notificationService.countUserNotificationsByApplicantId(userNotification.getApplicantId()));
		result.put("success", success);
		return result;
	}
	
}

