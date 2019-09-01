<%@ include file="../../../common/taglibs.jsp"%>

<script>
    jQuery(document).ready(function() {
    	
    	
    	if('${ applicantPostAssoc.gradOrPostGrad}' == 1 )
  		{
  			postSelectionObj.showElementsByClass('machineEngineerPostGraduateDegreeNameToggle');
  			postSelectionObj.showElementsByClass('machineEngineerPostGraduateUniversityToggle');
  			postSelectionObj.showElementsByClass('machineEngineerPostGraduateMarksToggle');
  			postSelectionObj.showElementsByClass('machineEngineerDegreeNameToggle');
  			postSelectionObj.showElementsByClass('machineEngineerUniversityToggle');
  			postSelectionObj.showElementsByClass('machineEngineerMarksToggle');

  		}
  		else
  		{
  			postSelectionObj.hideElementsByClass('machineEngineerPostGraduateDegreeNameToggle');
  			postSelectionObj.hideElementsByClass('machineEngineerPostGraduateUniversityToggle');
  			postSelectionObj.hideElementsByClass('machineEngineerPostGraduateMarksToggle');
  			postSelectionObj.hideElementsByClass('machineEngineerDegreeNameToggle');
  			postSelectionObj.hideElementsByClass('machineEngineerUniversityToggle');
  			postSelectionObj.hideElementsByClass('machineEngineerMarksToggle');
  		} 
		
    	if('${applicantPostAssoc.mbaFromGovernmentAffiliatedInstitute}' == true || '${applicantPostAssoc.mbaFromGovernmentAffiliatedInstitute}' == "true")
		{
    		postSelectionObj.showElementsByClass('machineEngineerMbaMarksToggle');
			postSelectionObj.showElementsByClass('machineEngineerMbaUniversityToggle');
			postSelectionObj.showElementsByClass('machineEngineerMbaDegreeNameToggle');
		}
		else
		{    postSelectionObj.hideElementsByClass('machineEngineerMbaMarksToggle');
		    postSelectionObj.hideElementsByClass('machineEngineerMbaUniversityToggle');
		     postSelectionObj.hideElementsByClass('machineEngineerMbaDegreeNameToggle');
		}
    	
    	 /* if ('${applicantPostAssoc.mbaFromGovernmentAffiliatedInstitute}'=='' || '${applicantPostAssoc.mbaFromGovernmentAffiliatedInstitute}'=='false') {
			postSelectionObj.hideElementsByClass('machineEngineerMbaMarksToggle');
			postSelectionObj.hideElementsByClass('machineEngineerMbaUniversityToggle');
			postSelectionObj.hideElementsByClass('machineEngineerMbaDegreeNameToggle');
		}  */
    	
    	postSelectionObj.disableFormFields ("machineEngineerForm", '${applicantPostAssoc.status}');
 		postSelectionObj.bindPostForm("machineEngineerForm");
 		var lastDateOver = commonObj.isValidate(${applicantPostAssoc.disableForm});
 	    commonObj.disableFormFields("machineEngineerForm",lastDateOver);
    });
    
    $( 'form#machineEngineerForm' ).find('input[type=radio][name=gradOrPostGrad]').unbind().change(function() {
        if (this.value == '1') {
        	jQuery('#machineEngineerForm').validate().settings.ignore = "";
        	$(this).parent().parent().find(".help-block").html("");
         	$(this).parent().parent().parent().removeClass( 'has-error has-danger' );
         	$('#mbaFromGovernmentAffiliatedInstituteError').html("");
       	 	$('#mbaFromGovernmentAffiliatedInstituteError').parent().parent().removeClass( 'has-error has-danger' );
       	 postSelectionObj.showElementsByClass('machineEngineerPostGraduateDegreeNameToggle');
       	postSelectionObj.showElementsByClass('machineEngineerPostGraduateUniversityToggle');
       	postSelectionObj.showElementsByClass('machineEngineerPostGraduateMarksToggle');
       	postSelectionObj.showElementsByClass('machineEngineerDegreeNameToggle');
			postSelectionObj.showElementsByClass('machineEngineerUniversityToggle');
			postSelectionObj.showElementsByClass('machineEngineerMarksToggle');
        } else {
        	
        	 jQuery('#machineEngineerForm').validate().settings.ignore = "#machineEngineer-degreeName,#machineEngineer-universityName,#machineEngineerrequiredQualificationMarks,#machineEngineer-postGraduateDegreeName,#machineEngineer-postGradDegreeInstituteName,#machineEngineerPostGraduateMarks";
        	 	postSelectionObj.resetTextFieldById('machineEngineer-postGraduateDegreeName');
        	 	postSelectionObj.resetTextFieldById('machineEngineer-postGradDegreeInstituteName');
        	 	postSelectionObj.resetTextFieldById('machineEngineerPostGraduateMarks');
        	 	 postSelectionObj.resetTextFieldById('machineEngineer-degreeName');
         	 	postSelectionObj.resetTextFieldById('machineEngineer-universityName');
         	 	postSelectionObj.resetTextFieldById('machineEngineerrequiredQualificationMarks');
         	 	$('#machineEngineerPostGraduateMarks').val(0);
         	 	$('#machineEngineerrequiredQualificationMarks').val(0);
        	postSelectionObj.hideElementsByClass('machineEngineerPostGraduateDegreeNameToggle');
        	postSelectionObj.hideElementsByClass('machineEngineerPostGraduateUniversityToggle');
        	postSelectionObj.hideElementsByClass('machineEngineerPostGraduateMarksToggle');
        	postSelectionObj.hideElementsByClass('machineEngineerDegreeNameToggle');
  			postSelectionObj.hideElementsByClass('machineEngineerUniversityToggle');
  			postSelectionObj.hideElementsByClass('machineEngineerMarksToggle');
  			if($( 'form#machineEngineerForm' ).find('input[type=radio][id=machineEngineer-mbaFromGovernmentAffiliatedInstitute-no]').is(":checked")){
            	$(this).parent().parent().find(".help-block").html(jQuery("#notEligibleForPost").val());
                $(this).parent().parent().parent().addClass( 'has-error' );
                jQuery("#machineEngineerForm").find('#saveAsDraftBtn').attr('disabled','disabled');
                jQuery("#machineEngineerForm").find('#saveBtn').attr('disabled','disabled');
            } else {
                $(this).parent().parent().find(".help-block").html("");
                $(this).parent().parent().parent().removeClass( 'has-error has-danger' );
                jQuery("#machineEngineerForm").find('#saveAsDraftBtn').removeAttr('disabled');
             	jQuery("#machineEngineerForm").find('#saveBtn').removeAttr('disabled');
            }
       		
        }
    });
    
    $( 'form#machineEngineerForm' ).find('input[type=radio][name=mbaFromGovernmentAffiliatedInstitute]').unbind().change(function() {
        if (this.value == '1') {
        	$(this).parent().parent().find(".help-block").html("");
         	$(this).parent().parent().parent().removeClass( 'has-error has-danger' );
         	$('#gradOrPostGradError').html("");
       	 	$('#gradOrPostGradError').parent().parent().removeClass( 'has-error has-danger' );
         	 $('#machineEngineer-mbaDegreeName').attr("required", true);
        	$('#machineEngineer-mbaUniversity').attr("required", true);
        	$('#machineEngineermbaMarks').attr("required", true);
        	$('#machineEngineermbaMarks').attr("min", 35); 
        	postSelectionObj.showElementsByClass('machineEngineerMbaMarksToggle');
			postSelectionObj.showElementsByClass('machineEngineerMbaUniversityToggle');
			postSelectionObj.showElementsByClass('machineEngineerMbaDegreeNameToggle');
			
			
        } else {
        	jQuery('#machineEngineerForm').validate().settings.ignore = "#machineEngineer-mbaDegreeName,#machineEngineer-mbaUniversity,#machineEngineermbaMarks";
        	postSelectionObj.resetTextFieldById('machineEngineer-mbaDegreeName');
    	 	postSelectionObj.resetTextFieldById('machineEngineer-mbaUniversity');
    	 	postSelectionObj.resetTextFieldById('machineEngineermbaMarks');
    	 	$('#machineEngineermbaMarks').val(0);
        	postSelectionObj.hideElementsByClass('machineEngineerMbaMarksToggle');
			postSelectionObj.hideElementsByClass('machineEngineerMbaUniversityToggle');
			postSelectionObj.hideElementsByClass('machineEngineerMbaDegreeNameToggle');
			 $('#machineEngineer-mbaDegreeName').attr("required", false);
        	$('#machineEngineer-mbaUniversity').attr("required", false);
        	$('#machineEngineermbaMarks').attr("required", false); 
        	$("#machineEngineer-mbaDegreeName").parent().find('label.error').empty();
        	$("#machineEngineer-mbaUniversity").parent().find('label.error').empty();
        	$("#machineEngineermbaMarks").parent().find('label.error').empty();
			if($( 'form#machineEngineerForm' ).find('input[type=radio][id=machineEngineer-gradOrPostGrad-no]').is(":checked")){
            	$(this).parent().parent().find(".help-block").html(jQuery("#notEligibleForPost").val());
                $(this).parent().parent().parent().addClass( 'has-error' );
                jQuery("#machineEngineerForm").find('#saveAsDraftBtn').attr('disabled','disabled');
                jQuery("#machineEngineerForm").find('#saveBtn').attr('disabled','disabled');
            } else {
                $(this).parent().parent().find(".help-block").html("");
                $(this).parent().parent().parent().removeClass( 'has-error has-danger' );
                jQuery("#machineEngineerForm").find('#saveAsDraftBtn').removeAttr('disabled');
             	jQuery("#machineEngineerForm").find('#saveBtn').removeAttr('disabled');
            }
        }
    });  
    
$( 'form#machineEngineerForm' ).find('input[type=radio][name=mscitOrGaccc]').unbind().change(function() {
    	
    	if(this.value == '0'){
    		 commonObj.showAgreeDisAgreePopup("<fmt:message key='mscit.equivalent.computer.certificate.alert' />", mscitCertificatePopUpMachineEngineer, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
    	     
    	}
    });
    
    function mscitCertificatePopUpMachineEngineer(flag)
    {
    	if(!flag)
    	{
    		$('#machineEngineer-skComputerCourseCertification-yes').prop('checked', true);
      	}
    }
    
</script>

<div id="downloadEligibilityCriteria" class="form-group" align="right">
    <div class="col-sm-12" align="pull-right">
        <a href="javascript:void(0);" onclick="javascript:showEligibilityCriteriaPDF(${post.postId})"><b><fmt:message key="postEligibilityCriteriaLink"/></b></a>
    </div>
</div>

<form class="form-horizontal" name="machineEngineerForm"
      id="machineEngineerForm"
      action="<c:url value='/applicant?operation=saveApplicantPostDetails'/>" method="POST">

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${applicantPostAssoc.id}"/>
    <input type="hidden" name="postId" value="${post.postId}"/>
    <input type="hidden" name="status" id="status"  value="${ applicantPostAssoc.status }"/>

<div class="form-group">
		<label class="control-label col-sm-5"><fmt:message key="machine.engineer.isDegree"/>: <span class="red">*</span></label>
		<div class="col-sm-4">
			<div class="radio radio-inline">
				<input name="gradOrPostGrad" ${ applicantPostAssoc.gradOrPostGrad eq 1 ? 'checked="checked"':''} id="machineEngineer-gradOrPostGrad-yes" value="1" type="radio" />
				<label for="machineEngineer-gradOrPostGrad-yes"> <fmt:message key="yes"/> </label>
			</div>
			<div class="radio radio-inline">
				<input class="" name="gradOrPostGrad" ${applicantPostAssoc.gradOrPostGrad eq 0 ? 'checked="checked"':''} id="machineEngineer-gradOrPostGrad-no" value="0" type="radio" />
				<label for="machineEngineer-gradOrPostGrad-no"> <fmt:message key="no"/> </label>
			</div>
			<div id="gradOrPostGradError"class="help-block with-errors"></div>
		</div>
	</div>
	
	<div class="form-group machineEngineerDegreeNameToggle">
        <label class="control-label col-sm-5" for="degreeName"><fmt:message key="applicant.degreeName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.degreeName}" type="text" class="form-control" id="machineEngineer-degreeName" placeholder="<fmt:message key="applicant.degreeName"/>" name="degreeName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
	
	<div class="form-group machineEngineerUniversityToggle">
        <label class="control-label col-sm-5" for="universityName"><fmt:message key="applicant.universityName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.universityName}" type="text" class="form-control" id="machineEngineer-universityName" placeholder="<fmt:message key="fireWardenJunior.universityName"/>" name="universityName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
     <div class="form-group machineEngineerMarksToggle">
        <label class="control-label col-sm-5" for="requiredQualificationMarks"><fmt:message key="driverCumConductor.required.qualification.marks.obtained"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.requiredQualificationMarks}" type="number" class="form-control" id="machineEngineerrequiredQualificationMarks" placeholder="<fmt:message key="driverCumConductor.required.qualification.marks.obtained"/>" name="requiredQualificationMarks" maxlength="5" min="1" max="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
	
	<div class="form-group machineEngineerPostGraduateDegreeNameToggle">
        <label class="control-label col-sm-5" for="postGraduateDegreeName"><fmt:message key="machine.engineer.postGraguateDegreeName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.postGraduateDegreeName}" type="text" class="form-control" id="machineEngineer-postGraduateDegreeName" placeholder="<fmt:message key="departmental.transport.officer.postGraduateName"/>" name="postGraduateDegreeName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
	
	<div class="form-group machineEngineerPostGraduateUniversityToggle">
        <label class="control-label col-sm-5" for="postGradDegreeInstituteName"><fmt:message key="applicant.universityName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.postGradDegreeInstituteName}" type="text" class="form-control" id="machineEngineer-postGradDegreeInstituteName" placeholder="<fmt:message key="fireWardenJunior.universityName"/>" name="postGradDegreeInstituteName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
     <div class="form-group machineEngineerPostGraduateMarksToggle">
        <label class="control-label col-sm-5" for="departmentalTransportOfficerPostGraduateMarks"><fmt:message key="driverCumConductor.required.qualification.marks.obtained"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.postGraduateMarks}" type="number" class="form-control" id="machineEngineerPostGraduateMarks" placeholder="<fmt:message key="driverCumConductor.required.qualification.marks.obtained"/>" name="postGraduateMarks" maxlength="5" min="1" max="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div align="center"><strong ><fmt:message key="draftsman.diploma.certification.in.autocad"/></strong></div>
    <br>
    <div class="form-group">
		<label class="control-label col-sm-5"><fmt:message key="machine.engineer.OrDegree"/>: <span class="red">*</span></label>
		<div class="col-sm-4">
			<div class="radio radio-inline">
				<input name="mbaFromGovernmentAffiliatedInstitute" ${ applicantPostAssoc.mbaFromGovernmentAffiliatedInstitute ? 'checked="checked"':''} id="machineEngineer-mbaFromGovernmentAffiliatedInstitute-yes" value="1" type="radio" />
				<label for="machineEngineer-mbaFromGovernmentAffiliatedInstitute-yes"> <fmt:message key="yes"/> </label>
			</div>
			<div class="radio radio-inline">
				<input class="" name="mbaFromGovernmentAffiliatedInstitute" ${applicantPostAssoc.mbaFromGovernmentAffiliatedInstitute ==false ? 'checked="checked"':''} id="machineEngineer-mbaFromGovernmentAffiliatedInstitute-no" value="0" type="radio" />
				<label for="machineEngineer-mbaFromGovernmentAffiliatedInstitute-no"> <fmt:message key="no"/> </label>
			</div>
			<div id="mbaFromGovernmentAffiliatedInstituteError" class="help-block with-errors"></div>
		</div>
	</div>
    
    <div class="form-group machineEngineerMbaDegreeNameToggle">
        <label class="control-label col-sm-5" for="mbaDegreeName"><fmt:message key="storeOfficer.postGraduateDegreeName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.mbaDegreeName}" type="text" class="form-control" id="machineEngineer-mbaDegreeName" placeholder="<fmt:message key="applicant.degreeName"/>" name="mbaDegreeName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
	
	<div class="form-group machineEngineerMbaUniversityToggle">
        <label class="control-label col-sm-5" for="mbaUniversity"><fmt:message key="applicant.universityName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.mbaUniversity}" type="text" class="form-control" id="machineEngineer-mbaUniversity" placeholder="<fmt:message key="fireWardenJunior.universityName"/>" name="mbaUniversity" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
     <div class="form-group machineEngineerMbaMarksToggle">
        <label class="control-label col-sm-5" for="mbaMarks"><fmt:message key="driverCumConductor.required.qualification.marks.obtained"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.mbaMarks}" type="number" class="form-control" id="machineEngineermbaMarks" placeholder="<fmt:message key="driverCumConductor.required.qualification.marks.obtained"/>" name="mbaMarks" maxlength="5" min="1" max="100">
            <div class="help-block with-errors"></div>
        </div>
    </div> 
    
    <div class="form-group">
		<label class="control-label col-sm-5"><fmt:message key="machine.engineer.experience"/>: <span class="red">*</span></label>
		<div class="col-sm-4">
			<div class="radio radio-inline">
				<input name="managementExperience" ${ applicantPostAssoc.managementExperience ? 'checked="checked"':''} id="machineEngineer-managementExperience-yes" value="1" type="radio" />
				<label for="machineEngineer-managementExperience-yes"> <fmt:message key="yes"/> </label>
			</div>
			<div class="radio radio-inline">
				<input class="radiosToCheck" name="managementExperience" ${applicantPostAssoc.managementExperience ==false? 'checked="checked"':''} id="machineEngineer-managementExperience-no" value="0" type="radio" />
				<label for="machineEngineer-managementExperience-no"> <fmt:message key="no"/> </label>
			</div>
			<div class="help-block with-errors"></div>
		</div>
	</div>
	
	 <div class="form-group">
		<label class="control-label col-sm-5"><fmt:message key="machine.engineer.ability"/>: <span class="red">*</span></label>
		<div class="col-sm-4">
			<div class="radio radio-inline">
				<input name="isLargeOfficeAndLargeStaffMembers" ${ applicantPostAssoc.isLargeOfficeAndLargeStaffMembers ? 'checked="checked"':''} id="machineEngineer-isLargeOfficeAndLargeStaffMembers-yes" value="1" type="radio" />
				<label for="machineEngineer-isLargeOfficeAndLargeStaffMembers-yes"> <fmt:message key="yes"/> </label>
			</div>
			<div class="radio radio-inline">
				<input class="radiosToCheck" name="isLargeOfficeAndLargeStaffMembers" ${applicantPostAssoc.isLargeOfficeAndLargeStaffMembers ==false? 'checked="checked"':''} id="machineEngineer-isLargeOfficeAndLargeStaffMembers-no" value="0" type="radio" />
				<label for="machineEngineer-isLargeOfficeAndLargeStaffMembers-no"> <fmt:message key="no"/> </label>
			</div>
			<div class="help-block with-errors"></div>
		</div>
	</div>
	
	 <div class="form-group">
		<label class="control-label col-sm-5"><fmt:message key="machine.engineer.knowledge"/>: <span class="red">*</span></label>
		<div class="col-sm-4">
			<div class="radio radio-inline">
				<input name="knowledgeBoardMeetingsActs" ${ applicantPostAssoc.knowledgeBoardMeetingsActs ? 'checked="checked"':''} id="machineEngineer-knowledgeBoardMeetingsActs-yes" value="1" type="radio" />
				<label for="machineEngineer-knowledgeBoardMeetingsActs-yes"> <fmt:message key="yes"/> </label>
			</div>
			<div class="radio radio-inline">
				<input class="radiosToCheck" name="knowledgeBoardMeetingsActs" ${applicantPostAssoc.knowledgeBoardMeetingsActs ==false? 'checked="checked"':''} id="machineEngineer-knowledgeBoardMeetingsActs-no" value="0" type="radio" />
				<label for="machineEngineer-knowledgeBoardMeetingsActs-no"> <fmt:message key="no"/> </label>
			</div>
			<div class="help-block with-errors"></div>
		</div>
	</div>
    
     <div class="form-group">
        <label class="control-label col-sm-5" for="ownHeavyDrivingLicenseNumber"><fmt:message key="deputy.equipment.engineer.heavyDriveLicense"/>:<span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="ownHeavyDrivingLicenseNumber" id="machineEngineer-ownHeavyDrivingLicenseNumber-yes" value="1" type="radio" ${applicantPostAssoc.ownHeavyDrivingLicenseNumber ? 'checked' : ''}/>
                <label for="machineEngineer-ownHeavyDrivingLicenseNumber-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="ownHeavyDrivingLicenseNumber" id="machineEngineer-ownHeavyDrivingLicenseNumber-no" value="0" type="radio" ${applicantPostAssoc.ownHeavyDrivingLicenseNumber == false ? 'checked' : ''}/>
                <label for="machineEngineer-ownHeavyDrivingLicenseNumber-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group">
        <label class="control-label col-sm-5" for="machineEngineercomputerCourseCertification"><fmt:message key="machine.engineer.isMscIt"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline" >
                <input type="radio" name="mscitOrGaccc" value="1" class="form-control" id="machineEngineer-skComputerCourseCertification-yes" ${ applicantPostAssoc.mscitOrGaccc ? 'checked="checked"':''}  />
                <label for="machineEngineer-skComputerCourseCertification-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline" >
               	<input type="radio" name="mscitOrGaccc" value="0" class="form-control" id="machineEngineer-skComputerCourseCertification-no" ${ applicantPostAssoc.mscitOrGaccc == false ? 'checked="checked"':''}>
                <label for="machineEngineer-skComputerCourseCertification-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <jsp:include page="../postFooter.jsp">
        <jsp:param name="isPostSubmitted" value="${ applicantPostAssoc.status eq 2 || applicantPostAssoc.status eq 3 }"/>
        <jsp:param name="formId" value="machineEngineerForm"/>
        <jsp:param name="postId" value="${post.postId}"/>
        <jsp:param name="disableFormAfterLastDateOver" value="${disableFormAfterLastDateOver}"/>
    </jsp:include>

</form>

<script>
    $(document).ready(function(){
    	$("form[name='machineEngineerForm']").validate({
    	 	rules:{
    	 		gradOrPostGrad : "required",
    	 		mscitOrGaccc :"required",
    	 		 degreeName: {required: true},
    	 		 universityName: {required: true},
    	 		requiredQualificationMarks: {required: true, min: 35},
    	 		postGraduateDegreeName: {required: true},
    	 		postGradDegreeInstituteName: {required: true},
    	 		postGraduateMarks: {required: true, min:35},
    	 		mbaFromGovernmentAffiliatedInstitute : "required",
    	 		managementExperience : "required",
    	 		isLargeOfficeAndLargeStaffMembers : "required",
    	 		knowledgeBoardMeetingsActs : "required",
    	 		ownHeavyDrivingLicenseNumber:"required"
    	 		 },
    		     errorPlacement: function (error, element) {
    			    	if ( element.is(":radio") ) 
    		            {
    						error.appendTo(element.parent().parent().children('.help-block.with-errors'));
    		            }
    			    	else
    			    	{
    			    		error.insertAfter( element );
    			    	}
    		    	}
    		 });
    });
</script>