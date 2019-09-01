package com.msrtc.portal.applicant.domain;

import java.util.List;

import com.google.gson.annotations.SerializedName;

public class ApplicantRestResponse extends Response{
	
	private static final long serialVersionUID = -6960443444656542202L;

	@SerializedName("questionContainer")
	private List<Question> questions;

	public List<Question> getQuestions() {
		return questions;
	}

	public void setQuestions(List<Question> questions) {
		this.questions = questions;
	}

	@Override
	public String toString() {
		return "ApplicantRestResponse [questions=" + questions + "]";
	}


}
