package com.msrtc.portal.applicant.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.msrtc.portal.applicant.domain.*;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.msrtc.portal.applicant.dto.AdmitCardDownload;
import com.msrtc.portal.applicant.dto.ApplicantPostAssocSearchDTO;
import com.msrtc.portal.applicant.dto.ApplicantSearchDTO;
import com.msrtc.portal.applicant.dto.SubmissionErrorsDTO;
import com.msrtc.portal.challan.domain.ApplicantPostPaymentMismatch;
import com.msrtc.portal.core.common.util.PageDetail;

public interface ApplicantService {

    List<Applicant> findAllApplicants();

    Page<Applicant> searchApplicants(ApplicantSearchDTO applicantSearchDTO, Pageable pageable);

    Applicant findApplicantById(Long id) ;

    Applicant findApplicantByApplicationId(String applicationId);

    void saveApplicant(Applicant applicant);

    void deleteApplicant(Long id);

    void updatePassword(Applicant applicant);

    List<Caste> findAllCastes();
    
    List<Post> findAllPost();

    void saveApplicantFiles(Long applicantFilesId, Applicant applicant, MultipartFile photo, MultipartFile signature, int status);
    
    void saveAllApplicantPostAssoc(String[] selectedPostIds, Applicant applicant);
    
    List<ApplicantPostAssoc> findApplicantPostAssocsByApplicant(Applicant applicant);
    
    List<PostCategory> findAllPostCategory();
    
    void saveApplicantOtherInformation(ApplicantOtherInformation applicantOtherInformation, Applicant applicant);

    ApplicantOtherInformation findApplicantOtherInformationByApplicant(Applicant applicant);

    void deleteApplicantPost(Applicant applicant, Long postId);

    List<Division> findAllDivisions();

    List<Trade> findAllTrades();

    void saveApplicantPostDetails(ApplicantPostAssoc applicantPostAssoc, Applicant applicant, MultipartFile heavyDrivingLicenseUpload);
    
    Applicant findApplicantByEmailAddress(String email);
    
    void sendPasswordResetLinkToApplicant(Applicant applicant,String resetLink,String token);
    
    void saveApplicationPostPriority(Map<Long, Integer> appPostPriorityMap);
    
    List<PostSuperCategory> findAllPostSuperCategory();
    
    Long totalApplicants();
    
    ApplicantOTP findByApplicantId(Long applicantId);
    
    void saveApplicantOTP (ApplicantOTP applicantOTP);
    
    ApplicantFiles getApplicantFilesByApplicantId(Long applicantId);

    ApplicantOTP findApplicantOTPByApplicantId(Long applicantId);

    void updateApplicantOTP(Long applicantId, String otp);
    
    Page<ApplicantPostAssoc> searchApplicantPostAssocs(ApplicantPostAssocSearchDTO applicantPostAssocSearchDTO, Pageable pageable);
    
    Long totalApplicantPostAssocs();
    
    List<Object[]> findAllApplicantPostAssoc(ApplicantPostAssocSearchDTO applicantPostAssocSearchDTO);

    SubmissionErrorsDTO checkErrorsInApplicationSubmission(Applicant applicant);
    
    ApplicantPostAssoc findApplicantPostAssocByApplicantPostAssocIdWithDetails(Long applicantPostAssocId, int detailsLevel);
    
    List<ApplicantPostAssoc> findApplicantPostAssocsByApplicantIdOrderByPostCategory(Long applicantId);
    
    void saveApplicantPostAssoc(ApplicantPostAssoc applicantPostAssoc);

    List<ApplicantPostAssoc> findByTxnOrderNo(String txnOrderNo);
   
    List<ApplicantPostAssoc> findApplicantPostAssocsByApplicantIdAndStatus(Long applicantId, Long status);

    Post findPostByPostId(Long postId);

    List<ApplicantPostAssoc> findPostsAppliedForPayment(Long applicantId);
    
    Division findDivisionById(Integer id) ;
    
    List<City> findAllCities();
    
    Trade findTradeById(Integer id) ;
    
    List<PostSuperCategory> findAllPostSuperCategoryBySuperCategoryOrder();

    List<District> findAllDistricts();
    
    District findDistrictById(Long id) ;
    
    City findCityById(Long id) ;

    List<PostDivisionAssoc> findDivisionsByPostId(Long postId);

    int updateStatusByTxnOrderNo(Long status, String txnOrderNo);

    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
    int updateStatusByTxnOrderNo(Long status, List<String> txnOrderNos);

    String getRandomNo();
    
    Integer getPostFees(Applicant applicant);
    
    List<Post> findAllActivePost();

    boolean isOpenCategoryFeesApplicable(Applicant applicant);
    
    Page<ApplicantPostAssoc> filterApplicantPostAssocsList(ApplicantPostAssocSearchDTO applicantPostAssocSearchDTO, PageDetail pageDetail);
    
    Integer filterApplicantPostAssocsListSize(ApplicantPostAssocSearchDTO applicantPostAssocSearchDTO);

	public int getCountofUnreadQueryReplies(Long id);
    
    List<Integer> filterApplicantIdList(ApplicantPostAssocSearchDTO applicantPostAssocSearchDTO);
    
    List<Trade> findAllActiveTrades();
    
    boolean isPaymentDoneOrChallanGeneratedByApplicant(Long applicantId);
    
    boolean isLastDateOfApplicationOver();
    
    boolean isLastDateOfApplicationOverForPost(Long postId);

    void markPostAsSubmitted(Long postAssocId, String orderNo);
    
    public Long findSubmittedApplicantPostAssocCountByOrderNo(Long status, String orderNo);
    
    void updateApplicantPostAssocTransactionOrderNo(String oldOrderNo, String newOrderNo);
    
    public ApplicantRestResponse getExamDataFromExamBench(Integer applicantPostAssocId,String lngCode,Integer postId);

    void generateApplicationFormsPDF(String name, List<String> applicationIDs, Long postId, String logoPath, String fontFilePath, String itextLicenseFilePath, PageDetail pageDetail, Long userId);

    List<ApplicantForm> findAllApplicantFormList();

    ApplicantForm findApplicantFormByApplicantFormId(Long applicantFormId);

    void savePost(Post post);
    
    Integer filterApplicantPostPaymentMismatchListSize(String fromDate, String toDate);
    
    Page<ApplicantPostPaymentMismatch> filterApplicantPostPaymentMismatchList(String fromDate, String toDate, PageDetail pageDetail);

	Object[]  getAdmitCardUrl(Long applicantId, Long postId);
	
	String getExamCode(Integer postId);
	
	Date getExamDate(Integer applicantId, String examCode);
	
	String getShiftName(Integer applicantId, String examCode);
	
	Integer getApplicantId(Integer applicantPostAssocId, Integer postId);
	
	String getApplicationId(Integer applicantId);

	//Integer getPostFeesAsPerAdvertisementNumber(Applicant applicant);

	boolean isApplicantApplyForPayment(Long applicantId);
	
	List<ApplicantPostAssoc> findApplicantPostAssocbyTxnOrderNo(String txnOrderNum);
	
	List<Long> findUniquePostByPostType(ArrayList<Long> postId);
	
	String findApplicationIdById(Long id);
	
	boolean isOneMonthCompletedPaymentDoneOrChallanGeneratedByApplicant(Applicant applicant);
	
	boolean disableFormAfterLastDateOfPayment();
	
	List<Object[]> getPrefferedCityData();
	
	

	//String generatePreferedCityReport(String dateString) throws IOException;
	
	String generatePrefferedCityReportCsv(String dateString) throws IOException;

	void updateApplicant(Applicant applicant);

	Boolean isSelectedEwsOrSebc(Applicant applicant);
}

