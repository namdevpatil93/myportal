	<%@ include file="../../common/taglibs.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1" %>

<c:set var="nextTabNo" value="3"/>
<c:if test="${ disablePostSelection eq 1 or disablePostSelection eq '1'}">
	<c:set var="nextTabNo" value="4"/>
</c:if>

<script type="text/javascript" src="<c:url value='/static/app/js/postSelection.js'/>"></script>
<script>
var postSelectionObj = new PostSelection();
	jQuery(document).ready(function() {

		showSelectedOptions();
// 		postSelectionObj.bindPostForm("applicantOtherInformationForm");
		$('#retirementDate').datetimepicker({
			format: 'DD/MM/YYYY',
			ignoreReadonly: true,
			showTodayButton: true,
			defaultDate: moment(),
			date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicantOtherInformation.retirementDate}" />'
		});

		$('#retirementDateCalendarIcon').click(function() {
			$('#retirementDate').data("DateTimePicker").show();
		});
		jQuery("#applicantOtherInformationForm").ajaxForm({
			dataType:  'json',
			beforeSubmit:  function(){
				if (isDraft() || jQuery("#applicantOtherInformationForm").valid()) {
					jQuery("#processingRequestSpan").show();
                    jQuery("#saveBtn").attr("disabled",true);
                    jQuery("#saveAsDraftBtn").attr("disabled",true);
                    jQuery("#nextBtn").attr("disabled",true);
					return true;
				} else {
					return false;
				}
			},
			success:  function(result){
				jQuery("#processingRequestSpan").hide();
                jQuery("#saveBtn").attr("disabled",false);
                jQuery("#saveAsDraftBtn").attr("disabled",false);
                jQuery("#nextBtn").attr("disabled",false);
				
				var success = result.success;
				if(success){
					applyObj.gotoTab('${ nextTabNo }');
					return false;
				} else {
					commonObj.showAlert("There was some error while trying to save the Applicant's Other Information.");
				}
			}

		});

		//var paymentDoneForAtLeastOnePost = applyObj.isValidate(${disableOtherInformationFormFieldsOnPayment});
        //enableDisableOIFormFieldsOnPayment(paymentDoneForAtLeastOnePost);
		
        var lastDateOver = commonObj.isValidate(${disableFormAfterLastDateOver});
        commonObj.disableFormFields("applicantOtherInformationForm",lastDateOver);
        if(lastDateOver){
        	 $('#applicantOtherInformationForm').find('#citypreferenceFirst').attr('disabled', 'disabled');
        	 $('#applicantOtherInformationForm').find('#citypreferenceSecond').attr('disabled', 'disabled');
        	 $('#applicantOtherInformationForm').find('#citypreferenceThird').attr('disabled', 'disabled');
        }
	});

	function enableDisableOIFormFieldsOnPayment(flag){
		if(flag){
			$( 'form#applicantOtherInformationForm' ).find('input[type=radio][name=projectEffected]').click(function(){
			    return false;
			});
			$( 'form#applicantOtherInformationForm' ).find('input[type=radio][name=earthQuakeEffected]').click(function(){
			    return false;
			});
			$( 'form#applicantOtherInformationForm' ).find('input[type=radio][name=exServiceMan]').click(function(){
			    return false;
			});
			jQuery("#exServiceMan-TotalExperienceInYears").attr("readonly",true);
			jQuery("#exServiceMan-TotalExperienceInMonths").attr("readonly",true);
			$( 'form#applicantOtherInformationForm' ).find('input[type=radio][name=partTimeEmployee]').click(function(){
			    return false;
			});
			jQuery("#partTimeEmployee-TotalExperienceInYears").attr("readonly",true);
			jQuery("#partTimeEmployee-TotalExperienceInMonths").attr("readonly",true);
			$( 'form#applicantOtherInformationForm' ).find('input[type=radio][name=sportsPerson]').click(function(){
			    return false;
			});
			$( 'form#applicantOtherInformationForm' ).find('input[type=radio][name=sportsLevel]').click(function(){
			    return false;
			});
			$( 'form#applicantOtherInformationForm' ).find('input[type=radio][name=stEmployee]').click(function(){
			    return false;
			});
			$( 'form#applicantOtherInformationForm' ).find('input[type=radio][name=locomotorOrCerebralPalsy]').click(function(){
			    return false;
			});
			$( 'form#applicantOtherInformationForm' ).find('input[type=radio][name=orphanedPerson]').click(function(){
			    return false;
			});
			$( 'form#applicantOtherInformationForm' ).find('input[type=radio][name=deafAndMute]').click(function(){
			    return false;
			});
		}else{
			/* $( 'form#applicantOtherInformationForm' ).find('input[type=radio][name=projectEffected]').attr("readonly",false);
			$( 'form#applicantOtherInformationForm' ).find('input[type=radio][name=earthQuakeEffected]').attr("readonly",false);
			$( 'form#applicantOtherInformationForm' ).find('input[type=radio][name=exServiceMan]').attr("readonly",false); */
			jQuery("#exServiceMan-TotalExperienceInYears").attr("readonly",false);
			jQuery("#exServiceMan-TotalExperienceInMonths").attr("readonly",false);
			/* $( 'form#applicantOtherInformationForm' ).find('input[type=radio][name=partTimeEmployee]').attr("readonly",false); */
			jQuery("#partTimeEmployee-TotalExperienceInYears").attr("readonly",false);
			jQuery("#partTimeEmployee-TotalExperienceInMonths").attr("readonly",false);
			/* $( 'form#applicantOtherInformationForm' ).find('input[type=radio][name=sportsPerson]').attr("readonly",false);
			$( 'form#applicantOtherInformationForm' ).find('input[type=radio][name=sportsLevel]').attr("readonly",false);
			$( 'form#applicantOtherInformationForm' ).find('input[type=radio][name=stEmployee]').attr("readonly",false); */
		}
	}
	
	// differentlyAbled implementation
	 //applicantOtherInformation-differentlyAbled-yes
	 
	 /*
	 $( 'form#applicantOtherInformationForm' ).find('input[type=radio][name=differentlyAbled]').unbind().change(function() {
		 
		 $("#applicantOtherInformation-differentlyAbled-yes").parent().parent().find('.help-block').empty();
		if (this.value == '1') {
	       	 
	       	 //$( '.juniorEngineerCivilDifferentlyAbledToggle' ).find('input').prop('required', true);
        	commonObj.showAgreeDisAgreePopup("<b> <fmt:message key='driver.differentlyAbled.locomotorOrCerebralPalsy' />:</b>  <fmt:message key='common.prevailing.government.rules' />", applicantOtherInformationDifferentlyAbledAction, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
        } else {
        	//$("#applicantOtherInformation-differentlyAbled-yes").parent().parent().find('.help-block').empty();
        }
    });
	    
	 function applicantOtherInformationDifferentlyAbledAction(flag) {
		 	
			if(!flag) {
				$('#applicantOtherInformation-differentlyAbled-no').prop('checked', true);
			}else {
				//$("#applicantOtherInformation-differentlyAbled-yes").parent().parent().find('.help-block').empty();
			}
	 	}
		*/
	function isDraft(){
        var status = jQuery("#status").val();
        return status == 0 || status == '0';
    }

function saveApplicantOtherInformationAsDraft(){
//         $("#applicantOtherInformationForm").validator("destroy");
    $("#applicantOtherInformationForm").validate().settings.ignore = "*";
    jQuery("#status").val(0);
    jQuery("#applicantOtherInformationForm").submit();
}

	function saveApplicantOtherInformation(){
        jQuery("#status").val(1);
       /*  if(checkExperience())
		{
			postSelectionObj.experienceNotePopup();
			return false;
		} */
        jQuery("#applicantOtherInformationForm").submit();
    }
    
    function showSelectedOptions()
	{
    	if('${applicantOtherInformation.exServiceMan}' == "true" || '${applicantOtherInformation.exServiceMan}' == true)
		{
			postSelectionObj.showElementsByClass('exServiceManExperiencedToggle');
		}
		else
		{
			postSelectionObj.hideElementsByClass('exServiceManExperiencedToggle');
		}
    	
    	if('${ applicantOtherInformation.partTimeEmployee}' == "true" || '${applicantOtherInformation.partTimeEmployee}' == true)
		{
			postSelectionObj.showElementsByClass('partTimeEmployeeExperiencedToggle');
		}
		else
		{
			postSelectionObj.hideElementsByClass('partTimeEmployeeExperiencedToggle');
		}
    	if('${ applicantOtherInformation.sportsPerson}' == "true" || '${applicantOtherInformation.sportsPerson}' == true)
		{
			postSelectionObj.showElementsByClass('sportsLevelToggle');
		}
		else
		{
			postSelectionObj.hideElementsByClass('sportsLevelToggle');
		}
	}
   
    function checkExperience()
    {
    	//return ( partTimeEmployeeExp() || exServiceManExperience());
        return ( exServiceManExperience());
    }
    
    function partTimeEmployeeExp()
    {
    	var val=0;
    	$(".partTimeEmployeeExperiencedToggle").find('.telToCheck').each(function(){
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
			$(".partTimeEmployeeExperiencedToggle").addClass('has-error');
    		return true;
    	}
		else
		{
			$(".partTimeEmployeeExperiencedToggle").removeClass( 'has-error has-danger' );
			return false;
		}
    }
    
    function exServiceManExperience()
    {
    	var val2=0;
		$(".exServiceManExperiencedToggle").find('.telToCheck').each(function(){
			if(this.value == "")
			{
				val2 =-1;
			}
			else
			{
				val2 = val2 + this.value;
			}
		});	 
		
		if(val2 == 0)
    	{
			$(".exServiceManExperiencedToggle").addClass('has-error');
    		return true;
    	}
		else
		{
			$(".exServiceManExperiencedToggle").removeClass( 'has-error has-danger' );
			return false;
		}
    }
    
    $( 'form#applicantOtherInformationForm' ).find('input[type=radio][name=exServiceMan]').unbind().change(function() {
        if (this.value == '1') 
        {
//         	$('#exServiceMan-TotalExperienceInYears').attr("required", true);
        	$('#exServiceMan-TotalExperienceInMonths').attr("required", true);
       		 postSelectionObj.showElementsByClass('exServiceManExperiencedToggle');
        } 
        else 
        {
//         	$('#exServiceMan-TotalExperienceInYears').attr("required", false);
        	$('#exServiceMan-TotalExperienceInMonths').attr("required", false);
         	postSelectionObj.resetTextFieldById('exServiceMan-TotalExperienceInYears');
        	postSelectionObj.resetTextFieldById('exServiceMan-TotalExperienceInMonths');
        	postSelectionObj.hideElementsByClass('exServiceManExperiencedToggle');
//        		postSelectionObj.notEligiblePopup();
        }
    });
    
    $( 'form#applicantOtherInformationForm' ).find('input[type=radio][name=partTimeEmployee]').unbind().change(function() {
        if (this.value == '1') 
        {
        	$('#partTimeEmployee-TotalExperienceInYears').attr("required", true);
        	$('#partTimeEmployee-TotalExperienceInMonths').attr("required", true);
       		 postSelectionObj.showElementsByClass('partTimeEmployeeExperiencedToggle');
        } 
        else 
        {
        	$('#partTimeEmployee-TotalExperienceInYears').attr("required", false);
        	$('#partTimeEmployee-TotalExperienceInMonths').attr("required", false);
        	postSelectionObj.resetTextFieldById('partTimeEmployee-TotalExperienceInYears');
        	postSelectionObj.resetTextFieldById('partTimeEmployee-TotalExperienceInMonths');
        	postSelectionObj.hideElementsByClass('partTimeEmployeeExperiencedToggle');
//        		postSelectionObj.notEligiblePopup();
        }
    });
    
    $( 'form#applicantOtherInformationForm' ).find('input[type=radio][name=sportsPerson]').unbind().change(function() {
        if (this.value == '1') 
        {
//         	$('#input-sportsLevel-national').attr("required", true);
//         	$('#input-sportsLevel-state').attr("required", true);
       		 postSelectionObj.showElementsByClass('sportsLevelToggle');
        } 
        else 
        {
        	
        	postSelectionObj.resetRadioButtonByName('sportsLevel');
        	$('#input-sportsLevel-national').attr("required", false);
        	$('#input-sportsLevel-state').attr("required", false);
        	postSelectionObj.hideElementsByClass('sportsLevelToggle');
//        		postSelectionObj.notEligiblePopup();
        }
    });
    
    function resetDuplicateCity(val, id){
    	var elements = document.getElementsByClassName("preferredCity");
    	//var elements = $("#"+divId).find(".postPriority");
    	for(i=0; i < elements.length ; i++){
    		$("div #citypreferenceFirstDivId").removeClass("has-danger");
    		$("div #citypreferenceFirstDivId").removeClass("has-error");
    			if(elements[i].value==val && elements[i].id!=id){
    		 elements[i].selectedIndex= 0;
    	}
    }
   }

	function viewFile() {
		//var url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/Important_Instructions_to_the_Candidate.pdf'/>";
		var url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/Parallel Reservation.pdf'/>";
		window.open(url,'_blank');
	}
	function differentlyAbledViewFile() {
    	var url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/Important_Instructions_to_the_Candidate.pdf'/>";
    	window.open(url,'_blank');
    }
	function selectNoAsOption(popUpNo){
		switch(popUpNo){
		case '1':
			$("#input-projectEffected-no").prop("checked", true);
            break;
        case '2':
        	$("#input-earthQuakeEffected-no").prop("checked", true);
            break;
        case '3':
        	$("#input-exServiceMan-no").prop("checked", true);
        	$( 'form#applicantOtherInformationForm' ).find('input[type=radio][name=exServiceMan]').trigger('change');
            break;
        case '4':
        	$("#input-partTimeEmployee-no").prop("checked", true);
        	$( 'form#applicantOtherInformationForm' ).find('input[type=radio][name=partTimeEmployee]').trigger('change');
            break;
        case '5':
        	$("#input-sportsPerson-no").prop("checked", true);
        	$( 'form#applicantOtherInformationForm' ).find('input[type=radio][name=sportsPerson]').trigger('change');
            break;
        default:
            //applyObj.showPersonalInformation();
            break;
		}
	}

	jQuery(document).ready(function() {
		var paymentDoneForAtLeastOnePost = applyObj.isValidate(${disableOtherInformationFormFieldsOnPayment});
        enableDisableOIFormFieldsOnPayment(paymentDoneForAtLeastOnePost);
	});
</script>

<div class="" style="width:100%;">
<div class="text-center" style="display:none">
<a href="javascript:void(0);" data-toggle="modal" data-target="#parallelReservationModal"><fmt:message key="applicant.hashPopup"/></a>
</div>

<form class="form-horizontal" name="applicantOtherInformationForm"
	id="applicantOtherInformationForm" action="<c:url value='/applicant?operation=saveOtherInformation'/>"
 method="POST">

	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="hidden" name="id" value="${applicantOtherInformation.id}"/>
	<input type="hidden" name="status" id="status"  value="${ applicantOtherInformation.status }"/>

	
	<div class="form-group">
	<!-- </div>
	<div class="form-group required"> -->
		<label class="control-label col-xs-3" for="input-projectEffected-yes"><fmt:message key="applicant.projectEffected" />: <span class="red">*&nbsp;&nbsp;##</span><a href="javascript:void(0);" onclick="javascript:viewFile()" style="font-size: 9px; font-style: italic">	<fmt:message key="viewFile"/></a></label>
		<div class="col-xs-3">
			<div class="radio radio-inline" id="projectEffected-yes-id">
	                <input type="radio" name="projectEffected" onclick="javascript:void(0);" data-backdrop="static" data-keyboard="false" data-target="#projectAffectedModal" data-toggle="modal" ${ applicantOtherInformation.projectEffected eq true ? 'checked="checked"':''} value="1" class="form-control" id="input-projectEffected-yes" disabled=true>
	                <label for="input-projectEffected-yes"> <fmt:message key="yes"/> </label>
	        </div>
	        <div class="radio radio-inline" id="projectEffected-no-id">
	               	<input type="radio" name="projectEffected" value="0" class="form-control" id="input-projectEffected-no" ${ applicantOtherInformation.projectEffected eq false ? 'checked="checked"':''} disabled=true>
	                <label for="input-projectEffected-no"> <fmt:message key="no"/> </label>
	        </div>
			<div class="help-block with-errors"></div>
		</div>
	</div>
	<div class="form-group">
		<label class="control-label col-xs-3" for="input-earthQuakeEffected-yes"><fmt:message key="applicant.earthQuakeEffected" />: <span class="red">*&nbsp;&nbsp;##</span><a href="javascript:void(0);" onclick="javascript:viewFile()" style="font-size: 9px; font-style: italic">	<fmt:message key="viewFile"/></a></label>
		<div class="col-xs-3">
			<div class="radio radio-inline" id="earthQuakeEffected-yes-id">
	                <input type="radio" name="earthQuakeEffected" onclick="javascript:void(0);" data-backdrop="static" data-keyboard="false" data-target="#earthQuakeAffectedModal" data-toggle="modal" ${ applicantOtherInformation.earthQuakeEffected eq true ? 'checked="checked"':''} value="1" class="form-control" id="input-earthQuakeEffected-yes" disabled=true>
	                <label for="input-earthQuakeEffected-yes"> <fmt:message key="yes"/> </label>
	        </div>
	        <div class="radio radio-inline" id="earthQuakeEffected-no-id">
	               	<input type="radio" name="earthQuakeEffected" value="0" class="form-control" id="input-earthQuakeEffected-no" ${ applicantOtherInformation.earthQuakeEffected eq false ? 'checked="checked"':''} disabled=true>
	                <label for="input-earthQuakeEffected-no"> <fmt:message key="no"/> </label>
	        </div>
			<div class="help-block with-errors"></div>
		</div>
	</div>
	
 <div class="form-group">
		<label class="control-label col-xs-3" for="input-exServiceMan-yes"><fmt:message key="applicant.exServiceMan" />: <span class="red">*&nbsp;&nbsp;##</span><a href="javascript:void(0);" onclick="javascript:viewFile()" style="font-size: 9px; font-style: italic">	<fmt:message key="viewFile"/></a></label>
		<div class="col-xs-3">
			<div class="radio radio-inline" id="exServiceMan-yes-id">
	                <input type="radio" name="exServiceMan" onclick="javascript:void(0);" data-backdrop="static" data-keyboard="false" data-target="#exServiceManModal" data-toggle="modal" ${ applicantOtherInformation.exServiceMan eq true? 'checked="checked"':''} value="1" class="form-control" id="input-exServiceMan-yes" disabled=true>
	                <label for="input-exServiceMan-yes"> <fmt:message key="yes"/> </label>
	        </div>
	        <div class="radio radio-inline" id="exServiceMan-no-id">
	               	<input type="radio" name="exServiceMan" value="0" class="form-control" id="input-exServiceMan-no" ${ applicantOtherInformation.exServiceMan eq false? 'checked="checked"':''} disabled=true>
	                <label for="input-exServiceMan-no"> <fmt:message key="no"/> </label>
	        </div>
			<div class="help-block with-errors"></div>
		</div>
		
	<!-- </div>
	<div class="form-group required"> -->
	<div class="form-group exServiceManExperiencedToggle">
        <label class="control-label col-xs-2" for="totalExperienceInYears"><fmt:message key="otherInfo.totalServicePeriod"/>: <span class="red">*</span></label>
        <div class="col-sm-2">
            <input value="${applicantOtherInformation.exServicemanTotalExperienceInYears}" type="number" class="form-control" id="exServiceMan-TotalExperienceInYears" placeholder="<fmt:message key="trafficInspector.experienced.inYears"/>" name="exServicemanTotalExperienceInYears">
            <%--  <input value="${applicantOtherInformation.exServicemanTotalExperienceInYears}" type="tel" class="form-control" id="exServiceMan-TotalExperienceInYears" placeholder="<fmt:message key="trafficInspector.experienced.inYears"/>" name="exServicemanTotalExperienceInYears">
				 <input value="${ applicantOtherInformation.exServicemanTotalExperienceInYears }"  name="exServicemanTotalExperienceInYears" class="form-control telToCheck" id="exServiceMan-TotalExperienceInYears" type="tel" placeholder="<fmt:message key="trafficInspector.experienced.inYears"/>" maxlength="2"/>
 --%><!--             <div class="help-block with-errors"></div> -->
        </div>
        <div class="col-sm-2">
            <input value="${applicantOtherInformation.exServicemanTotalExperienceInMonths}" type="number" class="form-control" id="exServiceMan-TotalExperienceInMonths" placeholder="<fmt:message key="trafficInspector.experienced.inMonths"/>" name="exServicemanTotalExperienceInMonths" required oninvalid="this.setCustomValidity('<fmt:message key="validation.requiredfield"/>')" max=12>
            	<%-- <input value="${ applicantOtherInformation.exServicemanTotalExperienceInMonths }"  name="exServicemanTotalExperienceInMonths" class="form-control telToCheck" id="exServiceMan-TotalExperienceInMonths" type="tel" placeholder="<fmt:message key="trafficInspector.experienced.inMonths"/>" maxlength="2"/> --%>
<!--             <div class="help-block with-errors"></div> -->
        </div>
    </div>
	</div> 
	<div class="form-group">
		<label class="control-label col-xs-3" for="input-partTimeEmployee-yes"><fmt:message key="applicant.partTimeEmployee" />: <span class="red">*&nbsp;&nbsp;##</span><a href="javascript:void(0);" onclick="javascript:viewFile()" style="font-size: 9px; font-style: italic">	<fmt:message key="viewFile"/></a></label>
		<div class="col-xs-3">
			<div class="radio radio-inline" id="partTimeEmployee-yes-id">
	                <input type="radio" name="partTimeEmployee" onclick="javascript:void(0);" data-backdrop="static" data-keyboard="false" data-target="#partTimeEmployeeModal" data-toggle="modal" ${ applicantOtherInformation.partTimeEmployee eq true ? 'checked="checked"':''} value="1" class="form-control" id="input-partTimeEmployee-yes" disabled=true>
	                <label for="input-partTimeEmployee-yes"> <fmt:message key="yes"/> </label>
	        </div>
	        <div class="radio radio-inline" id="partTimeEmployee-no-id">
	               	<input type="radio" name="partTimeEmployee" value="0" class="form-control" id="input-partTimeEmployee-no" ${ applicantOtherInformation.partTimeEmployee eq false ? 'checked="checked"':''} disabled=true>
	                <label for="input-partTimeEmployee-no"> <fmt:message key="no"/> </label>
	        </div>
			<div class="help-block with-errors"></div>
		</div>
		<div class="form-group partTimeEmployeeExperiencedToggle">
		        <label class="control-label col-sm-2" for="totalExperienceInYears"><fmt:message key="trafficInspector.experienced.totalExperience"/>: <span class="red">*</span></label>
		        <div class="col-sm-2">
		            <input value="${applicantOtherInformation.partTimeEmployeeTotalExperienceInYears}" type="number" class="form-control" id="partTimeEmployee-TotalExperienceInYears" placeholder="<fmt:message key="trafficInspector.experienced.inYears"/>" name="partTimeEmployeeTotalExperienceInYears" min="0"> 
						<%-- <input value="${ applicantOtherInformation.partTimeEmployeeTotalExperienceInYears }"  name="partTimeEmployeeTotalExperienceInYears" class="form-control telToCheck" id="partTimeEmployee-TotalExperienceInYears" type="tel" placeholder="<fmt:message key="trafficInspector.experienced.inYears"/>" maxlength="2"/> --%>
<!-- 		            <div class="help-block with-errors"></div> -->
		        </div>
		        <div class="col-sm-2">
		            <input value="${applicantOtherInformation.partTimeEmployeeTotalExperienceInMonths}" type="number" class="form-control" id="partTimeEmployee-TotalExperienceInMonths" placeholder="<fmt:message key="trafficInspector.experienced.inMonths"/>" name="partTimeEmployeeTotalExperienceInMonths" min="0" max="12">
						<!--  <input value="${ applicantOtherInformation.partTimeEmployeeTotalExperienceInMonths }"  name="partTimeEmployeeTotalExperienceInMonths" class="form-control telToCheck" id="partTimeEmployee-TotalExperienceInMonths" type="tel" placeholder="<fmt:message key="trafficInspector.experienced.inMonths"/>" maxlength="2"/> -->
<!-- 		            <div class="help-block with-errors"></div> -->
		        </div>
    	</div>
	</div>
	
	<div class="form-group">
		<label class="control-label col-xs-3" for="input-sportsPerson-yes"><fmt:message	key="applicant.sportsPerson" />: <span class="red">*&nbsp;&nbsp;##</span><a href="javascript:void(0);" onclick="javascript:viewFile()" style="font-size: 9px; font-style: italic">	<fmt:message key="viewFile"/></a></label>
		<div class="col-xs-3">
			<div class="radio radio-inline" id="sportsPerson-yes-id">
	                <input type="radio" name="sportsPerson"  onclick="javascript:void(0);" data-backdrop="static" data-keyboard="false" data-target="#sportsPersonModal" data-toggle="modal" ${ applicantOtherInformation.sportsPerson eq true ? 'checked="checked"':''} value="1" class="form-control" id="input-sportsPerson-yes" >
	                <label for="input-sportsPerson-yes"> <fmt:message key="yes"/> </label>
	        </div>
	        <div class="radio radio-inline" id="sportsPerson-no-id">
	               	<input type="radio" name="sportsPerson" value="0" class="form-control" id="input-sportsPerson-no" ${ applicantOtherInformation.sportsPerson eq false ? 'checked="checked"':''} >
	                <label for="input-sportsPerson-no"> <fmt:message key="no"/> </label>
	        </div>
			<div class="help-block with-errors"></div>
		</div>
	<!-- </div>
	<div class="form-group required"> -->
	<div class="form-group sportsLevelToggle">
		<label class="control-label col-xs-2" for="input-sportsLevel-national"><fmt:message key="applicant.sportsLevel" />: <span class="red">*</span></label>
		<div class="col-xs-4">
			<div class="radio radio-inline" id="sportsLevel-national-id">
	                <input type="radio" name="sportsLevel" ${ applicantOtherInformation.sportsLevel eq 'National' ? 'checked="checked"':''} value="National" class="form-control" id="input-sportsLevel-national" >
	                <label for="input-sportsLevel-national"> <fmt:message key="applicant.sportsLevel.national"/> </label>
	        </div>
	    </div>
	    <div class="col-xs-8"></div>
	    <div class="col-xs-4">
	        <div class="radio radio-inline" id="sportsLevel-state-id">
	               	<input type="radio" name="sportsLevel" value="State" class="form-control" id="input-sportsLevel-state" ${ applicantOtherInformation.sportsLevel eq 'State' ? 'checked="checked"':''} >
	                <label for="input-sportsLevel-state"> <fmt:message key="applicant.sportsLevel.state"/> </label>
	        </div>
			<div class="help-block with-errors"></div>
		</div>
		<div class="col-xs-8"></div>
		<div class="col-xs-4">
	        <div class="radio radio-inline" id="sportsLevel-international-id">
	               	<input type="radio" name="sportsLevel" value="International" class="form-control" id="input-sportsLevel-international" ${ applicantOtherInformation.sportsLevel eq 'International' ? 'checked="checked"':''} >
	                <label for="input-sportsLevel-international"> <fmt:message key="applicant.sportsLevel.international"/> </label>
	        </div>
			<div class="help-block with-errors"></div>
		</div>
	</div>
	</div>
	<div class="form-group">
		<label class="control-label col-xs-3" for="input-stEmployee-yes"><fmt:message key="applicant.stEmployee" />: <span class="red">*</span></label>
		<div class="col-xs-3">
			<div class="radio radio-inline" id="stEmployee-yes-id">
	                <input type="radio" name="stEmployee" ${ applicantOtherInformation.stEmployee eq true ? 'checked="checked"':''} value="1" class="form-control" id="input-stEmployee-yes" onclick="javascript:void(0);" data-backdrop="static" data-keyboard="false" data-target="#stEmployeeModal" data-toggle="modal" >
	                <label for="input-stEmployee-yes"> <fmt:message key="yes"/> </label>
	        </div>
	        <div class="radio radio-inline" id="stEmployee-no-id">
	               	<input type="radio" name="stEmployee" value="0" class="form-control" id="input-stEmployee-no" ${ applicantOtherInformation.stEmployee eq false ? 'checked="checked"':''} >
	                <label for="input-stEmployee-no"> <fmt:message key="no"/> </label>
	        </div>
			<div class="help-block with-errors"></div>
		</div>
    </div>
    
    <div class="form-group">
		<label class="control-label col-xs-3" for="input-OrphanedPerson"><fmt:message key="applicant.OrphanedPerson" />: <span class="red">*</span></label>
		<div class="col-xs-3">
			<div class="radio radio-inline">
                <input name="orphanedPerson" id="input-OrphanedPerson-yes" class="form-control" value="1" type="radio" ${applicantOtherInformation.orphanedPerson eq true ? 'checked="checked"':''} >
                <label for="input-OrphanedPerson-yes"> <fmt:message key="yes"/> </label>
            </div>
			
	        <div class="radio radio-inline" id="OrphanedPerson-no-id">
	               	<input type="radio" name="orphanedPerson"  value="0" class="form-control" id="input-OrphanedPerson-no" ${ applicantOtherInformation.orphanedPerson eq false ? 'checked="checked"':''} >
	                <label for="input-OrphanedPerson-no"> <fmt:message key="no"/> </label>
	        </div>
			<div class="help-block with-errors"></div>
		</div>
    </div>
    
    <div class="form-group">
		<label class="control-label col-xs-3" for="locomotorOrCerebralPalsy"><fmt:message key="applicant.locomotorOrCerebralPalsy" />: <span class="red">*</span></label>
		<div class="col-xs-3">
			<div class="radio radio-inline">
                <input name="locomotorOrCerebralPalsy" id="input-locomotorOrCerebralPalsy-yes" class="form-control" value="1" type="radio" ${applicantOtherInformation.locomotorOrCerebralPalsy eq true ? 'checked="checked"':''} >
                <label for="input-locomotorOrCerebralPalsy-yes"> <fmt:message key="yes"/> </label>
            </div>
			
	        <div class="radio radio-inline" id="locomotorOrCerebralPalsy-no-id">
	               	<input type="radio" name="locomotorOrCerebralPalsy"  value="0" class="form-control" id="input-locomotorOrCerebralPalsy-no" ${ applicantOtherInformation.locomotorOrCerebralPalsy eq false ? 'checked="checked"':''} >
	                <label for="input-locomotorOrCerebralPalsy-no"> <fmt:message key="no"/> </label>
	        </div>
			<div class="help-block with-errors"></div>
		</div>
    </div>
    
        <div class="form-group">
		<label class="control-label col-xs-3" for="deafAndMute"><fmt:message key="applicant.deaf" />: <span class="red">*</span></label>
		<div class="col-xs-3">
			<div class="radio radio-inline">
                <input name="deafAndMute" id="input-deafAndMute-yes" class="form-control" value="1" type="radio" ${applicantOtherInformation.deafAndMute eq true ? 'checked="checked"':''} >
                <label for="input-deafAndMute-yes"> <fmt:message key="yes"/> </label>
            </div>
			
	        <div class="radio radio-inline" id="deafAndMute-no-id">
	               	<input type="radio" name="deafAndMute" value="0" class="form-control" id="input-deafAndMute-no" ${ applicantOtherInformation.deafAndMute eq false ? 'checked="checked"':''} >
	                <label for="input-deafAndMute-no"> <fmt:message key="no"/> </label>
	        </div>
			<div class="help-block with-errors"></div>
		</div>
    </div>
    
	<%-- <div class="form-group">
        <label class="control-label col-xs-3" for="differentlyAbled"><fmt:message key="driver.differentlyAbled"/>: <span class="red">*&nbsp;&nbsp;##</span><a href="javascript:void(0);" onclick="javascript:differentlyAbledViewFile()" style="font-size: 9px; font-style: italic"><fmt:message key="viewFile"/></a></label>
        <div class="col-xs-3">
            <div class="radio radio-inline">
                <input name="differentlyAbled" id="applicantOtherInformation-differentlyAbled-yes" value="1" type="radio" ${applicantOtherInformation.differentlyAbled ? 'checked' : ''} />
                <label for="applicantOtherInformation-differentlyAbled-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input name="differentlyAbled" id="applicantOtherInformation-differentlyAbled-no" value="0" type="radio" ${applicantOtherInformation.differentlyAbled == false  ? 'checked' : ''} />
                <label for="applicantOtherInformation-differentlyAbled-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div> --%>
 <div id="cityPreference=" class="form-group">
 <label for="selectCityPrefrences" class="col-sm-3 control-label"><fmt:message key="city.preference" />:</label>
 </div>
	<div id="citypreferenceFirstDivId" class="form-group" >
        <label style="padding-left: 180px;" for="citypreferenceFirst" class="col-sm-3 control-label"><fmt:message key="city.first.preference" />:<span class="red">*</span></label>
        <div class="col-sm-3">
            <select id="citypreferenceFirst" name="preferredCity1" class="form-control preferredCity skipDisabling" onchange="resetDuplicateCity(this.value,this.id);" required oninvalid="this.setCustomValidity('<fmt:message key="validation.requiredfield"/>')">
                <option value="">-- <fmt:message key="city.preference"/> --</option>
                <c:forEach items="${cityList}" var="city">
					<option value="${city.id}" ${ city.id eq applicantOtherInformation.preferredCity1? 'selected':'' }><fmt:message key="${ city.messageKey }" /></option>
				</c:forEach>
			</select>
<!--             <div class="help-block with-errors"></div> -->
        </div>
    </div>
    
    <div class="form-group">
       <label style="padding-left: 180px;" for="citypreferenceSecond" class="col-sm-3 control-label"><fmt:message key="city.second.preference" />:<span class="red">*</span></label>
        <div class="col-sm-3">
            <select id="citypreferenceSecond" name="preferredCity2" class="form-control preferredCity skipDisabling" onchange="resetDuplicateCity(this.value,this.id);" required>
                <option value="">-- <fmt:message key="city.preference"/> --</option>
                <c:forEach items="${cityList}" var="city">
					<option value="${city.id}" ${ city.id eq applicantOtherInformation.preferredCity2? 'selected':'' }><fmt:message key="${ city.messageKey }" /></option>
				</c:forEach>
			</select>
<!--             <div class="help-block with-errors"></div> -->
        </div>
    </div>
    
    <div class="form-group">
        <label style="padding-left: 180px;" for="citypreferenceThird" class="col-sm-3 control-label"><fmt:message key="city.third.preference" />:<span class="red">*</span></label>
        <div class="col-sm-3">
            <select id="citypreferenceThird" name="preferredCity3" class="form-control preferredCity skipDisabling" onchange="resetDuplicateCity(this.value,this.id);" required>
                <option value="">-- <fmt:message key="city.preference"/> --</option>
                <c:forEach items="${cityList}" var="city">
					<option value="${city.id}" ${ city.id eq applicantOtherInformation.preferredCity3? 'selected':'' }><fmt:message key="${ city.messageKey }" /></option>
				</c:forEach>
			</select>
            <div class="help-block with-errors"></div>
        </div>
    </div>
	
	<%-- <div class="form-group required">
		<label class="control-label col-xs-4"></label>
		<div class="col-xs-8">
			<input class="btn btn-success" id="submit" value="<fmt:message key="submit"/>" type="submit" />
			<input class="btn btn-default" id="cancel" value="<fmt:message key="cancel"/>" type="button" onclick="javascript:commonObj.goToURL('<c:url value='/'/>');"/>
		</div>
	</div> --%>
<div class="form-group"><label class="control-label col-sm-15" > <Strong style="color: red"><fmt:message key="divisionController.note"/> : </Strong><fmt:message key="apply.otherInformation.note"/> </label></div>


	<nav class="navbar btn-toolbar sw-toolbar sw-toolbar-bottom">
		<div class="btn-group navbar-btn sw-btn-group pull-right" role="group">
        	<span class="processingRequest greenTxt" style="display: none" id="processingRequestSpan">
                 	<img src="<c:url value='static/app/images/smallLoader.gif'/>" class="smallLoader">
                <fmt:message key="processingrequest"/>
            </span>&nbsp;
			<c:if test="${!disableFormAfterLastDateOver}">
				<button onclick="javascript:saveApplicantOtherInformation();" class="btn btn-default sw-btn-next" type="button" id="saveBtn">
					<fmt:message key="save" />
				</button>
				<c:if test="${ disableSaveAsDraft ne 1 and disableSaveAsDraft ne '1' }">
					<c:if test="${!disableOtherInformationFormFieldsOnPayment }">
						<button onclick="javascript:saveApplicantOtherInformationAsDraft();" class="btn btn-default sw-btn-next" type="button" id="saveAsDraftBtn">
							<fmt:message key="saveAsDraft" />
						</button>
					</c:if>
				</c:if>
			</c:if>
			<button onclick="javascript:applyObj.gotoTab('${ nextTabNo }')" class="btn btn-default sw-btn-next skipDisabling" type="button" id="nextBtn">
				<fmt:message key="next" />
			</button>
		</div>
	</nav>

</form>
</div>
<jsp:include page="popup/stEmployeeYesPopup.jsp"/>
<jsp:include page="popup/parallelReservationPopup.jsp"/>
<jsp:include page="popup/exServiceManPopup.jsp"/>
<jsp:include page="popup/partTimeEmployeePopup.jsp"/>
<jsp:include page="popup/sportsPersonPopup.jsp"/>
<jsp:include page="popup/projectAffectedPopup.jsp"/>
<jsp:include page="popup/earthQuakeAffectedPopup.jsp"/>
<script>
	$(document).ready(function(){
		$("form[name='applicantOtherInformationForm']").validate({
			rules:{
				projectEffected:{
			    	required: true
			    	},
			    earthQuakeEffected:{
		    		required: true
		    	  },
		    	  stEmployee:{
		    		required: true
		    	  },
		    	  exServiceMan:{
		    		required: true
		    	  },
		    	  partTimeEmployee:{
		    		required: true
		    	  },
		    	  sportsPerson:{
		    		required: true
		    	  },
		    	  sportsLevel:{
		    		  required:true
		    	  },
		    	  orphanedPerson:{
		    		  required:true
		    	  },
		    	   exServicemanTotalExperienceInYears:{
		    		  required:true,
		    		  numbersonly: true
		    	  },
		    	  exServicemanTotalExperienceInMonths:{
		    		  required:true,
		    		  numbersonly: true,
		    		  max: 11
		    	  }, 
		    	  partTimeEmployeeTotalExperienceInYears:{
		    		  required:true,
		    		  numbersonly: true
		    	  },
		    	  partTimeEmployeeTotalExperienceInMonths:{
		    		  required:true,
		    		  numbersonly: true,
		    		  max: 11
		    	  },
		    	  locomotorOrCerebralPalsy:{
		    		  required:true
		    	  },
		    	  deafAndMute:{
		    		  required:true
		    	  }/*,  
		    	  differentlyAbled:{
			    	  required:true
			      } */
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