<%@ include file="../../../common/taglibs.jsp"%>

<script>
    jQuery(document).ready(function() {
    	var lastDateOver = commonObj.isValidate(${applicantPostAssoc.disableForm});
	    commonObj.disableFormFields("accountingOfficerForm",lastDateOver);
    	postGraduationDetails();
    	companyNameToggel();
    	postSelectionObj.bindPostForm('accountingOfficerForm');
    	
    	postSelectionObj.validateDate('accountingOfficerExperienceFrom','accountingOfficerExperienceTo');
    	
    	$('#accountingOfficerExperienceFrom').datetimepicker({
            format: 'DD/MM/YYYY',
            ignoreReadonly: true,
            showTodayButton: true,
            minDate: postSelectionObj.minDate(),
            maxDate: postSelectionObj.maxDate()
            //date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseIssueDate}" />'
        });
    	
    	$('#accountingOfficerExperienceCalendarIconStartDate').click(function() {
            $('#accountingOfficerExperienceFrom').data("DateTimePicker").show();
        });
    	
    	$('#accountingOfficerExperienceTo').datetimepicker({
            format: 'DD/MM/YYYY',
            ignoreReadonly: true,
            showTodayButton: true,
            minDate: postSelectionObj.minDate(),
            maxDate: postSelectionObj.maxDate()
           // date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseEndDate}" />'
        });
    	
    	$('#accountingOfficerExperienceCalendarIconEndDate').click(function() {
            $('#accountingOfficerExperienceTo').data("DateTimePicker").show();
        });
    	
    	var startDate = '${applicantPostAssoc.organisationTimeFrom}';
		if(startDate != 'undefined' || startDate != null || startDate !='' )
			$('#accountingOfficerExperienceFrom').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicantPostAssoc.organisationTimeFrom}" />');
		
	   var Enddate = '${applicantPostAssoc.organisationTimeTo}';
		if(Enddate != 'undefined' || Enddate != null || Enddate !='' )
			$('#accountingOfficerExperienceTo').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicantPostAssoc.organisationTimeTo}" />');
    	
    });
    
    
    function postGraduationDetails(){
    	var check= $('#accountingOfficerForm').find('input[name=graduateFromAffiliatedInstitute]:checked').val();
    	if(check == 1){
    		$('.accountingOfficer-postgraddegreeDiv').show();
    		
    		
    	}else if(check == 0){
    		$('.accountingOfficer-postgraddegreeDiv').hide();
    		
    		postSelectionObj.bindPostForm('accountingOfficerForm');
    	}else{
    		$('.accountingOfficer-postgraddegreeDiv').hide();
    		
    	}
    }
    
    function companyNameToggel(){
    	var isExp = $('#accountingOfficerForm').find('input[name=experienced]:checked').val();
    	
    	if(isExp == 1){
    		$('.accountingOfficerExperiencedToggle').show();
    		$('.accountingOfficerExperienceFromToggel').show();
    		$('.accountingOfficerExperienceToToggel').show();
    		$('.accountingOfficerCompanyAddressToggle').show()
    	}else if(isExp == 0){
    		$('.accountingOfficerExperiencedToggle').hide();
    		$('.accountingOfficerExperienceFromToggel').hide();
    		$('.accountingOfficerExperienceToToggel').hide();
    		$('.accountingOfficerCompanyAddressToggle').hide();
    		postSelectionObj.bindPostForm('accountingOfficerForm');
    	}else{
    		$('.accountingOfficerExperiencedToggle').hide();
    		$('.accountingOfficerExperienceFromToggel').hide();
    		$('.accountingOfficerExperienceToToggel').hide();
    		$('.accountingOfficerCompanyAddressToggle').hide();
    	}
    }
    
$( 'form#accountingOfficerForm' ).find('input[type=radio][name=mscitOrGaccc]').unbind().change(function() {
    	
    	if(this.value == '0'){
    		 commonObj.showAgreeDisAgreePopup("<fmt:message key='mscit.equivalent.computer.certificate.alert' />", mscitCertificatePopUpAccountingOfficer, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
    	     
    	}
    });
    
    function mscitCertificatePopUpAccountingOfficer(flag)
    {
    	if(!flag)
    	{
    		$('#accountingOfficer-skComputerCourseCertification-yes').prop('checked', true);
      	}
    }
    
</script>

<div id="downloadEligibilityCriteria" class="form-group" align="right">
    <div class="col-sm-12" align="pull-right">
        <a href="javascript:void(0);" onclick="javascript:showEligibilityCriteriaPDF(${post.postId})"><b><fmt:message key="postEligibilityCriteriaLink"/></b></a>
    </div>
</div>

<form class="form-horizontal" name="accountingOfficerForm"
      id="accountingOfficerForm"
      action="<c:url value='/applicant?operation=saveApplicantPostDetails'/>" method="POST">

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${applicantPostAssoc.id}"/>
    <input type="hidden" name="postId" value="${post.postId}"/>
    <input type="hidden" name="status" id="status"  value="${ applicantPostAssoc.status }"/>

	
<div class="form-group">
        <label class="control-label col-sm-5" for="graduateFromAffiliatedInstitute"><fmt:message key="accounting.audit.officer.postgraduate.degree"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="graduateFromAffiliatedInstitute" onclick="javascript:postGraduationDetails()" id="graduateFromAffiliatedInstitute-yes" value="1" type="radio" ${applicantPostAssoc.graduateFromAffiliatedInstitute ? 'checked' : ''} />
                <label for="graduateFromAffiliatedInstitute-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="graduateFromAffiliatedInstitute" onclick="javascript:postGraduationDetails()" id="graduateFromAffiliatedInstitute-no" value="0" type="radio" ${applicantPostAssoc.graduateFromAffiliatedInstitute == false  ? 'checked' : ''} />
                <label for="graduateFromAffiliatedInstitute-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>

	<div class="accountingOfficer-postgraddegreeDiv" id="accountingOfficer-postgraddegreeDiv" hidden>
    	<%-- <div class="form-group postgraddegree">
        <label class="control-label col-sm-5" for="accountingOfficer-degreeName"><fmt:message key="applicant.degreeName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.degreeName}" type="text" class="form-control" id="accountingOfficer-degreeName" placeholder="<fmt:message key="applicant.degreeName"/>" name="degreeName" maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
    	</div> --%>
    
    	<div class="form-group postgradinstituteName">
        <label class="control-label col-sm-5" for="accountingOfficer-instituteName"><fmt:message key="accounting.audit.officer.degree.university"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
          <input value="${applicantPostAssoc.instituteName}" type="text" class="form-control" id="accountingOfficer-instituteName" placeholder="<fmt:message key="applicant.universityName"/>" name="instituteName" maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
    	</div>
    	
    	<div class="form-group accountingOfficerRequiredQualificationMarks">
        <label class="control-label col-sm-5" for="accountingOfficerQualificationMarks"><fmt:message key="driverCumConductor.required.qualification.marks.obtained"/> %: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.requiredQualificationMarks}"  type="number" class="form-control" id="accountingOfficerQualificationMarks" placeholder="<fmt:message key="driverCumConductor.required.qualification.marks.obtained"/>" name="requiredQualificationMarks" maxlength="5" min="1" max="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    
    	
    	<div class="form-group postgraddegree">
        <label class="control-label col-sm-5" for="€accountingOfficer-postGraduateDegreeName"><fmt:message key="post.graduate.degree.name"/> : <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.postGraduateDegreeName}" type="text" class="form-control" id="accountingOfficer-postGraduateDegreeName" placeholder="<fmt:message key="post.graduate.degree.name"/>" name="postGraduateDegreeName" maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
    	</div>
    
    	<div class="form-group postgradinstituteName">
        <label class="control-label col-sm-5" for="accountingOfficer-postGradDegreeInstituteName"><fmt:message key="applicant.universityName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.postGradDegreeInstituteName}" type="text" class="form-control" id="accountingOfficer-postGradDegreeInstituteName" placeholder="<fmt:message key="postgraddegree.instituteName"/>" name="postGradDegreeInstituteName" maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
    	</div>
    	<div class="form-group accountingOfficerRequiredMarks">
        <label class="control-label col-sm-5" for="accountingOfficerMarks"><fmt:message key="driverCumConductor.required.qualification.marks.obtained"/> %: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.postGraduateMarks}"  oninput="javascript:toggleGraduationMarks(this.value);" type="number" class="form-control" id="accountingOfficerMarks" placeholder="<fmt:message key="driverCumConductor.required.qualification.marks.obtained"/>" name="postGraduateMarks" maxlength="5" min="1" max="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
   </div>
   
   <div class="form-group">
        <label class="control-label col-sm-5" for="examinationSupervisorExperienced"><fmt:message key="audit.examination.supervisor.in.government"/>:<span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="experienced" id="accountingOfficer-experienced-yes" onclick="javascript:companyNameToggel()" value="1" type="radio" ${applicantPostAssoc.experienced ? 'checked' : ''} />
                <label for="accountingOfficer-experienced-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="experienced" onclick="javascript:companyNameToggel()" id="accountingOfficer-experienced-no" value="0" type="radio" ${applicantPostAssoc.experienced == false ? 'checked' : ''} />
                <label for="accountingOfficer-experienced-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group accountingOfficerExperiencedToggle" hidden>
        <label class="control-label col-sm-5" for="accountingOfficer-companyName"><fmt:message key="divisionController.organizationName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.companyName}" type="text" class="form-control" id="accountingOfficer-companyName" placeholder="<fmt:message key="divisionController.organizationName"/>" name="companyName" maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group accountingOfficerCompanyAddressToggle" hidden>
        <label class="control-label col-sm-5" for="accountingOfficer-company-address"><fmt:message key="accounting.audit.officer.company.address"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.companyAddress}" type="text" class="form-control" id="accountingOfficer-company-address" placeholder="<fmt:message key="accounting.audit.officer.company.address"/>" name="companyAddress" maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
    </div>

	<div class="form-group accountingOfficerExperienceFromToggel" hidden>
        <label class="control-label col-sm-5" for="accountingOfficerExperienceFrom"><fmt:message key="accounting.audit.officer.company.start.date"/>: <span class="red">*</span></label>
        <div class="col-sm-3">
        	<div class="input-group date">
	            <input type="datetime" class="form-control" id="accountingOfficerExperienceFrom" placeholder="<fmt:message key="accounting.audit.officer.company.start.date"/>" name="organisationTimeFrom" readonly>
	            <div class="input-group-addon" id="accountingOfficerExperienceCalendarIconStartDate">
					<i class="fa fa-calendar"></i>
				</div>
	            <div class="help-block with-errors"></div>
            </div>
        </div>
   </div>
   
    <div class="form-group accountingOfficerExperienceToToggel" hidden>
        <label class="control-label col-sm-5" for="accountingOfficerExperienceTo"><fmt:message key="accounting.audit.officer.company.end.date"/>: <span class="red">*</span></label>
        <div class="col-sm-3">
        	<div class="input-group date">
	            <input type="datetime" class="form-control" id="accountingOfficerExperienceTo" placeholder="<fmt:message key="accounting.audit.officer.company.end.date"/>" name="organisationTimeTo" readonly >
	            <div class="input-group-addon" id="accountingOfficerExperienceCalendarIconEndDate">
					<i class="fa fa-calendar"></i>
				</div>
	            <div class="help-block with-errors"></div>
            </div>
        </div>
    </div>

	 <div class="form-group">
       <label class="control-label col-sm-5" for="accountingOfficercomputerCourseCertification"><fmt:message key="machine.engineer.isMscIt"/>: <span class="red">*</span></label>
       <div class="col-sm-4">
           <div class="radio radio-inline" >
               <input type="radio" name="mscitOrGaccc" value="1" class="form-control" id="accountingOfficer-skComputerCourseCertification-yes" ${ applicantPostAssoc.mscitOrGaccc ? 'checked="checked"':''}  />
               <label for="accountingOfficer-skComputerCourseCertification-yes"> <fmt:message key="yes"/> </label>
           </div>
           <div class="radio radio-inline" >
              <input type="radio" name="mscitOrGaccc" value="0" class="form-control" id="accountingOfficer-skComputerCourseCertification-no" ${ applicantPostAssoc.mscitOrGaccc == false ? 'checked="checked"':''}>
               <label for="accountingOfficer-skComputerCourseCertification-no"> <fmt:message key="no"/> </label>
           </div>
           <div class="help-block with-errors"></div>
       </div>
   </div>

    <jsp:include page="../postFooter.jsp">
        <jsp:param name="isPostSubmitted" value="${ applicantPostAssoc.status eq 2 || applicantPostAssoc.status eq 3 }"/>
        <jsp:param name="formId" value="accountingOfficerForm"/>
        <jsp:param name="postId" value="${post.postId}"/>
        <jsp:param name="disableFormAfterLastDateOver" value="${disableFormAfterLastDateOver}"/>
    </jsp:include>

</form>

<script>
    $(document).ready(function(){

    	
    	 $("form[name='accountingOfficerForm']").validate({
 		 	rules:{
 		 		
 		 		graduateFromAffiliatedInstitute: "required",
 		 		degreeName : "required",
 		 		instituteName : "required",
 		 		requiredQualificationMarks : {required: true, min: 35},
 		 		experienced : "required",
 		 		companyName : "required",
 		 		postGraduateMarks: {required: true, min: 35},
 		 		postGradDegreeInstituteName : "required",
 		 		postGraduateDegreeName : "required",
 		 		mscitOrGaccc: "required",
 		 		organisationTimeTo : "required",
 		 		organisationTimeFrom : "required",
 		 		companyAddress : "required"
 		 		
 		 		
 		 		
 		 	},
 	 messages:{
			 /*totalExperienceInYears : {min : "<fmt:message key="validation.minlengthfield"/>"},*/
			 totalExperienceInMonths : {max : "<fmt:message key="number.eleven" var="key" /><fmt:message key="validate.maxMonths"><fmt:param value="${key}" /></fmt:message>"},
			 guarantorPersonMobileNumber : {minlength : "<fmt:message key="number.ten" var="key" /><fmt:message key="validate.minlength"><fmt:param value="${key}" /></fmt:message>"}
		  },
	     errorPlacement: function (error, element) {
		    	if ( element.is(":radio") ) 
	            {
					error.appendTo(element.parent().parent().children('.help-block.with-errors'));
	            }
	            else if( element.is("input[type=datetime]"))
		        {
			        error.insertAfter(element.parent());
		        }	            
		    	else
		    	{
		    		error.insertAfter( element );
		    	}
	    	}
 	 });
    	
    	
    });
</script>