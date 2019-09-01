package com.msrtc.portal.applicant.util.post;

import org.apache.commons.lang3.StringUtils;

import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Table;
import com.msrtc.portal.applicant.dto.UndertakingDTO;
import com.msrtc.portal.applicant.util.PDFUtil;

public class DivisionControllerPostDetailsTableCreator {
	 private UndertakingDTO dto;

	   public DivisionControllerPostDetailsTableCreator(UndertakingDTO dto) {
		super();
		this.dto = dto;
	}



		public Table create() {
	        Table table = new Table(4);

	        /*table.addCell(PDFUtil.createBoldDataCell("शैक्षणिक अहर्ता:"));
	        table.addCell(PDFUtil.createDataCell(String.valueOf(dto.getHighestQualificationTitle())));*/
	        table.addCell(PDFUtil.createBoldDataCell("गुण %:"));
	        table.addCell(PDFUtil.createDataCell(String.valueOf(dto.getRequiredQualificationMarks())));
	        table.addCell(PDFUtil.createDataCell(""));
	        table.addCell(PDFUtil.createDataCell(""));
	        
	        table.addCell(PDFUtil.createBoldDataCell("पदवीचे नाव:"));
	        table.addCell(PDFUtil.createDataCell(dto.getDegreeName()));
	        table.addCell(PDFUtil.createBoldDataCell("विद्यापीठाचे नाव:"));
	        table.addCell(PDFUtil.createDataCell(dto.getUniversityName()));
	        
	        if(dto.getRequiredQualificationMarks() <60 && dto.getRequiredQualificationMarks()>=45){
	        	 table.addCell(PDFUtil.createBoldDataCell("पदव्युत्तर पदवी किंवा पदविका:"));
	 	        table.addCell(PDFUtil.createDataCell(dto.getPostGradDegreeName()));
	 	        table.addCell(PDFUtil.createBoldDataCell("विद्यापीठाचे / संस्थेचे नाव:"));
	 	        table.addCell(PDFUtil.createDataCell(dto.getPostGradDegreeInstituteName()));
	        }

	        table.addCell(PDFUtil.createBoldDataCell("एम.एस.सी.आयटी किंवा समान सरकारी मान्यताप्राप्त संगणक अभ्यासक्रम प्रमाणपत्र:"));
	        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isMscitOrGaccc())));
	        table.addCell(PDFUtil.createBoldDataCell("संस्थेचे नाव:"));
	        table.addCell(PDFUtil.createDataCell(dto.getInstituteName()));

	        table.addCell(PDFUtil.createBoldDataCell("कामाचा अनुभव:"));
	        table.addCell(PDFUtil.createDataCell(dto.getWorkExperience()));
	       /*if(dto.getWorkExp()==1){
	    	  
	    	   table.addCell(PDFUtil.createDataCell("रेल्वे वाहतूक / रस्ते वाहतूक / जल वाहतूक इत्यादी उपक्रमातील व्यवस्थापनाचा किमान १० वर्षाचा अनुभव"));
	       }
	       else if(dto.getWorkExp()==2){
	    	   table.addCell(PDFUtil.createDataCell("भारतीय संरक्षणदलातील सेनादलातील कॅप्टन या पदापेक्षा कमी दर्जा नसेल किंवा वायुदल व नौसेनामधील समकक्ष पदावरील किमान ३ वर्षाचा अनुभव असणे आवश्यक आहे"));
	       }
	       else if(dto.getWorkExp()==3){
	    	   table.addCell(PDFUtil.createDataCell("ज्या संस्थेमध्ये १००० पेक्षा जास्त कामगार असलेल्या व्यापारी संस्थेमधिल १० वर्षाचा अनुभव"));
	       }
	       else if(dto.getWorkExp()==4){
	    	   table.addCell(PDFUtil.createDataCell("म. रा. प. कर्मचाऱ्यांसाठी  : द्वितीय वर्ग - २ (कनिष्ठ ) व (वरिष्ठ ) पदावर किमान ५ वर्ष सेवेचा अनुभव"));
	       }*/
	       if(dto.getWorkExp()==4){
	    	   table.addCell(PDFUtil.createDataCell(""));
	    	   table.addCell(PDFUtil.createDataCell(""));
	    	   
	    	   table.addCell(PDFUtil.createBoldDataCell("पदाचे नाव:"));
		        table.addCell(PDFUtil.createDataCell(dto.getPostName()));
		        table.addCell(PDFUtil.createBoldDataCell("विभाग:"));
		        table.addCell(PDFUtil.createDataCell(dto.getDcDivisionName()));
	      
	       } else  if(dto.getWorkExp()==1 || dto.getWorkExp()==2 || dto.getWorkExp()==3){
	        table.addCell(PDFUtil.createBoldDataCell("संस्थेचे नाव:"));
	        table.addCell(PDFUtil.createDataCell(dto.getTransportCompanyName()));
	        
	        table.addCell(PDFUtil.createBoldDataCell("वर्षे:"));
	        table.addCell(PDFUtil.createDataCell(StringUtils.isBlank(dto.getHgvExperienceInYears()) ? "" : dto.getHgvExperienceInYears()));
	        table.addCell(PDFUtil.createBoldDataCell("महिने:"));
	        table.addCell(PDFUtil.createDataCell(StringUtils.isBlank(dto.getHgvExperienceInMonths()) ? "" : dto.getHgvExperienceInMonths()));
	      }
	        	        table.setMarginBottom(30);
	        	        

	        return table;
	    }


}
