<%@ include file="../../common/taglibs.jsp"%>

<script>
jQuery(document).ready(function() {
	
	postSelectionObj.disableFormFields ("clerkTypistJuniorForm", '${applicantPostAssoc.status}');
    postSelectionObj.bindPostForm("clerkTypistJuniorForm");
	
   	//postSelectionObj.hideElementsByClass('experiencedToggle');
	//postSelectionObj.hideElementsByClass('clerkTypistJuniorDifferentlyAbledToggle');
	checkIfShowOrHideElements();

	differentlyAbledOthersAction();
	
	var lastDateOver = commonObj.isValidate(${disableFormAfterLastDateOver});
    commonObj.disableFormFields("clerkTypistJuniorForm",lastDateOver);
	
});
   // ----------------------------- differentlyAbledOthersAction -------------------------
	$('#clerkTypistJunior-differentlyAbled-others').click(differentlyAbledOthersAction);
	
	function differentlyAbledOthersAction()
	{
		if(jQuery('input[id=clerkTypistJunior-differentlyAbled-others]').is(':checked')) {
			$("#clerkTypistJunior-differentlyAbled-others-text").show();
			resetFieldsAndAttributes(['clerkTypistJunior-differentlyAbled-others-text'], true);
		 }else if(!jQuery('input[id=clerkTypistJunior-differentlyAbled-others]').is(':checked')){
			$("#clerkTypistJunior-differentlyAbled-others-text").hide();
			$("#clerkTypistJunior-differentlyAbled-others-text").parent().find('label.error').empty();
			resetFieldsAndAttributes(['clerkTypistJunior-differentlyAbled-others-text'], false);
		 }else
		  {
			 $("#clerkTypistJunior-differentlyAbled-others-text").hide();
			 resetFieldsAndAttributes(['clerkTypistJunior-differentlyAbled-others-text'], false);
		  }
	}
	function resetFieldsAndAttributes(idArr, flag)
	{
		for (i=0; i<idArr.length; i++){
			if(flag)
	  	  		$('#'+idArr[i]+'').prop('required', flag);
	  		else{
	  			postSelectionObj.resetTextFieldById(idArr[i]);
	  			$('#'+idArr[i]+'').prop('required', flag);
	  	  	}
		 }
	}
   // ----------------------------------------------------------------
   
function checkIfShowOrHideElements() {
	if ('${applicantPostAssoc.graduateFromAffiliatedInstitute}' == ''||'${applicantPostAssoc.graduateFromAffiliatedInstitute}' == 'false') {
		postSelectionObj.hideElementsByClass('graduateFromAffiliatedInstituteToggle');
	}
	
	if ('${applicantPostAssoc.experienced}' == '' ||'${applicantPostAssoc.experienced}' == 'false') {
		 $("#clerkTypistJunior-companyName").parent().parent().find("label.error").html("");
		 $("#clerkTypistJunior-totalExperienceInYears").parent().parent().find("label.error").html("");
// 		 jQuery("#clerkTypistJuniorForm").validate().settings.ignore = "";
		postSelectionObj.hideElementsByClass('experiencedToggle');
	}
// 	else
// 	{
// 		jQuery("#clerkTypistJuniorForm").validate().settings.ignore = "#";
// 	}
	
	if ('${applicantPostAssoc.differentlyAbled}' == ''||'${applicantPostAssoc.differentlyAbled}' == 'false') {
		postSelectionObj.hideElementsByClass('clerkTypistJuniorDifferentlyAbledToggle');
		$("#clerkTypistJunior-differentlyAbled-yes").parent().parent().find('.help-block').empty();
	}
	
	actionOnCheckBoxSelected();
}

$( 'form#clerkTypistJuniorForm' ).find('input[type=radio][name=graduateFromAffiliatedInstitute]').unbind().change(function() {
    if (this.value == '1') {
    	$('#clerkTypist-graduatesFromAffiliatedInstitute-degreeName').attr("required", true);
    	$('#clerkTypist-graduatesFromAffiliatedInstitute-universityName').attr("required", true);
   	 postSelectionObj.showElementsByClass('graduateFromAffiliatedInstituteToggle');
    } else {
    	$('#clerkTypist-graduatesFromAffiliatedInstitute-degreeName').attr("required", false);
    	$('#clerkTypist-graduatesFromAffiliatedInstitute-universityName').attr("required", false);
   	 postSelectionObj.hideElementsByClass('graduateFromAffiliatedInstituteToggle');
   	 postSelectionObj.resetTextFieldById('clerkTypist-graduatesFromAffiliatedInstitute-degreeName');
   	 postSelectionObj.resetTextFieldById('clerkTypist-graduatesFromAffiliatedInstitute-universityName');
    }
});
$( 'form#clerkTypistJuniorForm' ).find('input[type=radio][name=experienced]').unbind().change(function() {
    if (this.value == '1') {
//     	$('#clerkTypistJunior-companyName').attr("required", true);
//     	$('#clerkTypistJunior-totalExperienceInYears').attr("required", true);
//     	$('#clerkTypistJunior-TotalExperienceInMonths').attr("required", true);
   	 postSelectionObj.showElementsByClass('experiencedToggle');
    } else {
//     	$('#clerkTypistJunior-companyName').attr("required", false);
//     	$('#clerkTypistJunior-totalExperienceInYears').attr("required", false);
//     	$('#clerkTypistJunior-TotalExperienceInMonths').attr("required", false);
		 $("#clerkTypistJunior-companyName").parent().parent().find("label.error").html("");
		 $("#clerkTypistJunior-totalExperienceInYears").parent().parent().find("label.error").html("");
	   	 postSelectionObj.hideElementsByClass('experiencedToggle');
	   	 postSelectionObj.resetTextFieldById('clerkTypistJunior-companyName');
	   	 postSelectionObj.resetTextFieldById('clerkTypistJunior-totalExperienceInYears');
	   	 postSelectionObj.resetTextFieldById('clerkTypistJunior-TotalExperienceInMonths');
    }
});

$( 'form#clerkTypistJuniorForm' ).find('input[type=radio][name=differentlyAbled]').unbind().change(function() {
    if (this.value == '1') {
//     	jQuery("#clerkTypistJuniorForm").validate().settings.ignore = "";
//     	requiredDifferentlyAbledChilds(true);
   	 	postSelectionObj.showElementsByClass('clerkTypistJuniorDifferentlyAbledToggle');
   	 if('${applicantPostAssoc.ageValid}'=='true'){
  		 $('#clerkTypistJuniorFormContainerDiv').show();
  		 $( 'form#clerkTypistJuniorForm' ).find('#saveBtn').show();
  		 $( 'form#clerkTypistJuniorForm' ).find('#saveAsDraftBtn').show();
  		 //$('#saveBtn').show();
  		 //$('#saveAsDraftBtn').show();
  	 }else{
  		commonObj.showAlert("<fmt:message key="ageValidationError" />");
  		$('#clerkTypistJuniorFormContainerDiv').hide();
  		$( 'form#clerkTypistJuniorForm' ).find('#saveBtn').hide();
  		$( 'form#clerkTypistJuniorForm' ).find('#saveAsDraftBtn').hide();
  		//$('#saveBtn').hide();
  		//$('#saveAsDraftBtn').hide();
  	 }
    } else {
//     	 jQuery("#clerkTypistJuniorForm").validate().settings.ignore = "#clerkTypistJunior-differentlyAbled-blindnessAndLowVision, #clerkTypistJunior-differentlyAbled-deafAndMute, #clerkTypistJunior-differentlyAbled-locomotorOrCerebralPalsy";
	   	 $("#clerkTypistJunior-differentlyAbled-yes").parent().parent().find('.help-block').empty();
	   	 postSelectionObj.hideElementsByClass('clerkTypistJuniorDifferentlyAbledToggle');
	   	 postSelectionObj.resetCheckBoxById('clerkTypistJunior-differentlyAbled-blindnessAndLowVision');
	   	 postSelectionObj.resetCheckBoxById('clerkTypistJunior-differentlyAbled-deafAndMute');
	   	 postSelectionObj.resetCheckBoxById('clerkTypistJunior-differentlyAbled-locomotorOrCerebralPalsy');
	   	
	   	 postSelectionObj.resetCheckBoxById('clerkTypistJunior-differentlyAbled-others');
	   	 postSelectionObj.resetTextFieldById('clerkTypistJunior-differentlyAbled-others-text');
	   	 postSelectionObj.hideElementsByClass('differentlyAbled-others-text');
	   	if('${applicantPostAssoc.ageInvalid}'=='true'){
    		 $('#clerkTypistJuniorFormContainerDiv').show();
    		 $( 'form#clerkTypistJuniorForm' ).find('#saveBtn').show();
       		 $( 'form#clerkTypistJuniorForm' ).find('#saveAsDraftBtn').show();
    		 //$('#saveBtn').show();
    		 //$('#saveAsDraftBtn').show();
    	 }else{
    		commonObj.showAlert("<fmt:message key="ageValidationError" />");
    		$('#clerkTypistJuniorFormContainerDiv').hide();
    		$( 'form#clerkTypistJuniorForm' ).find('#saveBtn').hide();
      		$( 'form#clerkTypistJuniorForm' ).find('#saveAsDraftBtn').hide();
    		//$('#saveBtn').hide();
    		//$('#saveAsDraftBtn').hide();
    	 }
//    	requiredDifferentlyAbledChilds(false);
    }
});

$( '.clerkTypistJuniorDifferentlyAbledToggle' ).find('input').click(function() {
	actionOnCheckBoxSelected();
});

function actionOnCheckBoxSelected() {
	var total = $( '.clerkTypistJuniorDifferentlyAbledToggle' ).find('input:checked').length;
	if (total > 0) {
		$("#clerkTypistJunior-differentlyAbled-yes").parent().parent().find('.help-block').empty();
  		requiredDifferentlyAbledChilds(false);
  		$("#clerkTypistJunior-differentlyAbled-yes").parent().parent().find('.help-block').empty();
  	} else {
  		requiredDifferentlyAbledChilds(true);
  	}
}

function requiredDifferentlyAbledChilds(flag) {
 	$( '.clerkTypistJuniorDifferentlyAbledToggle' ).find('input').prop('required', flag);
}

function checkExperienceClerkTypist()
{
	var val=0;
	$(".experiencedToggle").find('.telToCheck').each(function(){
		if(this.value == "")
		{
			val = -1;
		}
		else
		{
			val = val + this.value;
		}
	});	 
	if(val == 0)
	{
		$(".experiencedToggle").find('.telToCheck').parent().addClass('has-error');
		return true;
	}
	else
	{
		$(".experiencedToggle").find('.telToCheck').parent().removeClass( 'has-error has-danger' );
		return false;
	}
}

$('#clerkTypistJunior-differentlyAbled-blindnessAndLowVision').click(function(){
	  if(jQuery('input[id=clerkTypistJunior-differentlyAbled-blindnessAndLowVision]').is(':checked')){
			$('#ctjda').val("");
			$('#ctjda').val("1");
			//commonObj.showAgreeDisAgreePopup("<b> <fmt:message key='assistantJunior.differentlyAbled.blindnessAndLowVision' />:</b>  <fmt:message key='clerktypist.junior.differentlyAbled.blindnessAndLowVision.popup.msg' />", clerkTypistJuniorDifferentlyAbledAction, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
			commonObj.showAgreeDisAgreePopup("<fmt:message key='clerktypist.junior.differentlyAbled.common.popup.msg' />", clerkTypistJuniorDifferentlyAbledAction, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
	    }else{
	    	$('#ctjda').val("");
	    	checkboxFlag(false);
		}	
	});
$('#clerkTypistJunior-differentlyAbled-deafAndMute').click(function(){
	   if(jQuery('input[id=clerkTypistJunior-differentlyAbled-deafAndMute]').is(':checked')){
			$('#ctjda').val("");
			$('#ctjda').val("2");
			//commonObj.showAgreeDisAgreePopup("<b> <fmt:message key='assistantJunior.differentlyAbled.deafAndMute' />:</b>  <fmt:message key='clerktypist.junior.differentlyAbled.deafAndMute.popup.msg' />", clerkTypistJuniorDifferentlyAbledAction, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
			commonObj.showAgreeDisAgreePopup("<fmt:message key='clerktypist.junior.differentlyAbled.common.popup.msg' />", clerkTypistJuniorDifferentlyAbledAction, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
	    }else{
	    	$('#ctjda').val("");
	    	checkboxFlag(false);
		}
	});
$('#clerkTypistJunior-differentlyAbled-locomotorOrCerebralPalsy').click(function(){
		if(jQuery('input[id=clerkTypistJunior-differentlyAbled-locomotorOrCerebralPalsy]').is(':checked')){
			$('#ctjda').val("");
			$('#ctjda').val("3");
			//commonObj.showAgreeDisAgreePopup("<b> <fmt:message key='driver.differentlyAbled.locomotorOrCerebralPalsy' />:</b>  <fmt:message key='clerktypist.junior.differentlyAbled.locomotorOrCerebralPalsy.popup.msg' />", clerkTypistJuniorDifferentlyAbledAction, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
			commonObj.showAgreeDisAgreePopup("<fmt:message key='clerktypist.junior.differentlyAbled.common.popup.msg' />", clerkTypistJuniorDifferentlyAbledAction, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
	    }else{
	    	$('#ctjda').val("");
	    	checkboxFlag(false);
		}
	});

function clerkTypistJuniorDifferentlyAbledAction(flag) {
	if(!flag) {
		checkboxFlag(flag);
	}else {
		checkboxFlag(flag);
	}
}

function checkboxFlag(flag)
{
	var clickActionId = $('#ctjda').val();
	
	if(clickActionId == '1'){
		$('#clerkTypistJunior-differentlyAbled-blindnessAndLowVision').prop('checked', flag);
	}
	if(clickActionId == '2'){
		$('#clerkTypistJunior-differentlyAbled-deafAndMute').prop('checked', flag);
	}
	if(clickActionId == '3'){
		$('#clerkTypistJunior-differentlyAbled-locomotorOrCerebralPalsy').prop('checked', flag);
	}
	
	var total = $( '.clerkTypistJuniorDifferentlyAbledToggle' ).find('input:checked').length;
	if (total < 1 ) {
		$( '.clerkTypistJuniorDifferentlyAbledToggle' ).find('input').prop('required', true);
		//$("#clerkTypistJunior-differentlyAbled-yes").parent().parent().find('.help-block').empty();
		$("#clerkTypistJunior-differentlyAbled-yes").parent().parent().find('.help-block').empty().append("<fmt:message key="clerkTypistJunior.atleastone"/>");
	}else{
		$("#clerkTypistJunior-differentlyAbled-yes").parent().parent().find('.help-block').empty();
		$( '.clerkTypistJuniorDifferentlyAbledToggle' ).find('input').prop('required', false);
	}
}

function viewFileClerkTypist() {
	var url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/ClerkTypiest 3.pdf'/>";
	window.open(url,'_blank');
}

</script>   
<div id="downloadEligibilityCriteria" class="form-group" align="right">
       <div class="col-sm-12" align="pull-right">
           <a href="javascript:void(0);" onclick="javascript:showEligibilityCriteriaPDF(${post.postId})"><b><fmt:message key="postEligibilityCriteriaLink"/></b></a>
       </div>
   </div>

<form class="form-horizontal" name="clerkTypistJuniorForm" id="clerkTypistJuniorForm" data-toggle="validator" action="<c:url value='/applicant?operation=saveApplicantPostDetails'/>" method="POST">

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${applicantPostAssoc.id}"/>
    <input type="hidden" name="postId" value="${post.postId}"/>
    <input type="hidden" name="status" id="status"  value="${ applicantPostAssoc.status }"/>
	<input type="hidden" name="ctjda" id="ctjda" />
	
<div class="form-group">
        <label class="control-label col-sm-5" for="differentlyAbled"><fmt:message key="clerkTypistJunior.differentlyAbled"/>: <span class="red">*&nbsp;&nbsp;##</span><a href="javascript:void(0);" onclick="javascript:viewFileClerkTypist()" style="font-size: 9px; font-style: italic">	<fmt:message key="viewFile"/></a></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="differentlyAbled" id="clerkTypistJunior-differentlyAbled-yes" value="1" type="radio" ${applicantPostAssoc.differentlyAbled ? 'checked' : ''} />
                <label for="clerkTypistJunior-differentlyAbled-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input name="differentlyAbled" id="clerkTypistJunior-differentlyAbled-no" value="0" type="radio" ${applicantPostAssoc.differentlyAbled == false ? 'checked' : ''} />
                <label for="clerkTypistJunior-differentlyAbled-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
	<div class="form-group clerkTypistJuniorDifferentlyAbledToggle">
    	<div class="col-sm-5">&nbsp;</div>
        <div class="col-sm-4">
        	<div class="checkbox">
	        	<input value="1" type="checkbox" class="form-control"  id="clerkTypistJunior-differentlyAbled-blindnessAndLowVision" placeholder="<fmt:message key="clerkTypistJunior.differentlyAbled.blindnessAndLowVision"/>" name="blindnessAndLowVision" ${applicantPostAssoc.blindnessAndLowVision ? 'checked' : ''}  maxlength="100">
	        	<label for="clerkTypistJunior-differentlyAbled-blindnessAndLowVision"><fmt:message key="clerkTypistJunior.differentlyAbled.blindnessAndLowVision"/></label>
        	</div>
           	<div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group clerkTypistJuniorDifferentlyAbledToggle">
    	<div class="col-sm-5">&nbsp;</div>
        <div class="col-sm-4">
        	<div class="checkbox">
        		<input value="1" type="checkbox" class="form-control"  id="clerkTypistJunior-differentlyAbled-deafAndMute" placeholder="<fmt:message key="clerkTypistJunior.differentlyAbled.deafAndMute"/>" name="deafAndMute" ${applicantPostAssoc.deafAndMute ? 'checked' : ''}   maxlength="100">
        		<label for="clerkTypistJunior-differentlyAbled-deafAndMute"><fmt:message key="clerkTypistJunior.differentlyAbled.deafAndMute"/></label>
        	</div>
           	<div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group clerkTypistJuniorDifferentlyAbledToggle">
    	<div class="col-sm-5">&nbsp;</div>
        <div class="col-sm-4">
        	<div class="checkbox">
	        	<input value="1" type="checkbox" class="form-control"  id="clerkTypistJunior-differentlyAbled-locomotorOrCerebralPalsy" placeholder="<fmt:message key="driver.differentlyAbled.locomotorOrCerebralPalsy"/>" name="locomotorOrCerebralPalsy" ${applicantPostAssoc.locomotorOrCerebralPalsy ? 'checked' : ''}   maxlength="100">
	        	<label for="clerkTypistJunior-differentlyAbled-locomotorOrCerebralPalsy"><fmt:message key="clerkTypistJunior.differentlyAbled.locomotorOrCerebralPalsy"/></label>
        	</div>
           	<div class="help-block with-errors"></div>
        </div>
    </div>
<div id="clerkTypistJuniorFormContainerDiv">
<div class="form-group">
        <label class="control-label col-sm-5" for="graduateFromAffiliatedInstitute"><fmt:message key="clerkTypistJunior.graduateFromAffiliatedInstitute"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="graduateFromAffiliatedInstitute" id="clerkTypist-graduateFromAffiliatedInstitute-yes" value="1" type="radio" ${applicantPostAssoc.graduateFromAffiliatedInstitute ? 'checked' : ''} />
                <label for="clerkTypist-graduateFromAffiliatedInstitute-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck"  name="graduateFromAffiliatedInstitute" id="clerkTypist-graduateFromAffiliatedInstitute-no" value="0" type="radio" ${applicantPostAssoc.graduateFromAffiliatedInstitute == false ? 'checked' : ''} />
                <label for="clerkTypist-graduateFromAffiliatedInstitute-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group graduateFromAffiliatedInstituteToggle">
        <label class="control-label col-sm-5" for="degreeName"><fmt:message key="applicant.degreeName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.degreeName}" type="text" class="form-control" id="clerkTypist-graduatesFromAffiliatedInstitute-degreeName" placeholder="<fmt:message key="applicant.degreeName"/>" name="degreeName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group graduateFromAffiliatedInstituteToggle">
        <label class="control-label col-sm-5" for="universityName"><fmt:message key="applicant.universityName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.universityName}" type="text" class="form-control" id="clerkTypist-graduatesFromAffiliatedInstitute-universityName" placeholder="<fmt:message key="applicant.universityName"/>" name="universityName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <%--  <div class="form-group">
        <label class="control-label col-sm-5" for="otherQualificationDetails"><fmt:message key="clerkTypistJunior.otherQualificationDetails"/>: </label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.otherQualificationDetails}" type="text" class="form-control" id="clerkTypistJunior-otherQualificationDetails" placeholder="<fmt:message key="clerkTypistJunior.otherQualificationDetails"/>" name="otherQualificationDetails" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div> --%>

<div class="form-group">
        <label for="division" class="col-sm-5 control-label"><fmt:message key="clerkTypistJunior.division" />:<span class="red">*</span></label>
        <div class="col-sm-4">
            <select id="clerkTypistJuniorDivision" name="divisionId" class="form-control" data-size="5" required>
                <option value="">-- <fmt:message key="division.select"/> --</option>
                <c:forEach items="${clerktypistJrDivisionList}" var="postdivision">
					<option value="${postdivision.division.divisionId}" ${ postdivision.division.divisionId eq applicantPostAssoc.divisionId? 'selected':'' }><fmt:message key="${ postdivision.division.messageKey }" /></option>
				</c:forEach>
			</select>
            <div class="help-block with-errors"></div>
        </div>
    </div>

	<div class="form-group">
        <label class="control-label col-sm-5" for="mscitOrDoeaccPassCertification"><fmt:message key="clerkTypistJunior.mscitOrDoeaccPassCertification"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="mscitOrDoeaccPassCertification" id="clerkTypist-mscitOrDoeaccPassCertification-yes" value="1" type="radio" ${applicantPostAssoc.mscitOrDoeaccPassCertification ? 'checked' : ''} />
                <label for="clerkTypist-mscitOrDoeaccPassCertification-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="mscitOrDoeaccPassCertification" id="clerkTypist-mscitOrDoeaccPassCertification-no" value="0" type="radio" ${applicantPostAssoc.mscitOrDoeaccPassCertification == false ? 'checked' : ''} />
                <label for="clerkTypist-mscitOrDoeaccPassCertification-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>

	<div class="form-group">
        <label class="control-label col-sm-5" for="typingExamPassed"><fmt:message key="clerkTypistJunior.typingExamPassed"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="typingExamPassed" id="clerkTypist-typingExamPassed-yes" value="1" type="radio" ${applicantPostAssoc.typingExamPassed ? 'checked' : ''} />
                <label for="clerkTypist-typingExamPassed-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="typingExamPassed" id="clerkTypist-typingExamPassed-no" value="0" type="radio" ${applicantPostAssoc.typingExamPassed == false ? 'checked' : ''} />
                <label for="clerkTypist-typingExamPassed-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
	<div class="form-group">
        <label class="control-label col-sm-5" for="experienced"><fmt:message key="clerkTypistJunior.experienced"/>:</label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="experienced" id="clerkTypistJunior-experienced-yes" value="1" type="radio" ${applicantPostAssoc.experienced ? 'checked' : ''} />
                <label for="clerkTypistJunior-experienced-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input name="experienced" id="clerkTypistJunior-experienced-no" value="0" type="radio" ${applicantPostAssoc.experienced == false ? 'checked' : ''} />
                <label for="clerkTypistJunior-experienced-no"> <fmt:message key="no"/> </label>
            </div> <div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group experiencedToggle">
        <label class="control-label col-sm-5" for=""><fmt:message key="clerkTypistJunior.experienced.companyName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.companyName}" type="text" class="form-control" id="clerkTypistJunior-companyName" placeholder="<fmt:message key="clerkTypistJunior.experienced.companyName"/>" name="companyName"   maxlength="150">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group experiencedToggle">
        <label class="control-label col-sm-5" for=""><fmt:message key="clerkTypistJunior.experienced.totalExperienceInYears"/>: <span class="red">*</span></label>
        <div class="col-sm-2">
            <input value="${applicantPostAssoc.totalExperienceInYears}" type="tel" class="form-control telToCheck" id="clerkTypistJunior-totalExperienceInYears" placeholder="<fmt:message key="clerkTypistJunior.experienced.inYears"/>" name="totalExperienceInYears" min="0" maxlength="2">
            <div class="help-block with-errors"></div>
        </div>
        <div class="col-sm-2">
            <input value="${applicantPostAssoc.totalExperienceInMonths}" type="tel" class="form-control telToCheck" id="clerkTypistJunior-TotalExperienceInMonths" placeholder="<fmt:message key="clerkTypistJunior.experienced.inMonths"/>" name="totalExperienceInMonths" min="0" maxlength="2">
            <div class="help-block with-errors"></div>
        </div>
    </div>
<%-- <div class="form-group">
        <label class="control-label col-sm-5" for="nightBlindness"><fmt:message key="clerkTypistJunior.nightBlindness"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="nightBlindness" id="clerkTypistJunior-nightBlindness-yes" value="1" type="radio" ${applicantPostAssoc.nightBlindness ? 'checked' : ''} required/>
                <label for="clerkTypistJunior-nightBlindness-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input  name="nightBlindness"  id="clerkTypistJunior-nightBlindness-no" value="0" type="radio" ${applicantPostAssoc.nightBlindness == false ? 'checked' : ''} required/>
                <label for="clerkTypistJunior-nightBlindness-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-5" for="colorBlindness"><fmt:message key="clerkTypistJunior.colorBlindness"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="colorBlindness" id="clerkTypistJunior-colorBlindness-yes" value="1" ${applicantPostAssoc.colorBlindness ? 'checked' : ''} type="radio" required/>
                <label for="clerkTypistJunior-colorBlindness-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input name="colorBlindness" id="clerkTypistJunior-colorBlindness-no" value="0" type="radio" ${applicantPostAssoc.colorBlindness == false ? 'checked' : ''} required/>
                <label for="clerkTypistJunior-colorBlindness-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div> --%>

  
<%-- 	<div class="form-group clerkTypistJuniorDifferentlyAbledToggle">
    	<div class="col-sm-5">&nbsp;</div>
        <div class="col-sm-4">
        	<div class="checkbox">
	        	<input value="1" name="differentlyAbledOthers" type="checkbox" class="form-control"  id="clerkTypistJunior-differentlyAbled-others" placeholder="<fmt:message key="clerkTypistJunior.differentlyAbled.others"/>" ${applicantPostAssoc.differentlyAbledOthers ? 'checked' : ''}   maxlength="100">
	        	<label for="clerkTypistJunior-differentlyAbled-others"><fmt:message key="clerkTypistJunior.differentlyAbled.others"/></label><span class="red">*</span>
        	</div>
           	<div class="help-block with-errors"></div>
        </div>
    </div>
	<div class="form-group clerkTypistJuniorDifferentlyAbledOthersTextToggle">
    	<div class="col-sm-5">&nbsp;</div>
        <div class="col-sm-4">
        	<input value="${applicantPostAssoc.differentlyAbledOthersText}" class="differentlyAbled-others-text" name="differentlyAbledOthersText" type="text" class="form-control"  id="clerkTypistJunior-differentlyAbled-others-text" placeholder="<fmt:message key="clerkTypistJunior.differentlyAbled.others.text"/>" maxlength="100">
        	<div class="help-block with-errors"></div>
        </div>
    </div> --%>
</div>
    <jsp:include page="postFooter.jsp">
    	<jsp:param name="isPostSubmitted" value="${ applicantPostAssoc.status eq 2 || applicantPostAssoc.status eq 3 }"/>
        <jsp:param name="formId" value="clerkTypistJuniorForm"/>
        <jsp:param name="postId" value="${post.postId}"/>
        <jsp:param name="disableFormAfterLastDateOver" value="${disableFormAfterLastDateOver}"/>
    </jsp:include>

</form>

<script>
 $(document).ready(function(){
	 $.validator.addMethod("checkboxes", function(value, element) {
		    return $( '.clerkTypistJuniorDifferentlyAbledToggle' ).find('input:checked').length > 0;
		}, "Please select atleast one checkbox");
	 
 $("form[name='clerkTypistJuniorForm']").validate({
	 rules:{
 		 graduateFromAffiliatedInstitute : "required",
 		 degreeName: {required: true},
 		 universityName: {required: true},
 		 mscitOrDoeaccPassCertification : "required",
 		 typingExamPassed : "required",
 		 companyName: {required: true},
 		 totalExperienceInYears :{required: true, numbersonly:true, max:100},
 		 totalExperienceInMonths :{required: true, numbersonly:true, max: 11},
 		 differentlyAbled: "required",
 		 '#clerkTypistJunior-differentlyAbled-blindnessAndLowVision' : { checkboxes: true }
 		  },
		  messages:{
			  totalExperienceInMonths : {max : "<fmt:message key="number.eleven" var="key" /><fmt:message key="validate.maxMonths"><fmt:param value="${key}" /></fmt:message>"}
			  },
	     errorPlacement: function (error, element) {
		    	if ( element.is(":radio") ) 
	            {
					error.appendTo(element.parent().parent().children('.help-block.with-errors'));
	            }
		    	else 
		    	if (element.is(":checkbox") )
		    	{
					$("#clerkTypistJunior-differentlyAbled-yes").parent().parent().find('.help-block').empty().append("<fmt:message key="clerkTypistJunior.atleastone"/>");
		    	}
		    	else
		    	{
		    		error.insertAfter( element );
		    	}
	    	}
	 });
 });
 </script>