package com.msrtc.portal.applicant.domain;

import java.util.List;

public class Choice {
	
	private String choiceText;
	
	private Boolean correct;
	
	private List<String> choiceImages;

	public String getChoiceText() {
		return choiceText;
	}

	public void setChoiceText(String choiceText) {
		this.choiceText = choiceText;
	}
	
	public Boolean getCorrect() {
		return correct;
	}

	public void setCorrect(Boolean correct) {
		this.correct = correct;
	}

	public List<String> getChoiceImages() {
		return choiceImages;
	}

	public void setChoiceImages(List<String> choiceImages) {
		this.choiceImages = choiceImages;
	}

	@Override
	public String toString() {
		return "Choice [choiceText=" + choiceText + ", correct=" + correct + ", choiceImages=" + choiceImages + "]";
	}

}
