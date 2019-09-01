package com.msrtc.portal.document.domain;

public enum DocumentEnum {
	
	RECRUITMENT_FEE(1), INFORMATION(2), INSTRUCTIONS(3), TIMETABLE(4), RESULT(5), ANNOUNCEMENTS(6), ADVERTISEMENTS(7);

    private int documentId;

    DocumentEnum(int documentId){
        this.documentId = documentId;
    }

    public int getDocumentId() {
        return documentId;
    }
    
    public static String getDocumentTypeById(int documentId) {
		
		switch(documentId) {
			case 1:
				return "RECRUITMENT_FEE";
			
			case 2:
				return "INFORMATION";
			
			case 3:
				return "INSTRUCTIONS";
			
			case 4:
				return "TIMETABLE";
			
			case 5:
				return "RESULT";
			
			case 6:
				return "ANNOUNCEMENTS";
			
			case 7:
				return "ADVERTISEMENTS";
		}
		
		return "";
	}
}
