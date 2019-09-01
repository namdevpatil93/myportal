package com.msrtc.portal.applicant.util.post;

import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Table;
import com.msrtc.portal.applicant.dto.UndertakingDTO;
import com.msrtc.portal.applicant.util.PDFUtil;

public class SrComputerOperatorJrPostDetailsTableCreator {
	private UndertakingDTO dto;

    public SrComputerOperatorJrPostDetailsTableCreator(UndertakingDTO dto){
        this.dto = dto;
    }
    
    public Table create() {
        Table table = new Table(4);
        
        table.addCell(PDFUtil.createBoldDataCell("प्राधान्य:"));
        table.addCell(PDFUtil.createDataCell("तांत्रिक - " + PDFUtil.checkPriority(dto.getPriority())));
        table.addCell(PDFUtil.createBoldDataCell(""));
        table.addCell(PDFUtil.createDataCell(""));
        
        table.addCell(PDFUtil.createBoldDataCell("मान्यताप्राप्त विद्यापीठाचा संगणकीय / माहिती व तंत्रज्ञान विषयातील पदवीधारक / समकक्ष पदवीधारक अथवा समकक्ष शाखेमधील उच्च शैक्षणिक अर्हताधारक:"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isItEngineer())));
        table.addCell(PDFUtil.createBoldDataCell("पदवीचे नाव:"));
        Cell cellDegreeName = null;
        Cell cellUniversityName = null;
        if(dto.isItEngineer()) {
        	cellDegreeName = PDFUtil.createDataCell(dto.getDegreeName());
        	cellUniversityName = PDFUtil.createDataCell(dto.getUniversityName());
        } else {
        	cellDegreeName = PDFUtil.createDataCell("");
        	cellUniversityName = PDFUtil.createDataCell("");
        }
        table.addCell(cellDegreeName);
        
        table.addCell(PDFUtil.createBoldDataCell("विद्यापीठाचे नाव:"));
        table.addCell(cellUniversityName);
        table.addCell(PDFUtil.createDataCell(""));
        table.addCell(PDFUtil.createDataCell(""));
        
        return table;
    }
}
