package com.msrtc.portal.applicant.domain;

import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name="applicant_post_assoc")
public class ApplicantPostAssoc implements Serializable{

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = -9197708550276428243L;

	@Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
	
	@Column(name="applicant_id")
    private Long applicantId;
	
    @Column(name="post_id")
    private long postId;

    @Transient
    private Post post;
    
    @Transient
    private Caste caste;
    
    @Transient
    private String admitCardUrl;
    
    @Transient
    private Applicant applicant;
    
    @Transient
    private String applicationId;
    
    @Transient
    private String showAdmitCard;
    
    @Transient
    private String firstName;
    
    @Transient
    private String emailAddress;

    @Transient
    private Division division;

	// Post field's

	@Column(name = "is_ssc_passed")
	private Boolean sscPassed;
	
	@Column(name = "required_qualification_marks")
	private float requiredQualificationMarks;

	@Column(name = "other_qualification_details")
	private String otherQualificationDetails;

	@Column(name = "is_night_blindness")
	private Boolean nightBlindness;

	@Column(name = "is_color_blindness")
	private Boolean colorBlindness;

	@Column(name = "is_vision_acuity")
	private Boolean visionAcuity;

	@Column(name = "is_differently_abled")
	private Boolean differentlyAbled;

	@Column(name = "is_blindness_and_low_vision")
	private Boolean blindnessAndLowVision;

	@Column(name = "is_deaf_and_mute")
	private Boolean deafAndMute;

	@Column(name = "is_locomotor_or_cerebral_palsy")
	private Boolean locomotorOrCerebralPalsy;

	@Column(name = "is_own_heavy_driving_license_number")
	private Boolean ownHeavyDrivingLicenseNumber;

	@Column(name = "heavy_driving_license_number")
	private String heavyDrivingLicenseNumber;

	@Column(name = "heavy_driving_license_issue_date")
	private LocalDate heavyDrivingLicenseIssueDate;

	@Column(name = "heavy_driving_license_end_date")
	private LocalDate heavyDrivingLicenseEndDate;

    @Column(name = "is_own_psv_batch_number")
    private Boolean ownPsvBatchNumber;

	@Column(name = "psv_batch_number")
	private String psvBatchNumber;

	@Column(name = "is_own_conductor_batch_number")
	private Boolean ownConductorBatchNumber;

	@Column(name = "conductor_batch_number")
	private String conductorBatchNumber;

	@Column(name = "conductor_batch_number_issue_date")
	private LocalDate conductorBatchNumberIssueDate;

	@Column(name = "conductor_batch_number_end_date")
	private LocalDate conductorBatchNumberEndDate;

    @Column(name = "is_experienced")
    private Boolean experienced;

	@Column(name = "is_min_three_yrs_exp")
	private Boolean minThreeYrsExp;

	@Column(name = "company_name")
	private String companyName;

	@Column(name = "total_experience_in_years")
	private String totalExperienceInYears;

    @Column(name = "total_experience_in_months")
    private String totalExperienceInMonths;

	@Column(name = "is_height_within_range")
	private Boolean heightWithinRange;

	@Column(name = "is_past_accidental_or_death_incident")
	private Boolean pastAccidentalOrDeathIncident;

	@Column(name = "past_accidental_or_death_incident_reason")
	private String pastAccidentalOrDeathIncidentReason;

	@Column(name = "division_id")
	private Integer divisionId;

	@Column(name="priority")
    private Integer priority;
	
	@Column(name = "is_guarantor_person_name_and_mobile_no")
	private Boolean guarantorPersonNameAndMobileNo;

	@Column(name = "guarantor_person_name")
	private String guarantorPersonName;

	@Column(name = "guarantor_person_mobile_number")
	private String guarantorPersonMobileNumber;

	@Column(name = "is_iti_passed")
	private Boolean itiPassed;

	@Column(name = "college_name")
	private String collegeName ;

	@Column(name = "is_graduate_from_affiliated_institute")
	private Boolean graduateFromAffiliatedInstitute;

    @Column(name = "is_mscit_or_doeacc_pass_certification")
    private Boolean mscitOrDoeaccPassCertification;

    @Column(name = "is_typing_exam_passed")
	private Boolean typingExamPassed;

    @Column(name = "trade_id")
    private Integer tradeId;
    
    /* General Manager (Information Technology) starts */
    @Column(name = "it_engineer")
    private Boolean itEngineer;

    @Column(name = "knowledge_of_sap_and_oracle")
    private Boolean knowledgeOfSapAndOracle;

    @Column(name = "min_ten_yrs_exp_as_it_project_manager ")
    private Boolean minTenYrsExpAsItProjectManager;

    /* General Manager (Information Technology) ends */

    @Column(name = "mba_from_government_affiliated_institute")
    private Boolean mbaFromGovernmentAffiliatedInstitute;

    @Column(name = "degree_name")
    private String degreeName;

    /*Accountant (Jr.) / Jr. Stock Verifier (Jr.)*/

    @Column(name = "bcom_passed")
    private Boolean bcomPassed;

    @Column(name = "university_name")
    private String universityName;

    @Column(name = "one_year_exp_as_accountant")
    private Boolean oneYearExpAsAccountant;

    @Column(name = "mscit_or_Gaccc")
    private Boolean mscitOrGaccc;

    @Column(name = "two_year_exp_as_transport_association")
    private Boolean twoYearExpAsTransportAssociation;

    @Column(name = "bcom_or_bsc_or_diploma_holders_in_automobile_or_mechanical")
    private Boolean bComOrBSCOrDiplomaHoldersInAutomobileOrMechanical;

    /* Store Keeper (Jr.) */
    
    @Column(name="one_year_exp_as_transport_association")
    private Boolean oneYearExpAsTransportAssociation;
    
    @Column(name="automobile_mechanical_engineering_degree")
    private Boolean automobileOrMechanicalEngDegree;
    
    @Column(name="one_year_exp_in_automobile_repairing")
    private Boolean oneYearExpInAutomobileRepairing;
    
    @CreatedDate
    @Column(name = "created_date", nullable = false)
    private LocalDateTime createdDate = LocalDateTime.now();

    @LastModifiedDate
    @Column(name = "last_modified_date", nullable = false)
    private LocalDateTime lastModifiedDate = LocalDateTime.now();
	
	@Column(name = "architect_engineering_degree")
	private Boolean architectEngineeringDegree;
    
    @Column(name = "electrical_engineering_degree")
	private Boolean electricalEngineeringDegree;
    
    @Column(name = "qualification_for_military_force")
    private Boolean qualificationForMilitaryForce;
    
    @Column(name = "miltary_force_degree_name")
    private String miltaryForceDegreeName;
    
    @Column(name = "military_force_university_name")
    private String miltaryForceUniversityName;
    
    @Column(name = "fire_safety_degree_from_affiliated_institute")
    private Boolean fireSafetyDegreeFromAffiliatedInstitute;
    
    @Column(name = "fire_and_safety_degree_name")
    private String fireAndSafetyDegreeName;
    
    @Column(name = "fire_and_safety_university_name")
    private String fireAndSafetyUniversityName;

    @Column(name="submitted_date")
    private LocalDate submittedDate;

    // Draftsman (Mechanics) (Jr.)

    @Column(name="diploma_in_autocad")
    private Boolean diplomaInAutocad;

    @Column(name="diploma_in_autocad_university_name")
    private String diplomaInAutocadUniversityName;

    @Column(name="autocad_certification_from_government")
    private Boolean autocadCertificationFromGovernment;

    @Column(name="autocad_certification_government_institute_name")
    private String autocadCertificationFromGovernmentInstituteName;

    @Column(name="experience_in_autocad")
    private Boolean experienceInAutocad;
    
    @Column(name="experience_letter_upload")
    private String experienceLetterUpload;

	@Column(name="txn_order_no")
	private String txnOrderNo;

    @Transient
    private Boolean ageValid;
    
    @Transient
    private Boolean ageInvalid;

	@Column(name = "status")
	private Long status;
	
	@Transient
	private String paymentMode;
	
	@Transient
	private int transactionStatus;
	
	@Transient
	private Boolean formDisableStatus;

	@Column(name="differently_abled_others")
	private Boolean differentlyAbledOthers;
	
	@Column(name="differently_abled_others_text", length=100)
	private String differentlyAbledOthersText;
	
	//Light motor vechile properties
	@Column(name="light_motor_vechicle")
	private Boolean lightMotorVechicle;
	
	@Column(name="light_motor_vechicle_license_no")
	private String lightMotorVechicleLicenseNo;
	
	@Column(name="light_motor_vechicle_issue_date")
	private LocalDate lightMotorVechicleIssueDate;

	@Column(name = "apprenticeship_in_msrtc")
	private Boolean apprenticeshipInMSRTC;
	
	@Column(name = "apprenticeship_in_msrtc_trade")
	private String apprenticeshipInMSRTCTrade;
	
	@Column(name = "apprenticeship_in_msrtc_year")
	private String apprenticeshipInMSRTCYear;

	@Column(name = "apprenticeship_in_msrtc_division")
	private String apprenticeshipInMSRTCDivision;
	
	@Column(name = "fifteen_year_exp_in_commerce")
    private Boolean fifteenYearExpInCommerce;

	@Column(name = "pdf_generated")
	private Boolean pdfGenerated;
	
	@Column(name="other_qualification")
	private Long otherQualification;

	@Column(name = "advt_no")
	private Integer advtNo;
	
	@Column(name="post_graduate_degree_science")
	private Boolean postGraduateDegreeScience;

	
	public Integer getAdvtNo() {
		return advtNo;
	}

	public void setAdvtNo(Integer advtNo) {
		this.advtNo = advtNo;
	}

	public Boolean getPdfGenerated() {
		return pdfGenerated;
	}

	public void setPdfGenerated(Boolean pdfGenerated) {
		this.pdfGenerated = pdfGenerated;
	}

	/*@Column(name="learning_license")
	private Boolean learningLicense;
	
	@Column(name="learning_license_no")
	private String learningLicenseNo;
	
	@Column(name="learning_license_issue_date")
	private LocalDate learningLicenseIssueDate;*/
	
	public String getTxnOrderNo() {
		return txnOrderNo;
	}

	public void setTxnOrderNo(String txnOrderNo) {
		this.txnOrderNo = txnOrderNo;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getApplicantId() {
		return applicantId;
	}

	public void setApplicantId(Long applicantId) {
		this.applicantId = applicantId;
	}

	public long getPostId() {
		return postId;
	}

	public void setPostId(long postId) {
		this.postId = postId;
	}

	public Post getPost() {
		return post;
	}

	public void setPost(Post post) {
		this.post = post;
	}

	public Caste getCaste() {
		return caste;
	}

	public void setCaste(Caste caste) {
		this.caste = caste;
	}

	public Applicant getApplicant() {
		return applicant;
	}

	public void setApplicant(Applicant applicant) {
		this.applicant = applicant;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getEmailAddress() {
		return emailAddress;
	}

	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}

	public Division getDivision() {
		return division;
	}

	public void setDivision(Division division) {
		this.division = division;
	}

	public Boolean getSscPassed() {
		return sscPassed;
	}

	public void setSscPassed(Boolean sscPassed) {
		this.sscPassed = sscPassed;
	}
	
	public float getRequiredQualificationMarks() {
		return requiredQualificationMarks;
	}

	public void setRequiredQualificationMarks(float requiredQualificationMarks) {
		this.requiredQualificationMarks = requiredQualificationMarks;
	}

	public String getOtherQualificationDetails() {
		return otherQualificationDetails;
	}

	public void setOtherQualificationDetails(String otherQualificationDetails) {
		this.otherQualificationDetails = otherQualificationDetails;
	}

	public Boolean getNightBlindness() {
		return nightBlindness;
	}

	public void setNightBlindness(Boolean nightBlindness) {
		this.nightBlindness = nightBlindness;
	}

	public Boolean getColorBlindness() {
		return colorBlindness;
	}

	public void setColorBlindness(Boolean colorBlindness) {
		this.colorBlindness = colorBlindness;
	}

	public Boolean getVisionAcuity() {
		return visionAcuity;
	}

	public void setVisionAcuity(Boolean visionAcuity) {
		this.visionAcuity = visionAcuity;
	}

	public Boolean getDifferentlyAbled() {
		return differentlyAbled;
	}

	public void setDifferentlyAbled(Boolean differentlyAbled) {
		this.differentlyAbled = differentlyAbled;
	}

	public Boolean getBlindnessAndLowVision() {
		return blindnessAndLowVision;
	}

	public void setBlindnessAndLowVision(Boolean blindnessAndLowVision) {
		this.blindnessAndLowVision = blindnessAndLowVision;
	}

	public Boolean getDeafAndMute() {
		return deafAndMute;
	}

	public void setDeafAndMute(Boolean deafAndMute) {
		this.deafAndMute = deafAndMute;
	}

	public Boolean getLocomotorOrCerebralPalsy() {
		return locomotorOrCerebralPalsy;
	}

	public void setLocomotorOrCerebralPalsy(Boolean locomotorOrCerebralPalsy) {
		this.locomotorOrCerebralPalsy = locomotorOrCerebralPalsy;
	}

	public Boolean getOwnHeavyDrivingLicenseNumber() {
		return ownHeavyDrivingLicenseNumber;
	}

	public void setOwnHeavyDrivingLicenseNumber(Boolean ownHeavyDrivingLicenseNumber) {
		this.ownHeavyDrivingLicenseNumber = ownHeavyDrivingLicenseNumber;
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

	public void setHeavyDrivingLicenseIssueDate(
			LocalDate heavyDrivingLicenseIssueDate) {
		this.heavyDrivingLicenseIssueDate = heavyDrivingLicenseIssueDate;
	}

	public LocalDate getHeavyDrivingLicenseEndDate() {
		return heavyDrivingLicenseEndDate;
	}

	public void setHeavyDrivingLicenseEndDate(LocalDate heavyDrivingLicenseEndDate) {
		this.heavyDrivingLicenseEndDate = heavyDrivingLicenseEndDate;
	}

	public Boolean getOwnPsvBatchNumber() {
		return ownPsvBatchNumber;
	}

	public void setOwnPsvBatchNumber(Boolean ownPsvBatchNumber) {
		this.ownPsvBatchNumber = ownPsvBatchNumber;
	}

	public String getPsvBatchNumber() {
		return psvBatchNumber;
	}

	public void setPsvBatchNumber(String psvBatchNumber) {
		this.psvBatchNumber = psvBatchNumber;
	}

	public Boolean getOwnConductorBatchNumber() {
		return ownConductorBatchNumber;
	}

	public void setOwnConductorBatchNumber(Boolean ownConductorBatchNumber) {
		this.ownConductorBatchNumber = ownConductorBatchNumber;
	}

	public String getConductorBatchNumber() {
		return conductorBatchNumber;
	}

	public void setConductorBatchNumber(String conductorBatchNumber) {
		this.conductorBatchNumber = conductorBatchNumber;
	}

	public LocalDate getConductorBatchNumberIssueDate() {
		return conductorBatchNumberIssueDate;
	}

	public void setConductorBatchNumberIssueDate(
			LocalDate conductorBatchNumberIssueDate) {
		this.conductorBatchNumberIssueDate = conductorBatchNumberIssueDate;
	}

	public LocalDate getConductorBatchNumberEndDate() {
		return conductorBatchNumberEndDate;
	}

	public void setConductorBatchNumberEndDate(LocalDate conductorBatchNumberEndDate) {
		this.conductorBatchNumberEndDate = conductorBatchNumberEndDate;
	}

	public Boolean getExperienced() {
		return experienced;
	}

	public void setExperienced(Boolean experienced) {
		this.experienced = experienced;
	}

	public Boolean getMinThreeYrsExp() {
		return minThreeYrsExp;
	}

	public void setMinThreeYrsExp(Boolean minThreeYrsExp) {
		this.minThreeYrsExp = minThreeYrsExp;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getTotalExperienceInYears() {
		return totalExperienceInYears;
	}

	public void setTotalExperienceInYears(String totalExperienceInYears) {
		this.totalExperienceInYears = totalExperienceInYears;
	}

	public String getTotalExperienceInMonths() {
		return totalExperienceInMonths;
	}

	public void setTotalExperienceInMonths(String totalExperienceInMonths) {
		this.totalExperienceInMonths = totalExperienceInMonths;
	}

	public Boolean getHeightWithinRange() {
		return heightWithinRange;
	}

	public void setHeightWithinRange(Boolean heightWithinRange) {
		this.heightWithinRange = heightWithinRange;
	}

	public Boolean getPastAccidentalOrDeathIncident() {
		return pastAccidentalOrDeathIncident;
	}

	public void setPastAccidentalOrDeathIncident(
			Boolean pastAccidentalOrDeathIncident) {
		this.pastAccidentalOrDeathIncident = pastAccidentalOrDeathIncident;
	}

	public String getPastAccidentalOrDeathIncidentReason() {
		return pastAccidentalOrDeathIncidentReason;
	}

	public void setPastAccidentalOrDeathIncidentReason(
			String pastAccidentalOrDeathIncidentReason) {
		this.pastAccidentalOrDeathIncidentReason = pastAccidentalOrDeathIncidentReason;
	}

	public Integer getDivisionId() {
		return divisionId;
	}

	public void setDivisionId(Integer divisionId) {
		this.divisionId = divisionId;
	}

	public Integer getPriority() {
		return priority;
	}

	public void setPriority(Integer priority) {
		this.priority = priority;
	}

	public Boolean getGuarantorPersonNameAndMobileNo() {
		return guarantorPersonNameAndMobileNo;
	}

	public void setGuarantorPersonNameAndMobileNo(
			Boolean guarantorPersonNameAndMobileNo) {
		this.guarantorPersonNameAndMobileNo = guarantorPersonNameAndMobileNo;
	}

	public String getGuarantorPersonName() {
		return guarantorPersonName;
	}

	public void setGuarantorPersonName(String guarantorPersonName) {
		this.guarantorPersonName = guarantorPersonName;
	}

	public String getGuarantorPersonMobileNumber() {
		return guarantorPersonMobileNumber;
	}

	public void setGuarantorPersonMobileNumber(String guarantorPersonMobileNumber) {
		this.guarantorPersonMobileNumber = guarantorPersonMobileNumber;
	}

	public Boolean getItiPassed() {
		return itiPassed;
	}

	public void setItiPassed(Boolean itiPassed) {
		this.itiPassed = itiPassed;
	}

	public String getCollegeName() {
		return collegeName;
	}

	public void setCollegeName(String collegeName) {
		this.collegeName = collegeName;
	}

	public Boolean getGraduateFromAffiliatedInstitute() {
		return graduateFromAffiliatedInstitute;
	}

	public void setGraduateFromAffiliatedInstitute(
			Boolean graduateFromAffiliatedInstitute) {
		this.graduateFromAffiliatedInstitute = graduateFromAffiliatedInstitute;
	}

	public Boolean getMscitOrDoeaccPassCertification() {
		return mscitOrDoeaccPassCertification;
	}

	public void setMscitOrDoeaccPassCertification(
			Boolean mscitOrDoeaccPassCertification) {
		this.mscitOrDoeaccPassCertification = mscitOrDoeaccPassCertification;
	}

	public Boolean getTypingExamPassed() {
		return typingExamPassed;
	}

	public void setTypingExamPassed(Boolean typingExamPassed) {
		this.typingExamPassed = typingExamPassed;
	}

	public Integer getTradeId() {
		return tradeId;
	}

	public void setTradeId(Integer tradeId) {
		this.tradeId = tradeId;
	}

	public Boolean getItEngineer() {
		return itEngineer;
	}

	public void setItEngineer(Boolean itEngineer) {
		this.itEngineer = itEngineer;
	}

	public Boolean getKnowledgeOfSapAndOracle() {
		return knowledgeOfSapAndOracle;
	}

	public void setKnowledgeOfSapAndOracle(Boolean knowledgeOfSapAndOracle) {
		this.knowledgeOfSapAndOracle = knowledgeOfSapAndOracle;
	}

	public Boolean getMinTenYrsExpAsItProjectManager() {
		return minTenYrsExpAsItProjectManager;
	}

	public void setMinTenYrsExpAsItProjectManager(
			Boolean minTenYrsExpAsItProjectManager) {
		this.minTenYrsExpAsItProjectManager = minTenYrsExpAsItProjectManager;
	}

	public Boolean getMbaFromGovernmentAffiliatedInstitute() {
		return mbaFromGovernmentAffiliatedInstitute;
	}

	public void setMbaFromGovernmentAffiliatedInstitute(
			Boolean mbaFromGovernmentAffiliatedInstitute) {
		this.mbaFromGovernmentAffiliatedInstitute = mbaFromGovernmentAffiliatedInstitute;
	}

	public String getDegreeName() {
		return degreeName;
	}

	public void setDegreeName(String degreeName) {
		this.degreeName = degreeName;
	}

	public Boolean getBcomPassed() {
		return bcomPassed;
	}

	public void setBcomPassed(Boolean bcomPassed) {
		this.bcomPassed = bcomPassed;
	}

	public String getUniversityName() {
		return universityName;
	}

	public void setUniversityName(String universityName) {
		this.universityName = universityName;
	}

	public Boolean getOneYearExpAsAccountant() {
		return oneYearExpAsAccountant;
	}

	public void setOneYearExpAsAccountant(Boolean oneYearExpAsAccountant) {
		this.oneYearExpAsAccountant = oneYearExpAsAccountant;
	}

	public Boolean getMscitOrGaccc() {
		return mscitOrGaccc;
	}

	public void setMscitOrGaccc(Boolean mscitOrGaccc) {
		this.mscitOrGaccc = mscitOrGaccc;
	}

	public Boolean getTwoYearExpAsTransportAssociation() {
		return twoYearExpAsTransportAssociation;
	}

	public void setTwoYearExpAsTransportAssociation(
			Boolean twoYearExpAsTransportAssociation) {
		this.twoYearExpAsTransportAssociation = twoYearExpAsTransportAssociation;
	}

	public Boolean getbComOrBSCOrDiplomaHoldersInAutomobileOrMechanical() {
		return bComOrBSCOrDiplomaHoldersInAutomobileOrMechanical;
	}

	public void setbComOrBSCOrDiplomaHoldersInAutomobileOrMechanical(
			Boolean bComOrBSCOrDiplomaHoldersInAutomobileOrMechanical) {
		this.bComOrBSCOrDiplomaHoldersInAutomobileOrMechanical = bComOrBSCOrDiplomaHoldersInAutomobileOrMechanical;
	}

	public Boolean getOneYearExpAsTransportAssociation() {
		return oneYearExpAsTransportAssociation;
	}

	public void setOneYearExpAsTransportAssociation(
			Boolean oneYearExpAsTransportAssociation) {
		this.oneYearExpAsTransportAssociation = oneYearExpAsTransportAssociation;
	}

	public Boolean getAutomobileOrMechanicalEngDegree() {
		return automobileOrMechanicalEngDegree;
	}

	public void setAutomobileOrMechanicalEngDegree(
			Boolean automobileOrMechanicalEngDegree) {
		this.automobileOrMechanicalEngDegree = automobileOrMechanicalEngDegree;
	}

	public Boolean getOneYearExpInAutomobileRepairing() {
		return oneYearExpInAutomobileRepairing;
	}

	public void setOneYearExpInAutomobileRepairing(
			Boolean oneYearExpInAutomobileRepairing) {
		this.oneYearExpInAutomobileRepairing = oneYearExpInAutomobileRepairing;
	}

	public LocalDateTime getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(LocalDateTime createdDate) {
		this.createdDate = createdDate;
	}

	public LocalDateTime getLastModifiedDate() {
		return lastModifiedDate;
	}

	public void setLastModifiedDate(LocalDateTime lastModifiedDate) {
		this.lastModifiedDate = lastModifiedDate;
	}

	public Boolean getArchitectEngineeringDegree() {
		return architectEngineeringDegree;
	}

	public void setArchitectEngineeringDegree(Boolean architectEngineeringDegree) {
		this.architectEngineeringDegree = architectEngineeringDegree;
	}

	public Boolean getElectricalEngineeringDegree() {
		return electricalEngineeringDegree;
	}

	public void setElectricalEngineeringDegree(Boolean electricalEngineeringDegree) {
		this.electricalEngineeringDegree = electricalEngineeringDegree;
	}

	public Boolean getQualificationForMilitaryForce() {
		return qualificationForMilitaryForce;
	}

	public void setQualificationForMilitaryForce(
			Boolean qualificationForMilitaryForce) {
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

	public Boolean getFireSafetyDegreeFromAffiliatedInstitute() {
		return fireSafetyDegreeFromAffiliatedInstitute;
	}

	public void setFireSafetyDegreeFromAffiliatedInstitute(
			Boolean fireSafetyDegreeFromAffiliatedInstitute) {
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

	public LocalDate getSubmittedDate() {
		return submittedDate;
	}

	public void setSubmittedDate(LocalDate submittedDate) {
		this.submittedDate = submittedDate;
	}

	public Boolean getDiplomaInAutocad() {
		return diplomaInAutocad;
	}

	public void setDiplomaInAutocad(Boolean diplomaInAutocad) {
		this.diplomaInAutocad = diplomaInAutocad;
	}

	public String getDiplomaInAutocadUniversityName() {
		return diplomaInAutocadUniversityName;
	}

	public void setDiplomaInAutocadUniversityName(
			String diplomaInAutocadUniversityName) {
		this.diplomaInAutocadUniversityName = diplomaInAutocadUniversityName;
	}

	public Boolean getAutocadCertificationFromGovernment() {
		return autocadCertificationFromGovernment;
	}

	public void setAutocadCertificationFromGovernment(
			Boolean autocadCertificationFromGovernment) {
		this.autocadCertificationFromGovernment = autocadCertificationFromGovernment;
	}

	public String getAutocadCertificationFromGovernmentInstituteName() {
		return autocadCertificationFromGovernmentInstituteName;
	}

	public void setAutocadCertificationFromGovernmentInstituteName(
			String autocadCertificationFromGovernmentInstituteName) {
		this.autocadCertificationFromGovernmentInstituteName = autocadCertificationFromGovernmentInstituteName;
	}

	public Boolean getExperienceInAutocad() {
		return experienceInAutocad;
	}

	public void setExperienceInAutocad(Boolean experienceInAutocad) {
		this.experienceInAutocad = experienceInAutocad;
	}

	public Boolean getAgeValid() {
		return ageValid;
	}

	public void setAgeValid(Boolean ageValid) {
		this.ageValid = ageValid;
	}

	public Long getStatus() {
		return status;
	}

	public void setStatus(Long status) {
		this.status = status;
	}

	public String getExperienceLetterUpload() {
		return experienceLetterUpload;
	}

	public void setExperienceLetterUpload(String experienceLetterUpload) {
		this.experienceLetterUpload = experienceLetterUpload;
	}

	public String getPaymentMode() {
		return paymentMode;
	}

	public void setPaymentMode(String paymentMode) {
		this.paymentMode = paymentMode;
	}

	public int getTransactionStatus() {
		return transactionStatus;
	}

	public void setTransactionStatus(int transactionStatus) {
		this.transactionStatus = transactionStatus;
	}

	public Boolean getFormDisableStatus() {
		return formDisableStatus;
	}

	public void setFormDisableStatus(Boolean formDisableStatus) {
		this.formDisableStatus = formDisableStatus;
	}

	public Boolean getDifferentlyAbledOthers() {
		return differentlyAbledOthers;
	}

	public void setDifferentlyAbledOthers(Boolean differentlyAbledOthers) {
		this.differentlyAbledOthers = differentlyAbledOthers;
	}

	public String getDifferentlyAbledOthersText() {
		return differentlyAbledOthersText;
	}

	public void setDifferentlyAbledOthersText(String differentlyAbledOthersText) {
		this.differentlyAbledOthersText = differentlyAbledOthersText;
	}

	public Boolean getLightMotorVechicle() {
		return lightMotorVechicle;
	}

	public void setLightMotorVechicle(Boolean lightMotorVechicle) {
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

	/*public String getLightMotorVechicleRTONo() {
		return lightMotorVechicleRTONo;
	}

	public void setLightMotorVechicleRTONo(String lightMotorVechicleRTONo) {
		this.lightMotorVechicleRTONo = lightMotorVechicleRTONo;
	}*/

	public Boolean getApprenticeshipInMSRTC() {
		return apprenticeshipInMSRTC;
	}

	public void setApprenticeshipInMSRTC(Boolean apprenticeshipInMSRTC) {
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

	public void setApprenticeshipInMSRTCDivision(
			String apprenticeshipInMSRTCDivision) {
		this.apprenticeshipInMSRTCDivision = apprenticeshipInMSRTCDivision;
	}

	public Boolean getFifteenYearExpInCommerce() {
		return fifteenYearExpInCommerce;
	}
	
	public void setFifteenYearExpInCommerce(Boolean fifteenYearExpInCommerce) {
		this.fifteenYearExpInCommerce = fifteenYearExpInCommerce;
	}
	
	/*public Boolean getLearningLicense() {
		return learningLicense;
	}

	public void setLearningLicense(Boolean learningLicense) {
		this.learningLicense = learningLicense;
	}

	public String getLearningLicenseNo() {
		return learningLicenseNo;
	}

	public void setLearningLicenseNo(String learningLicenseNo) {
		this.learningLicenseNo = learningLicenseNo;
	}

	public LocalDate getLearningLicenseIssueDate() {
		return learningLicenseIssueDate;
	}

	public void setLearningLicenseIssueDate(LocalDate learningLicenseIssueDate) {
		this.learningLicenseIssueDate = learningLicenseIssueDate;
	}*/

	public Boolean getAgeInvalid() {
		return ageInvalid;
	}

	public void setAgeInvalid(Boolean ageInvalid) {
		this.ageInvalid = ageInvalid;
	}

	public String getAdmitCardUrl() {
		return admitCardUrl;
	}

	public void setAdmitCardUrl(String admitCardUrl) {
		this.admitCardUrl = admitCardUrl;
	}

	public String getApplicationId() {
		return applicationId;
	}

	public void setApplicationId(String applicationId) {
		this.applicationId = applicationId;
	}

	public Long getOtherQualification() {
		return otherQualification;
	}

	public void setOtherQualification(Long otherQualification) {
		this.otherQualification = otherQualification;
	}

	public String getShowAdmitCard() {
		return showAdmitCard;
	}

	public void setShowAdmitCard(String showAdmitCard) {
		this.showAdmitCard = showAdmitCard;
	}

	@Column(name="grad_or_post_grad")
	private Integer gradOrPostGrad;

	@Column(name = "institute_name")
	private String instituteName;

	@Column(name = "work_exp")
	private Integer workExp;

	@Column(name = "post_name")
	private String postName;

	@Column(name = "dc_division_id")
	private Integer dcDivisionId;
	
	@Column(name="post_grad_degree_type_id")
	private Integer postGradDegreeTypeId;
	
	@Column(name="post_grad_degree_institute_name")
	private String postGradDegreeInstituteName;
	
	@Column(name="post_graduate_degree_name")
	private String postGraduateDegreeName;

	@Column(name="post_graduate_marks")
	private float postGraduateMarks;
	
	@Column(name="management_experience")
	private Boolean managementExperience;
	
	@Column(name="is_large_office_and_large_staff_members")
	private Boolean isLargeOfficeAndLargeStaffMembers;
	
	@Column(name="knowledge_board_meetings_acts")
	private Boolean knowledgeBoardMeetingsActs;
	
	@Column(name = "is_second_class_in_mba")
	private Boolean isSecondClassInMBA;
	
	@Column(name = "mba_degree_name")
	private String mbaDegreeName;

	@Column(name = "mba_university")
	private String mbaUniversity;

	@Column(name = "mba_marks")
	private float mbaMarks;

	@Column(name = "is_icwa_diploma")
	private Boolean isIcwaDiploma;

	@Column(name = "icwa_diploma_name")
	private String icwaDiplomaName;

	@Column(name = "icwa_university_name")
	private String icwaUniversityName;

	@Column(name = "icwa_marks")
	private float icwaMarks;
	
	@Column(name = "is_first_class_degree")
	private Boolean isFirstClassDegree;
	
	public Boolean getKnowledgeBoardMeetingsActs() {
		return knowledgeBoardMeetingsActs;
	}

	public void setKnowledgeBoardMeetingsActs(Boolean knowledgeBoardMeetingsActs) {
		this.knowledgeBoardMeetingsActs = knowledgeBoardMeetingsActs;
	}

	public Boolean getIsLargeOfficeAndLargeStaffMembers() {
		return isLargeOfficeAndLargeStaffMembers;
	}

	public void setIsLargeOfficeAndLargeStaffMembers(
			Boolean isLargeOfficeAndLargeStaffMembers) {
		this.isLargeOfficeAndLargeStaffMembers = isLargeOfficeAndLargeStaffMembers;
	}

	public Boolean getManagementExperience() {
		return managementExperience;
	}

	public void setManagementExperience(Boolean managementExperience) {
		this.managementExperience = managementExperience;
	}

	public String getPostGraduateDegreeName() {
		return postGraduateDegreeName;
	}

	public void setPostGraduateDegreeName(String postGraduateDegreeName) {
		this.postGraduateDegreeName = postGraduateDegreeName;
	}

	public float getPostGraduateMarks() {
		return postGraduateMarks;
	}

	public void setPostGraduateMarks(float postGraduateMarks) {
		this.postGraduateMarks = postGraduateMarks;
	}

	public Integer getGradOrPostGrad() {
		return gradOrPostGrad;
	}

	public void setGradOrPostGrad(Integer gradOrPostGrad) {
		this.gradOrPostGrad = gradOrPostGrad;
	}

	public String getInstituteName() {
		return instituteName;
	}

	public void setInstituteName(String instituteName) {
		this.instituteName = instituteName;
	}

	public Integer getWorkExp() {
		return workExp;
	}

	public void setWorkExp(Integer workExp) {
		this.workExp = workExp;
	}

	public String getPostName() {
		return postName;
	}

	public void setPostName(String postName) {
		this.postName = postName;
	}

	public Integer getDcDivisionId() {
		return dcDivisionId;
	}

	public void setDcDivisionId(Integer dcDivisionId) {
		this.dcDivisionId = dcDivisionId;
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

	public Boolean getIsSecondClassInMBA() {
		return isSecondClassInMBA;
	}

	public void setIsSecondClassInMBA(Boolean isSecondClassInMBA) {
		this.isSecondClassInMBA = isSecondClassInMBA;
	}

	public String getMbaDegreeName() {
		return mbaDegreeName;
	}

	public void setMbaDegreeName(String mbaDegreeName) {
		this.mbaDegreeName = mbaDegreeName;
	}

	public String getMbaUniversity() {
		return mbaUniversity;
	}

	public void setMbaUniversity(String mbaUniversity) {
		this.mbaUniversity = mbaUniversity;
	}

	public float getMbaMarks() {
		return mbaMarks;
	}

	public void setMbaMarks(float mbaMarks) {
		this.mbaMarks = mbaMarks;
	}

	public Boolean getIsIcwaDiploma() {
		return isIcwaDiploma;
	}

	public void setIsIcwaDiploma(Boolean isIcwaDiploma) {
		this.isIcwaDiploma = isIcwaDiploma;
	}

	public String getIcwaDiplomaName() {
		return icwaDiplomaName;
	}

	public void setIcwaDiplomaName(String icwaDiplomaName) {
		this.icwaDiplomaName = icwaDiplomaName;
	}

	public String getIcwaUniversityName() {
		return icwaUniversityName;
	}

	public void setIcwaUniversityName(String icwaUniversityName) {
		this.icwaUniversityName = icwaUniversityName;
	}

	public float getIcwaMarks() {
		return icwaMarks;
	}

	public void setIcwaMarks(float icwaMarks) {
		this.icwaMarks = icwaMarks;
	}

	public Boolean getIsFirstClassDegree() {
		return isFirstClassDegree;
	}

	public void setIsFirstClassDegree(Boolean isFirstClassDegree) {
		this.isFirstClassDegree = isFirstClassDegree;
	}

	public Boolean getPostGraduateDegreeScience() {
		return postGraduateDegreeScience;
	}

	public void setPostGraduateDegreeScience(Boolean postGraduateDegreeScience) {
		this.postGraduateDegreeScience = postGraduateDegreeScience;
	}
	
	@Transient
	private boolean disableForm = false;

	public boolean isDisableForm() {
		return disableForm;
	}

	public void setDisableForm(boolean disableForm) {
		this.disableForm = disableForm;
	}
	
	@Column(name = "organisation_time_from")
	private LocalDate organisationTimeFrom;
	
	@Column(name = "organisation_time_to")
	private LocalDate organisationTimeTo;


	public LocalDate getOrganisationTimeFrom() {
		return organisationTimeFrom;
	}

	public void setOrganisationTimeFrom(LocalDate organisationTimeFrom) {
		this.organisationTimeFrom = organisationTimeFrom;
	}

	public LocalDate getOrganisationTimeTo() {
		return organisationTimeTo;
	}

	public void setOrganisationTimeTo(LocalDate organisationTimeTo) {
		this.organisationTimeTo = organisationTimeTo;
	}
	
	@Column(name="company_address")
	private String companyAddress;


	public String getCompanyAddress() {
		return companyAddress;
	}

	public void setCompanyAddress(String companyAddress) {
		this.companyAddress = companyAddress;
	}
	
}
