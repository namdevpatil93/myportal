package com.msrtc.portal.applicant.util;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

import org.springframework.context.MessageSource;

import com.itextpdf.io.image.ImageDataFactory;
import com.itextpdf.kernel.color.Color;
import com.itextpdf.kernel.color.DeviceGray;
import com.itextpdf.kernel.font.PdfFont;
import com.itextpdf.kernel.pdf.canvas.PdfCanvasConstants;
import com.itextpdf.layout.Style;
import com.itextpdf.layout.border.Border;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Image;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.element.Text;
import com.itextpdf.layout.property.HorizontalAlignment;
import com.itextpdf.layout.property.TextAlignment;
import com.itextpdf.layout.property.UnitValue;
import com.itextpdf.layout.property.VerticalAlignment;
import com.msrtc.portal.applicant.dto.UndertakingDTO;

public class PDFUtil {
	
	private static PdfFont font;
	
	private static MessageSource messageSource;
	
	
	public static PdfFont getFont() {
		return font;
	}

	public static void setFont(PdfFont font) {
		PDFUtil.font = font;
	}
	
	public static MessageSource getMessageSource() {
		return messageSource;
	}

	public static void setMessageSource(MessageSource messageSource) {
		PDFUtil.messageSource = messageSource;
	}

	public static Cell createBoldDataCell(String text) {
        Text boldText = new Text(text)
                .setFont(getFont())
                .setTextRenderingMode(PdfCanvasConstants.TextRenderingMode.FILL_STROKE)
                .setStrokeWidth(0.2f)
                .setStrokeColor(DeviceGray.BLACK);

        Cell cell = new Cell()
                .setTextAlignment(TextAlignment.LEFT)
                .setVerticalAlignment(VerticalAlignment.TOP)
                .add(new Paragraph(boldText))
                .setPaddings(0,2,0,4)
                .setWidth(UnitValue.createPercentValue(25));

        return cell;
    }

	public static Cell createDataCell(String text){

        if(org.springframework.util.StringUtils.isEmpty(text)){
            text = "";
        }

        Cell cell = new Cell()
                .setTextAlignment(TextAlignment.LEFT)
                .setVerticalAlignment(VerticalAlignment.TOP)
                .add(new Paragraph(text))
                .setPaddings(0,2,0,4)
                .setWidth(UnitValue.createPercentValue(25));

        return cell;
    }

	public static Table getHeaderTable(UndertakingDTO dto){
        Table table = new Table(3);

        table.setFontSize(9);

        try {
            Cell logoCell = createLogoCell(dto.getLogoPath());
            logoCell
                    .setWidth(UnitValue.createPercentValue(15))
                    .setVerticalAlignment(VerticalAlignment.TOP);

            Style style = new Style();
            style.setFontColor(Color.BLACK,1 );

            Text boldText = new Text(getLabel("mainHeader", "mr"))
                    .setFont(getFont())
                    .setTextRenderingMode(PdfCanvasConstants.TextRenderingMode.FILL_STROKE)
                    .setStrokeWidth(0.5f)
                    .setStrokeColor(DeviceGray.BLACK);

            Cell headingCell = new Cell(2, 1)
                    .setTextAlignment(TextAlignment.CENTER)
                    .setVerticalAlignment(VerticalAlignment.TOP)
                    .add(new Paragraph(boldText))
                    .setFontSize(15)
                    .setBorder(Border.NO_BORDER)
                    .addStyle(style)
                    .setWidth(UnitValue.createPercentValue(70));

            table.addCell(logoCell);
            table.addCell(headingCell);
            Table photoAndSignatureTable = createPhotoAndSignatureTable(dto);
            photoAndSignatureTable.setBorder(Border.NO_BORDER);
            table.addCell(photoAndSignatureTable);
            table.setBorder(Border.NO_BORDER);
            table.setMarginBottom(10);

        } catch (IOException e) {
            e.printStackTrace();
        }

        return table;
    }
    
	public static Cell createLogoCell(String logoLocation) throws IOException {
        Cell cell = new Cell(2, 1);
        Image image = new Image(ImageDataFactory.create(logoLocation));
        image.setWidth(58);
        image.setHeight(58f);
        // image.setAutoScaleWidth(true);
        cell.add(image);
        cell.setBorder(Border.NO_BORDER);
        return cell;
    }
    
	public static Table createPhotoAndSignatureTable(UndertakingDTO dto){
        Table table = new Table(1);

        try {
            Cell photoCell = createPhotoCell(dto.getPhotoLocation());
            Cell signatureCell = createSignatureCell(dto.getSignatureLocation());

            photoCell.setBorder(Border.NO_BORDER);
            signatureCell.setBorder(Border.NO_BORDER);

            table.addCell(photoCell);
            table.addCell(signatureCell);
            table.setBorder(Border.NO_BORDER);


        } catch (IOException e) {
            e.printStackTrace();
        }

        return table;
    }
    
	public static Cell createPhotoCell(String photoLocation) throws IOException {
        Cell cell = new Cell(1, 1);
        Image image = new Image(ImageDataFactory.create(photoLocation));
        image.setWidth(58);
        image.setHeight(58f);
        cell.add(image);
        cell.setHorizontalAlignment(HorizontalAlignment.CENTER);
        // cell.setBorder(Border.NO_BORDER);
        return cell;
    }

	public static Cell createSignatureCell(String signatureLocation) throws IOException {
        Cell cell = new Cell(1, 1);
        Image image = new Image(ImageDataFactory.create(signatureLocation));
        image.setWidth(65);
        image.setHeight(40f);
        cell.add(image);
        // cell.setBorder(Border.NO_BORDER);
        cell.setHorizontalAlignment(HorizontalAlignment.CENTER);
        return cell;
    }
    
    private static String getLabel(String messageKey, String locale){
        return getMessageSource().getMessage(messageKey, null, new Locale(locale));
    }
    
    public static String checkCondition(boolean flag) {
        return flag ? "होय" : "नाही";

    }
    
    public static String getFormattedDate(LocalDate  date) {
    	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        return date != null ? date.format(formatter) : "";
    }
    
    public static String checkPriority(int priority) {
    	return priority != 0 ? String.valueOf(priority) : "";
    }
}
