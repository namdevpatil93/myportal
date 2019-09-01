package com.msrtc.portal.challan.domain;

import com.opencsv.bean.CsvToBeanFilter;
import com.opencsv.bean.MappingStrategy;

@SuppressWarnings("rawtypes")
public class ChallanFilter implements CsvToBeanFilter {
	
	private final MappingStrategy strategy;

 	public ChallanFilter(MappingStrategy strategy) {
 		this.strategy = strategy;
 	}
 	
 	public MappingStrategy getStrategy() {
		return strategy;
	}

	@Override
	public boolean allowLine(String[] line) {
 		/*
 		 * '1' because 'createdDate' can not be NULL,
 		 * as we aasign LocalDateTime.now() at instance level.
 		 */
 		return line.length > 1;
	}

}
