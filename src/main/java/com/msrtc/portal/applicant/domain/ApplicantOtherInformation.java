package com.msrtc.portal.applicant.domain;

import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;

import javax.persistence.*;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "applicant_other_information")
public class ApplicantOtherInformation implements Serializable{

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = -6713884227982538309L;
	
	@Id
	@Column(name = "id", nullable = false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Long id;
	
	@OneToOne
	@JoinColumn(name="applicant_id")
	private Applicant applicant;
	
	@Column(name = "ex_service_man")
    private Boolean exServiceMan;
	
	@Column(name = "project_effected")
    private Boolean projectEffected;
	
	@Column(name = "earth_quake_effected")
    private Boolean earthQuakeEffected;
	
	@Column(name = "retirement_date")
    private LocalDate retirementDate;
	
	@Column(name = "part_time_employee")
    private Boolean partTimeEmployee;

    @Column(name = "st_employee")
    private Boolean stEmployee;

    @Column(name = "sports_person")
    private Boolean sportsPerson;

    @Column(name = "sports_level")
    private String sportsLevel;
    
    @CreatedDate
    @Column(name = "created_date", nullable = false)
    private LocalDateTime createdDate = LocalDateTime.now();

    @LastModifiedDate
    @Column(name = "last_modified_date", nullable = false)
    private LocalDateTime lastModifiedDate = LocalDateTime.now();;

    @Column(name ="status")
    private int status;

    @Column(name="exserviceman_total_experience_in_years")
    private String exServicemanTotalExperienceInYears;
    
    @Column(name="exserviceman_total_experience_in_months")
    private String exServicemanTotalExperienceInMonths;
    
    @Column(name="parttimeemployee_total_experience_in_years")
    private String partTimeEmployeeTotalExperienceInYears;
    
    @Column(name="parttimeemployee_total_experience_in_months")
    private String partTimeEmployeeTotalExperienceInMonths;
    
    @Column(name="city_id_first_preference")
	private Long preferredCity1;
    
    @Column(name="city_id_second_preference")
	private Long preferredCity2;
    
    @Column(name="city_id_third_preference")
	private Long preferredCity3;
	
	@Transient
	private List<City> cityList;
	
	@Column(name="orphaned_person")
	private Boolean orphanedPerson;
	
	@Column(name="locomotor_or_cerebralpalsy")
	private Boolean locomotorOrCerebralPalsy;
	
	@Column(name="deaf_and_mute")
	private Boolean deafAndMute;
	
    public Boolean getOrphanedPerson() {
		return orphanedPerson;
	}

    public void setOrphanedPerson(Boolean orphanedPerson) {
		this.orphanedPerson = orphanedPerson;
	}

    public Long getId() {
		return id;
	}



	public void setId(Long id) {
		this.id = id;
	}



	public Applicant getApplicant() {
		return applicant;
	}



	public void setApplicant(Applicant applicant) {
		this.applicant = applicant;
	}



	public Boolean getExServiceMan() {
		return exServiceMan;
	}



	public void setExServiceMan(Boolean exServiceMan) {
		this.exServiceMan = exServiceMan;
	}



	public Boolean getProjectEffected() {
		return projectEffected;
	}



	public void setProjectEffected(Boolean projectEffected) {
		this.projectEffected = projectEffected;
	}



	public Boolean getEarthQuakeEffected() {
		return earthQuakeEffected;
	}



	public void setEarthQuakeEffected(Boolean earthQuakeEffected) {
		this.earthQuakeEffected = earthQuakeEffected;
	}



	public LocalDate getRetirementDate() {
		return retirementDate;
	}



	public void setRetirementDate(LocalDate retirementDate) {
		this.retirementDate = retirementDate;
	}



	public Boolean getPartTimeEmployee() {
		return partTimeEmployee;
	}



	public void setPartTimeEmployee(Boolean partTimeEmployee) {
		this.partTimeEmployee = partTimeEmployee;
	}



	public Boolean getStEmployee() {
		return stEmployee;
	}



	public void setStEmployee(Boolean stEmployee) {
		this.stEmployee = stEmployee;
	}



	public Boolean getSportsPerson() {
		return sportsPerson;
	}



	public void setSportsPerson(Boolean sportsPerson) {
		this.sportsPerson = sportsPerson;
	}



	public String getSportsLevel() {
		return sportsLevel;
	}



	public void setSportsLevel(String sportsLevel) {
		this.sportsLevel = sportsLevel;
	}



	public LocalDateTime getCreatedDate() {
		return createdDate;
	}



	public void setCreatedDate(LocalDateTime createdDate) {
		this.createdDate = createdDate;
	}



	public LocalDateTime getLastModifiedDate() {
		return lastModifiedDate;
	}



	public void setLastModifiedDate(LocalDateTime lastModifiedDate) {
		this.lastModifiedDate = lastModifiedDate;
	}



	public int getStatus() {
		return status;
	}



	public void setStatus(int status) {
		this.status = status;
	}

	public String getExServicemanTotalExperienceInYears() {
		return exServicemanTotalExperienceInYears;
	}

	public void setExServicemanTotalExperienceInYears(
			String exServicemanTotalExperienceInYears) {
		this.exServicemanTotalExperienceInYears = exServicemanTotalExperienceInYears;
	}

	public String getExServicemanTotalExperienceInMonths() {
		return exServicemanTotalExperienceInMonths;
	}

	public void setExServicemanTotalExperienceInMonths(
			String exServicemanTotalExperienceInMonths) {
		this.exServicemanTotalExperienceInMonths = exServicemanTotalExperienceInMonths;
	}
	
	public String getPartTimeEmployeeTotalExperienceInYears() {
		return partTimeEmployeeTotalExperienceInYears;
	}



	public void setPartTimeEmployeeTotalExperienceInYears(
			String partTimeEmployeeTotalExperienceInYears) {
		this.partTimeEmployeeTotalExperienceInYears = partTimeEmployeeTotalExperienceInYears;
	}



	public String getPartTimeEmployeeTotalExperienceInMonths() {
		return partTimeEmployeeTotalExperienceInMonths;
	}



	public void setPartTimeEmployeeTotalExperienceInMonths(
			String partTimeEmployeeTotalExperienceInMonths) {
		this.partTimeEmployeeTotalExperienceInMonths = partTimeEmployeeTotalExperienceInMonths;
	}

	public Long getPreferredCity1() {
		return preferredCity1;
	}

	public void setPreferredCity1(Long preferredCity1) {
		this.preferredCity1 = preferredCity1;
	}

	public Long getPreferredCity2() {
		return preferredCity2;
	}

	public void setPreferredCity2(Long preferredCity2) {
		this.preferredCity2 = preferredCity2;
	}

	public Long getPreferredCity3() {
		return preferredCity3;
	}

	public void setPreferredCity3(Long preferredCity3) {
		this.preferredCity3 = preferredCity3;
	}

	public List<City> getCityList() {
		return cityList;
	}

	public void setCityList(List<City> cityList) {
		this.cityList = cityList;
	}


	public Boolean getLocomotorOrCerebralPalsy() {
		return locomotorOrCerebralPalsy;
	}

	public void setLocomotorOrCerebralPalsy(Boolean locomotorOrCerebralPalsy) {
		this.locomotorOrCerebralPalsy = locomotorOrCerebralPalsy;
	}

	public Boolean getDeafAndMute() {
		return deafAndMute;
	}

	public void setDeafAndMute(Boolean deafAndMute) {
		this.deafAndMute = deafAndMute;
	}

	@Override
    public String toString() {
    	final StringBuilder sb = new StringBuilder("ApplicantOtherInformation{");
    	sb.append("id='").append(getId()).append('\'');
    	sb.append(", applicantId='").append(applicant.getId()).append('\'');
        sb.append(", partTimeEmployee='").append(partTimeEmployee).append('\'');
        sb.append(", exServiceMan='").append(exServiceMan).append('\'');
        sb.append(", retirementDate='").append(retirementDate).append('\'');
        sb.append(", stEmployee='").append(stEmployee).append('\'');
        sb.append(", sportsPerson='").append(sportsPerson).append('\'');
        sb.append(", sportsLevel='").append(sportsLevel).append('\'');
        sb.append(", projectEffected='").append(projectEffected).append('\'');
        sb.append(", earthQuakeEffected='").append(earthQuakeEffected).append('\'');
        sb.append(", exServicemanTotalExperienceInYears='").append(exServicemanTotalExperienceInYears).append('\'');
        sb.append(", exServicemanTotalExperienceInMonths='").append(exServicemanTotalExperienceInMonths).append('\'');
        sb.append(", partTimeEmployeeTotalExperienceInYears='").append(partTimeEmployeeTotalExperienceInYears).append('\'');
        sb.append(", partTimeEmployeeTotalExperienceInMonths='").append(partTimeEmployeeTotalExperienceInMonths).append('\'');
    	return sb.toString();
    }

}
