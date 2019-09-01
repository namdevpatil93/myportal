package com.msrtc.portal.notification.repository;

import com.msrtc.portal.notification.domain.Notification;
import com.msrtc.portal.notification.dto.NotificationSearchDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface NotificationRepositoryCustom {

    Page<Notification> searchNotifications(NotificationSearchDTO notificationSearchDTO, Pageable pageable);

}

