package com.msrtc.portal.notification.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.msrtc.portal.notification.domain.UserNotification;
import com.msrtc.portal.notification.dto.NotificationSearchDTO;
import com.msrtc.portal.notification.dto.UserNotificationSearchDTO;

public interface UserNotificationRepositoryCustom {
	 Page<UserNotification> searchUserNotifications(UserNotificationSearchDTO userNotificationSearchDTO, Pageable pageable);
}
