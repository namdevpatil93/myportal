package com.msrtc.portal.notification.repository;

import com.msrtc.portal.notification.domain.Notification;
import com.msrtc.portal.core.common.repository.BaseRepository;

public interface NotificationRepository extends BaseRepository<Notification, Long>, NotificationRepositoryCustom {

}

