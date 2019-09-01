package com.msrtc.portal.notification.repository.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.util.StringUtils;

import com.msrtc.portal.notification.domain.QUserNotification;
import com.msrtc.portal.notification.domain.UserNotification;
import com.msrtc.portal.notification.dto.UserNotificationSearchDTO;
import com.msrtc.portal.notification.repository.UserNotificationRepository;
import com.msrtc.portal.notification.repository.UserNotificationRepositoryCustom;
import com.querydsl.core.BooleanBuilder;

public class UserNotificationRepositoryImpl implements UserNotificationRepositoryCustom {
   
	@Autowired
    private UserNotificationRepository userNotificationRepository;

	@Override
	public Page<UserNotification> searchUserNotifications(
			UserNotificationSearchDTO userNotificationSearchDTO, Pageable pageable) {
		 QUserNotification userNotification = QUserNotification.userNotification;
		 BooleanBuilder queryBuilder = new BooleanBuilder();
         queryBuilder.or(userNotification.applicantId.eq(userNotificationSearchDTO.getApplicantId()));
		 return userNotificationRepository.findAll(queryBuilder.getValue(), pageable);
	}

	  /*  @Override
	    public Page<UserNotification> searchUserNotifications(UserNotificationSearchDTO userNotificationSearchDTO, Pageable pageable) {
	        QUserNotification userNotification = QUserNotification.userNotification;

	        BooleanBuilder queryBuilder = new BooleanBuilder();

	        int searchType = userNotificationSearchDTO.getSearchType();

	        if(searchType == 1){
	            String searchText = userNotificationSearchDTO.getSearchText();
	            if(!StringUtils.isEmpty(searchText)){
	                queryBuilder.or(userNotification.notification.title.containsIgnoreCase(searchText));
	                queryBuilder.or(userNotification.notification.description.containsIgnoreCase(searchText));
	            }
	        }

	        return userNotificationRepository.findAll(queryBuilder.getValue(), pageable);
	    }*/
	}