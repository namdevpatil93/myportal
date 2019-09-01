package com.msrtc.portal.applicant.util;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Locale;

import org.apache.commons.lang3.StringUtils;
import org.springframework.context.MessageSource;

import com.itextpdf.kernel.color.DeviceGray;
import com.itextpdf.kernel.font.PdfFont;
import com.itextpdf.kernel.font.PdfFontFactory;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.kernel.pdf.canvas.PdfCanvasConstants;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.border.Border;
import com.itextpdf.layout.border.SolidBorder;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.element.Text;
import com.itextpdf.layout.property.TextAlignment;
import com.itextpdf.layout.property.UnitValue;
import com.itextpdf.layout.property.VerticalAlignment;
import com.itextpdf.licensekey.LicenseKey;
import com.msrtc.portal.applicant.domain.Caste;
import com.msrtc.portal.applicant.dto.UndertakingDTO;
import com.msrtc.portal.applicant.service.ApplicantService;
import com.msrtc.portal.applicant.util.post.AccountantJuniorPostDetailsTableCreator;
import com.msrtc.portal.applicant.util.post.AssistantJuniorPostDetailsTableCreator;
import com.msrtc.portal.applicant.util.post.AssistantTrafficSuperintendentJrPostDetailsTableCreator;
import com.msrtc.portal.applicant.util.post.AsstSecurityInspectorJuniorPostDetailsTableCreator;
import com.msrtc.portal.applicant.util.post.AsstWorksSuperintendentJrPostDetailsTableCreator;
import com.msrtc.portal.applicant.util.post.ChargeManJuniorPostDetailsTableCreator;
import com.msrtc.portal.applicant.util.post.ClerkTypistJuniorPostDetailsTableCreator;
import com.msrtc.portal.applicant.util.post.DivisionControllerPostDetailsTableCreator;
import com.msrtc.portal.applicant.util.post.DriverCumConductorPostDetailsTableCreator;
import com.msrtc.portal.applicant.util.post.FireWardenJuniorPostDetailsTableCreator;
import com.msrtc.portal.applicant.util.post.JuniorEngineerCivilPostDetailsTableCreator;
import com.msrtc.portal.applicant.util.post.JuniorEngineerElectricalPostDetailsTableCreator;
import com.msrtc.portal.applicant.util.post.SecurityInspectorJuniorPostDetailsTableCreator;
import com.msrtc.portal.applicant.util.post.SrComputerOperatorJrPostDetailsTableCreator;
import com.msrtc.portal.applicant.util.post.StoreKeeperJuniorPostDetailsTableCreator;
import com.msrtc.portal.applicant.util.post.StoreSuperviserJuniorPostDetailsTableCreator;
import com.msrtc.portal.applicant.util.post.TrafficInspectorJrPostDetailsTableCreator;

public class UndertakingPDFGenerator {

    private String fontLocation;
    private String licenseKeyPath;
    private PdfFont font;
    private MessageSource messageSource;
    
    
    private ApplicantService applicantService;

    public UndertakingPDFGenerator(String fontLocation, String licenseKeyPath , MessageSource messageSource,ApplicantService applicantService){
        this.fontLocation = fontLocation;
        this.licenseKeyPath = licenseKeyPath;
        this.messageSource = messageSource;
        this.applicantService = applicantService;
        try {
            font = PdfFontFactory.createFont(fontLocation, "Identity-H", true);
            
            PDFUtil.setFont(font);
            PDFUtil.setMessageSource(messageSource);
            
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void generate(String pdfLocation,
                         String pdfName,
                         UndertakingDTO undertakingDTO){
        File dir = new File(pdfLocation);

        if (!dir.exists()) {
            dir.mkdirs();
        }

        LicenseKey.loadLicenseFile(licenseKeyPath);

        PdfDocument pdf = null;
        try {
            pdf = new PdfDocument(new PdfWriter(pdfLocation + File.separator + pdfName));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        Document document = new Document(pdf);

        document.setFontSize(8);
        document.setFont(font);

        document.add(PDFUtil.getHeaderTable(undertakingDTO));
        document.add(getPersonalInformationTable(undertakingDTO));
        document.add(getOtherInformationTable(undertakingDTO));
        document.add(getParallelReservationTable(undertakingDTO));
        document.add(getPreferredCitiesTable(undertakingDTO));
        document.add(getPostAppliedForTable(undertakingDTO));

        switch(undertakingDTO.getPostId()){
        	case 3:
	            document.add(new ClerkTypistJuniorPostDetailsTableCreator(undertakingDTO).create());
	            break;
        
	        case 4:
	            document.add(new AssistantJuniorPostDetailsTableCreator(undertakingDTO).create());
	            break;
	            
	        case 5:
	            document.add(new AssistantTrafficSuperintendentJrPostDetailsTableCreator(undertakingDTO).create());
	            break;
	            
	        case 6:
	            document.add(new TrafficInspectorJrPostDetailsTableCreator(undertakingDTO).create());
	            break;
	            
	        case 7:
	            document.add(new AccountantJuniorPostDetailsTableCreator(undertakingDTO).create());
	            break;
	            
	        case 8:
	            document.add(new StoreSuperviserJuniorPostDetailsTableCreator(undertakingDTO).create());
	            break;
	            
	        case 9:
	            document.add(new StoreKeeperJuniorPostDetailsTableCreator(undertakingDTO).create());
	            break;
	            
	        case 10:
	            document.add(new SecurityInspectorJuniorPostDetailsTableCreator(undertakingDTO).create());
	            break;
	            
	        case 11:
	            document.add(new AsstSecurityInspectorJuniorPostDetailsTableCreator(undertakingDTO).create());
	            break;
	            
	        case 12:
	            document.add(new FireWardenJuniorPostDetailsTableCreator(undertakingDTO).create());
	            break;
	            
	        case 13:
                document.add(new JuniorEngineerCivilPostDetailsTableCreator(undertakingDTO).create());
                break;
                
	        case 14:
                document.add(new JuniorEngineerElectricalPostDetailsTableCreator(undertakingDTO).create());
                break;
	            
	        case 15:
                document.add(new AsstWorksSuperintendentJrPostDetailsTableCreator(undertakingDTO).create());
                break;
                
	        case 16:
                document.add(new ChargeManJuniorPostDetailsTableCreator(undertakingDTO).create());
                break;
	            
	        case 18:
                document.add(new SrComputerOperatorJrPostDetailsTableCreator(undertakingDTO).create());
                break;
        
            case 21:
                document.add(new DriverCumConductorPostDetailsTableCreator(undertakingDTO).create());
                break;
                
            case 22:
                document.add(new DivisionControllerPostDetailsTableCreator(undertakingDTO).create());
                break;
                
        }

        document.add(getUndertakingTable(undertakingDTO));

        document.close();

    }

    private Table getPersonalInformationTable(UndertakingDTO dto){
        Table table = new Table(4);

        table.addCell(PDFUtil.createBoldDataCell("अर्जदार आयडी:"));
        table.addCell(PDFUtil.createDataCell(dto.getApplicationID()));
        table.addCell(PDFUtil.createDataCell(""));
        table.addCell(PDFUtil.createDataCell(""));

        table.addCell(PDFUtil.createBoldDataCell("नाव:"));
        table.addCell(PDFUtil.createDataCell(dto.getFirstName()));
        table.addCell(PDFUtil.createDataCell(dto.getFirstNameInMarathi()));
        table.addCell(PDFUtil.createDataCell(""));

        table.addCell(PDFUtil.createBoldDataCell("वडिलांचे नाव / पतीचे नाव:"));
        table.addCell(PDFUtil.createDataCell(dto.getMiddleName()));
        table.addCell(PDFUtil.createDataCell(dto.getMiddleNameInMarathi()));
        table.addCell(PDFUtil.createDataCell(""));

        table.addCell(PDFUtil.createBoldDataCell("आडनाव:"));
        table.addCell(PDFUtil.createDataCell(dto.getSurname()));
        table.addCell(PDFUtil.createDataCell(dto.getSurnameInMarathi()));
        table.addCell(PDFUtil.createDataCell(""));

        table.addCell(PDFUtil.createBoldDataCell("जन्म तारीख:"));

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

        table.addCell(PDFUtil.createDataCell(dto.getDob().format(formatter)));
       /* table.addCell(PDFUtil.createDataCell(""));
        table.addCell(PDFUtil.createDataCell(""));*/
        
        table.addCell(PDFUtil.createBoldDataCell("तुम्ही आत्महत्याग्रस्त शेतकऱ्यांचे पाल्य आहात?"));
        if(dto.getChildOfFarmerWhoCommittedSuicide()) {
            table.addCell(PDFUtil.createDataCell("होय"));
        } else {
            table.addCell(PDFUtil.createDataCell("नाही"));
        }


        table.setMarginBottom(10);

        return table;
    }

    private Table getOtherInformationTable(UndertakingDTO dto){
        Table table = new Table(4);

        table.addCell(PDFUtil.createBoldDataCell("लिंग:"));
        if(dto.getGender() == 1){
            table.addCell(PDFUtil.createDataCell("पुरुष"));
        } else {
            table.addCell(PDFUtil.createDataCell("महिला"));
        }
        table.addCell(PDFUtil.createBoldDataCell("पत्ता:"));
        table.addCell(PDFUtil.createDataCell(dto.getAddress()));

        table.addCell(PDFUtil.createBoldDataCell("पिन"));
        table.addCell(PDFUtil.createDataCell(dto.getPinCode()));
        table.addCell(PDFUtil.createBoldDataCell("सर्वोच्च शैक्षणिक अहर्ता"));
        table.addCell(PDFUtil.createDataCell(dto.getHighestQualificationTitle()));
        //table.addCell(PDFUtil.createDataCell(StringUtils.isBlank(dto.getHighestQualificationTitle()) ? "" : dto.getHighestQualificationTitle()));


        table.addCell(PDFUtil.createBoldDataCell("ई-मेल आयडी:"));
        table.addCell(PDFUtil.createDataCell(dto.getEmail()));
        table.addCell(PDFUtil.createBoldDataCell("मोबाईल क्रमांक:"));
        table.addCell(PDFUtil.createDataCell(dto.getMobile()));

        table.addCell(PDFUtil.createBoldDataCell("जिल्हा:"));
        table.addCell(PDFUtil.createDataCell(dto.getDistrict()));
        table.addCell(PDFUtil.createBoldDataCell("वैवाहिक स्थिती:"));

        if(dto.getMaritalStatus() == 1){
            table.addCell(PDFUtil.createDataCell("विवाहित"));
        } else {
            table.addCell(PDFUtil.createDataCell("अविवाहीत"));
        }

        table.addCell(PDFUtil.createBoldDataCell("महाराष्ट्राचे अधिवासी आहात का:"));
        if(dto.isMaharashtraDomicile()) {
            table.addCell(PDFUtil.createDataCell("होय"));
        } else {
            table.addCell(PDFUtil.createDataCell("नाही"));
        }

        table.addCell(PDFUtil.createBoldDataCell("मराठी भाषा (बोलता, लिहिता आणि वाचता येते):"));
        if(dto.isRwsMarathi()) {
            table.addCell(PDFUtil.createDataCell("होय"));
        } else {
            table.addCell(PDFUtil.createDataCell("नाही"));
        }

        table.addCell(PDFUtil.createBoldDataCell("जात प्रवर्ग:"));
        table.addCell(PDFUtil.createDataCell(dto.getCaste()));
        
        if(dto.getSubCaste() !="" && dto.getSubCaste() != null){
        table.addCell(PDFUtil.createBoldDataCell("पोट जात:"));
        table.addCell(PDFUtil.createDataCell(dto.getSubCaste()));
        }
        table.addCell(PDFUtil.createBoldDataCell("वाटप जात प्रवर्ग:"));
        
        if(dto.getGender()== 0 && dto.getCasteId() == 1 && dto.isNonCreamyLayer() == false){
        	List<Caste> casteList = applicantService.findAllCastes();
        	for (Caste caste : casteList) {
				if(caste.getId()== dto.getAllocatedCategory().longValue()){
					table.addCell(PDFUtil.createDataCell(messageSource.getMessage(caste.getMessageKey(),null, new Locale("mr"))));
		        	
		        	table.addCell(PDFUtil.createBoldDataCell("नोंद:"));
		        	table.addCell(PDFUtil.createDataCell(messageSource.getMessage("applicant.open.female.note",null, new Locale("mr"))));
		        
				}
			}
        	}else if (dto.getCasteId() == dto.getAllocatedCategory().longValue() && dto.getCasteId() != 1
        			&& dto.getCasteId() != 3 && dto.getCasteId() != 4 ) {
        		table.addCell(PDFUtil.createDataCell(dto.getCaste()));
			}else if (dto.getCasteId() != dto.getAllocatedCategory().longValue() && dto.getAllocatedCategory() ==1) {
				table.addCell(PDFUtil.createDataCell(messageSource.getMessage("caste.open",null, new Locale("mr"))));
				
				table.addCell(PDFUtil.createBoldDataCell("नोंद:"));
	        	table.addCell(PDFUtil.createDataCell(messageSource.getMessage("applicant.nonCreamy.no",null, new Locale("mr"))));
	        
			}else{
				table.addCell(PDFUtil.createDataCell(dto.getCaste()));
				
			}
       
        if( ((dto.getCaste() != messageSource.getMessage("caste.st",null, new Locale("mr")) && 
			dto.getCaste() != messageSource.getMessage("caste.sc",null, new Locale("mr")) ) && dto.getCaste() != messageSource.getMessage("caste.open",null, new Locale("mr")))
			|| (dto.getGender()!=1 && dto.getCaste() == messageSource.getMessage("caste.open",null, new Locale("mr")))) {
       
        
        table.addCell(PDFUtil.createBoldDataCell("उन्नत व प्रगत गटात मोडत नसल्याचे प्रमाणपत्र :"));
        if(dto.isNonCreamyLayer()) {
            table.addCell(PDFUtil.createDataCell("होय"));
            
            table.addCell(PDFUtil.createBoldDataCell("उन्नत व प्रगत गटात मोडत नसल्याच्या प्रमाणपत्राची वैधता अंतिम दिनांक:"));
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            String certificateValidityEndDate = dto.getCertificateValidityEndingDate() != null ? dto.getCertificateValidityEndingDate().format(formatter) : "";
            table.addCell(PDFUtil.createDataCell(certificateValidityEndDate));
            
            table.addCell(PDFUtil.createBoldDataCell("प्रमाणपत्र क्रमांक:"));
            table.addCell(PDFUtil.createDataCell(dto.getCertificateNumber()));
            
        } else {
            table.addCell(PDFUtil.createDataCell("नाही"));
        }
        }
        
        table.addCell(PDFUtil.createBoldDataCell("दुष्काळग्रस्त:"));
        if(dto.isDroughtAffected()) {
            table.addCell(PDFUtil.createDataCell("होय"));
        } else {
            table.addCell(PDFUtil.createDataCell("नाही"));
        }
        
        /*table.addCell(PDFUtil.createBoldDataCell("उन्नत व प्रगत गटात मोडत नसल्याच्या प्रमाणपत्राची वैधता अंतिम दिनांक:"));

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        String certificateValidityEndDate = dto.getCertificateValidityEndingDate() != null ? dto.getCertificateValidityEndingDate().format(formatter) : "";
        table.addCell(PDFUtil.createDataCell(certificateValidityEndDate));*/

        table.setMarginBottom(10);

        return table;
    }

    private Table getParallelReservationTable(UndertakingDTO dto){
        Table table = new Table(4);

        //1. Earth Quake Affected
        table.addCell(PDFUtil.createBoldDataCell("भूकंपग्रस्त:"));
        if(dto.isEarthQuakeEffected()) {
            table.addCell(PDFUtil.createDataCell("होय"));
        } else {
            table.addCell(PDFUtil.createDataCell("नाही"));
        }

        // 2. Project Affected
        table.addCell(PDFUtil.createBoldDataCell("प्रकल्पग्रस्त:"));
        if(dto.isProjectEffected()) {
            table.addCell(PDFUtil.createDataCell("होय"));
        } else {
            table.addCell(PDFUtil.createDataCell("नाही"));
        }

        // 3.Ex Service man
        table.addCell(PDFUtil.createBoldDataCell("माजी सैनिक:"));
        if(dto.isExServiceMan()) {
            table.addCell(PDFUtil.createDataCell("होय"));
            table.addCell(PDFUtil.createBoldDataCell("सैन्यदलातील एकूण सेवा काळ:"));
            table.addCell(PDFUtil.createDataCell(dto.getExServiceManTotalExpInYears()+ " - वर्षे    " + dto.getExServiceManTotalExpInMonths() +" - महिने"));
        } else {
            table.addCell(PDFUtil.createDataCell("नाही"));
            table.addCell(PDFUtil.createDataCell(""));
            table.addCell(PDFUtil.createDataCell(""));
        }

        // 4. Part Time Employee
        table.addCell(PDFUtil.createBoldDataCell("राज्यशासनाचे अंशकालीन कर्मचारी (सुशिक्षितबेरोजगार, आर्थिक सहाय्य योजने अंतर्गत येणारे अंशकालीन कर्मचारी):"));
        if(dto.isPartTimeEmployee()) {
            table.addCell(PDFUtil.createDataCell("होय"));
            table.addCell(PDFUtil.createBoldDataCell("एकूण अनुभव:"));
            table.addCell(PDFUtil.createDataCell(dto.getPartTimeEmployeeExpInYears() + " - वर्षे    " + dto.getPartTimeEmployeeExpInMonths() +" - महिने"));
        } else {
            table.addCell(PDFUtil.createDataCell("नाही"));
            table.addCell(PDFUtil.createDataCell(""));
            table.addCell(PDFUtil.createDataCell(""));
        }

        // 5. Sports person
        table.addCell(PDFUtil.createBoldDataCell("अत्युच्च गुणवत्ताधारक खेळाडू:"));
        if(dto.isSportsPerson()) {
            table.addCell(PDFUtil.createDataCell("होय"));
            table.addCell(PDFUtil.createBoldDataCell("खेळाचा स्तर:"));
            table.addCell(PDFUtil.createDataCell(StringUtils.isBlank(dto.getSportsLevel()) ? "" : dto.getSportsLevel().trim().equals("State") ? "राज्यस्तर" : "राष्ट्रीयस्तर"));
        } else {
            table.addCell(PDFUtil.createDataCell("नाही"));
            table.addCell(PDFUtil.createDataCell(""));
            table.addCell(PDFUtil.createDataCell(""));
        }

        //6. ST Employee
        table.addCell(PDFUtil.createBoldDataCell("रा. प. कर्मचारी:"));
        if(dto.isStEmployee()) {
            table.addCell(PDFUtil.createDataCell("होय"));
        } else {
            table.addCell(PDFUtil.createDataCell("नाही"));
        }
        
        //Orphaned Person:
        table.addCell(PDFUtil.createBoldDataCell("अनाथ व्यक्ती:"));
        if(dto.isOrphanedPerson()) {
            table.addCell(PDFUtil.createDataCell("होय"));
        } else {
            table.addCell(PDFUtil.createDataCell("नाही"));
        }

        table.setMarginBottom(10);

        return table;
    }

    
    private Table getPreferredCitiesTable(UndertakingDTO dto){
        Table table = new Table(2);

        table.addCell(PDFUtil.createBoldDataCell("परीक्षा देण्यासाठी शहर:"));
        table.addCell(PDFUtil.createDataCell(""));
       // table.addCell(PDFUtil.createDataCell(""));
       // table.addCell(PDFUtil.createDataCell(""));

        table.addCell(PDFUtil.createBoldDataCell("पहिला पर्याय:"));
        table.addCell(PDFUtil.createDataCell(dto.getFirstPreferredCity()));
       // table.addCell(PDFUtil.createDataCell(""));
       // table.addCell(PDFUtil.createDataCell(""));

        table.addCell(PDFUtil.createBoldDataCell("दुसरा पर्याय:"));
        table.addCell(PDFUtil.createDataCell(dto.getSecondPreferredCity()));
       // table.addCell(PDFUtil.createDataCell(""));
       // table.addCell(PDFUtil.createDataCell(""));

        table.addCell(PDFUtil.createBoldDataCell("तिसरा पर्याय:"));
        table.addCell(PDFUtil.createDataCell(dto.getThirdPreferredCity()));
       // table.addCell(PDFUtil.createDataCell(""));
        //table.addCell(PDFUtil.createDataCell(""));

        table.setMarginBottom(20);

        return table;
    }

    private Table getPostAppliedForTable(UndertakingDTO dto){
        Table table = new Table(2);

        Cell c1 = PDFUtil.createBoldDataCell(("पदा करीता अर्ज:  " + dto.getPostAppliedFor()));
        c1.setWidth(UnitValue.createPercentValue(60));

        Cell c2 = PDFUtil.createBoldDataCell("विभाग/घटक: " + (StringUtils.isBlank(dto.getDivisionName()) ? "" : dto.getDivisionName()));
        c2.setWidth(UnitValue.createPercentValue(40));

        table.addCell(c1 );
        table.addCell(c2);

        table.setMarginBottom(15);

        return table;
    }


    private Table getUndertakingTable(UndertakingDTO dto){
        Table table = new Table(2);

        Text boldText = new Text("प्रतिज्ञापत्र")
                .setFont(font)
                .setTextRenderingMode(PdfCanvasConstants.TextRenderingMode.FILL_STROKE)
                .setStrokeWidth(0.2f)
                .setStrokeColor(DeviceGray.BLACK);

        Cell heading = new Cell(1, 2)
                .setTextAlignment(TextAlignment.CENTER)
                .setVerticalAlignment(VerticalAlignment.TOP)
                .add(new Paragraph(boldText))
                .setFontSize(15)
                .setBorder(Border.NO_BORDER)
                .setBorderTop(new SolidBorder(0.5F))
                .setBorderLeft(new SolidBorder(0.5F))
                .setBorderRight(new SolidBorder(0.5F))
                .setPaddings(0,2,0,4);

        Cell undertaking = new Cell(1, 2)
                .setTextAlignment(TextAlignment.LEFT)
                .setVerticalAlignment(VerticalAlignment.TOP)
                .add("मी असे प्रमाणित करतो / करते की म.रा.मा.प. महामंडळामधील अर्ज केलेल्या पदासाठीच्या अटी काळजीपूर्वक वाचल्या असून सदर जाहिरातीतील अटी व शर्ती मला मान्य आहेत. या अर्जात दिलेली सर्व माहिती संपूर्ण खरी व योग्य आहे असे मी जाहीर करतो / करते. कागदपत्रांच्या छाननीच्या वेळी अर्जात उल्लेख केलेली सर्व मूळ प्रमाणपत्रे सादर करावी लागतील याची मला जाणीव आहे. या पुढे असेही जाहीर करतो / करते की, भविष्यात यापैकी कोणतीही माहिती खोटी व चुकीची आढळल्यास मी महामंडळ सेवेसाठी अपात्र ठरेन व कायदेशीर कार्यवाहीसाठी पात्र ठरेन, जर मला पोलीस चौकशीत किंवा न्यायालयीन प्रकरणी पूर्वी शिक्षा झाली असल्यास मी निर्णयाची प्रत निवड पूर्व कागद पत्र तपासणीत सादर करेन व लहान कुटुंबाचे प्रतिज्ञापत्र शासन अधिसूचना नुसार निवडपूर्व तपासणीच्या वेळी सादर करीन.")
                .setBorder(Border.NO_BORDER)
                .setBorderLeft(new SolidBorder(0.5F))
                .setBorderRight(new SolidBorder(0.5F))
                .setPaddings(0,2,0,4);

        Cell date = new Cell(1, 2)
                .setTextAlignment(TextAlignment.LEFT)
                .setVerticalAlignment(VerticalAlignment.TOP)
                .add("दिनांक : ")
                .setBorder(Border.NO_BORDER)
                .setBorderLeft(new SolidBorder(0.5F))
                .setBorderRight(new SolidBorder(0.5F))
                .setPaddings(20,2,0,4);

        Cell place = new Cell(1, 1)
                .setTextAlignment(TextAlignment.LEFT)
                .setVerticalAlignment(VerticalAlignment.TOP)
                .add("ठिकाण : ")
                .setBorder(Border.NO_BORDER)
                .setBorderLeft(new SolidBorder(0.5F))
                .setBorderBottom(new SolidBorder(0.5F))
                .setPaddings(0,2,0,4);

        Cell signature = new Cell(1, 1)
                .setTextAlignment(TextAlignment.RIGHT)
                .setVerticalAlignment(VerticalAlignment.TOP)
                .add("उमेदवाराची स्वाक्षरी")
                .setBorder(Border.NO_BORDER)
                .setBorderRight(new SolidBorder(0.5F))
                .setBorderBottom(new SolidBorder(0.5F))
                .setPaddings(0,2,0,4);

        table.addCell(heading);
        table.addCell(undertaking);
        table.addCell(date);
        table.addCell(place);
        table.addCell(signature);

        return table;
    }

}
