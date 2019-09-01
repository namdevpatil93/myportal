package com.msrtc.portal.challan.web;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.msrtc.portal.applicant.domain.Applicant;
import com.msrtc.portal.applicant.domain.ApplicantPostAssoc;
import com.msrtc.portal.applicant.domain.StatusEnum;
import com.msrtc.portal.applicant.service.ApplicantPostAssocService;
import com.msrtc.portal.applicant.service.ApplicantService;
import com.msrtc.portal.challan.domain.ApplicantPostPaymentMismatch;
import com.msrtc.portal.challan.domain.Challan;
import com.msrtc.portal.challan.domain.ChallanFile;
import com.msrtc.portal.challan.dto.ChallanFileSearchDTO;
import com.msrtc.portal.challan.dto.ChallanSearchDTO;
import com.msrtc.portal.challan.service.ChallanService;
import com.msrtc.portal.challan.service.impl.ChallanServiceImpl;
import com.msrtc.portal.core.common.util.Constants;
import com.msrtc.portal.core.common.util.FileUtils;
import com.msrtc.portal.core.common.util.PageDetail;
import com.msrtc.portal.core.config.ApplicationProperties;
import com.msrtc.portal.core.systemsetting.service.SystemSettingService;
import com.msrtc.portal.core.systemsetting.util.SystemSettingEnum;
import com.msrtc.portal.core.user.security.SecurityUtils;
import com.msrtc.portal.payment.domain.PaymentModeEnum;
import com.msrtc.portal.payment.domain.PaymentTransaction;
import com.msrtc.portal.payment.domain.PaymentTransactionStatusEnum;
import com.msrtc.portal.payment.dto.OnlineQueryApiResponse;
import com.msrtc.portal.payment.service.PaymentTransactionService;

@Controller
@RequestMapping(value = { "/challan" })
public class ChallanController {

	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	private MessageSource messageSource;

	@Autowired
	private ChallanService challanService;

	@Autowired
	private PaymentTransactionService paymentTransactionService;

	@Autowired
	private ApplicantService applicantService;

	@Autowired
	private SystemSettingService systemSettingService;
	
	@Autowired
	private ApplicantPostAssocService applicantPostAssocService;

	@RequestMapping(params = "operation=showUploadChallan")
	public String showUploadChallan(Model model) {
		log.debug("Show upload challan page.");

		// Long countOfOfflineTransactions =
		// paymentTransactionService.countByPaymentMode(PaymentModeEnum.OFFLINE.getId());
		Long countOfOfflineTransactions = paymentTransactionService
				.countByPaymentModeAndStatus(PaymentModeEnum.OFFLINE.getId(),
						PaymentTransactionStatusEnum.SUCCESS.getId());
		// Long countOfOnlineTransactions =
		// paymentTransactionService.countByPaymentMode(PaymentModeEnum.ONLINE.getId());
		Long countOfOnlineTransactions = paymentTransactionService
				.countByPaymentModeAndStatus(PaymentModeEnum.ONLINE.getId(),
						PaymentTransactionStatusEnum.SUCCESS.getId());

		BigDecimal offlineTransactionsAmount = new BigDecimal(0);
		// offlineTransactionsAmount =
		// paymentTransactionService.findTotalAmountByPaymentMode(PaymentModeEnum.OFFLINE.getId());
		offlineTransactionsAmount = paymentTransactionService
				.findTotalAmountByPaymentModeAndStatus(
						PaymentModeEnum.OFFLINE.getId(),
						PaymentTransactionStatusEnum.SUCCESS.getId());

		BigDecimal onlineTransactionsAmount = new BigDecimal(0);
		// onlineTransactionsAmount =
		// paymentTransactionService.findTotalAmountByPaymentMode(PaymentModeEnum.ONLINE.getId());
		onlineTransactionsAmount = paymentTransactionService
				.findTotalAmountByPaymentModeAndStatus(
						PaymentModeEnum.ONLINE.getId(),
						PaymentTransactionStatusEnum.SUCCESS.getId());

		BigDecimal totalAmount = new BigDecimal(0);

		offlineTransactionsAmount = offlineTransactionsAmount != null ? offlineTransactionsAmount
				: new BigDecimal(0);
		onlineTransactionsAmount = onlineTransactionsAmount != null ? onlineTransactionsAmount
				: new BigDecimal(0);

		totalAmount = offlineTransactionsAmount.add(onlineTransactionsAmount);
		//To fetch from system settings the start date of registration
		String fromDate = systemSettingService.getSystemSetting(SystemSettingEnum.START_DATE_OF_REGISTRATION);
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("d/MM/yyyy");
		LocalDate formattedfromDate = LocalDate.parse(fromDate, formatter);
		Long successfulOnlinePaymentPostCount = applicantPostAssocService.countApplicantPostAssocByPaymentModePaymentStatusBetweenDates(PaymentModeEnum.ONLINE.getId(), PaymentTransactionStatusEnum.SUCCESS.getId(), formattedfromDate.toString(), LocalDate.now().toString());
		Long successfulOfflinePaymentPostCount =applicantPostAssocService.countApplicantPostAssocByPaymentModePaymentStatusBetweenDates(PaymentModeEnum.OFFLINE.getId(), PaymentTransactionStatusEnum.SUCCESS.getId(), formattedfromDate.toString(), LocalDate.now().toString());
		Long failedOnlinePaymentPostCount =applicantPostAssocService.countApplicantPostAssocByPaymentModePaymentStatusBetweenDates(PaymentModeEnum.ONLINE.getId(), PaymentTransactionStatusEnum.FAILURE.getId(), formattedfromDate.toString(), LocalDate.now().toString());
		Long failedOfflinePaymentPostCount =applicantPostAssocService.countApplicantPostAssocByPaymentModePaymentStatusBetweenDates(PaymentModeEnum.OFFLINE.getId(), PaymentTransactionStatusEnum.FAILURE.getId(), formattedfromDate.toString(), LocalDate.now().toString());

		model.addAttribute("countOfOfflineTransactions",
				countOfOfflineTransactions);
		model.addAttribute("countOfOnlineTransactions",
				countOfOnlineTransactions);
		model.addAttribute("offlineTransactionsAmount",
				offlineTransactionsAmount);
		model.addAttribute("onlineTransactionsAmount", onlineTransactionsAmount);
		model.addAttribute("totalAmount", totalAmount);
		model.addAttribute("successfulOnlinePaymentPostCount", successfulOnlinePaymentPostCount);
		model.addAttribute("successfulOfflinePaymentPostCount", successfulOfflinePaymentPostCount);
		model.addAttribute("failedOnlinePaymentPostCount", failedOnlinePaymentPostCount);
		model.addAttribute("failedOfflinePaymentPostCount", failedOfflinePaymentPostCount);

		return "uploadChallan";
	}

	@RequestMapping(params = "operation=saveChallan")
	public String saveChallan(Model model,
			@RequestParam MultipartFile challanFile,
			final RedirectAttributes redirectAttributes) {
		log.debug("Save challan.");
		Long userId = SecurityUtils.getCurrentUser().getUser().getId();
		Map<String, String> errorMap = null;
		try {
			errorMap = challanService.uploadChallan(challanFile, userId);
			redirectAttributes.addFlashAttribute("message", messageSource
					.getMessage("challan.save.success", null,
							LocaleContextHolder.getLocale()));
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", messageSource
					.getMessage("challan.save.failed", null,
							LocaleContextHolder.getLocale()));
			log.error(e.getMessage());
		}

		redirectAttributes.addFlashAttribute("errorMap", errorMap);
		return "redirect:/challan?operation=showUploadChallan";
	}

	@RequestMapping(params = "operation=viewPreviousUploads")
	public String viewPreviousUploads(Model model) {
		log.debug("View Previous Uploads");
		return "viewPreviousUploads";
	}

	@RequestMapping(params = "operation=challanList")
	public String challanList(Model model, ChallanSearchDTO challanSearchDTO,
			PageDetail pageDetail) {
		log.debug("Finding all challan entries");
		Page<Challan> page = challanService.searchChallans(challanSearchDTO,
				pageDetail.getPageable());

		int beginIndex = pageDetail.getBeginIndex(page.getNumber());
		model.addAttribute("beginIndex", beginIndex);
		model.addAttribute("endIndex",
				pageDetail.getEndIndex(page.getTotalPages(), beginIndex));

		model.addAttribute("page", page);
		model.addAttribute("pageDetail", pageDetail);
		model.addAttribute("challanSearchDTO", challanSearchDTO);

		if (pageDetail.isNewPage()) {
			return "challanListResult";
		} else {
			return "challanList";
		}
	}

	@RequestMapping(params = "operation=challanFileList")
	public String challanFileList(Model model,
			ChallanFileSearchDTO challanFileSearchDTO, PageDetail pageDetail) {
		log.debug("Finding all challanFile entries");
		Page<ChallanFile> page = challanService.searchChallanFiles(
				challanFileSearchDTO, pageDetail.getPageable());

		int beginIndex = pageDetail.getBeginIndex(page.getNumber());
		model.addAttribute("beginIndex", beginIndex);
		model.addAttribute("endIndex",
				pageDetail.getEndIndex(page.getTotalPages(), beginIndex));

		model.addAttribute("page", page);
		model.addAttribute("pageDetail", pageDetail);
		model.addAttribute("challanFileSearchDTO", challanFileSearchDTO);

		if (pageDetail.isNewPage()) {
			return "challanFileListResult";
		} else {
			return "challanFileList";
		}
	}

	@RequestMapping(params = "operation=onlineQueryApi")
	public String onlineQueryApi(Model model) {
		return "onlineQueryApi";
	}

	@RequestMapping(params = "operation=submitQuery")
	public String submitQuery(Model model, @RequestParam String orderNo) {
		OnlineQueryApiResponse onlineQueryApiResponse = paymentTransactionService
				.getOnlineQueryResponse(orderNo);
		model.addAttribute("orderNo", orderNo);
		model.addAttribute("onlineQueryApiResponse", onlineQueryApiResponse);
		return "onlineQueryApi";
	}

	@RequestMapping(params = "operation=changeStatus")
	public @ResponseBody Map changeStatus(String orderNo, int status) {
		log.debug("Changing the status of the order No: {}", orderNo);
		Map<String, Object> result = new HashMap<>();
		boolean success = true;
		try {
			challanService.updatePaymentStatusViaQueryApi(orderNo, status);
		} catch (Exception e) {
			log.error(e.getMessage());
			success = false;
		}
		result.put("success", success);
		return result;
	}

	// ======================================================

	@RequestMapping(params = "operation=downloadChallanData")
	public void downloadChallanData(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ParseException {
		Date stDate = new SimpleDateFormat("dd/MM/yyyy").parse(request
				.getParameter("fromDate"));
		Date toDate = new SimpleDateFormat("dd/MM/yyyy").parse(request
				.getParameter("toDate"));
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String parsedFromDate = formatter.format(stDate);
		String parsedtoDate = formatter.format(toDate);
		List<Object[]> challanDataList = challanService.downloadChallanData(
				parsedFromDate, parsedtoDate);
		response.setContentType("text/plain");
		String reportName = "MSRTC_"+parsedFromDate+"_"+parsedtoDate+".txt";
		response.setHeader("Content-disposition", "attachment;filename="
				+ reportName);

		List<String> rows = new ArrayList<String>();

		StringBuilder srtBldr = null;

		/*
		 * List<Post> allPosts = applicantService.findAllPost(); Map<Long, Post>
		 * postMap = new HashMap<>();
		 * 
		 * if(allPosts != null && allPosts .size() > 0){ postMap =
		 * allPosts.stream().collect(Collectors.toMap(post -> post.getPostId(),
		 * post -> post)); }
		 */

		String paymentDate = systemSettingService
				.getSystemSetting(SystemSettingEnum.OFFLINE_LAST_DATE_OF_PAYMENT);
		LocalDate localDate = LocalDate.parse(
				paymentDate != null ? paymentDate : LocalDate.now().format(
						DateTimeFormatter.ofPattern("dd/MM/yyyy")),
				DateTimeFormatter.ofPattern("dd/MM/yyyy").withLocale(
						Locale.ENGLISH));
		String lastDateOfPayment = localDate.format(DateTimeFormatter
				.ofPattern("ddMMyyyy"));

		for (Object obj[] : challanDataList) {
			StringBuilder postIdBuilder = new StringBuilder();

			String challanNumber = (String) obj[1];
			// List<ApplicantPostAssoc> applicantPostAssocs =
			// applicantService.findByTxnOrderNo(challanNumber);

			// for(ApplicantPostAssoc apa : applicantPostAssocs){
			// if(postMap != null) {
			// postIdBuilder.append(postMap.get(apa.getPostId()) != null ?
			// postMap.get(apa.getPostId()).getPostCode() : "");
			// }
			// }

			srtBldr = new StringBuilder();

			srtBldr.append(StringUtils.leftPad((String) obj[0], 6, '0'));
			srtBldr.append(StringUtils.leftPad((String) obj[1], 20, '0'));

			DateTimeFormatter formatteDate = DateTimeFormatter
					.ofPattern("ddMMyyyy");
			String formattedDateTime = ((LocalDate) obj[2])
					.format(formatteDate);

			srtBldr.append(formattedDateTime);
			srtBldr.append(StringUtils.leftPad((String) obj[3], 17, '0'));
			srtBldr.append(StringUtils.leftPad((String) obj[4].toString()
					+ "000", 17, '0'));
			srtBldr.append(StringUtils.leftPad((String) obj[5], 5, '0'));

			String applicantName = (String) obj[6];

			if (applicantName.length() > 30) {
				applicantName = applicantName.substring(0, 30);
			}

			srtBldr.append(StringUtils.rightPad(applicantName, 30, ' '));
			srtBldr.append(StringUtils.rightPad(postIdBuilder.toString(), 30,
					' '));

			String casteTitle = obj[7].toString();
			srtBldr.append(StringUtils.rightPad(casteTitle, 30, ' '));
			srtBldr.append(StringUtils.rightPad((String) obj[8], 30, ' '));
			srtBldr.append(StringUtils.repeat(" ", 70));

			srtBldr.append(lastDateOfPayment);

			rows.add(srtBldr.toString());
			rows.add(System.getProperty("line.separator"));
		}

		response.setCharacterEncoding("UTF-8");
		Iterator<String> iter = rows.iterator();
		while (iter.hasNext()) {
			String outputString = (String) iter.next();
			response.getWriter().print(outputString);
		}

		response.getWriter().flush();
	}

	

	@RequestMapping(params = "operation=showPaymentSearchForm")
	public String showPaymentSearchForm(HttpServletRequest request, Model model) {
		model.addAttribute("applicationId", request.getParameter("applicantId"));
		model.addAttribute("isRedirectedFromPaymentScreen", true);
		return "paymentSearchForm";
	}

	@RequestMapping(params = "operation=searchPayments")
	public String searchPayments(Model model, String applicationId) {
		Applicant applicant = applicantService
				.findApplicantByApplicationId(applicationId);

		if (applicant != null) {
			List<PaymentTransaction> paymentTransactionList = paymentTransactionService
					.findAllPaymentsDoneByApplicant(applicant.getId());

			if (paymentTransactionList != null
					&& paymentTransactionList.size() > 0) {
				for (PaymentTransaction paymentTransaction : paymentTransactionList) {
					List<ApplicantPostAssoc> txnWiseApplicantPostAssocList = applicantService
							.findByTxnOrderNo(paymentTransaction.getOrderNo());
					paymentTransaction
							.setApplicantPostAssocList(txnWiseApplicantPostAssocList);
				}
			}

			List<ApplicantPostAssoc> applicantPostAssocList = applicantService
					.findApplicantPostAssocsByApplicant(applicant);

			model.addAttribute("paymentTransactionList", paymentTransactionList);
			model.addAttribute("applicantPostAssocList", applicantPostAssocList);
			model.addAttribute("applicant", applicant);
			model.addAttribute("result", Boolean.TRUE);
		}

		model.addAttribute("applicationId", applicationId);

		return "paymentSearchForm";
	}

	@RequestMapping(params = "operation=markPostAsSubmitted")
	public @ResponseBody Map markPostAsSubmitted(Long postAssocId,
			String orderNo, String applicationId) {
		log.info("Marking the post id {} as submitted for with order No {}",
				postAssocId, orderNo);
		Map<String, Object> result = new HashMap<>();

		boolean success = true;
		Integer feeApplicableToApplicant = 0;
		Integer amountPaidForOrderNo = 0;
		Integer postCountApplicableAsPerPaidFees = 0;
		Integer submiitedApplicationsForOrderNo = 0;
		try {
			Applicant applicant = applicantService
					.findApplicantByApplicationId(applicationId);
			if (applicant != null) {
				feeApplicableToApplicant = applicantService
						.getPostFees(applicant);
			}
			PaymentTransaction pt = paymentTransactionService
					.findPaymentTransactionByOrderNo(orderNo);
			if (pt != null) {
				amountPaidForOrderNo = pt.getAmount().intValue();
			}
			postCountApplicableAsPerPaidFees = amountPaidForOrderNo
					/ feeApplicableToApplicant;
			submiitedApplicationsForOrderNo = applicantService
					.findSubmittedApplicantPostAssocCountByOrderNo(
							new Long(StatusEnum.SUBMITTED.getId()), orderNo)
					.intValue();
			if (pt.getStatus() == PaymentTransactionStatusEnum.SUCCESS.getId()) {
				challanService.markPostAsSubmitted(postAssocId, orderNo);
			} else {
				success = false;
			}
		} catch (Exception e) {
			log.error(e.getMessage());
			success = false;
		}
		result.put("success", success);
		return result;
	}

	@RequestMapping(params = "operation=correctChallanOrderNo")
	public void correctChallanOrderNo(HttpServletRequest request,
			HttpServletResponse response) throws ParseException, IOException {
		response.setContentType("text/csv");
		String reportName = "PendingChallanList_UpdatedOrderNo_12To29Jan.csv";
		response.setHeader("Content-disposition", "attachment;filename="
				+ reportName);

		List<String> rows = new ArrayList<String>();
		rows.add("S. No,Applicant ID,Application ID,Mobile No,Email Address,Old Reference / Registration No.,New Reference / Registration No.");
		rows.add("\n");

		StringBuilder strBldr = null;
		int serialNo = 1;
		Date stDate = new SimpleDateFormat("dd/MM/yyyy").parse(request
				.getParameter("fromOrderDate"));
		Date toDate = new SimpleDateFormat("dd/MM/yyyy").parse(request
				.getParameter("toOrderDate"));
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String parsedFromDate = formatter.format(stDate);
		String parsedtoDate = formatter.format(toDate);
		List<PaymentTransaction> pendingChallanListForDates = paymentTransactionService
				.findPendingOfflinePaymentsBetweenDates(
						PaymentModeEnum.OFFLINE.getId(),
						PaymentTransactionStatusEnum.PENDING.getId(),
						parsedFromDate, parsedtoDate);
		for (PaymentTransaction pt : pendingChallanListForDates) {
			String applicantId = pt.getApplicantId().toString();
			String applicationId = "";
			String mobileNo = "";
			String emailAddress = "";

			// Applicant applicant =
			// applicantService.findApplicantById(Long.parseLong(applicantId));
			/*
			 * if(applicant!=null){ applicationId =
			 * applicant.getApplicationId(); mobileNo =
			 * applicant.getMobileNumber(); emailAddress =
			 * applicant.getEmailAddress(); }
			 */
			String oldOrderNo = pt.getOrderNo();
			String newOrderNo = applicantService.getRandomNo();

			paymentTransactionService.updateOfflinePaymentTransactionOrderNo(
					oldOrderNo, newOrderNo);
			// applicantService.updateApplicantPostAssocTransactionOrderNo(oldOrderNo,
			// newOrderNo);
			strBldr = new StringBuilder();
			// strBldr.append(serialNo).append(",");
			strBldr.append(applicantId).append(",");
			// strBldr.append(applicationId).append(",");
			// strBldr.append(mobileNo).append(",");
			// strBldr.append(emailAddress).append(",");
			strBldr.append("*" + oldOrderNo).append(",");
			strBldr.append("*" + newOrderNo).append(",");
			rows.add(strBldr.toString());
			rows.add("\n");

			serialNo++;
		}

		response.setCharacterEncoding("UTF-8");
		Iterator<String> iter = rows.iterator();
		while (iter.hasNext()) {
			String outputString = (String) iter.next();
			response.getOutputStream().print(outputString);
		}

		response.getOutputStream().flush();
	}
	
	@RequestMapping(params = "operation=showPostPaymentCount")
	public @ResponseBody
	Map showPostPaymentCount(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		Map<String, Object> result = new HashMap<>();
		Date stDate = new SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fromDateForCount"));
		Date toDate = new SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("toDateForCount"));
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String parsedFromDate = formatter.format(stDate);
		String parsedtoDate = formatter.format(toDate);

		boolean success = true;
		Long successfulOnlinePaymentPostCount = 0L;
		Long successfulOfflinePaymentPostCount = 0L;
		Long failedOnlinePaymentPostCount = 0L;
		Long failedOfflinePaymentPostCount = 0L;
		try {
			successfulOnlinePaymentPostCount = applicantPostAssocService.countApplicantPostAssocByPaymentModePaymentStatusBetweenDates(PaymentModeEnum.ONLINE.getId(), PaymentTransactionStatusEnum.SUCCESS.getId(), parsedFromDate, parsedtoDate);
			successfulOfflinePaymentPostCount =applicantPostAssocService.countApplicantPostAssocByPaymentModePaymentStatusBetweenDates(PaymentModeEnum.OFFLINE.getId(), PaymentTransactionStatusEnum.SUCCESS.getId(), parsedFromDate, parsedtoDate);
			failedOnlinePaymentPostCount =applicantPostAssocService.countApplicantPostAssocByPaymentModePaymentStatusBetweenDates(PaymentModeEnum.ONLINE.getId(), PaymentTransactionStatusEnum.FAILURE.getId(), parsedFromDate, parsedtoDate);
			failedOfflinePaymentPostCount =applicantPostAssocService.countApplicantPostAssocByPaymentModePaymentStatusBetweenDates(PaymentModeEnum.OFFLINE.getId(), PaymentTransactionStatusEnum.FAILURE.getId(), parsedFromDate, parsedtoDate);
		} catch(Exception e){
			log.error(e.getMessage());
			success = false;
		}
		result.put("success", success);
		result.put("successfulOnlinePaymentPostCount", successfulOnlinePaymentPostCount);
		result.put("successfulOfflinePaymentPostCount", successfulOfflinePaymentPostCount);
		result.put("failedOnlinePaymentPostCount", failedOnlinePaymentPostCount);
		result.put("failedOfflinePaymentPostCount", failedOfflinePaymentPostCount);
		return result;
	}
	
	@RequestMapping(params="operation=showPostPaymentMismatchCount")
	public String showPostPaymentMismatchCount(Model model, HttpServletRequest request, PageDetail pageDetail) throws ParseException{
		log.debug("Finding all Payment Mismatch Count entries");
		String fromDate = request.getParameter("fromDateForCount");
		String toDate = request.getParameter("toDateForCount");
		if(fromDate!=null && fromDate.isEmpty()){
			fromDate = systemSettingService.getSystemSetting(SystemSettingEnum.START_DATE_OF_REGISTRATION);
		}
		if(toDate!=null && toDate.isEmpty()){
			String toDateString = LocalDate.now().toString();
			String[] stArr = toDateString.split("-");
			toDate = stArr[2]+"/"+stArr[1]+"/"+stArr[0];
		}
		Date stDateForCount = new SimpleDateFormat("dd/MM/yyyy").parse(fromDate);
		Date toDateForCount = new SimpleDateFormat("dd/MM/yyyy").parse(toDate);
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String parsedFromDate = formatter.format(stDateForCount);
		String parsedtoDate = formatter.format(toDateForCount);
		pageDetail.setSize(50);
		Integer pageHasRecords = applicantService.filterApplicantPostPaymentMismatchListSize(parsedFromDate, parsedtoDate);
		Page<ApplicantPostPaymentMismatch> pageData = applicantService.filterApplicantPostPaymentMismatchList(parsedFromDate, parsedtoDate, pageDetail);
		model.addAttribute("pageHasRecords", pageHasRecords);
        model.addAttribute("pageData", pageData);
        model.addAttribute("pageDetail", pageDetail);
        
        int correntPageNo = pageDetail.getPageNumber();
        
        int totalPages = 0;
        int pageSize = pageDetail.getSize();
        int startIndex = 1;
        int endIndex = pageSize;
        
        if (pageHasRecords % pageSize == 0) {
        	totalPages = (int) (pageHasRecords / pageSize);
        } else {
        	totalPages = (int) (pageHasRecords / pageSize);
        	totalPages++;
        }
        
        //--- Pagination Logic Starts ---
        if ( totalPages >= pageSize ) {
        	for (int i = 0; i <= (int) Math.ceil(pageSize / 2); i++) {
				int tempPage = (correntPageNo + i);
				if ( tempPage >= totalPages ) {
					endIndex = tempPage;
					startIndex = endIndex - pageSize;

					break;
				}
			}
		}

        if ( correntPageNo > endIndex ) {
        	endIndex = correntPageNo;
		}

        if ( endIndex > totalPages ) {
			endIndex = totalPages;
		}
        //--- Pagination Logic Ends ---
        
        model.addAttribute("totalPages", totalPages);

        model.addAttribute("beginPage", correntPageNo);
        model.addAttribute("beginIndex", startIndex);
        model.addAttribute("endIndex", endIndex);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("startDate", fromDate);
        model.addAttribute("toDate", toDate);
        
        if(pageDetail.isNewPage()){
        	return "postPaymentMismatchResultList";
        }else{
        	return "postPaymentMismatchList";
        }
        
		
	}
	
	@Autowired
    private ApplicationProperties applicationProperties;
	
	@RequestMapping(params = "operation=submitQueryList")
	public void submitQueryList(Model model, HttpServletRequest request, HttpServletResponse response) throws ParseException, IOException{
		
		Date stDate = new SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fromDate"));
		Date toDate = new SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("toDate"));
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String parsedFromDate = formatter.format(stDate);
		String parsedtoDate = formatter.format(toDate);
		List<PaymentTransaction> listOfOPaymentTranscation = paymentTransactionService.findListPaymentTranscationNoBetweenDates(parsedFromDate, parsedtoDate);
		if(listOfOPaymentTranscation.size()>=1 && listOfOPaymentTranscation != null ){
		String reportName =parsedFromDate+"_to_"+parsedtoDate+".xlsx";
		//paymentTransactionService.generateQueryApiResponse(listOfOPaymentTranscation,reportName);
		//List<OnlineQueryApiResponse> listOfOnlineQueryApiResponse = paymentTransactionService.getListOnlineQueryResponse(listOfOrderNo);
		//paymentTransactionService.generateonlineQueryApiResponseExcel(listOfOnlineQueryApiResponse);
		String reportLocation = applicationProperties.getResources().getBasePath()+ 
				File.separator + Constants.BASE_DOWNLOAD_DIR + File.separator + Constants.ONLINE_QUERY_API_BASE_DIR;
		
		
		//paymentTransactionService.generateQueryApiResponse2(listOfOPaymentTranscation,reportName,response);
		paymentTransactionService.generateQueryApiResponse(listOfOPaymentTranscation,reportName);
		reportName = reportName+"onlineQueryApiResp.xlsx";
		String reportNameWithPath = reportLocation+ File.separator + reportName;
		FileUtils.downloadFile(response, reportNameWithPath, reportName, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		//return "redirect:challan?operation=onlineQueryApi";
		}else{
			response.sendRedirect("challan?operation=onlineQueryApi");
		}
	}

}
