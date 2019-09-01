package com.msrtc.portal.applicant.util.post;

import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Table;
import com.msrtc.portal.applicant.dto.UndertakingDTO;
import com.msrtc.portal.applicant.util.PDFUtil;

public class FireWardenJuniorPostDetailsTableCreator {
	private UndertakingDTO dto;

    public FireWardenJuniorPostDetailsTableCreator(UndertakingDTO dto){
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
        table.addCell(PDFUtil.createBoldDataCell("मान्यताप्राप्त शासकीय संस्थेची अग्निशमनाची पदवीका:"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isFireSafetyDegreeFromAffiliatedInstitute())));
        
        Cell cellFireAndSafetyDegreeName = null;
        Cell cellFireAndSafetyUniversityName = null;
        if (dto.isFireSafetyDegreeFromAffiliatedInstitute()) {
        	cellFireAndSafetyDegreeName = PDFUtil.createDataCell(dto.getFireAndSafetyDegreeName());
        	cellFireAndSafetyUniversityName = PDFUtil.createDataCell(dto.getFireAndSafetyUniversityName());
        } else {
        	cellFireAndSafetyDegreeName = PDFUtil.createDataCell("");
        	cellFireAndSafetyUniversityName = PDFUtil.createDataCell("");
        }        
        table.addCell(PDFUtil.createBoldDataCell("पदविकाचे नाव:"));
        table.addCell(cellFireAndSafetyDegreeName);        
        table.addCell(PDFUtil.createBoldDataCell("बोर्ड / विद्यापीठाचे नाव:"));
        table.addCell(cellFireAndSafetyUniversityName);         
        
        table.addCell(PDFUtil.createBoldDataCell("सेना दलातील अग्निशमनाची समकक्ष अर्हता ग्राह्य:"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isQualificationForMilitaryForce())));
        Cell cellMiltaryForceDegreeName = null;
        Cell cellMiltaryForceUniversityName = null;
        if (dto.isQualificationForMilitaryForce()) {
        	cellMiltaryForceDegreeName = PDFUtil.createDataCell(dto.getMiltaryForceDegreeName());
        	cellMiltaryForceUniversityName = PDFUtil.createDataCell(dto.getMiltaryForceUniversityName());
        } else {
        	cellMiltaryForceDegreeName = PDFUtil.createDataCell("");
        	cellMiltaryForceUniversityName = PDFUtil.createDataCell("");
        }
        table.addCell(PDFUtil.createBoldDataCell("पदविकाचे नाव:"));
        table.addCell(cellMiltaryForceDegreeName);
        
        table.addCell(PDFUtil.createBoldDataCell("बोर्ड / विद्यापीठाचे नाव:"));
        table.addCell(cellMiltaryForceUniversityName);         
        table.addCell(PDFUtil.createBoldDataCell("शारीरिक पात्रता: उंची: पुरुष उमेदवारांसाठी: किमान (१६५ से.मी.) महिला उमेदवारांसाठी: किमान (१५५ से.मी.) छाती ७८ से.मी. न फुगविता (पुरुष उमेदवारांसाठी):"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isPhysicalQualificationHeight()))); //heightWithinRange
        
        return table;
    }
}
