package com.msrtc.portal.applicant.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.stream.Collectors;

import com.msrtc.portal.applicant.domain.*;
import com.msrtc.portal.applicant.dto.*;
import com.msrtc.portal.applicant.repository.*;
import com.msrtc.portal.applicant.service.ApplicantPostAssocService;
import com.msrtc.portal.applicant.util.UndertakingPDFGenerator;
import com.msrtc.portal.challan.domain.ApplicantPostPaymentMismatch;
import com.msrtc.portal.core.user.service.UserService;

import org.apache.commons.lang.time.DateUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.msrtc.portal.applicant.rest.ApplicantRestApi;
import com.msrtc.portal.applicant.service.ApplicantService;
import com.msrtc.portal.applicant.service.ChangePasswordRequestService;
import com.msrtc.portal.applicantQuery.repository.ApplicantQueryReplyRepository;
import com.msrtc.portal.core.common.util.CommonUtils;
import com.msrtc.portal.core.common.util.Constants;
import com.msrtc.portal.core.common.util.ExcelWriterUtils;
import com.msrtc.portal.core.common.util.FileUtils;
import com.msrtc.portal.core.common.util.PageDetail;
import com.msrtc.portal.core.config.ApplicationProperties;
import com.msrtc.portal.core.role.domain.Role;
import com.msrtc.portal.core.systemsetting.service.SystemSettingService;
import com.msrtc.portal.core.systemsetting.util.SystemSettingEnum;
import com.msrtc.portal.core.user.domain.UserRole;
import com.msrtc.portal.core.user.security.PasswordUtils;
import com.msrtc.portal.email.service.SendEmailService;
import com.msrtc.portal.payment.domain.PaymentModeEnum;
import com.msrtc.portal.payment.domain.PaymentTransaction;
import com.msrtc.portal.payment.domain.PaymentTransactionStatusEnum;
import com.msrtc.portal.payment.repository.PaymentTransactionRepository;
import com.msrtc.portal.payment.service.PaymentTransactionService;
import com.msrtc.portal.qualification.domain.Qualification;
import com.msrtc.portal.qualification.service.QualificationService;
import com.msrtc.portal.sms.service.SentSMSService;
import com.opencsv.CSVWriter;
import com.querydsl.core.types.OrderSpecifier;

@Service(value = "applicantService")
@Transactional(readOnly = true)
public class ApplicantServiceImpl implements ApplicantService {

	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	private ApplicantRepository applicantRepository;

	@Autowired
	private PasswordUtils passwordUtils;

	@Autowired
	private SendEmailService sendEmailService;

	@Autowired
	private SentSMSService sentSMSService;

	@Autowired
	private CasteRepository casteRepository;

	@Autowired
	private PostRepository postRepository;

	@Autowired
	private ApplicationProperties applicationProperties;

	@Autowired
	private ApplicantOTPRepository applicantOTPRepository;

	@Autowired
	private ApplicantPostAssocRepository applicantPostAssocRepository;

	@Autowired
	private PostCategoryRepository postCategoryRepository;

	@Autowired
	private ApplicantOtherInformationRepository applicantOtherInformationRepository;

	@Autowired
	private DivisionRepository divisionRepository;

	@Autowired
	private TradeRepository tradeRepository;

	@Autowired
	private ChangePasswordRequestService changePasswordRequestService;

	@Autowired
	private PostSuperCategoryRepository postSuperCategoryRepository;

	@Autowired
	private ApplicantFilesRepository applicantFilesRepository;

	@Autowired
	private CityRepository cityRepository;

	@Autowired
	private DistrictRepository districtRepository;

	@Autowired
	private PaymentTransactionRepository paymentTransactionRepository;

	@Autowired
	private PostDivisionAssocRepository postDivisionAssocRepository;

	@Autowired
	private ApplicantQueryReplyRepository applicantQueryReplyRepository;

	@Autowired
	private SystemSettingService systemSettingService;

	@Autowired
	private ApplicantRestApi applicantRestApi;

	@Autowired
	private MessageSource messageSource;

	@Autowired
	private ApplicantPostAssocService applicantPostAssocService;

	@Autowired
	private ApplicantFormRepository applicantFormRepository;

	@Autowired
	private UserService userService;

	@Autowired
	private QualificationService qualificationService;

	@Autowired
	private ApplicantService applicantService;
	
	@Autowired
	private ApplicantHistoryRepository applicantHistoryRepository;
	
	@Autowired
	private ApplicantOtherInformationHistoryRepository applicantOtherInformationHistoryRepository;
	
	@Autowired
	private PaymentTransactionService paymentTransactionService;
	
	@Override
	public List<Applicant> findAllApplicants() {
		log.debug("Finding all applicant entries");
		return (List<Applicant>) applicantRepository.findAll();
	}

	@Override
	public Page<Applicant> searchApplicants(
			ApplicantSearchDTO applicantSearchDTO, Pageable pageable) {
		return applicantRepository.searchApplicants(applicantSearchDTO,
				pageable);
	}

	@Override
	public Applicant findApplicantById(Long id) {
		log.debug("Finding applicant entry with the applicant id: {}", id);
		return applicantRepository.findOne(id);
	}

	@Override
	public Applicant findApplicantByApplicationId(String applicationId) {
		log.debug("Finding applicant entry with the applicant id: {}",
				applicationId);
		return applicantRepository.findByApplicationId(applicationId);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = { "java.lang.Exception" })
	public void saveApplicant(Applicant applicant) {
		log.debug("Saving Applicant with the information: {}", applicant);

		boolean isNew = applicant.getId() == null || applicant.getId() == 0;
		String SaveHistoryEnable = systemSettingService
				.getSystemSetting(SystemSettingEnum.SAVE_APPLICANT_HISTORY);

		if (isNew) {
			applicant.setFirstLogin(Boolean.TRUE);
			applicant.setCreatedDate(LocalDateTime.now());
			applicant.setLastModifiedDate(LocalDateTime.now());
			applicant.setRole(new Role((long) UserRole.APPLICANT.getId()));

			String plainPassword = CommonUtils.generateRandomPassword();
			applicant.setPlainPassword(plainPassword);
			applicant.setPassword(passwordUtils
					.encryptUserPassword(plainPassword));

			applicant.setMobileNoVerified(Boolean.FALSE);
			

			/*
			 * Caste caste = new Caste();
			 * caste.setId(Long.valueOf(CasteEnum.OPEN.getCasteId()));
			 * applicant.setCaste(caste);
			 */

			// ---------- when new user register applicant and applicant_file
			// entity status set to '0' ----------
			applicant.setStatus(StatusEnum.DRAFT.getId());

			applicantRepository.save(applicant);

			ApplicantOtherInformation applicantOtherInformation = new ApplicantOtherInformation();
			applicantOtherInformation.setApplicant(applicant);
			applicantOtherInformation.setStatus(StatusEnum.DRAFT.getId());
			applicantOtherInformationRepository.save(applicantOtherInformation);

			ApplicantFiles applicantFiles = new ApplicantFiles();
			applicantFiles.setStatus(StatusEnum.DRAFT.getId());
			applicantFiles.setApplicantId(applicant.getId());
			applicantFilesRepository.save(applicantFiles);

			// ---------- when new user register applicant and applicant_file
			// entity status set to '0' ----------

			applicant.setApplicationId(CommonUtils
					.generateApplicationId(applicant.getId().toString()));

			applicantRepository.save(applicant);
			sendEmailService.sendSuccessfulRegistrationEmail(applicant);

			Integer otpNo = CommonUtils.generateRandomOTP();

			// ----------------------- save ApplicantOTP for successful
			// registration sms ------
			ApplicantOTP applicantOTP = new ApplicantOTP();
			applicantOTP.setApplicantId(applicant.getId());
			applicantOTP.setOtp(otpNo.toString());
			applicantOTPRepository.save(applicantOTP);

			// ---------------------- To send sms on successful registration
			// ------------------
			sentSMSService.sendSuccessfulRegistrationSMS(
					applicant.getMobileNumber(), applicant.getFirstName(),
					otpNo);
			if(SaveHistoryEnable.equals("0") ){
			applicantHistoryForNewUser(applicant,applicantOtherInformation);
			}

		} else {
			Applicant dbApplicant = applicantRepository.findOne(applicant
					.getId());

			dbApplicant.setFirstName(applicant.getFirstName());
			dbApplicant.setMiddleName(applicant.getMiddleName());
			dbApplicant.setLastName(applicant.getLastName());
			dbApplicant.setBirthDate(applicant.getBirthDate());
			if(applicantService.isApplicantApplyForPayment(applicant.getId())){
				applicant.setGender(dbApplicant.getGender());
			}
			if(dbApplicant.getGender()!=applicant.getGender()){
				resetPostDetails(dbApplicant,applicant);
			}
			dbApplicant.setGender(applicant.getGender());
			dbApplicant.setAddress(applicant.getAddress());
			dbApplicant.setPinCode(applicant.getPinCode());
			dbApplicant.setEmailAddress(applicant.getEmailAddress());

			String dbMobileNo = dbApplicant.getMobileNumber();
			String updatedMobileNo = applicant.getMobileNumber();

			if (!dbMobileNo.equals(updatedMobileNo)) {
				log.info("dbMobileNo [" + dbMobileNo + "] dupdatedMobileNo ["
						+ updatedMobileNo + "]");
				Integer newOtp = CommonUtils.generateRandomOTP();
				updateApplicantOTP(dbApplicant.getId(), String.valueOf(newOtp));
				sentSMSService.reSendOTP(updatedMobileNo,
						applicant.getFirstName(), newOtp);
				dbApplicant.setMobileNoVerified(Boolean.FALSE);
			}
			dbApplicant.setMobileNumber(applicant.getMobileNumber());
			// Qualification
			// qualification=qualificationService.findQualificationById(Long.parseLong(applicant.getHighestQualification()));
			dbApplicant.setHighestQualification(applicant
					.getHighestQualification());
			dbApplicant.setMaritalStatus(applicant.getMaritalStatus());
			dbApplicant.setMaharashtraDomiciled(applicant
					.getMaharashtraDomiciled());
			dbApplicant.setReadWriteSpeakMarathi(applicant
					.getReadWriteSpeakMarathi());
			dbApplicant.setChildOfFarmerWhoCommittedSuicide(applicant
					.getChildOfFarmerWhoCommittedSuicide());
			
			
			if(applicant.getDroughtAffected()!=null){
				
				/*if(applicant.getDroughtAffected()!=dbApplicant.getDroughtAffected()){
					Long postId =(long) 21;
					ApplicantPostAssoc applicantPostAssoc = applicantPostAssocRepository.findApplicantPostAssocByApplicantIdAndPostId(applicant.getId(),postId );
					if(applicantPostAssoc!=null){
					applicantPostAssoc.setDivisionId(null);
					applicantService.saveApplicantPostAssoc(applicantPostAssoc);
				}
					}*/
				
				
			dbApplicant.setDroughtAffected(applicant.getDroughtAffected());
			}
			if(applicant.getCaste().getId() != null){
				if(applicant.getCaste().getId()!=1 &&  applicant.getCaste().getId()!=3 && applicant.getCaste().getId()!=4){
					dbApplicant.setAllocatedCategory(applicant.getAllocatedCategory());
				}
				else{
                dbApplicant.setAllocatedCategory(applicant.getCaste().getId().intValue());

			}
			}
			if (applicant.getCaste() != null
					&& applicant.getCaste().getId() == null) {
				dbApplicant.setCaste(null);
			} else {
				dbApplicant.setCaste(applicant.getCaste());
			}

			dbApplicant.setNonCreamyLayer(applicant.getNonCreamyLayer());
			dbApplicant.setCertificateValidityEndingDate(applicant
					.getCertificateValidityEndingDate());
			dbApplicant.setStatus(applicant.getStatus());

			dbApplicant.setLastModifiedDate(LocalDateTime.now());
			dbApplicant.setSubcategory(applicant.getSubcategory());

			dbApplicant.setDistrictId(applicant.getDistrictId());
			dbApplicant.setFirstNameMarathi(applicant.getFirstNameMarathi());
			dbApplicant.setMiddleNameMarathi(applicant.getMiddleNameMarathi());
			dbApplicant.setLastNameMarathi(applicant.getLastNameMarathi());
			dbApplicant.setCertificateNumber(applicant.getCertificateNumber());
			/*if(applicant.getCaste().getId() == 11){
			dbApplicant.setIsBelongToEws(applicant.getIsBelongToEws());
			}else{
				dbApplicant.setIsBelongToEws(null);
			}
			if(applicant.getIsBelongToEws()!=null){
			dbApplicant.setEwsCertificateNumber(applicant.getEwsCertificateNumber());
			}else{
				dbApplicant.setEwsCertificateNumber(null);
			}*/
			
			dbApplicant.setIsBelongToEws(applicant.getIsBelongToEws());
			dbApplicant.setEwsCertificateNumber(applicant.getEwsCertificateNumber());
			
			/*if(applicant.getCaste().getId()==null||applicant.getCaste().getId() == 11){
				dbApplicant.setIsBelongToEws(applicant.getIsBelongToEws());
				dbApplicant.setEwsCertificateNumber(applicant.getEwsCertificateNumber());
			}*/
			applicantRepository.save(dbApplicant);
			if(SaveHistoryEnable.equals("0") ){
			applicantHistorySave(dbApplicant);
			}
		}
	}
	
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = { "java.lang.Exception" })
	private void applicantHistorySave(Applicant applicant) {
		ApplicantHistory applicantHistory=new ApplicantHistory();
		
		applicantHistory.setApplicationId(applicant.getApplicationId());
		applicantHistory.setFirstName(applicant.getFirstName());
		applicantHistory.setMiddleName(applicant.getMiddleName());
		applicantHistory.setLastName(applicant.getLastName());
		applicantHistory.setBirthDate(applicant.getBirthDate());
		//applicant.setGender(applicantHistory.getGender());
		applicantHistory.setGender(applicant.getGender());
		
		applicantHistory.setAddress(applicant.getAddress());
		applicantHistory.setPinCode(applicant.getPinCode());
		applicantHistory.setEmailAddress(applicant.getEmailAddress());
		applicantHistory.setMobileNumber(applicant.getMobileNumber());
		applicantHistory.setMaritalStatus(applicant.getMaritalStatus());
		applicantHistory.setMaharashtraDomiciled(applicant
				.getMaharashtraDomiciled());
		applicantHistory.setReadWriteSpeakMarathi(applicant
				.getReadWriteSpeakMarathi());
		applicantHistory.setCaste(applicant.getCaste());
		applicantHistory.setPassword(applicant.getPassword());
		applicantHistory.setCreatedDate(applicant.getCreatedDate());
		applicantHistory.setLastModifiedDate(LocalDateTime.now());
		applicantHistory.setRole(applicant.getRole());
		applicantHistory.setFirstLogin(applicant.getFirstLogin());
		applicantHistory.setNonCreamyLayer(applicant.getNonCreamyLayer());
		applicantHistory.setCertificateValidityEndingDate(applicant
				.getCertificateValidityEndingDate());
		applicantHistory.setStatus(applicant.getStatus());
		applicantHistory.setSubcategory(applicant.getSubcategory());
		applicantHistory.setDistrictId(applicant.getDistrictId());
		applicantHistory.setFirstNameMarathi(applicant.getFirstNameMarathi());
		applicantHistory.setMiddleNameMarathi(applicant.getMiddleNameMarathi());
		applicantHistory.setLastNameMarathi(applicant.getLastNameMarathi());
		applicantHistory.setMobileNoVerified(applicant.getMobileNoVerified());
		applicantHistory.setChildOfFarmerWhoCommittedSuicide(applicant
				.getChildOfFarmerWhoCommittedSuicide());
		applicantHistory.setHighestQualification(applicant
				.getHighestQualification());
		applicantHistory.setCertificateNumber(applicant.getCertificateNumber());
		
		applicantHistory.setAllocatedCategory(applicant.getAllocatedCategory());
		
		
		applicantHistory.setPlainPassword(applicant.getPlainPassword());
		
		
	//	applicantHistory.setDroughtAffected(applicant.getDroughtAffected());
		
		//applicantHistory.setCertificateNumber(applicant.getCertificateNumber());
		applicantHistory.setIsBelongToEws(applicant.getIsBelongToEws());
		applicantHistory.setEwsCertificateNumber(applicant.getEwsCertificateNumber());
		
		applicantHistoryRepository.save(applicantHistory);
		
		
	}

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = { "java.lang.Exception" })
	private void applicantHistoryForNewUser(Applicant applicant,
			ApplicantOtherInformation applicantOtherInformation) {
		
		ApplicantHistory applicantHistory=new ApplicantHistory();
		
		applicantHistory.setApplicationId(applicant.getApplicationId());
		applicantHistory.setMobileNumber(applicant.getMobileNumber());
		applicantHistory.setFirstName(applicant.getFirstName());
		applicantHistory.setMiddleName(applicant.getMiddleName());
		applicantHistory.setLastName(applicant.getLastName());
		applicantHistory.setFirstNameMarathi(applicant.getFirstNameMarathi());
		applicantHistory.setMiddleNameMarathi(applicant.getMiddleNameMarathi());
		applicantHistory.setLastNameMarathi(applicant.getLastNameMarathi());
		applicantHistory.setBirthDate(applicant.getBirthDate());
		//applicant.setGender(applicantHistory.getGender());
		applicantHistory.setGender(applicant.getGender());
		applicantHistory.setAddress(applicant.getAddress());
		applicantHistory.setPinCode(applicant.getPinCode());
		applicantHistory.setEmailAddress(applicant.getEmailAddress());
	/*	applicantHistory.setHighestQualification(applicant
				.getHighestQualification());*/
		
		/*applicantHistory.setMaritalStatus(applicant.getMaritalStatus());
		applicantHistory.setMaharashtraDomiciled(applicant
				.getMaharashtraDomiciled());
		applicantHistory.setReadWriteSpeakMarathi(applicant
				.getReadWriteSpeakMarathi());
		applicantHistory.setChildOfFarmerWhoCommittedSuicide(applicant
				.getChildOfFarmerWhoCommittedSuicide());*/
		
		applicantHistory.setFirstLogin(Boolean.TRUE);
		applicantHistory.setCreatedDate(LocalDateTime.now());
		applicantHistory.setLastModifiedDate(LocalDateTime.now());
		applicantHistory.setRole(applicant.getRole());
		
applicantHistory.setPlainPassword(applicant.getPlainPassword());
		applicantHistory.setPassword(passwordUtils
				.encryptUserPassword(applicant.getPlainPassword()));

		applicantHistory.setMobileNoVerified(applicant.getMobileNoVerified());
		applicantHistory.setStatus(applicant.getStatus());

		applicantHistoryRepository.save(applicantHistory);
		
		ApplicantOtherInformationHistory applicantOtherInformationHistory = new ApplicantOtherInformationHistory();
		applicantOtherInformationHistory.setApplicant(applicantOtherInformation.getApplicant().getId());
		applicantOtherInformationHistory.setStatus(applicantOtherInformation.getStatus());
		applicantOtherInformationHistoryRepository.save(applicantOtherInformationHistory);
		
		
		
	}

	public void resetPostDetails(Applicant dbApplicant, Applicant applicant) {
		List<ApplicantPostAssoc> applicantPostAssoclist =applicantPostAssocRepository.findByApplicantId(dbApplicant.getId());
		for(ApplicantPostAssoc applicantPostAssoc:applicantPostAssoclist ){
			if(applicantPostAssoc.getPostId()==21){
				PaymentTransaction pt = paymentTransactionRepository.findPaymentTransactionByOrderNo(applicantPostAssoc.getTxnOrderNo());
				if(pt==null ){
				applicantPostAssoc.setOwnHeavyDrivingLicenseNumber(null);
				applicantPostAssoc.setHeavyDrivingLicenseEndDate(null);
				applicantPostAssoc.setHeavyDrivingLicenseIssueDate(null);
				applicantPostAssoc.setHeavyDrivingLicenseNumber(null);
				applicantPostAssoc.setLightMotorVechicle(null);
				applicantPostAssoc.setLightMotorVechicleIssueDate(null);
				applicantPostAssoc.setLightMotorVechicleLicenseNo(null);
				applicantPostAssoc.setOwnPsvBatchNumber(null);
				applicantPostAssoc.setPsvBatchNumber(null);
				applicantPostAssoc.setExperienced(null);
				applicantPostAssoc.setCompanyName(null);
				applicantPostAssoc.setTotalExperienceInMonths(null);
				applicantPostAssoc.setTotalExperienceInYears(null);
				applicantPostAssoc.setStatus((long) StatusEnum.DRAFT.getId());
				}
			}
		}
		
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = { "java.lang.Exception" })
	public void deleteApplicant(Long id) {
		log.debug("Deleting applicant entry with the applicant id: {}", id);
		applicantRepository.delete(id);
	}

	@Override
	public Long totalApplicants() {
		return applicantRepository.count();
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = { "java.lang.Exception" })
	public void updatePassword(Applicant applicant) {
		log.debug(
				"Updating password of the applicant entry with the applicant id: {}",
				applicant.getId());
		final String encryptUserPassword = passwordUtils
				.encryptUserPassword(applicant.getNewPassword());
		applicantRepository.updatePassword(applicant.getId(),
				encryptUserPassword);
	}

	@Override
	public List<Caste> findAllCastes() {
		OrderSpecifier<Integer> sortByCasteOrder = QCaste.caste.casteOrder
				.asc();
		return (List<Caste>) casteRepository.findAll(sortByCasteOrder);
	}

	@Override
	public List<Post> findAllPost() {
		log.debug("Finding all post entries");
		return (List<Post>) postRepository.findAll();
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = { "java.lang.Exception" })
	public void saveApplicantFiles(Long applicantFilesId, Applicant applicant,
			MultipartFile photo, MultipartFile signature, int status) {
		String basePath = applicationProperties.getResources().getBasePath();

		String applicationId = applicant.getApplicationId();

		// String photoName = photo != null ? UUID.randomUUID().toString() + "_"
		// + photo.getOriginalFilename() : null;
		String photoFileExtension = photo != null ? photo.getOriginalFilename()
				.substring(photo.getOriginalFilename().lastIndexOf(".")) : null;
		String photoName = photo != null ? UUID.randomUUID().toString() + "_"
				+ applicationId + "_photo" + photoFileExtension : null;
		String photoLocation = basePath + File.separator
				+ Constants.BASE_UPLOAD_DIR + File.separator + applicationId
				+ File.separator + Constants.APPLICANT_PHOTO_UPLOAD_BASE_DIR;

		// String signatureName = signature != null ?
		// UUID.randomUUID().toString() + "_" + signature.getOriginalFilename()
		// : null;
		String signatureFileExtension = signature != null ? signature
				.getOriginalFilename().substring(
						signature.getOriginalFilename().lastIndexOf("."))
				: null;
		String signatureName = signature != null ? UUID.randomUUID().toString()
				+ "_" + applicationId + "_signature" + signatureFileExtension
				: null;
		String signatureLocation = basePath + File.separator
				+ Constants.BASE_UPLOAD_DIR + File.separator + applicationId
				+ File.separator
				+ Constants.APPLICANT_SIGNATURE_UPLOAD_BASE_DIR;

		if (photo != null
				&& !org.apache.commons.lang3.StringUtils.isBlank(photoName)) {
			FileUtils.deletePreviousFiles(photoLocation, photoName);
			FileUtils.saveFile(photo, photoName, photoLocation);
		}
		if (signature != null
				&& !org.apache.commons.lang3.StringUtils.isBlank(signatureName)) {
			FileUtils.deletePreviousFiles(signatureLocation, signatureName);
			FileUtils.saveFile(signature, signatureName, signatureLocation);
		}
		saveApplicantFiles(applicantFilesId, applicant, photoName,
				signatureName, status);

	}

	private void saveApplicantFiles(Long applicantFilesId, Applicant applicant,
			String photoName, String signatureName, int status) {
		ApplicantFiles dbApplicantFiles = new ApplicantFiles();
		String photoLocal = null;
		String signatureLocal = null;
		if (applicantFilesId != null && applicantFilesId != 0) {
			dbApplicantFiles = applicantFilesRepository
					.findOne(applicantFilesId);
			photoLocal = dbApplicantFiles.getPhotoFileName();
			signatureLocal = dbApplicantFiles.getSignatureFileName();
		}
		dbApplicantFiles.setApplicantId(applicant.getId());
		dbApplicantFiles.setPhotoFileName(org.apache.commons.lang3.StringUtils
				.isBlank(photoName) ? photoLocal : photoName);
		dbApplicantFiles
				.setSignatureFileName(org.apache.commons.lang3.StringUtils
						.isBlank(signatureName) ? signatureLocal
						: signatureName);
		dbApplicantFiles.setStatus(status);
		applicantFilesRepository.save(dbApplicantFiles);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = { "java.lang.Exception" })
	public void saveAllApplicantPostAssoc(String[] uiPostIds,
			Applicant applicant) {
		log.debug("Saving all applicantPostAssocs entries");

		List<Long> dbPostIds = applicantPostAssocRepository
				.findApplicantPostAssocByApplicantId(applicant.getId());

		if (dbPostIds != null && dbPostIds.size() > 0) {

			List<String> newlyAddedPostIds = findNewlyAddedPostIds(uiPostIds,
					dbPostIds);
			List<String> removedPostIds = findRemovedPostIds(uiPostIds,
					dbPostIds);

			if (newlyAddedPostIds != null && newlyAddedPostIds.size() > 0) {
				insertNewApplicantPosts(newlyAddedPostIds, applicant);
			}

			if (removedPostIds != null && removedPostIds.size() > 0) {
				removedPostIds
						.forEach(removedPostId -> {
							ApplicantPostAssoc applicantPostAssoc = applicantPostAssocRepository
									.findApplicantPostAssocByApplicantIdAndPostId(
											applicant.getId(),
											Long.valueOf(removedPostId));
							if (applicantPostAssoc != null) {
								String txnOrderNo = applicantPostAssoc
										.getTxnOrderNo();
								if (txnOrderNo == null
										|| StringUtils.isEmpty(txnOrderNo)) {
									applicantPostAssocRepository.deleteByApplicantIdAndPostId(
											applicant.getId(),
											Long.valueOf(removedPostId));
								}
							}
						});
			}
		} else {
			insertNewApplicantPosts(Arrays.asList(uiPostIds), applicant);
		}

	}

	private List<String> findRemovedPostIds(String[] uiPostIds,
			List<Long> dbPostIds) {
		List<String> removedPostIds = new ArrayList<String>();

		if (dbPostIds != null && dbPostIds.size() > 0) {
			for (Long dbPostId : dbPostIds) {
				boolean dbPostIdFound = false;
				for (String uiPostId : uiPostIds) {
					if (uiPostId.equals(dbPostId.toString())) {
						dbPostIdFound = true;
						break;
					}
				}
				if (!dbPostIdFound) {
					removedPostIds.add(String.valueOf(dbPostId));
				}
			}
		}

		return removedPostIds;
	}

	private List<String> findNewlyAddedPostIds(String[] uiPostIds,
			List<Long> dbPostIds) {
		List<String> newlyAddedPostIds = new ArrayList<String>();

		if (uiPostIds != null && uiPostIds.length > 0) {
			for (String uiPostId : uiPostIds) {
				boolean uiPostIdFound = false;
				for (Long dbPostId : dbPostIds) {
					if (uiPostId.equals(dbPostId.toString())) {
						uiPostIdFound = true;
						break;
					}
				}
				if (!uiPostIdFound) {
					newlyAddedPostIds.add(uiPostId);
				}
			}
		}

		return newlyAddedPostIds;
	}

	private void insertNewApplicantPosts(List<String> newPostIds,
			Applicant applicant) {
		List<ApplicantPostAssoc> newPosts = new ArrayList<>();

		for (String postId : newPostIds) {
			ApplicantPostAssoc applicantPostAssoc = new ApplicantPostAssoc();
			applicantPostAssoc.setApplicantId(applicant.getId());
			applicantPostAssoc.setPostId(Long.valueOf(postId));
			applicantPostAssoc.setStatus((long) StatusEnum.DRAFT.getId());
			applicantPostAssoc.setPdfGenerated(false);
			newPosts.add(applicantPostAssoc);
		}

		if (newPosts != null && newPosts.size() > 0) {
			applicantPostAssocRepository.save(newPosts);
		}
	}

	@Override
	public List<ApplicantPostAssoc> findApplicantPostAssocsByApplicant(
			Applicant applicant) {
		log.debug("Finding ApplicantPostAssoc entry with the applicant id: {}",
				applicant.getId());
		List<ApplicantPostAssoc> applicantPostAssocs = applicantPostAssocRepository
				.findByApplicantId(applicant.getId());

		if (applicantPostAssocs != null && applicantPostAssocs.size() > 0) {
			for (ApplicantPostAssoc applicantPostAssoc : applicantPostAssocs) {
				PaymentTransaction pt = paymentTransactionRepository
						.findPaymentTransactionByOrderNo(applicantPostAssoc
								.getTxnOrderNo());
				applicantPostAssoc.setPost(postRepository
						.findOne(applicantPostAssoc.getPostId()));
				if (pt != null) {
					applicantPostAssoc.setPaymentMode(String.valueOf(pt
							.getPaymentMode()));
					applicantPostAssoc.setTransactionStatus(pt.getStatus());
				}
				if (applicantPostAssoc.getDivisionId() != null) {

					applicantPostAssoc.setDivision(divisionRepository
							.findOne(applicantPostAssoc.getDivisionId()
									.longValue()));
				}
			}
		}

		return applicantPostAssocs;

	}

	@Override
	public List<PostCategory> findAllPostCategory() {
		log.debug("Finding all PostCategory entries");
		return (List<PostCategory>) postCategoryRepository.findAll();
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = { "java.lang.Exception" })
	public void saveApplicantOtherInformation(
			ApplicantOtherInformation applicantOtherInformation,
			Applicant applicant) {
		log.debug("Saving applicantOtherInformation entries");

		boolean isNew = applicantOtherInformation.getId() == null
				|| applicantOtherInformation.getId() == 0;
		String SaveHistoryEnable = systemSettingService
				.getSystemSetting(SystemSettingEnum.SAVE_APPLICANT_HISTORY);
		if (isNew) {
			applicantOtherInformation.setCreatedDate(LocalDateTime.now());
			applicantOtherInformation.setLastModifiedDate(LocalDateTime.now());
			applicantOtherInformationRepository.save(applicantOtherInformation);
			//newapplicantOtherInformationHistorySave(applicantOtherInformation);
			
		} else {
			ApplicantOtherInformation dbApplicantOtherInformation = applicantOtherInformationRepository
					.findApplicantOtherInformationByApplicant(applicant);
			dbApplicantOtherInformation.setApplicant(applicant);
			dbApplicantOtherInformation
					.setExServiceMan(applicantOtherInformation
							.getExServiceMan());
			dbApplicantOtherInformation
					.setProjectEffected(applicantOtherInformation
							.getProjectEffected());
			dbApplicantOtherInformation
					.setRetirementDate(applicantOtherInformation
							.getRetirementDate());
			dbApplicantOtherInformation
					.setEarthQuakeEffected(applicantOtherInformation
							.getEarthQuakeEffected());
			dbApplicantOtherInformation.setStEmployee(applicantOtherInformation
					.getStEmployee());
			dbApplicantOtherInformation
					.setPartTimeEmployee(applicantOtherInformation
							.getPartTimeEmployee());
			dbApplicantOtherInformation
					.setSportsPerson(applicantOtherInformation
							.getSportsPerson());
			dbApplicantOtherInformation
					.setSportsLevel(applicantOtherInformation.getSportsLevel());
			dbApplicantOtherInformation
					.setLastModifiedDate(LocalDateTime.now());
			dbApplicantOtherInformation.setStatus(applicantOtherInformation
					.getStatus());
			dbApplicantOtherInformation
					.setExServicemanTotalExperienceInYears(applicantOtherInformation
							.getExServicemanTotalExperienceInYears());
			dbApplicantOtherInformation
					.setExServicemanTotalExperienceInMonths(applicantOtherInformation
							.getExServicemanTotalExperienceInMonths());
			dbApplicantOtherInformation
					.setPartTimeEmployeeTotalExperienceInYears(applicantOtherInformation
							.getPartTimeEmployeeTotalExperienceInYears());
			dbApplicantOtherInformation
					.setPartTimeEmployeeTotalExperienceInMonths(applicantOtherInformation
							.getPartTimeEmployeeTotalExperienceInMonths());
			dbApplicantOtherInformation
					.setPreferredCity1(applicantOtherInformation
							.getPreferredCity1());
			dbApplicantOtherInformation
					.setPreferredCity2(applicantOtherInformation
							.getPreferredCity2());
			dbApplicantOtherInformation
					.setPreferredCity3(applicantOtherInformation
							.getPreferredCity3());
			dbApplicantOtherInformation.setOrphanedPerson(applicantOtherInformation
							.getOrphanedPerson());
			dbApplicantOtherInformation.setLocomotorOrCerebralPalsy(applicantOtherInformation
					.getLocomotorOrCerebralPalsy());
			dbApplicantOtherInformation.setDeafAndMute(applicantOtherInformation
					.getDeafAndMute());
			
			
			applicantOtherInformationRepository
					.save(dbApplicantOtherInformation);
			if(SaveHistoryEnable.equals("0") ){
			applicantOtherInformationHistorySave(dbApplicantOtherInformation);
			}
		}
	}

	/*private void newapplicantOtherInformationHistorySave(
			ApplicantOtherInformation applicantOtherInformation) {
		ApplicantOtherInformationHistory applicantOtherInformationHistory = new ApplicantOtherInformationHistory();
		applicantOtherInformationHistory.setCreatedDate(LocalDateTime.now());
		applicantOtherInformationHistory.setLastModifiedDate(LocalDateTime.now());
		applicantOtherInformationHistoryRepository.save(applicantOtherInformationHistory);
	}*/

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = { "java.lang.Exception" })
	private void applicantOtherInformationHistorySave(
			ApplicantOtherInformation applicantOtherInformation) {
		
		ApplicantOtherInformationHistory applicantOtherInformationHistory = new ApplicantOtherInformationHistory();
		/*applicantOtherInformationHistory.setApplicant(applicantOtherInformation.getApplicant().getId());
		applicantOtherInformationHistory.setStatus(applicantOtherInformation.getStatus());*/
		
		applicantOtherInformationHistory.setApplicant(applicantOtherInformation.getApplicant().getId());
		applicantOtherInformationHistory
				.setExServiceMan(applicantOtherInformation
						.getExServiceMan());
		applicantOtherInformationHistory
				.setProjectEffected(applicantOtherInformation
						.getProjectEffected());
		applicantOtherInformationHistory
				.setRetirementDate(applicantOtherInformation
						.getRetirementDate());
		applicantOtherInformationHistory
				.setEarthQuakeEffected(applicantOtherInformation
						.getEarthQuakeEffected());
		applicantOtherInformationHistory.setStEmployee(applicantOtherInformation
				.getStEmployee());
		applicantOtherInformationHistory
				.setPartTimeEmployee(applicantOtherInformation
						.getPartTimeEmployee());
		applicantOtherInformationHistory
				.setSportsPerson(applicantOtherInformation
						.getSportsPerson());
		applicantOtherInformationHistory
				.setSportsLevel(applicantOtherInformation.getSportsLevel());
		applicantOtherInformationHistory
				.setLastModifiedDate(LocalDateTime.now());
		applicantOtherInformationHistory.setStatus(applicantOtherInformation
				.getStatus());
		applicantOtherInformationHistory
				.setExServicemanTotalExperienceInYears(applicantOtherInformation
						.getExServicemanTotalExperienceInYears());
		applicantOtherInformationHistory
				.setExServicemanTotalExperienceInMonths(applicantOtherInformation
						.getExServicemanTotalExperienceInMonths());
		applicantOtherInformationHistory
				.setPartTimeEmployeeTotalExperienceInYears(applicantOtherInformation
						.getPartTimeEmployeeTotalExperienceInYears());
		applicantOtherInformationHistory
				.setPartTimeEmployeeTotalExperienceInMonths(applicantOtherInformation
						.getPartTimeEmployeeTotalExperienceInMonths());
		applicantOtherInformationHistory
				.setPreferredCity1(applicantOtherInformation
						.getPreferredCity1());
		applicantOtherInformationHistory
				.setPreferredCity2(applicantOtherInformation
						.getPreferredCity2());
		applicantOtherInformationHistory
				.setPreferredCity3(applicantOtherInformation
						.getPreferredCity3());
		applicantOtherInformationHistory.setOrphanedPerson(applicantOtherInformation
						.getOrphanedPerson());
		applicantOtherInformationHistory.setLocomotorOrCerebralPalsy(applicantOtherInformation
				.getLocomotorOrCerebralPalsy());
		applicantOtherInformationHistory.setDeafAndMute(applicantOtherInformation
				.getDeafAndMute());
		applicantOtherInformationHistoryRepository.save(applicantOtherInformationHistory);
		
	}

	@Override
	public ApplicantOTP findByApplicantId(Long applicantId) {
		return applicantOTPRepository.findByApplicantId(applicantId);
	}

	@Override
	public ApplicantOtherInformation findApplicantOtherInformationByApplicant(
			Applicant applicant) {
		log.debug(
				"Finding ApplicantOtherInformation entry with the applicant id: {}",
				applicant.getId());
		return applicantOtherInformationRepository
				.findApplicantOtherInformationByApplicant(applicant);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = { "java.lang.Exception" })
	public void deleteApplicantPost(Applicant applicant, Long postId) {
		ApplicantPostAssoc applicantPostAssoc = applicantPostAssocRepository
				.findApplicantPostAssocByApplicantIdAndPostId(
						applicant.getId(), postId);
		boolean paymentInitiated = false;
		if (applicantPostAssoc != null) {
			paymentInitiated = applicantPostAssoc.getStatus() == StatusEnum.PENDING
					.getId()
					|| applicantPostAssoc.getStatus() == StatusEnum.SUBMITTED
							.getId();
		}
		if (applicantPostAssoc != null && !paymentInitiated) {
			String txnOrderNo = applicantPostAssoc.getTxnOrderNo();
			if (txnOrderNo == null || StringUtils.isEmpty(txnOrderNo)) {
				applicantPostAssocRepository.deleteByApplicantIdAndPostId(
						applicant.getId(), postId);
			}
		}
	}

	@Override
	public void saveApplicantOTP(ApplicantOTP applicantOTP) {
		applicantOTPRepository.save(applicantOTP);
	}

	@Override
	public ApplicantFiles getApplicantFilesByApplicantId(Long applicantId) {

		return applicantFilesRepository.findByApplicantId(applicantId);
	}

	@Override
	public List<Division> findAllDivisions() {
		log.debug("Finding all division entries");
		OrderSpecifier<String> sortByDivisionTitle = QDivision.division.divisionTitle
				.asc();
		return (List<Division>) divisionRepository.findAll(sortByDivisionTitle);
	}

	@Override
	public List<Trade> findAllTrades() {
		log.debug("Finding all trades entries");
		return (List<Trade>) tradeRepository.findAll();
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = { "java.lang.Exception" })
	public void saveApplicantPostDetails(ApplicantPostAssoc applicantPostAssoc,
			Applicant applicant, MultipartFile experienceLetterScanCopy) {
		log.debug("Saving applicant post details.");

		String basePath = applicationProperties.getResources().getBasePath();

		String applicationId = applicant.getApplicationId();

		String experienceLetterUploadName = experienceLetterScanCopy != null ? UUID
				.randomUUID().toString()
				+ "_"
				+ experienceLetterScanCopy.getOriginalFilename() : null;
		String experienceLetterUploadLocation = basePath + File.separator
				+ Constants.BASE_UPLOAD_DIR + File.separator + applicationId
				+ File.separator + applicantPostAssoc.getPostId()
				+ File.separator + Constants.EXPERIENCE_LETTER_DIR;

		if (experienceLetterScanCopy != null) {
			FileUtils.deletePreviousFiles(experienceLetterUploadLocation,
					experienceLetterUploadName);
			FileUtils.saveFile(experienceLetterScanCopy,
					experienceLetterUploadName, experienceLetterUploadLocation);
		}

		ApplicantPostAssoc dbApplicantPostAssoc = applicantPostAssocRepository
				.findOne(applicantPostAssoc.getId());

		if (dbApplicantPostAssoc != null) {
			populatePostDetails(applicantPostAssoc, dbApplicantPostAssoc,
					experienceLetterUploadName);
			applicantPostAssocRepository.save(dbApplicantPostAssoc);
		}
	}

	private void populatePostDetails(ApplicantPostAssoc applicantPostAssoc,
			ApplicantPostAssoc dbApplicantPostAssoc,
			String experienceLetterUploadName) {
		dbApplicantPostAssoc.setSscPassed(applicantPostAssoc.getSscPassed());
		dbApplicantPostAssoc.setRequiredQualificationMarks(applicantPostAssoc
				.getRequiredQualificationMarks());
		dbApplicantPostAssoc.setOtherQualificationDetails(applicantPostAssoc
				.getOtherQualificationDetails());
		dbApplicantPostAssoc.setOtherQualification(applicantPostAssoc
				.getOtherQualification());

		dbApplicantPostAssoc.setNightBlindness(applicantPostAssoc
				.getNightBlindness());
		dbApplicantPostAssoc.setColorBlindness(applicantPostAssoc
				.getColorBlindness());
		dbApplicantPostAssoc.setVisionAcuity(applicantPostAssoc
				.getVisionAcuity());

		dbApplicantPostAssoc.setDifferentlyAbled(applicantPostAssoc
				.getDifferentlyAbled());
		dbApplicantPostAssoc.setBlindnessAndLowVision(applicantPostAssoc
				.getBlindnessAndLowVision());

		dbApplicantPostAssoc.setOwnHeavyDrivingLicenseNumber(applicantPostAssoc
				.getOwnHeavyDrivingLicenseNumber());
		dbApplicantPostAssoc.setHeavyDrivingLicenseNumber(applicantPostAssoc
				.getHeavyDrivingLicenseNumber());
		dbApplicantPostAssoc.setHeavyDrivingLicenseIssueDate(applicantPostAssoc
				.getHeavyDrivingLicenseIssueDate());
		dbApplicantPostAssoc.setHeavyDrivingLicenseEndDate(applicantPostAssoc
				.getHeavyDrivingLicenseEndDate());

		dbApplicantPostAssoc.setOwnPsvBatchNumber(applicantPostAssoc
				.getOwnPsvBatchNumber());
		dbApplicantPostAssoc.setPsvBatchNumber(applicantPostAssoc
				.getPsvBatchNumber());

		dbApplicantPostAssoc.setOwnConductorBatchNumber(applicantPostAssoc
				.getOwnConductorBatchNumber());
		dbApplicantPostAssoc.setConductorBatchNumber(applicantPostAssoc
				.getConductorBatchNumber());
		dbApplicantPostAssoc
				.setConductorBatchNumberIssueDate(applicantPostAssoc
						.getConductorBatchNumberIssueDate());
		dbApplicantPostAssoc.setConductorBatchNumberEndDate(applicantPostAssoc
				.getConductorBatchNumberEndDate());

		dbApplicantPostAssoc
				.setExperienced(applicantPostAssoc.getExperienced());
		dbApplicantPostAssoc.setMinThreeYrsExp(applicantPostAssoc
				.getMinThreeYrsExp());

		dbApplicantPostAssoc
				.setCompanyName(applicantPostAssoc.getCompanyName());
		dbApplicantPostAssoc.setTotalExperienceInYears(applicantPostAssoc
				.getTotalExperienceInYears());
		dbApplicantPostAssoc.setTotalExperienceInMonths(applicantPostAssoc
				.getTotalExperienceInMonths());

		dbApplicantPostAssoc.setHeightWithinRange(applicantPostAssoc
				.getHeightWithinRange());

		dbApplicantPostAssoc
				.setPastAccidentalOrDeathIncident(applicantPostAssoc
						.getPastAccidentalOrDeathIncident());
		dbApplicantPostAssoc
				.setPastAccidentalOrDeathIncidentReason(applicantPostAssoc
						.getPastAccidentalOrDeathIncidentReason());

		dbApplicantPostAssoc.setDivisionId(applicantPostAssoc.getDivisionId());
		dbApplicantPostAssoc.setTradeId(applicantPostAssoc.getTradeId());

		dbApplicantPostAssoc
				.setGuarantorPersonNameAndMobileNo(applicantPostAssoc
						.getGuarantorPersonNameAndMobileNo());
		dbApplicantPostAssoc.setGuarantorPersonName(applicantPostAssoc
				.getGuarantorPersonName());
		dbApplicantPostAssoc.setGuarantorPersonMobileNumber(applicantPostAssoc
				.getGuarantorPersonMobileNumber());

		dbApplicantPostAssoc.setItiPassed(applicantPostAssoc.getItiPassed());
		dbApplicantPostAssoc
				.setCollegeName(applicantPostAssoc.getCollegeName());

		dbApplicantPostAssoc
				.setGraduateFromAffiliatedInstitute(applicantPostAssoc
						.getGraduateFromAffiliatedInstitute());
		dbApplicantPostAssoc.setDegreeName(applicantPostAssoc.getDegreeName());

		dbApplicantPostAssoc.setUniversityName(applicantPostAssoc
				.getUniversityName());
		dbApplicantPostAssoc.setItEngineer(applicantPostAssoc.getItEngineer());
		dbApplicantPostAssoc.setKnowledgeOfSapAndOracle(applicantPostAssoc
				.getKnowledgeOfSapAndOracle());
		dbApplicantPostAssoc
				.setMinTenYrsExpAsItProjectManager(applicantPostAssoc
						.getMinTenYrsExpAsItProjectManager());

		dbApplicantPostAssoc.setTypingExamPassed(applicantPostAssoc
				.getTypingExamPassed());

		dbApplicantPostAssoc.setBcomPassed(applicantPostAssoc.getBcomPassed());
		dbApplicantPostAssoc.setOneYearExpAsAccountant(applicantPostAssoc
				.getOneYearExpAsAccountant());
		dbApplicantPostAssoc.setMscitOrGaccc(applicantPostAssoc
				.getMscitOrGaccc());

		dbApplicantPostAssoc
				.setTwoYearExpAsTransportAssociation(applicantPostAssoc
						.getTwoYearExpAsTransportAssociation());

		dbApplicantPostAssoc
				.setMbaFromGovernmentAffiliatedInstitute(applicantPostAssoc
						.getMbaFromGovernmentAffiliatedInstitute());

		dbApplicantPostAssoc
				.setbComOrBSCOrDiplomaHoldersInAutomobileOrMechanical(applicantPostAssoc
						.getbComOrBSCOrDiplomaHoldersInAutomobileOrMechanical());
		dbApplicantPostAssoc
				.setTwoYearExpAsTransportAssociation(applicantPostAssoc
						.getTwoYearExpAsTransportAssociation());
		dbApplicantPostAssoc.setMscitOrGaccc(applicantPostAssoc
				.getMscitOrGaccc());

		dbApplicantPostAssoc
				.setOneYearExpAsTransportAssociation(applicantPostAssoc
						.getOneYearExpAsTransportAssociation());

		dbApplicantPostAssoc.setMiltaryForceDegreeName(applicantPostAssoc
				.getMiltaryForceDegreeName());
		dbApplicantPostAssoc.setMiltaryForceUniversityName(applicantPostAssoc
				.getMiltaryForceUniversityName());
		dbApplicantPostAssoc.setFireAndSafetyDegreeName(applicantPostAssoc
				.getFireAndSafetyDegreeName());
		dbApplicantPostAssoc.setFireAndSafetyUniversityName(applicantPostAssoc
				.getFireAndSafetyDegreeName());
		dbApplicantPostAssoc
				.setQualificationForMilitaryForce(applicantPostAssoc
						.getQualificationForMilitaryForce());
		dbApplicantPostAssoc
				.setFireSafetyDegreeFromAffiliatedInstitute(applicantPostAssoc
						.getFireSafetyDegreeFromAffiliatedInstitute());

		dbApplicantPostAssoc
				.setAutomobileOrMechanicalEngDegree(applicantPostAssoc
						.getAutomobileOrMechanicalEngDegree());
		dbApplicantPostAssoc
				.setOneYearExpInAutomobileRepairing(applicantPostAssoc
						.getOneYearExpInAutomobileRepairing());

		dbApplicantPostAssoc.setStatus(applicantPostAssoc.getStatus());

		// Draftsman (Mechanics) (Jr.)
		dbApplicantPostAssoc.setDiplomaInAutocad(applicantPostAssoc
				.getDiplomaInAutocad());
		dbApplicantPostAssoc
				.setDiplomaInAutocadUniversityName(applicantPostAssoc
						.getDiplomaInAutocadUniversityName());
		dbApplicantPostAssoc
				.setAutocadCertificationFromGovernment(applicantPostAssoc
						.getAutocadCertificationFromGovernment());
		dbApplicantPostAssoc
				.setAutocadCertificationFromGovernmentInstituteName(applicantPostAssoc
						.getAutocadCertificationFromGovernmentInstituteName());
		dbApplicantPostAssoc.setExperienceInAutocad(applicantPostAssoc
				.getExperienceInAutocad());
		dbApplicantPostAssoc.setArchitectEngineeringDegree(applicantPostAssoc
				.getArchitectEngineeringDegree());
		dbApplicantPostAssoc
				.setExperienceLetterUpload(experienceLetterUploadName);
		dbApplicantPostAssoc
				.setMscitOrDoeaccPassCertification(applicantPostAssoc
						.getMscitOrDoeaccPassCertification());
		dbApplicantPostAssoc.setElectricalEngineeringDegree(applicantPostAssoc
				.getElectricalEngineeringDegree());

		// Differentyly abled others
		dbApplicantPostAssoc.setDifferentlyAbledOthers(applicantPostAssoc
				.getDifferentlyAbledOthers());
		dbApplicantPostAssoc.setDifferentlyAbledOthersText(applicantPostAssoc
				.getDifferentlyAbledOthersText());

		// Light motor vechile properties
		dbApplicantPostAssoc.setLightMotorVechicle(applicantPostAssoc
				.getLightMotorVechicle());
		dbApplicantPostAssoc.setLightMotorVechicleLicenseNo(applicantPostAssoc
				.getLightMotorVechicleLicenseNo());
		dbApplicantPostAssoc.setLightMotorVechicleIssueDate(applicantPostAssoc
				.getLightMotorVechicleIssueDate());

		dbApplicantPostAssoc.setApprenticeshipInMSRTC(applicantPostAssoc
				.getApprenticeshipInMSRTC());
		dbApplicantPostAssoc.setApprenticeshipInMSRTCTrade(applicantPostAssoc
				.getApprenticeshipInMSRTCTrade());
		dbApplicantPostAssoc.setApprenticeshipInMSRTCYear(applicantPostAssoc
				.getApprenticeshipInMSRTCYear());
		dbApplicantPostAssoc
				.setApprenticeshipInMSRTCDivision(applicantPostAssoc
						.getApprenticeshipInMSRTCDivision());

		dbApplicantPostAssoc.setFifteenYearExpInCommerce(applicantPostAssoc
				.getFifteenYearExpInCommerce());
		
		dbApplicantPostAssoc.setLocomotorOrCerebralPalsy(applicantPostAssoc.getLocomotorOrCerebralPalsy());

		/*
		 * dbApplicantPostAssoc.setLearningLicense(applicantPostAssoc.
		 * getLearningLicense());
		 * dbApplicantPostAssoc.setLearningLicenseNo(applicantPostAssoc
		 * .getLearningLicenseNo());
		 * dbApplicantPostAssoc.setLearningLicenseIssueDate
		 * (applicantPostAssoc.getLearningLicenseIssueDate());
		 */
		
		dbApplicantPostAssoc.setGradOrPostGrad(applicantPostAssoc.getGradOrPostGrad());
		dbApplicantPostAssoc.setInstituteName(applicantPostAssoc.getInstituteName());
		dbApplicantPostAssoc.setWorkExp(applicantPostAssoc.getWorkExp());
		dbApplicantPostAssoc.setPostName(applicantPostAssoc.getPostName());
		dbApplicantPostAssoc.setDcDivisionId(applicantPostAssoc.getDcDivisionId());
		
		/*if(applicantPostAssoc.getRequiredQualificationMarks()>=60){
			dbApplicantPostAssoc.setPostGradDegreeTypeId(null);
			dbApplicantPostAssoc.setPostGradDegreeInstituteName(null);
		}else{

		dbApplicantPostAssoc.setPostGradDegreeTypeId(applicantPostAssoc.getPostGradDegreeTypeId());
		dbApplicantPostAssoc.setPostGradDegreeInstituteName(applicantPostAssoc.getPostGradDegreeInstituteName());
		}*/
		
			dbApplicantPostAssoc.setPostGradDegreeTypeId(applicantPostAssoc.getPostGradDegreeTypeId());
			dbApplicantPostAssoc.setPostGraduateDegreeScience(applicantPostAssoc.getPostGraduateDegreeScience());
			dbApplicantPostAssoc.setPostGraduateMarks(applicantPostAssoc.getPostGraduateMarks());
			dbApplicantPostAssoc.setPostGraduateDegreeName(applicantPostAssoc.getPostGraduateDegreeName());
			dbApplicantPostAssoc.setPostGradDegreeInstituteName(applicantPostAssoc.getPostGradDegreeInstituteName());
			//dbApplicantPostAssoc.setDegreeName(applicantPostAssoc.getDegreeName());
			//dbApplicantPostAssoc.setInstituteName(applicantPostAssoc.getInstituteName());
			//dbApplicantPostAssoc.setRequiredQualificationMarks(applicantPostAssoc.getRequiredQualificationMarks());
		    dbApplicantPostAssoc.setManagementExperience(applicantPostAssoc.getManagementExperience());
		    dbApplicantPostAssoc.setIsLargeOfficeAndLargeStaffMembers(applicantPostAssoc.getIsLargeOfficeAndLargeStaffMembers());
		    dbApplicantPostAssoc.setKnowledgeBoardMeetingsActs(applicantPostAssoc.getKnowledgeBoardMeetingsActs());
		    dbApplicantPostAssoc.setIsSecondClassInMBA(applicantPostAssoc.getIsSecondClassInMBA());
		    dbApplicantPostAssoc.setMbaDegreeName(applicantPostAssoc.getMbaDegreeName());
		    dbApplicantPostAssoc.setMbaUniversity(applicantPostAssoc.getMbaUniversity());
		    dbApplicantPostAssoc.setMbaMarks(applicantPostAssoc.getMbaMarks());
		    dbApplicantPostAssoc.setIsIcwaDiploma(applicantPostAssoc.getIsIcwaDiploma());
		    dbApplicantPostAssoc.setIcwaDiplomaName(applicantPostAssoc.getIcwaDiplomaName());
		    dbApplicantPostAssoc.setIcwaUniversityName(applicantPostAssoc.getIcwaUniversityName());
		    dbApplicantPostAssoc.setIcwaMarks(applicantPostAssoc.getIcwaMarks());
		    dbApplicantPostAssoc.setIsFirstClassDegree(applicantPostAssoc.getIsFirstClassDegree());
		    dbApplicantPostAssoc.setOrganisationTimeFrom(applicantPostAssoc.getOrganisationTimeFrom());
		    dbApplicantPostAssoc.setOrganisationTimeTo(applicantPostAssoc.getOrganisationTimeTo());
		    dbApplicantPostAssoc.setCompanyAddress(applicantPostAssoc.getCompanyAddress());
		dbApplicantPostAssoc.setAdvtNo(applicantPostAssoc.getAdvtNo());

	}

	@Override
	public Applicant findApplicantByEmailAddress(String emailAddress) {
		log.debug("Finding applicant entry with the applicant email: {}",
				emailAddress);
		Applicant existingApplicant = applicantRepository
				.findByEmailAddress(emailAddress);
		return existingApplicant;

	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = { "java.lang.Exception" })
	public void sendPasswordResetLinkToApplicant(Applicant applicant,
			String resetLink, String token) {
		ChangePasswordRequest changePasswordRequest = new ChangePasswordRequest();
		changePasswordRequest.setCreatedDate(LocalDate.now());
		changePasswordRequest.setEmailAddress(applicant.getEmailAddress());
		changePasswordRequest.setToken(token);
		changePasswordRequest.setUserType(UserRole.APPLICANT.getId());
		changePasswordRequestService
				.saveChangePasswordRequest(changePasswordRequest);
		sendEmailService.sendPasswordResetEmail(applicant, resetLink);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = { "java.lang.Exception" })
	public void saveApplicationPostPriority(
			Map<Long, Integer> appPostPriorityMap) {
		List<Long> applicantPostIdList = new ArrayList<Long>(
				appPostPriorityMap.keySet());
		List<ApplicantPostAssoc> appPostAssocList = (List<ApplicantPostAssoc>) applicantPostAssocRepository
				.findAll(applicantPostIdList);
		for (ApplicantPostAssoc applicantPost : appPostAssocList) {
			applicantPost.setPriority(appPostPriorityMap.get(applicantPost
					.getId()));
			applicantPost.setLastModifiedDate(LocalDateTime.now());
		}
		applicantPostAssocRepository.save(appPostAssocList);
	}

	@Override
	public List<PostSuperCategory> findAllPostSuperCategory() {
		log.debug("Finding all PostSuperCategory entries");
		return (List<PostSuperCategory>) postSuperCategoryRepository.findAll();
	}

	@Override
	public ApplicantOTP findApplicantOTPByApplicantId(Long applicantId) {
		log.debug("Finding applicant OTP entry by applicant id ", applicantId);
		return applicantOTPRepository.findByApplicantId(applicantId);
	}

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = { "java.lang.Exception" })
	@Override
	public void updateApplicantOTP(Long applicantId, String otp) {
		log.debug("Updating applicant OTP entry by applicant id ", applicantId);
		applicantOTPRepository.updateApplicantOTP(applicantId, otp);
	}

	@Override
	public Page<ApplicantPostAssoc> searchApplicantPostAssocs(
			ApplicantPostAssocSearchDTO applicantPostAssocSearchDTO,
			Pageable pageable) {
		List<Caste> casteList = (List<Caste>) casteRepository.findAll();
		Map<Long, Caste> casteIdMap = new HashMap<Long, Caste>();
		for (Caste caste : casteList) {
			casteIdMap.put(caste.getId(), caste);
		}
		Page<ApplicantPostAssoc> page = applicantPostAssocRepository
				.searchApplicantPostAssocs(applicantPostAssocSearchDTO,
						pageable);
		List<ApplicantPostAssoc> applicantPostAssocs = page.getContent();
		for (ApplicantPostAssoc apa : applicantPostAssocs) {
			Applicant applicant = applicantRepository.findOne(apa
					.getApplicantId());
			apa.setApplicant(applicant);
			apa.setFirstName(applicant.getFirstName());
			apa.setEmailAddress(applicant.getEmailAddress());
			apa.setPost(postRepository.findOne(apa.getPostId()));
			if (apa.getDivisionId() != null) {
				Division division = findDivisionById(apa.getDivisionId());
				apa.setDivision(division);
			}
		}
		return page;
	}

	@Override
	public Long totalApplicantPostAssocs() {
		return applicantPostAssocRepository.count();
	}

	@Override
	public List<Object[]> findAllApplicantPostAssoc(
			ApplicantPostAssocSearchDTO applicantPostAssocSearchDTO) {
		log.debug("Finding all ApplicantPostAssoc entries");
		return applicantPostAssocRepository
				.findAllApplicantPostAssoc(applicantPostAssocSearchDTO);
	}

	@Override
	public SubmissionErrorsDTO checkErrorsInApplicationSubmission(
			Applicant applicant) {
		SubmissionErrorsDTO submissionErrorsDTO = new SubmissionErrorsDTO();

		Applicant dbApplicant = applicantRepository.findOne(applicant.getId());

		boolean submissionValid = true;
		boolean prioritySet = true;

		if (dbApplicant.getStatus() == StatusEnum.DRAFT.getId()) {
			submissionErrorsDTO.setPersonalInformationValid(false);
			submissionValid = false;
		}

		if (dbApplicant.getReadWriteSpeakMarathi() != null
				&& !dbApplicant.getReadWriteSpeakMarathi()) {
			submissionErrorsDTO.setReadWriteSpeakMarathi(false);
			;
			submissionValid = false;
		}

		ApplicantOtherInformation applicantOtherInformation = applicantOtherInformationRepository
				.findApplicantOtherInformationByApplicant(applicant);
		if (applicantOtherInformation != null) {
			if (applicantOtherInformation.getStatus() == StatusEnum.DRAFT
					.getId()) {
				submissionErrorsDTO.setOtherInformationValid(false);
				submissionValid = false;
			}else if(applicantOtherInformation.getDeafAndMute() == null||applicantOtherInformation.getStEmployee() == null
					|| applicantOtherInformation.getLocomotorOrCerebralPalsy() == null ||
					applicantOtherInformation.getSportsPerson()==null || applicantOtherInformation.getOrphanedPerson()==null){
				submissionErrorsDTO.setOtherInformationFieldValid(false);
				
			}
		} else {
			submissionErrorsDTO.setOtherInformationValid(false);
			submissionValid = false;
		}

		ApplicantFiles applicantFiles = applicantFilesRepository
				.findByApplicantId(applicant.getId());
		if (applicantFiles != null) {
			if (StringUtils.isEmpty(applicantFiles.getPhotoFileName())) {
				submissionErrorsDTO.setPhotoValid(false);
				submissionValid = false;
			}

			if (StringUtils.isEmpty(applicantFiles.getSignatureFileName())) {
				submissionErrorsDTO.setSignatureValid(false);
				submissionValid = false;
			}
		} else {
			submissionErrorsDTO.setPhotoValid(false);
			submissionErrorsDTO.setSignatureValid(false);
			submissionValid = false;
		}

		List<PostSubmissionErrorsDTO> myPostSubmissionErrorsDTOList = submissionErrorsDTO
				.getPostSubmissionErrorsDTOList();
		List<ApplicantPostAssoc> applicantPostAssocs = applicantPostAssocRepository
				.findByApplicantId(applicant.getId());
		int noOfSelectedTechNicalPosts = 0;
		int noOfSelectedNonTechNicalPosts = 0;
		for (ApplicantPostAssoc apa : applicantPostAssocs) {
			apa.setPost(postRepository.findOne(apa.getPostId()));
			if (apa.getPost().getPostCategory().getId() == PostCategoryEnum.Technical
					.getPostCategoryId()) {
				noOfSelectedTechNicalPosts = (noOfSelectedTechNicalPosts + 1);
			} else if (apa.getPost().getPostCategory().getId() == PostCategoryEnum.NonTechnical
					.getPostCategoryId()) {
				noOfSelectedNonTechNicalPosts = (noOfSelectedNonTechNicalPosts + 1);
			}
		}
		if (applicantPostAssocs != null && applicantPostAssocs.size() > 0) {
			
			Map<Long, Post> allPostsMap = getAllPostMap();
			for (ApplicantPostAssoc applicantPostAssoc : applicantPostAssocs) {
				PostSubmissionErrorsDTO postSubmissionErrorsDTO = new PostSubmissionErrorsDTO();
				Post myPost = postSubmissionErrorsDTO.getPost();
				Post dbPost = allPostsMap.get(applicantPostAssoc.getPostId());
				myPost.setPostId(dbPost.getPostId());
				myPost.setMessageKey(dbPost.getMessageKey());
				postSubmissionErrorsDTO.setPost(myPost);

				if (applicantPostAssoc.getStatus() == StatusEnum.DRAFT.getId()) {
					submissionErrorsDTO.getInvalidPostNames().add(
							allPostsMap.get(applicantPostAssoc.getPostId())
									.getMessageKey());
					submissionValid = false;
					submissionErrorsDTO.setPostDetailsValid(false);
					postSubmissionErrorsDTO.setFormValid(false);
				}

				if ((applicantPostAssoc.getPriority() == null || applicantPostAssoc
						.getPriority() == 0)
						&& postRepository
								.findPostSuperCategoryIdByPostId(applicantPostAssoc
										.getPostId()) == SuperCategoryEnum.Supervisor
								.getSuperCategoryId()) {
					if (applicantPostAssoc.getPost().getPostCategory().getId() == PostCategoryEnum.Technical
							.getPostCategoryId()
							&& noOfSelectedTechNicalPosts > 1) {
						postSubmissionErrorsDTO.setPrioritySet(false);
						submissionValid = false;
						prioritySet = false;
					}
					if (applicantPostAssoc.getPost().getPostCategory().getId() == PostCategoryEnum.NonTechnical
							.getPostCategoryId()
							&& noOfSelectedNonTechNicalPosts > 1) {
						postSubmissionErrorsDTO.setPrioritySet(false);
						submissionValid = false;
						prioritySet = false;
					}
					
					
				}
				if(applicantPostAssoc.getPostId() == 21){
					if(applicantPostAssoc.getDivisionId()==null){
						postSubmissionErrorsDTO.setFormValid(false);
						submissionValid = false;
					}
				}
				if(applicantPostAssoc.getPostId() ==21){
				if(dbApplicant.getGender()==1){
					if(applicantPostAssoc.getOwnHeavyDrivingLicenseNumber() == false){
						postSubmissionErrorsDTO.setFormValid(false);
						submissionValid = false;
					}
				}
				}
				if (!postSubmissionErrorsDTO.getFormValid()
						|| !postSubmissionErrorsDTO.getPrioritySet()) {
					postSubmissionErrorsDTO.setPostValid(false);
				}

				myPostSubmissionErrorsDTOList.add(postSubmissionErrorsDTO);
			}
			submissionErrorsDTO
					.setPostSubmissionErrorsDTOList(myPostSubmissionErrorsDTOList);
			
		} else {
			submissionErrorsDTO.setPostsSelected(false);
			submissionValid = false;
		}
		submissionErrorsDTO.setPrioritySet(prioritySet);
		submissionErrorsDTO.setValid(submissionValid);
		
		return submissionErrorsDTO;
	}

	private Map<Long, Post> getAllPostMap() {
		List<Post> allPosts = (List<Post>) postRepository.findAll();
		if (allPosts != null && allPosts.size() > 0) {
			Map<Long, Post> allPostsMap = allPosts.stream().collect(
					Collectors.toMap(Post::getPostId, post -> post));
			return allPostsMap;
		}
		return Collections.EMPTY_MAP;
	}

	@Override
	public ApplicantPostAssoc findApplicantPostAssocByApplicantPostAssocIdWithDetails(
			Long applicantPostAssocId, int detailsLevel) {
		log.debug("finding Applicant Post Assoc By applicantPostAssocId",
				applicantPostAssocId);

		ApplicantPostAssoc applicantPostAssoc = applicantPostAssocRepository
				.findOne(applicantPostAssocId);

		switch (detailsLevel) {
		case 1:
			Long postId = applicantPostAssoc.getPostId();
			Post post = postRepository.findOne(postId);
			applicantPostAssoc.setPost(post);
			Integer divisionId = applicantPostAssoc.getDivisionId();
			if (divisionId != null) {
				Division division = divisionRepository.findOne(divisionId
						.longValue());
				applicantPostAssoc.setDivision(division);
			}
			break;
		default:
			break;
		}

		return applicantPostAssoc;
	}

	@Override
	public List<ApplicantPostAssoc> findApplicantPostAssocsByApplicantIdOrderByPostCategory(
			Long applicantId) {
		log.debug(
				"finding Applicant Post Assoc By applicantId order by postCategory",
				applicantId);
		List<ApplicantPostAssoc> applicantPostAssocList = applicantPostAssocRepository
				.findApplicantPostAssocsByApplicantIdOrderByPostCategory(applicantId);
		for (ApplicantPostAssoc applicantPostAssoc : applicantPostAssocList) {
			Long postId = applicantPostAssoc.getPostId();
			Post post = postRepository.findOne(postId);
			applicantPostAssoc.setPost(post);

			String txnOrderNo = applicantPostAssoc.getTxnOrderNo();
			if (txnOrderNo != null && !txnOrderNo.trim().isEmpty()) {
				applicantPostAssoc.setFormDisableStatus(true);
				/*
				 * PaymentTransaction pt =
				 * paymentTransactionRepository.findPaymentTransactionByOrderNo
				 * (txnOrderNo); if(pt != null) {
				 * //applicantPostAssoc.setTransactionStatus(pt.getStatus());
				 * 
				 * String paymentMode = ""+pt.getPaymentMode();
				 * if(pt.getStatus() == 1 || (paymentMode == null ? false :
				 * paymentMode.equals("2") ? true : false) ) {
				 * //if(pt.getStatus() < 2)
				 * applicantPostAssoc.setFormDisableStatus(true); } else {
				 * applicantPostAssoc.setFormDisableStatus(false); }
				 * 
				 * }
				 */
			} else {
				applicantPostAssoc.setFormDisableStatus(false);
			}
		}
		return applicantPostAssocList;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = { "java.lang.Exception" })
	public void saveApplicantPostAssoc(ApplicantPostAssoc applicantPostAssoc) {
		log.debug("Saving an applicant post assoc entry");
		applicantPostAssocRepository.save(applicantPostAssoc);
	}

	@Override
	public List<ApplicantPostAssoc> findApplicantPostAssocsByApplicantIdAndStatus(
			Long applicantId, Long status) {
		log.debug("finding Applicant Post Assoc By applicantId [", applicantId
				+ "] and satus [" + status + "]");
		List<ApplicantPostAssoc> applicantPostAssocList = applicantPostAssocRepository
				.findApplicantPostAssocsByApplicantIdAndStatus(applicantId,
						status);
		for (ApplicantPostAssoc applicantPostAssoc : applicantPostAssocList) {
			Long postId = applicantPostAssoc.getPostId();
			Integer divisionId = applicantPostAssoc.getDivisionId();
			if (divisionId != null) {
				Division division = divisionRepository.findOne(divisionId
						.longValue());
				applicantPostAssoc.setDivision(division);
			}
			Post post = postRepository.findOne(postId);
			applicantPostAssoc.setPost(post);
		}

		return applicantPostAssocList;
	}

	@Override
	public List<ApplicantPostAssoc> findByTxnOrderNo(String txnOrderNo) {
		log.debug("finding all applicant post assoc entries by txn order no",
				txnOrderNo);
		return applicantPostAssocRepository.findByTxnOrderNo(txnOrderNo);
	}

	@Override
	public Post findPostByPostId(Long postId) {
		log.debug("finding post by post id", postId);
		return postRepository.findOne(postId);
	}

	@Override
	public List<ApplicantPostAssoc> findPostsAppliedForPayment(Long applicantId) {
		log.debug("finding post applied for ", applicantId);
		List<ApplicantPostAssoc> postsAppliedForPayment = applicantPostAssocRepository
				.findPostsAppliedForPayment(applicantId);
		List<ApplicantPostAssoc> notActivePostList = new ArrayList<ApplicantPostAssoc>();
		for (ApplicantPostAssoc applicantPostAssoc : postsAppliedForPayment) {
			Long postId = applicantPostAssoc.getPostId();
			Post post = postRepository.findOne(postId);
			if(!post.getActive()){
				notActivePostList.add(applicantPostAssoc);
			}
			
		}
		
		postsAppliedForPayment.removeAll(notActivePostList);
		
		for (ApplicantPostAssoc applicantPostAssoc : postsAppliedForPayment) {
			Long postId = applicantPostAssoc.getPostId();
			Post post = postRepository.findOne(postId);
			
			applicantPostAssoc.setPost(post);
			String txnOrderNo = applicantPostAssoc.getTxnOrderNo();

			if (txnOrderNo != null && !txnOrderNo.trim().isEmpty()) {
				PaymentTransaction pt = paymentTransactionRepository
						.findPaymentTransactionByOrderNo(txnOrderNo);
				if (pt != null) {
					if (pt.getPaymentMode() == 2 && pt.getStatus() < 1) {
						applicantPostAssoc.setTransactionStatus(1);
						continue;
					}
					applicantPostAssoc.setTransactionStatus(pt.getStatus());
				}

				continue;
			}
			applicantPostAssoc.setTransactionStatus(0);
		}
		
		return postsAppliedForPayment;
	}

	@Override
	public Division findDivisionById(Integer id) {
		log.debug("Finding division entry with the division id: {}", id);
		return divisionRepository.findOne(id.longValue());
	}

	@Override
	public List<City> findAllCities() {
		OrderSpecifier<Integer> sortByCityOrder = QCity.city.cityOrder.asc();
		return (List<City>) cityRepository.findAll(sortByCityOrder);
	}

	@Override
	public Trade findTradeById(Integer id) {
		log.debug("Finding trade entry with the division id: {}", id);
		return tradeRepository.findOne(id.longValue());

	}

	@Override
	public List<PostSuperCategory> findAllPostSuperCategoryBySuperCategoryOrder() {
		log.debug("Finding all PostSuperCategory entries ordered by super category order.");
		OrderSpecifier<Integer> orderBySuperCategoryOrder = QPostSuperCategory.postSuperCategory.superCategoryOrder
				.asc();
		return (List<PostSuperCategory>) postSuperCategoryRepository
				.findAll(orderBySuperCategoryOrder);
	}

	@Override
	public List<District> findAllDistricts() {
		OrderSpecifier<Integer> sortByDistrictOrder = QDistrict.district.districtOrder
				.asc();
		return (List<District>) districtRepository.findAll(sortByDistrictOrder);
	}

	@Override
	public District findDistrictById(Long id) {
		return districtRepository.findOne(id);
	}

	@Override
	public City findCityById(Long id) {
		return cityRepository.findOne(id);
	}

	@Override
	public List<PostDivisionAssoc> findDivisionsByPostId(Long postId) {
		log.debug("Finding PostDivisionAssoc entry with the post id: {}",
				postId);
		List<PostDivisionAssoc> postDivisionAssocs = postDivisionAssocRepository
				.findByPostId(postId);
		for (PostDivisionAssoc pda : postDivisionAssocs) {
			pda.setDivision(divisionRepository.findOne(pda.getDivisionId()));
		}
		return postDivisionAssocs;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = { "java.lang.Exception" })
	public int updateStatusByTxnOrderNo(Long status, String txnOrderNo) {
		return applicantPostAssocRepository.updateStatusByTxnOrderNo(status,
				LocalDate.now(), txnOrderNo);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = { "java.lang.Exception" })
	public int updateStatusByTxnOrderNo(Long status, List<String> txnOrderNos) {
		return applicantPostAssocRepository.updateStatusByTxnOrderNo(status,
				LocalDate.now(), txnOrderNos);
	}

	public synchronized String getRandomNo() {
		int len = 10;

		// int len=10;
		// long tLen = (long) Math.pow(10, len - 1) * 9;
		// long number = (long) (Math.random() * tLen) + (long) Math.pow(10, len
		// - 1) * 1;

		String orderNo = RandomStringUtils.random(10, false, true);
		orderNo = orderNo.charAt(0) == '0' ? orderNo.replaceFirst("0", "8")
				: orderNo;

		if (orderNo.length() == len) {
			// List<ApplicantPostAssoc> aPA = findByTxnOrderNo(orderNo);
			PaymentTransaction pt = paymentTransactionRepository
					.findPaymentTransactionByOrderNo(orderNo);
			if (pt == null) {
				return orderNo;
			} else {
				getRandomNo();
			}
		} else {
			getRandomNo();
		}
		System.gc();
		return orderNo;
	}

	public Integer getPostFees(Applicant applicant) {
		Integer postFees = 0;
		Caste caste = applicant.getCaste();
		Boolean nonCreamyLayer = applicant.getNonCreamyLayer();
		nonCreamyLayer = (nonCreamyLayer != null && nonCreamyLayer == true) ? true
				: false;
		if(applicant.getIsBelongToEws()!=null){
		       if(applicant.getIsBelongToEws()){
		           //caste = findCasteByCasteId((long)CasteEnum.SC.getCasteId());
		            postFees = caste.getPostFees();
		       }else if (caste.getId() == CasteEnum.SC.getCasteId()
		               || caste.getId() == CasteEnum.ST.getCasteId() || nonCreamyLayer) {
		            postFees = caste.getPostFees();
		       } else {
		           caste = findCasteByCasteId((long) CasteEnum.OPEN.getCasteId());
		            postFees = caste.getPostFees();
		       }
		       }else{

		    	   if (caste.getId() == CasteEnum.SC.getCasteId()
							|| caste.getId() == CasteEnum.ST.getCasteId() || nonCreamyLayer) {

						 postFees = caste.getPostFees();
					} else {
						caste = findCasteByCasteId((long) CasteEnum.OPEN.getCasteId());
						 postFees = caste.getPostFees();
					}
		}
		
			
		
		return postFees;
	}

	private Caste findCasteByCasteId(Long casteId) {
		return casteRepository.findOne(casteId);
	}

	@Override
	public List<Post> findAllActivePost() {
		return postRepository.findAllActivePost();
	}

	@Override
	public boolean isOpenCategoryFeesApplicable(Applicant applicant) {
		if (applicant != null && applicant.getCaste() != null) {
			Long casteId = applicant.getCaste().getId();
			boolean nonCreamyLayer=(applicant.getNonCreamyLayer()!=null && applicant.getNonCreamyLayer()==true)?true:false;
			if (casteId != null) {
				if (casteId != CasteEnum.OPEN.getCasteId()
						&& casteId != CasteEnum.SC.getCasteId()
						&& casteId != CasteEnum.ST.getCasteId()) {
					if ( !nonCreamyLayer) {
						return true;
					}
				}
			}
		}

		return false;
	}

	@Override
	public Page<ApplicantPostAssoc> filterApplicantPostAssocsList(
			ApplicantPostAssocSearchDTO applicantPostAssocSearchDTO,
			PageDetail pageDetail) {
		log.debug("Calling Page<ApplicantPostAssoc> filterApplicantPostAssocsList");
		return applicantPostAssocRepository.filterApplicantPostAssocsList(
				applicantPostAssocSearchDTO, pageDetail);
	}

	@Override
	public Integer filterApplicantPostAssocsListSize(
			ApplicantPostAssocSearchDTO applicantPostAssocSearchDTO) {
		log.debug("Calling Page<ApplicantPostAssoc> filterApplicantPostAssocsListSize");
		return applicantPostAssocRepository
				.filterApplicantPostAssocsListSize(applicantPostAssocSearchDTO);
	}

	@Override
	public int getCountofUnreadQueryReplies(Long userId) {
		return applicantQueryReplyRepository
				.getCountofUnreadQueryReplies(userId);
	}

	@Override
	public List<Integer> filterApplicantIdList(
			ApplicantPostAssocSearchDTO applicantPostAssocSearchDTO) {
		log.debug("Calling List<Applicant> filterApplicantIdList");
		return applicantPostAssocRepository
				.filterApplicantIdList(applicantPostAssocSearchDTO);
	}

	@Override
	public List<Trade> findAllActiveTrades() {
		log.debug("Finding all active Trade entries ordered by trade order.");
		return tradeRepository.findAll();
	}

	@Override
	public boolean isPaymentDoneOrChallanGeneratedByApplicant(Long applicantId) {
		Boolean isPaymentDoneForAtLeastOnePost = false;
		List<PaymentTransaction> ptList = paymentTransactionRepository
				.findPaymentTransactionByapplicantId(applicantId);
		if (!ptList.isEmpty()) {
			for (PaymentTransaction pt : ptList) {
				if (pt.getPaymentMode() == PaymentModeEnum.ONLINE.getId()
						&& pt.getStatus() == PaymentTransactionStatusEnum.SUCCESS
								.getId()) {
					String orderNumber = pt.getOrderNo();
					List<ApplicantPostAssoc> listOfApplicantPostAssoc = applicantService.findApplicantPostAssocbyTxnOrderNo(orderNumber);
					/*if(applicantPostAssoc.getPostId()!=PostEnum.DRIVERCUMCONDUCTOR_JR.getPostId()){*/
					for (ApplicantPostAssoc applicantPostAssoc : listOfApplicantPostAssoc) {
						if(applicantPostAssoc.getPostId()!=PostEnum.DRIVERCUMCONDUCTOR_JR.getPostId()){
							isPaymentDoneForAtLeastOnePost = true;
							return isPaymentDoneForAtLeastOnePost;
						}
					}
					//isPaymentDoneForAtLeastOnePost = true;
					/*}*/
					//return isPaymentDoneForAtLeastOnePost;
					
				} else if (pt.getPaymentMode() == PaymentModeEnum.OFFLINE
						.getId()) {
					isPaymentDoneForAtLeastOnePost = true;
					return isPaymentDoneForAtLeastOnePost;
				}
			}
		}
		return isPaymentDoneForAtLeastOnePost;
	}
	
	public boolean isOneMonthCompletedPaymentDoneOrChallanGeneratedByApplicant(Applicant applicant){
		boolean isOneMonthCompletedPaymentDoneOrChallanGenerated = false;
		
		/*if(applicant.getCaste().getId() == CasteEnum.SEBC.getCasteId() ||applicant.getCaste().getId() == CasteEnum.EWS.getCasteId()){*/
		List<ApplicantPostAssoc> listOfApplicantPostAssoc = applicantService.findApplicantPostAssocsByApplicant(applicant);
		List<PaymentTransaction> listOfPaymenttransaction = paymentTransactionService.findAllPaymentsDoneByApplicant(applicant.getId());
		
		for (ApplicantPostAssoc applicantPostAssoc : listOfApplicantPostAssoc) {
			if(applicantPostAssoc.getStatus() == 2 && applicantPostAssoc.getPostId()!=PostEnum.DRIVERCUMCONDUCTOR_JR.getPostId()){
				PaymentTransaction pt = paymentTransactionService.findPaymentTransactionByOrderNo(applicantPostAssoc.getTxnOrderNo());
				
				//LocalDateTime lDT = applicantPostAssoc.getLastModifiedDate();
				LocalDateTime lDT = pt.getLastModifiedDate();
			    LocalDateTime rightNow = LocalDateTime.now();
			    
			    Long days = ChronoUnit.DAYS.between(lDT,rightNow );
			    
			    if(days>30){
			    	 isOneMonthCompletedPaymentDoneOrChallanGenerated = true;
			    	 return isOneMonthCompletedPaymentDoneOrChallanGenerated;
			    }
				
			}
			
		}
		
		/*}*/
		return isOneMonthCompletedPaymentDoneOrChallanGenerated;
		
	}

	@Override
	public boolean isLastDateOfApplicationOver() {
		Boolean isLastDateOfApplicationOver = false;
		String lastDateOfApplicationString = systemSettingService
				.getSystemSetting(SystemSettingEnum.LAST_DATE_OF_APPLICATION);
		String dateFormat = CommonUtils.getLocalDateFormat(LocalDate.parse(
				lastDateOfApplicationString,
				DateTimeFormatter.ofPattern("dd/MM/yyyy").withLocale(
						Locale.ENGLISH)), "dd/MM/yyyy");
		LocalDate lastDateOfApplication = LocalDate.parse(
				dateFormat,
				DateTimeFormatter.ofPattern("dd/MM/yyyy").withLocale(
						Locale.ENGLISH));
		LocalDate currentDate = LocalDate.now();
		if (currentDate.isAfter(lastDateOfApplication)) {
			isLastDateOfApplicationOver = true;
		}
		
		String editWindowStartDate = systemSettingService
				.getSystemSetting(SystemSettingEnum.START_DATE_OF_EDIT_WINDOW);
		
		String startDateFormat = CommonUtils.getLocalDateFormat(LocalDate.parse(
				editWindowStartDate,
				DateTimeFormatter.ofPattern("dd/MM/yyyy").withLocale(
						Locale.ENGLISH)), "dd/MM/yyyy");
		
		LocalDate startDateOfEdit = LocalDate.parse(
				startDateFormat,
				DateTimeFormatter.ofPattern("dd/MM/yyyy").withLocale(
						Locale.ENGLISH));
		
		String editWindowEndDate = systemSettingService
				.getSystemSetting(SystemSettingEnum.END_DATE_OF_EDIT_WINDOW);
		
		String endDateFormat = CommonUtils.getLocalDateFormat(LocalDate.parse(
				editWindowEndDate,
				DateTimeFormatter.ofPattern("dd/MM/yyyy").withLocale(
						Locale.ENGLISH)), "dd/MM/yyyy");
		
		LocalDate endDateOfEdit = LocalDate.parse(
				endDateFormat,
				DateTimeFormatter.ofPattern("dd/MM/yyyy").withLocale(
						Locale.ENGLISH));
		
		if((currentDate.isAfter(startDateOfEdit) && currentDate.isBefore(endDateOfEdit)) ||
				(currentDate.isEqual(startDateOfEdit) || currentDate.isEqual(endDateOfEdit))){
			isLastDateOfApplicationOver = false;
		}
		
		
		return isLastDateOfApplicationOver;
	}
	
	@Override
	public boolean isLastDateOfApplicationOverForPost(Long postId) {
		Boolean isLastDateOfApplicationOver = false;
		Post post = applicantService.findPostByPostId(postId);
		
		String lastDateOfApplicationString = post.getPostLastDateOfApplication();
		
		String dateFormat = CommonUtils.getLocalDateFormat(LocalDate.parse(
				lastDateOfApplicationString,
				DateTimeFormatter.ofPattern("dd/MM/yyyy").withLocale(
						Locale.ENGLISH)), "dd/MM/yyyy");
		LocalDate lastDateOfApplication = LocalDate.parse(
				dateFormat,
				DateTimeFormatter.ofPattern("dd/MM/yyyy").withLocale(
						Locale.ENGLISH));
		LocalDate currentDate = LocalDate.now();
		if (currentDate.isAfter(lastDateOfApplication)) {
			isLastDateOfApplicationOver = true;
		}
		return isLastDateOfApplicationOver;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = { "java.lang.Exception" })
	public void markPostAsSubmitted(Long postAssocId, String orderNo) {
		applicantPostAssocRepository.markPostAsSubmitted(
				(long) StatusEnum.SUBMITTED.getId(), LocalDate.now(), orderNo,
				postAssocId);
	}

	@Override
	public Long findSubmittedApplicantPostAssocCountByOrderNo(Long status,
			String orderNo) {
		return applicantPostAssocRepository.countByStatusAndTxnOrderNo(status,
				orderNo);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = { "java.lang.Exception" })
	public void updateApplicantPostAssocTransactionOrderNo(String oldOrderNo,
			String newOrderNo) {
		log.debug(
				"updating Applicant post assoc transaction order no for order nos",
				oldOrderNo);
		applicantPostAssocRepository
				.updateApplicantPostAssocTransactionOrderNo(oldOrderNo,
						newOrderNo);
	}

	@Override
	public ApplicantRestResponse getExamDataFromExamBench(
			Integer applicantPostAssocId, String lngCode, Integer postId) {

		ApplicantRestResponse applicantRestResponse = null;
		String systemDriveId = systemSettingService
				.getSystemSetting(SystemSettingEnum.DRIVE_ID);
		String examBenchBaseUrl = systemSettingService
				.getSystemSetting(SystemSettingEnum.EXAMBENCHBASEURL);
		String examBenchAccessToken = systemSettingService
				.getSystemSetting(SystemSettingEnum.EXAMBENCHACCESSTOKEN);
		List<Object[]> userExamRequestData = applicantRepository
				.userExamRequestData(applicantPostAssocId,
						Integer.parseInt(systemDriveId), postId);
		if (userExamRequestData != null && userExamRequestData.size() > 0) {
			Applicant applicant = new Applicant();
			for (Object[] objects : userExamRequestData) {
				applicant.setGroupName(objects[0] != null ? objects[0]
						.toString() : "");
				applicant.setEmailAddress(objects[1] != null ? objects[1]
						.toString() : "");
				applicant.setApplicationId(objects[2] != null ? objects[2]
						.toString() : "");
			}
			applicantRestResponse = applicantRestApi.getExamDataFromExamBench(
					applicant, examBenchBaseUrl, examBenchAccessToken, lngCode);
		}
		return applicantRestResponse;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = { "java.lang.Exception" })
	public void generateApplicationFormsPDF(String name,
			List<String> applicationIDs, Long postId, String logoPath,
			String fontFilePath, String itextLicenseFilePath,
			PageDetail pageDetail, Long userId) {

		if (applicationIDs != null && applicationIDs.size() > 0) {

			ExecutorService fixedPool = Executors.newFixedThreadPool(1);

			String resourceBasePath = applicationProperties.getResources()
					.getBasePath();

			Map<Long, Caste> casteMap = ((List<Caste>) casteRepository
					.findAll()).stream().collect(
					Collectors.toMap(Caste::getId, c -> c));
			Map<Long, City> cityMap = ((List<City>) cityRepository.findAll())
					.stream().collect(Collectors.toMap(City::getId, c -> c));

			List<UndertakingDTO> applicationList = applicantRepository
					.findApplicationDetailsByPostId(applicationIDs, postId,
							pageDetail);

			if (applicationList != null && applicationList.size() > 0) {
				processList(name, applicationList, logoPath, fontFilePath,
						itextLicenseFilePath, resourceBasePath, casteMap,
						postId, cityMap, userId);
			}

			/*
			 * Runnable aRunnable = new Runnable(){
			 * 
			 * @Override public void run() {
			 * 
			 * } };
			 * 
			 * Future<?> runnableFuture = fixedPool.submit(aRunnable);
			 * fixedPool.shutdown();
			 */

		}

	}

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = { "java.lang.Exception" })
	private void processList(String name, List<UndertakingDTO> applicationList,
			String logoPath, String fontFilePath, String itextLicenseFilePath,
			String resourceBasePath, Map<Long, Caste> casteMap, Long postId,
			Map<Long, City> cityMap, Long userId) {
		int noOfThreads = 1;
		int noOfApplications = applicationList.size();

		if (noOfApplications < 4) {
			noOfThreads = 1;
		}

		ExecutorService exec = Executors.newFixedThreadPool(noOfThreads);

		int minItemsPerThread = noOfApplications / noOfThreads;
		int start = 0;

		List<Future<?>> futures = new ArrayList<>(noOfApplications);

		String normalizedName = name.replaceAll("[\\s\\p{Z}]+", "_").trim();
		String location = normalizedName + "_" + UUID.randomUUID();

		for (int i = 0; i < noOfThreads; i++) {
			int end = start + minItemsPerThread;
			if (!applicationList.subList(start, end).isEmpty()) {
				Runnable r = new Processor(location, applicationList, logoPath,
						fontFilePath, itextLicenseFilePath, resourceBasePath,
						casteMap, postId, cityMap);
				futures.add(exec.submit(r));
			}
			start = end;
		}

		ApplicantForm applicantForm = new ApplicantForm();

		applicantForm.setName(name);
		applicantForm.setPostId(postId);
		applicantForm.setLocation(location);
		applicantForm.setCreatedBy(userId);
		applicantForm.setCreatedDate(LocalDateTime.now());

		applicantFormRepository.save(applicantForm);

		for (Future<?> f : futures) {
			try {
				f.get();
			} catch (InterruptedException e) {
				e.printStackTrace();
			} catch (ExecutionException e) {
				e.printStackTrace();
			}
		}

		exec.shutdown();
	}

	class Processor implements Runnable {

		private List<UndertakingDTO> applicationList;
		private String logoPath;
		private String fontFilePath;
		private String itextLicenseFilePath;
		private String resourceBasePath;
		private Map<Long, Caste> casteMap;
		private Long postId;
		Map<Long, City> cityMap;
		private String name;

		Processor(String name, List<UndertakingDTO> applicationList,
				String logoPath, String fontFilePath,
				String itextLicenseFilePath, String resourceBasePath,
				Map<Long, Caste> casteMap, Long postId, Map<Long, City> cityMap) {
			this.name = name;
			this.applicationList = applicationList;
			this.logoPath = logoPath;
			this.fontFilePath = fontFilePath;
			this.itextLicenseFilePath = itextLicenseFilePath;
			this.resourceBasePath = resourceBasePath;
			this.casteMap = casteMap;
			this.postId = postId;
			this.cityMap = cityMap;
		}

		@Override
		public void run() {
			if (applicationList != null && applicationList.size() > 0) {
				applicationList
						.forEach(dto -> {
							try {
								if (!dto.isConductorBatchLicense()) {
									dto.setConductorBatchLicenseNumber(messageSource
											.getMessage(
													"conductorbatch.no.agree.to.submit.later.note",
													null, new Locale("mr")));
								}

								String districtMessageKey = "";
								if (dto.getDistrictId() != null
										&& dto.getDistrictId() > 0) {
									districtMessageKey = messageSource.getMessage(
											districtRepository.findOne(
													dto.getDistrictId())
													.getMessageKey(), null,
											new Locale("mr"));
								}
								dto.setDistrict(districtMessageKey);
								
								Qualification highestQualification = new Qualification();
								if (dto.getHighestQualification() != null) {
									highestQualification = qualificationService
											.findQualificationById(dto
													.getHighestQualification());
									if (highestQualification != null) {
										dto.setHighestQualificationTitle(highestQualification
												.getTitleInMarathi());
									}
								}
								
								if (dto.getDcDivisionId() !=null && dto.getDcDivisionId() > 0) {
									String divisionMessageKey =divisionRepository.findOne(dto.getDcDivisionId()).getMessageKey();
									if (divisionMessageKey != null
											&& !"".equals(divisionMessageKey)) {
										dto.setDcDivisionName(messageSource.getMessage(divisionMessageKey, null, new Locale("mr")));
									}
								}
								if( dto.getWorkExp() > 0 ){
                                    if( dto.getWorkExp()==1){
                                    dto.setWorkExperience(messageSource.getMessage ("divisionController.workExp.option1",null, new Locale("mr")));
                                    }
                                    if( dto.getWorkExp()==2){
                                    dto.setWorkExperience(messageSource.getMessage ("divisionController.workExp.option2",null, new Locale("mr")));
                                    }
                                    if( dto.getWorkExp()==3){
                                    dto.setWorkExperience(messageSource.getMessage ("divisionController.workExp.option3",null, new Locale("mr")));
                                    }
                                    if( dto.getWorkExp()==4){
                                        dto.setWorkExperience(messageSource.getMessage ("divisionController.workExp.option4",null, new Locale("mr")));
                                        }
                                    }
								
								if(dto.getPostGradDegreeTypeId()!=null && dto.getPostGradDegreeTypeId()>0){
									if(dto.getPostGradDegreeTypeId()==1){
									dto.setPostGradDegreeName(messageSource.getMessage ("postgraddegree.type1",null, new Locale("mr")));
									}
									if(dto.getPostGradDegreeTypeId()==2){
										dto.setPostGradDegreeName(messageSource.getMessage ("postgraddegree.type2",null, new Locale("mr")));
										}
									if(dto.getPostGradDegreeTypeId()==3){
										dto.setPostGradDegreeName(messageSource.getMessage ("postgraddegree.type3",null, new Locale("mr")));
										}
								}
								/*String highestQualification="";
								if (dto.getHighestQualification() !=null) {
									highestQualification = qualificationService.findQualificationById(dto.getHighestQualification()).getTitle();
								}
								dto.setHighestQualificationTitle(highestQualification);*/
								dto.setCaste(messageSource.getMessage(casteMap
										.get(dto.getCasteId()).getMessageKey(),
										null, new Locale("mr")));

								dto.setPostId(postId.intValue());
								String postMessageKey = (postId != null && postId > 0) ? postRepository
										.findOne(postId).getMessageKey() : "";
								dto.setPostAppliedFor(messageSource.getMessage(
										postMessageKey, null, new Locale("mr")));
								// dto.setPriority(1);
								String divisionMessageKey = (dto
										.getDivisionId() != null && dto
										.getDivisionId() > 0) ? divisionRepository
										.findOne(dto.getDivisionId())
										.getMessageKey() : "";
								if (divisionMessageKey != null
										&& !"".equals(divisionMessageKey)) {
									dto.setDivisionName(messageSource
											.getMessage(divisionMessageKey,
													null, new Locale("mr")));
								}
								String tradeMessageKey = (dto.getTradeId() != null && dto
										.getTradeId() > 0) ? tradeRepository
										.findOne(dto.getTradeId())
										.getMessageKey() : "";
								if (tradeMessageKey != null
										&& !"".equals(tradeMessageKey)) {
									dto.setTradeName(messageSource.getMessage(
											tradeMessageKey, null, new Locale(
													"mr")));
								}
								dto.setLogoPath(logoPath);

								dto.setPhotoLocation(resourceBasePath
										+ File.separator
										+ Constants.BASE_UPLOAD_DIR
										+ File.separator
										+ dto.getApplicationID()
										+ File.separator
										+ Constants.APPLICANT_PHOTO_UPLOAD_BASE_DIR
										+ File.separator
										+ dto.getPhotoNameInDB());
								dto.setSignatureLocation(resourceBasePath
										+ File.separator
										+ Constants.BASE_UPLOAD_DIR
										+ File.separator
										+ dto.getApplicationID()
										+ File.separator
										+ Constants.APPLICANT_SIGNATURE_UPLOAD_BASE_DIR
										+ File.separator
										+ dto.getSignatureNameInDB());

								if(dto.getFirstPreferedCityId() !=null && dto.getFirstPreferedCityId() > 0){
									dto.setFirstPreferredCity(messageSource.getMessage(
											cityMap.get(
													dto.getFirstPreferedCityId())
													.getMessageKey(), null,
											new Locale("mr")));}
							if(dto.getSecondPreferedCityId() !=null && dto.getSecondPreferedCityId() >0){
									dto.setSecondPreferredCity(messageSource.getMessage(
											cityMap.get(
													dto.getSecondPreferedCityId())
													.getMessageKey(), null,
											new Locale("mr")));}
									if(dto.getThirdPreferedCityId() !=null && dto.getThirdPreferedCityId() >0){
									dto.setThirdPreferredCity(messageSource.getMessage(
											cityMap.get(
													dto.getThirdPreferedCityId())
													.getMessageKey(), null,
											new Locale("mr")));}
								Qualification otherQualification = null;
								if (dto.getOtherQualification() != null) {
									otherQualification = qualificationService
											.findQualificationById(dto
													.getOtherQualification());
									if (otherQualification != null) {
										dto.setOtherQualificationDetails(otherQualification
												.getTitleInMarathi());
									}
								}

								String pdfLocation = resourceBasePath
										+ File.separator
										+ Constants.BASE_DOWNLOAD_DIR
										+ File.separator
										+ Constants.UNDERTAKING_BASE_DIR
										+ File.separator + dto.getPostId()
										+ File.separator + name;
								String pdfName = dto.getApplicationID() + "_"
										+ dto.getPostId() + ".pdf";

								UndertakingPDFGenerator generator = new UndertakingPDFGenerator(
										fontFilePath, itextLicenseFilePath,
										messageSource,applicantService);
								generator.generate(pdfLocation, pdfName, dto);
								// applicantPostAssocService.updatePdfGeneratedStatus(dto.getApplicantId(),
								// postId);

							} catch (Exception e) {
								log.error(
										"There was an error while trying to generate the PDF form the Application ID {} for the Post ID {}",
										dto.getApplicationID(), postId);
								e.printStackTrace();
							}
						});
			}
		}
	}

	@Override
	public List<ApplicantForm> findAllApplicantFormList() {
		List<ApplicantForm> applicantFormList = (List<ApplicantForm>) applicantFormRepository
				.findAll();

		if (applicantFormList != null && applicantFormList.size() > 0) {
			for (ApplicantForm applicantForm : applicantFormList) {
				applicantForm.setPost(postRepository.findOne(applicantForm
						.getPostId()));
				applicantForm.setUser(userService.findUserById(applicantForm
						.getCreatedBy()));
			}
		}

		return applicantFormList;
	}

	@Override
	public ApplicantForm findApplicantFormByApplicantFormId(Long applicantFormId) {
		return applicantFormRepository.findOne(applicantFormId);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = { "java.lang.Exception" })
	public void savePost(Post post){
		Post dbPost = postRepository.findOne(post.getPostId());

		if(dbPost != null){

			dbPost.setActive(post.getActive());
			dbPost.setShowAdmitCard(post.getShowAdmitCard());
			dbPost.setShowUserResponse(post.getShowUserResponse());

			postRepository.save(dbPost);
		}

	}

	@Override
	public Integer filterApplicantPostPaymentMismatchListSize(String fromDate, String toDate) {
		log.debug("Calling Page<ApplicantPostPaymentMismatch> filterApplicantPostPaymentMismatchListSize");
		return applicantPostAssocRepository.filterApplicantPostPaymentMismatchListSize(fromDate, toDate);
	}

	@Override
	public Page<ApplicantPostPaymentMismatch> filterApplicantPostPaymentMismatchList(String fromDate, String toDate, PageDetail pageDetail) {
		log.debug("Calling Page<ApplicantPostPaymentMismatch> filterApplicantPostPaymentMismatchList");
		return applicantPostAssocRepository.filterApplicantPostPaymentMismatchList(fromDate, toDate, pageDetail);
		
	}

	@Override
	public 	Object[]  getAdmitCardUrl(Long applicantId, Long postId) {
		
		return applicantPostAssocRepository.getAdmitCardUrl(applicantId,postId);
	}

	@Override
	public String getExamCode(Integer postId) {
		
		return applicantPostAssocRepository.getExamCode(postId);
		
	}

	@Override
	public Date getExamDate(Integer applicantId, String examCode) {
		
		return applicantPostAssocRepository.getExamDate(applicantId, examCode);
	}

	@Override
	public String getShiftName(Integer applicantId, String examCode) {
		// TODO Auto-generated method stub
		return applicantPostAssocRepository.getShiftName(applicantId, examCode);
	}

	@Override
	public Integer getApplicantId(Integer applicantPostAssocId, Integer postId) {
		// TODO Auto-generated method stub
		return applicantPostAssocRepository.getApplicantId(applicantPostAssocId, postId);
	}

	@Override
	public String getApplicationId(Integer applicantId) {
		// TODO Auto-generated method stub
		return applicantPostAssocRepository.getApplicationId(applicantId);
	}

	@Override
	public boolean isApplicantApplyForPayment(Long applicantId) {
		Boolean isPaymentDoneForAtLeastOnePost = false;
		List<PaymentTransaction> ptList = paymentTransactionRepository
				.findPaymentTransactionByapplicantId(applicantId);
		if (!ptList.isEmpty()) {
			for (PaymentTransaction pt : ptList) {
				if (pt.getPaymentMode() == PaymentModeEnum.ONLINE.getId()) {
					isPaymentDoneForAtLeastOnePost = true;
					return isPaymentDoneForAtLeastOnePost;
				} else if (pt.getPaymentMode() == PaymentModeEnum.OFFLINE
						.getId()) {
					isPaymentDoneForAtLeastOnePost = true;
					return isPaymentDoneForAtLeastOnePost;
				}
			}
		}
		return isPaymentDoneForAtLeastOnePost;
	}

	@Override
	public List<ApplicantPostAssoc> findApplicantPostAssocbyTxnOrderNo(
			String txnOrderNum) {
		// TODO Auto-generated method stub
		return applicantPostAssocRepository.findApplicantPostAssocByTxnOrderNo(txnOrderNum);
	}

	@Override
	public List<Long> findUniquePostByPostType(ArrayList<Long> postId) {
		
		return postRepository.findUniquePostByPostType(postId);
	}
	
	@Override
	public String findApplicationIdById(Long id) {
		// TODO Auto-generated method stub
		return applicantRepository.findApplicationIdById(id);
	}

	@Override
	public boolean disableFormAfterLastDateOfPayment() {

		Boolean isLastDateOfPayment = false;
		String lastDateOfPaymentString = systemSettingService
				.getSystemSetting(SystemSettingEnum.OFFLINE_LAST_DATE_OF_PAYMENT);
		String dateFormat = CommonUtils.getLocalDateFormat(LocalDate.parse(
				lastDateOfPaymentString,
				DateTimeFormatter.ofPattern("dd/MM/yyyy").withLocale(
						Locale.ENGLISH)), "dd/MM/yyyy");
		LocalDate lastDateOfPayment = LocalDate.parse(
				dateFormat,
				DateTimeFormatter.ofPattern("dd/MM/yyyy").withLocale(
						Locale.ENGLISH));
		LocalDate currentDate = LocalDate.now();
		if (currentDate.isAfter(lastDateOfPayment)) {
			isLastDateOfPayment = true;
		}
		return isLastDateOfPayment;
	}

	/*@Override
	public String generatePreferedCityReport(String dateString) throws IOException {
		// TODO Auto-generated method stub
		List<Object[]>PrefferedCityData = getPrefferedCityData();
		
		String reportLocation = applicationProperties.getResources().getBasePath()+ 
				File.separator + Constants.BASE_DOWNLOAD_DIR + File.separator + Constants.ONLINE_QUERY_API_BASE_DIR;
				File dir = new File(reportLocation);
			    if (!dir.exists()) {
			            dir.mkdirs();
			       }
			    String reportName = dateString+"preferedCityData.xlsx";
			    String reportNameWithPath = reportLocation+ File.separator + reportName;
			    XSSFWorkbook prefferedCityDataExcel = ExcelWriterUtils.createWorkbook();
			    
			    Sheet sheet = ExcelWriterUtils.createSheet(prefferedCityDataExcel, "prefferedCityData");
				Row row0 = ExcelWriterUtils.createRow(sheet, 0);
				Cell row0cell0 = ExcelWriterUtils.createCell(row0, 0, "Application_Id", ExcelWriterUtils.getBoldCellStyleLeftAligned(prefferedCityDataExcel));
				Cell row0cell1 = ExcelWriterUtils.createCell(row0, 1, "First_Name", ExcelWriterUtils.getBoldCellStyleLeftAligned(prefferedCityDataExcel));
				Cell row0cell2 = ExcelWriterUtils.createCell(row0, 2, "Middel_Name", ExcelWriterUtils.getBoldCellStyleLeftAligned(prefferedCityDataExcel));
				Cell row0cell3 = ExcelWriterUtils.createCell(row0, 2, "Last_Name", ExcelWriterUtils.getBoldCellStyleLeftAligned(prefferedCityDataExcel));
				Cell row0cell4 = ExcelWriterUtils.createCell(row0, 3, "Email_Address", ExcelWriterUtils.getBoldCellStyleLeftAligned(prefferedCityDataExcel));
				Cell row0cell5 = ExcelWriterUtils.createCell(row0, 4, "Mobile_Number", ExcelWriterUtils.getBoldCellStyleLeftAligned(prefferedCityDataExcel));
				Cell row0cell6 = ExcelWriterUtils.createCell(row0, 5, "Post_AppliedFor", ExcelWriterUtils.getBoldCellStyleLeftAligned(prefferedCityDataExcel));
				Cell row0cell7 = ExcelWriterUtils.createCell(row0, 6, "First_PreferenceCity", ExcelWriterUtils.getBoldCellStyleLeftAligned(prefferedCityDataExcel));
				Cell row0cell8 = ExcelWriterUtils.createCell(row0, 7, "Second_PreferenceCity", ExcelWriterUtils.getBoldCellStyleLeftAligned(prefferedCityDataExcel));
				Cell row0cell9 = ExcelWriterUtils.createCell(row0, 8, "Third_PreferenceCity", ExcelWriterUtils.getBoldCellStyleLeftAligned(prefferedCityDataExcel));
			
				int count =1;
				int srNo = 1;
				for (Object[] objects : PrefferedCityData) {
					
					Row row = ExcelWriterUtils.createRow(sheet, count);
					Cell rowcell0 = ExcelWriterUtils.createCell(row, 0, objects[0], ExcelWriterUtils.getBoldCellStyleLeftAligned(prefferedCityDataExcel));
					Cell rowcell1 = ExcelWriterUtils.createCell(row, 1, objects[1], ExcelWriterUtils.getBoldCellStyleLeftAligned(prefferedCityDataExcel));
					Cell rowcell2 = ExcelWriterUtils.createCell(row, 2, objects[2], ExcelWriterUtils.getBoldCellStyleLeftAligned(prefferedCityDataExcel));
					Cell rowcell3 = ExcelWriterUtils.createCell(row0, 3, objects[3], ExcelWriterUtils.getBoldCellStyleLeftAligned(prefferedCityDataExcel));
					Cell rowcell4 = ExcelWriterUtils.createCell(row, 4, objects[4], ExcelWriterUtils.getBoldCellStyleLeftAligned(prefferedCityDataExcel));
					Cell rowcell5 = ExcelWriterUtils.createCell(row, 5, objects[5], ExcelWriterUtils.getBoldCellStyleLeftAligned(prefferedCityDataExcel));
					Cell rowcell6 = ExcelWriterUtils.createCell(row, 6, objects[6], ExcelWriterUtils.getBoldCellStyleLeftAligned(prefferedCityDataExcel));
					Cell rowcell7 = ExcelWriterUtils.createCell(row, 7, objects[7], ExcelWriterUtils.getBoldCellStyleLeftAligned(prefferedCityDataExcel));
					Cell rowcell8 = ExcelWriterUtils.createCell(row, 8, objects[8], ExcelWriterUtils.getBoldCellStyleLeftAligned(prefferedCityDataExcel));
					//Cell rowcell9 = ExcelWriterUtils.createCell(row, 9, objects[9], ExcelWriterUtils.getBoldCellStyleLeftAligned(prefferedCityDataExcel));
				
				
					count++;
					srNo++;
				}
				
				FileOutputStream fileOut = new FileOutputStream(reportNameWithPath);
				prefferedCityDataExcel.write(fileOut);
		        fileOut.close();
		        
				return reportNameWithPath;
		
	}*/

	public String generatePrefferedCityReportCsv(String dateString) throws IOException{
		
		List<Object[]>PrefferedCityData = getPrefferedCityData();
		
		List<String[]> stringPrefferedCityList = new ArrayList<String[]>();
		
		for (Object[] objects : PrefferedCityData) {
			
			String [] prefCit = {(String) objects[0],(String) objects[1],(String) objects[2],(String) objects[3],(String) objects[4],
					(String) objects[5],(String) objects[6],(String) objects[7],(String) objects[9],(String) objects[10],(String) objects[11]};
			stringPrefferedCityList.add(prefCit);
		}
		
			String reportLocation = applicationProperties.getResources().getBasePath()+ 
			File.separator + Constants.BASE_DOWNLOAD_DIR + File.separator + Constants.PREFERRED_CITY_DIR;
			File dir = new File(reportLocation);
			    if (!dir.exists()) {
			            dir.mkdirs();
			       }
			String reportName = dateString+"_preferedCityData.csv";
			String reportNameWithPath = reportLocation+ File.separator + reportName;
			 
			    
			FileWriter outputfile = new FileWriter(reportNameWithPath); 
			CSVWriter writer = new CSVWriter(outputfile);
			String[] header = { "Application_Id", "First_Name", "Middel_Name", "Last_Name","Gender","Email_Address","Mobile_Number"
			    		,"Post_AppliedFor","First_PreferenceCity","Second_PreferenceCity","Third_PreferenceCity" }; 
			writer.writeNext(header);
			
			writer.writeAll(stringPrefferedCityList);
			  
			writer.close();
			return reportNameWithPath;
	
		
	}
	
	@Override
	public List<Object[]> getPrefferedCityData() {
		return applicantRepository.getPrefferedCityData();
	}

	
	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = { "java.lang.Exception" })
	public void updateApplicant(Applicant applicant) {
		
		Applicant dbApplicant = applicantRepository.findOne(applicant
				.getId());
		
		if(applicant.getCertificateNumber() != null){
			dbApplicant.setCertificateNumber(applicant.getCertificateNumber());
		}
		
		if(applicant.getCertificateValidityEndingDate() != null){
			dbApplicant.setCertificateValidityEndingDate(applicant.getCertificateValidityEndingDate());
		}
		
		if(applicant.getEwsCertificateNumber() != null){
			dbApplicant.setEwsCertificateNumber(applicant.getEwsCertificateNumber());
		}
		applicantRepository.save(dbApplicant);
	}
	

	/*@Override
	public Integer getPostFeesAsPerAdvertisementNumber(Applicant applicant) {
		
		Integer postFees = 0;
		Caste caste = applicant.getCaste();
		Boolean nonCreamyLayer = applicant.getNonCreamyLayer();
		nonCreamyLayer = (nonCreamyLayer == null || nonCreamyLayer == true) ? true : false;
		
			if (caste.getId() == CasteEnum.SC.getCasteId()
					|| caste.getId() == CasteEnum.ST.getCasteId() || nonCreamyLayer) {

				 postFees = caste.getPostFees();
			} else {
				caste = findCasteByCasteId((long) CasteEnum.OPEN.getCasteId());
				 postFees = caste.getPostFees();
			}
		
		return postFees;
		
	}*/
	
	@Override
	public Boolean isSelectedEwsOrSebc(Applicant applicant){
		
		boolean isSelectedEwsOrSebcYes = false;
		
		Long casteId = applicant.getCaste().getId();
		
		if(casteId == 10 && applicant.getNonCreamyLayer()){
			isSelectedEwsOrSebcYes = true;
		}else if(casteId == 11 && applicant.getIsBelongToEws()){
			isSelectedEwsOrSebcYes = true;
		}
		
		return isSelectedEwsOrSebcYes;
		
	}
	
}
