package com.msrtc.portal.notification.service;

import java.util.List;

import com.msrtc.portal.notification.domain.Notification;
import com.msrtc.portal.notification.domain.UserNotification;
import com.msrtc.portal.notification.dto.NotificationSearchDTO;
import com.msrtc.portal.notification.dto.UserNotificationSearchDTO;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface NotificationService {

	List<Notification> findAllNotifications();

	Page<Notification> searchNotifications(NotificationSearchDTO notificationSearchDTO, Pageable pageable);

	Notification findNotificationById(Long id);

	void saveNotification(Notification notification);

	void deleteNotification(Long id);

	List<UserNotification> findAllUserNotifications();

	UserNotification findUserNotificationById(Long id);

	void saveUserNotification(UserNotification userNotification);

	void deleteUserNotification(Long id);
	
	List<UserNotification> findUserNotificationsByApplicantId(Long applicantId);
	
	Page<UserNotification> searchUserNotifications(UserNotificationSearchDTO userNotificationSearchDTO, Pageable pageable);
	
	void deleteUserNotificationByNotificationId(Long notificationId);
	
	void markUserNotificationAsRead(Long userNotificationId);
	
	int countUserNotificationsByApplicantId(Long applicantId);
}
