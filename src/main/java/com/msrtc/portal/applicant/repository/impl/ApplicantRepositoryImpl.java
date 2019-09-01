package com.msrtc.portal.applicant.repository.impl;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.util.StringUtils;

import com.msrtc.portal.applicant.domain.Applicant;
import com.msrtc.portal.applicant.domain.QApplicant;
import com.msrtc.portal.applicant.dto.ApplicantSearchDTO;
import com.msrtc.portal.applicant.dto.UndertakingDTO;
import com.msrtc.portal.applicant.repository.ApplicantRepository;
import com.msrtc.portal.applicant.repository.ApplicantRepositoryCustom;
import com.msrtc.portal.core.common.util.PageDetail;
import com.msrtc.portal.core.common.util.PageQueryBuilder;
import com.querydsl.core.BooleanBuilder;

public class ApplicantRepositoryImpl implements ApplicantRepositoryCustom {

    @Autowired
    private ApplicantRepository applicantRepository;

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public Page<Applicant> searchApplicants(ApplicantSearchDTO applicantSearchDTO, Pageable pageable) {
        QApplicant applicant = QApplicant.applicant;

        BooleanBuilder queryBuilder = new BooleanBuilder();

        int searchType = applicantSearchDTO.getSearchType();

        if(searchType == 1){
            String searchText = applicantSearchDTO.getSearchText();
            if(!StringUtils.isEmpty(searchText)){
                queryBuilder.or(applicant.applicationId.containsIgnoreCase(searchText));
                queryBuilder.or(applicant.firstName.containsIgnoreCase(searchText));
                queryBuilder.or(applicant.middleName.containsIgnoreCase(searchText));
                queryBuilder.or(applicant.lastName.containsIgnoreCase(searchText));
                queryBuilder.or(applicant.address.containsIgnoreCase(searchText));
                queryBuilder.or(applicant.emailAddress.containsIgnoreCase(searchText));
                queryBuilder.or(applicant.password.containsIgnoreCase(searchText));
            }
        }

        return applicantRepository.findAll(queryBuilder.getValue(), pageable);
    }

    @SuppressWarnings("unchecked")
	@Override
    public List<UndertakingDTO> findApplicationDetailsByPostId(List<String> applicationIds, Long postId, PageDetail pageDetail) {
        final PageQueryBuilder pqb = new PageQueryBuilder();

        pqb.getSelectColumns().add("a.applicationId"); //1
        pqb.getSelectColumns().add("a.firstName"); //2
        pqb.getSelectColumns().add("a.middleName"); //3
        pqb.getSelectColumns().add("a.lastName"); //4
        pqb.getSelectColumns().add("a.firstNameMarathi"); //5
        pqb.getSelectColumns().add("a.middleNameMarathi"); //6
        pqb.getSelectColumns().add("a.lastNameMarathi"); //7
        pqb.getSelectColumns().add("a.birthDate"); //8
        pqb.getSelectColumns().add("a.gender"); //9
        pqb.getSelectColumns().add("a.address"); //10
        pqb.getSelectColumns().add("a.pinCode"); //11
        pqb.getSelectColumns().add("a.emailAddress"); //12
        pqb.getSelectColumns().add("a.mobileNumber"); //13
        
        pqb.getSelectColumns().add("a.districtId"); //14
        pqb.getSelectColumns().add("a.maritalStatus"); //15
        pqb.getSelectColumns().add("a.maharashtraDomiciled"); //16
        pqb.getSelectColumns().add("a.readWriteSpeakMarathi"); //17
        pqb.getSelectColumns().add("a.caste.id"); //18
        pqb.getSelectColumns().add("a.subcategory"); //19
        pqb.getSelectColumns().add("a.nonCreamyLayer"); //20
        pqb.getSelectColumns().add("a.certificateValidityEndingDate"); //21
        
        pqb.getSelectColumns().add("ao.earthQuakeEffected"); //22
        pqb.getSelectColumns().add("ao.projectEffected"); //23
        pqb.getSelectColumns().add("ao.exServiceMan"); //24
        pqb.getSelectColumns().add("ao.retirementDate"); //25
        pqb.getSelectColumns().add("ao.partTimeEmployee"); //26
        pqb.getSelectColumns().add("ao.sportsPerson"); //27
        pqb.getSelectColumns().add("ao.sportsLevel"); //28
        pqb.getSelectColumns().add("ao.stEmployee"); //29
       
        pqb.getSelectColumns().add("a.id"); //30
        
        pqb.getSelectColumns().add("ao.preferredCity1"); //31
        pqb.getSelectColumns().add("ao.preferredCity2"); //32
        pqb.getSelectColumns().add("ao.preferredCity3"); //33
        
        pqb.getSelectColumns().add("apa.sscPassed"); //34
        pqb.getSelectColumns().add("apa.otherQualificationDetails"); //35
        pqb.getSelectColumns().add("apa.nightBlindness"); //36
        pqb.getSelectColumns().add("apa.colorBlindness"); //37
        pqb.getSelectColumns().add("apa.visionAcuity"); //38
        pqb.getSelectColumns().add("apa.ownHeavyDrivingLicenseNumber"); //39
        pqb.getSelectColumns().add("apa.heavyDrivingLicenseNumber"); //40
        pqb.getSelectColumns().add("apa.heavyDrivingLicenseIssueDate"); //41
        pqb.getSelectColumns().add("apa.heavyDrivingLicenseEndDate"); //42
        pqb.getSelectColumns().add("apa.ownPsvBatchNumber"); //43
        pqb.getSelectColumns().add("apa.psvBatchNumber"); //44
        pqb.getSelectColumns().add("apa.ownConductorBatchNumber"); //45
        pqb.getSelectColumns().add("apa.conductorBatchNumber"); //46
        pqb.getSelectColumns().add("apa.conductorBatchNumberIssueDate"); //47
        pqb.getSelectColumns().add("apa.conductorBatchNumberEndDate"); //48
        pqb.getSelectColumns().add("apa.minThreeYrsExp"); //49
        pqb.getSelectColumns().add("apa.companyName"); //50
        pqb.getSelectColumns().add("apa.totalExperienceInYears"); //51
        pqb.getSelectColumns().add("apa.totalExperienceInMonths"); //52
        pqb.getSelectColumns().add("apa.guarantorPersonNameAndMobileNo"); //53
        pqb.getSelectColumns().add("apa.guarantorPersonName"); //54
        pqb.getSelectColumns().add("apa.guarantorPersonMobileNumber"); //55
        pqb.getSelectColumns().add("apa.heightWithinRange"); //56
        pqb.getSelectColumns().add("apa.pastAccidentalOrDeathIncident"); //57
        
        pqb.getSelectColumns().add("af.photoFileName"); //58
        pqb.getSelectColumns().add("af.signatureFileName"); //59
        
        pqb.getSelectColumns().add("apa.divisionId"); //60
        
        pqb.getSelectColumns().add("ao.exServicemanTotalExperienceInYears"); //61
        pqb.getSelectColumns().add("ao.exServicemanTotalExperienceInMonths"); //62
        pqb.getSelectColumns().add("ao.partTimeEmployeeTotalExperienceInYears"); //63
        pqb.getSelectColumns().add("ao.partTimeEmployeeTotalExperienceInMonths"); //64
        
        pqb.getSelectColumns().add("apa.itiPassed"); //65
        pqb.getSelectColumns().add("apa.tradeId"); //66
        pqb.getSelectColumns().add("apa.lightMotorVechicle"); //67
        pqb.getSelectColumns().add("apa.lightMotorVechicleLicenseNo"); //68
        pqb.getSelectColumns().add("apa.lightMotorVechicleIssueDate"); //69
        pqb.getSelectColumns().add("apa.apprenticeshipInMSRTC"); //70
        pqb.getSelectColumns().add("apa.apprenticeshipInMSRTCTrade"); //71
        pqb.getSelectColumns().add("apa.apprenticeshipInMSRTCYear"); //72
        pqb.getSelectColumns().add("apa.apprenticeshipInMSRTCDivision"); //73
        pqb.getSelectColumns().add("apa.experienced"); //74
        
        pqb.getSelectColumns().add("apa.itEngineer"); //75
        pqb.getSelectColumns().add("apa.degreeName"); //76
        pqb.getSelectColumns().add("apa.universityName"); //77
        
        pqb.getSelectColumns().add("apa.automobileOrMechanicalEngDegree"); //78
        
        pqb.getSelectColumns().add("apa.oneYearExpInAutomobileRepairing"); //79
        
        pqb.getSelectColumns().add("apa.electricalEngineeringDegree"); //80
        
        pqb.getSelectColumns().add("apa.differentlyAbled"); //81
        
        pqb.getSelectColumns().add("apa.locomotorOrCerebralPalsy"); //82
        pqb.getSelectColumns().add("apa.architectEngineeringDegree"); //83
        
        pqb.getSelectColumns().add("apa.blindnessAndLowVision"); //84
        pqb.getSelectColumns().add("apa.deafAndMute"); //85
        pqb.getSelectColumns().add("apa.graduateFromAffiliatedInstitute"); //86
        pqb.getSelectColumns().add("apa.mscitOrDoeaccPassCertification"); //87
        pqb.getSelectColumns().add("apa.typingExamPassed"); //88
        
        pqb.getSelectColumns().add("apa.mscitOrGaccc"); //89
        pqb.getSelectColumns().add("apa.twoYearExpAsTransportAssociation"); //90
        
        pqb.getSelectColumns().add("apa.oneYearExpAsTransportAssociation"); //91
        
        pqb.getSelectColumns().add("apa.bcomPassed"); //92
        pqb.getSelectColumns().add("apa.oneYearExpAsAccountant"); //93
        
        pqb.getSelectColumns().add("apa.bComOrBSCOrDiplomaHoldersInAutomobileOrMechanical"); //94
        
        pqb.getSelectColumns().add("apa.fireSafetyDegreeFromAffiliatedInstitute"); //95
        pqb.getSelectColumns().add("apa.fireAndSafetyDegreeName"); //96
        pqb.getSelectColumns().add("apa.fireAndSafetyUniversityName"); //97
        pqb.getSelectColumns().add("apa.qualificationForMilitaryForce"); //98
        pqb.getSelectColumns().add("apa.miltaryForceDegreeName"); //99
        pqb.getSelectColumns().add("apa.miltaryForceUniversityName"); //100
        pqb.getSelectColumns().add("apa.priority"); //101
        pqb.getSelectColumns().add("apa.requiredQualificationMarks"); //102
        pqb.getSelectColumns().add("apa.otherQualification"); //103
        
        pqb.getSelectColumns().add("a.highestQualification"); //104
        pqb.getSelectColumns().add("a.childOfFarmerWhoCommittedSuicide"); //105
        pqb.getSelectColumns().add("apa.instituteName"); //106
        pqb.getSelectColumns().add("apa.workExp"); //107
        pqb.getSelectColumns().add("apa.postName");//108
        pqb.getSelectColumns().add("apa.dcDivisionId");//109
        
        pqb.getSelectColumns().add("a.certificateNumber"); //110
        
        pqb.getSelectColumns().add("a.allocatedCategory");//111
        pqb.getSelectColumns().add("apa.postGradDegreeTypeId");//112
        pqb.getSelectColumns().add("apa.postGradDegreeInstituteName");//113
        pqb.getSelectColumns().add("ao.orphanedPerson");//114
        pqb.getSelectColumns().add("a.droughtAffected");//115
        pqb.setCountColumn( "apa.id" );

        pqb.getTables().add( "ApplicantPostAssoc apa" );
        pqb.getTables().add( "Applicant a" );
        pqb.getTables().add( "ApplicantOtherInformation ao" );
        pqb.getTables().add( "ApplicantFiles af" );

        pqb.getWhereConditions().add("apa.applicantId = a.id");
        pqb.getWhereConditions().add("ao.applicant.id = a.id");
        pqb.getWhereConditions().add("af.applicantId = a.id");

        pqb.getWhereConditions().add( "apa.status= 2");
        pqb.getWhereConditions().add( "apa.pdfGenerated = false");
        pqb.getWhereConditions().add( "apa.postId= " + postId);

        String applicationIdsCommaSeparated = applicationIds.stream()
                .map(s -> "'" + s + "'")
                .collect(Collectors.joining(","));

        pqb.getWhereConditions().add( "a.applicationId in (" + applicationIdsCommaSeparated + ")");

       // Long count = (Long) entityManager.createQuery(pqb.getCountQuery() ).getSingleResult();

        Query query = entityManager.createQuery(pqb.getResultQuery() );

     //   Pageable pageable = pageDetail.getPageable();
   //     query.setMaxResults(pageable.getPageSize());

/*
        if(pageable.getPageNumber()  >= 1) {
            query.setFirstResult(pageable.getOffset());
        }
*/

        List<Object[]> result = query.getResultList();
      //  final Page<UndertakingDTO> page = new PageImpl<UndertakingDTO>(populateApplicationDetails(result), pageable, count);
        return populateApplicationDetails(result);
    }

    private List<UndertakingDTO> populateApplicationDetails(List<Object[]> result){
        List<UndertakingDTO> dtoList = new ArrayList<>();
        if(result != null && result.size() > 0) {

            for (Object[] o : result) {
                UndertakingDTO dto = new UndertakingDTO();

                if(o[0] != null) {
                    dto.setApplicationID(o[0].toString());
                }

                if(o[1] != null) {
                    dto.setFirstName(o[1].toString());
                }

                if(o[2] != null) {
                    dto.setMiddleName(o[2].toString());
                }

                if(o[3] != null) {
                    dto.setSurname(o[3].toString());
                }

                if(o[4] != null) {
                    dto.setFirstNameInMarathi(o[4].toString());
                }

                if(o[5] != null) {
                    dto.setMiddleNameInMarathi(o[5].toString());
                }

                if(o[6] != null) {
                    dto.setSurnameInMarathi(o[6].toString());
                }

                if(o[7] != null) {
                    String s = o[7].toString();
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                    dto.setDob(LocalDate.parse(s, formatter));
                }

                if(o[8] != null) {
                    dto.setGender((Integer) o[8]);
                }

                if(o[9] != null) {
                    dto.setAddress(o[9].toString());
                }

                if(o[10] != null) {
                    dto.setPinCode(o[10].toString());
                }

                if(o[11] != null) {
                    dto.setEmail(o[11].toString());
                }

                if(o[12] != null) {
                    dto.setMobile(o[12].toString());
                }
               if(o[103] != null) {
                    dto.setHighestQualification((Long) (o[103] != null ?o[103] : 0));
                }
               
               if(o[104] != null) {
                   dto.setChildOfFarmerWhoCommittedSuicide((Boolean) o[104]);
               }

                if(o[13] != null) {
                    dto.setDistrictId((Long) o[13]);
                }

                if(o[14] != null) {
                    dto.setMaritalStatus((Integer) o[14]);
                }

                if(o[15] != null) {
                    dto.setMaharashtraDomicile((Boolean) o[15]);
                }

                if(o[16] != null) {
                    dto.setRwsMarathi((Boolean) o[16]);
                }

                if(o[17] != null) {
                    dto.setCasteId((Long) o[17]);
                }

                if(o[18] != null) {
                    dto.setSubCaste(o[18].toString());
                }

                if(o[19] != null) {
                    dto.setNonCreamyLayer((Boolean) o[19]);
                }

                if(o[20] != null) {
                    String s = o[20].toString();
                    dto.setCertificateValidityEndingDate(getFormattedDate(s));
                }
                
                if(o[21] != null) {
                    dto.setEarthQuakeEffected((Boolean) o[21]);
                }
                
                if(o[22] != null) {
                    dto.setProjectEffected((Boolean) o[22]);
                }
                
                if(o[23] != null) {
                    dto.setExServiceMan((Boolean) o[23]);
                }
                
                if(o[24] != null) {
                    String s = o[24].toString();
                    dto.setRetirementDate(getFormattedDate(s));
                }
                
                if(o[25] != null) {
                    dto.setPartTimeEmployee((Boolean) o[25]);
                }
                
                if(o[26] != null) {
                    dto.setSportsPerson((Boolean) o[26]);
                }
                
                if(o[27] != null) {
                    dto.setSportsLevel(o[27].toString());
                }
                
                if(o[28] != null) {
                    dto.setStEmployee((Boolean) o[28]);
                }
                
                if(o[29] != null) {
                    dto.setApplicantId((Long) o[29]);
                }
                
                if(o[30] != null) {
                    dto.setFirstPreferedCityId((Long) o[30]);
                }
                
                if(o[31] != null) {
                    dto.setSecondPreferedCityId((Long) o[31]);
                }
                
                if(o[32] != null) {
                    dto.setThirdPreferedCityId((Long) o[32]);
                }
                
                if(o[33] != null) {
                    dto.setSscPass((Boolean) o[33]);
                }
                
                if(o[34] != null) {
                    dto.setOtherQualificationDetails(o[34].toString());
                }
                
                if(o[35] != null) {
                    dto.setNightBlindness((Boolean) o[35]);
                }
                
                if(o[36] != null) {
                    dto.setColorBlindness((Boolean) o[36]);
                }
                
                if(o[37] != null) {
                    dto.setVisionAcuity((Boolean) o[37]);
                }
                
                if(o[38] != null) {
                    dto.setHeavyDrivingLicense((Boolean) o[38]);
                }
                
                if(o[39] != null) {
                    dto.setHeavyDrivingLicenseNumber(o[39].toString());
                }
                
                if(o[40] != null) {
                    String s = o[40].toString();
                    dto.setHeavyDrivingLicenseIssueDate(getFormattedDate(s));
                }
                
                if(o[41] != null) {
                    String s = o[41].toString();
                    dto.setHeavyDrivingLicenseExpiryDate(getFormattedDate(s));
                }
                
                if(o[42] != null) {
                    dto.setPsvBadge((Boolean) o[42]);
                }
                
                if(o[43] != null) {
                    dto.setPsvBadgeNumber(o[43].toString());
                }
                
                if(o[44] != null) {
                    dto.setConductorBatchLicense((Boolean) o[44]);
                }
                
                if(o[45] != null) {
                    dto.setConductorBatchLicenseNumber(o[45].toString());
                }
                
                if(o[46] != null) {
                	String s = o[46].toString();
                    dto.setConductorBatchLicenseIssueDate(getFormattedDate(s));
                }
                
                if(o[47] != null) {
                	String s = o[47].toString();
                    dto.setConductorBatchLicenseExpiryDate(getFormattedDate(s));
                }
                
                if(o[48] != null) {
                    dto.setThreeYearsExperienceAfterIssueOfHGVLicense((Boolean) o[48]);
                }
                
                if(o[49] != null) {
                    dto.setTransportCompanyName(o[49].toString());
                }
                
                if(o[50] != null) {
                    dto.setHgvExperienceInYears(o[50].toString());
                }
                
                if(o[51] != null) {
                    dto.setHgvExperienceInMonths(o[51].toString());
                }
                
                if(o[52] != null) {
                    dto.setGuarantorPerson((Boolean) o[52]);
                }
                
                if(o[53] != null) {
                    dto.setGuarantorPersonName(o[53].toString());
                }
                
                if(o[54] != null) {
                    dto.setGuarantorPersonNumber(o[54].toString());
                }
                
                if(o[55] != null) {
                    dto.setPhysicalQualificationHeight((Boolean) o[55]);
                }
                
                if(o[56] != null) {
                    dto.setCommittedAnyFatalAccident((Boolean) o[56]);
                }
                
                if(o[57] != null) {
                    dto.setPhotoNameInDB(o[57].toString());
                }
                
                if(o[58] != null) {
                    dto.setSignatureNameInDB(o[58].toString());
                }
                
                if(o[59] != null) {
                    dto.setDivisionId(new Long((Integer)o[59]));
                }
                
                if(o[60] != null) {
                    dto.setExServiceManTotalExpInYears(o[60].toString());
                }
                
                if(o[61] != null) {
                    dto.setExServiceManTotalExpInMonths(o[61].toString());
                }
                
                if(o[62] != null) {
                    dto.setPartTimeEmployeeExpInYears(o[62].toString());
                }
                
                if(o[63] != null) {
                    dto.setPartTimeEmployeeExpInMonths(o[63].toString());
                }
                
                if(o[64] != null) {
                    dto.setItiPassed((Boolean) o[64]);
                }
                
                if(o[65] != null) {
                    dto.setTradeId(new Long((Integer) o[65]));
                }
                
                if(o[66] != null) {
                    dto.setLightMotorVechicle((Boolean) o[66]);
                }
                
                if(o[67] != null) {
                    dto.setLightMotorVechicleLicenseNo(o[67].toString());
                }
                
                if(o[68] != null) {
                	String s = o[68].toString();
                    dto.setLightMotorVechicleIssueDate(getFormattedDate(s));
                }
                
                if(o[69] != null) {
                    dto.setApprenticeshipInMSRTC((Boolean) o[69]);
                }
                
                if(o[70] != null) {
                    dto.setApprenticeshipInMSRTCTrade(o[70].toString());
                }
                
                if(o[71] != null) {
                    dto.setApprenticeshipInMSRTCYear(o[71].toString());
                }
                
                if(o[72] != null) {
                    dto.setApprenticeshipInMSRTCDivision(o[72].toString());
                }
                
                if(o[73] != null) {
                    dto.setExperienced((Boolean) o[73]);
                }
                
                if(o[74] != null) {
                    dto.setItEngineer((Boolean) o[74]);
                }
                
                if(o[75] != null) {
                    dto.setDegreeName(o[75].toString());
                }
                
                if(o[76] != null) {
                    dto.setUniversityName(o[76].toString());
                }
                
                if(o[77] != null) {
                    dto.setAutomobileOrMechanicalEngDegree((Boolean) o[77]);
                }
                
                if(o[78] != null) {
                    dto.setOneYearExpInAutomobileRepairing((Boolean) o[78]);
                }
                
                if(o[79] != null) {
                    dto.setElectricalEngineeringDegree((Boolean) o[79]);
                }
                
                if(o[80] != null) {
                    dto.setDifferentlyAbled((Boolean) o[80]);
                }
                
                if(o[81] != null) {
                    dto.setLocomotorOrCerebralPalsy((Boolean) o[81]);
                }
                
                if(o[82] != null) {
                    dto.setArchitectEngineeringDegree((Boolean) o[82]);
                }
                
                if(o[83] != null) {
                    dto.setBlindnessAndLowVision((Boolean) o[83]);
                }
                
                if(o[84] != null) {
                    dto.setDeafAndMute((Boolean) o[84]);
                }
                
                if(o[85] != null) {
                    dto.setGraduateFromAffiliatedInstitute((Boolean) o[85]);
                }
                
                if(o[86] != null) {                
                	dto.setMscitOrDoeaccPassCertification((Boolean) o[86]);
                }
                
                if(o[87] != null) {                
                	dto.setTypingExamPassed((Boolean) o[87]);
                }
                
                if(o[88] != null) {                
                	dto.setMscitOrGaccc((Boolean) o[88]);
                }
                
                if(o[89] != null) {                
                	dto.setTwoYearExpAsTransportAssociation((Boolean) o[89]);
                }
                
                if(o[90] != null) {                
                	dto.setOneYearExpAsTransportAssociation((Boolean) o[90]);
                }
                
                if(o[91] != null) {                
                	dto.setBcomPassed((Boolean) o[91]);
                }
                
                if(o[92] != null) {                
                	dto.setOneYearExpAsAccountant((Boolean) o[92]);
                }
                
                if(o[93] != null) {                
                	dto.setbComOrBSCOrDiplomaHoldersInAutomobileOrMechanical((Boolean) o[93]);
                }
                
                if(o[94] != null) {                
                	dto.setFireSafetyDegreeFromAffiliatedInstitute((Boolean) o[94]);
                }
                
                if(o[95] != null) {
                    dto.setFireAndSafetyDegreeName(o[95].toString());
                }
                
                if(o[96] != null) {
                    dto.setFireAndSafetyUniversityName(o[96].toString());
                }
                
                if(o[97] != null) {                
                	dto.setQualificationForMilitaryForce((Boolean) o[97]);
                }
                
                if(o[98] != null) {
                    dto.setMiltaryForceDegreeName(o[98].toString());
                }
                
                if(o[99] != null) {
                    dto.setMiltaryForceUniversityName(o[99].toString());
                }
                
                if(o[100] != null) {
                    dto.setPriority((Integer) (o[100] != null ?o[100] : 0));
                }
                
                if(o[101] != null) {
                    dto.setRequiredQualificationMarks((Float) (o[101] != null ?o[101] : 0.0));
                }

                if(o[102] != null) {
                    dto.setOtherQualification((Long) (o[102] != null ?o[102] : 0));
                }
                if(o[105] != null) {
                    dto.setInstituteName(o[105].toString());
                }
                if(o[106] != null) {
                    dto.setWorkExp((int)o[106]);
                }
                if(o[107] != null) {
                    dto.setPostName(o[107].toString());
                }
                if(o[108] != null) {
                    dto.setDcDivisionId(new Long((Integer)o[108]));
                }
                
                if(o[109] != null) {
                    dto.setCertificateNumber(o[109].toString());
                }
                
                if(o[110] != null) {
                    dto.setAllocatedCategory((Integer) (o[110] != null ?o[110] : 0));
                }
                if(o[111] != null) {
                    dto.setPostGradDegreeTypeId(((Integer)o[111]));
                }
                if(o[112] != null) {
                    dto.setPostGradDegreeInstituteName(o[112].toString());
                }
                if(o[113] != null) {
                    dto.setOrphanedPerson((Boolean) o[113]);
                }
                if(o[114] != null) {
                    dto.setDroughtAffected((Boolean) o[114]);
                }
                
                dtoList.add(dto);
            }
        }

        return dtoList;
    }

	private LocalDate getFormattedDate(String s) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		return LocalDate.parse(s, formatter);
	}
}

