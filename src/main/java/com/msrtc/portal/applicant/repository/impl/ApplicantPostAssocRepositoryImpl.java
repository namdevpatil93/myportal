package com.msrtc.portal.applicant.repository.impl;

import java.math.BigInteger;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;

import com.msrtc.portal.applicant.domain.ApplicantPostAssoc;
import com.msrtc.portal.applicant.dto.AdmitCardDownload;
import com.msrtc.portal.applicant.dto.ApplicantPostAssocSearchDTO;
import com.msrtc.portal.applicant.repository.ApplicantPostAssocRepository;
import com.msrtc.portal.applicant.repository.ApplicantPostAssocRepositoryCustom;
import com.msrtc.portal.challan.domain.ApplicantPostPaymentMismatch;
import com.msrtc.portal.core.common.util.PageDetail;

public class ApplicantPostAssocRepositoryImpl implements ApplicantPostAssocRepositoryCustom {

	@Autowired
	ApplicantPostAssocRepository applicantPostAssocRepository;
	
	@PersistenceContext
	private EntityManager entityManager;
	
	@Override
	public Page<ApplicantPostAssoc> searchApplicantPostAssocs(ApplicantPostAssocSearchDTO applicantPostAssocSearchDTO, Pageable pageable) {
		return applicantPostAssocRepository.findAll(pageable);
	}
	  
	
	@SuppressWarnings("unchecked")
	@Override
	public Page<ApplicantPostAssoc> filterApplicantPostAssocsList(ApplicantPostAssocSearchDTO applicantPostAssocSearchDTO, PageDetail pageDetail) {
		StringBuilder sqlString = new StringBuilder();
		
		selectApplicantPostAssocsListQuery(sqlString);
		
		filterApplicantPostAssocsListQuery(sqlString, applicantPostAssocSearchDTO);
		
		sqlString.append(" ORDER BY a.application_id " + pageDetail.getSortOrder());
		
		sqlString.append(" LIMIT " + pageDetail.getSize());
		
		sqlString.append(" OFFSET "+ ((pageDetail.getPageNumber()-1) * pageDetail.getSize()));
		
		Query query = entityManager.createNativeQuery(sqlString.toString());
		
//		query.setFirstResult((pageDetail.getPageNumber()-1) * pageDetail.getSize()); 
//		query.setMaxResults(pageDetail.getSize());
		
		return new PageImpl<ApplicantPostAssoc>(query.getResultList());
	}


	private void selectApplicantPostAssocsListQuery(StringBuilder sqlString) {
		sqlString.append( "SELECT DISTINCT apa.id, a.application_id, CONCAT(a.first_name, ' ', a.middle_name, ' ',  a.last_name)," );
		sqlString.append( " a.mobile_number,  a.email_address," );
		sqlString.append( " (SELECT `post_title` FROM posts WHERE post_id = apa.post_id)," );
		sqlString.append( " (SELECT division_title FROM divisions WHERE division_id = apa.division_id)," );
		sqlString.append( " (SELECT caste_title FROM castes WHERE id = a.caste_id)," );
		sqlString.append( " a.subcategory, apa.status, apa.applicant_id,apa.post_id," );
		sqlString.append( " (SELECT `show_admit_card` FROM posts WHERE post_id = apa.post_id)" );
	}
	
	private void filterApplicantPostAssocsListQuery(StringBuilder sqlString, ApplicantPostAssocSearchDTO applicantPostAssocSearchDTO) {
		sqlString.append( " FROM applicant_post_assoc apa" );
		sqlString.append( " LEFT JOIN applicants a ON a.id = apa.applicant_id" );
		sqlString.append( " LEFT JOIN applicant_other_information aoi ON aoi.applicant_id = apa.applicant_id" );
		sqlString.append( " LEFT JOIN payment_transactions pt ON pt.order_no = apa.txn_order_no" );
		
		sqlString.append( " WHERE a.id IS NOT NULL" );
		
		basicFilterConditions(sqlString, applicantPostAssocSearchDTO);
		
		advancedFilterConditions(sqlString, applicantPostAssocSearchDTO);
		
	}


	private void basicFilterConditions(StringBuilder sqlString, ApplicantPostAssocSearchDTO applicantPostAssocSearchDTO) {
		if ( !StringUtils.isBlank(applicantPostAssocSearchDTO.getName()) ) {
			sqlString.append( " AND CONCAT(LOWER(a.first_name), ' ', LOWER(a.middle_name), ' ',  LOWER(a.last_name)) LIKE " ).append( "'%" + applicantPostAssocSearchDTO.getName().trim().toLowerCase() + "%'" );
		}
		
		if ( !StringUtils.isBlank(applicantPostAssocSearchDTO.getApplicantId()) ) {
			sqlString.append( " AND LOWER(a.application_id) LIKE " ).append( "'%" + applicantPostAssocSearchDTO.getApplicantId().trim().toLowerCase() + "%'" );
		}
		
		if ( applicantPostAssocSearchDTO.getCaste() != null && applicantPostAssocSearchDTO.getCaste() > 0 ) {
			sqlString.append( " AND a.caste_id = " ).append( applicantPostAssocSearchDTO.getCaste() );
		}
		
//		if ( applicantPostAssocSearchDTO.getDifferentlyAbled() != null ) {
//			sqlString.append( " AND apa.is_differently_abled = " ).append( applicantPostAssocSearchDTO.getDifferentlyAbled() );
//		}
		
		if ( !StringUtils.isBlank(applicantPostAssocSearchDTO.getDifferentlyAbledSelect()) ) {
			
			String[] idArr = applicantPostAssocSearchDTO.getDifferentlyAbledSelect().split(",");
			
			sqlString.append( " AND");
			
			String isBlindnessAndLowVision = " apa.is_blindness_and_low_vision = " + true;
			String isDeafAndMute = " apa.is_deaf_and_mute = " + true;
			String isLocomotorOrCerebralPalsy = " apa.is_locomotor_or_cerebral_palsy = " + true;
			switch(idArr.length) {
				case 1: {
					if ( applicantPostAssocSearchDTO.getDifferentlyAbledSelect().contains("1") ) {
						sqlString.append( isBlindnessAndLowVision );
					} else if ( applicantPostAssocSearchDTO.getDifferentlyAbledSelect().contains("2") ) {
						sqlString.append( isDeafAndMute );
					} else {
					//if ( applicantPostAssocSearchDTO.getDifferentlyAbledSelect().contains("3") ) {
						sqlString.append( isLocomotorOrCerebralPalsy );
					}
				}
				break;
				
				case 2: {
					sqlString.append(" (");
					if ( applicantPostAssocSearchDTO.getDifferentlyAbledSelect().contains("1") 
							&& applicantPostAssocSearchDTO.getDifferentlyAbledSelect().contains("2")) {
						sqlString.append( isBlindnessAndLowVision ).append( " OR" ).append( isDeafAndMute );
					} else if ( applicantPostAssocSearchDTO.getDifferentlyAbledSelect().contains("2") 
							&& applicantPostAssocSearchDTO.getDifferentlyAbledSelect().contains("3")) {
						sqlString.append( isDeafAndMute ).append( " OR" ).append( isLocomotorOrCerebralPalsy );
					} else {
//					if ( applicantPostAssocSearchDTO.getDifferentlyAbledSelect().contains("3") 
//							&& applicantPostAssocSearchDTO.getDifferentlyAbledSelect().contains("1")) {
						sqlString.append( isLocomotorOrCerebralPalsy ).append( " OR" ).append( isBlindnessAndLowVision );
					}
					sqlString.append(" )");
				}
				break;
				
				case 3: {
					sqlString.append(" (");
					sqlString.append( isBlindnessAndLowVision ).append( " OR" ).append( isDeafAndMute ).append( " OR" ).append( isLocomotorOrCerebralPalsy );
					sqlString.append(" )");
				}
				break;
			}
		}
		
		if ( applicantPostAssocSearchDTO.getGender() != null ) {
			sqlString.append( " AND a.gender = " ).append( applicantPostAssocSearchDTO.getGender() );
		}
		
		/*if ( applicantPostAssocSearchDTO.getPaidUnpaid() == Integer.valueOf(2) ) {
			//Integer.valueOf(2) is for Paid applicants
			sqlString.append( " AND apa.status = " ).append( Integer.valueOf(2) );
		} else if (applicantPostAssocSearchDTO.getPaidUnpaid() != null)  {
			sqlString.append( " AND apa.status != " ).append( Integer.valueOf(2) );
		}*/
		
		if ( applicantPostAssocSearchDTO.getPaidUnpaid() != null ) {
			//Refer PaymentTransactionStatusEnum
			sqlString.append( " AND pt.status = " ).append( applicantPostAssocSearchDTO.getPaidUnpaid() );
		}
		
		if ( applicantPostAssocSearchDTO.getOnlineOffline() != null ) {
			sqlString.append( " AND pt.payment_mode = " ).append( applicantPostAssocSearchDTO.getOnlineOffline() );//***
		}
		
		if ( applicantPostAssocSearchDTO.getPost() != null && applicantPostAssocSearchDTO.getPost() > 0 ) {
			sqlString.append( " AND apa.post_id = " ).append( applicantPostAssocSearchDTO.getPost() );
		}
		
		if ( applicantPostAssocSearchDTO.getDistrict() != null && applicantPostAssocSearchDTO.getDistrict() > 0 ) {
			sqlString.append( " AND a.district_id = " ).append( applicantPostAssocSearchDTO.getDistrict() );
		}
		
		if ( !StringUtils.isBlank(applicantPostAssocSearchDTO.getMobileNumber()) ) {
			sqlString.append( " AND LOWER(a.mobile_number)  LIKE " ).append( "'%" + applicantPostAssocSearchDTO.getMobileNumber().trim().toLowerCase() + "%'" );
		}
		
		if ( !StringUtils.isBlank(applicantPostAssocSearchDTO.getEmailId()) ) {
			sqlString.append( " AND LOWER(a.email_address)  LIKE " ).append( "'%" + applicantPostAssocSearchDTO.getEmailId().trim().toLowerCase() + "%'" );
		}
	}
	
	private void advancedFilterConditions(StringBuilder sqlString, ApplicantPostAssocSearchDTO applicantPostAssocSearchDTO) {
		if ( applicantPostAssocSearchDTO.getProjectAffected() != null ) {
			sqlString.append( " AND aoi.project_effected = " ).append( applicantPostAssocSearchDTO.getProjectAffected() );
		}
		
		if ( applicantPostAssocSearchDTO.getEarthQuickAffected() != null ) {
			sqlString.append( " AND aoi.earth_quake_effected = " ).append( applicantPostAssocSearchDTO.getEarthQuickAffected() );
		}
		
		if ( applicantPostAssocSearchDTO.getExServiceMan() != null ) {
			sqlString.append( " AND aoi.ex_service_man = " ).append( applicantPostAssocSearchDTO.getExServiceMan() );
		}
		
		if ( applicantPostAssocSearchDTO.getPartTimeEmployee() != null ) {
			sqlString.append( " AND aoi.part_time_employee = " ).append( applicantPostAssocSearchDTO.getPartTimeEmployee() );
		}
		
		if ( applicantPostAssocSearchDTO.getSportsPerson() != null ) {
			sqlString.append( " AND aoi.sports_person = " ).append( applicantPostAssocSearchDTO.getSportsPerson() );
		}
		
		if ( applicantPostAssocSearchDTO.getsTEmployee() != null ) {
			sqlString.append( " AND aoi.st_employee = " ).append( applicantPostAssocSearchDTO.getsTEmployee() );
		}
		
	}
	
	@Override
	public Integer filterApplicantPostAssocsListSize(ApplicantPostAssocSearchDTO applicantPostAssocSearchDTO) {
		StringBuilder sqlString = new StringBuilder();
		
		sqlString.append( " SELECT COUNT(DISTINCT apa.id)" );
		
		filterApplicantPostAssocsListQuery(sqlString, applicantPostAssocSearchDTO);
		
		BigInteger pageHasRecords = (BigInteger) entityManager.createNativeQuery(sqlString.toString()).getSingleResult();
		
		return pageHasRecords.intValue();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Object[]> findAllApplicantPostAssoc(ApplicantPostAssocSearchDTO applicantPostAssocSearchDTO) {
		StringBuilder sqlString = new StringBuilder();
		selectApplicantPostAssocsListQuery(sqlString);
		filterApplicantPostAssocsListQuery(sqlString, applicantPostAssocSearchDTO);
		
		return  entityManager.createNativeQuery(sqlString.toString()).getResultList();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Integer> filterApplicantIdList(ApplicantPostAssocSearchDTO applicantPostAssocSearchDTO) {
		StringBuilder sqlString = new StringBuilder();
		
		sqlString.append( "SELECT DISTINCT a.id" );
		
		applicantListJoinQuery(applicantPostAssocSearchDTO, sqlString);
		
		return  entityManager.createNativeQuery(sqlString.toString()).getResultList();
	}

	private void applicantListJoinQuery(ApplicantPostAssocSearchDTO applicantPostAssocSearchDTO, StringBuilder sqlString) {
		sqlString.append( " FROM applicants a" );		
		sqlString.append( " LEFT JOIN applicant_post_assoc apa ON apa.applicant_id = a.id" );			
		sqlString.append( " LEFT JOIN applicant_other_information aoi ON aoi.applicant_id = a.id" );		
		sqlString.append( " LEFT JOIN payment_transactions pt ON pt.order_no = apa.txn_order_no" );
		
		sqlString.append( " WHERE a.id IS NOT NULL" );
		
		basicFilterConditions(sqlString, applicantPostAssocSearchDTO);
		
		advancedFilterConditions(sqlString, applicantPostAssocSearchDTO);
	}


	@Override
	public Integer filterApplicantPostPaymentMismatchListSize(String fromDate, String toDate) {
		StringBuilder sqlString = new StringBuilder();
		
		sqlString.append( " SELECT COUNT(*) FROM view_applicant_post_payment_mismatch " );
		sqlString.append(" WHERE CONVERT(transaction_date, DATE) BETWEEN CONVERT('");
		sqlString.append(fromDate);
		sqlString.append("', DATE) AND CONVERT('");
		sqlString.append(toDate);
		sqlString.append("', DATE)");
		
		
		BigInteger pageHasRecords = (BigInteger) entityManager.createNativeQuery(sqlString.toString()).getSingleResult();
		
		return pageHasRecords.intValue();
	}


	@Override
	public Page<ApplicantPostPaymentMismatch> filterApplicantPostPaymentMismatchList(String fromDate, String toDate, PageDetail pageDetail) {
		StringBuilder sqlString = new StringBuilder();
		sqlString.append( " SELECT * FROM view_applicant_post_payment_mismatch " );
		sqlString.append(" WHERE CONVERT(transaction_date, DATE) BETWEEN CONVERT('");
		sqlString.append(fromDate);
		sqlString.append("', DATE) AND CONVERT('");
		sqlString.append(toDate);
		sqlString.append("', DATE)");
		sqlString.append(" LIMIT " + pageDetail.getSize());
		sqlString.append(" OFFSET "+ ((pageDetail.getPageNumber()-1) * pageDetail.getSize()));
		Query query = entityManager.createNativeQuery(sqlString.toString());
		return new PageImpl<ApplicantPostPaymentMismatch>(query.getResultList());
	}


	@Override
	public 	Object[]  getAdmitCardUrl(Long applicantId, Long postId) {
		StringBuilder sqlString = new StringBuilder();
		sqlString.append( " SELECT  " );
		sqlString.append( " (SELECT e.drive_id FROM ep_exams e LEFT JOIN ep_exam_post_assoc epc ON e.id=epc.exam_id LEFT JOIN ep_exam_applicant_assoc ec ON ec.exam_id= epc.exam_id  WHERE epc.post_id=" );
		sqlString.append(  postId  );
		sqlString.append( " AND ec.applicant_id=" );
		sqlString.append(  applicantId  );
		sqlString.append( ")as driveId," );
		sqlString.append( " a.admit_card_url as admitCardUrl" );
		sqlString.append( " FROM ep_exam_applicant_assoc a  WHERE a.exam_id=(SELECT epc.exam_id FROM ep_exam_post_assoc epc LEFT JOIN  ep_exam_applicant_assoc ec ON epc.exam_id=ec.exam_id WHERE epc.post_id=");
		sqlString.append( postId );
		sqlString.append( " AND ec.applicant_id=" );
		sqlString.append(  applicantId  );
		sqlString.append( ") AND a.applicant_id =" );
		sqlString.append( applicantId );
		Object[] download=   (Object[]) entityManager.createNativeQuery(sqlString.toString()).getSingleResult() ;
		
		return download;
	}
}
