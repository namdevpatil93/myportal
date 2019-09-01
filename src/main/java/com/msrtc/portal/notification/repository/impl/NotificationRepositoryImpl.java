package com.msrtc.portal.notification.repository.impl;

import com.querydsl.core.BooleanBuilder;
import com.msrtc.portal.notification.domain.QNotification;
import com.msrtc.portal.notification.domain.Notification;
import com.msrtc.portal.notification.dto.NotificationSearchDTO;
import com.msrtc.portal.notification.repository.NotificationRepository;
import com.msrtc.portal.notification.repository.NotificationRepositoryCustom;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.util.StringUtils;

public class NotificationRepositoryImpl implements NotificationRepositoryCustom {

    @Autowired
    private NotificationRepository notificationRepository;

    @Override
    public Page<Notification> searchNotifications(NotificationSearchDTO notificationSearchDTO, Pageable pageable) {
        QNotification notification = QNotification.notification;

        BooleanBuilder queryBuilder = new BooleanBuilder();

        int searchType = notificationSearchDTO.getSearchType();

        if(searchType == 1){
            String searchText = notificationSearchDTO.getSearchText();
            if(!StringUtils.isEmpty(searchText)){
                queryBuilder.or(notification.title.containsIgnoreCase(searchText));
                queryBuilder.or(notification.description.containsIgnoreCase(searchText));
            }
        }

        return notificationRepository.findAll(queryBuilder.getValue(), pageable);
    }
}

