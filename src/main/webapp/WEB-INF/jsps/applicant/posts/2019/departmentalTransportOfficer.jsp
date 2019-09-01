<%@ include file="../../../common/taglibs.jsp"%>

<script>
    jQuery(document).ready(function() {
    	if('${ applicantPostAssoc.gradOrPostGrad}' == 1 )
  		{
  			postSelectionObj.showElementsByClass('departmentalTransportOfficerPostGraduateDegreeNameToggle');
  			postSelectionObj.showElementsByClass('departmentalTransportOfficerPostGraduateUniversityToggle');
  			postSelectionObj.showElementsByClass('departmentalTransportOfficerPostGraduateMarksToggle');
  		}
  		else
  		{
  			postSelectionObj.hideElementsByClass('departmentalTransportOfficerPostGraduateDegreeNameToggle');
  			postSelectionObj.hideElementsByClass('departmentalTransportOfficerPostGraduateUniversityToggle');
  			postSelectionObj.hideElementsByClass('departmentalTransportOfficerPostGraduateMarksToggle');
  		} 
      	
      	/* if ('${applicantPostAssoc.automobileOrMechanicalEngDegree}'=='' || '${applicantPostAssoc.automobileOrMechanicalEngDegree}'=='false') {
      		postSelectionObj.hideElementsByClass('departmentalTransportOfficerDegreeToggle');
          	postSelectionObj.hideElementsByClass('departmentalTransportOfficerUniversityToggle');
          	postSelectionObj.hideElementsByClass('departmentalTransportOfficerRequiredQualificationMarksToggle');
  		} */
      	
      	postSelectionObj.disableFormFields ("departmentalTransportOfficerForm", '${applicantPostAssoc.status}');
  		postSelectionObj.bindPostForm("departmentalTransportOfficerForm");
  		var lastDateOver = commonObj.isValidate(${applicantPostAssoc.disableForm});
  	    commonObj.disableFormFields("departmentalTransportOfficerForm",lastDateOver);
    });
    
    $( 'form#departmentalTransportOfficerForm' ).find('input[type=radio][name=gradOrPostGrad]').unbind().change(function() {
        if (this.value == '1') {
       	 postSelectionObj.showElementsByClass('departmentalTransportOfficerPostGraduateDegreeNameToggle');
       	postSelectionObj.showElementsByClass('departmentalTransportOfficerPostGraduateUniversityToggle');
       	postSelectionObj.showElementsByClass('departmentalTransportOfficerPostGraduateMarksToggle');
        } else {
        	 postSelectionObj.resetTextFieldById('departmentalTransportOfficer-PostGraduateDegreeName');
        	 	postSelectionObj.resetTextFieldById('departmentalTransportOfficer-postGradDegreeInstituteName');
        	 	postSelectionObj.resetTextFieldById('departmentalTransportOfficerPostGraduateMarks');
        	postSelectionObj.hideElementsByClass('departmentalTransportOfficerPostGraduateDegreeNameToggle');
        	postSelectionObj.hideElementsByClass('departmentalTransportOfficerPostGraduateUniversityToggle');
        	postSelectionObj.hideElementsByClass('departmentalTransportOfficerPostGraduateMarksToggle');
       		
        }
    });
    
$( 'form#departmentalTransportOfficerForm' ).find('input[type=radio][name=mscitOrGaccc]').unbind().change(function() {
    	
    	if(this.value == '0'){
    		 commonObj.showAgreeDisAgreePopup("<fmt:message key='mscit.equivalent.computer.certificate.alert' />", mscitCertificatePopUpDepartmentalTransportOfficer, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
    	     
    	}
    });
    
    function mscitCertificatePopUpDepartmentalTransportOfficer(flag)
    {
    	if(!flag)
    	{
    		$('#departmentalTransportOfficer-skComputerCourseCertification-yes').prop('checked', true);
      	}
    }
    
</script>

<div id="downloadEligibilityCriteria" class="form-group" align="right">
    <div class="col-sm-12" align="pull-right">
        <a href="javascript:void(0);" onclick="javascript:showEligibilityCriteriaPDF(${post.postId})"><b><fmt:message key="postEligibilityCriteriaLink"/></b></a>
    </div>
</div>

<form class="form-horizontal" name="departmentalTransportOfficerForm"
      id="departmentalTransportOfficerForm"
      action="<c:url value='/applicant?operation=saveApplicantPostDetails'/>" method="POST">

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${applicantPostAssoc.id}"/>
    <input type="hidden" name="postId" value="${post.postId}"/>
    <input type="hidden" name="status" id="status"  value="${ applicantPostAssoc.status }"/>


<div class="form-group">
		<label class="control-label col-sm-5"><fmt:message key="departmental.transport.officer.degree"/>: <span class="red">*</span></label>
		<div class="col-sm-4">
			<div class="radio radio-inline">
				<input name="gradOrPostGrad" ${ applicantPostAssoc.gradOrPostGrad eq 1 ? 'checked="checked"':''} id="departmentalTransportOfficer-isDegreeFromAffiliatedInstitute-yes" value="1" type="radio" />
				<label for="departmentalTransportOfficer-isDegreeFromAffiliatedInstitute-yes"> <fmt:message key="yes"/> </label>
			</div>
			<div class="radio radio-inline">
				<input class="radiosToCheck" name="gradOrPostGrad" ${applicantPostAssoc.gradOrPostGrad eq 2 ? 'checked="checked"':''} id="departmentalTransportOfficer-isDegreeFromAffiliatedInstitute-no" value="2" type="radio" />
				<label for="departmentalTransportOfficer-isDegreeFromAffiliatedInstitute-no"> <fmt:message key="no"/> </label>
			</div>
			<div class="help-block with-errors"></div>
		</div>
	</div>
	
	<div class="form-group departmentalTransportOfficerPostGraduateDegreeNameToggle">
        <label class="control-label col-sm-5" for="postGraduateDegreeName"><fmt:message key="departmental.transport.officer.postGraduateName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.postGraduateDegreeName}" type="text" class="form-control" id="departmentalTransportOfficer-postGraduateDegreeName" placeholder="<fmt:message key="departmental.transport.officer.postGraduateName"/>" name="postGraduateDegreeName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
	
	<div class="form-group departmentalTransportOfficerPostGraduateUniversityToggle">
        <label class="control-label col-sm-5" for="postGradDegreeInstituteName"><fmt:message key="applicant.universityName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.postGradDegreeInstituteName}" type="text" class="form-control" id="departmentalTransportOfficer-postGradDegreeInstituteName" placeholder="<fmt:message key="fireWardenJunior.universityName"/>" name="postGradDegreeInstituteName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
     <div class="form-group departmentalTransportOfficerPostGraduateMarksToggle">
        <label class="control-label col-sm-5" for="departmentalTransportOfficerPostGraduateMarks"><fmt:message key="driverCumConductor.required.qualification.marks.obtained"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.postGraduateMarks}" type="number" class="form-control" id="departmentalTransportOfficerPostGraduateMarks" placeholder="<fmt:message key="driverCumConductor.required.qualification.marks.obtained"/>" name="postGraduateMarks" maxlength="5" min="1" max="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
      <div class="form-group">
        <label class="control-label col-sm-5" for="ownHeavyDrivingLicenseNumber"><fmt:message key="deputy.equipment.engineer.heavyDriveLicense"/>:<span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="ownHeavyDrivingLicenseNumber" id="departmentalTransportOfficer-ownHeavyDrivingLicenseNumber-yes" value="1" type="radio" ${applicantPostAssoc.ownHeavyDrivingLicenseNumber ? 'checked' : ''}/>
                <label for="departmentalTransportOfficer-ownHeavyDrivingLicenseNumber-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="ownHeavyDrivingLicenseNumber" id="departmentalTransportOfficer-ownHeavyDrivingLicenseNumber-no" value="0" type="radio" ${applicantPostAssoc.ownHeavyDrivingLicenseNumber == false ? 'checked' : ''}/>
                <label for="departmentalTransportOfficer-ownHeavyDrivingLicenseNumber-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <%--  <div class="form-group">
        <label class="control-label col-sm-5" for="ownHeavyDrivingLicenseNumber"><fmt:message key="deputy.equipment.engineer.heavyDriveLicense"/>:</label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="ownHeavyDrivingLicenseNumber" id="departmentalTransportOfficer-ownHeavyDrivingLicenseNumber-yes" value="1" type="radio" ${applicantPostAssoc.ownHeavyDrivingLicenseNumber ? 'checked' : ''}/>
                <label for="departmentalTransportOfficer-ownHeavyDrivingLicenseNumber-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="ownHeavyDrivingLicenseNumber" id="departmentalTransportOfficer-ownHeavyDrivingLicenseNumber-no" value="0" type="radio" ${applicantPostAssoc.ownHeavyDrivingLicenseNumber == false ? 'checked' : ''}/>
                <label for="departmentalTransportOfficer-ownHeavyDrivingLicenseNumber-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div> --%>
    
     <div class="form-group">
        <label class="control-label col-sm-5" for="departmentalTransportOfficercomputerCourseCertification"><fmt:message key="machine.engineer.isMscIt"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline" >
                <input type="radio" name="mscitOrGaccc" value="1" class="form-control" id="departmentalTransportOfficer-skComputerCourseCertification-yes" ${ applicantPostAssoc.mscitOrGaccc ? 'checked="checked"':''}  />
                <label for="departmentalTransportOfficer-skComputerCourseCertification-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline" >
               	<input type="radio" name="mscitOrGaccc" value="0" class="form-control" id="departmentalTransportOfficer-skComputerCourseCertification-no" ${ applicantPostAssoc.mscitOrGaccc == false ? 'checked="checked"':''}>
                <label for="departmentalTransportOfficer-skComputerCourseCertification-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <jsp:include page="../postFooter.jsp">
        <jsp:param name="isPostSubmitted" value="${ applicantPostAssoc.status eq 2 || applicantPostAssoc.status eq 3 }"/>
        <jsp:param name="formId" value="departmentalTransportOfficerForm"/>
        <jsp:param name="postId" value="${post.postId}"/>
        <jsp:param name="disableFormAfterLastDateOver" value="${disableFormAfterLastDateOver}"/>
    </jsp:include>

</form>

<script>
    $(document).ready(function(){
    	$("form[name='departmentalTransportOfficerForm']").validate({
   		 	rules:{
   		 		gradOrPostGrad : "required",
   		 		mscitOrGaccc :"required",
   		 		ownHeavyDrivingLicenseNumber: "required",
   		 		postGraduateDegreeName: {required: true},
   		 		postGradDegreeInstituteName: {required: true},
   		 		postGraduateMarks: {required: true, min: 35}
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