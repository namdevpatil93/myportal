package com.msrtc.portal.applicant.util.post;

import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Table;
import com.msrtc.portal.applicant.dto.UndertakingDTO;
import com.msrtc.portal.applicant.util.PDFUtil;

public class AssistantJuniorPostDetailsTableCreator {
	private UndertakingDTO dto;

    public AssistantJuniorPostDetailsTableCreator(UndertakingDTO dto){
        this.dto = dto;
    }
    
    public Table create() {
        Table table = new Table(4);

        table.addCell(PDFUtil.createBoldDataCell("औद्योगिक प्रशिक्षण संस्थेकडील (आय. टी. आय) संबंधीत व्यवसायातील पाठयक्रम (परीक्षा) उत्तीर्ण किंवा संबंधित व्यवसायातील केंद्र शासनाची अखिल भारतीय व्यवसाय परीक्षा (N.C.T.V.T.) उत्तीर्ण किंवा त्यापेक्षा उच्च दर्जाच्या संबंधीत व्यवसायातील परीक्षा उत्तीर्ण असणे आवश्यक:"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isItiPassed())));
        /*table.addCell(PDFUtil.createBoldDataCell("अतिरिक्त शैक्षणिक माहिती:"));
        table.addCell(PDFUtil.createDataCell(dto.getOtherQualificationDetails()));*/

        table.addCell(PDFUtil.createBoldDataCell("व्यवसाय:"));
        table.addCell(PDFUtil.createDataCell(dto.getTradeName()));
        table.addCell(PDFUtil.createBoldDataCell(""));//("आपण कोणत्या विभाग / घटक यासाठी अर्ज करु इच्छिता:"));
        table.addCell(PDFUtil.createDataCell(""));//(dto.getDivisionName()));

        table.addCell(PDFUtil.createBoldDataCell("अनुभव:"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isExperienced())));
        Cell cellCompanyName = null;
        Cell cellExperiencedYear = null;
        Cell cellExperiencedMonth = null;
        if (dto.isExperienced()) {
        	cellCompanyName = PDFUtil.createDataCell(dto.getTransportCompanyName());
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

        table.addCell(PDFUtil.createBoldDataCell("रातआंधळेपणा:"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isNightBlindness())));
        table.addCell(PDFUtil.createBoldDataCell("रंगअंधत्व:"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isColorBlindness())));
        
        //--
        table.addCell(PDFUtil.createBoldDataCell("हलके वाहन शिकाऊ परवाना (LMV):"));
        Cell cellLightMotorVechicleLicense = null;
        if (dto.isLightMotorVechicle()) {
        	cellLightMotorVechicleLicense = PDFUtil.createDataCell("होय");
        } else {
        	cellLightMotorVechicleLicense = PDFUtil.createDataCell("हलके वाहन शिकाऊ परवाना (LMV) कागदपत्र तपासणीच्या वेळी सादर करीन, तसेच नियुक्ती पूर्वी नियमित वाहन परवाना सादर करेन हे मला मान्य आहे.");
        }
        
        table.addCell(cellLightMotorVechicleLicense);
        
        Cell cellLightMotorVechicleLicenseNo = null;
        Cell cellLightMotorVechicleIssueDate = null;
        if (dto.isLightMotorVechicle()) {
        	cellLightMotorVechicleLicenseNo = PDFUtil.createDataCell(dto.getLightMotorVechicleLicenseNo());
        	cellLightMotorVechicleIssueDate = PDFUtil.createDataCell(PDFUtil.getFormattedDate(dto.getLightMotorVechicleIssueDate()));
        } else {
        	cellLightMotorVechicleLicenseNo = PDFUtil.createDataCell("");
        	cellLightMotorVechicleIssueDate = PDFUtil.createDataCell("");
		}
        
        table.addCell(PDFUtil.createBoldDataCell(""));
        table.addCell("");
        
        table.addCell(PDFUtil.createBoldDataCell("हलके वाहन शिकाऊ परवाना (LMV) क्रमांक:"));
        table.addCell(cellLightMotorVechicleLicenseNo);
        table.addCell(PDFUtil.createBoldDataCell("हलके वाहन शिकाऊ परवाना (LMV) प्राप्त केल्याचा दिनांक:"));
        table.addCell(cellLightMotorVechicleIssueDate);
        //--
        
        table.addCell(PDFUtil.createBoldDataCell("रा. प. महामंडळामध्ये शिकाऊ उमेदवारी केली आहे का:"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isApprenticeshipInMSRTC())));
        
        Cell cellApprenticeshipInMSRTCTrade = null;
        Cell cellApprenticeshipInMSRTCYear = null;
        Cell cellApprenticeshipInMSRTCDivision = null;
        if (dto.isApprenticeshipInMSRTC()) {
        	cellApprenticeshipInMSRTCTrade = PDFUtil.createDataCell(dto.getApprenticeshipInMSRTCTrade());
        	cellApprenticeshipInMSRTCYear = PDFUtil.createDataCell(dto.getApprenticeshipInMSRTCYear());
        	cellApprenticeshipInMSRTCDivision = PDFUtil.createDataCell(dto.getApprenticeshipInMSRTCDivision());
        } else {
        	cellApprenticeshipInMSRTCTrade = PDFUtil.createDataCell("");
        	cellApprenticeshipInMSRTCYear = PDFUtil.createDataCell("");
        	cellApprenticeshipInMSRTCDivision = PDFUtil.createDataCell("");
		}
        
        table.addCell(PDFUtil.createBoldDataCell("व्यवसाय:"));
        table.addCell(cellApprenticeshipInMSRTCTrade);
        
        table.addCell(PDFUtil.createBoldDataCell("वर्षे:"));
        table.addCell(cellApprenticeshipInMSRTCYear);
        table.addCell(PDFUtil.createBoldDataCell("रा.प. महामंडळातील कोणत्याही विभाग / घटक येथे शिकाऊ उमेदवारी:"));
        table.addCell(cellApprenticeshipInMSRTCDivision);

        table.setMarginBottom(30);

        return table;
    }
}
