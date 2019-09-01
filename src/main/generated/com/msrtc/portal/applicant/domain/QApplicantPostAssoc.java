package com.msrtc.portal.applicant.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;


/**
 * QApplicantPostAssoc is a Querydsl query type for ApplicantPostAssoc
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QApplicantPostAssoc extends EntityPathBase<ApplicantPostAssoc> {

    private static final long serialVersionUID = 1609690415L;

    public static final QApplicantPostAssoc applicantPostAssoc = new QApplicantPostAssoc("applicantPostAssoc");

    public final NumberPath<Integer> advtNo = createNumber("advtNo", Integer.class);

    public final NumberPath<Long> applicantId = createNumber("applicantId", Long.class);

    public final BooleanPath apprenticeshipInMSRTC = createBoolean("apprenticeshipInMSRTC");

    public final StringPath apprenticeshipInMSRTCDivision = createString("apprenticeshipInMSRTCDivision");

    public final StringPath apprenticeshipInMSRTCTrade = createString("apprenticeshipInMSRTCTrade");

    public final StringPath apprenticeshipInMSRTCYear = createString("apprenticeshipInMSRTCYear");

    public final BooleanPath architectEngineeringDegree = createBoolean("architectEngineeringDegree");

    public final BooleanPath autocadCertificationFromGovernment = createBoolean("autocadCertificationFromGovernment");

    public final StringPath autocadCertificationFromGovernmentInstituteName = createString("autocadCertificationFromGovernmentInstituteName");

    public final BooleanPath automobileOrMechanicalEngDegree = createBoolean("automobileOrMechanicalEngDegree");

    public final BooleanPath bComOrBSCOrDiplomaHoldersInAutomobileOrMechanical = createBoolean("bComOrBSCOrDiplomaHoldersInAutomobileOrMechanical");

    public final BooleanPath bcomPassed = createBoolean("bcomPassed");

    public final BooleanPath blindnessAndLowVision = createBoolean("blindnessAndLowVision");

    public final StringPath collegeName = createString("collegeName");

    public final BooleanPath colorBlindness = createBoolean("colorBlindness");

    public final StringPath companyAddress = createString("companyAddress");

    public final StringPath companyName = createString("companyName");

    public final StringPath conductorBatchNumber = createString("conductorBatchNumber");

    public final DatePath<java.time.LocalDate> conductorBatchNumberEndDate = createDate("conductorBatchNumberEndDate", java.time.LocalDate.class);

    public final DatePath<java.time.LocalDate> conductorBatchNumberIssueDate = createDate("conductorBatchNumberIssueDate", java.time.LocalDate.class);

    public final DateTimePath<java.time.LocalDateTime> createdDate = createDateTime("createdDate", java.time.LocalDateTime.class);

    public final NumberPath<Integer> dcDivisionId = createNumber("dcDivisionId", Integer.class);

    public final BooleanPath deafAndMute = createBoolean("deafAndMute");

    public final StringPath degreeName = createString("degreeName");

    public final BooleanPath differentlyAbled = createBoolean("differentlyAbled");

    public final BooleanPath differentlyAbledOthers = createBoolean("differentlyAbledOthers");

    public final StringPath differentlyAbledOthersText = createString("differentlyAbledOthersText");

    public final BooleanPath diplomaInAutocad = createBoolean("diplomaInAutocad");

    public final StringPath diplomaInAutocadUniversityName = createString("diplomaInAutocadUniversityName");

    public final NumberPath<Integer> divisionId = createNumber("divisionId", Integer.class);

    public final BooleanPath electricalEngineeringDegree = createBoolean("electricalEngineeringDegree");

    public final BooleanPath experienced = createBoolean("experienced");

    public final BooleanPath experienceInAutocad = createBoolean("experienceInAutocad");

    public final StringPath experienceLetterUpload = createString("experienceLetterUpload");

    public final BooleanPath fifteenYearExpInCommerce = createBoolean("fifteenYearExpInCommerce");

    public final StringPath fireAndSafetyDegreeName = createString("fireAndSafetyDegreeName");

    public final StringPath fireAndSafetyUniversityName = createString("fireAndSafetyUniversityName");

    public final BooleanPath fireSafetyDegreeFromAffiliatedInstitute = createBoolean("fireSafetyDegreeFromAffiliatedInstitute");

    public final NumberPath<Integer> gradOrPostGrad = createNumber("gradOrPostGrad", Integer.class);

    public final BooleanPath graduateFromAffiliatedInstitute = createBoolean("graduateFromAffiliatedInstitute");

    public final StringPath guarantorPersonMobileNumber = createString("guarantorPersonMobileNumber");

    public final StringPath guarantorPersonName = createString("guarantorPersonName");

    public final BooleanPath guarantorPersonNameAndMobileNo = createBoolean("guarantorPersonNameAndMobileNo");

    public final DatePath<java.time.LocalDate> heavyDrivingLicenseEndDate = createDate("heavyDrivingLicenseEndDate", java.time.LocalDate.class);

    public final DatePath<java.time.LocalDate> heavyDrivingLicenseIssueDate = createDate("heavyDrivingLicenseIssueDate", java.time.LocalDate.class);

    public final StringPath heavyDrivingLicenseNumber = createString("heavyDrivingLicenseNumber");

    public final BooleanPath heightWithinRange = createBoolean("heightWithinRange");

    public final StringPath icwaDiplomaName = createString("icwaDiplomaName");

    public final NumberPath<Float> icwaMarks = createNumber("icwaMarks", Float.class);

    public final StringPath icwaUniversityName = createString("icwaUniversityName");

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final StringPath instituteName = createString("instituteName");

    public final BooleanPath isFirstClassDegree = createBoolean("isFirstClassDegree");

    public final BooleanPath isIcwaDiploma = createBoolean("isIcwaDiploma");

    public final BooleanPath isLargeOfficeAndLargeStaffMembers = createBoolean("isLargeOfficeAndLargeStaffMembers");

    public final BooleanPath isSecondClassInMBA = createBoolean("isSecondClassInMBA");

    public final BooleanPath itEngineer = createBoolean("itEngineer");

    public final BooleanPath itiPassed = createBoolean("itiPassed");

    public final BooleanPath knowledgeBoardMeetingsActs = createBoolean("knowledgeBoardMeetingsActs");

    public final BooleanPath knowledgeOfSapAndOracle = createBoolean("knowledgeOfSapAndOracle");

    public final DateTimePath<java.time.LocalDateTime> lastModifiedDate = createDateTime("lastModifiedDate", java.time.LocalDateTime.class);

    public final BooleanPath lightMotorVechicle = createBoolean("lightMotorVechicle");

    public final DatePath<java.time.LocalDate> lightMotorVechicleIssueDate = createDate("lightMotorVechicleIssueDate", java.time.LocalDate.class);

    public final StringPath lightMotorVechicleLicenseNo = createString("lightMotorVechicleLicenseNo");

    public final BooleanPath locomotorOrCerebralPalsy = createBoolean("locomotorOrCerebralPalsy");

    public final BooleanPath managementExperience = createBoolean("managementExperience");

    public final StringPath mbaDegreeName = createString("mbaDegreeName");

    public final BooleanPath mbaFromGovernmentAffiliatedInstitute = createBoolean("mbaFromGovernmentAffiliatedInstitute");

    public final NumberPath<Float> mbaMarks = createNumber("mbaMarks", Float.class);

    public final StringPath mbaUniversity = createString("mbaUniversity");

    public final StringPath miltaryForceDegreeName = createString("miltaryForceDegreeName");

    public final StringPath miltaryForceUniversityName = createString("miltaryForceUniversityName");

    public final BooleanPath minTenYrsExpAsItProjectManager = createBoolean("minTenYrsExpAsItProjectManager");

    public final BooleanPath minThreeYrsExp = createBoolean("minThreeYrsExp");

    public final BooleanPath mscitOrDoeaccPassCertification = createBoolean("mscitOrDoeaccPassCertification");

    public final BooleanPath mscitOrGaccc = createBoolean("mscitOrGaccc");

    public final BooleanPath nightBlindness = createBoolean("nightBlindness");

    public final BooleanPath oneYearExpAsAccountant = createBoolean("oneYearExpAsAccountant");

    public final BooleanPath oneYearExpAsTransportAssociation = createBoolean("oneYearExpAsTransportAssociation");

    public final BooleanPath oneYearExpInAutomobileRepairing = createBoolean("oneYearExpInAutomobileRepairing");

    public final DatePath<java.time.LocalDate> organisationTimeFrom = createDate("organisationTimeFrom", java.time.LocalDate.class);

    public final DatePath<java.time.LocalDate> organisationTimeTo = createDate("organisationTimeTo", java.time.LocalDate.class);

    public final NumberPath<Long> otherQualification = createNumber("otherQualification", Long.class);

    public final StringPath otherQualificationDetails = createString("otherQualificationDetails");

    public final BooleanPath ownConductorBatchNumber = createBoolean("ownConductorBatchNumber");

    public final BooleanPath ownHeavyDrivingLicenseNumber = createBoolean("ownHeavyDrivingLicenseNumber");

    public final BooleanPath ownPsvBatchNumber = createBoolean("ownPsvBatchNumber");

    public final BooleanPath pastAccidentalOrDeathIncident = createBoolean("pastAccidentalOrDeathIncident");

    public final StringPath pastAccidentalOrDeathIncidentReason = createString("pastAccidentalOrDeathIncidentReason");

    public final BooleanPath pdfGenerated = createBoolean("pdfGenerated");

    public final StringPath postGradDegreeInstituteName = createString("postGradDegreeInstituteName");

    public final NumberPath<Integer> postGradDegreeTypeId = createNumber("postGradDegreeTypeId", Integer.class);

    public final StringPath postGraduateDegreeName = createString("postGraduateDegreeName");

    public final BooleanPath postGraduateDegreeScience = createBoolean("postGraduateDegreeScience");

    public final NumberPath<Float> postGraduateMarks = createNumber("postGraduateMarks", Float.class);

    public final NumberPath<Long> postId = createNumber("postId", Long.class);

    public final StringPath postName = createString("postName");

    public final NumberPath<Integer> priority = createNumber("priority", Integer.class);

    public final StringPath psvBatchNumber = createString("psvBatchNumber");

    public final BooleanPath qualificationForMilitaryForce = createBoolean("qualificationForMilitaryForce");

    public final NumberPath<Float> requiredQualificationMarks = createNumber("requiredQualificationMarks", Float.class);

    public final BooleanPath sscPassed = createBoolean("sscPassed");

    public final NumberPath<Long> status = createNumber("status", Long.class);

    public final DatePath<java.time.LocalDate> submittedDate = createDate("submittedDate", java.time.LocalDate.class);

    public final StringPath totalExperienceInMonths = createString("totalExperienceInMonths");

    public final StringPath totalExperienceInYears = createString("totalExperienceInYears");

    public final NumberPath<Integer> tradeId = createNumber("tradeId", Integer.class);

    public final BooleanPath twoYearExpAsTransportAssociation = createBoolean("twoYearExpAsTransportAssociation");

    public final StringPath txnOrderNo = createString("txnOrderNo");

    public final BooleanPath typingExamPassed = createBoolean("typingExamPassed");

    public final StringPath universityName = createString("universityName");

    public final BooleanPath visionAcuity = createBoolean("visionAcuity");

    public final NumberPath<Integer> workExp = createNumber("workExp", Integer.class);

    public QApplicantPostAssoc(String variable) {
        super(ApplicantPostAssoc.class, forVariable(variable));
    }

    public QApplicantPostAssoc(Path<? extends ApplicantPostAssoc> path) {
        super(path.getType(), path.getMetadata());
    }

    public QApplicantPostAssoc(PathMetadata metadata) {
        super(ApplicantPostAssoc.class, metadata);
    }

}

