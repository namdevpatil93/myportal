package com.msrtc.portal.applicant.util.post;

import org.apache.commons.lang3.StringUtils;

import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Table;
import com.msrtc.portal.applicant.dto.UndertakingDTO;
import com.msrtc.portal.applicant.util.PDFUtil;

public class TrafficInspectorJrPostDetailsTableCreator {
	private UndertakingDTO dto;

    public TrafficInspectorJrPostDetailsTableCreator(UndertakingDTO dto){
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
        /*table.addCell(PDFUtil.createBoldDataCell("अतिरिक्त शैक्षणिक माहिती:"));
        table.addCell(PDFUtil.createDataCell(StringUtils.isBlank(dto.getOtherQualificationDetails()) ? "" : dto.getOtherQualificationDetails()));*/
        
        table.addCell(PDFUtil.createBoldDataCell("उमेदवार \"एमएस-सीआयटी\" (MS-CIT) / तत्सम शासनमान्य संस्थेचा संगणक कोर्स उत्तीर्ण असावा.:"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isMscitOrGaccc())));
        table.addCell(PDFUtil.createBoldDataCell("शारीरिक पात्रता: ऊंची: पुरुष उमेदवारांसाठी: किमान (१६३ से.मी.) महिला उमेदवारांसाठी: किमान (१५३ से.मी.):"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isPhysicalQualificationHeight()))); //heightWithinRange
        
        table.addCell(PDFUtil.createBoldDataCell("वाहतूक क्षेत्रातील कामाचा २ वर्षाचा अनुभव (रा.प. कर्मचाऱ्यांसाठी केवळ सहा.वाह. निरीक्षक / वाहतूक निरिक्षक व वरिष्ठ कारकून, पदातील वाहतूक खाते / शाखेच्या कामाचा २ वर्षाचा अनुभव ग्राह्य राहील.):"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isOneYearExpAsTransportAssociation())));
        Cell cellCompanyName = null;
        Cell cellTotalExperienceInYears = null;
        Cell cellTotalExperienceInMonths = null;
        if(dto.isOneYearExpAsTransportAssociation()) {
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
        
        table.addCell(PDFUtil.createBoldDataCell("अवजड़ वाहन चालविण्याचा परवाना (एच. जी. व्ही.):"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isHeavyDrivingLicense())));
        Cell cellOwnHeavyDrivingLicenseNumber = null;
        Cell cellOwnHeavyDrivingLicenseIssueDate = null;
        Cell cellOwnHeavyDrivingLicenseExpiryDate = null;
        if (dto.isHeavyDrivingLicense()) {
        	cellOwnHeavyDrivingLicenseNumber = PDFUtil.createDataCell(dto.getHeavyDrivingLicenseNumber());
        	cellOwnHeavyDrivingLicenseIssueDate = PDFUtil.createDataCell(PDFUtil.getFormattedDate(dto.getHeavyDrivingLicenseIssueDate()));
        	cellOwnHeavyDrivingLicenseExpiryDate = PDFUtil.createDataCell(PDFUtil.getFormattedDate(dto.getHeavyDrivingLicenseExpiryDate()));
        } else {
        	cellOwnHeavyDrivingLicenseNumber = PDFUtil.createDataCell("आपण अवजड़ वाहन चालविण्याचा परवाना (एच. जी. व्ही.) यासाठी \"नाही\" असा पर्याय निवडला आहे. कृपया याची नोंद करा कि आपण रा.प. मध्ये प्रशिक्षणासाठी उपस्थित झाल्याच्या तारखेपासून दोन वर्षाच्या मुदतीत अवजड वाहतूकीची वाहने चालविण्याचा परवाना सादर करेन असे मान्य केले आहे.");
        	cellOwnHeavyDrivingLicenseIssueDate = PDFUtil.createDataCell("");
        	cellOwnHeavyDrivingLicenseExpiryDate = PDFUtil.createDataCell("");
        }
        table.addCell(PDFUtil.createBoldDataCell("अवजड़ वाहन चालविण्याचा परवाना क्रमांक (एच. जी. व्ही.):"));
        table.addCell(cellOwnHeavyDrivingLicenseNumber);
        
        table.addCell(PDFUtil.createBoldDataCell("अवजड़ वाहन चालविण्याचा परवाना प्राप्त केल्याचा दिनांक (एच. जी. व्ही.):"));
        table.addCell(cellOwnHeavyDrivingLicenseIssueDate);
        table.addCell(PDFUtil.createDataCell("अवजड़ वाहन चालविण्याचा परवाना वैध दिनांक (एच. जी. व्ही.):"));
        table.addCell(cellOwnHeavyDrivingLicenseExpiryDate);
        
        return table;
    }
}
