package com.msrtc.portal.notification.domain;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "user_notifications")
public class UserNotification implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "id", nullable = false)
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	@Column(name = "notification_id")
	private Long notificationId;

	@Column(name = "applicant_id")
	private Long applicantId;

	@Column(name = "sent_on")
	private LocalDateTime sentOn;

	@Column(name = "notification_read")
	private boolean notificationRead;
	
	@Transient
	private Notification notification;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getNotificationId() {
		return notificationId;
	}

	public void setNotificationId(Long notificationId) {
		this.notificationId = notificationId;
	}

	public Long getApplicantId() {
		return applicantId;
	}

	public void setApplicantId(Long applicantId) {
		this.applicantId = applicantId;
	}

	public LocalDateTime getSentOn() {
		return sentOn;
	}

	public void setSentOn(LocalDateTime sentOn) {
		this.sentOn = sentOn;
	}

	public boolean isNotificationRead() {
		return notificationRead;
	}

	public void setNotificationRead(boolean notificationRead) {
		this.notificationRead = notificationRead;
	}

	public Notification getNotification() {
		return notification;
	}

	public void setNotification(Notification notification) {
		this.notification = notification;
	}

	@Override
	public String toString() {
		return "UserNotification [id=" + id + ", notificationId="
				+ notificationId + ", applicantId=" + applicantId + ", sentOn="
				+ sentOn + ", notificationRead=" + notificationRead
				+ ", notification=" + notification + "]";
	}

}
