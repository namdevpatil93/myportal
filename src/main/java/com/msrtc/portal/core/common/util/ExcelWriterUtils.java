package com.msrtc.portal.core.common.util;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

public class ExcelWriterUtils {

	private ExcelWriterUtils() {
	}

	public static XSSFWorkbook createWorkbook() {
		return new XSSFWorkbook();
	}

	public static Sheet createSheet(Workbook workbook, String sheetName) {
		return workbook.createSheet(sheetName);
	}

	public static Row createRow(Sheet sheet, int rowNumber) {
		return sheet.createRow(rowNumber);
	}

    public static Row createHeaderRow(Sheet sheet, int rowNumber, List<String> headers, CellStyle cellStyle) {
        return createHeaderRow(sheet, rowNumber, 0, headers, cellStyle);
    }

    public static Row createHeaderRow(Sheet sheet, int rowNumber, int startColNo, List<String> headers, CellStyle cellStyle) {
        Row headerRow = createRow(sheet, rowNumber);
        if (headers != null && headers.size() > 0) {
            int index = 0;
            for(String header : headers){
                createCell(headerRow, index + startColNo, header, cellStyle);
                index++;
            }
        }
        return headerRow;
    }

	public static void createMergedCell(Sheet sheet, String cellValue, int rowNumber, Integer startRow,
                                        Integer endRow, Integer startColumn, Integer endColumn, CellStyle cellStyle) {
		Row row = sheet.getRow(rowNumber);
		if(row==null){
			row = ExcelWriterUtils.createRow(sheet, rowNumber);
		}
		sheet.addMergedRegion(new CellRangeAddress(startRow, endRow, startColumn, endColumn));
		Cell cell = row.createCell(startColumn);
		cell.setCellValue(cellValue);
		cellStyle.setAlignment(CellStyle.ALIGN_CENTER);
		cell.setCellStyle(cellStyle);
	}
	
	public static Cell createCell(Row row, int cellNumber, Object cellValue, CellStyle cellStyle) {
		Cell cell = row.createCell(cellNumber);

		if (cellValue instanceof String) {
			cell.setCellValue(String.valueOf(cellValue));
		} else if (cellValue instanceof LocalDate) {
			cell.setCellValue(java.sql.Date.valueOf((LocalDate) cellValue));
		} else if (cellValue instanceof BigDecimal) {
			cell.setCellValue(((BigDecimal) cellValue).doubleValue());
		} else if (cellValue instanceof Double) {
			cell.setCellValue((Double)cellValue);
		}

		if (cellStyle != null) {
			cell.setCellStyle(cellStyle);
        }
		Sheet cellSheet = cell.getSheet();
		cellSheet.autoSizeColumn(cellNumber);
		return cell;
	}

    public static CellStyle getDefaultCellStyle(Workbook workbook) {
        CellStyle style = workbook.createCellStyle();

        style.setAlignment(CellStyle.ALIGN_CENTER);
        style.setWrapText(true);
        style.setFont(getDefaultFont(workbook));

        applyBorderToCells(style);

        return style;
    }
    
    public static CellStyle getDefaultCellStyleLeftAligned(Workbook workbook) {
        CellStyle style = workbook.createCellStyle();

        style.setAlignment(CellStyle.ALIGN_LEFT);
        style.setWrapText(true);
        style.setFont(getDefaultFont(workbook));

        applyBorderToCells(style);

        return style;
    }

    public static CellStyle getPrimaryHeaderCellStyle(Workbook workbook) {
        CellStyle headerStyle = getBoldCellStyle(workbook);
        headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        headerStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
        return headerStyle;
    }
    
    public static CellStyle getColoredCellStyle(Workbook workbook, short color) {
        CellStyle headerStyle = workbook.createCellStyle();
        headerStyle.setFillForegroundColor(color);
        headerStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
        headerStyle.setAlignment(CellStyle.ALIGN_CENTER);
        headerStyle.setWrapText(true);
        headerStyle.setFont(getDefaultFont(workbook));

        applyBorderToCells(headerStyle);
        return headerStyle;
    }
    
    public static CellStyle getColoredBoldCellStyle(Workbook workbook, short color) {
        CellStyle headerStyle = getBoldCellStyle(workbook);
        headerStyle.setFillForegroundColor(color);
        headerStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
        return headerStyle;
    }

    public static CellStyle getSecondaryHeaderCellStyle(Workbook workbook) {
        XSSFCellStyle headerStyle = (XSSFCellStyle) ExcelWriterUtils.getBoldCellStyle(workbook);
        headerStyle.setFillForegroundColor(new XSSFColor(new java.awt.Color(250, 219, 216)));
        headerStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
        return headerStyle;
    }

	public static CellStyle getBoldCellStyle(Workbook workbook) {
		CellStyle boldStyle = getDefaultCellStyle(workbook);
		boldStyle.setFont(getBoldFont(workbook));
		return boldStyle;
	}

	public static CellStyle getBoldCellStyleLeftAligned(Workbook workbook) {
		CellStyle boldStyle = getDefaultCellStyleLeftAligned(workbook);
		boldStyle.setFont(getBoldFont(workbook));
		return boldStyle;
	}
    public static Font getDefaultFont(Workbook workbook) {
        Font font = workbook.createFont();

        font.setFontName("Arial");
        font.setFontHeightInPoints((short) 10);
        font.setColor(IndexedColors.BLACK.getIndex());
        font.setBold(false);
        font.setItalic(false);

        return font;
    }

    public static Font getBoldFont(Workbook workbook) {
		Font boldFont = getDefaultFont(workbook);
		boldFont.setBold(true);
		return boldFont;
	}

    private static void applyBorderToCells(CellStyle style) {
        style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        style.setBorderTop(HSSFCellStyle.BORDER_THIN);
        style.setBorderRight(HSSFCellStyle.BORDER_THIN);
        style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
    }

}
