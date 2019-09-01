package com.msrtc.portal.core.common.util;

import java.io.FileReader;
import java.io.IOException;
import java.util.Collections;
import java.util.List;

import com.msrtc.portal.challan.domain.ChallanFilter;
import com.opencsv.CSVParser;
import com.opencsv.CSVReader;
import com.opencsv.bean.CsvToBean;
import com.opencsv.bean.CsvToBeanFilter;
import com.opencsv.bean.HeaderColumnNameMappingStrategy;

public class CSVReaderUtils {

    private CSVReaderUtils(){}

    @SuppressWarnings("unchecked")
	public static <T> List<T> parseCSV(String csvFileLocation, Class<T> beanClass){
    	// '1' is number of rows before Headers.
        try (CSVReader reader = new CSVReader(new FileReader(csvFileLocation), CSVParser.DEFAULT_SEPARATOR, CSVParser.DEFAULT_QUOTE_CHARACTER, 1)) {
            HeaderColumnNameMappingStrategy<T> strategy = new HeaderColumnNameMappingStrategy<>();
            T instance = beanClass.newInstance();
            strategy.setType((Class<? extends T>) instance.getClass());
            CsvToBean<T> csvToBean = new CsvToBean<>();
            
            CsvToBeanFilter filter = new ChallanFilter(strategy);
            
            return csvToBean.parse(strategy, reader, filter);
        } catch (IOException | InstantiationException | IllegalAccessException e) {
            e.printStackTrace();
        } catch (Exception e){
            e.printStackTrace();
        }
        return Collections.emptyList();
    }

}
