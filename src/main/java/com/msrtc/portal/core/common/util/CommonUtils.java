package com.msrtc.portal.core.common.util;

import javax.servlet.http.HttpServletRequest;
import java.time.DateTimeException;
import java.time.LocalDate;
import java.time.Period;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Random;

public class CommonUtils {

	private CommonUtils() {
	}

	public static String generateRandomPassword() {
        String charactersAllowed = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";
        StringBuilder password = new StringBuilder();
        Random rnd = new Random();
        while (password.length() < 8) {
            int index = (int) (rnd.nextFloat() * charactersAllowed.length());
            password.append(charactersAllowed.charAt(index));
        }
        return password.toString();
    }
	
	public static String generateApplicationId(String aId){
		Integer aidLength = aId.length();
		Integer padding = (7-aidLength);
		StringBuilder sb = new StringBuilder();
		sb.append("MSRTC");
		for(Integer i=0;i<padding;i++)
		{
			sb.append("0");
		}
		sb.append(aId);
		return sb.toString();
	}
	
	public static Integer generateRandomOTP() {
		Integer otp = (100000 + (int)(new Random().nextFloat() * 899900));
		return otp;
	}

	public static int[] getApplicantAgeInYearsAndMonths(LocalDate birthDate)
	{
		int[] ageAndMonthsArr = new int[3];
        ZoneId kolkata = ZoneId.of("Asia/Kolkata");

        LocalDate currentDate = LocalDate.now(kolkata);
		
        Period age = Period.between(birthDate, currentDate);
        //applicant age in years
        ageAndMonthsArr[0] = age.getYears();
        //applicant age in months 
        ageAndMonthsArr[1] = age.getMonths();
		ageAndMonthsArr[2] = age.getDays() + 1;
		return ageAndMonthsArr;
	}
	
	public static String getLocalDateFormat(LocalDate localDate, String format)
	{
		try{
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern(format);
			
			return localDate.format(formatter);
			
		}catch(NullPointerException | IllegalArgumentException | DateTimeException ex)
		{
			ex.printStackTrace();
		}
		return LocalDate.now().toString();
	}

	public static int[] getApplicantAgeAsOnGivenDate(LocalDate birthDate, LocalDate givenDate)
	{
		int[] ageAndMonthsArr = new int[3];
		Period age = Period.between(birthDate, givenDate);
		ageAndMonthsArr[0] = age.getYears();
		ageAndMonthsArr[1] = age.getMonths();
		ageAndMonthsArr[2] = age.getDays() + 1;
		return ageAndMonthsArr;
	}

	public static String getClientIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("X-Forwarded-For");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

}
