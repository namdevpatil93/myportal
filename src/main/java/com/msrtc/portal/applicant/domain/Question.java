package com.msrtc.portal.applicant.domain;

import java.util.List;

public class Question {
	
	private String questionText;
	
	private List<String> questionImages;
	
	private List<Choice> choices;
	
	private List<QuestionAnswer> questionAnswers;

	public String getQuestionText() {
		return questionText;
	}

	public void setQuestionText(String questionText) {
		this.questionText = questionText;
	}

	public List<String> getQuestionImages() {
		return questionImages;
	}

	public void setQuestionImages(List<String> questionImages) {
		this.questionImages = questionImages;
	}

	public List<Choice> getChoices() {
		return choices;
	}

	public void setChoices(List<Choice> choices) {
		this.choices = choices;
	}

	public List<QuestionAnswer> getQuestionAnswers() {
		return questionAnswers;
	}

	public void setQuestionAnswers(List<QuestionAnswer> questionAnswers) {
		this.questionAnswers = questionAnswers;
	}

	
}
