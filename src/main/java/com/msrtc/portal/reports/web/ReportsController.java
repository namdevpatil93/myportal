package com.msrtc.portal.reports.web;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.msrtc.portal.core.common.util.Constants;
import com.msrtc.portal.core.common.util.ExcelWriterUtils;
import com.msrtc.portal.core.common.util.FileUtils;
import com.msrtc.portal.core.config.ApplicationProperties;
import com.msrtc.portal.reports.dto.PostReportDataDTO;
import com.msrtc.portal.reports.dto.ReportDataDTO;
import com.msrtc.portal.reports.service.ReportService;

@Controller
@RequestMapping(value = { ReportsController.REPORTS_CONTROLLER_URL })
public class ReportsController {

	private final Logger log = LoggerFactory.getLogger(getClass());

	static final String REPORTS_CONTROLLER_URL = "/reports";
	
	@Autowired
	ReportService reportService;
	
	@Autowired
    private ApplicationProperties applicationProperties;
	
	@RequestMapping(params="operation=viewReports")
	public String viewReoprts(Model model){
		return "reports";
	}
	
	@RequestMapping(params="operation=downloadReport")
	public void downloadReport(HttpServletRequest request, HttpServletResponse response) throws IOException, ParseException {
		String basePath = applicationProperties.getResources().getBasePath();
		String reportLocation = basePath + File.separator + Constants.BASE_DOWNLOAD_DIR + File.separator + Constants.REPORTS_BASE_DIR;
		
		String reportNameWithPath = reportLocation+ File.separator + request.getParameter("reportFileName");
		String reportName = "DailyReport.xlsx";
		
        FileUtils.downloadFile(response, reportNameWithPath, reportName, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
	}
	
	@RequestMapping(params="operation=genearteReport")
	public String genearteReport(Model model, HttpServletRequest request) throws ParseException, IOException{
		Date stDate = new SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fromDate"));
		Date toDate = new SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("toDate"));
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String parsedFromDate = formatter.format(stDate);
		String parsedtoDate = formatter.format(toDate);
		
		ReportDataDTO rddto = reportService.downloadReport(parsedFromDate, parsedtoDate);
		String reportFileName = UUID.randomUUID().toString() + "_DailyReport.xlsx";
		 
		String basePath = applicationProperties.getResources().getBasePath();
		String reportLocation = basePath + File.separator + Constants.BASE_DOWNLOAD_DIR + File.separator + Constants.REPORTS_BASE_DIR;
			
		 reportService.genearteReports(stDate, toDate, reportLocation, reportFileName);
		/*String basePath = applicationProperties.getResources().getBasePath();
		String reportLocation = basePath + File.separator + Constants.BASE_DOWNLOAD_DIR + File.separator + Constants.REPORTS_BASE_DIR;
		File dir = new File(reportLocation);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        String reportFileName = UUID.randomUUID().toString() + "_DailyReport.xlsx";
		String reportNameWithPath = reportLocation+ File.separator + reportFileName;
		String reportName = "DailyReport.xlsx";
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
        fileOut.close();*/
        model.addAttribute("reportFileName", reportFileName);
        model.addAttribute("rddto", rddto);
        model.addAttribute("reportsFromDate",LocalDate.parse(parsedFromDate));
        model.addAttribute("reportsToDate",LocalDate.parse(parsedtoDate));
		return "reports";
	}
	
	
}
