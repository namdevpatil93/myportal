package com.msrtc.portal.challan.domain;

import java.io.Serializable;
import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;

import com.msrtc.portal.core.domain.BaseExcelEntity;
import com.opencsv.bean.CsvBindByName;

@Entity
@Table(name = "challans")
public class Challan extends BaseExcelEntity implements Serializable {

    private static final long serialVersionUID = -8752536325171910446L;

    @Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Long id;

    @CsvBindByName(column = "JRNL-NO")
    @Column(name = "jrnl_no")
    private String jrnlNo;

    @CsvBindByName(column = "TRAN-MODE")
    @Column(name = "tran_mode")
    private String tranMode;

    @CsvBindByName(column = "FROM-ACCOUNT-SYS")
    @Column(name = "from_account_sys")
    private String fromAccountSys;

    @CsvBindByName(column = "FROM-ACCT-NO")
    @Column(name = "from_acct_no")
    private String fromAcctNo;

    @CsvBindByName(column = "FEE-TYPE")
    @Column(name = "fee_type")
    private String feeType;

    @CsvBindByName(column = "Reg/Ref No.")
    @Column(name = "application_no")
    private String applicationNo;

    @CsvBindByName(column = "DOB")
    @Column(name = "dob")
    private String dob;

    @CsvBindByName(column = "TRAN-DATE")
    @Column(name = "tran_date")
    private String tranDate;

    @CsvBindByName(column = "TRAN-BRANCH")
    @Column(name = "tran_branch")
    private String tranBranch;

    @CsvBindByName(column = "TRAN-TIME")
    @Column(name = "tran_time")
    private String tranTime;

    @CsvBindByName(column = "Account No.")
    @Column(name = "account_no")
    private String accountNo;

    @CsvBindByName(column = "AMOUNT")
    @Column(name = "amount")
    private String amount;

    @CsvBindByName(column = "APPLICANT NAME")
    @Column(name = "applicant_name")
    private String applicantName;

    @CsvBindByName(column = "POST APPLIED")
    @Column(name = "post_applied")
    private String postApplied;

    @CsvBindByName(column = "CATEGORY")
    @Column(name = "category")
    private String category;

    @CsvBindByName(column = "Last date for acceptance")
    @Column(name = "last_date_for_acceptance")
    private String lastDateForAcceptance;

    @CreatedBy
    @Column(name = "created_by", nullable = false)
    private Long createdBy;

    @CreatedDate
    @Column(name = "created_date", nullable = false)
    private LocalDateTime createdDate = LocalDateTime.now();

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getJrnlNo() {
        return jrnlNo;
    }

    public void setJrnlNo(String jrnlNo) {
        this.jrnlNo = jrnlNo;
    }

    public String getTranMode() {
        return tranMode;
    }

    public void setTranMode(String tranMode) {
        this.tranMode = tranMode;
    }

    public String getFromAccountSys() {
        return fromAccountSys;
    }

    public void setFromAccountSys(String fromAccountSys) {
        this.fromAccountSys = fromAccountSys;
    }

    public String getFromAcctNo() {
        return fromAcctNo;
    }

    public void setFromAcctNo(String fromAcctNo) {
        this.fromAcctNo = fromAcctNo;
    }

    public String getFeeType() {
        return feeType;
    }

    public void setFeeType(String feeType) {
        this.feeType = feeType;
    }

    public String getApplicationNo() {
        return applicationNo;
    }

    public void setApplicationNo(String applicationNo) {
        this.applicationNo = applicationNo;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getTranDate() {
        return tranDate;
    }

    public void setTranDate(String tranDate) {
        this.tranDate = tranDate;
    }

    public String getTranBranch() {
        return tranBranch;
    }

    public void setTranBranch(String tranBranch) {
        this.tranBranch = tranBranch;
    }

    public String getTranTime() {
        return tranTime;
    }

    public void setTranTime(String tranTime) {
        this.tranTime = tranTime;
    }

    public String getAccountNo() {
        return accountNo;
    }

    public void setAccountNo(String accountNo) {
        this.accountNo = accountNo;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getApplicantName() {
        return applicantName;
    }

    public void setApplicantName(String applicantName) {
        this.applicantName = applicantName;
    }

    public String getPostApplied() {
        return postApplied;
    }

    public void setPostApplied(String postApplied) {
        this.postApplied = postApplied;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getLastDateForAcceptance() {
        return lastDateForAcceptance;
    }

    public void setLastDateForAcceptance(String lastDateForAcceptance) {
        this.lastDateForAcceptance = lastDateForAcceptance;
    }

    public Long getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(Long createdBy) {
        this.createdBy = createdBy;
    }

    public LocalDateTime getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(LocalDateTime createdDate) {
        this.createdDate = createdDate;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("Challan{");
        sb.append("id=").append(id);
        sb.append(", jrnlNo='").append(jrnlNo).append('\'');
        sb.append(", tranMode='").append(tranMode).append('\'');
        sb.append(", fromAccountSys='").append(fromAccountSys).append('\'');
        sb.append(", fromAcctNo='").append(fromAcctNo).append('\'');
        sb.append(", feeType='").append(feeType).append('\'');
        sb.append(", applicationNo='").append(applicationNo).append('\'');
        sb.append(", dob='").append(dob).append('\'');
        sb.append(", tranDate='").append(tranDate).append('\'');
        sb.append(", tranBranch='").append(tranBranch).append('\'');
        sb.append(", tranTime='").append(tranTime).append('\'');
        sb.append(", accountNo='").append(accountNo).append('\'');
        sb.append(", amount=").append(amount);
        sb.append(", applicantName='").append(applicantName).append('\'');
        sb.append(", postApplied='").append(postApplied).append('\'');
        sb.append(", category='").append(category).append('\'');
        sb.append(", lastDateForAcceptance='").append(lastDateForAcceptance).append('\'');
        sb.append(", createdBy=").append(createdBy);
        sb.append(", createdDate=").append(createdDate);
        sb.append('}');
        return sb.toString();
    }
}
