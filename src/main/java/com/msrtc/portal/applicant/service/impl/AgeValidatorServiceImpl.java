package com.msrtc.portal.applicant.service.impl;

import com.msrtc.portal.applicant.domain.Applicant;
import com.msrtc.portal.applicant.domain.ApplicantOtherInformation;
import com.msrtc.portal.applicant.domain.ApplicantPostAssoc;
import com.msrtc.portal.applicant.domain.CasteEnum;
import com.msrtc.portal.applicant.dto.AgeValidationCriteria;
import com.msrtc.portal.applicant.repository.ApplicantOtherInformationRepository;
import com.msrtc.portal.applicant.repository.ApplicantPostAssocRepository;
import com.msrtc.portal.applicant.repository.ApplicantRepository;
import com.msrtc.portal.applicant.service.AgeValidatorService;
import com.msrtc.portal.applicant.util.PostConstants;
import com.msrtc.portal.core.common.util.CommonUtils;
import com.msrtc.portal.core.systemsetting.service.SystemSettingService;
import com.msrtc.portal.core.systemsetting.util.SystemSettingEnum;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

@Service(value = "ageValidatorService")
public class AgeValidatorServiceImpl implements AgeValidatorService {

    @Autowired
    private ApplicantRepository applicantRepository;

    @Autowired
    private ApplicantOtherInformationRepository applicantOtherInformationRepository;

    @Autowired
    private SystemSettingService systemSettingService;

    @Autowired
    private ApplicantPostAssocRepository applicantPostAssocRepository;

    @Override
    public boolean isApplicantOfValidAgeToApplyForPost(Applicant applicant, long postId, boolean isDifferentlyAbled){
        Applicant dbApplicant = applicantRepository.findOne(applicant.getId());
        ApplicantOtherInformation applicantOtherInformation = applicantOtherInformationRepository.findApplicantOtherInformationByApplicant(dbApplicant);
        ApplicantPostAssoc applicantPostAssoc = applicantPostAssocRepository.findApplicantPostAssocByApplicantIdAndPostId(applicant.getId(), postId);

        boolean nonCreamyLayer=false;
        boolean isSportsPerson = false;
        boolean isEarthQuakeAffected = false;
        boolean isProjectAffected = false;
        boolean isPartTimeEmployee = false;
        boolean isStEmployee = false;
        boolean exServiceMan = false;
        String exServiceManExpYears = "0";
        String exServiceManExpMonths = "0";
        boolean isDeafAndMute = false;
        boolean islocomotorOrCerebralPalsy = false;
        boolean isBelongToEws = false;
        //Getting null pointer exception if applicant other info page is not filled and post selection page is directly rendered by navigating to it. So put a null check here.
        if(applicantOtherInformation != null){
        	 isSportsPerson = applicantOtherInformation.getSportsPerson() != null ? applicantOtherInformation.getSportsPerson() : false;
             isEarthQuakeAffected = applicantOtherInformation.getEarthQuakeEffected() != null ? applicantOtherInformation.getEarthQuakeEffected() : false;
             isProjectAffected = applicantOtherInformation.getProjectEffected() != null ? applicantOtherInformation.getProjectEffected() : false;
             isPartTimeEmployee = applicantOtherInformation.getPartTimeEmployee() != null ? applicantOtherInformation.getPartTimeEmployee() : false;
             isStEmployee = applicantOtherInformation.getStEmployee() != null ? applicantOtherInformation.getStEmployee() : false;
             exServiceMan = applicantOtherInformation.getExServiceMan() != null ? applicantOtherInformation.getExServiceMan() : false;
             isDeafAndMute = applicantOtherInformation.getDeafAndMute() != null ? applicantOtherInformation.getDeafAndMute() : false;
             islocomotorOrCerebralPalsy = applicantOtherInformation.getLocomotorOrCerebralPalsy() != null ? applicantOtherInformation.getLocomotorOrCerebralPalsy() : false;
            exServiceManExpYears = applicantOtherInformation.getExServicemanTotalExperienceInYears();
            if(exServiceManExpYears==null || ("").equalsIgnoreCase(exServiceManExpYears) || !StringUtils.isNumeric(exServiceManExpYears)){
                exServiceManExpYears = "0";
            }

            exServiceManExpMonths = applicantOtherInformation.getExServicemanTotalExperienceInMonths();
            if(exServiceManExpMonths==null || ("").equalsIgnoreCase(exServiceManExpMonths) || !StringUtils.isNumeric(exServiceManExpMonths)){
                exServiceManExpMonths = "0";
            }
        }
        nonCreamyLayer=dbApplicant.getNonCreamyLayer()!=null ?dbApplicant.getNonCreamyLayer():false;
        if(dbApplicant.getCaste() == null){
            return false;
        }
        isBelongToEws=dbApplicant.getIsBelongToEws()!=null ?dbApplicant.getIsBelongToEws():false;
        
        int casteId = dbApplicant.getCaste().getId().intValue();

        if(dbApplicant != null && dbApplicant.getNonCreamyLayer() != null && !dbApplicant.getNonCreamyLayer()) {
            if (casteId != CasteEnum.OPEN.getCasteId() && casteId != CasteEnum.ST.getCasteId() && casteId != CasteEnum.SC.getCasteId()) {
                casteId = CasteEnum.OPEN.getCasteId();
            }
        }
        
        // reference date retrive from database systemsetting table
        String systemReferenceDate = systemSettingService.getSystemSetting(SystemSettingEnum.REFERENCE_DATE);

        /*if(applicantPostAssoc.getAdvtNo() != null && applicantPostAssoc.getAdvtNo().equals(PostConstants.ADVT_NO_2)){
            systemReferenceDate = PostConstants.ADVT_NO_2_DATE_FOR_AGE_VALIDATION;
        }*/

        String dateFormat = CommonUtils.getLocalDateFormat(LocalDate.parse(systemReferenceDate, DateTimeFormatter.ofPattern("dd/MM/yyyy").withLocale(Locale.ENGLISH)), "dd/MM/yyyy");
        
        LocalDate referenceDate = LocalDate.parse(dateFormat, DateTimeFormatter.ofPattern("dd/MM/yyyy").withLocale(Locale.ENGLISH));
        LocalDate birthDate = null;

        if(applicant.getNewDate() != null)
        	birthDate = applicant.getNewDate();
        else 
        	birthDate = dbApplicant.getBirthDate();
        
        int[] ageAsOnGivenDate = CommonUtils.getApplicantAgeAsOnGivenDate(birthDate, referenceDate);
        
        Period age = Period.of(ageAsOnGivenDate[0], ageAsOnGivenDate[1], ageAsOnGivenDate[2]);

        //Period age = Period.between(birthDate, referenceDate);

        AgeValidationCriteria criteria = new AgeValidationCriteria(age,
                casteId,
                (int) postId,
                isSportsPerson,
                isEarthQuakeAffected,
                isProjectAffected,
                isPartTimeEmployee,
                exServiceMan,
                Integer.parseInt(exServiceManExpYears),
                Integer.parseInt(exServiceManExpMonths),
                isStEmployee,nonCreamyLayer, isDeafAndMute, islocomotorOrCerebralPalsy, isBelongToEws);

        return isAgeWithinRange(criteria, isDifferentlyAbled);
    }

    @Override
    public boolean isAgeWithinRange(AgeValidationCriteria ageValidationCriteria, boolean isDifferentlyAbled){
        Period age = ageValidationCriteria.getAge();

        boolean ageWithinRange = true;

        int allowedMinAge = 24;
        int allowedMaxAge = 38;

        switch(ageValidationCriteria.getPostId()){
            case 1:
                // 1 is for Driver
                allowedMinAge = 18;
                switch(ageValidationCriteria.getCasteId()){
                    case 1:
                        // 1 is for OPEN
                        allowedMaxAge = 38;
                        break;
                    default:
                        // ALL OTHER CASTES
                        allowedMaxAge = 43;
                        break;
                }
                break;
            case 19:
                allowedMinAge = 18;
                switch(ageValidationCriteria.getCasteId()){
                    case 1:
                        // 1 is for OPEN
                        allowedMaxAge = 45;
                        break;
                    default:
                        // ALL OTHER CASTES
                        allowedMaxAge = 50;
                        break;
                }
                break;
            case 20:
                allowedMinAge = 18;
                switch(ageValidationCriteria.getCasteId()){
                    case 1:
                        // 1 is for OPEN
                        allowedMaxAge = 45;
                        break;
                    default:
                        // ALL OTHER CASTES
                        allowedMaxAge = 50;
                        break;
                }
                break;
            case 21:
                // 21 is for Driver-cum conductor
                allowedMinAge = 24;
                switch(ageValidationCriteria.getCasteId()){
                    case 1:
                        allowedMaxAge = 38;
                        break;
                    case 3:
                    	allowedMaxAge = 43;
                    	break;
                    case 4:
                		allowedMaxAge = 43;
                		break;
                    default:
                        // ALL OTHER CASTES
                        allowedMaxAge = 38;
                        break;
                }
                break;
            case 3:
                // 3 is for Clerk Typist (Jr.)
                allowedMinAge = 18;
                if(isDifferentlyAbled){
                	allowedMaxAge = 45;
                }else{
                	switch(ageValidationCriteria.getCasteId()){
                    case 1:
                        allowedMaxAge = 38;
                        break;
                    default:
                        // ALL OTHER CASTES
                        allowedMaxAge = 43;
                        break;
                }
                }
                break;
            case 9:
                // 9 is for Store Keeper (Jr.)
            	allowedMinAge = 18;
            	if(isDifferentlyAbled){
                	allowedMaxAge = 45;
                }else{
                	switch(ageValidationCriteria.getCasteId()){
                    case 1:
                        allowedMaxAge = 38;
                        break;
                    default:
                        // ALL OTHER CASTES
                        allowedMaxAge = 43;
                        break;
                }
                }
                break;
            case 13:
                // 13 is for Junior Engineer (Civil) (Jr.)
            	allowedMinAge = 18;
            	if(isDifferentlyAbled){
                	allowedMaxAge = 45;
                }else{
                	switch(ageValidationCriteria.getCasteId()){
                    case 1:
                        allowedMaxAge = 38;
                        break;
                    default:
                        // ALL OTHER CASTES
                        allowedMaxAge = 43;
                        break;
                }
                }
                break;
            case 22:
            	// 22 is for Division Controller
            	allowedMinAge = 18;
            	switch(ageValidationCriteria.getCasteId()){
                case 1:
                    allowedMaxAge = 38;
                    break;
                default:
                    // ALl OTHER CASTES
                    allowedMaxAge = 43;
                    break;
            }
            	break;
            default:
                // All OTHER POSTS
                allowedMinAge = 18;
                /*if(isDifferentlyAbled){
                	allowedMaxAge = 45;
                }else{*/
                switch(ageValidationCriteria.getCasteId()){
                    case 1:
                        allowedMaxAge = 38;
                        break;
                    case 3:
                        allowedMaxAge = 43;
                        break;
                    case 4:
                        allowedMaxAge = 43;
                        break;
                    case 11:
                        allowedMaxAge = 38;
                        break;
                    default:
                        // ALl OTHER CASTES
                        allowedMaxAge = 38;
                        break;
                }
                /*}*/
                break;
        }
        
        if(ageValidationCriteria.isNonCreamyLayer()==true && ageValidationCriteria.getCasteId()!=1 ){
        	allowedMaxAge = 43;
        }

        if(ageValidationCriteria.getPostId() != 19 && ageValidationCriteria.getPostId() != 20) {
            if (ageValidationCriteria.isSportsPerson()) {
            	allowedMaxAge = allowedMaxAge > 43 ? allowedMaxAge : 43;
            }
            /*if (ageValidationCriteria.isProjectAffected() || ageValidationCriteria.isEarthQuakeAffected()) {
                allowedMaxAge = 45;
            }
            if (ageValidationCriteria.isPartTimeEmployee()) {
                allowedMaxAge = 46;
            }*/
        }
        
        if(ageValidationCriteria.isBelongToEws() == true ){
        	allowedMaxAge= 43;
        }
        
        if(ageValidationCriteria.getPostId()== 30 && ageValidationCriteria.isIslocomotorOrCerebralPalsy()){
        	allowedMaxAge=45;
        }
        
        if(ageValidationCriteria.getPostId()== 31 && ageValidationCriteria.isDeafAndMute()){
        	allowedMaxAge=45;
        }

       // Period revisedAgeForExServiceMan = age;

       /* if(ageValidationCriteria.getPostId() != 19 && ageValidationCriteria.getPostId() != 20) {
	        if(ageValidationCriteria.isExServiceMan()){
	            Period servicePlusThree = Period.of(ageValidationCriteria.getExServiceManExpYears(), ageValidationCriteria.getExServiceManExpMonths(), 0).plusYears(3);
	            revisedAgeForExServiceMan = age.minus(servicePlusThree);
	
	            if(ageValidationCriteria.isStEmployee() ){
	                allowedMaxAge = 200;
	            }
	
	            if(age.getYears() < allowedMinAge){
	                return false;
	            } else {
	                return checkForUpperAgeLimit(revisedAgeForExServiceMan, allowedMaxAge);
	            }
	        }
        }*/
        
        if(ageValidationCriteria.getPostId() != 19 && ageValidationCriteria.getPostId() != 20) {
	        if(ageValidationCriteria.isStEmployee()){
	        	allowedMaxAge = 45;
	           // allowedMaxAge = 200;
	        }
        }
        
        if(ageValidationCriteria.getPostId() == 22) {
	        if(ageValidationCriteria.isStEmployee()){
	            allowedMaxAge = 45;
	        }
        }
       /* //==================================
        if(ageValidationCriteria.isNonCreamyLayer()==false){
        if(ageValidationCriteria.getCasteId()== 3 || ageValidationCriteria.getCasteId()==4
        		|| ageValidationCriteria.isSportsPerson()==true ){
        	allowedMaxAge = 43;
        }
        }
        
      
        //===================================
*/        if(age.getYears() < allowedMinAge){
            return false;
        } else {
            return checkForUpperAgeLimit(age, allowedMaxAge);
        }
    }

    private boolean checkForUpperAgeLimit(Period age, int allowedMaxAge) {
        if(age.getYears() < allowedMaxAge){
            return true;
        } else {
            if(age.getMonths() == 0 && age.getDays() == 0){
                if(age.getYears() <= allowedMaxAge){
                    return true;
                } else {
                    return false;
                }
            } else {
                return false;
            }
        }
    }
}
