package com.msrtc.portal.core.systemsetting.util;

/**
 * Enum which maps to the System Settings defined in the
 * <i>system_settings</i> table. <br>
 * Enum values defined in this class map to the <i>id</i> column of the
 * <i>system_settings</i> table.
 */
public enum SystemSettingEnum {

    /**
     * The test system setting.
     */
	/**
	 * Sms gateway common properties
	 */
	SMS_GUPSHUP_METHOD(1),
	SMS_GUPSHUP_USERID(2),
	SMS_GUPSHUP_PASSWORD(3),
	SMS_GUPSHUP_BASEURL(4),
	SMS_GUPSHUP_MSG_TYPE(5),
	SMS_GUPSHUP_AUTY_SCHEME(6),
	SMS_GUPSHUP_MASK(7),
	SMS_GUPSHUP_VERSION(8),
	
	/**
	 *  offline payment common properties
	 */
	OFFLINE_PAYMENT_FEES_TYPE(9),
	OFFLINE_PAYMENT_BANK_CHARGES(10),
	OFFLINE_LAST_DATE_OF_PAYMENT(12),
	
	/**
	 * Age validation between fixedDate and dateOfBirth
	 */
	REFERENCE_DATE(11),
	
	/**
	 * Age validation between fixedDate and dateOfBirth
	 */
	
	CHALLAN_EMAIL_SUBJECT(21),
	CHALLAN_EMAIL_IDS(22),
	CHALLAN_EMAIL_BODY(23),
	ENABLE_SENDING_CHALLAN_EMAIL_AUTOMATIC(24),
	CHALLAN_CRON_VALUE(25),
	START_DATE_OF_REGISTRATION(26),
	REPORT_EMAIL_SUBJECT(28),
	APPLICATION_REPORT_EMAIL_IDS(27),
	REPORT_EMAIL_BODY(29),
	LAST_DATE_OF_APPLICATION(13),
	ENABLE_SENDING_REPORT_EMAIL_AUTOMATIC(30),
	REPORT_CRON_VALUE(31),
	DRIVE_ID(14),
	
	EXAMBENCHBASEURL(15),
	EXAMBENCHACCESSTOKEN(16),
	DISABLE_NEW_REGISTRATION(17),
    DISABLE_SAVE_AS_DRAFT(18),
    DISABLE_POST_SELECTION(19),
    DISABLE_PAYMENTS(20),
	SAVE_APPLICANT_HISTORY(32),
	ENABLE_AUTOMATIC_PAYMENT_REPORT(37),
	PAYMENT_REPORT_EMAIL_IDS(33),
	PAYMENT_REPORT_EMAIL_SUBJECT(34),
	PAYMENT_REPORT_CRON_VALUE(35),
	PAYMENT_REPORT_EMAIL_BODY(36),
	START_DATE_REPORT_GENERATION(38),
	ENABLE_PREFFERED_CITY_EMAIL(39),
	PREFFERED_CITY_CRON_VALUE(40),
	PREFFERED_CITY_EMAIL_IDS(41),
	PREFFERED_CITY_EMAIL_SUBJECT(42),
	PREFFERED_CITY_EMAIL_BODY(43),
	START_DATE_OF_EDIT_WINDOW(44),
	END_DATE_OF_EDIT_WINDOW(45)
	;
	
	
	
    /**
     * The value.
     */
    private long value;

    /**
     * Instantiates a new System Setting enum.
     *
     * @param value the value
     */
    SystemSettingEnum(long value) {
        this.value = value;
    }

    /**
     * Gets the value.
     *
     * @return the value
     */
    public long getValue() {
        return this.value;
    }
}
