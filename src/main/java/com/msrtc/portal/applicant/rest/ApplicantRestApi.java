package com.msrtc.portal.applicant.rest;

import com.msrtc.portal.applicant.domain.Applicant;
import com.msrtc.portal.applicant.domain.ApplicantRestResponse;

public interface ApplicantRestApi {
	
	public ApplicantRestResponse getExamDataFromExamBench(Applicant applicant,String examBenchBaseUrl,String examBenchAccessToken, String lngCode);

}
