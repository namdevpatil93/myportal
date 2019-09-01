<%@ include file="../../../common/taglibs.jsp"%>

<script>
    jQuery(document).ready(function() {
    	 var lastDateOver = commonObj.isValidate(${applicantPostAssoc.disableForm});
 	     commonObj.disableFormFields("divisionalTransportSuperintendentForm",lastDateOver);

    	gradOrPostGradDetailsToggle('${applicantPostAssoc.gradOrPostGrad}');
    	postSelectionObj.bindPostForm('divisionalTransportSuperintendentForm');
    });
    
    function gradOrPostGradDetailsToggle(val){
    	if(val==1){
    		 jQuery(".divisionalTransportSuperintendent-postgraddegreeDiv").show();
    	}else if(val== 2){
    		jQuery(".divisionalTransportSuperintendent-postgraddegreeDiv").hide();
    		postSelectionObj.bindPostForm('divisionalTransportSuperintendentForm');
    		
    	}else{
    		jQuery(".divisionalTransportSuperintendent-postgraddegreeDiv").hide();
    	}
    }
    
$( 'form#divisionalTransportSuperintendentForm' ).find('input[type=radio][name=mscitOrGaccc]').unbind().change(function() {
    	
    	if(this.value == '0'){
    		 commonObj.showAgreeDisAgreePopup("<fmt:message key='mscit.equivalent.computer.certificate.alert' />", mscitCertificatePopUpDivisionalTransportSuperintendent, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
    	     
    	}
    });
    
    function mscitCertificatePopUpDivisionalTransportSuperintendent(flag)
    {
    	if(!flag)
    	{
    		$('#divisionalTransportSuperintendent-skComputerCourseCertification-yes').prop('checked', true);
      	}
    }
    
</script>

<div id="downloadEligibilityCriteria" class="form-group" align="right">
    <div class="col-sm-12" align="pull-right">
        <a href="javascript:void(0);" onclick="javascript:showEligibilityCriteriaPDF(${post.postId})"><b><fmt:message key="postEligibilityCriteriaLink"/></b></a>
    </div>
</div>

<form class="form-horizontal" name="divisionalTransportSuperintendentForm"
      id="divisionalTransportSuperintendentForm"
      action="<c:url value='/applicant?operation=saveApplicantPostDetails'/>" method="POST">

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${applicantPostAssoc.id}"/>
    <input type="hidden" name="postId" value="${post.postId}"/>
    <input type="hidden" name="status" id="status"  value="${ applicantPostAssoc.status }"/>

	<div class="form-group">
        <label class="control-label col-sm-5" for="gradOrPostGrad"><fmt:message key="divisional.transport.superintendent.degree"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="gradOrPostGrad"  onclick="javascript:gradOrPostGradDetailsToggle(1)" id="divisionalTransportSuperintendent-gradOrPostGrad-yes" value="1" type="radio" ${applicantPostAssoc.gradOrPostGrad eq 1 ? 'checked' : ''} />
                <label for="divisionalTransportSuperintendent-gradOrPostGrad-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="gradOrPostGrad" onclick="javascript:gradOrPostGradDetailsToggle(2)"  onclick="javascript:void(0);" data-backdrop="static" data-keyboard="false" data-toggle="modal" id="divisionalTransportSuperintendent-gradOrPostGrad-no" value="2" type="radio" ${applicantPostAssoc.gradOrPostGrad eq 2 ? 'checked' : ''} />
                <label for="divisionalTransportSuperintendent-gradOrPostGrad-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
	<div class="divisionalTransportSuperintendent-postgraddegreeDiv" id="divisionalTransportSuperintendent-postgraddegreeDiv" hidden>
    	<div class="form-group postgraddegree">
        <label class="control-label col-sm-5" for="degreeName"><fmt:message key="deputy.equipment.engineer.degreeName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.degreeName}" type="text" class="form-control" id="degreeName" placeholder="<fmt:message key="deputy.equipment.engineer.degreeName"/>" name="degreeName" maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
    	</div>
    
    	<div class="form-group postgradinstituteName">
        <label class="control-label col-sm-5" for="instituteName"><fmt:message key="applicant.universityName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
          <input value="${applicantPostAssoc.instituteName}" type="text" class="form-control" id="instituteName" placeholder="<fmt:message key="applicant.universityName"/>" name="instituteName" maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
    	</div>
    	<div class="form-group divisionalTransportSuperintendentRequiredQualificationMarks">
        <label class="control-label col-sm-5" for="divisionalTransportSuperintendentRequiredQualificationMarks"><fmt:message key="driverCumConductor.required.qualification.marks.obtained"/> %: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.requiredQualificationMarks}"  oninput="javascript:toggleGraduationMarks(this.value);" type="number" class="form-control" id="divisionalTransportSuperintendentRequiredQualificationMarks" placeholder="<fmt:message key="driverCumConductor.required.qualification.marks.obtained"/>" name="requiredQualificationMarks" maxlength="5" min="1" max="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    	<%-- <div class="form-group postgraddegree">
        <label class="control-label col-sm-5" for="postGraduateDegreeName"><fmt:message key="postgraddegree.label"/>: <span class="red"></span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.postGraduateDegreeName}" type="text" class="form-control" id="postGraduateDegreeName" placeholder="<fmt:message key="postgraddegree.label"/>" name="postGraduateDegreeName" maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
    	</div>
    
    	<div class="form-group postgradinstituteName">
        <label class="control-label col-sm-5" for="postGradDegreeInstituteName"><fmt:message key="postgraddegree.instituteName"/>: <span class="red"></span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.postGradDegreeInstituteName}" type="text" class="form-control" id="postGradDegreeInstituteName" placeholder="<fmt:message key="postgraddegree.instituteName"/>" name="postGradDegreeInstituteName" maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
    	</div>
    	<div class="form-group divisionalTransportSuperintendentRequiredQualificationMarks">
        <label class="control-label col-sm-5" for="divisionalTransportSuperintendentRequiredQualificationMarks"><fmt:message key="driverCumConductor.required.qualification.marks.obtained"/>: <span class="red"></span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.postGraduateMarks}"  oninput="javascript:toggleGraduationMarks(this.value);" type="number" class="form-control" id="postGraduateMarks" placeholder="<fmt:message key="driverCumConductor.required.qualification.marks.obtained"/>" name="postGraduateMarks" maxlength="5" min="1" max="100">
            <div class="help-block with-errors"></div>
        </div>
    </div> --%>
   </div>
   
   <%-- <div class="form-group">
        <label class="control-label col-sm-5" for="ownHeavyDrivingLicenseNumber1"><fmt:message key="deputy.equipment.engineer.heavyDriveLicense"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="ownHeavyDrivingLicenseNumber" id="driverCumConductor-ownHeavyDrivingLicenseNumber-yes" value="1" type="radio" ${applicantPostAssoc.ownHeavyDrivingLicenseNumber ? 'checked' : ''} />
                <label for="driverCumConductor-ownHeavyDrivingLicenseNumber-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="ownHeavyDrivingLicenseNumber" onclick="postSelectionObj.bindPostForm('divisionalTransportSuperintendentForm');" id="driverCumConductor-ownHeavyDrivingLicenseNumber-no" value="0" type="radio" ${applicantPostAssoc.ownHeavyDrivingLicenseNumber == false  ? 'checked' : ''} />
                <label for="driverCumConductor-ownHeavyDrivingLicenseNumber-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div> --%>
    
    <div class="form-group">
        <label class="control-label col-sm-5" for="ownHeavyDrivingLicenseNumber"><fmt:message key="deputy.equipment.engineer.heavyDriveLicense"/>:<span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="ownHeavyDrivingLicenseNumber" id="divisionalTransportSuperintendent-ownHeavyDrivingLicenseNumber-yes" value="1" type="radio" ${applicantPostAssoc.ownHeavyDrivingLicenseNumber ? 'checked' : ''}/>
                <label for="divisionalTransportSuperintendent-ownHeavyDrivingLicenseNumber-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="ownHeavyDrivingLicenseNumber" id="divisionalTransportSuperintendent-ownHeavyDrivingLicenseNumber-no" value="0" type="radio" ${applicantPostAssoc.ownHeavyDrivingLicenseNumber == false ? 'checked' : ''}/>
                <label for="divisionalTransportSuperintendent-ownHeavyDrivingLicenseNumber-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
   
   <div class="form-group">
        <label class="control-label col-sm-5" for="divisionalTransportSuperintendentcomputerCourseCertification"><fmt:message key="machine.engineer.isMscIt"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline" >
                <input type="radio" name="mscitOrGaccc" value="1" class="form-control" id="divisionalTransportSuperintendent-skComputerCourseCertification-yes" ${ applicantPostAssoc.mscitOrGaccc ? 'checked="checked"':''}  />
                <label for="divisionalTransportSuperintendent-skComputerCourseCertification-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline" >
               	<input type="radio" name="mscitOrGaccc" value="0" class="form-control" id="divisionalTransportSuperintendent-skComputerCourseCertification-no" ${ applicantPostAssoc.mscitOrGaccc == false ? 'checked="checked"':''}>
                <label for="divisionalTransportSuperintendent-skComputerCourseCertification-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <jsp:include page="../postFooter.jsp">
        <jsp:param name="isPostSubmitted" value="${ applicantPostAssoc.status eq 2 || applicantPostAssoc.status eq 3 }"/>
        <jsp:param name="formId" value="divisionalTransportSuperintendentForm"/>
        <jsp:param name="postId" value="${post.postId}"/>
        <jsp:param name="disableFormAfterLastDateOver" value="${disableFormAfterLastDateOver}"/>
    </jsp:include>

</form>

<script>
    $(document).ready(function(){

    	 $("form[name='divisionalTransportSuperintendentForm']").validate({
    		 	rules:{
    		 		gradOrPostGrad : "required",
    		 		ownHeavyDrivingLicenseNumber: "required",
    		 		degreeName : "required",
    		 		mscitOrGaccc : "required",
    		 		instituteName : "required",
    		 		requiredQualificationMarks : {required: true, min: 35}/* ,
    		 		postGraduateDegreeName : "required",
    		 		postGradDegreeInstituteName : "required",
    		 		postGraduateMarks: {required: true, min: 35}, */
    		 		
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