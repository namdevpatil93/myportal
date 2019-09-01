<%@ include file="../../../common/taglibs.jsp"%>

<script>
    jQuery(document).ready(function() {
    
    	postSelectionObj.disableFormFields ("departmentalAccountsOfficerForm", '${applicantPostAssoc.status}');
    	postSelectionObj.bindPostForm("departmentalAccountsOfficerForm");
		var lastDateOver = commonObj.isValidate(${applicantPostAssoc.disableForm});
    	   commonObj.disableFormFields("departmentalAccountsOfficerForm",lastDateOver);
    	
    	   if('${applicantPostAssoc.bcomPassed}' == true || '${applicantPostAssoc.bcomPassed}' == "true")
   		{
   			postSelectionObj.showElementsByClass('departmentalAccountsOfficerdegreeInCommerceToggle');
   			postSelectionObj.showElementsByClass('departmentalAccountsOfficerDegreeNameToggle');
   			postSelectionObj.showElementsByClass('departmentalAccountsOfficerRequiredQualificationMarksToggle');
   		}
   		else
   		{
   			postSelectionObj.hideElementsByClass('departmentalAccountsOfficerdegreeInCommerceToggle');
   			postSelectionObj.hideElementsByClass('departmentalAccountsOfficerDegreeNameToggle');
   			postSelectionObj.hideElementsByClass('departmentalAccountsOfficerRequiredQualificationMarksToggle');
   		}
    });
    
    $( 'form#departmentalAccountsOfficerForm' ).find('input[type=radio][name=bcomPassed]').unbind().change(function() {
    	var age = ${applicantAgeInYears};
    	var locomotive = $("input[name='locomotorOrCerebralPalsy']:checked").val();
        if (this.value == '1') {
       	 jQuery("#departmentalAccountsOfficerForm").validate().settings.ignore = "";
       	 postSelectionObj.showElementsByClass('departmentalAccountsOfficerdegreeInCommerceToggle');
       	 postSelectionObj.showElementsByClass('departmentalAccountsOfficerDegreeNameToggle');
       	 postSelectionObj.showElementsByClass('departmentalAccountsOfficerRequiredQualificationMarksToggle');
       	 	if(locomotive == 1)
       	 	{
       			if(age >= 45){
					jQuery("#departmentalAccountsOfficerForm").find('#saveAsDraftBtn').attr('disabled','disabled');
					jQuery("#departmentalAccountsOfficerForm").find('#saveBtn').attr('disabled','disabled');
		 		}
       			else{
 			   		postSelectionObj.hideElementsByClass('alert-danger');
 			   	jQuery("#departmentalAccountsOfficerForm").find('#saveAsDraftBtn').attr('disabled',false);
				jQuery("#departmentalAccountsOfficerForm").find('#saveBtn').attr('disabled',false);
 		   		}
       	 	}else{
       	 	jQuery("#departmentalAccountsOfficerForm").find('#saveAsDraftBtn').attr('disabled',false);
			jQuery("#departmentalAccountsOfficerForm").find('#saveBtn').attr('disabled',false);
       	 	}
        } else {
       	// jQuery("#departmentalAccountsOfficerForm").validate().settings.ignore = "#departmentalAccountsOfficerUniversityName";
       	postSelectionObj.resetTextFieldById('departmentalAccountsOfficerUniversityName');
       	postSelectionObj.resetTextFieldById('departmentalAccountsOfficerDegreeName');
       	postSelectionObj.resetTextFieldById('departmentalAccountsOfficerRequiredQualificationMarks');
       	postSelectionObj.hideElementsByClass('departmentalAccountsOfficerdegreeInCommerceToggle');
       	postSelectionObj.hideElementsByClass('departmentalAccountsOfficerDegreeNameToggle');
       	postSelectionObj.hideElementsByClass('departmentalAccountsOfficerRequiredQualificationMarksToggle');
       	 
        }
    });
    
$( 'form#departmentalAccountsOfficerForm' ).find('input[type=radio][name=mscitOrGaccc]').unbind().change(function() {
    	
    	if(this.value == '0'){
    		 commonObj.showAgreeDisAgreePopup("<fmt:message key='mscit.equivalent.computer.certificate.alert' />", mscitCertificatePopUpDepartmentalAccountsOfficer, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
    	     
    	}
    });
    
    function mscitCertificatePopUpDepartmentalAccountsOfficer(flag)
    {
    	if(!flag)
    	{
    		$('#departmentalAccountsOfficer-skComputerCourseCertification-yes').prop('checked', true);
      	}
    }
    
</script>

<div id="downloadEligibilityCriteria" class="form-group" align="right">
    <div class="col-sm-12" align="pull-right">
        <a href="javascript:void(0);" onclick="javascript:showEligibilityCriteriaPDF(${post.postId})"><b><fmt:message key="postEligibilityCriteriaLink"/></b></a>
    </div>
</div>

<form class="form-horizontal" name="departmentalAccountsOfficerForm" id="departmentalAccountsOfficerForm" 
		action="<c:url value='/applicant?operation=saveApplicantPostDetails'/>" method="POST">

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${applicantPostAssoc.id}"/>
    <input type="hidden" name="postId" value="${post.postId}"/>
    <input type="hidden" name="status" id="status"  value="${ applicantPostAssoc.status }"/>
	
	<div class="form-group">
        <label class="control-label col-sm-5" for="bcomPassed"><fmt:message key="departmentalAccountsOfficer.degreeInCommerceFromRecognizedUniversity"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="bcomPassed" id="departmentalAccountsOfficer-degreeInCommerce-yes" value="1" type="radio" ${applicantPostAssoc.bcomPassed ? 'checked' : ''} />
                <label for="departmentalAccountsOfficer-degreeInCommerce-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="bcomPassed" id="departmentalAccountsOfficer-degreeInCommerce-no" value="0" type="radio" ${applicantPostAssoc.bcomPassed == false ? 'checked' : ''} />
                <label for="departmentalAccountsOfficer-degreeInCommerce-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>

    	<div class="form-group departmentalAccountsOfficerDegreeNameToggle">
        	<label class="control-label col-sm-5" for="departmentalAccountsOfficerDegreeName"><fmt:message key="departmentalAccountsOfficer.degreeName"/>: <span class="red">*</span></label>
        	<div class="col-sm-4">
            	<input value="${applicantPostAssoc.degreeName}" name= "degreeName" type="text" class="form-control" id="departmentalAccountsOfficerDegreeName" placeholder="<fmt:message key="departmentalAccountsOfficer.degreeName"/>" name="degreeName" maxlength="50">
            	<div class="help-block with-errors"></div>
        	</div>
    	</div>
    	
        <div class="form-group departmentalAccountsOfficerdegreeInCommerceToggle">
        	<label class="control-label col-sm-5" for="departmentalAccountsOfficerUniversityName"><fmt:message key="departmentalAccountsOfficer.universityName"/>: <span class="red">*</span></label>
        	<div class="col-sm-4">
            	<input value="${applicantPostAssoc.universityName}" name= "universityName" type="text" class="form-control" id="departmentalAccountsOfficerUniversityName" placeholder="<fmt:message key="departmentalAccountsOfficer.universityName"/>" name="universityName" maxlength="50">
            	<div class="help-block with-errors"></div>
        	</div>
    	</div>
    	
    	<div class="form-group departmentalAccountsOfficerRequiredQualificationMarksToggle">
        	<label class="control-label col-sm-5" for="departmentalAccountsOfficerRequiredQualificationMarks"><fmt:message key="departmentalAccountsOfficer.marks"/>%:<span class="red">*</span></label>
        	<div class="col-sm-4">
            	<input value="${applicantPostAssoc.requiredQualificationMarks}" name= "requiredQualificationMarks" type="number" class="form-control" id="departmentalAccountsOfficerRequiredQualificationMarks" placeholder="<fmt:message key="departmentalAccountsOfficer.marks"/>" name="requiredQualificationMarks" maxlength="50">
            	<div class="help-block with-errors"></div>
        	</div>
    	</div>
  	
  	   <div class="form-group">
        <label class="control-label col-sm-5" for="departmentalAccountsOfficercomputerCourseCertification"><fmt:message key="machine.engineer.isMscIt"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline" >
                <input type="radio" name="mscitOrGaccc" value="1" class="form-control" id="departmentalAccountsOfficer-skComputerCourseCertification-yes" ${ applicantPostAssoc.mscitOrGaccc ? 'checked="checked"':''}  />
                <label for="departmentalAccountsOfficer-skComputerCourseCertification-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline" >
               	<input type="radio"  name="mscitOrGaccc" value="0" class="form-control" id="departmentalAccountsOfficer-skComputerCourseCertification-no" ${ applicantPostAssoc.mscitOrGaccc == false ? 'checked="checked"':''}>
                <label for="departmentalAccountsOfficer-skComputerCourseCertification-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <jsp:include page="../postFooter.jsp">
        <jsp:param name="isPostSubmitted" value="${ applicantPostAssoc.status eq 2 || applicantPostAssoc.status eq 3 }"/>
        <jsp:param name="formId" value="departmentalAccountsOfficerForm"/>
        <jsp:param name="postId" value="${post.postId}"/>
        <jsp:param name="disableFormAfterLastDateOver" value="${disableFormAfterLastDateOver}"/>
    </jsp:include>

</form>

<script>
    $(document).ready(function(){
    	$("form[name='departmentalAccountsOfficerForm']").validate({
    	 	rules:{
    	 		bcomPassed : "required",
    	 		mscitOrGaccc : "required",
    	 		universityName: {required: true},
    	 		degreeName: {required: true},
    	 		requiredQualificationMarks: {required: true,min:35, max:100}
    	 		
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