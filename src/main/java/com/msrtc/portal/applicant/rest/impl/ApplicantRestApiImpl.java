package com.msrtc.portal.applicant.rest.impl;


import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.msrtc.portal.applicant.domain.Applicant;
import com.msrtc.portal.applicant.domain.ApplicantRestResponse;
import com.msrtc.portal.applicant.rest.ApplicantRestApi;
import com.msrtc.portal.core.common.util.HttpUtils;
import com.msrtc.portal.core.common.util.JsonUtils;
import com.msrtc.portal.core.common.util.RestConstants;

@Component
public class ApplicantRestApiImpl  implements ApplicantRestApi{

	private final Logger log = LoggerFactory.getLogger(getClass());

	@Override
	public ApplicantRestResponse getExamDataFromExamBench(Applicant applicant,String examBenchBaseUrl, String examBenchAccessToken,String lngCode) {
		
		String url = examBenchBaseUrl+RestConstants.GET_EXAM_API_PATH;
		
		Map<String, String> params = new HashMap<>();
		params.put("access_token",examBenchAccessToken);
		params.put("groupName", applicant.getGroupName());
		params.put("applicantId", applicant.getApplicationId());
		params.put("email", applicant.getEmailAddress());
		params.put("locale",lngCode);
		try{
			String response = HttpUtils.sendPostRequest(url, null, params);
//			System.out.println("Response -- - - "+response);
			return JsonUtils.convertJsonStringToObject(response, ApplicantRestResponse.class);
		}catch(Exception e){
			e.printStackTrace();
			log.error("Error in json data importExam ApplicantsData");
		}
		return null;
	}
	
	
}
