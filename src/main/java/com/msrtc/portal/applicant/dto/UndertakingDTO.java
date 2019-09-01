package com.msrtc.portal.applicant.dto;

import com.msrtc.portal.applicant.domain.ApplicantPostAssoc;

import java.time.LocalDate;

public class UndertakingDTO {

    private long applicantId;

    private String logoPath;
    private String photoLocation;
    private String signatureLocation;

    private String applicationID;

    private String firstName;
    private String middleName;
    private String surname;

    private String firstNameInMarathi;
    private String middleNameInMarathi;
    private String surnameInMarathi;

    private LocalDate dob;
    
    private Boolean childOfFarmerWhoCommittedSuicide;
    
    private int gender;
    private String address;
    private String pinCode;
    private String email;
    private String mobile;
    private Long highestQualification;
    private String highestQualificationTitle;
    private Long districtId;
    private String district;
    private int maritalStatus;
    private boolean maharashtraDomicile;
    private boolean rwsMarathi;

    private Long casteId;
    private String caste;
    private String subCaste;

    private boolean nonCreamyLayer;
    private LocalDate certificateValidityEndingDate;
    private boolean droughtAffected;
    
    private boolean earthQuakeEffected;
    private boolean projectEffected;
    private boolean exServiceMan;
    private String exServiceManTotalExpInYears;
    private String exServiceManTotalExpInMonths;
    private LocalDate retirementDate;
    private boolean partTimeEmployee;
    private String partTimeEmployeeExpInYears;
    private String partTimeEmployeeExpInMonths;
    private boolean sportsPerson;
    private String sportsLevel;
    private boolean stEmployee;
    private boolean orphanedPerson;

    private String firstPreferredCity;
    private String secondPreferredCity;
    private String thirdPreferredCity;

    private String postAppliedFor;
    private int priority;
    private int postId;

    private ApplicantPostAssoc applicantPostAssoc;

    private boolean sscPass;
    private String 	otherQualificationDetails;
    private boolean nightBlindness;
    private boolean colorBlindness;
    private boolean visionAcuity;
    private boolean heavyDrivingLicense;
    private String 	heavyDrivingLicenseNumber;
    private LocalDate heavyDrivingLicenseIssueDate;
    private LocalDate heavyDrivingLicenseExpiryDate;
    private boolean psvBadge;
    private String 	psvBadgeNumber;
    private boolean conductorBatchLicense;
    private String 	conductorBatchLicenseNumber;
    private LocalDate conductorBatchLicenseIssueDate;
    private LocalDate conductorBatchLicenseExpiryDate;
    private boolean threeYearsExperienceAfterIssueOfHGVLicense;
    private String transportCompanyName;
    private String hgvExperienceInYears;
    private String hgvExperienceInMonths;
    private boolean guarantorPerson;
    private String guarantorPersonName;
    private String guarantorPersonNumber;
    private boolean physicalQualificationHeight;
    private boolean committedAnyFatalAccident;
    
    private Long firstPreferedCityId;
    private Long secondPreferedCityId;
    private Long thirdPreferedCityId;
    
    private String photoNameInDB;
    private String signatureNameInDB;
    
    private Long divisionId;
    private String divisionName;
    
    private boolean itiPassed;
    
    private Long tradeId;
    private String tradeName;
    
    private boolean experienced;
    private boolean lightMotorVechicle;
    private String lightMotorVechicleLicenseNo;
    private LocalDate lightMotorVechicleIssueDate;
    
    private boolean apprenticeshipInMSRTC;
    private String apprenticeshipInMSRTCTrade;
    private String apprenticeshipInMSRTCYear;
    private String apprenticeshipInMSRTCDivision;
    
    private boolean itEngineer;
    private String degreeName;
    private String universityName;
    
    private boolean automobileOrMechanicalEngDegree;
    private boolean oneYearExpInAutomobileRepairing;
    
    private boolean electricalEngineeringDegree;
    
    private boolean differentlyAbled;
    
    private boolean locomotorOrCerebralPalsy;
    private boolean architectEngineeringDegree;
    
    private boolean blindnessAndLowVision;
    private boolean deafAndMute;
    private boolean graduateFromAffiliatedInstitute;
    private boolean mscitOrDoeaccPassCertification;
    private boolean typingExamPassed;
    
    private boolean mscitOrGaccc;
    private boolean twoYearExpAsTransportAssociation;
    
    private boolean oneYearExpAsTransportAssociation;
    
    private boolean bcomPassed;
    private boolean oneYearExpAsAccountant;
    
    private boolean bComOrBSCOrDiplomaHoldersInAutomobileOrMechanical;
    
    private boolean fireSafetyDegreeFromAffiliatedInstitute;
    private String fireAndSafetyDegreeName;
    private String fireAndSafetyUniversityName;
    private boolean qualificationForMilitaryForce;
    private String miltaryForceDegreeName;
    private String miltaryForceUniversityName;
    private float requiredQualificationMarks;
    private Long otherQualification;
    private String instituteName;
    private long workExp;
    private String postName;
    private Long dcDivisionId;
    private String dcDivisionName;
    private String certificateNumber;
    private Integer allocatedCategory;
    private String workExperience;
    private Integer postGradDegreeTypeId;
	private String postGradDegreeInstituteName;
	private String postGradDegreeName;
	public ApplicantPostAssoc getApplicantPostAssoc() {
        return applicantPostAssoc;
    }

    public void setApplicantPostAssoc(ApplicantPostAssoc applicantPostAssoc) {
        this.applicantPostAssoc = applicantPostAssoc;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getLogoPath() {
        return logoPath;
    }

    public void setLogoPath(String logoPath) {
        this.logoPath = logoPath;
    }

    public String getPhotoLocation() {
        return photoLocation;
    }

    public void setPhotoLocation(String photoLocation) {
        this.photoLocation = photoLocation;
    }

    public String getSignatureLocation() {
        return signatureLocation;
    }

    public void setSignatureLocation(String signatureLocation) {
        this.signatureLocation = signatureLocation;
    }

    public String getApplicationID() {
        return applicationID;
    }

    public void setApplicationID(String applicationID) {
        this.applicationID = applicationID;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getMiddleName() {
        return middleName;
    }

    public void setMiddleName(String middleName) {
        this.middleName = middleName;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public LocalDate getDob() {
        return dob;
    }

    public void setDob(LocalDate dob) {
        this.dob = dob;
    }

    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPinCode() {
        return pinCode;
    }

    public void setPinCode(String pinCode) {
        this.pinCode = pinCode;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public int getMaritalStatus() {
        return maritalStatus;
    }

    public void setMaritalStatus(int maritalStatus) {
        this.maritalStatus = maritalStatus;
    }

    public boolean isMaharashtraDomicile() {
        return maharashtraDomicile;
    }

    public void setMaharashtraDomicile(boolean maharashtraDomicile) {
        this.maharashtraDomicile = maharashtraDomicile;
    }

    public boolean isRwsMarathi() {
        return rwsMarathi;
    }

    public void setRwsMarathi(boolean rwsMarathi) {
        this.rwsMarathi = rwsMarathi;
    }

    public String getCaste() {
        return caste;
    }

    public void setCaste(String caste) {
        this.caste = caste;
    }

    public String getSubCaste() {
        return subCaste;
    }

    public void setSubCaste(String subCaste) {
        this.subCaste = subCaste;
    }

    public boolean isEarthQuakeEffected() {
        return earthQuakeEffected;
    }

    public void setEarthQuakeEffected(boolean earthQuakeEffected) {
        this.earthQuakeEffected = earthQuakeEffected;
    }

    public boolean isProjectEffected() {
        return projectEffected;
    }

    public void setProjectEffected(boolean projectEffected) {
        this.projectEffected = projectEffected;
    }

    public boolean isExServiceMan() {
        return exServiceMan;
    }

    public void setExServiceMan(boolean exServiceMan) {
        this.exServiceMan = exServiceMan;
    }
    
    public String getExServiceManTotalExpInYears() {
		return exServiceManTotalExpInYears;
	}

	public void setExServiceManTotalExpInYears(String exServiceManTotalExpInYears) {
		this.exServiceManTotalExpInYears = exServiceManTotalExpInYears;
	}

	public String getExServiceManTotalExpInMonths() {
		return exServiceManTotalExpInMonths;
	}

	public void setExServiceManTotalExpInMonths(String exServiceManTotalExpInMonths) {
		this.exServiceManTotalExpInMonths = exServiceManTotalExpInMonths;
	}

	public LocalDate getRetirementDate() {
		return retirementDate;
	}

	public void setRetirementDate(LocalDate retirementDate) {
		this.retirementDate = retirementDate;
	}

	public boolean isPartTimeEmployee() {
        return partTimeEmployee;
    }

    public void setPartTimeEmployee(boolean partTimeEmployee) {
        this.partTimeEmployee = partTimeEmployee;
    }
    
    public String getPartTimeEmployeeExpInYears() {
		return partTimeEmployeeExpInYears;
	}

	public void setPartTimeEmployeeExpInYears(String partTimeEmployeeExpInYears) {
		this.partTimeEmployeeExpInYears = partTimeEmployeeExpInYears;
	}

	public String getPartTimeEmployeeExpInMonths() {
		return partTimeEmployeeExpInMonths;
	}

	public void setPartTimeEmployeeExpInMonths(String partTimeEmployeeExpInMonths) {
		this.partTimeEmployeeExpInMonths = partTimeEmployeeExpInMonths;
	}

	public boolean isSportsPerson() {
        return sportsPerson;
    }

    public void setSportsPerson(boolean sportsPerson) {
        this.sportsPerson = sportsPerson;
    }

    public String getSportsLevel() {
		return sportsLevel;
	}

	public void setSportsLevel(String sportsLevel) {
		this.sportsLevel = sportsLevel;
	}

	public boolean isStEmployee() {
        return stEmployee;
    }

    public void setStEmployee(boolean stEmployee) {
        this.stEmployee = stEmployee;
    }

    public String getFirstPreferredCity() {
        return firstPreferredCity;
    }

    public void setFirstPreferredCity(String firstPreferredCity) {
        this.firstPreferredCity = firstPreferredCity;
    }

    public String getSecondPreferredCity() {
        return secondPreferredCity;
    }

    public void setSecondPreferredCity(String secondPreferredCity) {
        this.secondPreferredCity = secondPreferredCity;
    }

    public String getThirdPreferredCity() {
        return thirdPreferredCity;
    }

    public void setThirdPreferredCity(String thirdPreferredCity) {
        this.thirdPreferredCity = thirdPreferredCity;
    }

    public String getPostAppliedFor() {
        return postAppliedFor;
    }

    public void setPostAppliedFor(String postAppliedFor) {
        this.postAppliedFor = postAppliedFor;
    }

    public int getPriority() {
        return priority;
    }

    public void setPriority(int priority) {
        this.priority = priority;
    }

    public String getFirstNameInMarathi() {
        return firstNameInMarathi;
    }

    public void setFirstNameInMarathi(String firstNameInMarathi) {
        this.firstNameInMarathi = firstNameInMarathi;
    }

    public String getMiddleNameInMarathi() {
        return middleNameInMarathi;
    }

    public void setMiddleNameInMarathi(String middleNameInMarathi) {
        this.middleNameInMarathi = middleNameInMarathi;
    }

    public String getSurnameInMarathi() {
        return surnameInMarathi;
    }

    public void setSurnameInMarathi(String surnameInMarathi) {
        this.surnameInMarathi = surnameInMarathi;
    }

    public boolean isNonCreamyLayer() {
        return nonCreamyLayer;
    }

    public void setNonCreamyLayer(boolean nonCreamyLayer) {
        this.nonCreamyLayer = nonCreamyLayer;
    }

    public LocalDate getCertificateValidityEndingDate() {
        return certificateValidityEndingDate;
    }

    public void setCertificateValidityEndingDate(LocalDate certificateValidityEndingDate) {
        this.certificateValidityEndingDate = certificateValidityEndingDate;
    }

	public boolean isSscPass() {
		return sscPass;
	}

	public void setSscPass(boolean sscPass) {
		this.sscPass = sscPass;
	}

	public String getOtherQualificationDetails() {
		return otherQualificationDetails;
	}

	public void setOtherQualificationDetails(String otherQualificationDetails) {
		this.otherQualificationDetails = otherQualificationDetails;
	}

	public boolean isNightBlindness() {
		return nightBlindness;
	}

	public void setNightBlindness(boolean nightBlindness) {
		this.nightBlindness = nightBlindness;
	}

	public boolean isColorBlindness() {
		return colorBlindness;
	}

	public void setColorBlindness(boolean colorBlindness) {
		this.colorBlindness = colorBlindness;
	}

	public boolean isVisionAcuity() {
		return visionAcuity;
	}

	public void setVisionAcuity(boolean visionAcuity) {
		this.visionAcuity = visionAcuity;
	}

	public boolean isHeavyDrivingLicense() {
		return heavyDrivingLicense;
	}

	public void setHeavyDrivingLicense(boolean heavyDrivingLicense) {
		this.heavyDrivingLicense = heavyDrivingLicense;
	}

	public String getHeavyDrivingLicenseNumber() {
		return heavyDrivingLicenseNumber;
	}

	public void setHeavyDrivingLicenseNumber(String heavyDrivingLicenseNumber) {
		this.heavyDrivingLicenseNumber = heavyDrivingLicenseNumber;
	}

	public LocalDate getHeavyDrivingLicenseIssueDate() {
		return heavyDrivingLicenseIssueDate;
	}

	public void setHeavyDrivingLicenseIssueDate(LocalDate heavyDrivingLicenseIssueDate) {
		this.heavyDrivingLicenseIssueDate = heavyDrivingLicenseIssueDate;
	}

	public LocalDate getHeavyDrivingLicenseExpiryDate() {
		return heavyDrivingLicenseExpiryDate;
	}

	public void setHeavyDrivingLicenseExpiryDate(LocalDate heavyDrivingLicenseExpiryDate) {
		this.heavyDrivingLicenseExpiryDate = heavyDrivingLicenseExpiryDate;
	}

	public boolean isPsvBadge() {
		return psvBadge;
	}

	public void setPsvBadge(boolean psvBadge) {
		this.psvBadge = psvBadge;
	}

	public String getPsvBadgeNumber() {
		return psvBadgeNumber;
	}

	public void setPsvBadgeNumber(String psvBadgeNumber) {
		this.psvBadgeNumber = psvBadgeNumber;
	}

	public boolean isConductorBatchLicense() {
		return conductorBatchLicense;
	}

	public void setConductorBatchLicense(boolean conductorBatchLicense) {
		this.conductorBatchLicense = conductorBatchLicense;
	}

	public String getConductorBatchLicenseNumber() {
		return conductorBatchLicenseNumber;
	}

	public void setConductorBatchLicenseNumber(String conductorBatchLicenseNumber) {
		this.conductorBatchLicenseNumber = conductorBatchLicenseNumber;
	}

	public LocalDate getConductorBatchLicenseIssueDate() {
		return conductorBatchLicenseIssueDate;
	}

	public void setConductorBatchLicenseIssueDate(LocalDate conductorBatchLicenseIssueDate) {
		this.conductorBatchLicenseIssueDate = conductorBatchLicenseIssueDate;
	}

	public LocalDate getConductorBatchLicenseExpiryDate() {
		return conductorBatchLicenseExpiryDate;
	}

	public void setConductorBatchLicenseExpiryDate(LocalDate conductorBatchLicenseExpiryDate) {
		this.conductorBatchLicenseExpiryDate = conductorBatchLicenseExpiryDate;
	}

	public boolean isThreeYearsExperienceAfterIssueOfHGVLicense() {
		return threeYearsExperienceAfterIssueOfHGVLicense;
	}

	public void setThreeYearsExperienceAfterIssueOfHGVLicense(boolean threeYearsExperienceAfterIssueOfHGVLicense) {
		this.threeYearsExperienceAfterIssueOfHGVLicense = threeYearsExperienceAfterIssueOfHGVLicense;
	}

	public String getTransportCompanyName() {
		return transportCompanyName;
	}

	public void setTransportCompanyName(String transportCompanyName) {
		this.transportCompanyName = transportCompanyName;
	}

	public String getHgvExperienceInYears() {
		return hgvExperienceInYears;
	}

	public void setHgvExperienceInYears(String hgvExperienceInYears) {
		this.hgvExperienceInYears = hgvExperienceInYears;
	}

	public String getHgvExperienceInMonths() {
		return hgvExperienceInMonths;
	}

	public void setHgvExperienceInMonths(String hgvExperienceInMonths) {
		this.hgvExperienceInMonths = hgvExperienceInMonths;
	}

	public boolean isGuarantorPerson() {
		return guarantorPerson;
	}

	public void setGuarantorPerson(boolean guarantorPerson) {
		this.guarantorPerson = guarantorPerson;
	}

	public String getGuarantorPersonName() {
		return guarantorPersonName;
	}

	public void setGuarantorPersonName(String guarantorPersonName) {
		this.guarantorPersonName = guarantorPersonName;
	}

	public String getGuarantorPersonNumber() {
		return guarantorPersonNumber;
	}

	public void setGuarantorPersonNumber(String guarantorPersonNumber) {
		this.guarantorPersonNumber = guarantorPersonNumber;
	}

	public boolean isPhysicalQualificationHeight() {
		return physicalQualificationHeight;
	}

	public void setPhysicalQualificationHeight(boolean physicalQualificationHeight) {
		this.physicalQualificationHeight = physicalQualificationHeight;
	}

	public boolean isCommittedAnyFatalAccident() {
		return committedAnyFatalAccident;
	}

	public void setCommittedAnyFatalAccident(boolean committedAnyFatalAccident) {
		this.committedAnyFatalAccident = committedAnyFatalAccident;
	}

    public Long getDistrictId() {
        return districtId;
    }

    public void setDistrictId(Long districtId) {
        this.districtId = districtId;
    }

    public Long getCasteId() {
        return casteId;
    }

    public void setCasteId(Long casteId) {
        this.casteId = casteId;
    }

    public long getApplicantId() {
        return applicantId;
    }
    
    public void setApplicantId(long applicantId) {
        this.applicantId = applicantId;
    }

	public Long getFirstPreferedCityId() {
		return firstPreferedCityId;
	}

	public void setFirstPreferedCityId(Long firstPreferedCityId) {
		this.firstPreferedCityId = firstPreferedCityId;
	}

	public Long getSecondPreferedCityId() {
		return secondPreferedCityId;
	}

	public void setSecondPreferedCityId(Long secondPreferedCityId) {
		this.secondPreferedCityId = secondPreferedCityId;
	}

	public Long getThirdPreferedCityId() {
		return thirdPreferedCityId;
	}

	public void setThirdPreferedCityId(Long thirdPreferedCityId) {
		this.thirdPreferedCityId = thirdPreferedCityId;
	}

	public String getPhotoNameInDB() {
		return photoNameInDB;
	}

	public void setPhotoNameInDB(String photoNameInDB) {
		this.photoNameInDB = photoNameInDB;
	}

	public String getSignatureNameInDB() {
		return signatureNameInDB;
	}

	public void setSignatureNameInDB(String signatureNameInDB) {
		this.signatureNameInDB = signatureNameInDB;
	}

	public Long getDivisionId() {
		return divisionId;
	}

	public void setDivisionId(Long divisionId) {
		this.divisionId = divisionId;
	}

	public String getDivisionName() {
		return divisionName;
	}

	public void setDivisionName(String divisionName) {
		this.divisionName = divisionName;
	}

	public boolean isItiPassed() {
		return itiPassed;
	}

	public void setItiPassed(boolean itiPassed) {
		this.itiPassed = itiPassed;
	}

	public Long getTradeId() {
		return tradeId;
	}

	public void setTradeId(Long tradeId) {
		this.tradeId = tradeId;
	}

	public String getTradeName() {
		return tradeName;
	}

	public void setTradeName(String tradeName) {
		this.tradeName = tradeName;
	}
	
	public boolean isExperienced() {
		return experienced;
	}

	public void setExperienced(boolean experienced) {
		this.experienced = experienced;
	}

	public boolean isLightMotorVechicle() {
		return lightMotorVechicle;
	}

	public void setLightMotorVechicle(boolean lightMotorVechicle) {
		this.lightMotorVechicle = lightMotorVechicle;
	}

	public String getLightMotorVechicleLicenseNo() {
		return lightMotorVechicleLicenseNo;
	}

	public void setLightMotorVechicleLicenseNo(String lightMotorVechicleLicenseNo) {
		this.lightMotorVechicleLicenseNo = lightMotorVechicleLicenseNo;
	}

	public LocalDate getLightMotorVechicleIssueDate() {
		return lightMotorVechicleIssueDate;
	}

	public void setLightMotorVechicleIssueDate(LocalDate lightMotorVechicleIssueDate) {
		this.lightMotorVechicleIssueDate = lightMotorVechicleIssueDate;
	}

	public boolean isApprenticeshipInMSRTC() {
		return apprenticeshipInMSRTC;
	}

	public void setApprenticeshipInMSRTC(boolean apprenticeshipInMSRTC) {
		this.apprenticeshipInMSRTC = apprenticeshipInMSRTC;
	}

	public String getApprenticeshipInMSRTCTrade() {
		return apprenticeshipInMSRTCTrade;
	}

	public void setApprenticeshipInMSRTCTrade(String apprenticeshipInMSRTCTrade) {
		this.apprenticeshipInMSRTCTrade = apprenticeshipInMSRTCTrade;
	}

	public String getApprenticeshipInMSRTCYear() {
		return apprenticeshipInMSRTCYear;
	}

	public void setApprenticeshipInMSRTCYear(String apprenticeshipInMSRTCYear) {
		this.apprenticeshipInMSRTCYear = apprenticeshipInMSRTCYear;
	}

	public String getApprenticeshipInMSRTCDivision() {
		return apprenticeshipInMSRTCDivision;
	}

	public void setApprenticeshipInMSRTCDivision(String apprenticeshipInMSRTCDivision) {
		this.apprenticeshipInMSRTCDivision = apprenticeshipInMSRTCDivision;
	}

	public boolean isItEngineer() {
		return itEngineer;
	}

	public void setItEngineer(boolean itEngineer) {
		this.itEngineer = itEngineer;
	}

	public String getDegreeName() {
		return degreeName;
	}

	public void setDegreeName(String degreeName) {
		this.degreeName = degreeName;
	}

	public String getUniversityName() {
		return universityName;
	}

	public void setUniversityName(String universityName) {
		this.universityName = universityName;
	}

	public boolean isAutomobileOrMechanicalEngDegree() {
		return automobileOrMechanicalEngDegree;
	}

	public void setAutomobileOrMechanicalEngDegree(boolean automobileOrMechanicalEngDegree) {
		this.automobileOrMechanicalEngDegree = automobileOrMechanicalEngDegree;
	}

	public boolean isOneYearExpInAutomobileRepairing() {
		return oneYearExpInAutomobileRepairing;
	}

	public void setOneYearExpInAutomobileRepairing(boolean oneYearExpInAutomobileRepairing) {
		this.oneYearExpInAutomobileRepairing = oneYearExpInAutomobileRepairing;
	}

	public boolean isElectricalEngineeringDegree() {
		return electricalEngineeringDegree;
	}

	public void setElectricalEngineeringDegree(boolean electricalEngineeringDegree) {
		this.electricalEngineeringDegree = electricalEngineeringDegree;
	}

	public boolean isDifferentlyAbled() {
		return differentlyAbled;
	}

	public void setDifferentlyAbled(boolean differentlyAbled) {
		this.differentlyAbled = differentlyAbled;
	}

	public boolean isLocomotorOrCerebralPalsy() {
		return locomotorOrCerebralPalsy;
	}

	public void setLocomotorOrCerebralPalsy(boolean locomotorOrCerebralPalsy) {
		this.locomotorOrCerebralPalsy = locomotorOrCerebralPalsy;
	}

	public boolean isArchitectEngineeringDegree() {
		return architectEngineeringDegree;
	}

	public void setArchitectEngineeringDegree(boolean architectEngineeringDegree) {
		this.architectEngineeringDegree = architectEngineeringDegree;
	}

	public boolean isBlindnessAndLowVision() {
		return blindnessAndLowVision;
	}

	public void setBlindnessAndLowVision(boolean blindnessAndLowVision) {
		this.blindnessAndLowVision = blindnessAndLowVision;
	}

	public boolean isDeafAndMute() {
		return deafAndMute;
	}

	public void setDeafAndMute(boolean deafAndMute) {
		this.deafAndMute = deafAndMute;
	}

	public boolean isGraduateFromAffiliatedInstitute() {
		return graduateFromAffiliatedInstitute;
	}

	public void setGraduateFromAffiliatedInstitute(boolean graduateFromAffiliatedInstitute) {
		this.graduateFromAffiliatedInstitute = graduateFromAffiliatedInstitute;
	}

	public boolean isMscitOrDoeaccPassCertification() {
		return mscitOrDoeaccPassCertification;
	}

	public void setMscitOrDoeaccPassCertification(boolean mscitOrDoeaccPassCertification) {
		this.mscitOrDoeaccPassCertification = mscitOrDoeaccPassCertification;
	}

	public boolean isTypingExamPassed() {
		return typingExamPassed;
	}

	public void setTypingExamPassed(boolean typingExamPassed) {
		this.typingExamPassed = typingExamPassed;
	}

	public boolean isMscitOrGaccc() {
		return mscitOrGaccc;
	}

	public void setMscitOrGaccc(boolean mscitOrGaccc) {
		this.mscitOrGaccc = mscitOrGaccc;
	}

	public boolean isTwoYearExpAsTransportAssociation() {
		return twoYearExpAsTransportAssociation;
	}

	public void setTwoYearExpAsTransportAssociation(boolean twoYearExpAsTransportAssociation) {
		this.twoYearExpAsTransportAssociation = twoYearExpAsTransportAssociation;
	}

	public boolean isOneYearExpAsTransportAssociation() {
		return oneYearExpAsTransportAssociation;
	}

	public void setOneYearExpAsTransportAssociation(boolean oneYearExpAsTransportAssociation) {
		this.oneYearExpAsTransportAssociation = oneYearExpAsTransportAssociation;
	}

	public boolean isBcomPassed() {
		return bcomPassed;
	}

	public void setBcomPassed(boolean bcomPassed) {
		this.bcomPassed = bcomPassed;
	}

	public boolean isOneYearExpAsAccountant() {
		return oneYearExpAsAccountant;
	}

	public void setOneYearExpAsAccountant(boolean oneYearExpAsAccountant) {
		this.oneYearExpAsAccountant = oneYearExpAsAccountant;
	}

	public boolean isbComOrBSCOrDiplomaHoldersInAutomobileOrMechanical() {
		return bComOrBSCOrDiplomaHoldersInAutomobileOrMechanical;
	}

	public void setbComOrBSCOrDiplomaHoldersInAutomobileOrMechanical(
			boolean bComOrBSCOrDiplomaHoldersInAutomobileOrMechanical) {
		this.bComOrBSCOrDiplomaHoldersInAutomobileOrMechanical = bComOrBSCOrDiplomaHoldersInAutomobileOrMechanical;
	}

	public boolean isFireSafetyDegreeFromAffiliatedInstitute() {
		return fireSafetyDegreeFromAffiliatedInstitute;
	}

	public void setFireSafetyDegreeFromAffiliatedInstitute(boolean fireSafetyDegreeFromAffiliatedInstitute) {
		this.fireSafetyDegreeFromAffiliatedInstitute = fireSafetyDegreeFromAffiliatedInstitute;
	}

	public String getFireAndSafetyDegreeName() {
		return fireAndSafetyDegreeName;
	}

	public void setFireAndSafetyDegreeName(String fireAndSafetyDegreeName) {
		this.fireAndSafetyDegreeName = fireAndSafetyDegreeName;
	}

	public String getFireAndSafetyUniversityName() {
		return fireAndSafetyUniversityName;
	}

	public void setFireAndSafetyUniversityName(String fireAndSafetyUniversityName) {
		this.fireAndSafetyUniversityName = fireAndSafetyUniversityName;
	}

	public boolean isQualificationForMilitaryForce() {
		return qualificationForMilitaryForce;
	}

	public void setQualificationForMilitaryForce(boolean qualificationForMilitaryForce) {
		this.qualificationForMilitaryForce = qualificationForMilitaryForce;
	}

	public String getMiltaryForceDegreeName() {
		return miltaryForceDegreeName;
	}

	public void setMiltaryForceDegreeName(String miltaryForceDegreeName) {
		this.miltaryForceDegreeName = miltaryForceDegreeName;
	}

	public String getMiltaryForceUniversityName() {
		return miltaryForceUniversityName;
	}

	public void setMiltaryForceUniversityName(String miltaryForceUniversityName) {
		this.miltaryForceUniversityName = miltaryForceUniversityName;
	}

	public float getRequiredQualificationMarks() {
		return requiredQualificationMarks;
	}

	public void setRequiredQualificationMarks(float requiredQualificationMarks) {
		this.requiredQualificationMarks = requiredQualificationMarks;
	}

	public Long getOtherQualification() {
		return otherQualification;
	}

	public void setOtherQualification(Long otherQualification) {
		this.otherQualification = otherQualification;
	}

	public Long getHighestQualification() {
		return highestQualification;
	}

	public void setHighestQualification(Long highestQualificationId) {
		this.highestQualification = highestQualificationId;
	}

	public String getHighestQualificationTitle() {
		return highestQualificationTitle;
	}

	public void setHighestQualificationTitle(String highestQualification) {
		this.highestQualificationTitle = highestQualification;
	}

	public Boolean getChildOfFarmerWhoCommittedSuicide() {
		return childOfFarmerWhoCommittedSuicide;
	}
	

	public void setChildOfFarmerWhoCommittedSuicide(
			Boolean childOfFarmerWhoCommittedSuicide) {
		this.childOfFarmerWhoCommittedSuicide = childOfFarmerWhoCommittedSuicide;
	}

	public String getInstituteName() {
		return instituteName;
	}

	public void setInstituteName(String instituteName) {
		this.instituteName = instituteName;
	}

	public long getWorkExp() {
		return workExp;
	}

	public void setWorkExp(long workExp) {
		this.workExp = workExp;
	}

	public String getPostName() {
		return postName;
	}

	public void setPostName(String postName) {
		this.postName = postName;
	}

	public Long getDcDivisionId() {
		return dcDivisionId;
	}

	public void setDcDivisionId(Long dcDivisionId) {
		this.dcDivisionId = dcDivisionId;
	}

	public String getDcDivisionName() {
		return dcDivisionName;
	}

	public void setDcDivisionName(String dcDivisionName) {
		this.dcDivisionName = dcDivisionName;
	}

	public String getCertificateNumber() {
		return certificateNumber;
	}

	public void setCertificateNumber(String certificateNumber) {
		this.certificateNumber = certificateNumber;
	}

	public Integer getAllocatedCategory() {
		return allocatedCategory;
	}

	public void setAllocatedCategory(Integer allocatedCategory) {
		this.allocatedCategory = allocatedCategory;
	}
	
	 public String getWorkExperience() {
			return workExperience;
		}

		public void setWorkExperience(String workExperience) {
			this.workExperience = workExperience;
		}

		public Integer getPostGradDegreeTypeId() {
			return postGradDegreeTypeId;
		}

		public void setPostGradDegreeTypeId(Integer postGradDegreeTypeId) {
			this.postGradDegreeTypeId = postGradDegreeTypeId;
		}

		public String getPostGradDegreeInstituteName() {
			return postGradDegreeInstituteName;
		}

		public void setPostGradDegreeInstituteName(String postGradDegreeInstituteName) {
			this.postGradDegreeInstituteName = postGradDegreeInstituteName;
		}

		public String getPostGradDegreeName() {
			return postGradDegreeName;
		}

		public void setPostGradDegreeName(String postGradDegreeName) {
			this.postGradDegreeName = postGradDegreeName;
		}

		public boolean isDroughtAffected() {
			return droughtAffected;
		}

		public void setDroughtAffected(boolean droughtAffected) {
			this.droughtAffected = droughtAffected;
		}

		public boolean isOrphanedPerson() {
			return orphanedPerson;
		}

		public void setOrphanedPerson(boolean orphanedPerson) {
			this.orphanedPerson = orphanedPerson;
		}
	
}
