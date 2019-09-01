package com.msrtc.portal.applicant.util.post;

import org.apache.commons.lang3.StringUtils;

import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Table;
import com.msrtc.portal.applicant.dto.UndertakingDTO;
import com.msrtc.portal.applicant.util.PDFUtil;

public class SecurityInspectorJuniorPostDetailsTableCreator {
	private UndertakingDTO dto;

    public SecurityInspectorJuniorPostDetailsTableCreator(UndertakingDTO dto){
        this.dto = dto;
    }

    public Table create() {
        Table table = new Table(4);
        
        table.addCell(PDFUtil.createBoldDataCell("प्राधान्य:"));
        table.addCell(PDFUtil.createDataCell("अतांत्रिक - " + PDFUtil.checkPriority(dto.getPriority())));
        table.addCell(PDFUtil.createBoldDataCell(""));
        table.addCell(PDFUtil.createDataCell(""));
        
        table.addCell(PDFUtil.createBoldDataCell("मान्यताप्राप्त विद्यापीठाचा कोणत्याही शाखेचा पदवीधारक:"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isGraduateFromAffiliatedInstitute())));
        Cell cellDegreeName = null;
        Cell cellUniversityName = null;
        if (dto.isGraduateFromAffiliatedInstitute()) {
        	cellDegreeName = PDFUtil.createDataCell(dto.getDegreeName());
        	cellUniversityName = PDFUtil.createDataCell(dto.getUniversityName());
        } else {
        	cellDegreeName = PDFUtil.createDataCell("");
        	cellUniversityName = PDFUtil.createDataCell("");
        }
        table.addCell(PDFUtil.createBoldDataCell("पदवीचे नाव:"));
        table.addCell(cellDegreeName);
        
        
        table.addCell(PDFUtil.createBoldDataCell("विद्यापीठाचे नाव:"));
        table.addCell(cellUniversityName);         
       /* table.addCell(PDFUtil.createBoldDataCell("अतिरिक्त शैक्षणिक माहिती:"));
        table.addCell(PDFUtil.createDataCell(StringUtils.isBlank(dto.getOtherQualificationDetails()) ? "" : dto.getOtherQualificationDetails()));*/
        
        table.addCell(PDFUtil.createBoldDataCell("उमेदवार \"एमएस-सीआयटी\" (MS-CIT) / तत्सम शासनमान्य संस्थेचा संगणक कोर्स उत्तीर्ण असावा:"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isMscitOrGaccc())));
        table.addCell(PDFUtil.createBoldDataCell("शारीरिक पात्रता:उंची:पुरुष उमेदवारांसाठी: किमान (१६५ से.मी.)महिला उमेदवारांसाठी: किमान (१५५ से.मी.) छाती ७८ से.मी. न फुगविता (पुरुष उमेदवारांसाठी):"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isPhysicalQualificationHeight()))); //heightWithinRange
        
        return table;
    }
}
