package com.msrtc.portal.core.common.util;

import java.text.NumberFormat;
import java.util.Locale;

public class NumberFormatMultiLang {
	public static String localize(Integer number, String language, String country) 
	 {
		NumberFormat formatter = NumberFormat.getInstance(new Locale(language, country));
	    formatter.setGroupingUsed(false);
	    if("en".equalsIgnoreCase(language)){
	    	return ordinal(number);
	    }else{
	    	return formatter.format(number);
	    }
	    
	 }
	
	public static String ordinal(Integer i) {
	    String[] sufixes = new String[] { "th", "st", "nd", "rd", "th", "th", "th", "th", "th", "th" };
	    switch (i % 100) {
	    case 11:
	    case 12:
	    case 13:
	        return i + "th";
	    default:
	        return i + sufixes[i % 10];

	    }
	}

}
