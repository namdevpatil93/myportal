package com.msrtc.portal.applicant.util.post;

import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Table;
import com.msrtc.portal.applicant.dto.UndertakingDTO;
import com.msrtc.portal.applicant.util.PDFUtil;

public class ClerkTypistJuniorPostDetailsTableCreator {
	private UndertakingDTO dto;

    public ClerkTypistJuniorPostDetailsTableCreator(UndertakingDTO dto){
        this.dto = dto;
    }

    public Table create() {
        Table table = new Table(4);
        
        table.addCell(PDFUtil.createBoldDataCell("दिव्यांग:"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isDifferentlyAbled())));
        table.addCell(PDFUtil.createBoldDataCell("अंध व अल्पदृष्टी:"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isBlindnessAndLowVision())));
        
        table.addCell(PDFUtil.createBoldDataCell("मूक व कर्ण बधीर:"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isDeafAndMute())));
        table.addCell(PDFUtil.createBoldDataCell("अस्थिव्यंग/लोकोमोटिव सेरेब्रल पाल्सी:"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isLocomotorOrCerebralPalsy())));
        
        table.addCell(PDFUtil.createBoldDataCell("मान्यताप्राप्त विद्यापीठाचा कोणत्याही शाखेचा पदवीधारक:"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isGraduateFromAffiliatedInstitute())));
        table.addCell(PDFUtil.createBoldDataCell("पदवीचे नाव:"));
        Cell cellDegreeName = null;
        Cell cellUniversityName = null;
        if(dto.isGraduateFromAffiliatedInstitute()) {
        	cellDegreeName = PDFUtil.createDataCell(dto.getDegreeName());
        	cellUniversityName = PDFUtil.createDataCell(dto.getUniversityName());
        } else {
        	cellDegreeName = PDFUtil.createDataCell("");
        	cellUniversityName = PDFUtil.createDataCell("");
        }
        table.addCell(cellDegreeName);
        
        table.addCell(PDFUtil.createBoldDataCell("विद्यापीठाचे नाव:"));
        table.addCell(cellUniversityName);
        /*table.addCell(PDFUtil.createDataCell("अतिरिक्त शैक्षणिक माहिती"));
        table.addCell(PDFUtil.createDataCell(dto.getOtherQualificationDetails()));*/
        
        table.addCell(PDFUtil.createBoldDataCell("आपण कोणत्या विभाग / घटक यासाठी अर्ज करु इच्छिता:"));
        table.addCell(PDFUtil.createDataCell(dto.getDegreeName()));
        table.addCell(PDFUtil.createBoldDataCell("\"एमएस-सीआयटी\" (MS-CIT) / तत्सम शासनमान्य संस्थेचा संगणक कोर्स उत्तीर्ण:"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isMscitOrDoeaccPassCertification())));
        
        table.addCell(PDFUtil.createBoldDataCell("टंकलेखन परीक्षा उत्तीर्ण असल्याचे शासनमान्य दाखला (मराठी ३० श. प्र. मि. व इंग्रजी ४० श. प्र. मि.) :"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isTypingExamPassed())));
        table.addCell(PDFUtil.createBoldDataCell(""));
        table.addCell(PDFUtil.createDataCell(""));

        table.addCell(PDFUtil.createBoldDataCell("अनुभव:"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isExperienced())));
        
        Cell cellCompanyName = null;
        Cell cellExperiencedYear = null;
        Cell cellExperiencedMonth = null;
        if (dto.isExperienced()) {
        	cellCompanyName = PDFUtil.createDataCell(dto.getTransportCompanyName()); //companyName
        	cellExperiencedYear = PDFUtil.createDataCell(dto.getHgvExperienceInYears());
        	cellExperiencedMonth = PDFUtil.createDataCell(dto.getHgvExperienceInMonths());
        } else {
        	cellCompanyName = PDFUtil.createDataCell("");
        	cellExperiencedYear = PDFUtil.createDataCell("");
        	cellExperiencedMonth = PDFUtil.createDataCell("");
		}
        
        table.addCell(PDFUtil.createDataCell("संस्था / संस्थांची नावे:"));
        table.addCell(cellCompanyName);
     
        table.addCell(PDFUtil.createBoldDataCell("वर्षे:"));
        table.addCell(cellExperiencedYear);
        table.addCell(PDFUtil.createBoldDataCell("महिने:"));
        table.addCell(cellExperiencedMonth);
        
        return table;
    }
}
