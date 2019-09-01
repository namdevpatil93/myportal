package com.msrtc.portal.email.domain;

import java.util.List;

public class Attachment {
	
	String name;
    String fullPath;
    
    List<String> attachmentPaths;

    Attachment(){}

    public Attachment(String name, String fullPath) {
        this.name = name;
        this.fullPath = fullPath;
    }
    
    

    public Attachment(String name, List<String> attachmentPaths) {
		super();
		this.name = name;
		this.fullPath = fullPath;
		this.attachmentPaths = attachmentPaths;
	}

	public List<String> getAttachmentPaths() {
		return attachmentPaths;
	}

	public void setAttachmentPaths(List<String> attachmentPaths) {
		this.attachmentPaths = attachmentPaths;
	}

	public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getFullPath() {
        return fullPath;
    }

    public void setFullPath(String fullPath) {
        this.fullPath = fullPath;
    }

}
