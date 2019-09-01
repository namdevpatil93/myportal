<%@ include file="../../common/taglibs.jsp"%>


<script type="text/javascript">

$(document).ready(function() 
{
	postSelectionObj.disableFormFields ("fireWardenJuniorForm", '${applicantPostAssoc.status}');
	showSelectedOptions();
	postSelectionObj.bindPostForm("fireWardenJuniorForm");
	
	function showSelectedOptions()
	{
		if('${applicantPostAssoc.graduateFromAffiliatedInstitute}' == true || '${applicantPostAssoc.graduateFromAffiliatedInstitute}' == "true")
		{
			postSelectionObj.showElementsByClass('fireWardenJuniorDegreeNameToggle');
			postSelectionObj.showElementsByClass('fireWardenJuniorgraduateFromAffiliatedInstituteToggle');
		}
		else
		{
			postSelectionObj.hideElementsByClass('fireWardenJuniorDegreeNameToggle');
        	postSelectionObj.hideElementsByClass('fireWardenJuniorgraduateFromAffiliatedInstituteToggle');
		}
		
		if('${ applicantPostAssoc.fireSafetyDegreeFromAffiliatedInstitute}' == true || '${ applicantPostAssoc.fireSafetyDegreeFromAffiliatedInstitute}' == "true")
		{
			postSelectionObj.showElementsByClass('fireWardenJuniorfireSafetyDegreeToggle');
			postSelectionObj.showElementsByClass('fireWardenJuniorfireSafetyUniversityToggle');
		}
		else
		{
			postSelectionObj.hideElementsByClass('fireWardenJuniorfireSafetyDegreeToggle');
			postSelectionObj.hideElementsByClass('fireWardenJuniorfireSafetyUniversityToggle');
		}
		
		if('${ applicantPostAssoc.qualificationForMilitaryForce}' == true || '${ applicantPostAssoc.qualificationForMilitaryForce}' == "true")
		{
			postSelectionObj.showElementsByClass('fireWardenJuniorQualificationForMilitaryForceDegreeToggle');
			postSelectionObj.showElementsByClass('fireWardenJuniorQualificationForMilitaryForceUniversityToggle');
		}
		else
		{
			postSelectionObj.hideElementsByClass('fireWardenJuniorQualificationForMilitaryForceDegreeToggle');
			postSelectionObj.hideElementsByClass('fireWardenJuniorQualificationForMilitaryForceUniversityToggle');
		}
		
	}


	var lastDateOver = commonObj.isValidate(${disableFormAfterLastDateOver});
	commonObj.disableFormFields("fireWardenJuniorForm",lastDateOver);
	
});


	$( 'form#fireWardenJuniorForm' ).find('input[type=radio][name=graduateFromAffiliatedInstitute]').unbind().change(function() {
        if (this.value == '1') 
        {
        	$('#fireWardenJunior-DegreeName').attr("required", true);
        	$('#fireWardenJunior-UniversityName').attr("required", true);
       	 	postSelectionObj.showElementsByClass('fireWardenJuniorDegreeNameToggle');
       	 	postSelectionObj.showElementsByClass('fireWardenJuniorgraduateFromAffiliatedInstituteToggle');
       	 
        } 
        else 
        {
        	$('#fireWardenJunior-DegreeName').attr("required", false);
        	$('#fireWardenJunior-UniversityName').attr("required", false);
        	postSelectionObj.resetTextFieldById('fireWardenJunior-DegreeName');
        	postSelectionObj.resetTextFieldById('fireWardenJunior-UniversityName');
        	postSelectionObj.hideElementsByClass('fireWardenJuniorgraduateFromAffiliatedInstituteToggle');
        	postSelectionObj.hideElementsByClass('fireWardenJuniorDegreeNameToggle');
//        		postSelectionObj.notEligiblePopup();
        }
    });
	
	$( 'form#fireWardenJuniorForm' ).find('input[type=radio][name=fireSafetyDegreeFromAffiliatedInstitute]').unbind().change(function() {
        if (this.value == '1') 
        {
//         	$('#fireWardenJunior-fireSafetyDegreeName').attr("required", true);
//         	$('#fireWardenJunior-fireSafetyUniversityName').attr("required", true);
        	jQuery("#fireWardenJuniorForm").validate().settings.ignore = "";
       	 	postSelectionObj.showElementsByClass('fireWardenJuniorfireSafetyDegreeToggle');
       	 	postSelectionObj.showElementsByClass('fireWardenJuniorfireSafetyUniversityToggle');
       	 	$(this).parent().parent().find(".help-block").html("");
         	$(this).parent().parent().parent().removeClass( 'has-error has-danger' );
         	$('#qualificationForMilitaryForceError').html("");
       	 	$('#qualificationForMilitaryForceError').parent().parent().removeClass( 'has-error has-danger' );
       	 	jQuery("#fireWardenJuniorForm").find('#saveAsDraftBtn').removeAttr('disabled');
         	jQuery("#fireWardenJuniorForm").find('#saveBtn').removeAttr('disabled');
        } 
        else 
        {
//         	$('#fireWardenJunior-fireSafetyDegreeName').attr("required", false);
//         	$('#fireWardenJunior-fireSafetyUniversityName').attr("required", false);
        	jQuery("#fireWardenJuniorForm").validate().settings.ignore = "#fireWardenJunior-fireSafetyDegreeName, #fireWardenJunior-fireSafetyUniversityName";
        	postSelectionObj.resetTextFieldById('fireWardenJunior-fireSafetyDegreeName');
        	postSelectionObj.resetTextFieldById('fireWardenJunior-fireSafetyUniversityName');
        	postSelectionObj.hideElementsByClass('fireWardenJuniorfireSafetyDegreeToggle');
        	postSelectionObj.hideElementsByClass('fireWardenJuniorfireSafetyUniversityToggle');
        	if($( 'form#fireWardenJuniorForm' ).find('input[type=radio][id=fireWardenJunior-qualificationForMilitaryForce-no]').is(":checked")){
            	$(this).parent().parent().find(".help-block").html(jQuery("#notEligibleForPost").val());
                $(this).parent().parent().parent().addClass( 'has-error' );
                jQuery("#fireWardenJuniorForm").find('#saveAsDraftBtn').attr('disabled','disabled');
                jQuery("#fireWardenJuniorForm").find('#saveBtn').attr('disabled','disabled');
            } else {
                $(this).parent().parent().find(".help-block").html("");
                $(this).parent().parent().parent().removeClass( 'has-error has-danger' );
                jQuery("#fireWardenJuniorForm").find('#saveAsDraftBtn').removeAttr('disabled');
                jQuery("#fireWardenJuniorForm").find('#saveBtn').removeAttr('disabled');
            }
//        		postSelectionObj.notEligiblePopup();
        }
    });
	
	$( 'form#fireWardenJuniorForm' ).find('input[type=radio][name=qualificationForMilitaryForce]').unbind().change(function() {
        if (this.value == '1') 
        {
        	$('#fireWardenJunior-qualificationForMilitaryForceDegreeName').attr("required", true);
        	$('#fireWardenJunior-qualificationForMilitaryForceUniversityName').attr("required", true);
       	 	postSelectionObj.showElementsByClass('fireWardenJuniorQualificationForMilitaryForceDegreeToggle');
       	 	postSelectionObj.showElementsByClass('fireWardenJuniorQualificationForMilitaryForceUniversityToggle');
       	 	$(this).parent().parent().find(".help-block").html("");
         	$(this).parent().parent().parent().removeClass( 'has-error has-danger' );
         	$('#fireSafetyDegreeFromAffiliatedInstituteError').html("");
       	 	$('#fireSafetyDegreeFromAffiliatedInstituteError').parent().parent().removeClass( 'has-error has-danger' );
       	 	jQuery("#fireWardenJuniorForm").find('#saveAsDraftBtn').removeAttr('disabled');
         	jQuery("#fireWardenJuniorForm").find('#saveBtn').removeAttr('disabled');
        } 
        else 
        {
            jQuery("#fireWardenJuniorForm").validate().settings.ignore = "#fireWardenJunior-qualificationForMilitaryForceDegreeName, #fireWardenJunior-qualificationForMilitaryForceUniversityName";
        	$('#fireWardenJunior-qualificationForMilitaryForceDegreeName').attr("required", false);
        	$('#fireWardenJunior-qualificationForMilitaryForceUniversityName').attr("required", false);
        	$("#fireWardenJunior-qualificationForMilitaryForceUniversityName").parent().find('label.error').empty();
        	$("#fireWardenJunior-qualificationForMilitaryForceDegreeName").parent().find('label.error').empty();
        	postSelectionObj.resetTextFieldById('fireWardenJunior-qualificationForMilitaryForceDegreeName');
        	postSelectionObj.resetTextFieldById('fireWardenJunior-qualificationForMilitaryForceUniversityName');
        	postSelectionObj.hideElementsByClass('fireWardenJuniorQualificationForMilitaryForceDegreeToggle');
        	postSelectionObj.hideElementsByClass('fireWardenJuniorQualificationForMilitaryForceUniversityToggle');
        	if($( 'form#fireWardenJuniorForm' ).find('input[type=radio][id=fireWardenJunior-fireSafetyDegreeFromAffiliatedInstitute-no]').is(":checked")){
            	$(this).parent().parent().find(".help-block").html(jQuery("#notEligibleForPost").val());
                $(this).parent().parent().parent().addClass( 'has-error' );
                jQuery("#fireWardenJuniorForm").find('#saveAsDraftBtn').attr('disabled','disabled');
                jQuery("#fireWardenJuniorForm").find('#saveBtn').attr('disabled','disabled');
            } else {
                $(this).parent().parent().find(".help-block").html("");
                $(this).parent().parent().parent().removeClass( 'has-error has-danger' );
                jQuery("#fireWardenJuniorForm").find('#saveAsDraftBtn').removeAttr('disabled');
             	jQuery("#fireWardenJuniorForm").find('#saveBtn').removeAttr('disabled');
            }
//        		postSelectionObj.notEligiblePopup();
        }
    });
	/*
	function showEligibilityCriteriaPDF() {
		var url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/viewPdf.pdf'/>";
		window.open(url,'_blank');
	}*/
</script>   
 <c:if test="${ !formReadOnly }">
	<div class="form-group">
	   <div class="pull-right">
            <a href="javascript:void(0);" onclick="javascript:showEligibilityCriteriaPDF(${post.postId})"><b><fmt:message key="postEligibilityCriteriaLink"/></b></a><br>
	       <a href="javascript:void(0);" data-toggle="modal" data-target="#fireWardenJuniorPopup"><b><fmt:message key="physicaltest"/></b></a>
	   </div>
	</div>
</c:if>
<form class="form-horizontal" name="fireWardenJuniorForm" id="fireWardenJuniorForm" action="<c:url value='/applicant?operation=saveApplicantPostDetails'/>" method="POST" style="z-index:0;">

	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="hidden" name="id" value="${applicantPostAssoc.id}"/>
	<input type="hidden" name="postId" value="${post.postId}"/>
	<input type="hidden" name="status" id="status"  value="${ applicantPostAssoc.status }"/>

	<div class="form-group">
		<label class="control-label col-sm-5"><fmt:message key="fireWardenJunior.graduateFromAffiliatedInstitute"/>: <span class="red">*</span></label>
		<div class="col-sm-4">
			<div class="radio radio-inline">
				<input name="graduateFromAffiliatedInstitute" ${ applicantPostAssoc.graduateFromAffiliatedInstitute ? 'checked="checked"':''} id="fireWardenJunior-graduateFromAffiliatedInstitute-yes" value="1" type="radio" />
				<label for="fireWardenJunior-graduateFromAffiliatedInstitute-yes"> <fmt:message key="yes"/> </label>
			</div>
			<div class="radio radio-inline">
				<input class="radiosToCheck" name="graduateFromAffiliatedInstitute" ${ applicantPostAssoc.graduateFromAffiliatedInstitute == false ? 'checked="checked"':''} id="fireWardenJunior-graduateFromAffiliatedInstitute-no" value="0" type="radio" />
				<label for="fireWardenJunior-graduateFromAffiliatedInstitute-no"> <fmt:message key="no"/> </label>
			</div>
			<div class="help-block with-errors"></div>
		</div>
	</div>
	
	<div class="form-group fireWardenJuniorDegreeNameToggle">
        <label class="control-label col-sm-5" for="degreeName"><fmt:message key="fireWardenJunior.degreeName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.degreeName}" type="text" class="form-control" id="fireWardenJunior-DegreeName" placeholder="<fmt:message key="fireWardenJunior.degreeName"/>" name="degreeName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
	
	<div class="form-group fireWardenJuniorgraduateFromAffiliatedInstituteToggle">
        <label class="control-label col-sm-5" for="graduateFromAffiliatedInstituteUniversityName"><fmt:message key="fireWardenJunior.universityName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.universityName}" type="text" class="form-control" id="fireWardenJunior-UniversityName" placeholder="<fmt:message key="fireWardenJunior.universityName"/>" name="universityName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
   
<!--    fire and safety degre -->

	<div class="form-group">
		<label class="control-label col-sm-5"><fmt:message key="fireWardenJunior.fireSafetyDegreeFromAffiliatedInstitute"/>: <span class="red">*</span></label>
		<div class="col-sm-4">
			<div class="radio radio-inline">
				<input name="fireSafetyDegreeFromAffiliatedInstitute" ${ applicantPostAssoc.fireSafetyDegreeFromAffiliatedInstitute ? 'checked="checked"':''} id="fireWardenJunior-fireSafetyDegreeFromAffiliatedInstitute-yes" value="1" type="radio" />
				<label for="fireWardenJunior-fireSafetyDegreeFromAffiliatedInstitute-yes"> <fmt:message key="yes"/> </label>
			</div>
			<div class="radio radio-inline">
				<input name="fireSafetyDegreeFromAffiliatedInstitute" ${applicantPostAssoc.fireSafetyDegreeFromAffiliatedInstitute == false ? 'checked="checked"':''} id="fireWardenJunior-fireSafetyDegreeFromAffiliatedInstitute-no" value="0" type="radio" />
				<label for="fireWardenJunior-fireSafetyDegreeFromAffiliatedInstitute-no"> <fmt:message key="no"/> </label>
			</div>
			<div id="fireSafetyDegreeFromAffiliatedInstituteError" class="help-block with-errors"></div>
		</div>
	</div>
	
	<div class="form-group fireWardenJuniorfireSafetyDegreeToggle">
        <label class="control-label col-sm-5" for="fireAndSafetyDegreeName"><fmt:message key="fireWardenJunior.diplomaName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.fireAndSafetyDegreeName}" type="text" class="form-control" id="fireWardenJunior-fireSafetyDegreeName" placeholder="<fmt:message key="fireWardenJunior.diplomaName"/>" name="fireAndSafetyDegreeName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
	
	<div class="form-group fireWardenJuniorfireSafetyUniversityToggle">
        <label class="control-label col-sm-5" for="fireSafetyUniversityName"><fmt:message key="fireWardenJunior.universityName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.fireAndSafetyUniversityName}" type="text" class="form-control" id="fireWardenJunior-fireSafetyUniversityName" placeholder="<fmt:message key="fireWardenJunior.universityName"/>" name="fireAndSafetyUniversityName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
   
<!--    Qualification similar to military force -->
	 <div class="form-group">
        <label class="control-label col-sm-5" for="computerCourseCertification"><fmt:message key="draftsman.diploma.certification.in.autocad"/></label>
        <div class="col-sm-4">
            <div class="radio radio-inline" id="computerCourseCertification-yes-id">
            </div>
            <div class="radio radio-inline" id="computerCourseCertification-no-id">
               	
            </div>
        </div>
     </div>
	
	<div class="form-group">
		<label class="control-label col-sm-5"><fmt:message key="fireWardenJunior.qualificationForMilitaryForce"/>: <span class="red">*</span></label>
		<div class="col-sm-4">
			<div class="radio radio-inline">
				<input name="qualificationForMilitaryForce" ${ applicantPostAssoc.qualificationForMilitaryForce ? 'checked="checked"':''} id="fireWardenJunior-qualificationForMilitaryForce-yes" value="1" type="radio" />
				<label for="fireWardenJunior-qualificationForMilitaryForce-yes"> <fmt:message key="yes"/> </label>
			</div>
			<div class="radio radio-inline">
				<input name="qualificationForMilitaryForce" ${applicantPostAssoc.qualificationForMilitaryForce == false ? 'checked="checked"':''} id="fireWardenJunior-qualificationForMilitaryForce-no" value="0" type="radio" />
				<label for="fireWardenJunior-qualificationForMilitaryForce-no"> <fmt:message key="no"/> </label>
			</div>
			<div id="qualificationForMilitaryForceError" class="help-block with-errors"></div>
		</div>
	</div>
	
	<div class="form-group fireWardenJuniorQualificationForMilitaryForceDegreeToggle">
        <label class="control-label col-sm-5" for="qualificationForMilitaryForceDegree"><fmt:message key="fireWardenJunior.degreeName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.miltaryForceDegreeName}" type="text" class="form-control" id="fireWardenJunior-qualificationForMilitaryForceDegreeName" placeholder="<fmt:message key="fireWardenJunior.degreeName"/>" name="miltaryForceDegreeName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
	
	<div class="form-group fireWardenJuniorQualificationForMilitaryForceUniversityToggle">
        <label class="control-label col-sm-5" for="QualificationForMilitaryForceUniversityName"><fmt:message key="fireWardenJunior.universityName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.miltaryForceUniversityName}" type="text" class="form-control" id="fireWardenJunior-qualificationForMilitaryForceUniversityName" placeholder="<fmt:message key="fireWardenJunior.universityName"/>" name="miltaryForceUniversityName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
	
	
	<div class="form-group">
		<label class="control-label col-sm-5"><fmt:message key="fireWardenJunior.heightWithinRange"/>: <span class="red">*</span></label>
		<div class="col-sm-4">
			<div class="radio radio-inline">
				<input name="heightWithinRange" ${ applicantPostAssoc.heightWithinRange ? 'checked="checked"':''} id="fireWardenJunior-heightWithinRange-yes" value="1" type="radio" />
				<label for="fireWardenJunior-heightWithinRange-yes"> <fmt:message key="yes"/> </label>
			</div>
			<div class="radio radio-inline">
				<input class="radiosToCheck" name="heightWithinRange" ${ applicantPostAssoc.heightWithinRange == false ? 'checked="checked"':''} id="fireWardenJunior-heightWithinRange-no" value="0" type="radio" />
				<label for="fireWardenJunior-heightWithinRange-no"> <fmt:message key="no"/> </label>
			</div>
			<div class="help-block with-errors"></div>
		</div>
	</div>
	
	
	<jsp:include page="postFooter.jsp">
		<jsp:param name="isPostSubmitted" value="${ applicantPostAssoc.status eq 2 || applicantPostAssoc.status eq 3 }"/>
		<jsp:param name="formId" value="fireWardenJuniorForm"/>
		<jsp:param name="postId" value="${post.postId}"/>
		<jsp:param name="disableFormAfterLastDateOver" value="${disableFormAfterLastDateOver}"/>
	</jsp:include>
	
	<jsp:include page="eligibilityCriterias/fireWardenJuniorEligibility.jsp"/>
</form>


<script>
 $(document).ready(function(){
 $("form[name='fireWardenJuniorForm']").validate({
 	rules:{
 		 graduateFromAffiliatedInstitute : "required",
 		 degreeName: {required: true},
 		 universityName: {required: true},
 		 heightWithinRange : "required",
 		 qualificationForMilitaryForce : "required",
 		 //miltaryForceDegreeName: {required: true},
 		 //miltaryForceUniversityName: {required: true},
 		 fireSafetyDegreeFromAffiliatedInstitute : "required",
 		 fireAndSafetyDegreeName: {required: true},
 		 fireAndSafetyUniversityName: {required: true}		 
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