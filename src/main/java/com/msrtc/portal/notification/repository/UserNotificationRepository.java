package com.msrtc.portal.notification.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.msrtc.portal.core.common.repository.BaseRepository;
import com.msrtc.portal.core.module.domain.Module;
import com.msrtc.portal.notification.domain.UserNotification;

public interface UserNotificationRepository extends BaseRepository<UserNotification, Long>,UserNotificationRepositoryCustom{
	
	List<UserNotification> findAllByApplicantId(Long applicantId);
	
	void deleteByNotificationId(Long notificationId);

	 @Modifying(clearAutomatically = true)
	 @Query("UPDATE UserNotification SET notificationRead=true WHERE id = :userNotificationId")
	 void markUserNotificationAsRead(@Param("userNotificationId") Long userNotificationId);
	 
	 @Query("SELECT COUNT(id) FROM UserNotification WHERE applicantId = :applicantId and notificationRead=false")
	 int countUserNotificationsByApplicantId(@Param("applicantId") Long applicantId);
}
