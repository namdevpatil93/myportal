package com.msrtc.portal.applicant.web;

import java.awt.Desktop;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.*;
import java.util.stream.Collectors;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.commons.lang.StringUtils;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.core.io.FileSystemResource;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import cn.apiclub.captcha.Captcha;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.msrtc.portal.applicant.domain.Applicant;
import com.msrtc.portal.applicant.domain.ApplicantFiles;
import com.msrtc.portal.applicant.domain.ApplicantOTP;
import com.msrtc.portal.applicant.domain.ApplicantOtherInformation;
import com.msrtc.portal.applicant.domain.ApplicantPostAssoc;
import com.msrtc.portal.applicant.domain.ApplicantRestResponse;
import com.msrtc.portal.applicant.domain.ChangePasswordRequest;
import com.msrtc.portal.applicant.domain.City;
import com.msrtc.portal.applicant.domain.District;
import com.msrtc.portal.applicant.domain.Division;
import com.msrtc.portal.applicant.domain.Post;
import com.msrtc.portal.applicant.domain.PostCategory;
import com.msrtc.portal.applicant.domain.PostCategoryEnum;
import com.msrtc.portal.applicant.domain.PostDivisionAssoc;
import com.msrtc.portal.applicant.domain.PostEnum;
import com.msrtc.portal.applicant.domain.PostSuperCategory;
import com.msrtc.portal.applicant.domain.StatusEnum;
import com.msrtc.portal.applicant.domain.SuperCategoryEnum;
import com.msrtc.portal.applicant.dto.ApplicantSearchDTO;
import com.msrtc.portal.applicant.dto.SubmissionErrorsDTO;
import com.msrtc.portal.applicant.service.AgeValidatorService;
import com.msrtc.portal.applicant.service.ApplicantService;
import com.msrtc.portal.applicant.service.ChangePasswordRequestService;
import com.msrtc.portal.core.common.util.CommonUtils;
import com.msrtc.portal.core.common.util.Constants;
import com.msrtc.portal.core.common.util.PageDetail;
import com.msrtc.portal.core.config.ApplicationProperties;
import com.msrtc.portal.core.systemsetting.service.SystemSettingService;
import com.msrtc.portal.core.systemsetting.util.SystemSettingEnum;
import com.msrtc.portal.core.user.security.PasswordUtils;
import com.msrtc.portal.core.user.security.SecurityUtils;
import com.msrtc.portal.notification.service.NotificationService;
import com.msrtc.portal.payment.domain.PaymentModeEnum;
import com.msrtc.portal.payment.domain.PaymentTransaction;
import com.msrtc.portal.payment.service.PaymentTransactionService;
import com.msrtc.portal.qualification.domain.Qualification;
import com.msrtc.portal.qualification.service.QualificationService;
import com.msrtc.portal.sms.service.SentSMSService;

@Controller
@RequestMapping(value = { ApplicantController.APPLICANT_CONTROLLER_URL })
public class ApplicantController {

	private final Logger log = LoggerFactory.getLogger(getClass());

	static final String APPLICANT_CONTROLLER_URL = "/applicant";

	@Autowired
	private ApplicantService applicantService;

    @Autowired
    private MessageSource messageSource;

    @Autowired
    private ApplicationProperties applicationProperties;
    
    @Autowired
	private ChangePasswordRequestService changePasswordRequestService;

    @Autowired
    private PasswordUtils passwordUtils;

	@Autowired
	private AgeValidatorService ageValidatorService;

    @Autowired
	private SystemSettingService systemSettingService;
    
    @Autowired
    private PaymentTransactionService paymentTransactionService;

    @Autowired
    private SentSMSService sentSMSService;
    
    @Autowired
    private NotificationService notificationService;

    @Autowired
    private QualificationService qualificationService;
    
	@GetMapping(value = "/showRegistrationPage")
	public String showRegistrationPage(Model model) {
		String disableNewRegistration = systemSettingService.getSystemSetting(SystemSettingEnum.DISABLE_NEW_REGISTRATION);

		if(!StringUtils.isBlank(disableNewRegistration) && "1".equals(disableNewRegistration)){
			return "registrationClosedPage";
		} else {
			model.addAttribute("emailExists", Boolean.FALSE);
			return "registrationPage";
		}
	}

	@PostMapping(value="/register")
	public String register(@Validated Applicant applicant, BindingResult bindingResult,  HttpServletRequest request, HttpSession session, Model model){
		Applicant dbApplicant = applicantService.findApplicantByEmailAddress(applicant.getEmailAddress());
		boolean emailExists = false;

		if(bindingResult.hasErrors()){
			model.addAttribute("applicant", applicant);
			model.addAttribute("emailExists", emailExists);
			model.addAttribute("errors", bindingResult.getAllErrors());
			return "registrationPage";
		}

		Captcha captcha = (Captcha) session.getAttribute(Captcha.NAME);
		String answer = request.getParameter("answer");

		if (captcha.isCorrect(answer) && dbApplicant==null) {
			applicantService.saveApplicant(applicant);
			model.addAttribute("firstName", applicant.getFirstName());
			model.addAttribute("lastName", applicant.getLastName());
			model.addAttribute("emailExists",emailExists);
			return "registrationSuccess";
		} else {
			if(dbApplicant!=null){
				emailExists = true;
			}
			model.addAttribute("emailExists",emailExists);
			model.addAttribute("applicant", applicant);
			model.addAttribute("invalidCaptcha", Boolean.TRUE);
			return "registrationPage";
		}
	}

    @RequestMapping(params = "operation=showChangePassword")
    public String showChangePassword(){
        return "applicantChangePassword";
    }

	@RequestMapping(params = "operation=applicantDashboard")
	public String applicantDashboard(Model model,HttpServletRequest request){
		Applicant applicant = SecurityUtils.getCurrentUser().getApplicant();
		Applicant dbApplicant = applicantService.findApplicantById(applicant.getId());
		if(dbApplicant.getFirstLogin()){
            model.addAttribute("isFirstLogin", Boolean.TRUE);
            model.addAttribute("applicant", applicant);
           // model.addAttribute("userNotificationCount", notificationService.countUserNotificationsByApplicantId(applicant.getId()));
			return "applicantChangePassword";
		} else {
			List<ApplicantPostAssoc> applicantPostAssocs = applicantService.findApplicantPostAssocsByApplicant(dbApplicant);
			
			for (ApplicantPostAssoc apa : applicantPostAssocs) {
				PaymentTransaction paymentTransaction = paymentTransactionService.findPaymentTransactionByOrderNo(apa.getTxnOrderNo());
				if (paymentTransaction!=null) {
					String systemDriveId= systemSettingService.getSystemSetting(SystemSettingEnum.DRIVE_ID);
					String admitCardUrl = paymentTransactionService.findAdmitCardURLByPostIdAndApplicantId(apa.getPostId(),applicant.getId(),Integer.parseInt(systemDriveId));
					if (admitCardUrl !=null) {
						apa.setAdmitCardUrl(admitCardUrl);
					}
					apa.setApplicationId(applicant.getApplicationId());
					apa.setPaymentMode(String.valueOf(paymentTransaction.getPaymentMode()));
					apa.setTransactionStatus(paymentTransaction.getStatus());
					
				} else if (isInternalApplicant(apa.getApplicantId())) {
					apa.setAdmitCardUrl("MSRTC0" + apa.getApplicantId() + "_10.pdf" );
					apa.setApplicationId(applicant.getApplicationId());
					apa.setPaymentMode(String.valueOf(1));
					apa.setTransactionStatus(1);
				}
				
			}
			model.addAttribute("isFirstLogin", Boolean.FALSE);
			model.addAttribute("applicantPostAssocs", applicantPostAssocs);
			//model.addAttribute("userNotificationCount", notificationService.countUserNotificationsByApplicantId(applicant.getId()));
			model.addAttribute("totalPostsApplied",applicantPostAssocs.size());
			int count = applicantService.getCountofUnreadQueryReplies(applicant.getId());
			//model.addAttribute("unreadCount", count);

			HttpSession session = request.getSession();
			session.setAttribute("userNotificationCount", notificationService
					.countUserNotificationsByApplicantId(applicant.getId()));
			session.setAttribute("userQueryCount",count);
			return "applicantDashboard";
		}
	}
	
	private Boolean isInternalApplicant(Long applicantId) {
		Boolean flag = Boolean.FALSE;
		
		if (applicantId > 600000 && applicantId < 609045) {
			flag = Boolean.TRUE;
		}
		
		return flag;
	}
	
	@RequestMapping(params = "operation=viewAdmitCardAttachment", produces = MediaType.APPLICATION_PDF_VALUE)
    @ResponseBody
    public FileSystemResource viewAdmitCardAttachment(@RequestParam("admitCardURL") String admitCardURL,@RequestParam("applicationId") String applicationId) {
		String basePath = applicationProperties.getResources().getEpassBasePath();
		String systemDriveId= systemSettingService.getSystemSetting(SystemSettingEnum.DRIVE_ID);
		String attachmentUploadLocation = basePath + File.separator + com.msrtc.portal.core.common.util.Constants.ADMITCARD_PATH+ File.separator +systemDriveId+ File.separator + applicationId+ File.separator +admitCardURL;
		return new FileSystemResource(attachmentUploadLocation);
    }

	@RequestMapping(params = "operation=viewProfile")
	public String viewProfile(Model model){
		String locale = LocaleContextHolder.getLocale().toString();
		Applicant applicant = SecurityUtils.getCurrentUser().getApplicant();
		Applicant dbApplicant = applicantService.findApplicantById(applicant.getId());
	
		//---------- find out applicant age and month of birth ------------------
		int[] ageAndMonthsArr = CommonUtils.getApplicantAgeInYearsAndMonths(dbApplicant.getBirthDate());
		dbApplicant.setApplicantAgeInYears(ageAndMonthsArr[0]);
		dbApplicant.setApplicantAgeInMonths(ageAndMonthsArr[1]);
		dbApplicant.setApplicantAgeInDays(ageAndMonthsArr[2]);
		
		ApplicantOtherInformation applicantOterInformation = applicantService.findApplicantOtherInformationByApplicant(dbApplicant);
		model.addAttribute("applicant", dbApplicant);
		model.addAttribute("applicantOtherinfo", applicantOterInformation);
		//model.addAttribute("districts", applicantService.findAllDistricts());
		if(dbApplicant.getDistrictId() != null && dbApplicant.getDistrictId() > 0 ) {
			model.addAttribute("district", applicantService.findDistrictById(dbApplicant.getDistrictId()));
		}

		if(applicantOterInformation != null && applicantOterInformation.getPreferredCity1()!=null){
			model.addAttribute("city", applicantService.findCityById(applicantOterInformation.getPreferredCity1()));
		}
		if(applicantOterInformation != null && applicantOterInformation.getPreferredCity2()!=null){
			model.addAttribute("citySecond", applicantService.findCityById(applicantOterInformation.getPreferredCity2()));
		}
		if(applicantOterInformation != null && applicantOterInformation.getPreferredCity3()!=null){
			model.addAttribute("citythird", applicantService.findCityById(applicantOterInformation.getPreferredCity3()));
		}
		Qualification qualification = new Qualification();
		if(dbApplicant.getHighestQualification()!=null){
			qualification=qualificationService.findQualificationById(dbApplicant.getHighestQualification());
		}
	       
		String systemReferenceDate = systemSettingService.getSystemSetting(SystemSettingEnum.REFERENCE_DATE);
		String dateFormat = CommonUtils.getLocalDateFormat(LocalDate.parse(systemReferenceDate, DateTimeFormatter.ofPattern("dd/MM/yyyy").withLocale(Locale.ENGLISH)), "dd/MM/yyyy");
		LocalDate referenceDate = LocalDate.parse(dateFormat, DateTimeFormatter.ofPattern("dd/MM/yyyy").withLocale(Locale.ENGLISH));
		int[] ageAsOnGivenDate = CommonUtils.getApplicantAgeAsOnGivenDate(dbApplicant.getBirthDate(), referenceDate);
		model.addAttribute("qualification", qualification);
		model.addAttribute("ageAsOnGivenDate", ageAsOnGivenDate);
		model.addAttribute("locale",locale);
		return "viewProfile";
    }

    @RequestMapping(params = "operation=changePassword")
    public String changePassword(Applicant applicant, @RequestParam(required = false) boolean isMyAccountPage, Model model,
								 final RedirectAttributes redirectAttributes){
        log.debug("Updating password of the applicant entry with the applicant id: {}", applicant.getId());
        Applicant dbApplicant = applicantService.findApplicantById(applicant.getId());
		boolean isPasswordsMatch = passwordUtils.isPasswordsMatch(applicant.getPassword(), dbApplicant.getPassword());

        if (isPasswordsMatch) {
        	applicantService.updatePassword(applicant);
        }

		if(!isPasswordsMatch) {
			redirectAttributes.addFlashAttribute("message", messageSource.getMessage("myAccount.password.oldPassword.mismatch", null, LocaleContextHolder.getLocale()));
		} else {
			redirectAttributes.addFlashAttribute("message", messageSource.getMessage("myAccount.password.updated", null, LocaleContextHolder.getLocale()));
		}

        if(isMyAccountPage){
			return "redirect:/applicant?operation=myAccount";
		} else {
			if(!isPasswordsMatch) {
				model.addAttribute("message", messageSource.getMessage("myAccount.password.oldPassword.mismatch", null, LocaleContextHolder.getLocale()));
				model.addAttribute("isFirstLogin", dbApplicant.getFirstLogin());
				return "applicantChangePassword";
			} else {
				return "redirect:/applicant?operation=applicantDashboard&menu=applicantDashboard";
			}
		}
    }

	@RequestMapping(params = "operation=apply")
	public String apply(Model model, @RequestParam String tabNo, @RequestParam(required = false) String postId){
		String locale = LocaleContextHolder.getLocale().toString();
		Applicant applicant = SecurityUtils.getCurrentUser().getApplicant();
		Applicant dbApplicant = applicantService.findApplicantById(applicant.getId());
		 List<Qualification> activeHighestQualificationList = qualificationService.findAllActiveQualificationByPriority();
		List<ApplicantPostAssoc> applicantPostAssocList = applicantService.findApplicantPostAssocsByApplicant(dbApplicant);
		boolean isAppliedForDriverCumConductor= false;
		for (ApplicantPostAssoc applicantPostAssoc : applicantPostAssocList) {
			if(applicantPostAssoc.getPostId()==PostEnum.DRIVERCUMCONDUCTOR_JR.getPostId()){
				isAppliedForDriverCumConductor=true;
			}
		}
		model.addAttribute("isAppliedForDriverCumConductor", isAppliedForDriverCumConductor);
		boolean dobDisabledFlag=false;
		for (ApplicantPostAssoc applicantPostAssoc : applicantPostAssocList) {
			String txnNo = applicantPostAssoc.getTxnOrderNo();
			if(txnNo != null && !txnNo.trim().isEmpty())
			{
				dobDisabledFlag=true;
				break;
			}
		}
				
		//---------- find out applicant age and month of birth ------------------
        if(dbApplicant.getBirthDate() != null){
	  		int[] ageAndMonthsArr = CommonUtils.getApplicantAgeInYearsAndMonths(dbApplicant.getBirthDate());
	  		dbApplicant.setApplicantAgeInYears(ageAndMonthsArr[0]);
	  		dbApplicant.setApplicantAgeInMonths(ageAndMonthsArr[1]);
			dbApplicant.setApplicantAgeInDays(ageAndMonthsArr[2]);

			String systemReferenceDate = systemSettingService.getSystemSetting(SystemSettingEnum.REFERENCE_DATE);
			String dateFormat = CommonUtils.getLocalDateFormat(LocalDate.parse(systemReferenceDate, DateTimeFormatter.ofPattern("dd/MM/yyyy").withLocale(Locale.ENGLISH)), "dd/MM/yyyy");
			LocalDate referenceDate = LocalDate.parse(dateFormat, DateTimeFormatter.ofPattern("dd/MM/yyyy").withLocale(Locale.ENGLISH));
			int[] ageAsOnGivenDate = CommonUtils.getApplicantAgeAsOnGivenDate(dbApplicant.getBirthDate(), referenceDate);
			boolean disableFormAfterLastDateOver = applicantService.isLastDateOfApplicationOver();
			model.addAttribute("disableFormAfterLastDateOver", disableFormAfterLastDateOver);
			model.addAttribute("ageAsOnGivenDate", ageAsOnGivenDate);

		}
		model.addAttribute("applicant", dbApplicant);
        model.addAttribute("castes", applicantService.findAllCastes());
        if(dbApplicant.getCaste() != null){
        model.addAttribute("casteId", dbApplicant.getCaste().getId());
        model.addAttribute("isSelectedEwsOrSebcYes", applicantService.isSelectedEwsOrSebc(dbApplicant));
        }
        
        model.addAttribute("tabNo", tabNo);
        model.addAttribute("districts", applicantService.findAllDistricts());
		model.addAttribute("postId", postId);
		model.addAttribute("dobDisabledFlag", dobDisabledFlag);
		model.addAttribute("isOneMonthCompletedOnPaymentDone", applicantService.isOneMonthCompletedPaymentDoneOrChallanGeneratedByApplicant(dbApplicant));
		model.addAttribute("disablePersonalInformationFormFieldsOnPayment", applicantService.isPaymentDoneOrChallanGeneratedByApplicant(applicant.getId()));
		model.addAttribute("isApplicantApplyForPayment", applicantService.isApplicantApplyForPayment(applicant.getId()));
        String disableSaveAsDraft = systemSettingService.getSystemSetting(SystemSettingEnum.DISABLE_SAVE_AS_DRAFT);
        model.addAttribute("disableSaveAsDraft", disableSaveAsDraft);

        String disablePostSelection = systemSettingService.getSystemSetting(SystemSettingEnum.DISABLE_POST_SELECTION);
        model.addAttribute("disablePostSelection", disablePostSelection );

        String disablePayments = systemSettingService.getSystemSetting(SystemSettingEnum.DISABLE_PAYMENTS);
        model.addAttribute("disablePayments", disablePayments );
        model.addAttribute("highestQualificationList", activeHighestQualificationList);
        model.addAttribute("locale",locale);
        model.addAttribute("emailExists", Boolean.FALSE);
        return "apply";
	}

    @RequestMapping(params = "operation=showPersonalInformation")
    public String showPersonalInformation(Model model){
        Applicant applicant = SecurityUtils.getCurrentUser().getApplicant();
        Applicant dbApplicant = applicantService.findApplicantById(applicant.getId());
       
      //---------- find out applicant age and month of birth ------------------
        if(dbApplicant.getBirthDate() != null){
	  		int[] ageAndMonthsArr = CommonUtils.getApplicantAgeInYearsAndMonths(dbApplicant.getBirthDate());
	  		dbApplicant.setApplicantAgeInYears(ageAndMonthsArr[0]);
	  		dbApplicant.setApplicantAgeInMonths(ageAndMonthsArr[1]);
			dbApplicant.setApplicantAgeInDays(ageAndMonthsArr[2]);

			String systemReferenceDate = systemSettingService.getSystemSetting(SystemSettingEnum.REFERENCE_DATE);
			String dateFormat = CommonUtils.getLocalDateFormat(LocalDate.parse(systemReferenceDate, DateTimeFormatter.ofPattern("dd/MM/yyyy").withLocale(Locale.ENGLISH)), "dd/MM/yyyy");
			LocalDate referenceDate = LocalDate.parse(dateFormat, DateTimeFormatter.ofPattern("dd/MM/yyyy").withLocale(Locale.ENGLISH));
			int[] ageAsOnGivenDate = CommonUtils.getApplicantAgeAsOnGivenDate(dbApplicant.getBirthDate(), referenceDate);
			//boolean disableFormAfterLastDateOver = applicantService.isLastDateOfApplicationOver();
			//model.addAttribute("disableFormAfterLastDateOver", disableFormAfterLastDateOver);
			model.addAttribute("ageAsOnGivenDate", ageAsOnGivenDate);
		}
        
         //model.addAttribute("disablePersonalInformationFormFieldsOnPayment", applicantService.isPaymentDoneOrChallanGeneratedByApplicant(applicant.getId()));
        model.addAttribute("applicant", dbApplicant);
        model.addAttribute("castes", applicantService.findAllCastes());
        model.addAttribute("districts", applicantService.findAllDistricts());
        String disableSaveAsDraft = systemSettingService.getSystemSetting(SystemSettingEnum.DISABLE_SAVE_AS_DRAFT);
        model.addAttribute("disableSaveAsDraft", disableSaveAsDraft);
       
        return "personalInformation";
    }

    @RequestMapping(params = "operation=savePersonalInformation")
	public @ResponseBody Map savePersonalInformation(Applicant applicant, @RequestParam("deletedPostIds") String postIds ) {
    	Applicant dbApplicant = applicantService.findApplicantByEmailAddress(applicant.getEmailAddress());
    	Applicant dbApplicantById=applicantService.findApplicantById(applicant.getId());
		boolean emailExists = false;
		log.debug("Saving applicant's Personal Information");
		Map<String, Object> result = new HashMap<>();
		boolean success = true;
		try {
			String[] deletedPostIds = postIds.split(",");
			for (String string : deletedPostIds) {
				applicantService.deleteApplicantPost(applicant, Long.parseLong(string !=null && !string.trim().isEmpty() ? string : "0"));
			}
			if (dbApplicant==dbApplicantById ||dbApplicant==null ) {
				if(applicantService.isLastDateOfApplicationOver() && 
						!applicantService.isOneMonthCompletedPaymentDoneOrChallanGeneratedByApplicant(dbApplicantById))
						{
					applicantService.updateApplicant(applicant);
				}else{
			applicantService.saveApplicant(applicant);
				}
			}
			else{
				emailExists = true;
			}
		} catch(Exception e){
			log.error(e.getMessage());
			success = false;
		}
		result.put("success", success);
		result.put("emailExists",emailExists);
		return result;
	}

	@RequestMapping(params = "operation=showOtherInformation")
	public String showOtherInformation(Model model){
		ApplicantOtherInformation applicantOtherInformation = applicantService.findApplicantOtherInformationByApplicant(SecurityUtils.getCurrentUser().getApplicant());
		List<City> cityList = applicantService.findAllCities();
		boolean disableFormAfterLastDateOver = applicantService.isLastDateOfApplicationOver();
		model.addAttribute("disableFormAfterLastDateOver", disableFormAfterLastDateOver);
		model.addAttribute("disableOtherInformationFormFieldsOnPayment", applicantService.isPaymentDoneOrChallanGeneratedByApplicant(applicantOtherInformation.getApplicant().getId()));
        model.addAttribute("cityList", cityList);
		model.addAttribute("applicantOtherInformation", applicantOtherInformation);

        String disableSaveAsDraft = systemSettingService.getSystemSetting(SystemSettingEnum.DISABLE_SAVE_AS_DRAFT);
        model.addAttribute("disableSaveAsDraft", disableSaveAsDraft);

        String disablePostSelection = systemSettingService.getSystemSetting(SystemSettingEnum.DISABLE_POST_SELECTION);
        model.addAttribute("disablePostSelection", disablePostSelection );

        return "otherInformation";
	}

	@RequestMapping(params = "operation=saveOtherInformation")
	public @ResponseBody Map saveOtherInformation(ApplicantOtherInformation applicantOtherInformation) {
		log.debug("Saving applicant's Other Information");
		Map<String, Object> result = new HashMap<>();
		boolean success = true;
		try {
			Applicant applicant = SecurityUtils.getCurrentUser().getApplicant();
			applicantOtherInformation.setApplicant(applicant);
			applicantService.saveApplicantOtherInformation(applicantOtherInformation, applicant);
		} catch(Exception e){
			log.error(e.getMessage());
			success = false;
		}

		result.put("success", success);
		return result;
	}

	@RequestMapping(params = "operation=showPostSelection")
	public String showPostSelection(Model model){
		log.debug("Show Post selection");
        Applicant applicant = applicantService.findApplicantById(SecurityUtils.getCurrentUser().getApplicant().getId());
		List<PostSuperCategory> postSuperCategoryList = applicantService.findAllPostSuperCategory();
//		List<ApplicantPostAssoc> applicantPostAssocs = applicantService.findApplicantPostAssocsByApplicant(applicant);
		List<Long> appliedPostIdList = new ArrayList<Long>();
		List<ApplicantPostAssoc> applicantPostAssocsOrderByPostCategory = applicantService.findApplicantPostAssocsByApplicantIdOrderByPostCategory(applicant.getId());
		
		ApplicantOtherInformation applicantOtherInfo =  applicantService.findApplicantOtherInformationByApplicant(applicant);
		boolean personalOrOtherInfoStatus = false;
		if(applicant.getStatus() == 1 && applicantOtherInfo.getStatus() == 1) {
			personalOrOtherInfoStatus = true;
		}
		
		List<Long> paymentTransactionSuccessPostIdList = new ArrayList<Long>();
        if(applicantPostAssocsOrderByPostCategory != null && applicantPostAssocsOrderByPostCategory.size() > 0){
            for(ApplicantPostAssoc applicantPostAssoc : applicantPostAssocsOrderByPostCategory){
            	appliedPostIdList.add(applicantPostAssoc.getPostId());
                applicantPostAssoc.setAgeValid(ageValidatorService.isApplicantOfValidAgeToApplyForPost(applicant, applicantPostAssoc.getPost().getPostId().longValue(), true));
                Boolean formDisableStatus = applicantPostAssoc.getFormDisableStatus();
                if(formDisableStatus != null && formDisableStatus == true )
                {
					paymentTransactionSuccessPostIdList.add(applicantPostAssoc.getPostId());
                }
            }
        }
        
        List<Long> postApplyLastDatePostIdList = new ArrayList<Long>();
        
        List<ApplicantPostAssoc> applicantPostAssocs = applicantService.findApplicantPostAssocsByApplicant(applicant);
		for (ApplicantPostAssoc apa : applicantPostAssocs) {
			if(apa.getPost().getPostLastDateOfApplication()!=null){
			Boolean disablePostFormAfterLastDateOver = applicantService.isLastDateOfApplicationOverForPost(apa.getPostId());
			if(disablePostFormAfterLastDateOver != null && disablePostFormAfterLastDateOver == true){
				postApplyLastDatePostIdList.add(apa.getPostId());
			}
		}
			}
        
        //boolean disableFormAfterLastDateOver = applicantService.isLastDateOfApplicationOver();
		//model.addAttribute("disableFormAfterLastDateOver", disableFormAfterLastDateOver);
        model.addAttribute("selectedPosts", applicantPostAssocsOrderByPostCategory);
		model.addAttribute("postSuperCategoryList",postSuperCategoryList);
		model.addAttribute("appliedPosts", appliedPostIdList);
        model.addAttribute("isPostSelectionPage", true);
        model.addAttribute("applicant", applicant);
        model.addAttribute("paymentTransactionSuccessPostsId", paymentTransactionSuccessPostIdList);
        model.addAttribute("postApplyLastDatePostIdList", postApplyLastDatePostIdList);
        model.addAttribute("personalOrOtherInfoStatus", personalOrOtherInfoStatus);
        
		return "postSelection";
	}

	@RequestMapping(params = "operation=savePostSelection")
	public @ResponseBody Map savePostSelection(HttpServletRequest request) {
		log.debug("Saving applicant's Post selection");
		Map<String, Object> result = new HashMap<>();
		boolean success = true;

		try {
            String[] selectedPostIds = request.getParameterValues("postList");
			if(selectedPostIds != null && selectedPostIds.length > 0){
				applicantService.saveAllApplicantPostAssoc(selectedPostIds, SecurityUtils.getCurrentUser().getApplicant());
			}
		} catch(Exception e){
			e.printStackTrace();
			log.error(e.getMessage());
			success = false;
		}

		result.put("success", success);
		return result;
	}

	@RequestMapping(params = "operation=showSelectedPosts")
	public String showSelectedPosts(Model model, @RequestParam(required = false) boolean isPostSelectionPage){
		log.debug("Show selected post");
		String locale = LocaleContextHolder.getLocale().toString();
		Applicant applicant = applicantService.findApplicantById(SecurityUtils.getCurrentUser().getApplicant().getId());
		LocalDate applicantdob = applicant.getBirthDate();
		List<ApplicantPostAssoc> applicantPostAssocsOrderByPostCategory = applicantService.findApplicantPostAssocsByApplicantIdOrderByPostCategory(applicant.getId());
		
		ApplicantOtherInformation applicantOtherInfo =  applicantService.findApplicantOtherInformationByApplicant(applicant);
		boolean personalOrOtherInfoStatus = false;
		if(applicantOtherInfo != null){
			if(applicant.getStatus() == 1 && applicantOtherInfo.getStatus() == 1) {
				personalOrOtherInfoStatus = true;
			}
		}
		
        //List<PostSuperCategory> postSuperCategoryList = applicantService.findAllPostSuperCategory();
        List<PostSuperCategory> postSuperCategoryList = applicantService.findAllPostSuperCategoryBySuperCategoryOrder();
        List<PostSuperCategory> postSuperCategoryListWithActivePosts = new ArrayList<PostSuperCategory>();
        for(PostSuperCategory pstSC : postSuperCategoryList){
        	List<PostCategory> postCategoryListWithActivePosts = new ArrayList<PostCategory>();
        	PostSuperCategory pcsWithActivePosts= new PostSuperCategory();
        	pcsWithActivePosts.setId(pstSC.getId());
        	pcsWithActivePosts.setCategoryTitle(pstSC.getCategoryTitle());
        	pcsWithActivePosts.setMessageKey(pstSC.getMessageKey());
        	pcsWithActivePosts.setSuperCategoryOrder(pstSC.getSuperCategoryOrder());
        	for(PostCategory pc:pstSC.getPosCategorytList()){
        		PostCategory pcWithActivePost = new PostCategory();
        		pcWithActivePost.setId(pc.getId());
        		pcWithActivePost.setCategoryTitle(pc.getCategoryTitle());
        		pcWithActivePost.setMessageKey(pc.getMessageKey());
        		pcWithActivePost.setPostSuperCategory(pc.getPostSuperCategory());
        		List<Post> activePostList = new ArrayList<Post>();
        		for(Post p:pc.getPostList()){
        			if(p.getActive()){
        				activePostList.add(p);
        			}
        		}
        		pcWithActivePost.setPostList(activePostList);
        		if(activePostList!=null && !activePostList.isEmpty()){
        			postCategoryListWithActivePosts.add(pcWithActivePost);
        		}
        	}
        	if(postCategoryListWithActivePosts!=null && !postCategoryListWithActivePosts.isEmpty()){
        		pcsWithActivePosts.setPosCategorytList(postCategoryListWithActivePosts);
        		postSuperCategoryListWithActivePosts.add(pcsWithActivePosts);
        	}
        }
        
        List<Long> paymentTransactionSuccessPostIdList = new ArrayList<Long>();
               
		if(applicantPostAssocsOrderByPostCategory != null && applicantPostAssocsOrderByPostCategory.size() > 0){
			for(ApplicantPostAssoc applicantPostAssoc : applicantPostAssocsOrderByPostCategory){
				Post post = applicantPostAssoc.getPost();
				if(post != null)
				{	
					//Considering candidate is differently abled.
					applicantPostAssoc.setAgeValid(ageValidatorService.isApplicantOfValidAgeToApplyForPost(applicant, post.getPostId().longValue(), true));
					//Considering candidate is not differently abled.
					applicantPostAssoc.setAgeInvalid(ageValidatorService.isApplicantOfValidAgeToApplyForPost(applicant, post.getPostId().longValue(), false));
					Boolean formDisableStatus = applicantPostAssoc.getFormDisableStatus();
					if(formDisableStatus != null && formDisableStatus == true )
	                {
						paymentTransactionSuccessPostIdList.add(applicantPostAssoc.getPostId());
	                }
				}
			}
		}

        List<Long> appliedPostIdList = new ArrayList<Long>();
        List<ApplicantPostAssoc> applicantPostAssocs = applicantService.findApplicantPostAssocsByApplicant(applicant);

        Set<PostCategory> pcSet = new HashSet<PostCategory>();
        Set<PostSuperCategory> pcsSet = new HashSet<PostSuperCategory>();
        int noOfSelectedTechNicalPosts = 0;
        int noOfSelectedNonTechNicalPosts = 0;
        int noOfTechPostsSelectedForOfficer = 0;
        int noOfNonTechPostsSelectedForOfficer = 0;
        for(ApplicantPostAssoc applicantPostAssoc : applicantPostAssocs){
            appliedPostIdList.add(applicantPostAssoc.getPostId());
            pcSet.add(applicantPostAssoc.getPost().getPostCategory());
        	pcsSet.add(applicantPostAssoc.getPost().getPostCategory().getPostSuperCategory());
        	if(applicantPostAssoc.getPost().getPostCategory().getId()==PostCategoryEnum.Technical.getPostCategoryId()){
    			noOfSelectedTechNicalPosts=(noOfSelectedTechNicalPosts+1);
    		}else if(applicantPostAssoc.getPost().getPostCategory().getId()==PostCategoryEnum.NonTechnical.getPostCategoryId()){
    			noOfSelectedNonTechNicalPosts=(noOfSelectedNonTechNicalPosts+1);
    		}else if(applicantPostAssoc.getPost().getPostCategory().getId()==PostCategoryEnum.TechnicalForOfficer.getPostCategoryId()){
    			noOfTechPostsSelectedForOfficer=(noOfTechPostsSelectedForOfficer+1);
    		}else if(applicantPostAssoc.getPost().getPostCategory().getId()==PostCategoryEnum.NonTechnicalForOfficer.getPostCategoryId()){
    			noOfNonTechPostsSelectedForOfficer=(noOfNonTechPostsSelectedForOfficer+1);
    		}
        }

        List<PostCategory> newpcList = new ArrayList<PostCategory>();
        List<PostSuperCategory> newPcsList = new ArrayList<PostSuperCategory>();
        for(PostCategory pc : new ArrayList<PostCategory>(pcSet)){
        	List<Post> appliedPostListUnderCategry = new ArrayList<Post>();
        	List<ApplicantPostAssoc> appPostAssocListUnderCategory = new ArrayList<ApplicantPostAssoc>();
        	PostCategory pc1 = new PostCategory();
        	pc1.setId(pc.getId());
        	pc1.setMessageKey(pc.getMessageKey());
        	pc1.setCategoryTitle(pc.getCategoryTitle());
        	pc1.setPostSuperCategory(pc.getPostSuperCategory());
        	for(ApplicantPostAssoc apassoc : applicantPostAssocs){
        		for(Post p : pc.getPostList()){
        			if(p.getPostId()==apassoc.getPostId()){
        				appliedPostListUnderCategry.add(p);
        				appPostAssocListUnderCategory.add(apassoc);
        			}
        		}
        	}
        	pc1.setPostList(appliedPostListUnderCategry);
        	pc1.setApplicantPostAssocs(appPostAssocListUnderCategory);
        	newpcList.add(pc1);
        }
        
        for(PostSuperCategory pcs : new ArrayList<PostSuperCategory>(pcsSet)){
        	PostSuperCategory pcs1 = new PostSuperCategory();
        	List<PostCategory> postCategoryListForSuperCategory = new ArrayList<PostCategory>();
        	for(PostCategory newPc : newpcList){
        		if(newPc.getPostSuperCategory().getId()==pcs.getId()){
        			postCategoryListForSuperCategory.add(newPc);
        		}
        	}
        	pcs1.setId(pcs.getId());
        	pcs1.setCategoryTitle(pcs.getCategoryTitle());
        	pcs1.setMessageKey(pcs.getMessageKey());
        	pcs1.setPosCategorytList(postCategoryListForSuperCategory);
        	newPcsList.add(pcs1);
        }
        model.addAttribute("applicant", applicant);
        model.addAttribute("selectedPostSuperCategory", newPcsList);
        model.addAttribute("appliedPosts", appliedPostIdList);
		model.addAttribute("selectedPosts", applicantPostAssocsOrderByPostCategory);
        model.addAttribute("postSuperCategoryList",postSuperCategoryListWithActivePosts);
        model.addAttribute("startDateOfExam", systemSettingService.getSystemSetting(SystemSettingEnum.START_DATE_OF_REGISTRATION));
		if(isPostSelectionPage){
			model.addAttribute("isPostSelectionPage", true);
		} else {
			model.addAttribute("isPostSelectionPage", false);
		}

		List<PostDivisionAssoc> driverJrDivisionList = applicantService.findDivisionsByPostId((long) PostEnum.DRIVER_JR.getPostId());
		List<PostDivisionAssoc> conductorJrDivisionList = applicantService.findDivisionsByPostId((long) PostEnum.CONDUCTOR_JR.getPostId());
		List<PostDivisionAssoc> assistantJrDivisionList = applicantService.findDivisionsByPostId((long) PostEnum.ASSISTANT_JR.getPostId());
		List<PostDivisionAssoc> clerktypistJrDivisionList = applicantService.findDivisionsByPostId((long) PostEnum.CLERKTYPIST_JR.getPostId());
		List<PostDivisionAssoc> driverCumConductorJrDivisionList = applicantService.findDivisionsByPostId((long) PostEnum.DRIVERCUMCONDUCTOR_JR.getPostId());
		List<Division> divisionList = new ArrayList<>();
		for (PostDivisionAssoc postDivisionAssoc : driverCumConductorJrDivisionList) {
			Division division = applicantService.findDivisionById(postDivisionAssoc.getDivisionId().intValue());
			if(division.getIsDroughtAffected()==null){
				division.setIsDroughtAffected(false);
			}
			if(division.getIsDroughtAffected())	{	
			divisionList.add(division);
			}
		}

		List<Division> allDivisions = applicantService.findAllDivisions();
		List<Long> advtNo2DivisionIdList = Arrays.asList(1L, 25L, 26L, 8L, 13L, 17L, 6L, 31L, 10L); // this is had coded temp., DO NOT DO THIS,
		
		/*for (Division division : allDivisions) {
			if(advtNo2DivisionIdList.contains(division.getDivisionId())){
				divisionList.add(division);
			}
			
		}*/
		List advtNo2DivisionList = allDivisions.stream().filter(d -> advtNo2DivisionIdList.contains(d.getDivisionId())).collect(Collectors.toList());
		model.addAttribute("advtNo2DivisionList", advtNo2DivisionList);

		String startDate= systemSettingService.getSystemSetting(SystemSettingEnum.START_DATE_OF_REGISTRATION);
	       DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
	LocalDate formattedfromDate = LocalDate.parse(startDate, formatter);
	       model.addAttribute("startDateOfExam", formattedfromDate);
		model.addAttribute("divisionListDraughtAffected", divisionList);
		List<Qualification> activeHighestQualificationList = qualificationService.findAllActiveQualificationByPriority();
		
		
		List<Long> postApplyLastDatePostIdList = new ArrayList<Long>();
        
        List<ApplicantPostAssoc> applicantPostAssocss = applicantService.findApplicantPostAssocsByApplicant(applicant);
		for (ApplicantPostAssoc apa : applicantPostAssocss) {
			if(apa.getPost().getPostLastDateOfApplication()!=null){
			Boolean disablePostFormAfterLastDateOver = applicantService.isLastDateOfApplicationOverForPost(apa.getPostId());
			if(disablePostFormAfterLastDateOver != null && disablePostFormAfterLastDateOver == true){
				postApplyLastDatePostIdList.add(apa.getPostId());
			}
		}
			}
		model.addAttribute("postApplyLastDatePostIdList", postApplyLastDatePostIdList);
		//boolean disableFormAfterLastDateOver = applicantService.isLastDateOfApplicationOver();
		//model.addAttribute("disableFormAfterLastDateOver", disableFormAfterLastDateOver);
		model.addAttribute("applicantPostAssocs", applicantPostAssocs);
		model.addAttribute("divisionList", allDivisions);
        model.addAttribute("driverJrDivisionList", driverJrDivisionList);
        model.addAttribute("conductorJrDivisionList", conductorJrDivisionList);
        model.addAttribute("assistantJrDivisionList", assistantJrDivisionList);
        model.addAttribute("clerktypistJrDivisionList", clerktypistJrDivisionList);
        model.addAttribute("driverCumConductorJrDivisionList", driverCumConductorJrDivisionList);
        model.addAttribute("tradeList", applicantService.findAllActiveTrades());
        model.addAttribute("supervisorSuperCat", SuperCategoryEnum.Supervisor.getSuperCategoryId());
        model.addAttribute("OfficersSuperCat", SuperCategoryEnum.Officers.getSuperCategoryId());
        model.addAttribute("noOfTechPostsSelected", noOfSelectedTechNicalPosts);
        model.addAttribute("noOfTechPostsSelectedForOfficer", noOfTechPostsSelectedForOfficer);
        model.addAttribute("noOfNonTechPostsSelectedForOfficer", noOfNonTechPostsSelectedForOfficer);
        model.addAttribute("noOfNonTechPostsSelected", noOfSelectedNonTechNicalPosts);
        model.addAttribute("techPostCategoryId", PostCategoryEnum.Technical.getPostCategoryId());
        model.addAttribute("techPostCategoryIdForOfficer", PostCategoryEnum.TechnicalForOfficer.getPostCategoryId());
        model.addAttribute("nontechPostCategoryIdIdForOfficer", PostCategoryEnum.NonTechnicalForOfficer.getPostCategoryId());
        model.addAttribute("nontechPostCategoryId", PostCategoryEnum.NonTechnical.getPostCategoryId());
        model.addAttribute("paymentTransactionSuccessPostsId", paymentTransactionSuccessPostIdList);
        model.addAttribute("personalOrOtherInfoStatus", personalOrOtherInfoStatus);
        model.addAttribute("highestQualificationList",activeHighestQualificationList);
        model.addAttribute("locale",locale);
        Period per = Period.between(applicantdob, formattedfromDate);
        int years = per.getYears();
        model.addAttribute("applicantAgeInYears", years);
        return "postSelection";
	}

    @RequestMapping(params = "operation=saveApplicantPostDetails")
    public @ResponseBody Map saveApplicantPostDetails(ApplicantPostAssoc applicantPostAssoc, @RequestParam(required=false) MultipartFile experienceLetterScanCopy) {
        log.debug("Saving applicant's Post details for the post with id", applicantPostAssoc.getPostId());
        Map<String, Object> result = new HashMap<>();
        Applicant applicant = SecurityUtils.getCurrentUser().getApplicant();
        boolean success = true;
        try {
            applicantService.saveApplicantPostDetails(applicantPostAssoc, applicant, experienceLetterScanCopy);
        } catch(Exception e){
			e.printStackTrace();
            log.error(e.getMessage());
            success = false;
        }
        result.put("success", success);
        return result;
    }

    @RequestMapping(params = "operation=deleteApplicantPost")
    public @ResponseBody Map deleteApplicantPost(Long postId) {
        log.debug("Deleting applicant's Post with post id ", postId);
        Map<String, Object> result = new HashMap<>();
        boolean success = true;
        try {
            Applicant applicant = SecurityUtils.getCurrentUser().getApplicant();
            applicantService.deleteApplicantPost(applicant, postId);
        } catch(Exception e){
            log.error(e.getMessage());
            success = false;
        }
        result.put("success", success);
        return result;
    }

	@RequestMapping(params = "operation=showApplicantFiles")
	public String showApplicantFiles(Model model){
		Applicant applicant = SecurityUtils.getCurrentUser().getApplicant();
		ApplicantFiles applicantFiles = applicantService.getApplicantFilesByApplicantId(applicant.getId());
		boolean disableFormAfterLastDateOver = applicantService.isLastDateOfApplicationOver();
		model.addAttribute("disableFormAfterLastDateOver", disableFormAfterLastDateOver);
		model.addAttribute("applicationId", applicant.getApplicationId());
		model.addAttribute("applicantFiles", applicantFiles);
		model.addAttribute("disableApplicantFilesFormFieldsOnPayment", applicantService.isPaymentDoneOrChallanGeneratedByApplicant(applicant.getId()));
		String disableSaveAsDraft = systemSettingService.getSystemSetting(SystemSettingEnum.DISABLE_SAVE_AS_DRAFT);
        model.addAttribute("disableSaveAsDraft", disableSaveAsDraft);

		return "applicantFiles";
	}

	@RequestMapping(params = "operation=saveApplicantFiles")
	public @ResponseBody Map saveApplicantFiles(@RequestParam(required=false) MultipartFile photo,
												@RequestParam(required=false) MultipartFile signature,
                                                @RequestParam Long id, @RequestParam int status) {
		log.debug("Saving applicant's Photo and Signature.");
		Map<String, Object> result = new HashMap<>();
		
		boolean success = true;
		try {
			Applicant applicant = SecurityUtils.getCurrentUser().getApplicant();
			applicantService.saveApplicantFiles(id, applicant, photo, signature, status);
		} catch(Exception e){
			log.error(e.getMessage());
			success = false;
		}

		result.put("success", success);
		return result;
	}

	@RequestMapping(params = "operation=showConfirmation")
	public String showConfirmation(Model model){
        Applicant applicant = SecurityUtils.getCurrentUser().getApplicant();
        List<ApplicantPostAssoc> applicantPostAssocList = applicantService.findApplicantPostAssocsByApplicant(applicant);
        List<ApplicantPostAssoc> confirmedApplicantPostAssocList = applicantPostAssocList;
        /*for(ApplicantPostAssoc apa : applicantPostAssocList){
        	if(apa.getPaymentMode()!=null && apa.getPaymentMode().equals(String.valueOf(PaymentModeEnum.ONLINE.getId())) && apa.getStatus() == Long.parseLong(String.valueOf(StatusEnum.SUBMITTED.getId()))){
        		confirmedApplicantPostAssocList.add(apa);
        	}else if(apa.getPaymentMode()!=null && apa.getPaymentMode().equals(String.valueOf(PaymentModeEnum.OFFLINE.getId()))){
        		if(apa.getStatus() == Long.parseLong(String.valueOf(StatusEnum.SUBMITTED.getId())) || apa.getStatus() == Long.parseLong(String.valueOf(StatusEnum.PENDING.getId()))){
        			confirmedApplicantPostAssocList.add(apa);
        		}
        	}
        }*/
        List<Post> postList = applicantService.findAllActivePost();
        //boolean disableFormAfterLastDateOver = applicantService.isLastDateOfApplicationOver();
        boolean disableFormAfterLastDateOver = applicantService.disableFormAfterLastDateOfPayment();
        boolean disableFormAfterLastDateOfPayment = applicantService.disableFormAfterLastDateOfPayment();
		model.addAttribute("disableFormAfterLastDateOver", disableFormAfterLastDateOver);
		model.addAttribute("disableFormAfterLastDateOfPayment", disableFormAfterLastDateOfPayment);
        //model.addAttribute("applicantPostAssocList", applicantPostAssocList);
		model.addAttribute("applicantPostAssocList", confirmedApplicantPostAssocList);
        model.addAttribute("isAllPostSelected", applicantPostAssocList.size() - postList.size());

        String disablePayments = systemSettingService.getSystemSetting(SystemSettingEnum.DISABLE_PAYMENTS);
        model.addAttribute("disablePayments", disablePayments);

        return "confirmation";
	}

	@RequestMapping(params = "operation=applicantList")
	public String applicantList(Model model, ApplicantSearchDTO applicantSearchDTO, PageDetail pageDetail) {
		log.debug("Finding all applicant entries");
		Page<Applicant> page = applicantService.searchApplicants(applicantSearchDTO, pageDetail.getPageable());

		model.addAttribute("page", page);
		model.addAttribute("pageDetail", pageDetail);
		model.addAttribute("applicantSearchDTO", applicantSearchDTO);

		if(pageDetail.isNewPage()){
			return "applicantListResult";
		} else {
			return "applicantList";
		}
	}

	@RequestMapping(params = "operation=editApplicant")
	public String editApplicant(Long id , Model model) {
		log.debug("Finding applicant entry with the applicant id: {}", id);
		model.addAttribute("applicant", applicantService.findApplicantById(id));
		return "applicantForm";
	}

	@RequestMapping(params = "operation=saveApplicant")
	public String saveApplicant(Applicant applicant, final RedirectAttributes redirectAttributes) {
		log.debug("Saving Applicant with the information: {}", applicant);

        boolean isNew = applicant.getId() == null ||  applicant.getId() == 0;

		try {
        	applicantService.saveApplicant(applicant);

			if(isNew) {
				redirectAttributes.addFlashAttribute("message", messageSource.getMessage("applicant.created", null, LocaleContextHolder.getLocale()));
			} else {
				redirectAttributes.addFlashAttribute("message", messageSource.getMessage("applicant.updated", null, LocaleContextHolder.getLocale()));
			}
		} catch(Exception e){
			log.error(e.getMessage());
			redirectAttributes.addFlashAttribute("error", messageSource.getMessage("applicant.save.failed", null, LocaleContextHolder.getLocale()));
		}

		return "redirect:/applicant?operation=applicantList";
	}

	@GetMapping(value = "/forgotPasswordForm")
	public String forgotPasswordForm() {
		return "forgotPasswordForm";
	}
	
	@RequestMapping(params = "operation=myAccount")
	public String myAccount(Model model) {
		log.debug("myAccount of logged-in applicant");
		Applicant applicant = applicantService.findApplicantByApplicationId(SecurityUtils.getCurrentUser().getApplicant().getApplicationId());
		model.addAttribute("applicant", applicant);
		return "myAccount";
	}
	
	@PostMapping(value = "/saveForgotPasswordForm")
	public String saveForgotPasswordForm(@RequestParam(value = "email") String email,Model model,HttpServletRequest request) {
		Applicant applicant=applicantService.findApplicantByEmailAddress(email);
		if(applicant!=null){
			String token=UUID.randomUUID().toString();
			String resetLink =request.getScheme() + "://"+request.getServerName()+ ":" +request.getServerPort()+request.getContextPath()+"/applicant/handleForgotPassword?token="+token;

			applicantService.sendPasswordResetLinkToApplicant(applicant,resetLink,token);
			model.addAttribute("message", messageSource
					.getMessage("forgotPassword.linkSent", null,
							LocaleContextHolder.getLocale()));
			model.addAttribute("showForm",false);
		}else{
			model.addAttribute("message", messageSource
					.getMessage("forgotPassword.notExistingEmail", null,
							LocaleContextHolder.getLocale()));
		}
		return "forgotPasswordForm";
	}
	
	@GetMapping(value = "/handleForgotPassword")
	public String handleForgotPassword(@RequestParam("token") String token,
			Model model) {
		ChangePasswordRequest changePasswordRequest = changePasswordRequestService
				.findChangePasswordRequestByToken(token);
		if (changePasswordRequest != null) {

			if ((int)ChronoUnit.DAYS.between(changePasswordRequest.getCreatedDate(),LocalDate.now()) < 1
					&& changePasswordRequest.getExpired() == false) {
				model.addAttribute("emailId",
						changePasswordRequest.getEmailAddress());
				return "passwordResetForm";
			} else {
				changePasswordRequest.setExpired(true);
				model.addAttribute("resetMessage", messageSource
						.getMessage("forgotPassword.linkExpired", null,
								LocaleContextHolder.getLocale()));
				model.addAttribute("showForm",false);
				return "passwordResetForm";
			}

		} else {
			model.addAttribute("resetMessage", messageSource.getMessage(
					"forgotPassword.noRecordFound", null,
					LocaleContextHolder.getLocale()));
			model.addAttribute("showForm",false);
			return "passwordResetForm";
		}
	}
	
	@PostMapping(value = "/saveUpdatedPasswordForm")
	public String saveUpdatedPasswordForm(@RequestParam("newPassword")String password,@RequestParam("emailId")String emailId,Model model) {
		Applicant applicant=applicantService.findApplicantByEmailAddress(emailId);
		applicant.setNewPassword(password);
		applicantService.updatePassword(applicant);
		model.addAttribute("showForm",false);
		model.addAttribute("resetMessage",messageSource
				.getMessage("forgotPassword.passwordResetSuccess", null,
						LocaleContextHolder.getLocale()));
		return "passwordResetForm";
	}

	@RequestMapping(params = "operation=savePostPriority")
	public @ResponseBody Map savePostPriority(HttpServletRequest request) {
		log.debug("Saving applicant's Photo and Signature.");
		Map<String, Object> result = new HashMap<>();
		boolean success = true;
		try {
			String[] priorityArray = request.getParameterValues("postPriorityName");
			Map<Long, Integer> appPostPriorityMap = new HashMap<Long, Integer>();
			for(String str : priorityArray){
				String[] splitArray = str.split("_");
				appPostPriorityMap.put(Long.parseLong(splitArray[0]), Integer.parseInt(splitArray[1]));
			}
			applicantService.saveApplicationPostPriority(appPostPriorityMap);
		} catch(Exception e){
			log.error(e.getMessage());
			success = false;
		}
		result.put("success", success);
		return result;
	}
		
	@RequestMapping(params = "operation=verifyOTP")
	public @ResponseBody String verifyOTP(String otp) {
		log.debug("Verify OTP with the otp: {}", otp);
		Applicant applicant = applicantService.findApplicantById(SecurityUtils.getCurrentUser().getApplicant().getId());
		ApplicantOTP applicantOTP = applicantService.findByApplicantId(applicant.getId());
		String returnString = "fail";
		if (otp.equals(applicantOTP.getOtp())) {
			applicant.setMobileNoVerified(Boolean.TRUE);
			applicantService.saveApplicant(applicant);
			returnString = "pass";
		}
		return returnString;
	}
	
	@RequestMapping(params = "operation=resendOTP")
	public @ResponseBody void resendOTP() {
		log.debug("Resend OTP of logged-in applicant");
		Applicant applicant = applicantService.findApplicantById(SecurityUtils.getCurrentUser().getApplicant().getId());
		ApplicantOTP applicantOTP = applicantService.findApplicantOTPByApplicantId(applicant.getId());
        Integer newOtp = CommonUtils.generateRandomOTP();
		
		applicant.setMobileNoVerified(Boolean.FALSE);
		applicantService.saveApplicant(applicant);
		
		applicantService.updateApplicantOTP(applicant.getId() , String.valueOf(newOtp) );
		applicantOTP = applicantService.findApplicantOTPByApplicantId(applicant.getId());
		newOtp = applicantOTP.getOtp() == null ? 0 : Integer.parseInt(applicantOTP.getOtp());
		
		sentSMSService.reSendOTP(applicant.getMobileNumber(), applicant.getFirstName(), newOtp);
		
	}

    @RequestMapping(params = "operation=validateSubmission")
    public @ResponseBody Map  validateSubmission(){
        log.debug("Checking if the applicant is doing a valid post submission.");
        Map<String, Object> result = new HashMap<>();

        boolean success = true;

        try {
            Applicant applicant = SecurityUtils.getCurrentUser().getApplicant();
            SubmissionErrorsDTO errorsDTO = applicantService.checkErrorsInApplicationSubmission(applicant);
            result.put("errorsDTO", errorsDTO );
        } catch(Exception e){
            log.error(e.getMessage());
            success = false;
        }

        result.put("success", success);
        return result;
    }

    @RequestMapping(params = "operation=viewPostDetails")
    public String viewPostDetails(Model model, @RequestParam Long applicantPostAssocId, @RequestParam(required = false) Long applicantId){
    	String locale = LocaleContextHolder.getLocale().toString();
		ApplicantPostAssoc applicantPostAssoc = applicantService.findApplicantPostAssocByApplicantPostAssocIdWithDetails(applicantPostAssocId, 0);
		model.addAttribute("applicantPostAssoc", applicantPostAssoc);
		Qualification otherQualification = null;
		if(applicantPostAssoc.getOtherQualification()!=null){
			otherQualification = qualificationService.findQualificationById(applicantPostAssoc.getOtherQualification());
		}
		String postOtherQualification = "";
		if(otherQualification!=null){
			if ( "en".equals(locale) ) {
				postOtherQualification=otherQualification.getTitle();
			}else{
				postOtherQualification=otherQualification.getTitleInMarathi();
			}
		}
		Applicant applicant;
		if(applicantId!=null){
			applicant=applicantService.findApplicantById(applicantId);
		}else{
			applicant= SecurityUtils.getCurrentUser().getApplicant();
		}
        Applicant dbApplicant = applicantService.findApplicantById(applicant.getId());
      //---------- find out applicant age and month of birth ------------------
        if(dbApplicant.getBirthDate() != null){
	  		int[] ageAndMonthsArr = CommonUtils.getApplicantAgeInYearsAndMonths(dbApplicant.getBirthDate());
	  		dbApplicant.setApplicantAgeInYears(ageAndMonthsArr[0]);
	  		dbApplicant.setApplicantAgeInMonths(ageAndMonthsArr[1]);
			dbApplicant.setApplicantAgeInDays(ageAndMonthsArr[2]);

			String systemReferenceDate = systemSettingService.getSystemSetting(SystemSettingEnum.REFERENCE_DATE);
			String dateFormat = CommonUtils.getLocalDateFormat(LocalDate.parse(systemReferenceDate, DateTimeFormatter.ofPattern("dd/MM/yyyy").withLocale(Locale.ENGLISH)), "dd/MM/yyyy");
			LocalDate referenceDate = LocalDate.parse(dateFormat, DateTimeFormatter.ofPattern("dd/MM/yyyy").withLocale(Locale.ENGLISH));
			int[] ageAsOnGivenDate = CommonUtils.getApplicantAgeAsOnGivenDate(dbApplicant.getBirthDate(), referenceDate);

			model.addAttribute("ageAsOnGivenDate", ageAsOnGivenDate);
		}
        Qualification highestQualification = new Qualification();
        if(dbApplicant.getHighestQualification()!=null){
        	highestQualification = qualificationService.findQualificationById(dbApplicant.getHighestQualification());
        }
        model.addAttribute("qualification", highestQualification);
        model.addAttribute("applicant", dbApplicant);
        model.addAttribute("castes", applicantService.findAllCastes());
        model.addAttribute("districts", applicantService.findAllDistricts());
        ApplicantFiles files = applicantService.getApplicantFilesByApplicantId(applicant.getId());
        model.addAttribute("applicantFiles", files);
        model.addAttribute("applicationId", applicant.getApplicationId());
        ApplicantOtherInformation applicantOtherInformation = applicantService.findApplicantOtherInformationByApplicant(dbApplicant);
		model.addAttribute("applicantOtherinfo", applicantOtherInformation);
        model.addAttribute("cities", applicantService.findAllCities());
		model.addAttribute("formReadOnly", true);
		model.addAttribute("postOtherQualification", postOtherQualification);
		if(applicantPostAssoc.getDivisionId() !=null){
		model.addAttribute("divisionName", applicantService.findDivisionById(applicantPostAssoc.getDivisionId()).getMessageKey());
		}
		if(applicantPostAssoc.getTradeId() !=null){
			model.addAttribute("tradeName", applicantService.findTradeById(applicantPostAssoc.getTradeId()).getMessageKey());
			}
		if(applicantOtherInformation != null && applicantOtherInformation.getPreferredCity1()!=null){
			model.addAttribute("city", applicantService.findCityById(applicantOtherInformation.getPreferredCity1()));
		}
		if(applicantOtherInformation != null && applicantOtherInformation.getPreferredCity2()!=null){
			model.addAttribute("citySecond", applicantService.findCityById(applicantOtherInformation.getPreferredCity2()));
		}
		if(applicantOtherInformation != null && applicantOtherInformation.getPreferredCity3()!=null){
			model.addAttribute("citythird", applicantService.findCityById(applicantOtherInformation.getPreferredCity3()));
		}
		model.addAttribute("locale", locale);
		if(applicantPostAssoc.getDcDivisionId() !=null){
			model.addAttribute("dcDivisionName", applicantService.findDivisionById(applicantPostAssoc.getDcDivisionId()).getMessageKey());
			}
        return "viewPostDetails";
    }

    @RequestMapping(params = "operation=viewChallan")
	public String viewChallan(Model model, HttpServletRequest request)
	{
    	log.debug("Applicant's view challan controller called.");
		//String txnOrderNo, int status
		String txnOrderNo = request.getParameter("txnOrderNo");
		 ArrayList<Long> postId=new ArrayList<Long>();
//		String paymentStatus = request.getParameter("status");
		if(txnOrderNo == null || txnOrderNo.trim().isEmpty())
		{
			log.info("Invalid[txnOrderNo:"+txnOrderNo+"]");
			model.addAttribute("msg", "Challan not generated");
			return "applicantDashboard";
		}
		Applicant applicant = applicantService.findApplicantById(SecurityUtils.getCurrentUser().getApplicant().getId());
		List<ApplicantPostAssoc> applicantPostAssocList = applicantService.findByTxnOrderNo(txnOrderNo);
		applicantPostAssocList.forEach(applicanPostAssoc -> 
			applicanPostAssoc = applicantService.findApplicantPostAssocByApplicantPostAssocIdWithDetails(applicanPostAssoc.getId(), 1)
			
		);
		/*Integer postFees =0;
		for( ApplicantPostAssoc applicantPostAssoc:applicantPostAssocList){
			Integer PostFeesForSinglePost=0;
			 ApplicantPostAssoc applicantPostAssocDetails=applicantService.findApplicantPostAssocByApplicantPostAssocIdWithDetails(applicantPostAssoc.getId(), 1);
			 if(applicantPostAssocDetails.getAdvtNo()!=null && applicantPostAssocDetails.getAdvtNo()>0 && applicantPostAssocDetails.getAdvtNo()==2){
				 PostFeesForSinglePost=applicantService.getPostFeesAsPerAdvertisementNumber(applicant);
			 }else{
				 PostFeesForSinglePost=applicantService.getPostFees(applicant);
			 }
			 postFees = postFees+PostFeesForSinglePost;
		}*/
		for(ApplicantPostAssoc postAssocList:applicantPostAssocList){
			 postId.add(postAssocList.getPostId());
		}
		Integer postFees = applicantService.getPostFees(applicant) ;
		List<Long> UniquePostType=applicantService.findUniquePostByPostType(postId);
		postFees = postFees * UniquePostType.size();
		//postFees = postFees * applicantPostAssocList.size();
		
		String feesType = systemSettingService.getSystemSetting(SystemSettingEnum.OFFLINE_PAYMENT_FEES_TYPE);
        String bankCharges = systemSettingService.getSystemSetting(SystemSettingEnum.OFFLINE_PAYMENT_BANK_CHARGES);
        
        BigDecimal totalFees = new BigDecimal(postFees).add(new BigDecimal(bankCharges));
        
        PaymentTransaction paymentTransaction =  paymentTransactionService.findPaymentTransactionByOrderNo(txnOrderNo);
		model.addAttribute("isOpenCategoryFeesApplicable", applicantService.isOpenCategoryFeesApplicable(applicant));

        if(paymentTransaction != null)
        {
	        model.addAttribute("feesType", feesType);
	        model.addAttribute("bankCharges", bankCharges);
	        model.addAttribute("postFees", postFees);
	        model.addAttribute("totalFees", totalFees);
	        model.addAttribute("applicant", applicant);
	        model.addAttribute("applicantPostAssociation", applicantPostAssocList);
	        model.addAttribute("applicationNo", txnOrderNo);
	        model.addAttribute("challanDate", CommonUtils.getLocalDateFormat(paymentTransaction.getCreatedDate().toLocalDate(), "dd/MM/yyyy"));
	      //----------------  last date of payment implementation
	        String  paymentDate = systemSettingService.getSystemSetting(SystemSettingEnum.OFFLINE_LAST_DATE_OF_PAYMENT);
	        String lastDateOfPayment = CommonUtils.getLocalDateFormat(LocalDate.parse(paymentDate !=null ? paymentDate : CommonUtils.getLocalDateFormat(LocalDate.now(), "dd/MM/yyyy")  , DateTimeFormatter.ofPattern("dd/MM/yyyy").withLocale(Locale.ENGLISH)), "dd/MM/yyyy");
	        model.addAttribute("lastDateOfPayment", lastDateOfPayment);
	        //-------------------------------------
	        model.addAttribute("viewChallan", true);
        }
        else
        {
        	log.info("PaymentTransaction not generated for [txnOrderNo:"+txnOrderNo+"]");
        	model.addAttribute("msg", "Challan not generated");
        	return "applicantDashboard";
        }
		return "viewChallan";
	}

    @RequestMapping(params = "operation=findDisabledPost")
    public @ResponseBody String findDisabledPost(@RequestParam("applicantId") Long id, @RequestParam("dob") LocalDate dob )
    {
    	log.debug("Call findDisabledPost handler method.");
    	Applicant applicant = applicantService.findApplicantById(id);
    	List<ApplicantPostAssoc> applicantPostAssocList = applicantService.findApplicantPostAssocsByApplicant(applicant);
    	List<Long> postIdList = new ArrayList<Long>();
    	List<String> postNameList = new ArrayList<String>();
    	applicant.setNewDate(dob);
    	boolean isDifferentlyAbled = true;
    	for (ApplicantPostAssoc apa : applicantPostAssocList) {
    		if(apa.getDifferentlyAbled()!=null && apa.getDifferentlyAbled()){
    			isDifferentlyAbled = true;
    		}else if(apa.getDifferentlyAbled()!=null && !apa.getDifferentlyAbled()){
    			isDifferentlyAbled = false;
    		}
    		boolean isageValidPost = ageValidatorService.isApplicantOfValidAgeToApplyForPost(applicant, apa.getPostId(), isDifferentlyAbled);
    		if(!isageValidPost)
    		{
    			postIdList.add(apa.getPostId());
    			postNameList.add(apa.getPost().getMessageKey());
    		}
		}
    	Map<String, Object> jsonMap = new HashMap<String, Object>();
    	
    	JSONObject jsonObj = new JSONObject();
    	jsonObj.put("postIds", postIdList);
    	jsonObj.put("invalidPostNames", postNameList);
//    	System.out.println("jsonData: "+jsonObj);
    	return jsonObj.toString();
    }
    
    @RequestMapping(params = "operation=getExamDataFromExamBench")
    public String getExamDataFromExamBench(Model model, HttpServletRequest request) {
        String lngCode = request.getParameter("lngCode");
        Integer applicantPostAssocId = Integer.parseInt(request.getParameter("applicantPostAssocId")== null ? "0":request.getParameter("applicantPostAssocId"));

        Integer postId = Integer.parseInt(request.getParameter("postId")== null ? "0":request.getParameter("postId"));
        
        ApplicantRestResponse  applicantRestResponse = applicantService.getExamDataFromExamBench(applicantPostAssocId,lngCode,postId);
        
        if (applicantRestResponse != null && applicantRestResponse.getQuestions() !=null && applicantRestResponse.getQuestions().size()>0) {
             model.addAttribute("questionList", applicantRestResponse.getQuestions());
        } else {
            model.addAttribute("questionList", null);
        }
        model.addAttribute("lngCode", lngCode);
        
        return "examResponse"; 
    }
    
  
    /*@RequestMapping(params = "operation=getExamDataFromExamBench", produces = "application/pdf")
	public void getExamDataFromExamBench(Model model, HttpServletRequest request, HttpServletResponse response) throws IOException {
   	String lngCode = request.getParameter("lngCode");
   	Integer applicantPostAssocId = Integer.parseInt(request.getParameter("applicantPostAssocId")== null ? "0":request.getParameter("applicantPostAssocId"));

   	Integer postId = Integer.parseInt(request.getParameter("postId")== null ? "0":request.getParameter("postId"));
   	
   	Integer applicantId = applicantService.getApplicantId(applicantPostAssocId , postId);
   	
   	String examCode = applicantService.getExamCode(postId);
   	
   	Date examDate = applicantService.getExamDate(applicantId, examCode);
   	
   	SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
   	
   	String parsedExamDate = formatter.format(examDate);
   	
   	String shiftName = applicantService.getShiftName(applicantId, examCode);
   	
   	String fileName = applicantService.getApplicationId(applicantId) + "_" + examCode +".pdf";
   	
   	String basePath = applicationProperties.getResources().getBasePath();
   	
   	String answerSheetLocation = basePath + File.separator + Constants.BASE_DOWNLOAD_DIR 
   								+ File.separator + Constants.ANSWER_SHEET + File.separator +
   								examCode + "_" + parsedExamDate + "_" + shiftName + File.separator + fileName;
   	
   	try{
   		response.setContentType("application/pdf");
   		response.setHeader("Expires", "0");
   		response.setHeader("Cache-Control","must-revalidate, post-check=0, pre-check=0");
   		response.setHeader("Content-Disposition","inline;filename=" + fileName);
   		response.setHeader("Accept-Ranges", "bytes");
   		response.setHeader("target=","_blank");
   		
    File answerSheet = new File(answerSheetLocation);
    FileInputStream fis = new FileInputStream(answerSheet);
    BufferedInputStream bis = new BufferedInputStream(fis);
    ServletOutputStream sos = response.getOutputStream();
    byte[] buffer = new byte[2048];
    while (true) {
      int bytesRead = bis.read(buffer, 0, buffer.length);
      if (bytesRead < 0) {
        break;
      }
    sos.write(buffer, 0, bytesRead);
    sos.flush();
    }
    sos.flush();
    bis.close();
  } catch (Exception e) {
    e.printStackTrace();
  }
   	 	
	}*/
    
}

