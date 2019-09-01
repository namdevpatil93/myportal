package com.msrtc.portal.applicant.dto;

import java.time.Period;

public class AgeValidationCriteria {

    private Period age;

    private int casteId;

    private int postId;

    private boolean nonCreamyLayer;
    
    private boolean isSportsPerson;

    private boolean isEarthQuakeAffected;

    private boolean isProjectAffected;

    private boolean isPartTimeEmployee;

    private boolean isExServiceMan;

    private boolean isStEmployee;

    private int exServiceManExpYears;

    private int exServiceManExpMonths;
    
    private boolean isDeafAndMute;
    
    private boolean islocomotorOrCerebralPalsy;
    
    private boolean isBelongToEws;

    public AgeValidationCriteria(){}

    public AgeValidationCriteria(Period age, int casteId, int postId, boolean isSportsPerson, boolean isEarthQuakeAffected, boolean isProjectAffected, boolean isPartTimeEmployee, boolean isExServiceMan, int exServiceManExpYears, int exServiceManExpMonths, boolean isStEmployee,boolean nonCreamyLayer) {
        this.age = age;
        this.casteId = casteId;
        this.postId = postId;
        this.isSportsPerson = isSportsPerson;
        this.isEarthQuakeAffected = isEarthQuakeAffected;
        this.isProjectAffected = isProjectAffected;
        this.isPartTimeEmployee = isPartTimeEmployee;
        this.isExServiceMan = isExServiceMan;
        this.exServiceManExpYears = exServiceManExpYears;
        this.exServiceManExpMonths = exServiceManExpMonths;
        this.isStEmployee = isStEmployee;
        this.nonCreamyLayer=nonCreamyLayer;
    }
    
    public AgeValidationCriteria(Period age, int casteId, int postId, boolean isSportsPerson, boolean isEarthQuakeAffected, boolean isProjectAffected, boolean isPartTimeEmployee, boolean isExServiceMan, int exServiceManExpYears, int exServiceManExpMonths, boolean isStEmployee,boolean nonCreamyLayer,
    		boolean isDeafAndMute,boolean islocomotorOrCerebralPalsy, boolean isBelongToEws) {
        this.age = age;
        this.casteId = casteId;
        this.postId = postId;
        this.isSportsPerson = isSportsPerson;
        this.isEarthQuakeAffected = isEarthQuakeAffected;
        this.isProjectAffected = isProjectAffected;
        this.isPartTimeEmployee = isPartTimeEmployee;
        this.isExServiceMan = isExServiceMan;
        this.exServiceManExpYears = exServiceManExpYears;
        this.exServiceManExpMonths = exServiceManExpMonths;
        this.isStEmployee = isStEmployee;
        this.nonCreamyLayer=nonCreamyLayer;
        this.isDeafAndMute=isDeafAndMute;
        this.islocomotorOrCerebralPalsy=islocomotorOrCerebralPalsy;
        this.isBelongToEws=isBelongToEws;
    }

    public Period getAge() {
        return age;
    }

    public void setAge(Period age) {
        this.age = age;
    }

    public int getCasteId() {
        return casteId;
    }

    public void setCasteId(int casteId) {
        this.casteId = casteId;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public boolean isSportsPerson() {
        return isSportsPerson;
    }

    public void setSportsPerson(boolean sportsPerson) {
        isSportsPerson = sportsPerson;
    }

    public boolean isEarthQuakeAffected() {
        return isEarthQuakeAffected;
    }

    public void setEarthQuakeAffected(boolean earthQuakeAffected) {
        isEarthQuakeAffected = earthQuakeAffected;
    }

    public boolean isProjectAffected() {
        return isProjectAffected;
    }

    public void setProjectAffected(boolean projectAffected) {
        isProjectAffected = projectAffected;
    }

    public boolean isPartTimeEmployee() {
        return isPartTimeEmployee;
    }

    public void setPartTimeEmployee(boolean partTimeEmployee) {
        isPartTimeEmployee = partTimeEmployee;
    }

    public boolean isExServiceMan() {
        return isExServiceMan;
    }

    public void setExServiceMan(boolean exServiceMan) {
        isExServiceMan = exServiceMan;
    }

    public boolean isStEmployee() {
        return isStEmployee;
    }

    public void setStEmployee(boolean stEmployee) {
        isStEmployee = stEmployee;
    }

    public int getExServiceManExpYears() {
        return exServiceManExpYears;
    }

    public void setExServiceManExpYears(int exServiceManExpYears) {
        this.exServiceManExpYears = exServiceManExpYears;
    }

    public int getExServiceManExpMonths() {
        return exServiceManExpMonths;
    }

    public void setExServiceManExpMonths(int exServiceManExpMonths) {
        this.exServiceManExpMonths = exServiceManExpMonths;
    }
    
    public boolean isNonCreamyLayer() {
		return nonCreamyLayer;
	}

	public void setNonCreamyLayer(boolean nonCreamyLayer) {
		this.nonCreamyLayer = nonCreamyLayer;
	}

	public boolean isDeafAndMute() {
		return isDeafAndMute;
	}

	public void setDeafAndMute(boolean isDeafAndMute) {
		this.isDeafAndMute = isDeafAndMute;
	}

	public boolean isIslocomotorOrCerebralPalsy() {
		return islocomotorOrCerebralPalsy;
	}

	public void setIslocomotorOrCerebralPalsy(boolean islocomotorOrCerebralPalsy) {
		this.islocomotorOrCerebralPalsy = islocomotorOrCerebralPalsy;
	}

	public boolean isBelongToEws() {
		return isBelongToEws;
	}

	public void setBelongToEws(boolean isBelongToEws) {
		this.isBelongToEws = isBelongToEws;
	}
	
	
}
