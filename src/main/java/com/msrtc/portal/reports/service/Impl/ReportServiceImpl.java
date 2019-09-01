package com.msrtc.portal.reports.service.Impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.msrtc.portal.applicant.domain.Post;
import com.msrtc.portal.applicant.repository.ApplicantRepository;
import com.msrtc.portal.applicant.repository.PostRepository;
import com.msrtc.portal.core.common.util.Constants;
import com.msrtc.portal.core.common.util.ExcelWriterUtils;
import com.msrtc.portal.core.config.ApplicationProperties;
import com.msrtc.portal.payment.domain.PaymentModeEnum;
import com.msrtc.portal.payment.domain.PaymentTransactionStatusEnum;
import com.msrtc.portal.payment.service.PaymentTransactionService;
import com.msrtc.portal.reports.dto.PostReportDataDTO;
import com.msrtc.portal.reports.dto.ReportDataDTO;
import com.msrtc.portal.reports.service.ReportService;

@Service(value = "reportService")
@Transactional(readOnly = true)
public class ReportServiceImpl implements ReportService{
	
	@Autowired
	PaymentTransactionService paymentTransactionService;
	
	@Autowired
	ApplicantRepository applicantRepository;
	
	@Autowired
	PostRepository postRepository;
	
	@Autowired
	ApplicationProperties applicationProperties;
	
	@Autowired
	ReportService reportService;

	@Override
	public ReportDataDTO downloadReport(String fromDate, String toDate) {
		List<Post> postList = postRepository.findAllActivePost();
		//Map<Long, String> postIdTitleMap = new HashMap<Long, String>();
		Map<String, PostReportDataDTO> postReportDataDtoMap =  new HashMap<String, PostReportDataDTO>();
		for(Post p : postList){
			//postIdTitleMap.put(p.getPostId(), p.getPostTitle());
			postReportDataDtoMap.put(p.getPostId().toString(), new PostReportDataDTO(p.getPostId().intValue(), p.getPostTitle()));
		}
		// TODO Auto-generated method stub
		String totalRegistrationCount = applicantRepository.totalRegisteredApplicantsCount(fromDate, toDate).toString();
		String numberOfChallangeneratedCount = applicantRepository.totalChallanGeneratedCount(fromDate, toDate).toString();
		List<Object[]> applicantCountByGenderList = applicantRepository.totalApplicantCountByGender(fromDate, toDate);
		String totalMaleRegistrationCount = "0";
		String totalFemaleRegistrationCount = "0";
		
		for (Object obj[] : applicantCountByGenderList) {
			if(obj[0]!=null && Integer.parseInt(obj[0].toString())==0){
				totalFemaleRegistrationCount=obj[1].toString()!=null?obj[1].toString():String.valueOf(0);
			}else if(obj[0]!=null && Integer.parseInt(obj[0].toString())==1){
				totalMaleRegistrationCount=obj[1].toString()!=null?obj[1].toString():String.valueOf(0);
			}
		}
		BigDecimal offlineTransactionsAmount = new BigDecimal(0);
		offlineTransactionsAmount = paymentTransactionService.findTotalOfflineAmountByPaymentModeAndStatusBetweenDates(PaymentModeEnum.OFFLINE.getId(), PaymentTransactionStatusEnum.SUCCESS.getId(), fromDate, toDate);

		BigDecimal onlineTransactionsAmount = new BigDecimal(0);
		onlineTransactionsAmount = paymentTransactionService.findTotalOnlineAmountByPaymentModeAndStatusBetweenDates(PaymentModeEnum.ONLINE.getId(), PaymentTransactionStatusEnum.SUCCESS.getId(), fromDate, toDate);

		BigDecimal totalAmount = new BigDecimal(0);

		offlineTransactionsAmount = offlineTransactionsAmount != null ? offlineTransactionsAmount : new BigDecimal(0);
		onlineTransactionsAmount = onlineTransactionsAmount != null ? onlineTransactionsAmount : new BigDecimal(0);

		totalAmount = offlineTransactionsAmount.add(onlineTransactionsAmount);
		
		Integer offlineTransactionsAmountInteger = offlineTransactionsAmount.intValue();
		Integer onlineTransactionsAmountInteger = onlineTransactionsAmount.intValue();
		Integer totalAmountInteger = totalAmount.intValue();
		String onlineAmount = onlineTransactionsAmountInteger.toString();
		String offlineAmount = offlineTransactionsAmountInteger.toString();
		String totalAmountCollected = totalAmountInteger.toString();
		
		
		List<Object[]> successfulApplicantCountPostWiseGenderWiseList = applicantRepository.successfulApplicantCountPostWiseGenderWise(fromDate, toDate);
		for(Object obj[] : successfulApplicantCountPostWiseGenderWiseList){
			//postReportDataDtoMap.get(obj[0].toString()).setPostId(Integer.parseInt(obj[0].toString()));
			//postReportDataDtoMap.get(obj[0].toString()).setPostTitle(postIdTitleMap.get(Long.parseLong(obj[0].toString())));
			if(obj[1]!=null && Integer.parseInt(obj[1].toString())==0){
				postReportDataDtoMap.get(obj[0].toString()).setTotalPaidFealeApplicationCount(obj[2].toString()!=null?obj[2].toString():String.valueOf(0));
			}else if(obj[1]!=null && Integer.parseInt(obj[1].toString())==1){
				postReportDataDtoMap.get(obj[0].toString()).setTotalPaidMaleApplicationCount(obj[2].toString()!=null?obj[2].toString():String.valueOf(0));
			}
		}
		
		List<Object[]> applicantCountPostWise = applicantRepository.applicantCountPostWise(fromDate, toDate);
		for(Object obj[] : applicantCountPostWise){
			postReportDataDtoMap.get(obj[0].toString()).setTotalApplicationCount(obj[1].toString()!=null?obj[1].toString():String.valueOf(0));
		}
		
		List<Object[]> successFulApplicantCountOnlineModePostWiseGenderWiseList = applicantRepository.successFulApplicantCountOnlineModePostWiseGenderWise(fromDate, toDate);
		for(Object obj[] : successFulApplicantCountOnlineModePostWiseGenderWiseList){
			if(obj[1]!=null && Integer.parseInt(obj[1].toString())==0){
				postReportDataDtoMap.get(obj[0].toString()).setTotalOnlinePaidFemaleApplicationCount(obj[2].toString()!=null?obj[2].toString():String.valueOf(0));
			}else if(obj[1]!=null && Integer.parseInt(obj[1].toString())==1){
				postReportDataDtoMap.get(obj[0].toString()).setTotalOnlinePaidMaleApplicationCount(obj[2].toString()!=null?obj[2].toString():String.valueOf(0));
			}
		}
		
		List<Object[]> successfulApplicantCountOfflineModePostWiseGenderWiseList = applicantRepository.successfulApplicantCountOfflineModePostWiseGenderWise(fromDate, toDate);
		for(Object obj[] : successfulApplicantCountOfflineModePostWiseGenderWiseList){
			if(obj[1]!=null && Integer.parseInt(obj[1].toString())==0){
				postReportDataDtoMap.get(obj[0].toString()).setTotalOfflinePaidFemaleApplivationCount(obj[2].toString()!=null?obj[2].toString():String.valueOf(0));
			}else if(obj[1]!=null && Integer.parseInt(obj[1].toString())==1){
				postReportDataDtoMap.get(obj[0].toString()).setTotalOfflinePaidMaleApplivationCount(obj[2].toString()!=null?obj[2].toString():String.valueOf(0));
			}
		}
		
		List<Object[]> successfulApplicantCountOpenCategoryPostWiseGenderWiseList = applicantRepository.successfulApplicantCountOpenCategoryPostWiseGenderWise(fromDate, toDate);
		for(Object obj[] : successfulApplicantCountOpenCategoryPostWiseGenderWiseList){
			if(obj[1]!=null && Integer.parseInt(obj[1].toString())==0){
				postReportDataDtoMap.get(obj[0].toString()).setTotalOpenCategoryPaidFemaleApplicationCount(obj[2].toString()!=null?obj[2].toString():String.valueOf(0));
			}else if(obj[1]!=null && Integer.parseInt(obj[1].toString())==1){
				postReportDataDtoMap.get(obj[0].toString()).setTotalOpenCategoryPaidMaleApplicationCount(obj[2].toString()!=null?obj[2].toString():String.valueOf(0));
			}
		}
		
		List<Object[]> successfulApplicantCountReservedCategoryPostWiseGenderWiseList = applicantRepository.successfulApplicantCountReservedCategoryPostWiseGenderWise(fromDate, toDate);
		for(Object obj[] : successfulApplicantCountReservedCategoryPostWiseGenderWiseList){
			if(obj[1]!=null && Integer.parseInt(obj[1].toString())==0){
				postReportDataDtoMap.get(obj[0].toString()).setTotalReservedCategoryPaidFemaleApplicationCount(obj[2].toString()!=null?obj[2].toString():String.valueOf(0));
			}else if(obj[1]!=null && Integer.parseInt(obj[1].toString())==1){
				postReportDataDtoMap.get(obj[0].toString()).setTotalReservedCategoryPaidMaleApplicationCount(obj[2].toString()!=null?obj[2].toString():String.valueOf(0));
			}
		}
		
		Integer totalPostApplicationCount=0;
		Integer totalOnlineMalePostApplicationCount=0;
		Integer totalOnlineFemalePostApplicationCount=0;
		Integer totalOnlinePostApplicationCount=0;
		Integer totalOfflineMalePostApplicationCount=0;
		Integer totalOfflineFemalePostApplicationCount=0;
		Integer totalOfflinePostApplicationCount=0;
		Integer totalOpenCategoryMaleApplicationCount=0;
		Integer totalOpenCategoryFemaleApplicationCount=0;
		Integer totalReservedCategoryMaleApplicationCount=0;
		Integer totalReservedCategoryFemaleApplicationCount=0;
		Integer totalMaleApplicationCount=0;
		Integer totalFemaleApplicationCount=0;
		Integer totalMaleFemaleApplicationCount=0;
		
		List<PostReportDataDTO> postReportDataDTOList = new ArrayList<PostReportDataDTO>(postReportDataDtoMap.values());
		for(PostReportDataDTO prddto : postReportDataDTOList){
			prddto.setTotalOnlinePaidApplicationCount(String.valueOf(Integer.parseInt(prddto.getTotalOnlinePaidMaleApplicationCount()!=null ? prddto.getTotalOnlinePaidMaleApplicationCount():String.valueOf(0))+Integer.parseInt(prddto.getTotalOnlinePaidFemaleApplicationCount()!=null?prddto.getTotalOnlinePaidFemaleApplicationCount():String.valueOf(0))));
			prddto.setTotalOfflinePaidApplicationCount(String.valueOf(Integer.parseInt(prddto.getTotalOfflinePaidFemaleApplivationCount()!=null?prddto.getTotalOfflinePaidFemaleApplivationCount():String.valueOf(0))+Integer.parseInt(prddto.getTotalOfflinePaidMaleApplivationCount()!=null?prddto.getTotalOfflinePaidMaleApplivationCount():String.valueOf(0))));
			prddto.setTotalPaidApplicantCount(String.valueOf(Integer.parseInt(prddto.getTotalPaidMaleApplicationCount()!=null?prddto.getTotalPaidMaleApplicationCount():String.valueOf(0))+Integer.parseInt(prddto.getTotalPaidFealeApplicationCount()!=null?prddto.getTotalPaidFealeApplicationCount():String.valueOf(0))));
			totalPostApplicationCount += Integer.parseInt(prddto.getTotalApplicationCount()!=null?prddto.getTotalApplicationCount():String.valueOf(0));
			totalOnlineMalePostApplicationCount += Integer.parseInt(prddto.getTotalOnlinePaidMaleApplicationCount()!=null?prddto.getTotalOnlinePaidMaleApplicationCount():String.valueOf(0));
			totalOnlineFemalePostApplicationCount += Integer.parseInt(prddto.getTotalOnlinePaidFemaleApplicationCount()!=null?prddto.getTotalOnlinePaidFemaleApplicationCount():String.valueOf(0));
			totalOnlinePostApplicationCount += Integer.parseInt(prddto.getTotalOnlinePaidApplicationCount()!=null?prddto.getTotalOnlinePaidApplicationCount():String.valueOf(0));
			totalOfflineMalePostApplicationCount += Integer.parseInt(prddto.getTotalOfflinePaidMaleApplivationCount()!=null?prddto.getTotalOfflinePaidMaleApplivationCount():String.valueOf(0));
			totalOfflineFemalePostApplicationCount += Integer.parseInt(prddto.getTotalOfflinePaidFemaleApplivationCount()!=null?prddto.getTotalOfflinePaidFemaleApplivationCount():String.valueOf(0));
			totalOfflinePostApplicationCount += Integer.parseInt(prddto.getTotalOfflinePaidApplicationCount()!=null?prddto.getTotalOfflinePaidApplicationCount():String.valueOf(0));
			totalOpenCategoryMaleApplicationCount += Integer.parseInt(prddto.getTotalOpenCategoryPaidMaleApplicationCount()!=null?prddto.getTotalOpenCategoryPaidMaleApplicationCount():String.valueOf(0));
			totalOpenCategoryFemaleApplicationCount += Integer.parseInt(prddto.getTotalOpenCategoryPaidFemaleApplicationCount()!=null?prddto.getTotalOpenCategoryPaidFemaleApplicationCount():String.valueOf(0));
			totalReservedCategoryMaleApplicationCount += Integer.parseInt(prddto.getTotalReservedCategoryPaidMaleApplicationCount()!=null?prddto.getTotalReservedCategoryPaidMaleApplicationCount():String.valueOf(0));
			totalReservedCategoryFemaleApplicationCount += Integer.parseInt(prddto.getTotalReservedCategoryPaidFemaleApplicationCount()!=null?prddto.getTotalReservedCategoryPaidFemaleApplicationCount():String.valueOf(0));
			totalMaleApplicationCount += Integer.parseInt(prddto.getTotalPaidMaleApplicationCount()!=null?prddto.getTotalPaidMaleApplicationCount():String.valueOf(0));
			totalFemaleApplicationCount += Integer.parseInt(prddto.getTotalPaidFealeApplicationCount()!=null?prddto.getTotalPaidFealeApplicationCount():String.valueOf(0));
			totalMaleFemaleApplicationCount += Integer.parseInt(prddto.getTotalPaidApplicantCount()!=null?prddto.getTotalPaidApplicantCount():String.valueOf(0));
		}

		Collections.sort(postReportDataDTOList, (p1, p2) -> p1.getPostId().compareTo(p2.getPostId()));

		ReportDataDTO rdDto = new ReportDataDTO();
		rdDto.setTotalRegistrationCount(totalRegistrationCount);
		rdDto.setTotalMaleRegistrationCount(totalMaleRegistrationCount);
		rdDto.setTotalFemaleRegistrationCount(totalFemaleRegistrationCount);
		rdDto.setNumberOfChallangeneratedCount(numberOfChallangeneratedCount);
		rdDto.setOnlineAmount(onlineAmount);
		rdDto.setOfflineAmount(offlineAmount);
		rdDto.setTotalAmount(totalAmountCollected);
		rdDto.setPostReportDataDTOs(postReportDataDTOList);
		rdDto.setTotalPostApplicationCount(totalPostApplicationCount.toString());
		rdDto.setTotalOnlineMalePostApplicationCount(totalOnlineMalePostApplicationCount.toString());
		rdDto.setTotalOnlineFemalePostApplicationCount(totalOnlineFemalePostApplicationCount.toString());
		rdDto.setTotalOnlinePostApplicationCount(totalOnlinePostApplicationCount.toString());
		rdDto.setTotalOfflineMalePostApplicationCount(totalOfflineMalePostApplicationCount.toString());
		rdDto.setTotalOfflineFemalePostApplicationCount(totalOfflineFemalePostApplicationCount.toString());
		rdDto.setTotalOfflinePostApplicationCount(totalOfflinePostApplicationCount.toString());
		rdDto.setTotalOpenCategoryMaleApplicationCount(totalOpenCategoryMaleApplicationCount.toString());
		rdDto.setTotalOpenCategoryFemaleApplicationCount(totalOpenCategoryFemaleApplicationCount.toString());
		rdDto.setTotalReservedCategoryMaleApplicationCount(totalReservedCategoryMaleApplicationCount.toString());
		rdDto.setTotalReservedCategoryFemaleApplicationCount(totalReservedCategoryFemaleApplicationCount.toString());
		rdDto.setTotalMaleApplicationCount(totalMaleApplicationCount.toString());
		rdDto.setTotalFemaleApplicationCount(totalFemaleApplicationCount.toString());
		rdDto.setTotalMaleFemaleApplicationCount(totalMaleFemaleApplicationCount.toString());
		return rdDto;
	}
	
	//===========================Generate reports==================================
	@Override
	public void genearteReports(Date startDate, Date endDate, String reportLocation, String reportFileName) throws ParseException, IOException{
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String parsedFromDate = formatter.format(startDate);
		String parsedtoDate = formatter.format(endDate);
		
		//String basePath = applicationProperties.getResources().getBasePath();
		//String reportLocation = basePath + File.separator + Constants.BASE_DOWNLOAD_DIR + File.separator + Constants.REPORTS_TO_MAIL;
		File dir = new File(reportLocation);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        
       // String reportFileName = parsedFromDate+"-to-"+parsedtoDate+ "_DailyReport.xlsx";
		String reportNameWithPath = reportLocation+ File.separator + reportFileName;
		//String reportName = "DailyReport.xlsx";
		ReportDataDTO rddto = reportService.downloadReport(parsedFromDate, parsedtoDate);
		XSSFWorkbook dailyReportWorkBook = ExcelWriterUtils.createWorkbook();
		Sheet sheet = ExcelWriterUtils.createSheet(dailyReportWorkBook, "dailyReportSheet");
		Row row0 = ExcelWriterUtils.createRow(sheet, 0);
		Cell row0cell0 = ExcelWriterUtils.createCell(row0, 0, "Total Registration Count ", ExcelWriterUtils.getBoldCellStyleLeftAligned(dailyReportWorkBook));
		Cell row0cell1 = ExcelWriterUtils.createCell(row0, 1, rddto.getTotalRegistrationCount()!=null?rddto.getTotalRegistrationCount():0, ExcelWriterUtils.getDefaultCellStyle(dailyReportWorkBook));
		Row row1 = ExcelWriterUtils.createRow(sheet, 1);
		Cell row1cell0 = ExcelWriterUtils.createCell(row1, 0, "Total Male Registration ", ExcelWriterUtils.getBoldCellStyleLeftAligned(dailyReportWorkBook));
		Cell row1cell1 = ExcelWriterUtils.createCell(row1, 1, rddto.getTotalMaleRegistrationCount()!=null?rddto.getTotalMaleRegistrationCount():0, ExcelWriterUtils.getDefaultCellStyle(dailyReportWorkBook));
		Row row2 = ExcelWriterUtils.createRow(sheet, 2);
		Cell row2cell0 = ExcelWriterUtils.createCell(row2, 0, "Total Female Registration ", ExcelWriterUtils.getBoldCellStyleLeftAligned(dailyReportWorkBook));
		Cell row2cell1 = ExcelWriterUtils.createCell(row2, 1, rddto.getTotalFemaleRegistrationCount()!=null?rddto.getTotalFemaleRegistrationCount():0, ExcelWriterUtils.getDefaultCellStyle(dailyReportWorkBook));
		Row row3 = ExcelWriterUtils.createRow(sheet, 3);
		Cell row3cell0 = ExcelWriterUtils.createCell(row3, 0, "No of Challans Generated ", ExcelWriterUtils.getBoldCellStyleLeftAligned(dailyReportWorkBook));
		Cell row3cell1 = ExcelWriterUtils.createCell(row3, 1, rddto.getNumberOfChallangeneratedCount()!=null?rddto.getNumberOfChallangeneratedCount():0, ExcelWriterUtils.getDefaultCellStyle(dailyReportWorkBook));
		Row row4 = ExcelWriterUtils.createRow(sheet, 4);
		Cell row4cell0 = ExcelWriterUtils.createCell(row4, 0, "Online Amount ", ExcelWriterUtils.getBoldCellStyleLeftAligned(dailyReportWorkBook));
		Cell row4cell1 = ExcelWriterUtils.createCell(row4, 1, rddto.getOnlineAmount()!=null?rddto.getOnlineAmount():0, ExcelWriterUtils.getDefaultCellStyle(dailyReportWorkBook));
		Row row5 = ExcelWriterUtils.createRow(sheet, 5);
		Cell row5cell0 = ExcelWriterUtils.createCell(row5, 0, "Offline Amount ", ExcelWriterUtils.getBoldCellStyleLeftAligned(dailyReportWorkBook));
		Cell row5cell1 = ExcelWriterUtils.createCell(row5, 1, rddto.getOfflineAmount()!=null?rddto.getOfflineAmount():0, ExcelWriterUtils.getDefaultCellStyle(dailyReportWorkBook));
		Row row6 = ExcelWriterUtils.createRow(sheet, 6);
		Cell row6cell0 = ExcelWriterUtils.createCell(row6, 0, "Total Amount ", ExcelWriterUtils.getBoldCellStyleLeftAligned(dailyReportWorkBook));
		Cell row6cell1 = ExcelWriterUtils.createCell(row6, 1, rddto.getTotalAmount()!=null?rddto.getTotalAmount():0, ExcelWriterUtils.getDefaultCellStyle(dailyReportWorkBook));
		Row row7 = ExcelWriterUtils.createRow(sheet, 7);
		Row row8 = ExcelWriterUtils.createRow(sheet, 8);
		Row row9 = ExcelWriterUtils.createRow(sheet, 9);
		Row row10 = ExcelWriterUtils.createRow(sheet, 10);
		ExcelWriterUtils.createMergedCell(sheet, "Post", 8, 8, 10, 0, 0,  ExcelWriterUtils.getBoldCellStyle(dailyReportWorkBook));
		ExcelWriterUtils.createMergedCell(sheet, "Application Count", 8, 8, 10, 1, 1,  ExcelWriterUtils.getBoldCellStyle(dailyReportWorkBook));
		ExcelWriterUtils.createMergedCell(sheet, "Application Confirmed Count (Payment Completed Successfully)", 8, 8, 8, 2, 14,  ExcelWriterUtils.getBoldCellStyle(dailyReportWorkBook));
		ExcelWriterUtils.createMergedCell(sheet, "Online", 9, 9, 9, 2, 4,  ExcelWriterUtils.getColoredBoldCellStyle(dailyReportWorkBook, IndexedColors.ROSE.getIndex()));
		ExcelWriterUtils.createMergedCell(sheet, "Offline", 9, 9, 9, 5, 7,  ExcelWriterUtils.getColoredBoldCellStyle(dailyReportWorkBook, IndexedColors.LIGHT_BLUE.getIndex()));
		ExcelWriterUtils.createMergedCell(sheet, "Open Category", 9, 9, 9, 8, 9,  ExcelWriterUtils.getColoredBoldCellStyle(dailyReportWorkBook,IndexedColors.GOLD.getIndex()));
		ExcelWriterUtils.createMergedCell(sheet, "Reserved Category", 9, 9, 9, 10, 11,  ExcelWriterUtils.getColoredBoldCellStyle(dailyReportWorkBook,IndexedColors.GOLD.getIndex()));
		ExcelWriterUtils.createMergedCell(sheet, "Total", 9, 9, 9, 12, 14,  ExcelWriterUtils.getColoredBoldCellStyle(dailyReportWorkBook,IndexedColors.LIGHT_ORANGE.getIndex()));
		
		Cell row10cell2 = ExcelWriterUtils.createCell(row10, 2, "Male", ExcelWriterUtils.getColoredBoldCellStyle(dailyReportWorkBook, IndexedColors.ROSE.getIndex()));
		Cell row10cell3 = ExcelWriterUtils.createCell(row10, 3, "Female", ExcelWriterUtils.getColoredBoldCellStyle(dailyReportWorkBook, IndexedColors.ROSE.getIndex()));
		Cell row10cell4 = ExcelWriterUtils.createCell(row10, 4, "Total", ExcelWriterUtils.getColoredBoldCellStyle(dailyReportWorkBook, IndexedColors.ROSE.getIndex()));
		Cell row10cell5 = ExcelWriterUtils.createCell(row10, 5, "Male", ExcelWriterUtils.getColoredBoldCellStyle(dailyReportWorkBook, IndexedColors.LIGHT_BLUE.getIndex()));
		Cell row10cell6 = ExcelWriterUtils.createCell(row10, 6, "Female", ExcelWriterUtils.getColoredBoldCellStyle(dailyReportWorkBook, IndexedColors.LIGHT_BLUE.getIndex()));
		Cell row10cell7 = ExcelWriterUtils.createCell(row10, 7, "Total", ExcelWriterUtils.getColoredBoldCellStyle(dailyReportWorkBook, IndexedColors.LIGHT_BLUE.getIndex()));
		Cell row10cell8 = ExcelWriterUtils.createCell(row10, 8, "Male", ExcelWriterUtils.getColoredBoldCellStyle(dailyReportWorkBook,IndexedColors.GOLD.getIndex()));
		Cell row10cell9 = ExcelWriterUtils.createCell(row10, 9, "Female", ExcelWriterUtils.getColoredBoldCellStyle(dailyReportWorkBook,IndexedColors.GOLD.getIndex()));
		Cell row10cell10 = ExcelWriterUtils.createCell(row10, 10, "Male", ExcelWriterUtils.getColoredBoldCellStyle(dailyReportWorkBook,IndexedColors.GOLD.getIndex()));
		Cell row10cell11 = ExcelWriterUtils.createCell(row10, 11, "Female", ExcelWriterUtils.getColoredBoldCellStyle(dailyReportWorkBook,IndexedColors.GOLD.getIndex()));
		Cell row10cell12 = ExcelWriterUtils.createCell(row10, 12, "Male", ExcelWriterUtils.getColoredBoldCellStyle(dailyReportWorkBook,IndexedColors.LIGHT_ORANGE.getIndex()));
		Cell row10cell13 = ExcelWriterUtils.createCell(row10, 13, "Female", ExcelWriterUtils.getColoredBoldCellStyle(dailyReportWorkBook,IndexedColors.LIGHT_ORANGE.getIndex()));
		Cell row10cell14 = ExcelWriterUtils.createCell(row10, 14, "Total", ExcelWriterUtils.getColoredBoldCellStyle(dailyReportWorkBook,IndexedColors.LIGHT_ORANGE.getIndex()));
		
		Integer postStartRowNo =11;
		
		for(PostReportDataDTO prddto : rddto.getPostReportDataDTOs()){
			Row row = ExcelWriterUtils.createRow(sheet, postStartRowNo);
			Cell postcell0 = ExcelWriterUtils.createCell(row, 0, prddto.getPostTitle(), ExcelWriterUtils.getDefaultCellStyleLeftAligned(dailyReportWorkBook));
			Cell postcell1 = ExcelWriterUtils.createCell(row, 1, prddto.getTotalApplicationCount()!=null?prddto.getTotalApplicationCount():"0", ExcelWriterUtils.getDefaultCellStyle(dailyReportWorkBook));
			Cell postcell2 = ExcelWriterUtils.createCell(row, 2, prddto.getTotalOnlinePaidMaleApplicationCount()!=null?prddto.getTotalOnlinePaidMaleApplicationCount():"0", ExcelWriterUtils.getColoredCellStyle(dailyReportWorkBook, IndexedColors.ROSE.getIndex()));
			Cell postcell3 = ExcelWriterUtils.createCell(row, 3, prddto.getTotalOnlinePaidFemaleApplicationCount()!=null?prddto.getTotalOnlinePaidFemaleApplicationCount():"0", ExcelWriterUtils.getColoredCellStyle(dailyReportWorkBook, IndexedColors.ROSE.getIndex()));
			Cell postcell4 = ExcelWriterUtils.createCell(row, 4, prddto.getTotalOnlinePaidApplicationCount()!=null?prddto.getTotalOnlinePaidApplicationCount():"0", ExcelWriterUtils.getColoredCellStyle(dailyReportWorkBook, IndexedColors.ROSE.getIndex()));
			Cell postcell5 = ExcelWriterUtils.createCell(row, 5, prddto.getTotalOfflinePaidMaleApplivationCount()!=null?prddto.getTotalOfflinePaidMaleApplivationCount():"0", ExcelWriterUtils.getColoredCellStyle(dailyReportWorkBook,IndexedColors.LIGHT_BLUE.getIndex()));
			Cell postcell6 = ExcelWriterUtils.createCell(row, 6, prddto.getTotalOfflinePaidFemaleApplivationCount()!=null?prddto.getTotalOfflinePaidFemaleApplivationCount():"0", ExcelWriterUtils.getColoredCellStyle(dailyReportWorkBook,IndexedColors.LIGHT_BLUE.getIndex()));
			Cell postcell7 = ExcelWriterUtils.createCell(row, 7, prddto.getTotalOfflinePaidApplicationCount()!=null?prddto.getTotalOfflinePaidApplicationCount():"0", ExcelWriterUtils.getColoredCellStyle(dailyReportWorkBook,IndexedColors.LIGHT_BLUE.getIndex()));
			Cell postcell8 = ExcelWriterUtils.createCell(row, 8, prddto.getTotalOpenCategoryPaidMaleApplicationCount()!=null?prddto.getTotalOpenCategoryPaidMaleApplicationCount():"0", ExcelWriterUtils.getColoredCellStyle(dailyReportWorkBook,IndexedColors.GOLD.getIndex()));
			Cell postcell9 = ExcelWriterUtils.createCell(row, 9, prddto.getTotalOpenCategoryPaidFemaleApplicationCount()!=null?prddto.getTotalOpenCategoryPaidFemaleApplicationCount():"0", ExcelWriterUtils.getColoredCellStyle(dailyReportWorkBook,IndexedColors.GOLD.getIndex()));
			Cell postcell10 = ExcelWriterUtils.createCell(row, 10, prddto.getTotalReservedCategoryPaidMaleApplicationCount()!=null?prddto.getTotalReservedCategoryPaidMaleApplicationCount():"0", ExcelWriterUtils.getColoredCellStyle(dailyReportWorkBook,IndexedColors.GOLD.getIndex()));
			Cell postcell11 = ExcelWriterUtils.createCell(row, 11, prddto.getTotalReservedCategoryPaidFemaleApplicationCount()!=null?prddto.getTotalReservedCategoryPaidFemaleApplicationCount():"0", ExcelWriterUtils.getColoredCellStyle(dailyReportWorkBook,IndexedColors.GOLD.getIndex()));
			Cell postcell12 = ExcelWriterUtils.createCell(row, 12, prddto.getTotalPaidMaleApplicationCount()!=null?prddto.getTotalPaidMaleApplicationCount():"0", ExcelWriterUtils.getColoredCellStyle(dailyReportWorkBook,IndexedColors.LIGHT_ORANGE.getIndex()));
			Cell postcell13 = ExcelWriterUtils.createCell(row, 13, prddto.getTotalPaidFealeApplicationCount()!=null?prddto.getTotalPaidFealeApplicationCount():"0", ExcelWriterUtils.getColoredCellStyle(dailyReportWorkBook,IndexedColors.LIGHT_ORANGE.getIndex()));
			Cell postcell14 = ExcelWriterUtils.createCell(row, 14, prddto.getTotalPaidApplicantCount()!=null?prddto.getTotalPaidApplicantCount():"0", ExcelWriterUtils.getColoredCellStyle(dailyReportWorkBook,IndexedColors.LIGHT_ORANGE.getIndex()));
			postStartRowNo++;
		}
		
		Row posttotalrow = ExcelWriterUtils.createRow(sheet, postStartRowNo);
		Cell posttotalrowcell0 = ExcelWriterUtils.createCell(posttotalrow, 0, "Total", ExcelWriterUtils.getBoldCellStyleLeftAligned(dailyReportWorkBook));
		Cell posttotalrowcell1 = ExcelWriterUtils.createCell(posttotalrow, 1, rddto.getTotalPostApplicationCount()!=null?rddto.getTotalPostApplicationCount():"0", ExcelWriterUtils.getBoldCellStyle(dailyReportWorkBook));
		Cell posttotalrowcell2 = ExcelWriterUtils.createCell(posttotalrow, 2, rddto.getTotalOnlineMalePostApplicationCount()!=null?rddto.getTotalOnlineMalePostApplicationCount():"0", ExcelWriterUtils.getColoredCellStyle(dailyReportWorkBook, IndexedColors.ROSE.getIndex()));
		Cell posttotalrowcell3 = ExcelWriterUtils.createCell(posttotalrow, 3, rddto.getTotalOnlineFemalePostApplicationCount()!=null?rddto.getTotalOnlineFemalePostApplicationCount():"0", ExcelWriterUtils.getColoredCellStyle(dailyReportWorkBook, IndexedColors.ROSE.getIndex()));
		Cell posttotalrowcell4 = ExcelWriterUtils.createCell(posttotalrow, 4, rddto.getTotalOnlinePostApplicationCount()!=null?rddto.getTotalOnlinePostApplicationCount():"0", ExcelWriterUtils.getColoredCellStyle(dailyReportWorkBook, IndexedColors.ROSE.getIndex()));
		Cell posttotalrowcell5 = ExcelWriterUtils.createCell(posttotalrow, 5, rddto.getTotalOfflineMalePostApplicationCount()!=null?rddto.getTotalOfflineMalePostApplicationCount():"0", ExcelWriterUtils.getColoredCellStyle(dailyReportWorkBook,IndexedColors.LIGHT_BLUE.getIndex()));
		Cell posttotalrowcell6 = ExcelWriterUtils.createCell(posttotalrow, 6, rddto.getTotalOfflineFemalePostApplicationCount()!=null?rddto.getTotalOfflineFemalePostApplicationCount():"0", ExcelWriterUtils.getColoredCellStyle(dailyReportWorkBook,IndexedColors.LIGHT_BLUE.getIndex()));
		Cell posttotalrowcell7 = ExcelWriterUtils.createCell(posttotalrow, 7, rddto.getTotalOfflinePostApplicationCount()!=null?rddto.getTotalOfflinePostApplicationCount():"0", ExcelWriterUtils.getColoredCellStyle(dailyReportWorkBook,IndexedColors.LIGHT_BLUE.getIndex()));
		Cell posttotalrowcell8 = ExcelWriterUtils.createCell(posttotalrow, 8, rddto.getTotalOpenCategoryMaleApplicationCount()!=null?rddto.getTotalOpenCategoryMaleApplicationCount():"0", ExcelWriterUtils.getColoredCellStyle(dailyReportWorkBook,IndexedColors.GOLD.getIndex()));
		Cell posttotalrowcell9 = ExcelWriterUtils.createCell(posttotalrow, 9, rddto.getTotalOpenCategoryFemaleApplicationCount()!=null?rddto.getTotalOpenCategoryFemaleApplicationCount():"0", ExcelWriterUtils.getColoredCellStyle(dailyReportWorkBook,IndexedColors.GOLD.getIndex()));
		Cell posttotalrowcell10 = ExcelWriterUtils.createCell(posttotalrow, 10, rddto.getTotalReservedCategoryMaleApplicationCount()!=null?rddto.getTotalReservedCategoryMaleApplicationCount():"0", ExcelWriterUtils.getColoredCellStyle(dailyReportWorkBook,IndexedColors.GOLD.getIndex()));
		Cell posttotalrowcell11 = ExcelWriterUtils.createCell(posttotalrow, 11, rddto.getTotalReservedCategoryFemaleApplicationCount()!=null?rddto.getTotalReservedCategoryFemaleApplicationCount():"0", ExcelWriterUtils.getColoredCellStyle(dailyReportWorkBook,IndexedColors.GOLD.getIndex()));
		Cell posttotalrowcell12 = ExcelWriterUtils.createCell(posttotalrow, 12, rddto.getTotalMaleApplicationCount()!=null?rddto.getTotalMaleApplicationCount():"0", ExcelWriterUtils.getColoredCellStyle(dailyReportWorkBook,IndexedColors.LIGHT_ORANGE.getIndex()));
		Cell posttotalrowcell13 = ExcelWriterUtils.createCell(posttotalrow, 13, rddto.getTotalFemaleApplicationCount()!=null?rddto.getTotalFemaleApplicationCount():"0", ExcelWriterUtils.getColoredCellStyle(dailyReportWorkBook,IndexedColors.LIGHT_ORANGE.getIndex()));
		Cell posttotalrowcell14 = ExcelWriterUtils.createCell(posttotalrow, 14, rddto.getTotalMaleFemaleApplicationCount()!=null?rddto.getTotalMaleFemaleApplicationCount():"0", ExcelWriterUtils.getColoredCellStyle(dailyReportWorkBook,IndexedColors.LIGHT_ORANGE.getIndex()));
		
		FileOutputStream fileOut = new FileOutputStream(reportNameWithPath);
		
		//response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		//response.setHeader("Content-disposition", "attachment;filename="+reportName);
		dailyReportWorkBook.write(fileOut);
        fileOut.close();
		
	}

}
