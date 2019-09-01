package com.msrtc.portal.notification.service.impl;

import com.msrtc.portal.notification.domain.Notification;
import com.msrtc.portal.notification.domain.UserNotification;
import com.msrtc.portal.notification.dto.NotificationSearchDTO;
import com.msrtc.portal.notification.dto.UserNotificationSearchDTO;
import com.msrtc.portal.notification.repository.NotificationRepository;
import com.msrtc.portal.notification.repository.UserNotificationRepository;
import com.msrtc.portal.notification.service.NotificationService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service(value = "notificationService")
@Transactional(readOnly = true)
public class NotificationServiceImpl implements NotificationService {

	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	private NotificationRepository notificationRepository;

	@Autowired
	private UserNotificationRepository userNotificationRepository;

	@Override
	public List<Notification> findAllNotifications() {
		log.debug("Finding all notification entries");
		return (List<Notification>) notificationRepository.findAll();
	}

	@Override
	public Page<Notification> searchNotifications(
			NotificationSearchDTO notificationSearchDTO, Pageable pageable) {
		return notificationRepository.searchNotifications(
				notificationSearchDTO, pageable);
	}

	@Override
	public Notification findNotificationById(Long id) {
		log.debug("Finding notification entry with the notification id: {}", id);
		return notificationRepository.findOne(id);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = { "java.lang.Exception" })
	public void saveNotification(Notification notification) {
		log.debug("Saving Notification with the information: {}", notification);

		boolean isNew = notification.getId() == null
				|| notification.getId() == 0;

		if (isNew) {
			notificationRepository.save(notification);
		} else {
			Notification dbNotification = notificationRepository
					.findOne(notification.getId());

			dbNotification.setTitle(notification.getTitle());
			dbNotification.setDescription(notification.getDescription());

			notificationRepository.save(dbNotification);
		}
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = { "java.lang.Exception" })
	public void deleteNotification(Long id) {
		log.debug("Deleting notification entry with the notification id: {}",
				id);
		notificationRepository.delete(id);
	}

	@Override
	public List<UserNotification> findAllUserNotifications() {
		log.debug("Finding all user notification entries");
		return (List<UserNotification>) userNotificationRepository.findAll();
	}

	@Override
	public UserNotification findUserNotificationById(Long id) {
		log.debug(
				"Finding user notification entry with the user notification id: {}",
				id);
		return userNotificationRepository.findOne(id);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = { "java.lang.Exception" })
	public void saveUserNotification(UserNotification userNotification) {
		log.debug("Saving User Notification with the information: {}",
				userNotification);

		boolean isNew = userNotification.getId() == null
				|| userNotification.getId() == 0;

		if (isNew) {
			userNotificationRepository.save(userNotification);
		} else {
			UserNotification dbUserNotification = userNotificationRepository
					.findOne(userNotification.getId());
			dbUserNotification.setNotificationId(userNotification
					.getNotificationId());
			dbUserNotification
					.setApplicantId(userNotification.getApplicantId());
			dbUserNotification.setSentOn(userNotification.getSentOn());
			dbUserNotification.setNotificationRead(userNotification
					.isNotificationRead());

			userNotificationRepository.save(dbUserNotification);
		}

	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = { "java.lang.Exception" })
	public void deleteUserNotification(Long id) {
		log.debug(
				"Deleting user notification entry with the user notification id: {}",
				id);
		userNotificationRepository.delete(id);

	}

	@Override
	public List<UserNotification> findUserNotificationsByApplicantId(Long applicantId) {
		log.debug("Finding user notifications entries with the applicant id: {}",
				applicantId);
		return (List<UserNotification>) userNotificationRepository.findAllByApplicantId(applicantId);
	}

	@Override
	public Page<UserNotification> searchUserNotifications(
			UserNotificationSearchDTO userNotificationSearchDTO, Pageable pageable) {
		return userNotificationRepository.searchUserNotifications(userNotificationSearchDTO,pageable);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = { "java.lang.Exception" })
	public void deleteUserNotificationByNotificationId(Long notificationId) {
		log.debug("Deleting user notification entry with the notification id: {}",
				notificationId);
		userNotificationRepository.deleteByNotificationId(notificationId);
		
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = { "java.lang.Exception" })
	public void markUserNotificationAsRead(Long userNotificationId) {
		userNotificationRepository.markUserNotificationAsRead(userNotificationId);
	}

	@Override
	public int countUserNotificationsByApplicantId(Long applicantId) {
		return userNotificationRepository.countUserNotificationsByApplicantId(applicantId);
	}

}
