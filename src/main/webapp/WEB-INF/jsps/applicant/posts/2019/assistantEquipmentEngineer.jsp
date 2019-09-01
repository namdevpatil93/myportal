<%@ include file="../../../common/taglibs.jsp"%>

<script>
    jQuery(document).ready(function() {
    	 if('${ applicantPostAssoc.automobileOrMechanicalEngDegree}' == true || '${ applicantPostAssoc.automobileOrMechanicalEngDegree}' == "true")
 		{
 			postSelectionObj.showElementsByClass('assistantEquipmentEngineerDegreeToggle');
 			postSelectionObj.showElementsByClass('assistantEquipmentEngineerUniversityToggle');
 			postSelectionObj.showElementsByClass('assistantEquipmentEngineerRequiredQualificationMarksToggle');
 		}
 		else
 		{
 			postSelectionObj.hideElementsByClass('assistantEquipmentEngineerDegreeToggle');
 			postSelectionObj.hideElementsByClass('assistantEquipmentEngineerUniversityToggle');
 			postSelectionObj.hideElementsByClass('assistantEquipmentEngineerRequiredQualificationMarksToggle');
 		} 
     	
     	/* if ('${applicantPostAssoc.automobileOrMechanicalEngDegree}'=='' || '${applicantPostAssoc.automobileOrMechanicalEngDegree}'=='false') {
     		postSelectionObj.hideElementsByClass('departmentalTransportOfficerDegreeToggle');
         	postSelectionObj.hideElementsByClass('departmentalTransportOfficerUniversityToggle');
         	postSelectionObj.hideElementsByClass('departmentalTransportOfficerRequiredQualificationMarksToggle');
 		} */
     	
     	postSelectionObj.disableFormFields ("assistantEquipmentEngineerForm", '${applicantPostAssoc.status}');
 		postSelectionObj.bindPostForm("assistantEquipmentEngineerForm");
 		var lastDateOver = commonObj.isValidate(${applicantPostAssoc.disableForm});
 	    commonObj.disableFormFields("assistantEquipmentEngineerForm",lastDateOver);
    });
    
    $( 'form#assistantEquipmentEngineerForm' ).find('input[type=radio][name=automobileOrMechanicalEngDegree]').unbind().change(function() {
        if (this.value == '1') {
       	 postSelectionObj.showElementsByClass('assistantEquipmentEngineerDegreeToggle');
       	postSelectionObj.showElementsByClass('assistantEquipmentEngineerUniversityToggle');
       	postSelectionObj.showElementsByClass('assistantEquipmentEngineerRequiredQualificationMarksToggle');
        } else {
       		postSelectionObj.hideElementsByClass('assistantEquipmentEngineerDegreeToggle');
        	postSelectionObj.hideElementsByClass('assistantEquipmentEngineerUniversityToggle');
        	postSelectionObj.hideElementsByClass('assistantEquipmentEngineerRequiredQualificationMarksToggle');
       		/*  postSelectionObj.resetTextFieldById('assistantEquipmentEngineer-affiliatedDegreeName');
       	 	postSelectionObj.resetTextFieldById('assistantEquipmentEngineer-fireSafetyUniversityName');
       	 	postSelectionObj.resetTextFieldById('assistantEquipmentEngineerRequiredQualificationMarks'); */
       	 	
        }
    });
    
$( 'form#assistantEquipmentEngineerForm' ).find('input[type=radio][name=mscitOrGaccc]').unbind().change(function() {
    	
    	if(this.value == '0'){
    		 commonObj.showAgreeDisAgreePopup("<fmt:message key='mscit.equivalent.computer.certificate.alert' />", mscitCertificatePopUpAssistantEquipmentEngineer, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
    	     
    	}
    });
    
    function mscitCertificatePopUpAssistantEquipmentEngineer(flag)
    {
    	if(!flag)
    	{
    		$('#assistantEquipmentEngineer-skComputerCourseCertification-yes').prop('checked', true);
      	}
    }
    
</script>

<div id="downloadEligibilityCriteria" class="form-group" align="right">
    <div class="col-sm-12" align="pull-right">
        <a href="javascript:void(0);" onclick="javascript:showEligibilityCriteriaPDF(${post.postId})"><b><fmt:message key="postEligibilityCriteriaLink"/></b></a>
    </div>
</div>

<form class="form-horizontal" name="assistantEquipmentEngineerForm"
      id="assistantEquipmentEngineerForm"
      action="<c:url value='/applicant?operation=saveApplicantPostDetails'/>" method="POST">

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${applicantPostAssoc.id}"/>
    <input type="hidden" name="postId" value="${post.postId}"/>
    <input type="hidden" name="status" id="status"  value="${ applicantPostAssoc.status }"/>

<div class="form-group">
		<label class="control-label col-sm-5"><fmt:message key="degree.in.automobile.production.mechanical"/>: <span class="red">*</span></label>
		<div class="col-sm-4">
			<div class="radio radio-inline">
				<input name="automobileOrMechanicalEngDegree" ${ applicantPostAssoc.automobileOrMechanicalEngDegree ? 'checked="checked"':''} id="assistantEquipmentEngineer-isDegreeFromAffiliatedInstitute-yes" value="1" type="radio" />
				<label for="assistantEquipmentEngineer-isDegreeFromAffiliatedInstitute-yes"> <fmt:message key="yes"/> </label>
			</div>
			<div class="radio radio-inline">
				<input class="radiosToCheck" name="automobileOrMechanicalEngDegree" ${applicantPostAssoc.automobileOrMechanicalEngDegree == false ? 'checked="checked"':''} id="assistantEquipmentEngineer-isDegreeFromAffiliatedInstitute-no" value="0" type="radio" />
				<label for="assistantEquipmentEngineer-isDegreeFromAffiliatedInstitute-no"> <fmt:message key="no"/> </label>
			</div>
			<div class="help-block with-errors"></div>
		</div>
	</div>
	
	<div class="form-group assistantEquipmentEngineerDegreeToggle">
        <label class="control-label col-sm-5" for="affiliatedDegreeName"><fmt:message key="applicant.degreeName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.degreeName}" type="text" class="form-control" id="assistantEquipmentEngineer-affiliatedDegreeName" placeholder="<fmt:message key="applicant.degreeName"/>" name="degreeName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
	
	<div class="form-group assistantEquipmentEngineerUniversityToggle">
        <label class="control-label col-sm-5" for="affiliatedUniversityName"><fmt:message key="applicant.universityName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.universityName}" type="text" class="form-control" id="assistantEquipmentEngineer-affiliatedUniversityName" placeholder="<fmt:message key="fireWardenJunior.universityName"/>" name="universityName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div> 
    
     <div class="form-group assistantEquipmentEngineerRequiredQualificationMarksToggle">
        <label class="control-label col-sm-5" for="assistantEquipmentEngineerRequiredQualificationMarks"><fmt:message key="driverCumConductor.required.qualification.marks.obtained"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.requiredQualificationMarks}" type="number" class="form-control" id="assistantEquipmentEngineerRequiredQualificationMarks" placeholder="<fmt:message key="driverCumConductor.required.qualification.marks.obtained"/>" name="requiredQualificationMarks" maxlength="5" min="1" max="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
     <div class="form-group">
        <label class="control-label col-sm-5" for="ownHeavyDrivingLicenseNumber"><fmt:message key="deputy.equipment.engineer.heavyDriveLicense"/>:<span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="ownHeavyDrivingLicenseNumber" id="assistantEquipmentEngineer-ownHeavyDrivingLicenseNumber-yes" value="1" type="radio" ${applicantPostAssoc.ownHeavyDrivingLicenseNumber ? 'checked' : ''}/>
                <label for="assistantEquipmentEngineer-ownHeavyDrivingLicenseNumber-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="ownHeavyDrivingLicenseNumber" id="assistantEquipmentEngineer-ownHeavyDrivingLicenseNumber-no" value="0" type="radio" ${applicantPostAssoc.ownHeavyDrivingLicenseNumber == false ? 'checked' : ''}/>
                <label for="assistantEquipmentEngineer-ownHeavyDrivingLicenseNumber-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>

 <div class="form-group">
        <label class="control-label col-sm-5" for="assistantEquipmentEngineercomputerCourseCertification"><fmt:message key="machine.engineer.isMscIt"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline" >
                <input type="radio" name="mscitOrGaccc" value="1" class="form-control" id="assistantEquipmentEngineer-skComputerCourseCertification-yes" ${ applicantPostAssoc.mscitOrGaccc ? 'checked="checked"':''}  />
                <label for="assistantEquipmentEngineer-skComputerCourseCertification-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline" >
               	<input type="radio" name="mscitOrGaccc" value="0" class="form-control" id="assistantEquipmentEngineer-skComputerCourseCertification-no" ${ applicantPostAssoc.mscitOrGaccc == false ? 'checked="checked"':''}>
                <label for="assistantEquipmentEngineer-skComputerCourseCertification-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    

    <jsp:include page="../postFooter.jsp">
        <jsp:param name="isPostSubmitted" value="${ applicantPostAssoc.status eq 2 || applicantPostAssoc.status eq 3 }"/>
        <jsp:param name="formId" value="assistantEquipmentEngineerForm"/>
        <jsp:param name="postId" value="${post.postId}"/>
        <jsp:param name="disableFormAfterLastDateOver" value="${disableFormAfterLastDateOver}"/>
    </jsp:include>

</form>

<script>
    $(document).ready(function(){
    	 $("form[name='assistantEquipmentEngineerForm']").validate({
  		 	rules:{
  		 		automobileOrMechanicalEngDegree : "required",
  		 		ownHeavyDrivingLicenseNumber: "required",
  		 		mscitOrGaccc : "required",
  		 		degreeName: {required: true},
  		 		universityName: {required: true},
  		 		requiredQualificationMarks: {required: true, min: 35}
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