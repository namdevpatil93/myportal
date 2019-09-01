package com.msrtc.portal.applicant.util.post;

import org.apache.commons.lang3.StringUtils;

import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Table;
import com.msrtc.portal.applicant.dto.UndertakingDTO;
import com.msrtc.portal.applicant.util.PDFUtil;

public class StoreSuperviserJuniorPostDetailsTableCreator {
	private UndertakingDTO dto;

    public StoreSuperviserJuniorPostDetailsTableCreator(UndertakingDTO dto){
        this.dto = dto;
    }

    public Table create() {
        Table table = new Table(4);
        
        table.addCell(PDFUtil.createBoldDataCell("प्राधान्य:"));
        table.addCell(PDFUtil.createDataCell("अतांत्रिक - " + PDFUtil.checkPriority(dto.getPriority())));
        table.addCell(PDFUtil.createBoldDataCell(""));
        table.addCell(PDFUtil.createDataCell(""));
        
        table.addCell(PDFUtil.createBoldDataCell("मान्यताप्राप्त विद्यापीठाचा वाणिज्य अथवा विज्ञान पदवीधर / ऑटोमोबाईल किंवा मेकॅनिकल अभियांत्रिकीमधील शासनमान्य संस्थेची किमान पदविका (३ वर्षे मुदतीची):"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isbComOrBSCOrDiplomaHoldersInAutomobileOrMechanical())));
        Cell cellDegreeName = null;
        Cell cellUniversityName = null;
        if (dto.isbComOrBSCOrDiplomaHoldersInAutomobileOrMechanical()) {
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
        table.addCell(PDFUtil.createBoldDataCell(""));
        table.addCell(PDFUtil.createDataCell(""));
        
        table.addCell(PDFUtil.createBoldDataCell("मोटारीचे सुटे भाग इ. भांडार सामान हाताळणे व त्याच्या नोंदी ठेवणे व खरेदी करण्याबाबतचा २ वर्षाचा व्यवहारीक अनुभव (रा.प. कर्मचाऱ्यांसाठी वरिष्ठ लिपिक पदातील भांडार खात्यातील कामाचा २ वर्षाचा अनुभव ग्राह्य राहील.):"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isTwoYearExpAsTransportAssociation())));
        Cell cellCompanyName = null;
        Cell cellTotalExperienceInYears = null;
        Cell cellTotalExperienceInMonths = null;
        if(dto.isTwoYearExpAsTransportAssociation()) {
        	cellCompanyName = PDFUtil.createDataCell(dto.getTransportCompanyName());// It is company name
        	cellTotalExperienceInYears = PDFUtil.createDataCell(dto.getHgvExperienceInYears());// totalExperienceInYears
        	cellTotalExperienceInMonths = PDFUtil.createDataCell(dto.getHgvExperienceInMonths());// totalExperienceInMonths
        } else {
        	cellCompanyName = PDFUtil.createDataCell("");
        	cellTotalExperienceInYears = PDFUtil.createDataCell("");
        	cellTotalExperienceInMonths = PDFUtil.createDataCell("");
        }
        table.addCell(PDFUtil.createDataCell("वाहतूकदार / वाहतूक संस्था:"));
        table.addCell(cellCompanyName);
        
        
        table.addCell(PDFUtil.createBoldDataCell("कालावधी वर्षे:"));
        table.addCell(cellTotalExperienceInYears);
        table.addCell(PDFUtil.createDataCell("कालावधी महिने:"));
        table.addCell(cellTotalExperienceInMonths);
        
        return table;
    }
}
