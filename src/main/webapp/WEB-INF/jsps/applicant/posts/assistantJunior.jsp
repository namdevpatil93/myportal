<%@ include file="../../common/taglibs.jsp"%>

<script type="text/javascript">
	$(document).ready(function() {
		postSelectionObj.disableFormFields ("assistantJuniorForm", '${applicantPostAssoc.status}');
		postSelectionObj.bindPostForm("assistantJuniorForm");
		
		checkIfShowOrHideElements();
		
		 $('#assistantJunior-lightMotorVechicleIssueDate').datetimepicker({
	        format: 'DD/MM/YYYY',
	        ignoreReadonly: true,
	        showTodayButton: true,
	        minDate: postSelectionObj.minDate(),
	        maxDate: postSelectionObj.maxDate()
	        //date : '<tags:localDate pattern="dd/MM/yyyy" date="${applicantPostAssoc.lightMotorVechicleIssueDate}" />'
	    });
	    $('#assistantJunior-calendarIcon-lightMotorVechicleIssueDate').click(function() {
	        $('#assistantJunior-lightMotorVechicleIssueDate').data("DateTimePicker").show();
	    });
	    
	    /* $('#assistantJunior-learningLicenseIssueDate').datetimepicker({
	        format: 'DD/MM/YYYY',
	        ignoreReadonly: true,
	        showTodayButton: true,
	        minDate: postSelectionObj.minDate(),
	        maxDate: postSelectionObj.maxDate()
	        //date : '<tags:localDate pattern="dd/MM/yyyy" date="${applicantPostAssoc.lightMotorVechicleIssueDate}" />'
	    });
	    $('#assistantJunior-calendarIcon-learningLicenseIssueDate').click(function() {
	        $('#assistantJunior-learningLicenseIssueDate').data("DateTimePicker").show();
	    }); */
		
		var date = '${applicantPostAssoc.lightMotorVechicleIssueDate}';
		if(date != 'undefined' || date != null || data !='' )
			$('#assistantJunior-lightMotorVechicleIssueDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicantPostAssoc.lightMotorVechicleIssueDate}" />');
		
		
		hideLightMotorVechicleElements();
		//hideLearningLicenseElements();
		var lastDateOver = commonObj.isValidate(${disableFormAfterLastDateOver});
	    commonObj.disableFormFields("assistantJuniorForm",lastDateOver);
	});
	
	/* function requiredDifferentlyAbledChilds(flag) {
		$( '.assistantJuniorDifferentlyAbledToggle' ).find('input').prop('required', flag);
	} */
	
	function hideLightMotorVechicleElements() {
		if(!jQuery('input[id=assistantJunior-lightMotorVechicle-yes]').is(':checked') ) {
			$("#assistantJunior-lightMotorVechicle-yes").parent().parent().find('.help-block').empty();
			$( '.assistantJuniorLightMotorVechicleToggle' ).find('input').prop('required', false);
			postSelectionObj.hideElementsByClass('assistantJuniorLightMotorVechicleToggle');
		} 
	}

	/* function hideLearningLicenseElements() {
		if( !jQuery('input[id=assistantJunior-learningLicense-yes]').is(':checked') ) {
			$("#assistantJunior-learningLicense-yes").parent().parent().find('.help-block').empty();
			$( '.assistantJuniorLearningLicenseToggle' ).find('input').prop('required', false);
			postSelectionObj.hideElementsByClass('assistantJuniorLearningLicenseToggle');
		}
	} */
	
	function checkIfShowOrHideElements() {
		if ('${applicantPostAssoc.experienced}' == '' || '${applicantPostAssoc.experienced}' == 'false') {
			$("#assistantJuniorCompanyName").parent().parent().find("label.error").empty();
	       	$("#assistantJuniorTotalExperienceInYears").parent().parent().find("label.error").empty();
			postSelectionObj.hideElementsByClass('assistantJuniorExperiencedToggle');
		}
		if ('${applicantPostAssoc.apprenticeshipInMSRTC}' == '' || '${applicantPostAssoc.apprenticeshipInMSRTC}' == 'false') {
			$("#apprenticeshipInMSRTCTrade").parent().parent().find("label.error").empty();
	       	$("#apprenticeshipInMSRTCYear").parent().parent().find("label.error").empty();
	       	$("#apprenticeshipInMSRTCDivision").parent().parent().find("label.error").empty();
			postSelectionObj.hideElementsByClass('assistantJuniorApprenticeshipInMSRTCToggle');
		}
		/* if ('${applicantPostAssoc.differentlyAbled}' == '' || '${applicantPostAssoc.differentlyAbled}' == 'false') {
			postSelectionObj.hideElementsByClass('assistantJuniorDifferentlyAbledToggle');
			requiredDifferentlyAbledChilds(false);
		} */
		
		/* if ( ${applicantPostAssoc.lightMotorVechicle eq false} ) {
			postSelectionObj.showElementsByClass('assistantJuniorLearningLicenseRadioToggle');
			//$( 'form#assistantJuniorForm' ).find('input[type=radio][name=learningLicense]').attr("required", true);
		} else {
			postSelectionObj.hideElementsByClass('assistantJuniorLearningLicenseRadioToggle');
			//$( 'form#assistantJuniorForm' ).find('input[type=radio][name=learningLicense]').attr("required", false);
		} */
		
	}
	
	function checkExperienceAssistantJr()
	{
		var val=0;
    	$(".assistantJuniorExperiencedToggle").find('.telToCheck').each(function(){
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
			$(".assistantJuniorExperiencedToggle").find('.telToCheck').parent().addClass('has-error');
    		return true;
    	}
		else
		{
			$(".assistantJuniorExperiencedToggle").find('.telToCheck').parent().removeClass( 'has-error has-danger' );
			return false;
		}
	}
	
	$( 'form#assistantJuniorForm' ).find('input[type=radio][name=experienced]').unbind().change(function() {
        if (this.value == '1') {
       	 	postSelectionObj.showElementsByClass('assistantJuniorExperiencedToggle');
        } else {
        	$("#assistantJuniorCompanyName").parent().parent().find("label.error").empty();
	       	$("#assistantJuniorTotalExperienceInYears").parent().parent().find("label.error").empty();
	       	postSelectionObj.hideElementsByClass('assistantJuniorExperiencedToggle');
	       	postSelectionObj.resetTextFieldById('assistantJuniorCompanyName');
	       	postSelectionObj.resetTextFieldById('assistantJuniorTotalExperienceInYears');
	       	postSelectionObj.resetTextFieldById('assistantJuniorTotalExperienceInMonths');
        }
    });
	
	$( 'form#assistantJuniorForm' ).find('input[type=radio][name=apprenticeshipInMSRTC]').unbind().change(function() {
        if (this.value == '1') {
       	 	postSelectionObj.showElementsByClass('assistantJuniorApprenticeshipInMSRTCToggle');
        } else {
        	$("#apprenticeshipInMSRTCTrade").parent().parent().find("label.error").empty();
	       	$("#apprenticeshipInMSRTCYear").parent().parent().find("label.error").empty();
	       	$("#apprenticeshipInMSRTCDivision").parent().parent().find("label.error").empty();
	       	postSelectionObj.hideElementsByClass('assistantJuniorApprenticeshipInMSRTCToggle');
	       	postSelectionObj.resetTextFieldById('apprenticeshipInMSRTCTrade');
	       	postSelectionObj.resetTextFieldById('apprenticeshipInMSRTCYear');
	       	postSelectionObj.resetTextFieldById('apprenticeshipInMSRTCDivision');
        }
    });
	
	/* $( 'form#assistantJuniorForm' ).find('input[type=radio][name=differentlyAbled]').unbind().change(function() {
		actionOnCheckBoxSelected();
        if (this.value == '1') {
       	 	postSelectionObj.showElementsByClass('assistantJuniorDifferentlyAbledToggle');
       		requiredDifferentlyAbledChilds(true);
        } else {
	       	postSelectionObj.hideElementsByClass('assistantJuniorDifferentlyAbledToggle');
	       	postSelectionObj.resetCheckBoxById('assistantJunior-differentlyAbled-blindnessAndLowVision');
       	 	postSelectionObj.resetCheckBoxById('assistantJunior-differentlyAbled-deafAndMute');
       	 	postSelectionObj.resetCheckBoxById('assistantJunior-differentlyAbled-locomotorOrCerebralPalsy');
       	 	requiredDifferentlyAbledChilds(false);
        }
    }); */
	
	/* $( '.assistantJuniorDifferentlyAbledToggle' ).find('input').click(function() {
		actionOnCheckBoxSelected();
	}); */
	
	/* function actionOnCheckBoxSelected() {
		var total = $( '.assistantJuniorDifferentlyAbledToggle' ).find('input:checked').length;
	  	if (total > 0) {
	  		requiredDifferentlyAbledChilds(false);
	  	} else {
	  		requiredDifferentlyAbledChilds(true);
	  	}
	} */
/*

	function showEligibilityCriteriaPDF() {
		var url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/viewPdf.pdf'/>";
		window.open(url,'_blank');
	}*/
	
	$( 'form#assistantJuniorForm' ).find('input[type=radio][name=lightMotorVechicle]').unbind().change(function() {
	    if (this.value == '1') {
	    	$('.assistantJuniorLightMotorVechicleToggle').attr("required", true);
	   	 	postSelectionObj.showElementsByClass('assistantJuniorLightMotorVechicleToggle');
	   	 	resetFieldsAndAttributes(['assistantJunior-lightMotorVechicleLicenseNo', 'assistantJunior-lightMotorVechicleIssueDate'], true);
	   	 	//$( 'form#assistantJuniorForm' ).find('input[type=radio][name=learningLicense]').attr("required", false).attr('checked', false);
	   	 	//postSelectionObj.hideElementsByClass('assistantJuniorLearningLicenseRadioToggle');
	   	 	//assistantJuniorEffectLearningLicenseChild();
	   	    
	    } else {
	    	$('.assistantJuniorLightMotorVechicleToggle').attr("required", false);
	   	 	postSelectionObj.hideElementsByClass('assistantJuniorLightMotorVechicleToggle');
	   	 	postSelectionObj.resetTextFieldById('assistantJunior-lightMotorVechicleLicenseNo');
	   	 	postSelectionObj.resetTextFieldById('assistantJunior-lightMotorVechicleIssueDate');
	   	 	resetFieldsAndAttributes(['assistantJunior-lightMotorVechicleLicenseNo', 'assistantJunior-lightMotorVechicleIssueDate'], false);
	   	    $("#assistantJunior-lightMotorVechicleLicenseNo").parent().find('label.error').empty();
		    $("#assistantJunior-lightMotorVechicleIssueDate").parent().parent().find('label.error').empty();
//	   	 	commonObj.showAlert("<fmt:message key='assistantJunior.light.motor.vehicle.no.msg' />");
			//New changes
	   		commonObj.showAgreeDisAgreePopup("<fmt:message key='assistantJunior.light.motor.vehicle.no.msg' />", assistantJuniorLightMotoVechiclePopup, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
		    //$( 'form#assistantJuniorForm' ).find('input[type=radio][name=learningLicense]').attr("required", true);
		    //postSelectionObj.showElementsByClass('assistantJuniorLearningLicenseRadioToggle');
	    }
	});


	/* $( 'form#assistantJuniorForm' ).find('input[type=radio][name=learningLicense]').unbind().change(function() {
	    if (this.value == '1') {
	    	$('.assistantJuniorLearningLicenseToggle').attr("required", true);
	   	 	postSelectionObj.showElementsByClass('assistantJuniorLearningLicenseToggle');
	   	 	resetFieldsAndAttributes(['assistantJunior-learningLicenseNo', 'assistantJunior-learningLicenseIssueDate'], true);
	   	    
	    } else {
// 	    	assistantJuniorEffectLearningLicenseChild();
//	   	 	commonObj.showAlert("<fmt:message key='assistantJunior.light.motor.vehicle.no.msg' />");
	   		commonObj.showAgreeDisAgreePopup("<fmt:message key='assistantJunior.light.motor.vehicle.no.msg' />", assistantJuniorLightMotoVechiclePopup, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
	    }
	}); */

	function assistantJuniorEffectLMVLicenseChild() {
		$('.assistantJuniorLightMotorVechicleToggle').attr("required", false);
	 	postSelectionObj.hideElementsByClass('assistantJuniorLightMotorVechicleToggle');
//	 	postSelectionObj.resetTextFieldById('assistantJunior-learningLicenseNo');
//	 	postSelectionObj.resetTextFieldById('assistantJunior-learningLicenseIssueDate');
	 	resetFieldsAndAttributes(['assistantJunior-lightMotorVechicleLicenseNo', 'assistantJunior-lightMotorVechicleIssueDate'], false);
	    $("#assistantJunior-lightMotorVechicleLicenseNo").parent().find('label.error').empty();
	    $("#assistantJunior-lightMotorVechicleIssueDate").parent().parent().find('label.error').empty();
	}

	function assistantJuniorLightMotoVechiclePopup(flag) {
		if(!flag) {
			$('#assistantJunior-lightMotorVechicle-yes').prop('checked', true);
			$('.assistantJuniorLightMotorVechicleToggle').attr("required", true);
	   	 	postSelectionObj.showElementsByClass('assistantJuniorLightMotorVechicleToggle');
	   	 	resetFieldsAndAttributes(['assistantJunior-lightMotorVechicleLicenseNo', 'assistantJunior-lightMotorVechicleIssueDate'], true);
		} else {
			assistantJuniorEffectLMVLicenseChild();
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

</script>
	 <div id="downloadEligibilityCriteria" class="form-group" align="right">
	        <div class="col-sm-12" align="pull-right">
	            <a href="javascript:void(0);" onclick="javascript:showEligibilityCriteriaPDF(${post.postId})"><b><fmt:message key="postEligibilityCriteriaLink"/></b></a>
	        </div>
	    </div>

<form class="form-horizontal" name="assistantJuniorForm" id="assistantJuniorForm" action="<c:url value='/applicant?operation=saveApplicantPostDetails'/>" method="POST" style="z-index:0;">

	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="hidden" name="id" value="${applicantPostAssoc.id}"/>
	<input type="hidden" name="postId" value="${post.postId}"/>
	<input type="hidden" name="status" id="status"  value="${ applicantPostAssoc.status }"/>

	<div class="form-group">
		<label class="control-label col-sm-5"><fmt:message key="assistantJunior.itiPass"/>: <span class="red">*</span></label>
		<div class="col-sm-4">
			<div class="radio radio-inline">
				<input name="itiPassed" ${ applicantPostAssoc.itiPassed ? 'checked="checked"':''} id="assistantJunior-itiPassed-yes" value="1" type="radio"/>
				<label for="assistantJunior-itiPassed-yes"> <fmt:message key="yes"/> </label>
			</div>
			<div class="radio radio-inline">
				<input class="radiosToCheck" name="itiPassed" ${ applicantPostAssoc.itiPassed == false? 'checked="checked"':''} id="assistantJunior-itiPassed-no" value="0" type="radio" />
				<label for="assistantJunior-itiPassed-no"> <fmt:message key="no"/> </label>
			</div>
			<div class="help-block with-errors"></div>
		</div>
	</div>
	
	<%-- <div class="form-group ">
		<label class="control-label col-sm-5"><fmt:message key="assistantJunior.otherQualification"/>: </label>
		<div class="col-sm-4">
			<input value="${ applicantPostAssoc.otherQualificationDetails }"  name="otherQualificationDetails" class="form-control" id="assistantJunior-otherQualificationDetails" type="text" placeholder="<fmt:message key="assistantJunior.otherQualification"/>" maxlength="100"/>
			<div class="help-block with-errors"></div>
		</div>
	</div> --%>
	
	<div class="form-group">
		<label class="control-label col-sm-5 " for="assistantJunior-divisionId"><fmt:message key="assistantJunior.division"/>:<span class="red">*</span></label>
		<div class="col-sm-4">
			<select id="assistantJunior-divisionId" name="divisionId" class="form-control" data-size="5" required>
				<option value="">-- <fmt:message key="division.select"/> --</option>
				<c:forEach items="${assistantJrDivisionList}" var="postdivision">
					<option value="${postdivision.division.divisionId}" ${ postdivision.division.divisionId eq applicantPostAssoc.divisionId? 'selected':'' }><fmt:message key="${ postdivision.division.messageKey }" /></option>
				</c:forEach>
			</select>
			<div class="help-block with-errors"></div>
		</div>
	</div>
	
	 <div class="form-group">
		<label class="control-label col-sm-5" for="assistantJunior-tradeId"><fmt:message key="assistantJunior.trade"/>: <span class="red">*</span> </label>
		<div class="col-sm-4">
			<select id="assistantJunior-tradeId" name="tradeId" class="form-control" required oninvalid="this.setCustomValidity('<fmt:message key="validation.requiredfield"/>')">
				<option value="">-- <fmt:message key="assistantJunior.select"/> --</option>
				<c:forEach items="${tradeList}" var="trade">
					<option value="${trade.id}" ${ trade.id eq applicantPostAssoc.tradeId? 'selected=selected':'' }> <fmt:message key="${ trade.messageKey }"/> </option>
				</c:forEach>
			</select>
			<div class="help-block with-errors"></div>
		</div>
	</div>
	
	<div class="form-group ">
		<label class="control-label col-sm-5"><fmt:message key="assistantJunior.experience"/>:</label>
		<div class="col-sm-4">
			<div class="radio radio-inline">
				<input name="experienced" ${ applicantPostAssoc.experienced ? 'checked="checked"':''} id="assistantJunior-experienced-yes" value="1" type="radio"/>
				<label for="assistantJunior-experienced-yes"> <fmt:message key="yes"/> </label>
			</div>
			<div class="radio radio-inline">
				<input name="experienced" ${ applicantPostAssoc.experienced == false ? 'checked="checked"':''} id="assistantJunior-experienced-no" value="0" type="radio"/>
				<label for="assistantJunior-experienced-no"> <fmt:message key="no"/> </label>
			</div>
			<div class="help-block with-errors"></div>
		</div>
	</div>
	
	<div class="form-group assistantJuniorExperiencedToggle">
        <label class="control-label col-sm-5" for="companyName"><fmt:message key="assistantJunior.experienced.companyName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.companyName}" type="text" class="form-control" id="assistantJuniorCompanyName" placeholder="<fmt:message key="assistantJunior.experienced.companyName"/>" name="companyName" maxlength="150">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group assistantJuniorExperiencedToggle">
        <label class="control-label col-sm-5" for="totalExperienceInYears"><fmt:message key="assistantJunior.experienced.totalExperience"/>: <span class="red">*</span></label>
        <div class="col-sm-2">
            <input value="${applicantPostAssoc.totalExperienceInYears}" type="tel" class="form-control telToCheck" id="assistantJuniorTotalExperienceInYears" placeholder="<fmt:message key="assistantJunior.experienced.inYears"/>" name="totalExperienceInYears"  min="0" maxlength="2">
            <div class="help-block with-errors"></div>
        </div>
        <div class="col-sm-2">
            <input value="${applicantPostAssoc.totalExperienceInMonths}" type="tel" class="form-control telToCheck" id="assistantJuniorTotalExperienceInMonths" placeholder="<fmt:message key="assistantJunior.experienced.inMonths"/>" name="totalExperienceInMonths"  min="0" maxlength="2">
            <div class="help-block with-errors"></div>
        </div>
    </div>

	<div class="form-group">
		<label class="control-label col-sm-5 " for="input-nightBlindness"><fmt:message key="assistantJunior.nightBlindness"/>: <span class="red">*</span></label>
		<div class="col-sm-4">
			<div class="radio radio-inline">
				<input class="radiosToCheck" name="nightBlindness" ${ applicantPostAssoc.nightBlindness ? 'checked="checked"':''} id="assistantJunior-nightBlindness-yes" value="1" type="radio" />
				<label for="assistantJunior-nightBlindness-yes"> <fmt:message key="yes"/> </label>
			</div>
			<div class="radio radio-inline">
				<input name="nightBlindness" ${ applicantPostAssoc.nightBlindness == false ? 'checked="checked"':''} id="assistantJunior-nightBlindness-no" value="0" type="radio" />
				<label for="assistantJunior-nightBlindness-no"> <fmt:message key="no"/> </label>
			</div>
			<div class="help-block with-errors"></div>
		</div>
	</div>

	<div class="form-group">
		<label class="control-label col-sm-5 "><fmt:message key="assistantJunior.colorBlindness"/>: <span class="red">*</span></label>
		<div class="col-sm-4">
			<div class="radio radio-inline">
				<input class="radiosToCheck" name="colorBlindness" ${ applicantPostAssoc.colorBlindness ? 'checked="checked"':''} id="assistantJunior-colorBlindness-yes" value="1" type="radio" />
				<label for="assistantJunior-colorBlindness-yes"> <fmt:message key="yes"/> </label>
			</div>
			<div class="radio radio-inline">
				<input name="colorBlindness" ${ applicantPostAssoc.colorBlindness == false ? 'checked="checked"':''} id="assistantJunior-colorBlindness-no" value="0" type="radio" />
				<label for="assistantJunior-colorBlindness-no"> <fmt:message key="no"/> </label>
			</div>
			<div class="help-block with-errors"></div>
		</div>
	</div>
	
	<div class="form-group">
        <label class="control-label col-sm-5" for="assistantJuniorLightMotorVechicle"><fmt:message key="assistantJunior.light.motor.vehicle"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="lightMotorVechicle" id="assistantJunior-lightMotorVechicle-yes" value="1" type="radio" ${applicantPostAssoc.lightMotorVechicle ? 'checked' : ''} />
                <label for="assistantJunior-lightMotorVechicle-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input name="lightMotorVechicle" id="assistantJunior-lightMotorVechicle-no" value="0" type="radio" ${applicantPostAssoc.lightMotorVechicle == false ? 'checked' : ''} />
                <label for="assistantJunior-lightMotorVechicle-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group assistantJuniorLightMotorVechicleToggle">
        <label class="control-label col-sm-5" for="lightMotorVechicleLicenseNo"><fmt:message key="assistantJunior.light.motor.vehicle.license.no"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.lightMotorVechicleLicenseNo}" type="text"  name="lightMotorVechicleLicenseNo" maxlength="30" class="form-control" id="assistantJunior-lightMotorVechicleLicenseNo" placeholder="<fmt:message key="assistantJunior.light.motor.vehicle.license.no"/>" >
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group assistantJuniorLightMotorVechicleToggle">
        <label class="control-label col-sm-5" for="lightMotorVechicleIssueDate"><fmt:message key="assistantJunior.light.motor.vehicle.license.issue.date"/>: <span class="red">*</span></label>
        <div class="col-sm-3">
        	<div class="input-group date">
	            <input type="datetime" class="form-control" id="assistantJunior-lightMotorVechicleIssueDate" placeholder="<fmt:message key="assistantJunior.light.motor.vehicle.license.issue.date"/>" name="lightMotorVechicleIssueDate" readonly >
	            <div class="input-group-addon" id="assistantJunior-calendarIcon-lightMotorVechicleIssueDate">
					<i class="fa fa-calendar"></i>
				</div>
	            <div class="help-block with-errors"></div>
            </div>
        </div>
    </div>
    
    <%-- <div class="form-group assistantJuniorLearningLicenseRadioToggle">
        <label class="control-label col-sm-5" for="assistantJuniorLightMotorVechicle"><fmt:message key="assistantJunior.learning.license"/>: </label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="learningLicense" id="assistantJunior-learningLicense-yes" value="1" type="radio" ${applicantPostAssoc.learningLicense ? 'checked' : ''} />
                <label for="assistantJunior-learningLicense-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input name="learningLicense" id="assistantJunior-learningLicense-no" value="0" type="radio" ${applicantPostAssoc.learningLicense == false ? 'checked' : ''} />
                <label for="assistantJunior-learningLicense-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group assistantJuniorLearningLicenseToggle">
        <label class="control-label col-sm-5" for="learningLicenseNo"><fmt:message key="assistantJunior.learning.license.no"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.learningLicenseNo}" type="text"  name="learningLicenseNo" maxlength="30" class="form-control" id="assistantJunior-learningLicenseNo" placeholder="<fmt:message key="assistantJunior.learning.license.no"/>" >
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group assistantJuniorLearningLicenseToggle">
        <label class="control-label col-sm-5" for="learningLicenseIssueDate"><fmt:message key="assistantJunior.learning.license.issue.date"/>: <span class="red">*</span></label>
        <div class="col-sm-3">
        	<div class="input-group date">
	            <input  type="datetime" class="form-control" id="assistantJunior-learningLicenseIssueDate" placeholder="<fmt:message key="assistantJunior.learning.license.issue.date"/>" name="learningLicenseIssueDate" readonly >
	            <div class="input-group-addon" id="assistantJunior-calendarIcon-learningLicenseIssueDate">
					<i class="fa fa-calendar"></i>
				</div>
	            <div class="help-block with-errors"></div>
            </div>
        </div>
    </div> --%>
	
	<div class="form-group ">
		<label class="control-label col-sm-5"><fmt:message key="assistantJunior.apprenticeshipInMSRTC"/>:<span class="red">*</span></label>
		<div class="col-sm-4">
			<div class="radio radio-inline">
				<input name="apprenticeshipInMSRTC" ${ applicantPostAssoc.apprenticeshipInMSRTC ? 'checked="checked"':''} id="assistantJunior-apprenticeshipInMSRTC-yes" value="1" type="radio"/>
				<label for="assistantJunior-apprenticeshipInMSRTC-yes"> <fmt:message key="yes"/> </label>
			</div>
			<div class="radio radio-inline">
				<input name="apprenticeshipInMSRTC" ${ applicantPostAssoc.apprenticeshipInMSRTC == false ? 'checked="checked"':''} id="assistantJunior-apprenticeshipInMSRTC-no" value="0" type="radio"/>
				<label for="assistantJunior-apprenticeshipInMSRTC-no"> <fmt:message key="no"/> </label>
			</div>
			<div class="help-block with-errors"></div>
		</div>
	</div>
	
	<div class="form-group assistantJuniorApprenticeshipInMSRTCToggle">
        <label class="control-label col-sm-5" for="trade"><fmt:message key="assistantJunior.trade"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.apprenticeshipInMSRTCTrade}" type="text" class="form-control" id="apprenticeshipInMSRTCTrade" placeholder="<fmt:message key="assistantJunior.trade"/>" name="apprenticeshipInMSRTCTrade" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group assistantJuniorApprenticeshipInMSRTCToggle">
        <label class="control-label col-sm-5" for=year><fmt:message key="assistantJunior.apprenticeshipInMSRTC.year"/>: <span class="red">*</span></label>
        <div class="col-sm-2">
            <input value="${applicantPostAssoc.apprenticeshipInMSRTCYear}" type="tel" class="form-control telToCheck" id="apprenticeshipInMSRTCYear" placeholder="<fmt:message key="assistantJunior.apprenticeshipInMSRTC.year"/>" name="apprenticeshipInMSRTCYear"  min="0" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group assistantJuniorApprenticeshipInMSRTCToggle">
        <label class="control-label col-sm-5" for="division"><fmt:message key="assistantJunior.apprenticeshipInMSRTC.division"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.apprenticeshipInMSRTCDivision}" type="text" class="form-control" id="apprenticeshipInMSRTCDivision" placeholder="<fmt:message key="assistantJunior.apprenticeshipInMSRTC.division"/>" name="apprenticeshipInMSRTCDivision" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
	
	<%-- <div class="form-group">
		<label class="control-label col-sm-5 "><fmt:message key="assistantJunior.differentlyAbled"/>: <span class="red">*</span></label>
		<div class="col-sm-4">
			<div class="radio radio-inline">
				<input type="radio" id="assistantJunior-differentlyAbledYes" value="1" name="differentlyAbled" ${ applicantPostAssoc.differentlyAbled ? 'checked="checked"':''} required>
				<label for="assistantJunior-differentlyAbledYes"> <fmt:message key="yes"/> </label>
			</div>
			<div class="radio radio-inline">
				<input type="radio" id="assistantJunior-differentlyAbledNo" value="0" name="differentlyAbled" ${ applicantPostAssoc.differentlyAbled == false ? 'checked="checked"':''} required>
				<label for="assistantJunior-differentlyAbledNo"> <fmt:message key="no"/> </label>
			</div>
			<div class="help-block with-errors"></div>
		</div>
	</div>
	
	<div class="form-group assistantJuniorDifferentlyAbledToggle">
		<div class="col-sm-5">&nbsp;</div>
        <label class="control-label col-sm-5" for="assistantJunior-differentlyAbled-blindnessAndLowVision"><fmt:message key="assistantJunior.differentlyAbled.blindnessAndLowVision"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
        	<div class="checkbox">
	        	<input value="1" type="checkbox" class="form-control"  id="assistantJunior-differentlyAbled-blindnessAndLowVision" placeholder="<fmt:message key="assistantJunior.differentlyAbled.blindnessAndLowVision"/>" name="blindnessAndLowVision" ${applicantPostAssoc.blindnessAndLowVision ? 'checked' : ''} required  maxlength="100">
	        	<label for="assistantJunior-differentlyAbled-blindnessAndLowVision"><fmt:message key="assistantJunior.differentlyAbled.blindnessAndLowVision"/></label><span class="red">*</span>
        	</div>
           	<div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group assistantJuniorDifferentlyAbledToggle">
    	<div class="col-sm-5">&nbsp;</div>
        <label class="control-label col-sm-5" for="deafAndMute"><fmt:message key="assistantJunior.differentlyAbled.deafAndMute"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
        	<div class="checkbox">
	        	<input value="1" type="checkbox" class="form-control"  id="assistantJunior-differentlyAbled-deafAndMute" placeholder="<fmt:message key="assistantJunior.differentlyAbled.deafAndMute"/>" name="deafAndMute" ${applicantPostAssoc.deafAndMute ? 'checked' : ''} required  maxlength="100">
	        	<label for="assistantJunior-differentlyAbled-deafAndMute"><fmt:message key="assistantJunior.differentlyAbled.deafAndMute"/></label><span class="red">*</span>
        	</div>
           	<div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group assistantJuniorDifferentlyAbledToggle">
    	<div class="col-sm-5">&nbsp;</div>
        <label class="control-label col-sm-5" for="locomotorOrCerebralPalsy"><fmt:message key="assistantJunior.differentlyAbled.locomotorOrCerebralPalsy"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
        	<div class="checkbox">
	        	<input value="1" type="checkbox" class="form-control"  id="assistantJunior-differentlyAbled-locomotorOrCerebralPalsy" placeholder="<fmt:message key="assistantJunior.differentlyAbled.locomotorOrCerebralPalsy"/>" name="locomotorOrCerebralPalsy" ${applicantPostAssoc.locomotorOrCerebralPalsy ? 'checked' : ''} required  maxlength="100">
	        	<label for="assistantJunior-differentlyAbled-locomotorOrCerebralPalsy"><fmt:message key="assistantJunior.differentlyAbled.locomotorOrCerebralPalsy"/></label><span class="red">*</span>
        	</div>
           	<div class="help-block with-errors"></div>
        </div>
    </div> --%>
	
	<jsp:include page="postFooter.jsp">
		<jsp:param name="isPostSubmitted" value="${ applicantPostAssoc.status eq 2 || applicantPostAssoc.status eq 3 }"/>
		<jsp:param name="formId" value="assistantJuniorForm"/>
		<jsp:param name="postId" value="${post.postId}"/>
		<jsp:param name="disableFormAfterLastDateOver" value="${disableFormAfterLastDateOver}"/>
	</jsp:include>

</form>


<script>
 $(document).ready(function(){
 $("form[name='assistantJuniorForm']").validate({
// 	ignore:"#assistantJunior-tradeId",
 	rules:{
	 		itiPassed : "required",
	 		companyName: {required: true},
	 		totalExperienceInYears :{required: true, numbersonly:true, max:100},
	 		totalExperienceInMonths :{required: true, numbersonly:true, max: 11} ,
	 		nightBlindness: "required",
	 		colorBlindness: "required",
	 		lightMotorVechicle: "required",
	 		apprenticeshipInMSRTC: "required",
	 		apprenticeshipInMSRTCTrade :{required: true} ,
	 		apprenticeshipInMSRTCYear :{required: true} ,
	 		apprenticeshipInMSRTCDivision :{required: true} 
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