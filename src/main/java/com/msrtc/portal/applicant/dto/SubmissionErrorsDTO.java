package com.msrtc.portal.applicant.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class SubmissionErrorsDTO implements Serializable {

    private static final long serialVersionUID = -346620192196968747L;

    private boolean valid = true;

    private boolean personalInformationValid = true;

    private boolean otherInformationValid = true;

    private boolean postsSelected = true;

    private boolean photoValid = true;

    private boolean signatureValid = true;

    private boolean postDetailsValid = true;
    
    private boolean readWriteSpeakMarathi = true;

    private List<String> invalidPostNames = new ArrayList<>();
    
    private List<PostSubmissionErrorsDTO> postSubmissionErrorsDTOList = new ArrayList<>();
    
    private boolean prioritySet = true;

    private boolean otherInformationFieldValid = true;
    
    public boolean isValid() {
        return valid;
    }

    public void setValid(boolean valid) {
        this.valid = valid;
    }

    public boolean isPersonalInformationValid() {
        return personalInformationValid;
    }

    public void setPersonalInformationValid(boolean personalInformationValid) {
        this.personalInformationValid = personalInformationValid;
    }

    public boolean isOtherInformationValid() {
        return otherInformationValid;
    }

    public void setOtherInformationValid(boolean otherInformationValid) {
        this.otherInformationValid = otherInformationValid;
    }

    public boolean isPostsSelected() {
        return postsSelected;
    }

    public void setPostsSelected(boolean postsSelected) {
        this.postsSelected = postsSelected;
    }

    public boolean isPhotoValid() {
        return photoValid;
    }

    public void setPhotoValid(boolean photoValid) {
        this.photoValid = photoValid;
    }

    public boolean isSignatureValid() {
        return signatureValid;
    }

    public void setSignatureValid(boolean signatureValid) {
        this.signatureValid = signatureValid;
    }

    public boolean isPostDetailsValid() {
        return postDetailsValid;
    }

    public void setPostDetailsValid(boolean postDetailsValid) {
        this.postDetailsValid = postDetailsValid;
    }

    public List<String> getInvalidPostNames() {
        return invalidPostNames;
    }

    public void setInvalidPostNames(List<String> invalidPostNames) {
        this.invalidPostNames = invalidPostNames;
    }

	public List<PostSubmissionErrorsDTO> getPostSubmissionErrorsDTOList() {
		return postSubmissionErrorsDTOList;
	}

	public void setPostSubmissionErrorsDTOList(List<PostSubmissionErrorsDTO> postSubmissionErrorsDTOList) {
		this.postSubmissionErrorsDTOList = postSubmissionErrorsDTOList;
	}

	public boolean getReadWriteSpeakMarathi() {
		return readWriteSpeakMarathi;
	}

	public void setReadWriteSpeakMarathi(boolean readWriteSpeakMarathi) {
		this.readWriteSpeakMarathi = readWriteSpeakMarathi;
	}

	public boolean getPrioritySet() {
		return prioritySet;
	}

	public void setPrioritySet(boolean prioritySet) {
		this.prioritySet = prioritySet;
	}

	public boolean isOtherInformationFieldValid() {
		return otherInformationFieldValid;
	}

	public void setOtherInformationFieldValid(boolean otherInformationFieldValid) {
		this.otherInformationFieldValid = otherInformationFieldValid;
	}
	
}
