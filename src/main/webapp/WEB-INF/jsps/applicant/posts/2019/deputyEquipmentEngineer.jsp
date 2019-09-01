<%@ include file="../../../common/taglibs.jsp"%>

<script>
    jQuery(document).ready(function() {
    	 if('${ applicantPostAssoc.automobileOrMechanicalEngDegree}' == true || '${ applicantPostAssoc.automobileOrMechanicalEngDegree}' == "true")
 		{
 			postSelectionObj.showElementsByClass('deputyEquipmentEngineerDegreeToggle');
 			postSelectionObj.showElementsByClass('deputyEquipmentEngineerUniversityToggle');
 			postSelectionObj.showElementsByClass('deputyEquipmentEngineerRequiredQualificationMarksToggle');
 		}
 		else
 		{
 			postSelectionObj.hideElementsByClass('deputyEquipmentEngineerDegreeToggle');
 			postSelectionObj.hideElementsByClass('deputyEquipmentEngineerUniversityToggle');
 			postSelectionObj.hideElementsByClass('deputyEquipmentEngineerRequiredQualificationMarksToggle');
 		} 
     	
     	/* if ('${applicantPostAssoc.automobileOrMechanicalEngDegree}'=='' || '${applicantPostAssoc.automobileOrMechanicalEngDegree}'=='false') {
     		postSelectionObj.hideElementsByClass('departmentalTransportOfficerDegreeToggle');
         	postSelectionObj.hideElementsByClass('departmentalTransportOfficerUniversityToggle');
         	postSelectionObj.hideElementsByClass('departmentalTransportOfficerRequiredQualificationMarksToggle');
 		} */
     	
     	postSelectionObj.disableFormFields ("deputyEquipmentEngineerForm", '${applicantPostAssoc.status}');
 		postSelectionObj.bindPostForm("deputyEquipmentEngineerForm");
 		var lastDateOver = commonObj.isValidate(${applicantPostAssoc.disableForm});
 	    commonObj.disableFormFields("deputyEquipmentEngineerForm",lastDateOver);
    });
    
    $( 'form#deputyEquipmentEngineerForm' ).find('input[type=radio][name=automobileOrMechanicalEngDegree]').unbind().change(function() {
        if (this.value == '1') {
       	 postSelectionObj.showElementsByClass('deputyEquipmentEngineerDegreeToggle');
       	postSelectionObj.showElementsByClass('deputyEquipmentEngineerUniversityToggle');
       	postSelectionObj.showElementsByClass('deputyEquipmentEngineerRequiredQualificationMarksToggle');
        } else {
       		postSelectionObj.hideElementsByClass('deputyEquipmentEngineerDegreeToggle');
        	postSelectionObj.hideElementsByClass('deputyEquipmentEngineerUniversityToggle');
        	postSelectionObj.hideElementsByClass('deputyEquipmentEngineerRequiredQualificationMarksToggle');
       		 postSelectionObj.resetTextFieldById('deputyEquipmentEngineer-affiliatedDegreeName');
       	 	postSelectionObj.resetTextFieldById('deputyEquipmentEngineer-fireSafetyUniversityName');
       	 	postSelectionObj.resetTextFieldById('deputyEquipmentEngineerRequiredQualificationMarks');
       	 	
        }
    });
    
$( 'form#deputyEquipmentEngineerForm' ).find('input[type=radio][name=mscitOrGaccc]').unbind().change(function() {
    	
    	if(this.value == '0'){
    		 commonObj.showAgreeDisAgreePopup("<fmt:message key='mscit.equivalent.computer.certificate.alert' />", mscitCertificatePopUpDeputyEquipmentEngineer, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
    	     
    	}
    });
    
    function mscitCertificatePopUpDeputyEquipmentEngineer(flag)
    {
    	if(!flag)
    	{
    		$('#deputyEquipmentEngineer-skComputerCourseCertification-yes').prop('checked', true);
      	}
    }
    
</script>

<div id="downloadEligibilityCriteria" class="form-group" align="right">
    <div class="col-sm-12" align="pull-right">
        <a href="javascript:void(0);" onclick="javascript:showEligibilityCriteriaPDF(${post.postId})"><b><fmt:message key="postEligibilityCriteriaLink"/></b></a>
    </div>
</div>

<form class="form-horizontal" name="deputyEquipmentEngineerForm"
      id="deputyEquipmentEngineerForm"
      action="<c:url value='/applicant?operation=saveApplicantPostDetails'/>" method="POST">

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${applicantPostAssoc.id}"/>
    <input type="hidden" name="postId" value="${post.postId}"/>
    <input type="hidden" name="status" id="status"  value="${ applicantPostAssoc.status }"/>

<div class="form-group">
		<label class="control-label col-sm-5"><fmt:message key="deputy.equipment.engineer.isdegree"/>: <span class="red">*</span></label>
		<div class="col-sm-4">
			<div class="radio radio-inline">
				<input name="automobileOrMechanicalEngDegree" ${ applicantPostAssoc.automobileOrMechanicalEngDegree ? 'checked="checked"':''} id="deputyEquipmentEngineer-isDegreeFromAffiliatedInstitute-yes" value="1" type="radio" />
				<label for="deputyEquipmentEngineer-isDegreeFromAffiliatedInstitute-yes"> <fmt:message key="yes"/> </label>
			</div>
			<div class="radio radio-inline">
				<input class="radiosToCheck" name="automobileOrMechanicalEngDegree" ${applicantPostAssoc.automobileOrMechanicalEngDegree == false ? 'checked="checked"':''} id="deputyEquipmentEngineer-isDegreeFromAffiliatedInstitute-no" value="0" type="radio" />
				<label for="deputyEquipmentEngineer-isDegreeFromAffiliatedInstitute-no"> <fmt:message key="no"/> </label>
			</div>
			<div class="help-block with-errors"></div>
		</div>
	</div>
	
	<div class="form-group deputyEquipmentEngineerDegreeToggle">
        <label class="control-label col-sm-5" for="affiliatedDegreeName"><fmt:message key="deputy.equipment.engineer.degreeName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.degreeName}" type="text" class="form-control" id="deputyEquipmentEngineer-affiliatedDegreeName" placeholder="<fmt:message key="deputy.equipment.engineer.degreeName"/>" name="degreeName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
	
	<div class="form-group deputyEquipmentEngineerUniversityToggle">
        <label class="control-label col-sm-5" for="affiliatedUniversityName"><fmt:message key="applicant.universityName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.universityName}" type="text" class="form-control" id="deputyEquipmentEngineer-affiliatedUniversityName" placeholder="<fmt:message key="fireWardenJunior.universityName"/>" name="universityName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
     <div class="form-group deputyEquipmentEngineerRequiredQualificationMarksToggle">
        <label class="control-label col-sm-5" for="deputyEquipmentEngineerRequiredQualificationMarks"><fmt:message key="driverCumConductor.required.qualification.marks.obtained"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.requiredQualificationMarks}" type="number" class="form-control" id="deputyEquipmentEngineerRequiredQualificationMarks" placeholder="<fmt:message key="driverCumConductor.required.qualification.marks.obtained"/>" name="requiredQualificationMarks" maxlength="5" min="1" max="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
     <div class="form-group">
        <label class="control-label col-sm-5" for="ownHeavyDrivingLicenseNumber"><fmt:message key="deputy.equipment.engineer.heavyDriveLicense"/>:<span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="ownHeavyDrivingLicenseNumber" id="deputyEquipmentEngineer-ownHeavyDrivingLicenseNumber-yes" value="1" type="radio" ${applicantPostAssoc.ownHeavyDrivingLicenseNumber ? 'checked' : ''}/>
                <label for="deputyEquipmentEngineer-ownHeavyDrivingLicenseNumber-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="ownHeavyDrivingLicenseNumber" id="deputyEquipmentEngineer-ownHeavyDrivingLicenseNumber-no" value="0" type="radio" ${applicantPostAssoc.ownHeavyDrivingLicenseNumber == false ? 'checked' : ''}/>
                <label for="deputyEquipmentEngineer-ownHeavyDrivingLicenseNumber-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
     <div class="form-group">
        <label class="control-label col-sm-5" for="deputyEquipmentEngineercomputerCourseCertification"><fmt:message key="machine.engineer.isMscIt"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline" >
                <input type="radio" name="mscitOrGaccc" value="1" class="form-control" id="deputyEquipmentEngineer-skComputerCourseCertification-yes" ${ applicantPostAssoc.mscitOrGaccc ? 'checked="checked"':''}  />
                <label for="deputyEquipmentEngineer-skComputerCourseCertification-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline" >
               	<input type="radio" name="mscitOrGaccc" value="0" class="form-control" id="deputyEquipmentEngineer-skComputerCourseCertification-no" ${ applicantPostAssoc.mscitOrGaccc == false ? 'checked="checked"':''}>
                <label for="deputyEquipmentEngineer-skComputerCourseCertification-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>


    <jsp:include page="../postFooter.jsp">
        <jsp:param name="isPostSubmitted" value="${ applicantPostAssoc.status eq 2 || applicantPostAssoc.status eq 3 }"/>
        <jsp:param name="formId" value="deputyEquipmentEngineerForm"/>
        <jsp:param name="postId" value="${post.postId}"/>
        <jsp:param name="disableFormAfterLastDateOver" value="${disableFormAfterLastDateOver}"/>
    </jsp:include>

</form>

<script>
    $(document).ready(function(){
    	 $("form[name='deputyEquipmentEngineerForm']").validate({
  		 	rules:{
  		 		automobileOrMechanicalEngDegree : "required",
  		 		ownHeavyDrivingLicenseNumber: "required",
  		 		mscitOrGaccc :"required",
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