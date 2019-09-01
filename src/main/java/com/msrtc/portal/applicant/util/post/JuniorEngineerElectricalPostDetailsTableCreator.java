package com.msrtc.portal.applicant.util.post;

import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Table;
import com.msrtc.portal.applicant.dto.UndertakingDTO;
import com.msrtc.portal.applicant.util.PDFUtil;

public class JuniorEngineerElectricalPostDetailsTableCreator {
	private UndertakingDTO dto;

    public JuniorEngineerElectricalPostDetailsTableCreator(UndertakingDTO dto){
        this.dto = dto;
    }

    public Table create() {
        Table table = new Table(4);
        
        table.addCell(PDFUtil.createBoldDataCell("प्राधान्य:"));
        table.addCell(PDFUtil.createDataCell("तांत्रिक - " + PDFUtil.checkPriority(dto.getPriority())));
        table.addCell(PDFUtil.createBoldDataCell(""));
        table.addCell(PDFUtil.createDataCell(""));
        
        table.addCell(PDFUtil.createBoldDataCell("शासनमान्य संस्था / विद्यापिठाची विद्युत अभियांत्रिकीमधील पदविका (३ वर्षे मुदतीची) / पदवी:"));
        table.addCell(PDFUtil.createDataCell(PDFUtil.checkCondition(dto.isElectricalEngineeringDegree())));
        table.addCell(PDFUtil.createBoldDataCell("पदविका / पदवीचे नाव:"));
        Cell cellDegreeName = null;
        Cell cellUniversityName = null;
        if(dto.isElectricalEngineeringDegree()) {
        	cellDegreeName = PDFUtil.createDataCell(dto.getDegreeName());
        	cellUniversityName = PDFUtil.createDataCell(dto.getUniversityName());
        } else {
        	cellDegreeName = PDFUtil.createDataCell("");
        	cellUniversityName = PDFUtil.createDataCell("");
        }
        table.addCell(cellDegreeName);
        
        table.addCell(PDFUtil.createBoldDataCell("बोर्ड / विद्यापीठाचे नाव:"));
        table.addCell(cellUniversityName);
        table.addCell(PDFUtil.createDataCell(""));
        table.addCell(PDFUtil.createDataCell(""));
        
        return table;
    }
}
