<%@ include file="../../common/taglibs.jsp"%>

<script>
jQuery(document).ready(function() {
	
	postSelectionObj.disableFormFields ("conductorForm", '${applicantPostAssoc.status}');
    postSelectionObj.bindPostForm("conductorForm");

    postSelectionObj.validateDate('conductor-conductorBatchNumberIssueDate','conductor-conductorBatchNumberEndDate');
    
   $('#conductor-conductorBatchNumberIssueDate').datetimepicker({
        format: 'DD/MM/YYYY',
        ignoreReadonly: true,
        showTodayButton: true,
        minDate: postSelectionObj.minDate(),
        maxDate: postSelectionObj.maxDate()
       // date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicantPostAssoc.conductorBatchNumberIssueDate}" />'
    });
    $('#conductor-calendarIcon-conductorBatchNumberIssueDate').click(function() {
        $('#conductor-conductorBatchNumberIssueDate').data("DateTimePicker").show();
    });
    
	$('#conductor-conductorBatchNumberEndDate').datetimepicker({
        format: 'DD/MM/YYYY',
        ignoreReadonly: true,
        showTodayButton: true,
        minDate: postSelectionObj.minDate(),
        maxDate: postSelectionObj.maxDate()
        //date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicantPostAssoc.conductorBatchNumberEndDate}" />'
    });
    $('#conductor-calendarIcon-conductorBatchNumberEndDate').click(function() {
        $('#conductor-conductorBatchNumberEndDate').data("DateTimePicker").show();
    });

    $('#conductor-lightMotorVechicleIssueDate').datetimepicker({
        format: 'DD/MM/YYYY',
        ignoreReadonly: true,
        showTodayButton: true,
        minDate: postSelectionObj.minDate(),
        maxDate: postSelectionObj.maxDate()
        //date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicantPostAssoc.lightMotorVechicleIssueDate}" />'
    });
    $('#conductor-calendarIcon-lightMotorVechicleIssueDate').click(function() {
        $('#conductor-lightMotorVechicleIssueDate').data("DateTimePicker").show();
    });
    
    /* $('#conductor-learningLicenseIssueDate').datetimepicker({
        format: 'DD/MM/YYYY',
        ignoreReadonly: true,
        showTodayButton: true,
        minDate: postSelectionObj.minDate(),
        maxDate: postSelectionObj.maxDate()
        //date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicantPostAssoc.lightMotorVechicleIssueDate}" />'
    });
    $('#conductor-calendarIcon-learningLicenseIssueDate').click(function() {
        $('#conductor-learningLicenseIssueDate').data("DateTimePicker").show();
    }); */

	checkIfShowOrHideElements();

	//moment(date).format('DD/MM/YYYY')
	var date = '${applicantPostAssoc.conductorBatchNumberIssueDate}';
	if(date != 'undefined' || date != null || data !='' )
		$('#conductor-conductorBatchNumberIssueDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicantPostAssoc.conductorBatchNumberIssueDate}" />');

	date = '${applicantPostAssoc.conductorBatchNumberEndDate}';
	if(date != 'undefined' || date != null || data !='' )
		$('#conductor-conductorBatchNumberEndDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicantPostAssoc.conductorBatchNumberEndDate}" />');

	date = '${applicantPostAssoc.lightMotorVechicleIssueDate}';
	if(date != 'undefined' || date != null || data !='' )
		$('#conductor-lightMotorVechicleIssueDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicantPostAssoc.lightMotorVechicleIssueDate}" />');
	
	
	hideLightMotorVechicleElements();
	//hideLearningLicenseElements();
	
	var lastDateOver = commonObj.isValidate(${disableFormAfterLastDateOver});
    commonObj.disableFormFields("conductorForm",lastDateOver);
	
});

function hideLightMotorVechicleElements()
{
	if(!jQuery('input[id=conductor-lightMotorVechicle-yes]').is(':checked') ) {
		$("#conductor-lightMotorVechicle-yes").parent().parent().find('.help-block').empty();
		$( '.conductorLightMotorVechicleToggle' ).find('input').prop('required', false);
		postSelectionObj.hideElementsByClass('conductorLightMotorVechicleToggle');
// 		postSelectionObj.showElementsByClass('conductorLearningLicenseRadioToggle');
// 		$( 'form#conductorForm' ).find('input[type=radio][name=learningLicense]').attr("required", true);
		//conductorEffectLearningLicenseChild();
	} 
// 	else {
// 		postSelectionObj.hideElementsByClass('conductorLearningLicenseRadioToggle');
// 		$( 'form#conductorForm' ).find('input[type=radio][name=learningLicense]').attr("required", false).attr('checked', false);
// 	}
}

/* function hideLearningLicenseElements() {
	if( !jQuery('input[id=conductor-learningLicense-yes]').is(':checked') ) {
		$("#conductor-learningLicense-yes").parent().parent().find('.help-block').empty();
		$( '.conductorLearningLicenseToggle' ).find('input').prop('required', false);
		postSelectionObj.hideElementsByClass('conductorLearningLicenseToggle');
	}
} */

function checkIfShowOrHideElements() {
	if ('${applicantPostAssoc.ownConductorBatchNumber}' == ''||'${applicantPostAssoc.ownConductorBatchNumber}' == 'false') {
		postSelectionObj.hideElementsByClass('conductorOwnConductorBatchToggle');
	}
	
	if ('${applicantPostAssoc.guarantorPersonNameAndMobileNo}' == ''||'${applicantPostAssoc.guarantorPersonNameAndMobileNo}' == 'false') {
		postSelectionObj.hideElementsByClass('guarantorPersonNameAndMobileNoToggle');
	}
	
	/* if ('${applicantPostAssoc.differentlyAbled}' == ''||'${applicantPostAssoc.differentlyAbled}' == 'false') {
		postSelectionObj.hideElementsByClass('conductorDifferentlyAbledToggle');
	} */
	
	/* if ( ${applicantPostAssoc.lightMotorVechicle eq false} ) {
		postSelectionObj.showElementsByClass('conductorLearningLicenseRadioToggle');
		//$( 'form#conductorForm' ).find('input[type=radio][name=learningLicense]').attr("required", true);
	} else {
		postSelectionObj.hideElementsByClass('conductorLearningLicenseRadioToggle');
		//$( 'form#conductorForm' ).find('input[type=radio][name=learningLicense]').attr("required", false);
	} */
}

/* $( 'form#conductorForm' ).find('input[type=radio][name=differentlyAbled]').unbind().change(function() {
    if (this.value == '1') {
    	requiredDifferentlyAbledChilds(true);
   	 postSelectionObj.showElementsByClass('conductorDifferentlyAbledToggle');
    } else {
    	requiredDifferentlyAbledChilds(false);
   	 postSelectionObj.hideElementsByClass('conductorDifferentlyAbledToggle');
   	 postSelectionObj.resetCheckBoxById('conductor-differentlyAbled-blindnessAndLowVision');
   	 postSelectionObj.resetCheckBoxById('conductor-differentlyAbled-deafAndMute');
   	 postSelectionObj.resetCheckBoxById('conductor-differentlyAbled-locomotorOrCerebralPalsy');

    }
}); */

$( 'form#conductorForm' ).find('input[type=radio][name=lightMotorVechicle]').unbind().change(function() {
    if (this.value == '1') {
    	$('.conductorLightMotorVechicleToggle').attr("required", true);
   	 	postSelectionObj.showElementsByClass('conductorLightMotorVechicleToggle');
   	 	resetFieldsAndAttributes(['conductor-lightMotorVechicleLicenseNo', 'conductor-lightMotorVechicleIssueDate'], true);
   	 	//$( 'form#conductorForm' ).find('input[type=radio][name=learningLicense]').attr("required", false).attr('checked', false);
   	 	//postSelectionObj.hideElementsByClass('conductorLearningLicenseRadioToggle');
   	 	//conductorEffectLearningLicenseChild();
   	    
    } else {
    	$('.conductorLightMotorVechicleToggle').attr("required", false);
   	 	postSelectionObj.hideElementsByClass('conductorLightMotorVechicleToggle');
   	 	postSelectionObj.resetTextFieldById('conductor-lightMotorVechicleLicenseNo');
   	 	postSelectionObj.resetTextFieldById('conductor-lightMotorVechicleIssueDate');
   	 	resetFieldsAndAttributes(['conductor-lightMotorVechicleLicenseNo', 'conductor-lightMotorVechicleIssueDate'], false);
   	    $("#conductor-lightMotorVechicleLicenseNo").parent().find('label.error').empty();
	    $("#conductor-lightMotorVechicleIssueDate").parent().parent().find('label.error').empty();
//   	 	commonObj.showAlert("<fmt:message key='conductor.light.motor.vehicle.no.msg' />");
		//New changes
   		commonObj.showAgreeDisAgreePopup("<fmt:message key='conductor.light.motor.vehicle.no.msg' />", conductorLightMotoVechiclePopup, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
	    //$( 'form#conductorForm' ).find('input[type=radio][name=learningLicense]').attr("required", true);
	    //postSelectionObj.showElementsByClass('conductorLearningLicenseRadioToggle');
    }
});


/* $( 'form#conductorForm' ).find('input[type=radio][name=learningLicense]').unbind().change(function() {
    if (this.value == '1') {
    	$('.conductorLearningLicenseToggle').attr("required", true);
   	 	postSelectionObj.showElementsByClass('conductorLearningLicenseToggle');
   	 	resetFieldsAndAttributes(['conductor-learningLicenseNo', 'conductor-learningLicenseIssueDate'], true);
   	    
    } else {
    	//conductorEffectLearningLicenseChild();
//   	 	commonObj.showAlert("<fmt:message key='conductor.light.motor.vehicle.no.msg' />");
   		commonObj.showAgreeDisAgreePopup("<fmt:message key='conductor.light.motor.vehicle.no.msg' />", conductorLightMotoVechiclePopup, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
    }
}); */

function conductorEffectLMVLicenseChild() {
	$('.conductorLightMotorVechicleToggle').attr("required", false);
 	postSelectionObj.hideElementsByClass('conductorLightMotorVechicleToggle');
// 	postSelectionObj.resetTextFieldById('conductor-learningLicenseNo');
// 	postSelectionObj.resetTextFieldById('conductor-learningLicenseIssueDate');
 	resetFieldsAndAttributes(['conductor-lightMotorVechicleLicenseNo', 'conductor-lightMotorVechicleIssueDate'], false);
    $("#conductor-lightMotorVechicleLicenseNo").parent().find('label.error').empty();
    $("#conductor-lightMotorVechicleIssueDate").parent().parent().find('label.error').empty();
}

function conductorLightMotoVechiclePopup(flag) {
	if(!flag) {
		$('#conductor-lightMotorVechicle-yes').prop('checked', true);
		$('.conductorLightMotorVechicleToggle').attr("required", true);
   	 	postSelectionObj.showElementsByClass('conductorLightMotorVechicleToggle');
   	 	resetFieldsAndAttributes(['conductor-lightMotorVechicleLicenseNo', 'conductor-lightMotorVechicleIssueDate'], true);
	} else {
		conductorEffectLMVLicenseChild();
	}
}

$( 'form#conductorForm' ).find('input[type=radio][name=ownConductorBatchNumber]').unbind().change(function() {
    if (this.value == '1') {
    	$('#conductor-conductorBatchNumber').attr("required", true);
   	 postSelectionObj.showElementsByClass('conductorOwnConductorBatchToggle');
    } else {
    	$('#conductor-conductorBatchNumber').attr("required", false);
   	 postSelectionObj.hideElementsByClass('conductorOwnConductorBatchToggle');
   	 postSelectionObj.resetTextFieldById('conductor-conductorBatchNumber');
   	 postSelectionObj.resetTextFieldById('conductor-conductorBatchNumberIssueDate');
   	 postSelectionObj.resetTextFieldById('conductor-conductorBatchNumberEndDate');

    }
});

$( 'form#conductorForm' ).find('input[type=radio][name=guarantorPersonNameAndMobileNo]').unbind().change(function() {
    if (this.value == '1') 
    {
    	$('#conductor-guarantorPersonNameAndMobileNo-guarantorPersonName').attr("required", true);
    	$('#conductor-guarantorPersonNameAndMobileNo-guarantorPersonMobileNumber').attr("required", true);
   		 postSelectionObj.showElementsByClass('guarantorPersonNameAndMobileNoToggle');
    } 
    else 
    {
    	$('#conductor-guarantorPersonNameAndMobileNo-guarantorPersonName').attr("required", false);
    	$('#conductor-guarantorPersonNameAndMobileNo-guarantorPersonMobileNumber').attr("required", false);
    	postSelectionObj.hideElementsByClass('guarantorPersonNameAndMobileNoToggle');
    	postSelectionObj.resetTextFieldById('conductor-guarantorPersonNameAndMobileNo-guarantorPersonName');
    	postSelectionObj.resetTextFieldById('conductor-guarantorPersonNameAndMobileNo-guarantorPersonMobileNumber');
    }
});

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

/* $( '.conductorDifferentlyAbledToggle' ).find('input').click(function() {
	actionOnCheckBoxSelected();
}); */

/* function actionOnCheckBoxSelected() {
	var total = $( '.conductorDifferentlyAbledToggle' ).find('input:checked').length;
  	if (total > 0) {
  		requiredDifferentlyAbledChilds(false);
  	} else {
  		requiredDifferentlyAbledChilds(true);
  	}
} */

/* function requiredDifferentlyAbledChilds(flag) {
	$( '.conductorDifferentlyAbledToggle' ).find('input').prop('required', flag);
} */

</script>   
<div id="downloadEligibilityCriteria" class="form-group" align="right">
       <div class="col-sm-12" align="pull-right">
           <a href="javascript:void(0);" onclick="javascript:showEligibilityCriteriaPDF(${post.postId})"><b><fmt:message key="postEligibilityCriteriaLink"/></b></a>
       </div>
   </div>

<form class="form-horizontal" name="conductorForm" id="conductorForm" action="<c:url value='/applicant?operation=saveApplicantPostDetails'/>" method="POST">

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${applicantPostAssoc.id}"/>
    <input type="hidden" name="postId" value="${post.postId}"/>
    <input type="hidden" name="status" id="status"  value="${ applicantPostAssoc.status }"/>

   <div class="form-group">
        <label class="control-label col-sm-5" for="sscPassed"><fmt:message key="conductor.educationQualification"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="sscPassed" id="conductor-sscPassed-yes" value="1" type="radio" ${applicantPostAssoc.sscPassed ? 'checked' : ''} />
                <label for="conductor-sscPassed-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="sscPassed" id="conductor-sscPassed-no" value="0" type="radio" ${applicantPostAssoc.sscPassed == false ? 'checked' : ''} />
                <label for="conductor-sscPassed-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
 <div class="form-group">
        <label class="control-label col-sm-5" for="otherQualificationDetails"><fmt:message key="conductor.otherQualificationDetails"/>: </label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.otherQualificationDetails}" type="text" class="form-control" id="conductor-otherQualificationDetails" placeholder="<fmt:message key="conductor.otherQualificationDetails"/>" name="otherQualificationDetails" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group">
        <label for="division" class="col-sm-5 control-label"><fmt:message key="conductor.division" />:<span class="red">*</span></label>
        <div class="col-sm-4">
            <select id="conductorDivision" name="divisionId" class="form-control" data-size="5" required oninvalid="this.setCustomValidity('<fmt:message key="validation.requiredfield"/>')">
                <option value="">-- <fmt:message key="division.select"/> --</option>
                <c:forEach items="${conductorJrDivisionList}" var="postdivision">
					<option value="${postdivision.division.divisionId}" ${ postdivision.division.divisionId eq applicantPostAssoc.divisionId? 'selected':'' }><fmt:message key="${ postdivision.division.messageKey }" /></option>
				</c:forEach>
			</select>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
<div class="form-group">
        <label class="control-label col-sm-5" for="nightBlindness"><fmt:message key="conductor.nightBlindness"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="nightBlindness" id="conductor-nightBlindness-yes" value="1" type="radio" ${applicantPostAssoc.nightBlindness ? 'checked' : ''} />
                <label for="conductor-nightBlindness-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input name="nightBlindness"  id="conductor-nightBlindness-no" value="0" type="radio" ${applicantPostAssoc.nightBlindness == false ? 'checked' : ''} />
                <label for="conductor-nightBlindness-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group">
        <label class="control-label col-sm-5" for="colorBlindness"><fmt:message key="conductor.colorBlindness"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="colorBlindness" id="conductor-colorBlindness-yes" value="1" type="radio" ${applicantPostAssoc.colorBlindness ? 'checked' : ''} />
                <label for="conductor-colorBlindness-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input name="colorBlindness"  id="conductor-colorBlindness-no" value="0" type="radio" ${applicantPostAssoc.colorBlindness == false ? 'checked' : ''} />
                <label for="conductor-colorBlindness-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>

     <%-- <div class="form-group">
        <label class="control-label col-sm-5" for="differentlyAbled"><fmt:message key="conductor.differentlyAbled"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="differentlyAbled" id="conductor-differentlyAbled-yes" value="1" type="radio" ${applicantPostAssoc.differentlyAbled ? 'checked' : ''} required/>
                <label for="conductor-differentlyAbled-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input name="differentlyAbled" id="conductor-differentlyAbled-no" value="0" type="radio" ${applicantPostAssoc.differentlyAbled == false ? 'checked' : ''} required/>
                <label for="conductor-differentlyAbled-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group conductorDifferentlyAbledToggle">
    	<div class="col-sm-5">&nbsp;</div>
        <div class="col-sm-4">
        	<div class="checkbox">
	        	<input value="1" type="checkbox" class="form-control"  id="conductor-differentlyAbled-blindnessAndLowVision" placeholder="<fmt:message key="conductor.differentlyAbled.blindnessAndLowVision"/>" name="blindnessAndLowVision" ${applicantPostAssoc.blindnessAndLowVision ? 'checked' : ''}   maxlength="100">
	        	<label for="conductor-differentlyAbled-blindnessAndLowVision"><fmt:message key="conductor.differentlyAbled.blindnessAndLowVision"/></label><span class="red">*</span>
        	</div>
           	<div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group conductorDifferentlyAbledToggle">
    	<div class="col-sm-5">&nbsp;</div>
        <div class="col-sm-4">
        	<div class="checkbox">
        		<input value="1" type="checkbox" class="form-control"  id="conductor-differentlyAbled-deafAndMute" placeholder="<fmt:message key="conductor.differentlyAbled.deafAndMute"/>" name="deafAndMute" ${applicantPostAssoc.deafAndMute ? 'checked' : ''}   maxlength="100">
        		<label for="conductor-differentlyAbled-deafAndMute"><fmt:message key="conductor.differentlyAbled.deafAndMute"/></label><span class="red">*</span>
        	</div>
           	<div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group conductorDifferentlyAbledToggle">
    	<div class="col-sm-5">&nbsp;</div>
        <div class="col-sm-4">
        	<div class="checkbox">
	        	<input value="1" type="checkbox" class="form-control"  id="conductor-differentlyAbled-locomotorOrCerebralPalsy" placeholder="<fmt:message key="conductor.differentlyAbled.locomotorOrCerebralPalsy"/>" name="locomotorOrCerebralPalsy" ${applicantPostAssoc.locomotorOrCerebralPalsy ? 'checked' : ''}   maxlength="100">
	        	<label for="conductor-differentlyAbled-locomotorOrCerebralPalsy"><fmt:message key="conductor.differentlyAbled.locomotorOrCerebralPalsy"/></label><span class="red">*</span>
        	</div>
           	<div class="help-block with-errors"></div>
        </div>
    </div> --%>
    
     <div class="form-group">
        <label class="control-label col-sm-5" for="ownConductorBatchNumber"><fmt:message key="conductor.ownConductorBatchNumber"/>:<span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="ownConductorBatchNumber" id="conductor-ownConductorBatchNumber-yes" value="1" type="radio" ${applicantPostAssoc.ownConductorBatchNumber ? 'checked' : ''} />
                <label for="conductor-ownConductorBatchNumber-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="ownConductorBatchNumber" id="conductor-ownConductorBatchNumber-no" value="0" type="radio" ${applicantPostAssoc.ownConductorBatchNumber == false ? 'checked' : ''} />
                <label for="conductor-ownConductorBatchNumber-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
	<div class="form-group conductorOwnConductorBatchToggle">
        <label class="control-label col-sm-5" for="conductorBatchNumber"><fmt:message key="conductor.ownConductorBatchNumber.conductorBatchNumber"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.conductorBatchNumber}" type="text" class="form-control" id="conductor-conductorBatchNumber" placeholder="<fmt:message key="conductor.ownConductorBatchNumber.conductorBatchNumber"/>" name="conductorBatchNumber" maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group conductorOwnConductorBatchToggle">
        <label class="control-label col-sm-5" for="issueDate"><fmt:message key="conductor.ownConductorBatchNumber.issueDate"/>: <span class="red">*</span></label>
        <div class="col-sm-3">
        	<div class="input-group date">
	            <input type="datetime" class="form-control" id="conductor-conductorBatchNumberIssueDate" placeholder="<fmt:message key="conductor.ownConductorBatchNumber.issueDate"/>" name="conductorBatchNumberIssueDate" readonly>
	            <div class="input-group-addon" id="conductor-calendarIcon-conductorBatchNumberIssueDate">
					<i class="fa fa-calendar"></i>
				</div>
	            <div class="help-block with-errors"></div>
            </div>
        </div>
    </div>
    <div class="form-group conductorOwnConductorBatchToggle">
        <label class="control-label col-sm-5" for="endDate"><fmt:message key="conductor.ownConductorBatchNumber.endDate"/>:</label>
        <div class="col-sm-3">
        	<div class="input-group date">
	            <input type="datetime" class="form-control" id="conductor-conductorBatchNumberEndDate" placeholder="<fmt:message key="conductor.ownConductorBatchNumber.endDate"/>" name="conductorBatchNumberEndDate" readonly >
	            <div class="input-group-addon" id="conductor-calendarIcon-conductorBatchNumberEndDate">
					<i class="fa fa-calendar"></i>
				</div>
	            <div class="help-block with-errors"></div>
            </div>
        </div>
    </div>
    
    <div class="form-group">
        <label class="control-label col-sm-5" for="conductorLightMotorVechicle"><fmt:message key="conductor.light.motor.vehicle"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="lightMotorVechicle" id="conductor-lightMotorVechicle-yes" value="1" type="radio" ${applicantPostAssoc.lightMotorVechicle ? 'checked' : ''} />
                <label for="conductor-lightMotorVechicle-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input name="lightMotorVechicle" id="conductor-lightMotorVechicle-no" value="0" type="radio" ${applicantPostAssoc.lightMotorVechicle == false ? 'checked' : ''} />
                <label for="conductor-lightMotorVechicle-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group conductorLightMotorVechicleToggle">
        <label class="control-label col-sm-5" for="lightMotorVechicleLicenseNo"><fmt:message key="conductor.light.motor.vehicle.license.no"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.lightMotorVechicleLicenseNo}" type="text"  name="lightMotorVechicleLicenseNo" maxlength="30" class="form-control" id="conductor-lightMotorVechicleLicenseNo" placeholder="<fmt:message key="conductor.light.motor.vehicle.license.no"/>" >
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group conductorLightMotorVechicleToggle">
        <label class="control-label col-sm-5" for="lightMotorVechicleIssueDate"><fmt:message key="conductor.light.motor.vehicle.license.issue.date"/>: <span class="red">*</span></label>
        <div class="col-sm-3">
        	<div class="input-group date">
	            <input type="datetime" class="form-control" id="conductor-lightMotorVechicleIssueDate" placeholder="<fmt:message key="conductor.light.motor.vehicle.license.issue.date"/>" name="lightMotorVechicleIssueDate" readonly >
	            <div class="input-group-addon" id="conductor-calendarIcon-lightMotorVechicleIssueDate">
					<i class="fa fa-calendar"></i>
				</div>
	            <div class="help-block with-errors"></div>
            </div>
        </div>
    </div>
    
    <%-- <div class="form-group conductorLearningLicenseRadioToggle">
        <label class="control-label col-sm-5" for="conductorLightMotorVechicle"><fmt:message key="conductor.learning.license"/>: </label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="learningLicense" id="conductor-learningLicense-yes" value="1" type="radio" ${applicantPostAssoc.learningLicense ? 'checked' : ''} />
                <label for="conductor-learningLicense-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input name="learningLicense" id="conductor-learningLicense-no" value="0" type="radio" ${applicantPostAssoc.learningLicense == false ? 'checked' : ''} />
                <label for="conductor-learningLicense-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group conductorLearningLicenseToggle">
        <label class="control-label col-sm-5" for="learningLicenseNo"><fmt:message key="conductor.learning.license.no"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.learningLicenseNo}" type="text"  name="learningLicenseNo" maxlength="30" class="form-control" id="conductor-learningLicenseNo" placeholder="<fmt:message key="conductor.learning.license.no"/>" >
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group conductorLearningLicenseToggle">
        <label class="control-label col-sm-5" for="learningLicenseIssueDate"><fmt:message key="conductor.learning.license.issue.date"/>: <span class="red">*</span></label>
        <div class="col-sm-3">
        	<div class="input-group date">
	            <input type="datetime" class="form-control" id="conductor-learningLicenseIssueDate" placeholder="<fmt:message key="conductor.learning.license.issue.date"/>" name="learningLicenseIssueDate" readonly >
	            <div class="input-group-addon" id="conductor-calendarIcon-learningLicenseIssueDate">
					<i class="fa fa-calendar"></i>
				</div>
	            <div class="help-block with-errors"></div>
            </div>
        </div>
    </div> --%>
       
	<div class="form-group">
        <label class="control-label col-sm-5" for="guarantorPersonNameAndMobileNo"><fmt:message key="conductor.guarantorPersonNameAndMobileNo"/>:<span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="guarantorPersonNameAndMobileNo" id="conductor-guarantorPersonNameAndMobileNo-yes" value="1" type="radio" ${applicantPostAssoc.guarantorPersonNameAndMobileNo ? 'checked' : ''} />
                <label for="conductor-guarantorPersonNameAndMobileNo-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="guarantorPersonNameAndMobileNo" id="conductor-guarantorPersonNameAndMobileNo-no" value="0" type="radio" ${applicantPostAssoc.guarantorPersonNameAndMobileNo == false ? 'checked' : ''} />
                <label for="conductor-guarantorPersonNameAndMobileNo-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group guarantorPersonNameAndMobileNoToggle">
        <label class="control-label col-sm-5" for="guarantorPersonName"><fmt:message key="guarantorPersonNameAndMobileNo.guarantorPersonName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.guarantorPersonName}" type="text" class="form-control" id="conductor-guarantorPersonNameAndMobileNo-guarantorPersonName" placeholder="<fmt:message key="guarantorPersonNameAndMobileNo.guarantorPersonName"/>" name="guarantorPersonName" maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
    </div>
     <div class="form-group guarantorPersonNameAndMobileNoToggle">
        <label class="control-label col-sm-5" for="guarantorPersonMobileNumber"><fmt:message key="guarantorPersonNameAndMobileNo.guarantorPersonMobileNumber"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.guarantorPersonMobileNumber}" type="tel" maxlength="10" class="form-control" id="conductor-guarantorPersonNameAndMobileNo-guarantorPersonMobileNumber" placeholder="<fmt:message key="guarantorPersonNameAndMobileNo.guarantorPersonMobileNumber"/>" name="guarantorPersonMobileNumber" maxlength="10">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
<div class="form-group">
        <label class="control-label col-sm-5" for="heightWithinRange"><fmt:message key="conductor.heightWithinRange"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="heightWithinRange" id="conductor-heightWithinRange-yes" value="1" type="radio" ${applicantPostAssoc.heightWithinRange ? 'checked' : ''} />
                <label for="conductor-heightWithinRange-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="heightWithinRange" id="conductor-heightWithinRange-no" value="0" type="radio" ${applicantPostAssoc.heightWithinRange == false ? 'checked' : ''} />
                <label for="conductor-heightWithinRange-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <jsp:include page="postFooter.jsp">
    	<jsp:param name="isPostSubmitted" value="${ applicantPostAssoc.status eq 2 || applicantPostAssoc.status eq 3 }"/>
        <jsp:param name="formId" value="conductorForm"/>
        <jsp:param name="postId" value="${post.postId}"/>
        <jsp:param name="disableFormAfterLastDateOver" value="${disableFormAfterLastDateOver}"/>
    </jsp:include>

</form>

<script>
 $(document).ready(function(){
 $("form[name='conductorForm']").validate({
	 //ignore : "#conductorBatchNumberIssueDate, #conductorBatchNumberEndDate, #conductorDivision",
 	 rules:{
	 		sscPassed : "required",
	 		nightBlindness : "required",
	 		colorBlindness : "required",
	 		ownConductorBatchNumber : "required",
	 		conductorBatchNumber:{required: true},
	 		heightWithinRange : "required",
	 		guarantorPersonNameAndMobileNo : "required",
	 		guarantorPersonName: {required: true, lettersandspaceonly:true},
	 		guarantorPersonMobileNumber:{required: true, numbersonly:true, minlength: 10, maxlength: 10},

	 		conductorBatchNumberIssueDate : {required: true},
	 		conductorBatchNumberEndDate : {required: true},

	 		//lightMotorVechicle : "required"
	 		
 		  },
 		 messages:
		    {
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