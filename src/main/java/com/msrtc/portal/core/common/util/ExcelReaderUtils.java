package com.msrtc.portal.core.common.util;

import com.msrtc.portal.core.annotation.ExcelBindByName;
import com.msrtc.portal.core.domain.BaseExcelEntity;
import org.apache.poi.ss.usermodel.*;

import java.io.File;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * The type Excel Reader utils.
 */
public class ExcelReaderUtils {

    private ExcelReaderUtils(){

    }

    /**
     * Extract rows from excel list.
     *
     * @param <T>                the type parameter
     * @param location           the location
     * @param typeParameterClass the type parameter class
     * @param sheetNo            the sheet no
     * @param headerRowNo        the header row no
     * @param dataStartRowNumber the data start row number
     * @return the list
     */
    public static <T extends BaseExcelEntity> List<T> extractRowsFromExcel(String location, Class<T> typeParameterClass, int sheetNo, int headerRowNo, int dataStartRowNumber){
        List<T> list = new ArrayList<T>();

        try {
            File savedFile = new File(location);

            Workbook wb = WorkbookFactory.create(savedFile);
            // this is the sheet no. of the excel file to read
            // indexing starts from 0
            Sheet sheet = wb.getSheetAt(sheetNo);
            Row row;
            Cell cell;

            int totalRows = sheet.getPhysicalNumberOfRows();// No of rows
            int cols = 0; // No of columns
            int tmp = 0;

            // This trick ensures that we get the data properly even if it doesn't start from first few rows
            for(int i = 0; i < 10 || i < totalRows; i++) {
                row = sheet.getRow(i);
                if(row != null) {
                    tmp = sheet.getRow(i).getPhysicalNumberOfCells();
                    if(tmp > cols) cols = tmp;
                }
            }

            Map<Integer, Field> columnIndexFieldMap = getColumnIndexFieldMap(typeParameterClass.getDeclaredFields(), sheet.getRow(headerRowNo));

            for(int rowNumber = dataStartRowNumber; rowNumber <= totalRows; rowNumber++) {
                row = sheet.getRow(rowNumber);
                if(row != null && !isRowEmpty(row)) {
                    /*if(r == 300){
                        break;
                    }*/
                    T instance = typeParameterClass.newInstance();
                    for(int columnIndex = 0; columnIndex < cols; columnIndex++) {
                        Field field = columnIndexFieldMap.get(columnIndex);
                        if(field != null) {
                            cell = row.getCell((short) columnIndex);
                            if (cell != null) {
                                copyCellValueToInstanceProperty(cell, instance, field);
                            }
                        }
                    }

                    list.add(instance);
                }
            }
        } catch(Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    private static Map<Integer, Field> getColumnIndexFieldMap(Field[] fieldList, Row headerRow) {
        Map<Integer, Field> columnIndexFieldMap = new HashMap<>();

        if(fieldList != null && fieldList.length > 0) {
            for (int i = 0; i < fieldList.length; i++) {
                Field field = fieldList[i];
                if (field.getAnnotation(ExcelBindByName.class) != null) {
                    field.setAccessible(true);
                    String columnName = field.getAnnotation(ExcelBindByName.class).value();
                    int columnIndex = 0;

                    for(Cell c:headerRow){
                        if (c.getStringCellValue().equalsIgnoreCase(columnName)){
                            columnIndex = c.getColumnIndex();
                        }
                    }

                    columnIndexFieldMap.put(columnIndex, field);
                }
            }
        }

        return columnIndexFieldMap;
    }

    private static <T extends BaseExcelEntity> void copyCellValueToInstanceProperty(Cell cell, T instance, Field field) {
        if(cell.getCellType() == Cell.CELL_TYPE_FORMULA) {
            switch (cell.getCachedFormulaResultType()) {
                case Cell.CELL_TYPE_NUMERIC:
                    cell.setCellType(Cell.CELL_TYPE_STRING);
                    instance.setPropertyValue(field, cell.getRichStringCellValue());
                    break;
                case Cell.CELL_TYPE_STRING:
                    instance.setPropertyValue(field, cell.getRichStringCellValue());
                    break;
            }
        } else {
            switch (cell.getCellType()) {
                case Cell.CELL_TYPE_NUMERIC:
                    cell.setCellType(Cell.CELL_TYPE_STRING);
                    instance.setPropertyValue(field, cell.getRichStringCellValue());
                    break;
                case Cell.CELL_TYPE_STRING:
                    instance.setPropertyValue(field, cell.getRichStringCellValue());
                    break;
            }
        }
    }

    private static boolean isRowEmpty(Row row) {
        for (int c = row.getFirstCellNum(); c < row.getLastCellNum(); c++) {
            Cell cell = row.getCell(c);
            if (cell != null && cell.getCellType() != Cell.CELL_TYPE_BLANK)
                return false;
        }
        return true;
    }
}
