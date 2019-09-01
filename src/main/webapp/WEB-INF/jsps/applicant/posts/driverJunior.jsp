<%@ include file="../../common/taglibs.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1" %>

<link rel="stylesheet" href="<c:url value='/static/libs/bootstrap-fileinput/css/fileinput.min.css'/>" >
<script type="text/javascript" src="<c:url value='/static/libs/bootstrap-fileinput/js/fileinput.min.js'/>"></script>

<link rel="stylesheet" href="<c:url value='/static/libs/imageviewer/dist/viewer.min.css'/>" >
<script type="text/javascript" src="<c:url value='/static/libs/imageviewer/dist/viewer.min.js'/>"></script>

<script>
  
	$(document).ready(function() {
		postSelectionObj.disableFormFields ("driverForm", '${applicantPostAssoc.status}');
		postSelectionObj.bindPostForm("driverForm");
	    
		postSelectionObj.validateDate('driverHeavyDrivingLicenseIssueDate','driverHeavyDrivingLicenseEndDate');
	    postSelectionObj.validateDate('driverConductorBatchNumberIssueDate','driverConductorBatchNumberEndDate');

	    
		
	   $('#driverHeavyDrivingLicenseIssueDate').datetimepicker({
           format: 'DD/MM/YYYY',
           ignoreReadonly: true,
           showTodayButton: true,
           minDate: postSelectionObj.minDate(),
           maxDate: postSelectionObj.maxDate()
           //date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseIssueDate}" />'
       });
       
       $('#driverCalendarIconHeavyDrivingLicenseIssueDate').click(function() {
           $('#driverHeavyDrivingLicenseIssueDate').data("DateTimePicker").show();
       });
	    
	   $('#driverHeavyDrivingLicenseEndDate').datetimepicker({
           format: 'DD/MM/YYYY',
           ignoreReadonly: true,
           showTodayButton: true,
           minDate: postSelectionObj.minDate(),
           maxDate: postSelectionObj.maxDate()
          // date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseEndDate}" />'
       });
       
       $('#driverCalendarIconHeavyDrivingLicenseEndDate').click(function() {
           $('#driverHeavyDrivingLicenseEndDate').data("DateTimePicker").show();
       });
	       
		$('#driverConductorBatchNumberIssueDate').datetimepicker({
           format: 'DD/MM/YYYY',
           ignoreReadonly: true,
           showTodayButton: true,
           minDate: postSelectionObj.minDate(),
           maxDate: postSelectionObj.maxDate()
           //date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicantPostAssoc.conductorBatchNumberIssueDate}" />'
       });
       $('#driverCalendarIconConductorBatchNumberIssueDate').click(function() {
           $('#driverConductorBatchNumberIssueDate').data("DateTimePicker").show();
       });
		
	   $('#driverConductorBatchNumberEndDate').datetimepicker({
           format: 'DD/MM/YYYY',
           ignoreReadonly: true,
           showTodayButton: true,
           minDate: postSelectionObj.minDate(),
           maxDate: postSelectionObj.maxDate()
           //date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicantPostAssoc.conductorBatchNumberEndDate}" />'
       });
       $('#driverCalendarIconConductorBatchNumberEndDate').click(function() {
           $('#driverConductorBatchNumberEndDate').data("DateTimePicker").show();
       });

       checkIfShowOrHideElements();

       var licenceIssuedate = '${applicantPostAssoc.heavyDrivingLicenseIssueDate}';
		if(licenceIssuedate != 'undefined' || licenceIssuedate != null || licenceIssuedate !='' )
			$('#driverHeavyDrivingLicenseIssueDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseIssueDate}" />');
		
	   var licenceEnddate = '${applicantPostAssoc.heavyDrivingLicenseEndDate}';
		if(licenceEnddate != 'undefined' || licenceEnddate != null || licenceEnddate !='' )
			$('#driverHeavyDrivingLicenseEndDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseEndDate}" />');

		var batchNumberIssuedate = '${applicantPostAssoc.conductorBatchNumberIssueDate}';
		if(batchNumberIssuedate != 'undefined' || batchNumberIssuedate != null || batchNumberIssuedate !='')
			$('#driverConductorBatchNumberIssueDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicantPostAssoc.conductorBatchNumberIssueDate}" />');
		
		var batchNumberEnddate = '${applicantPostAssoc.conductorBatchNumberEndDate}';
		if(batchNumberEnddate != 'undefined' || batchNumberEnddate != null || batchNumberEnddate !='')
			$('#driverConductorBatchNumberEndDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicantPostAssoc.conductorBatchNumberEndDate}" />');
	});

	
	function checkIfShowOrHideElements() {
		/* if ('${applicantPostAssoc.differentlyAbled}'=='' || '${applicantPostAssoc.differentlyAbled}'=='false') {
			postSelectionObj.hideElementsByClass('driverDifferentlyAbledToggle');
			requiredDifferentlyAbledChilds(false);
		} */
		
		if ('${applicantPostAssoc.ownHeavyDrivingLicenseNumber}'=='' || '${applicantPostAssoc.ownHeavyDrivingLicenseNumber}'=='false') {
			postSelectionObj.hideElementsByClass('driverOwnHeavyDrivingLicenseToggle');
		}
		
		if ('${applicantPostAssoc.ownPsvBatchNumber}'=='' || '${applicantPostAssoc.ownPsvBatchNumber}'=='false') {
			postSelectionObj.hideElementsByClass('driverOwnPsvBadgeToggle');
		}
		
		if ( '${applicantPostAssoc.ownConductorBatchNumber}'=='' || '${applicantPostAssoc.ownConductorBatchNumber}'=='false') {
// 			requiredConductorBatchChilds(false);
			 $("#driverConductorBatchNumber").parent().parent().find("label.error").empty();
			 $("#driverConductorBatchNumberIssueDate").parent().parent().find("label.error").empty();
			 $("#driverConductorBatchNumberEndDate").parent().parent().find("label.error").empty();
			 postSelectionObj.hideElementsByClass('driverOwnConductorBatchToggle');
		}
	
		if ('${applicantPostAssoc.experienced}'=='' || '${applicantPostAssoc.experienced}'=='false') {
			postSelectionObj.hideElementsByClass('driverExperiencedToggle');
		}
		
		if ('${applicantPostAssoc.pastAccidentalOrDeathIncident}'=='' || '${applicantPostAssoc.pastAccidentalOrDeathIncident}'=='false') {
			//postSelectionObj.hideElementsByClass('driverPastAccidentalToggle');
			//$( '.driverPastAccidentalToggle' ).find('input').prop('required', false);
			
		} 
	}	
	
	function requiredConductorBatchChilds(flag) {
		$( '.driverOwnConductorBatchToggle' ).find('input').prop('required', flag);
	}
	
	/* function requiredDifferentlyAbledChilds(flag) {
		$( '.driverDifferentlyAbledToggle' ).find('input').prop('required', flag);
	} */
	
	/* $( 'form#driverForm' ).find('input[type=radio][name=differentlyAbled]').unbind().change(function() {
		 actionOnCheckBoxSelected();
         if (this.value == '1') {
        	 postSelectionObj.showElementsByClass('driverDifferentlyAbledToggle');
        	 //requiredDifferentlyAbledChilds(true);
        	 $( '.driverDifferentlyAbledToggle' ).find('input').prop('required', true);
         } else {
        	 postSelectionObj.hideElementsByClass('driverDifferentlyAbledToggle');
        	 postSelectionObj.resetCheckBoxById('driver-differentlyAbled-blindnessAndLowVision');
        	 postSelectionObj.resetCheckBoxById('driver-differentlyAbled-deafAndMute');
        	 postSelectionObj.resetCheckBoxById('driver-differentlyAbled-locomotorOrCerebralPalsy');
        	 //requiredDifferentlyAbledChilds(false);
        	 $( '.driverDifferentlyAbledToggle' ).find('input').prop('required', false);
         }
     }); */
	 
	$( 'form#driverForm' ).find('input[type=radio][name=ownHeavyDrivingLicenseNumber]').unbind().change(function() {
         if (this.value == '1') {
        	 postSelectionObj.showElementsByClass('driverOwnHeavyDrivingLicenseToggle');
         } else {
        	 postSelectionObj.hideElementsByClass('driverOwnHeavyDrivingLicenseToggle');
        	 postSelectionObj.resetTextFieldById('driverHeavyDrivingLicenseNumber');
        	 postSelectionObj.resetTextFieldById('driverHeavyDrivingLicenseIssueDate');
        	 postSelectionObj.resetTextFieldById('driverHeavyDrivingLicenseEndDate');
         }
     });
	 
	$( 'form#driverForm' ).find('input[type=radio][name=ownPsvBatchNumber]').unbind().change(function() {
         if (this.value == '1') {
        	 postSelectionObj.showElementsByClass('driverOwnPsvBadgeToggle');
         } else {
        	 postSelectionObj.hideElementsByClass('driverOwnPsvBadgeToggle');
        	 postSelectionObj.resetTextFieldById('driverPsvBatchNumber');
         }
     });
	 
	$( 'form#driverForm' ).find('input[type=radio][name=ownConductorBatchNumber]').unbind().change(function() {
         if (this.value == '1') {
        	 postSelectionObj.showElementsByClass('driverOwnConductorBatchToggle');
//         	 requiredConductorBatchChilds(true);
         } else {
        	
        	 postSelectionObj.resetTextFieldById('driverConductorBatchNumber');
        	 postSelectionObj.resetTextFieldById('driverConductorBatchNumberIssueDate');
        	 postSelectionObj.resetTextFieldById('driverConductorBatchNumberEndDate');
			 $("#driverConductorBatchNumber").parent().parent().find("label.error").empty();
			 $("#driverConductorBatchNumberIssueDate").parent().parent().find("label.error").empty();
			 $("#driverConductorBatchNumberEndDate").parent().parent().find("label.error").empty();
			 postSelectionObj.hideElementsByClass('driverOwnConductorBatchToggle');
			 //commonObj.showAlert("<fmt:message key='conductorbatch.onNoSelect.alert' />");
//              $(this).parent().parent().parent().removeClass( 'has-error has-danger' );
			 commonObj.showAgreeDisAgreePopup("<fmt:message key='conductorbatch.onNoSelect.alert' />", chargemanJuniorAgreeDisAgreePopup, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
         }
     });

	function chargemanJuniorAgreeDisAgreePopup(flag)
	{
	   	if(!flag)
	   	{
	   		$('#driver-ownConductorBatchNumber-yes').prop('checked', true);
	   		$('driverOwnConductorBatchToggle').find('input').prop('required', true);
	   		postSelectionObj.showElementsByClass('driverOwnConductorBatchToggle');
     	 	postSelectionObj.resetTextFieldById('driverConductorBatchNumber');
	       	postSelectionObj.resetTextFieldById('driverConductorBatchNumberIssueDate');
	        postSelectionObj.resetTextFieldById('driverConductorBatchNumberEndDate');
			//$("#driverConductorBatchNumber").parent().parent().find("label.error").empty();
			//$("#driverConductorBatchNumberIssueDate").parent().parent().find("label.error").empty();
			//$("#driverConductorBatchNumberEndDate").parent().parent().find("label.error").empty();
	   	}
	}		
	 
	$( 'form#driverForm' ).find('input[type=radio][name=experienced]').unbind().change(function() {
         if (this.value == '1') {
        	 postSelectionObj.showElementsByClass('driverExperiencedToggle');
         } else {
        	 postSelectionObj.hideElementsByClass('driverExperiencedToggle');
        	 postSelectionObj.resetTextFieldById('driverCompanyName');
        	 postSelectionObj.resetTextFieldById('driverTotalExperienceInYears');
        	 postSelectionObj.resetTextFieldById('driverTotalExperienceInMonths');
         }
     });
	 
	$( 'form#driverForm' ).find('input[type=radio][name=pastAccidentalOrDeathIncident]').unbind().change(function() {
         if (this.value == '1') {
        	 //postSelectionObj.showElementsByClass('driverPastAccidentalToggle');
        	 //$( '.driverPastAccidentalToggle' ).find('input').prop('required', true);
         } else {
        	 //postSelectionObj.hideElementsByClass('driverPastAccidentalToggle');
        	 postSelectionObj.resetTextFieldById('driverPastAccidentalOrDeathIncidentReason');
        	// $( '.driverPastAccidentalToggle' ).find('input').prop('required', false);
         }
     });
	
	/* $( '.driverDifferentlyAbledToggle' ).find('input').click(function() {
		actionOnCheckBoxSelected();
	}); */
	
	/* function actionOnCheckBoxSelected() {
		var total = $( '.driverDifferentlyAbledToggle' ).find('input:checked').length;
	  	if (total > 0) {
	  		requiredDifferentlyAbledChilds(false);
	  	} else {
	  		requiredDifferentlyAbledChilds(true);
	  	}
	} */
	
	$('#dbExperienceLetterScanCopy').viewer();

    function showPdfInNewTab() {
        var url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/driverExperienceLetter.pdf'/>";
        window.open(url,'_blank');
    }

	/*
	function showEligibilityCriteriaPDF() {
		var url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/viewPdf.pdf'/>";
		window.open(url,'_blank');
	}*/
</script>   
 <div id="downloadEligibilityCriteria" class="form-group" align="right">
        <div class="col-sm-12" align="pull-right">
            <a href="javascript:void(0);" onclick="javascript:showEligibilityCriteriaPDF(${post.postId})"><b><fmt:message key="postEligibilityCriteriaLink"/></b></a>
        </div>
    </div>
<form class="form-horizontal" name="driverForm" id="driverForm" action="<c:url value='/applicant?operation=saveApplicantPostDetails'/>" method="POST">

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${applicantPostAssoc.id}"/>
    <input type="hidden" name="postId" value="${post.postId}"/>
    <input type="hidden" name="status" id="status"  value="${ applicantPostAssoc.status }"/>

    <div class="form-group">
        <label class="control-label col-sm-5" for="sscPassed"><fmt:message key="driver.educationSSCpass"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="sscPassed" id="driver-sscPassed-yes" value="1" type="radio" ${applicantPostAssoc.sscPassed ? 'checked' : ''} />
                <label for="driver-sscPassed-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="sscPassed" id="driver-sscPassed-no" value="0" type="radio" ${applicantPostAssoc.sscPassed == false ? 'checked' : ''} />
                <label for="driver-sscPassed-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-5" for="otherQualificationDetails"><fmt:message key="driver.otherQualification"/>: </label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.otherQualificationDetails}" type="text" class="form-control" id="driverOtherQualificationDetails" placeholder="<fmt:message key="driver.otherQualification"/>" name="otherQualificationDetails" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>

<div class="form-group">
        <label for="division" class="col-sm-5 control-label"><fmt:message key="driver.division" />:<span class="red">*</span></label>
        <div class="col-sm-4">
            <select id="driverDivision" name="divisionId" class="form-control" data-size="5" required oninvalid="this.setCustomValidity('<fmt:message key="validation.requiredfield"/>')">
                <option value="">-- <fmt:message key="division.select"/> --</option>
                <c:forEach items="${driverJrDivisionList}" var="postdivision">
					<option value="${postdivision.division.divisionId}" ${ postdivision.division.divisionId eq applicantPostAssoc.divisionId? 'selected':'' }><fmt:message key="${ postdivision.division.messageKey }" /></option>
				</c:forEach>
			</select>
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-5" for="nightBlindness"><fmt:message key="driver.nightBlindness"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="nightBlindness" id="driver-nightBlindness-yes" value="1" type="radio" ${applicantPostAssoc.nightBlindness ? 'checked' : ''} />
                <label for="driver-nightBlindness-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input name="nightBlindness"  id="driver-nightBlindness-no" value="0" type="radio" ${applicantPostAssoc.nightBlindness == false  ? 'checked' : ''} />
                <label for="driver-nightBlindness-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-5" for="colorBlindness"><fmt:message key="driver.colorBlindness"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="colorBlindness" id="driver-colorBlindness-yes" value="1" ${applicantPostAssoc.colorBlindness ? 'checked' : ''} type="radio" />
                <label for="driver-colorBlindness-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input name="colorBlindness" id="driver-colorBlindness-no" value="0" type="radio" ${applicantPostAssoc.colorBlindness == false  ? 'checked' : ''} />
                <label for="driver-colorBlindness-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group">
        <label class="control-label col-sm-5" for="visionAcuity"><fmt:message key="driver.visionAcuity"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="visionAcuity" id="driver-visionAcuity-yes" value="1" type="radio" ${applicantPostAssoc.visionAcuity ? 'checked' : ''} />
                <label for="driver-visionAcuity-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="visionAcuity" id="driver-visionAcuity-no" value="0" type="radio" ${applicantPostAssoc.visionAcuity == false  ? 'checked' : ''} />
                <label for="driver-visionAcuity-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <%-- <div class="form-group">
        <label class="control-label col-sm-5" for="differentlyAbled"><fmt:message key="driver.differentlyAbled"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="differentlyAbled" id="driver-differentlyAbled-yes" value="1" type="radio" ${applicantPostAssoc.differentlyAbled ? 'checked' : ''} required/>
                <label for="driver-differentlyAbled-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input name="differentlyAbled" id="driver-differentlyAbled-no" value="0" type="radio" ${applicantPostAssoc.differentlyAbled == false  ? 'checked' : ''} required/>
                <label for="driver-differentlyAbled-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group driverDifferentlyAbledToggle">
    	<div class="col-sm-5">&nbsp;</div>
        <label class="control-label col-sm-5" for="driver-differentlyAbled-blindnessAndLowVision"><fmt:message key="driver.differentlyAbled.blindnessAndLowVision"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
        	<div class="checkbox">
	        	<input value="1" type="checkbox" class="form-control"  id="driver-differentlyAbled-blindnessAndLowVision" placeholder="<fmt:message key="driver.differentlyAbled.blindnessAndLowVision"/>" name="blindnessAndLowVision" ${applicantPostAssoc.blindnessAndLowVision ? 'checked' : ''} required  maxlength="100">
	        	<label for="driver-differentlyAbled-blindnessAndLowVision"><fmt:message key="driver.differentlyAbled.blindnessAndLowVision"/></label><span class="red">*</span>
        	</div>
           	<div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group driverDifferentlyAbledToggle">
    	<div class="col-sm-5">&nbsp;</div>
        <label class="control-label col-sm-5" for="driver-differentlyAbled-deafAndMute"><fmt:message key="driver.differentlyAbled.deafAndMute"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
        	<div class="checkbox">
        		<input value="1" type="checkbox" class="form-control"  id="driver-differentlyAbled-deafAndMute" placeholder="<fmt:message key="driver.differentlyAbled.deafAndMute"/>" name="deafAndMute" ${applicantPostAssoc.deafAndMute ? 'checked' : ''} required  maxlength="100">
        		<label for="driver-differentlyAbled-deafAndMute"><fmt:message key="driver.differentlyAbled.deafAndMute"/></label><span class="red">*</span>
        	</div>
           	<div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group driverDifferentlyAbledToggle">
    	<div class="col-sm-5">&nbsp;</div>
        <label class="control-label col-sm-5" for="driver-differentlyAbled-locomotorOrCerebralPalsy"><fmt:message key="driver.differentlyAbled.locomotorOrCerebralPalsy"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
        	<div class="checkbox">
	        	<input value="1" type="checkbox" class="form-control"  id="driver-differentlyAbled-locomotorOrCerebralPalsy" placeholder="<fmt:message key="driver.differentlyAbled.locomotorOrCerebralPalsy"/>" name="locomotorOrCerebralPalsy" ${applicantPostAssoc.locomotorOrCerebralPalsy ? 'checked' : ''} required  maxlength="100">
	        	<label for="driver-differentlyAbled-locomotorOrCerebralPalsy"><fmt:message key="driver.differentlyAbled.locomotorOrCerebralPalsy"/></label><span class="red">*</span>
        	</div>
           	<div class="help-block with-errors"></div>
        </div>
    </div> --%>

    <div class="form-group">
        <label class="control-label col-sm-5" for="ownHeavyDrivingLicenseNumber"><fmt:message key="driver.ownHeavyDrivingLicenseNo"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="ownHeavyDrivingLicenseNumber" id="driver-ownHeavyDrivingLicenseNumber-yes" value="1" type="radio" ${applicantPostAssoc.ownHeavyDrivingLicenseNumber ? 'checked' : ''} />
                <label for="driver-ownHeavyDrivingLicenseNumber-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="ownHeavyDrivingLicenseNumber" id="driver-ownHeavyDrivingLicenseNumber-no" value="0" type="radio" ${applicantPostAssoc.ownHeavyDrivingLicenseNumber == false  ? 'checked' : ''} />
                <label for="driver-ownHeavyDrivingLicenseNumber-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group driverOwnHeavyDrivingLicenseToggle">
        <label class="control-label col-sm-5" for="driverHeavyDrivingLicenseNumber"><fmt:message key="driver.ownHeavyDrivingLicenseNo.number"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.heavyDrivingLicenseNumber}" type="text" class="form-control" id="driverHeavyDrivingLicenseNumber" placeholder="<fmt:message key="driver.ownHeavyDrivingLicenseNo.number"/>" name="heavyDrivingLicenseNumber" maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
    </div>
   
    <div class="form-group driverOwnHeavyDrivingLicenseToggle">
        <label class="control-label col-sm-5" for="driverHeavyDrivingLicenseIssueDate"><fmt:message key="driver.ownHeavyDrivingLicenseNo.issueDate"/>: <span class="red">*</span></label>
        <div class="col-sm-3">
        	<div class="input-group date">
	            <input type="datetime" class="form-control" id="driverHeavyDrivingLicenseIssueDate" placeholder="<fmt:message key="driver.ownHeavyDrivingLicenseNo.issueDate"/>" name="heavyDrivingLicenseIssueDate" readonly>
	            <div class="input-group-addon" id="driverCalendarIconHeavyDrivingLicenseIssueDate">
					<i class="fa fa-calendar"></i>
				</div>
	            <div class="help-block with-errors"></div>
            </div>
        </div>
   </div>
   
    <div class="form-group driverOwnHeavyDrivingLicenseToggle">
        <label class="control-label col-sm-5" for="driverHeavyDrivingLicenseEndDate"><fmt:message key="driver.ownHeavyDrivingLicenseNo.endDate"/>: <span class="red">*</span></label>
        <div class="col-sm-3">
        	<div class="input-group date">
	            <input type="datetime" class="form-control" id="driverHeavyDrivingLicenseEndDate" placeholder="<fmt:message key="driver.ownHeavyDrivingLicenseNo.endDate"/>" name="heavyDrivingLicenseEndDate" readonly >
	            <div class="input-group-addon" id="driverCalendarIconHeavyDrivingLicenseEndDate">
					<i class="fa fa-calendar"></i>
				</div>
	            <div class="help-block with-errors"></div>
            </div>
        </div>
    </div>
    
    <div class="form-group">
        <label class="control-label col-sm-5" for="ownPsvBadgeNo"><fmt:message key="driver.ownPsvBadgeNo"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="ownPsvBatchNumber" id="driver-ownPsvBadgeNo-yes" value="1" type="radio" ${applicantPostAssoc.ownPsvBatchNumber ? 'checked' : ''} />
                <label for="driver-ownPsvBadgeNo-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="ownPsvBatchNumber" id="driver-ownPsvBadgeNo-no" value="0" type="radio" ${applicantPostAssoc.ownPsvBatchNumber == false ? 'checked' : ''} />
                <label for="driver-ownPsvBadgeNo-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
   
    <div class="form-group driverOwnPsvBadgeToggle">
        <label class="control-label col-sm-5" for="psvBatchNumber"><fmt:message key="driver.psvBadgeNo"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.psvBatchNumber}" type="text" class="form-control" id="driverPsvBatchNumber" placeholder="<fmt:message key="driver.psvBadgeNo"/>" name="psvBatchNumber"  maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-5" for="conductorbatchNo"><fmt:message key="driver.ownConductorbatchNo"/>: </label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="ownConductorBatchNumber" id="driver-ownConductorBatchNumber-yes" value="1" type="radio" ${applicantPostAssoc.ownConductorBatchNumber ? 'checked' : ''}/>
                <label for="driver-ownConductorBatchNumber-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input name="ownConductorBatchNumber" id="driver-ownConductorBatchNumber-no" value="0" type="radio" ${applicantPostAssoc.ownConductorBatchNumber == false ? 'checked' : ''}/>
                <label for="driver-ownConductorBatchNumber-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group driverOwnConductorBatchToggle">
        <label class="control-label col-sm-5" for="conductorBatchNumber"><fmt:message key="driver.ownConductorbatchNo.number"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.conductorBatchNumber}" type="text" class="form-control" id="driverConductorBatchNumber" placeholder="<fmt:message key="driver.ownConductorbatchNo.number"/>" name="conductorBatchNumber"  maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group driverOwnConductorBatchToggle">
        <label class="control-label col-sm-5" for="driverConductorBatchNumberIssueDate"><fmt:message key="driver.ownConductorbatchNo.issueDate"/>: <span class="red">*</span></label>
        <div class="col-sm-3">
        	<div class="input-group date">
	            <input type="datetime" class="form-control" id="driverConductorBatchNumberIssueDate" placeholder="<fmt:message key="driver.ownConductorbatchNo.issueDate"/>" name="conductorBatchNumberIssueDate" readonly>
	            <div class="input-group-addon" id="driverCalendarIconConductorBatchNumberIssueDate">
					<i class="fa fa-calendar"></i>
				</div>
	            <div class="help-block with-errors"></div>
            </div>
        </div>
    </div>
    <div class="form-group driverOwnConductorBatchToggle">
        <label class="control-label col-sm-5" for="driverCalendarIconConductorBatchNumberEndDate"><fmt:message key="driver.ownConductorbatchNo.endDate"/>: <span class="red">*</span></label>
        <div class="col-sm-3">
        	<div class="input-group date">
        		<input type="datetime" class="form-control" id="driverConductorBatchNumberEndDate" placeholder="<fmt:message key="driver.ownConductorbatchNo.endDate"/>" name="conductorBatchNumberEndDate" readonly>
	            <div class="input-group-addon" id="driverCalendarIconConductorBatchNumberEndDate">
					<i class="fa fa-calendar"></i>
				</div>
	            <div class="help-block with-errors"></div>
        	</div>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-5" for=experienced><fmt:message key="driver.experienced"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="experienced" id="driver-experienced-yes" value="1" type="radio" ${applicantPostAssoc.experienced ? 'checked' : ''}/>
                <label for="driver-experienced-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="experienced" id="driver-experienced-no" value="0" type="radio" ${applicantPostAssoc.experienced == false ? 'checked' : ''}/>
                <label for="driver-experienced-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group driverExperiencedToggle">
        <label class="control-label col-sm-5" for="companyName"><fmt:message key="driver.experienced.companyName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.companyName}" type="text" class="form-control" id="driverCompanyName" placeholder="<fmt:message key="driver.experienced.companyName"/>" name="companyName" maxlength="150">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group driverExperiencedToggle">
        <label class="control-label col-sm-5" for="totalExperienceInYears"><fmt:message key="driver.experienced.totalExperience"/>: <span class="red">*</span></label>
        <div class="col-sm-2">
            <input value="${applicantPostAssoc.totalExperienceInYears}" type="tel" class="form-control" id="driverTotalExperienceInYears" placeholder="<fmt:message key="driver.experienced.inYears"/>" name="totalExperienceInYears" maxlength="2">
            <div class="help-block with-errors"></div>
        </div>
        <div class="col-sm-2">
            <input value="${applicantPostAssoc.totalExperienceInMonths}" type="tel" class="form-control" id="driverTotalExperienceInMonths" placeholder="<fmt:message key="driver.experienced.inMonths"/>" name="totalExperienceInMonths"  min="0" maxlength="2">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div id="experienceLetterScanCopyDiv" class="form-group driverExperiencedToggle">
       <!-- <label class="control-label col-sm-5" for="dbExperienceLetterScanCopy"><fmt:message key="driver.experienced.upload"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
        	<div class="form-group">
        		<c:if test="${applicantPostAssoc.experienceLetterUpload ne null}">
        			<img id="dbExperienceLetterScanCopy" src="<c:url value='/file?operation=viewExperienceLetter'/>&postId=${post.postId}&experienceScanCopy=${applicantPostAssoc.experienceLetterUpload}" class="img-thumbnail" alt="<fmt:message key="driver.experienced.upload"/>" width="50" height="0" >
        		</c:if>
	            <input id="experienceLetterScanCopy" name="experienceLetterScanCopy" type="file" class="file" data-show-upload="false"
                   data-show-caption="false" data-show-preview="true"
                   data-allowed-file-extensions='["jpg", "jpeg", "png"]'>
	            <div class="help-block with-errors"></div>
            </div>
            <div class="text-muted">
                <em><fmt:message key="applicantFiles.instructions"/></em><br>
                <em><fmt:message key="applicantFiles.supportedFiles"/></em><br><br>
            </div>
        </div>  -->
        <label class="control-label col-sm-5" for=experienced><fmt:message key="driver.experienced.sample"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <a href="javascript:void(0);" onclick="javascript:showPdfInNewTab()"><fmt:message key="driver.experienced.download"/></a>
        </div>
    </div>
    
    <div class="form-group">
        <label class="control-label col-sm-5" for="height"><fmt:message key="driver.height"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="heightWithinRange" id="driver-height-yes" value="1" type="radio" ${applicantPostAssoc.heightWithinRange ? 'checked' : ''} />
                <label for="driver-height-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="heightWithinRange" id="driver-height-no" value="0" type="radio" ${applicantPostAssoc.heightWithinRange == false ? 'checked' : ''} />
                <label for="driver-height-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
	<div class="form-group">
        <label class="control-label col-sm-5" for="driverPastAccidentalDeathIncident"><fmt:message key="driver.pastAccidentalDeathIncident"/>: </label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="pastAccidentalOrDeathIncident" id="driver-pastAccidentalDeathIncident-yes" value="1" type="radio" ${applicantPostAssoc.pastAccidentalOrDeathIncident ? 'checked' : ''} />
                <label for="driver-pastAccidentalDeathIncident-yes"> <fmt:message key="yes"/> </label>
            </div>
			<div class="radio radio-inline">
                <input name="pastAccidentalOrDeathIncident" id="driver-pastAccidentalDeathIncident-no" value="0" type="radio" ${applicantPostAssoc.pastAccidentalOrDeathIncident == false ? 'checked' : ''} />
                <label for="driver-pastAccidentalDeathIncident-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <%-- <div class="form-group driverPastAccidentalToggle">
        <label class="control-label col-sm-5" for="companyName"><fmt:message key="driver.pastAccidentalDeathIncident.reason"/>: </label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.pastAccidentalOrDeathIncidentReason}" type="text" class="form-control" id="driverPastAccidentalOrDeathIncidentReason" placeholder="<fmt:message key="driver.pastAccidentalDeathIncident.reason"/>" name="pastAccidentalOrDeathIncidentReason" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div> --%>
    
    <jsp:include page="postFooter.jsp">
    	<jsp:param name="isPostSubmitted" value="${ applicantPostAssoc.status eq 2 || applicantPostAssoc.status eq 3 }"/>
        <jsp:param name="formId" value="driverForm"/>
        <jsp:param name="postId" value="${post.postId}"/>
        <jsp:param name="disableFormAfterLastDateOver" value="${disableFormAfterLastDateOver}"/>
    </jsp:include>

</form>

<script>
 $(document).ready(function(){
 $("form[name='driverForm']").validate({
 	rules:{
 		sscPassed : "required",
 		experienced : "required",
 		nightBlindness : "required",
 		colorBlindness : "required",
 		ownPsvBatchNumber : "required",
 		psvBatchNumber: {required: true},
//  		ownConductorBatchNumber : "required",
   		conductorBatchNumber: {required: true},
 		ownHeavyDrivingLicenseNumber : "required",
 		heavyDrivingLicenseNumber: {required: true},
 		companyName: {required: true},
 		totalExperienceInYears :{required: true, numbersonly:true, min: 3, max:100},
 		totalExperienceInMonths :{required: true, numbersonly:true, max: 11},
 		visionAcuity : "required",
//  		experienceLetterScanCopy : "required",
 		heightWithinRange : "required",
//  		pastAccidentalOrDeathIncident : "required",
//  		pastAccidentalOrDeathIncidentReason: {required: true, lettersandspaceonly:true},
 		heavyDrivingLicenseEndDate : {	required: true },
 		heavyDrivingLicenseIssueDate : {required: true },
 		conductorBatchNumberIssueDate : {required: true},
 		conductorBatchNumberEndDate : {required: true}
 		  },
 		  messages:{
 			  	totalExperienceInMonths : {max : "<fmt:message key="number.eleven" var="key" /><fmt:message key="validate.maxMonths"><fmt:param value="${key}" /></fmt:message>"}
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