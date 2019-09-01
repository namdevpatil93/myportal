package com.msrtc.portal.applicant.util.post;

import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Table;
import com.msrtc.portal.applicant.dto.UndertakingDTO;
import com.msrtc.portal.applicant.util.PDFUtil;

public class ChargeManJuniorPostDetailsTableCreator {
	private UndertakingDTO dto;

    public ChargeManJuniorPostDetailsTableCreator(UndertakingDTO dto){
        this.dto = dto;
    }

    public Table create() {
        Table table = new Table(4);
        
        table.addCell(PDFUtil.createBoldDataCell("प्राधान्य:"));
        table.addCell(PDFUtil.createDataCell("तांत्रिक - " + PDFUtil.checkPriority(dto.getPriority())));
        table.addCell(PDFUtil.createBoldDataCell(""));
        table.addCell(PDFUtil.createDataCell(""));
        
        table.addCell(PDFUtil.createBoldDataCell("शासनमान्य संस्था / विद्यापिठाची ऑटोमोबाईल किंवा मेकॅनिकल अभियांत्रिकीमधील शासनमान्य संस्थेची किमान पदविका (३ वर्षे मुदतीची) / पदवी:"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isAutomobileOrMechanicalEngDegree())));
        table.addCell(PDFUtil.createBoldDataCell("पदविका / पदवीचे नाव:"));
        Cell cellDegreeName = null;
        Cell cellUniversityName = null;
        if(dto.isAutomobileOrMechanicalEngDegree()) {
        	cellDegreeName = PDFUtil.createDataCell(dto.getDegreeName());
        	cellUniversityName = PDFUtil.createDataCell(dto.getUniversityName());
        } else {
        	cellDegreeName = PDFUtil.createDataCell("");
        	cellUniversityName = PDFUtil.createDataCell("");
        }
        table.addCell(cellDegreeName);
        
        table.addCell(PDFUtil.createBoldDataCell("विद्यापीठाचे नाव:"));
        table.addCell(cellUniversityName);
        /*table.addCell(PDFUtil.createBoldDataCell("अतिरिक्त शैक्षणिक माहिती:"));
        table.addCell(PDFUtil.createDataCell(dto.getOtherQualificationDetails() != null ? dto.getOtherQualificationDetails() : ""));*/
        
        table.addCell(PDFUtil.createBoldDataCell("मोटार दुरुस्ती कार्यशाळेतील कामाचा १ वर्षाचा अनुभव. (रा.प. कर्मचाऱ्यांसाठी रा.प. कार्यशाळा / आगार कार्यशाळेतील कामाचा १ वर्षाचा अनुभव ग्राह्य राहील.):"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isOneYearExpInAutomobileRepairing())));
        Cell cellCompanyName = null;
        Cell cellTotalExperienceInYears = null;
        Cell cellTotalExperienceInMonths = null;
        if(dto.isOneYearExpInAutomobileRepairing()) {
        	cellCompanyName = PDFUtil.createDataCell(dto.getTransportCompanyName());// It is company name
        	cellTotalExperienceInYears = PDFUtil.createDataCell(dto.getHgvExperienceInYears());// totalExperienceInYears
        	cellTotalExperienceInMonths = PDFUtil.createDataCell(dto.getHgvExperienceInMonths());// totalExperienceInMonths
        } else {
        	cellCompanyName = PDFUtil.createDataCell("");
        	cellTotalExperienceInYears = PDFUtil.createDataCell("");
        	cellTotalExperienceInMonths = PDFUtil.createDataCell("");
        }
        table.addCell(PDFUtil.createDataCell("संस्था / संस्थांची नावे:"));
        table.addCell(cellCompanyName);
        
        
        table.addCell(PDFUtil.createBoldDataCell("कालावधी वर्षे:"));
        table.addCell(cellTotalExperienceInYears);
        table.addCell(PDFUtil.createDataCell("कालावधी महिने:"));
        table.addCell(cellTotalExperienceInMonths);
        
        table.addCell(PDFUtil.createBoldDataCell("अवजड वाहतूकीची वाहने चालविण्याचा परवाना (एच. जी. व्ही.):"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isHeavyDrivingLicense())));// ownHeavyDrivingLicenseNumber
        Cell cellHeavyDrivingLicenseNumber = null;
        Cell cellHeavyDrivingLicenseIssueDate = null;
        Cell cellHeavyDrivingLicenseExpiryDate = null;
        
        if(dto.isHeavyDrivingLicense()) {
        	cellHeavyDrivingLicenseNumber = PDFUtil.createDataCell(dto.getHeavyDrivingLicenseNumber());
        	cellHeavyDrivingLicenseIssueDate = PDFUtil.createDataCell(PDFUtil.getFormattedDate(dto.getHeavyDrivingLicenseIssueDate()));
        	cellHeavyDrivingLicenseExpiryDate = PDFUtil.createDataCell(PDFUtil.getFormattedDate(dto.getHeavyDrivingLicenseExpiryDate())); 
        } else {
        	cellHeavyDrivingLicenseNumber = PDFUtil.createDataCell("आपण अवजड़ वाहन चालविण्याचा परवाना (एच. जी. व्ही.) यासाठी \"नाही\" असा पर्याय निवडला आहे. कृपया याची नोंद करा कि आपण रा.प. मध्ये प्रशिक्षणासाठी उपस्थित झाल्याच्या तारखेपासून दोन वर्षाच्या मुदतीत अवजड वाहतूकीची वाहने चालविण्याचा परवाना सादर करेन असे मान्य केले आहे.");
        	cellHeavyDrivingLicenseIssueDate = PDFUtil.createDataCell("");
        	cellHeavyDrivingLicenseExpiryDate = PDFUtil.createDataCell("");
        }
        table.addCell(PDFUtil.createBoldDataCell("अवजड़ वाहन चालविण्याचा परवाना क्रमांक (एच. जी. व्ही.):"));
        table.addCell(cellHeavyDrivingLicenseNumber);
        
        
        table.addCell(PDFUtil.createBoldDataCell("अवजड़ वाहन चालविण्याचा परवाना प्राप्त केल्याचा दिनांक (एच. जी. व्ही.):"));
        table.addCell(cellHeavyDrivingLicenseIssueDate);
        table.addCell(PDFUtil.createBoldDataCell("अवजड़ वाहन चालविण्याचा परवाना वैध दिनांक (एच. जी. व्ही.):"));
        table.addCell(cellHeavyDrivingLicenseExpiryDate);
        
        return table;
    }
}
