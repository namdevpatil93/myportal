package com.msrtc.portal.reports.service;

import java.io.IOException;
import java.text.ParseException;
import java.util.Date;

import com.msrtc.portal.reports.dto.ReportDataDTO;

public interface ReportService {

	ReportDataDTO downloadReport(String fromDate, String toDate);
	
	void genearteReports(Date startDate, Date endDate, String reportLocation, String reportFileName) throws ParseException, IOException;
	
}
