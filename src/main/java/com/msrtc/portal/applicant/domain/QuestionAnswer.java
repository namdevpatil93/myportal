package com.msrtc.portal.applicant.domain;

import java.util.List;

public class QuestionAnswer {
	
	private String answersText;
	
	private Boolean correct;
	
	private List<String> answersImages;

	public String getAnswersText() {
		return answersText;
	}

	public void setAnswersText(String answersText) {
		this.answersText = answersText;
	}
	
	public Boolean getCorrect() {
		return correct;
	}

	public void setCorrect(Boolean correct) {
		this.correct = correct;
	}

	public List<String> getAnswersImages() {
		return answersImages;
	}

	public void setAnswersImages(List<String> answersImages) {
		this.answersImages = answersImages;
	}

}
