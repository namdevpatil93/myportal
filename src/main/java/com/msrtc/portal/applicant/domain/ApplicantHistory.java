package com.msrtc.portal.applicant.domain;

 import com.msrtc.portal.core.role.domain.Role;
 import org.springframework.data.annotation.CreatedDate;
 import org.springframework.data.annotation.LastModifiedDate;

 import javax.persistence.*;
 import java.io.Serializable;
 import java.time.LocalDate;
 import java.time.LocalDateTime;

 @Entity
 @Table(name = "Applicant_History")
 public class ApplicantHistory implements Serializable {

     private static final long serialVersionUID = -8491306515995040121L;

     @Id
     @Column(name = "id", nullable = false)
     @GeneratedValue(strategy = GenerationType.AUTO)
     private Long id;

     @Column(name = "application_id")
     private String applicationId;

// 	@NotNull
     @Column(name = "first_name")
// 	@Size(min = 1,  message = "First name is required")
     private String firstName;

// 	@NotNull
     @Column(name = "first_name_marathi")
// 	@Size(min = 1, message = "First name in Marathi is required")
 	private String firstNameMarathi;

// 	@NotNull
 	@Column(name = "middle_name")
// 	@Size(min = 1,  message = "Middle name is required")
     private String middleName;

// 	@NotNull
// 	@Size(min = 1,  message = "Middle name in Marathi is required")
//     @Column(name = "middle_name_marathi")
     private String middleNameMarathi;

// 	@NotNull
     @Column(name = "last_name")
// 	@Size(min = 1,  message = "Last name is required")
     private String lastName;

// 	@NotNull
     @Column(name = "last_name_marathi")
// 	@Size(min = 1,  message = "Last name in Marathi is required")
     private String lastNameMarathi;

// 	@NotNull
     @Column(name = "birth_date")
     private LocalDate birthDate;

// 	@NotNull
     @Column(name = "gender")
     private Integer gender = 1;

// 	@NotNull
     @Column(name = "address")
// 	@Size(min = 1,  message = "Address is required")
 	private String address;

// 	@NotNull
// 	@Size(min = 6, max = 6, message = "Pin code should be 6 digits long.")
     @Column(name = "pin_code")
     private String pinCode;

// 	@NotNull
     @Column(name = "email_address", unique = true)
     private String emailAddress;

// 	@NotNull
// 	@Size(min = 10, max = 10 , message = "Mobile number should be 10 digits long.")
     @Column(name = "mobile_number")
     private String mobileNumber;

     @Column(name = "marital_status")
     private Integer maritalStatus;

     @Column(name = "maharashtra_domiciled")
     private Boolean maharashtraDomiciled;

     @Column(name = "read_write_speak_marathi")
     private Boolean readWriteSpeakMarathi;
     
     @Column(name = "child_of_farmer_who_committed_suicide")
     private Boolean childOfFarmerWhoCommittedSuicide;
     
     @Column(name="highest_qualification")
     private Long highestQualification;
     
     @Column(name="drought_Affected")
     private Boolean droughtAffected;
     
     @ManyToOne
     private Caste caste;

     @Column(name = "password")
     private String password;

     @Transient
     private String newPassword;

     @Transient
     private String plainPassword;

     @ManyToOne
     private Role role;

     @Column(name = "first_login")
     private Boolean firstLogin = true;

     @Column(name = "non_creamy_layer")
     private Boolean nonCreamyLayer;

     @Column(name = "certificate_validity_ending_Date")
     private LocalDate certificateValidityEndingDate;

     @CreatedDate
     @Column(name = "created_date", nullable = false)
     private LocalDateTime createdDate = LocalDateTime.now();

     @LastModifiedDate
     @Column(name = "last_modified_date", nullable = false)
     private LocalDateTime lastModifiedDate = LocalDateTime.now();
     
     @Transient
     private int applicantAgeInYears;
     
     @Transient
     private int applicantAgeInMonths;

 	@Transient
 	private int applicantAgeInDays;

     @Column(name ="status")
     private int status;
     
     @Column(name ="subcategory")
     private String subcategory;
     
     @Column(name ="district_id")
     private Long districtId;

     @Column(name="mobile_no_verified")
     private Boolean mobileNoVerified;
     
     @Transient
     private LocalDate newDate;
     
     @Transient
     private String  groupName;
     
     @Column(name="certificate_number")
     private String certificateNumber;
     
     @Column(name="allocated_category")
     private Integer allocatedCategory;
     
 	public String getGroupName() {
 		return groupName;
 	}

 	public void setGroupName(String groupName) {
 		this.groupName = groupName;
 	}

 	public Long getId() {
 		return id;
 	}

 	public void setId(Long id) {
 		this.id = id;
 	}

 	public String getApplicationId() {
 		return applicationId;
 	}

 	public void setApplicationId(String applicationId) {
 		this.applicationId = applicationId;
 	}

 	public String getFirstName() {
 		return firstName;
 	}

 	public void setFirstName(String firstName) {
 		this.firstName = firstName;
 	}
 	
 	public String getFirstNameMarathi() {
 		return firstNameMarathi;
 	}

 	public void setFirstNameMarathi(String firstNameMarathi) {
 		this.firstNameMarathi = firstNameMarathi;
 	}

 	public String getMiddleName() {
 		return middleName;
 	}

 	public void setMiddleName(String middleName) {
 		this.middleName = middleName;
 	}

 	public String getMiddleNameMarathi() {
 		return middleNameMarathi;
 	}

 	public void setMiddleNameMarathi(String middleNameMarathi) {
 		this.middleNameMarathi = middleNameMarathi;
 	}

 	public String getLastName() {
 		return lastName;
 	}

 	public void setLastName(String lastName) {
 		this.lastName = lastName;
 	}

 	public String getLastNameMarathi() {
 		return lastNameMarathi;
 	}

 	public void setLastNameMarathi(String lastNameMarathi) {
 		this.lastNameMarathi = lastNameMarathi;
 	}

 	public LocalDate getBirthDate() {
 		return birthDate;
 	}

 	public void setBirthDate(LocalDate birthDate) {
 		this.birthDate = birthDate;
 	}

 	public Integer getGender() {
 		return gender;
 	}

 	public void setGender(Integer gender) {
 		this.gender = gender;
 	}

 	public String getAddress() {
 		return address;
 	}

 	public void setAddress(String address) {
 		this.address = address;
 	}

 	public String getPinCode() {
 		return pinCode;
 	}

 	public void setPinCode(String pinCode) {
 		this.pinCode = pinCode;
 	}

 	public String getEmailAddress() {
 		return emailAddress;
 	}

 	public void setEmailAddress(String emailAddress) {
 		this.emailAddress = emailAddress;
 	}

 	public String getMobileNumber() {
 		return mobileNumber;
 	}

 	public void setMobileNumber(String mobileNumber) {
 		this.mobileNumber = mobileNumber;
 	}

 	public Integer getMaritalStatus() {
 		return maritalStatus;
 	}

 	public void setMaritalStatus(Integer maritalStatus) {
 		this.maritalStatus = maritalStatus;
 	}

 	public Boolean getMaharashtraDomiciled() {
 		return maharashtraDomiciled;
 	}

 	public void setMaharashtraDomiciled(Boolean maharashtraDomiciled) {
 		this.maharashtraDomiciled = maharashtraDomiciled;
 	}

 	public Boolean getReadWriteSpeakMarathi() {
 		return readWriteSpeakMarathi;
 	}

 	public void setReadWriteSpeakMarathi(Boolean readWriteSpeakMarathi) {
 		this.readWriteSpeakMarathi = readWriteSpeakMarathi;
 	}

 	
 	

 	public Boolean getChildOfFarmerWhoCommittedSuicide() {
 		return childOfFarmerWhoCommittedSuicide;
 	}

 	public void setChildOfFarmerWhoCommittedSuicide(
 			Boolean childOfFarmerWhoCommittedSuicide) {
 		this.childOfFarmerWhoCommittedSuicide = childOfFarmerWhoCommittedSuicide;
 	}

 	public Caste getCaste() {
 		return caste;
 	}

 	public void setCaste(Caste caste) {
 		this.caste = caste;
 	}

 	public String getPassword() {
 		return password;
 	}

 	public void setPassword(String password) {
 		this.password = password;
 	}

 	public String getNewPassword() {
 		return newPassword;
 	}

 	public void setNewPassword(String newPassword) {
 		this.newPassword = newPassword;
 	}

 	public String getPlainPassword() {
 		return plainPassword;
 	}

 	public void setPlainPassword(String plainPassword) {
 		this.plainPassword = plainPassword;
 	}

 	public Role getRole() {
 		return role;
 	}

 	public void setRole(Role role) {
 		this.role = role;
 	}

 	public Boolean getFirstLogin() {
 		return firstLogin;
 	}

 	public void setFirstLogin(Boolean firstLogin) {
 		this.firstLogin = firstLogin;
 	}

 	public Boolean getNonCreamyLayer() {
 		return nonCreamyLayer;
 	}

 	public void setNonCreamyLayer(Boolean nonCreamyLayer) {
 		this.nonCreamyLayer = nonCreamyLayer;
 	}

 	public LocalDate getCertificateValidityEndingDate() {
 		return certificateValidityEndingDate;
 	}

 	public void setCertificateValidityEndingDate(
 			LocalDate certificateValidityEndingDate) {
 		this.certificateValidityEndingDate = certificateValidityEndingDate;
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

 	public int getApplicantAgeInYears() {
 		return applicantAgeInYears;
 	}

 	public void setApplicantAgeInYears(int applicantAgeInYears) {
 		this.applicantAgeInYears = applicantAgeInYears;
 	}

 	public int getApplicantAgeInMonths() {
 		return applicantAgeInMonths;
 	}

 	public void setApplicantAgeInMonths(int applicantAgeInMonths) {
 		this.applicantAgeInMonths = applicantAgeInMonths;
 	}

 	public int getStatus() {
 		return status;
 	}

 	public void setStatus(int status) {
 		this.status = status;
 	}

 	public String getSubcategory() {
 		return subcategory;
 	}

 	public void setSubcategory(String subcategory) {
 		this.subcategory = subcategory;
 	}

 	public Long getDistrictId() {
 		return districtId;
 	}

 	public void setDistrictId(Long districtId) {
 		this.districtId = districtId;
 	}

 	public Boolean getMobileNoVerified() {
 		return mobileNoVerified;
 	}

 	public void setMobileNoVerified(Boolean mobileNoVerified) {
 		this.mobileNoVerified = mobileNoVerified;
 	}

 	public LocalDate getNewDate() {
 		return newDate;
 	}

 	public void setNewDate(LocalDate newDate) {
 		this.newDate = newDate;
 	}

 	public int getApplicantAgeInDays() {
 		return applicantAgeInDays;
 	}

 	public void setApplicantAgeInDays(int applicantAgeInDays) {
 		this.applicantAgeInDays = applicantAgeInDays;
 	}

 	public Long getHighestQualification() {
 		return highestQualification;
 	}

 	public void setHighestQualification(Long highestQualification) {
 		this.highestQualification = highestQualification;
 	}

 	public String getCertificateNumber() {
 		return certificateNumber;
 	}

 	public void setCertificateNumber(String certificateNumber) {
 		this.certificateNumber = certificateNumber;
 	}

 	public Integer getAllocatedCategory() {
 		return allocatedCategory;
 	}

 	public void setAllocatedCategory(Integer allocatedCategory) {
 		this.allocatedCategory = allocatedCategory;
 	}

 	public Boolean getDroughtAffected() {
 		return droughtAffected;
 	}

 	public void setDroughtAffected(Boolean droughtAffected) {
 		this.droughtAffected = droughtAffected;
 	}
 	
 	@Column(name="is_belong_to_ews")
 	private Boolean isBelongToEws;

 	public Boolean getIsBelongToEws() {
 		return isBelongToEws;
 	}

 	public void setIsBelongToEws(Boolean isBelongToEws) {
 		this.isBelongToEws = isBelongToEws;
 	}

 	@Column(name="ews_certificate_number")
     private String ewsCertificateNumber;

 	public String getEwsCertificateNumber() {
 		return ewsCertificateNumber;
 	}

 	public void setEwsCertificateNumber(String ewsCertificateNumber) {
 		this.ewsCertificateNumber = ewsCertificateNumber;
 	}
 	
 	
 }

