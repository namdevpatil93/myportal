package com.msrtc.portal.applicant.util.post;

import org.apache.commons.lang3.StringUtils;

import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Table;
import com.msrtc.portal.applicant.dto.UndertakingDTO;
import com.msrtc.portal.applicant.util.PDFUtil;

public class DriverCumConductorPostDetailsTableCreator {

    private UndertakingDTO dto;

    public DriverCumConductorPostDetailsTableCreator(UndertakingDTO dto){
        this.dto = dto;
    }

    public Table create() {
        Table table = new Table(4);

        table.addCell(PDFUtil.createBoldDataCell("शैक्षणिक पात्रता (दहावी (एस.एस.सी) उत्तीर्ण):"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isSscPass())));
        table.addCell(PDFUtil.createBoldDataCell("प्राप्त केलेले गुण:"));
        table.addCell(PDFUtil.createDataCell(String.valueOf(dto.getRequiredQualificationMarks())));
        /*table.addCell(PDFUtil.createBoldDataCell("अतिरिक्त शैक्षणिक माहिती"));
        table.addCell(PDFUtil.createDataCell(dto.getOtherQualificationDetails()));*/

        table.addCell(PDFUtil.createBoldDataCell("रातआंधळेपणा:"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isNightBlindness())));
        table.addCell(PDFUtil.createBoldDataCell("रंगअंधत्व"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isColorBlindness())));

        table.addCell(PDFUtil.createBoldDataCell("दृष्टीतीक्ष्णता (६ x ६ दृष्टी) (चष्माविरहित):"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isVisionAcuity())));
        table.addCell(PDFUtil.createDataCell(""));
        table.addCell(PDFUtil.createDataCell(""));

        table.addCell(PDFUtil.createBoldDataCell("अवजड़ वाहन चालविण्याचा परवाना (एच.जी.व्ही.):"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isHeavyDrivingLicense())));
        Cell cellHeavyDrivingLicense = null;
        if(dto.isHeavyDrivingLicense()) {
        	table.addCell(PDFUtil.createBoldDataCell("अवजड़ वाहन चालविण्याचा परवाना क्रमांक (एच.जी.व्ही.)"));
           
        	cellHeavyDrivingLicense = PDFUtil.createDataCell(dto.getHeavyDrivingLicenseNumber());
        } else {
        	table.addCell(PDFUtil.createBoldDataCell(""));
        	cellHeavyDrivingLicense = PDFUtil.createDataCell("");
        	
        }
        table.addCell(cellHeavyDrivingLicense);
        
        if(dto.isHeavyDrivingLicense()) {
        table.addCell(PDFUtil.createBoldDataCell("अवजड़ वाहन चालविण्याचा परवाना प्राप्त केल्याचा दिनांक (एच.जी.व्ही.):"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.getFormattedDate(dto.getHeavyDrivingLicenseIssueDate())));
        table.addCell(PDFUtil.createBoldDataCell("अवजड़ वाहन चालविण्याचा परवाना वैध दिनांक (एच.जी.व्ही.):"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.getFormattedDate(dto.getHeavyDrivingLicenseExpiryDate())));
        }
        
        if(dto.getGender()==0){
        table.addCell(PDFUtil.createBoldDataCell("हलके वाहन शिकाऊ परवाना (LMV):"));
        Boolean lmv=dto.isLightMotorVechicle()?dto.isLightMotorVechicle():false;
        
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(lmv)));
        table.addCell(PDFUtil.createDataCell(""));
        table.addCell(PDFUtil.createDataCell(""));
        if(lmv){
        
        table.addCell(PDFUtil.createBoldDataCell("हलके वाहन शिकाऊ परवाना (LMV) क्रमांक:"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.getFormattedDate(dto.getLightMotorVechicleIssueDate())));
        table.addCell(PDFUtil.createBoldDataCell("हलके वाहन शिकाऊ परवाना (LMV) प्राप्त केल्याचा दिनांक:"));
        table.addCell(PDFUtil.createDataCell(dto.getLightMotorVechicleLicenseNo()));
        }
        }
        

        table.addCell(PDFUtil.createBoldDataCell("पी.एस.व्ही. बॅज:"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isPsvBadge())));
        table.addCell(PDFUtil.createBoldDataCell("पी.एस.व्ही. बॅज क्रमांक:"));
        Cell cellPsvBadge = null;
        if(dto.isPsvBadge()) {
        	cellPsvBadge = PDFUtil.createDataCell(dto.getPsvBadgeNumber());
        } else {
        	cellPsvBadge = PDFUtil.createDataCell("");
        }
        table.addCell(cellPsvBadge);

        table.addCell(PDFUtil.createBoldDataCell("वाहकाचा वैध परवाना:"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isConductorBatchLicense())));
        table.addCell(PDFUtil.createBoldDataCell("वाहकाचा वैध परवाना क्रमांक:"));
        Cell cellConductorBatchLicense = null;
//        if(dto.isConductorBatchLicense()) {
        	cellConductorBatchLicense = PDFUtil.createDataCell(dto.getConductorBatchLicenseNumber());
//        } else {
//        	cellConductorBatchLicense = createDataCell("");
//        }
        table.addCell(cellConductorBatchLicense);
        if(dto.isConductorBatchLicense()){
        table.addCell(PDFUtil.createBoldDataCell("वाहकाचा वैध परवाना प्राप्त केल्याचा दिनांक:"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.getFormattedDate(dto.getConductorBatchLicenseIssueDate())));
        table.addCell(PDFUtil.createBoldDataCell("वाहकाचा परवाना वैध दिनांक:"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.getFormattedDate(dto.getConductorBatchLicenseExpiryDate())));
        }
        
        if(dto.isHeavyDrivingLicense()) {
        table.addCell(PDFUtil.createBoldDataCell("(एच.जी.व्ही.) परवाना प्राप्त झाल्यानंतरचा ३ वर्षांचा अनुभव (किमान अनुभव १ वर्ष):"));
        }else if(dto.isLightMotorVechicle()){
        	 table.addCell(PDFUtil.createBoldDataCell("(एल .एम .व्ही.) परवाना प्राप्त झाल्यानंतरचा १ वर्षांचा अनुभव (किमान अनुभव १ वर्ष): "));
        }
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isExperienced())));
        table.addCell(PDFUtil.createBoldDataCell("वाहतूकदार / वाहतूक संस्था / संस्थांची नावे:"));
        Cell cellTransportCompanyName = null;
        if(dto.isExperienced()) {
        	cellTransportCompanyName = PDFUtil.createDataCell(dto.getTransportCompanyName());
        } else {
        	cellTransportCompanyName = PDFUtil.createDataCell("");
        }
        table.addCell(cellTransportCompanyName);

        table.addCell(PDFUtil.createBoldDataCell("वर्षे:"));
        table.addCell(PDFUtil.createDataCell(StringUtils.isBlank(dto.getHgvExperienceInYears()) ? "" : dto.getHgvExperienceInYears()));
        table.addCell(PDFUtil.createBoldDataCell("महिने:"));
        table.addCell(PDFUtil.createDataCell(StringUtils.isBlank(dto.getHgvExperienceInMonths()) ? "" : dto.getHgvExperienceInMonths()));

        table.addCell(PDFUtil.createBoldDataCell("जामीन देणाऱ्या व्यक्तीचे नाव आणि मोबाईल क्रमांक:"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isGuarantorPerson())));
        table.addCell(PDFUtil.createBoldDataCell("जामीन देणाऱ्या व्यक्तीचे नाव:"));
        Cell cellGuarantorPerson = null;
        if(dto.isGuarantorPerson()) {
        	cellGuarantorPerson = PDFUtil.createDataCell(dto.getGuarantorPersonName());
        } else {
        	cellGuarantorPerson = PDFUtil.createDataCell("");
        }
        table.addCell(cellGuarantorPerson);

        table.addCell(PDFUtil.createBoldDataCell("जामीन देणाऱ्या व्यक्तीचे मोबाईल क्रमांक:"));
        table.addCell(PDFUtil.createDataCell(dto.getGuarantorPersonNumber()));
        table.addCell(PDFUtil.createBoldDataCell(""));
        table.addCell(PDFUtil.createDataCell(""));

        table.addCell(PDFUtil.createBoldDataCell("शारीरिक पात्रता:\n" +
                "उंची:\n" +
                "किमान - १६० से.मी. \n" +
                "कमाल - १८० से.मी"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isPhysicalQualificationHeight())));
        table.addCell(PDFUtil.createBoldDataCell("आपणा कड़ून या पूर्वी कोणत्याही प्रकारचा प्राणांतिक अपघात झाला आहे का ?"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isCommittedAnyFatalAccident())));

        table.setMarginBottom(30);

        return table;
    }
    
}
