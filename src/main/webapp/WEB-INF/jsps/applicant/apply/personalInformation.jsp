<%@ include file="../../common/taglibs.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1" %>

<script>
    jQuery(document).ready(function() {
    	/* showOrNotDroughtAffected() */
    	 var emailExists=${emailExists};
    	 if(emailExists==false){
    		 $('#emailExistErrorDiv').hide();
    	 }
    	 jQuery('.belongToSEBC').hide();
    	// var now=new Date();
    	var now = new Date("20-02-2019".replace( /(\d{2})-(\d{2})-(\d{4})/, "$2/$1/$3"));

		now.setFullYear(now.getFullYear() - 18);

		var maxDate=new Date();
		maxDate.setFullYear(maxDate.getFullYear() + 100);

		var minDate = new Date();
		minDate.setFullYear(minDate.getFullYear() - 100);
		
    	/* var mobileNoVerifyOTP = applyObj.isValidate(${applicant.mobileNoVerified});
    	if(mobileNoVerifyOTP)
        {
           $("#mobileNumber").prop("readonly", true);
    	} */

    	var paymentSuccess = applyObj.isValidate(${dobDisabledFlag});
    	if(paymentSuccess)
       	{
    		$('#birthDateCalendarIcon').hide();
    		jQuery("#input-droughtAffectedYes").attr("disabled",true);
    		jQuery("#input-droughtAffected-no").attr("disabled",true);
    		
    		var date = '${applicant.birthDate}';
        	if(date != 'undefined' || date != null || date !='' )
        		$('#birthDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicant.birthDate}" />');
    		
       	}else{
       		$('#birthDate').datetimepicker({
                format: 'DD/MM/YYYY',
                ignoreReadonly: true,
                showTodayButton: true,
                minDate: minDate,
                maxDate: now
                //defaultDate: moment(),
                //date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicant.birthDate}" />'
            });

            $('#birthDateCalendarIcon').click(function() {
                $('#birthDate').data("DateTimePicker").show();
            });
            
            var date = '${applicant.birthDate}';
        	if(date != 'undefined' || date != null || date !='' )
        		$('#birthDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicant.birthDate}" />');
        }
        
        isPersonalInfoPage = true;

        var currentDate = new Date();
        var paymentdone = applyObj.isValidate(${disablePersonalInformationFormFieldsOnPayment});
        var appliedForDriverCumConductor2 = applyObj.isValidate(${isAppliedForDriverCumConductor});
        
        if(paymentdone || appliedForDriverCumConductor2){
        	var certdate = '${applicant.certificateValidityEndingDate}';
        	if(certdate != 'undefined' || certdate != null || certdate !='' )
        		$('#certificateValidityEndingDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicant.certificateValidityEndingDate}" />');
        }else{
        $('#certificateValidityEndingDate').datetimepicker({
            format: 'DD/MM/YYYY',
            ignoreReadonly: true,
            showTodayButton: true,
            //defaultDate: now,
            minDate: currentDate,
            maxDate: maxDate
            //date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicant.certificateValidityEndingDate}" />'
        });

        $('#certificateValidityEndingDateCalendarIcon').click(function() {
            $('#certificateValidityEndingDate').data("DateTimePicker").show();
        });
    }
        var date = '${applicant.birthDate}';
    	if(date != 'undefined' || date != null || date !='' )
    		$('#birthDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicant.birthDate}" />');

    	date = '${applicant.certificateValidityEndingDate}';
    	if(date != 'undefined' || date != null || date !='' )
    		$('#certificateValidityEndingDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicant.certificateValidityEndingDate}" />');

        
        jQuery("#personalInfoForm").ajaxForm({
            dataType:  'json',
            beforeSubmit:  function(){
                if (isDraft() || jQuery("#personalInfoForm").valid()) {
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
               var emailvalidation=result.emailExists;
              
                if(emailvalidation){
                		$('#emailExistErrorDiv').show();	
             		}else if(success){
             			$('#emailExistErrorDiv').hide();
             		
                 	applyObj.gotoTab('2');
                    return false;
                } else {
                	$('#emailExistErrorDiv').hide();
                    commonObj.showAlert("There was some error while trying to save the Personal Information.");
                }
            }
        });
        var gender = ${applicant.gender eq 1} ? true : false;
        checkConditionForCreamyLayer(gender, '${applicant.caste.id}');
        showOrNotSubcategory('${applicant.caste.id}');
        
        checkIfShowOrHideElements();
        
        $('select#casteId').change(function () {
        	var category = $('form#personalInfoForm').find('select#casteId').val();
        	
        	if(category=='10'){
        	
        	$('#certificateNumber').attr("required", false);
            $('#certificateValidityEndingDate').attr("required", false);
        		
        		jQuery('.belongToSEBC').show();
        		var noncreamyval = $( 'form#personalInfoForm' ).find('input[type=radio][name=nonCreamyLayer]:checked').val();
        		if(noncreamyval=='1'){
        			jQuery('.belongToSEBCYes').show();
        		}else{
        			jQuery('.belongToSEBCYes').hide();
        		}
        	}else{
        		jQuery('.belongToSEBC').hide();
        		jQuery('.belongToSEBCYes').hide();
        		$('#certificateNumber').attr("required", true);
                $('#certificateValidityEndingDate').attr("required", true);
        		
        	}
        	
        	if(category=='2' || category=='5' || category=='6' || category=='7' || category=='8' || category=='9'){
        		var noncreamyval = $( 'form#personalInfoForm' ).find('input[type=radio][name=nonCreamyLayer]:checked').val();
        		jQuery('.belongToSEBC').hide();
        		if(noncreamyval=='1'){
        			var allocatedCat = $('form#personalInfoForm').find('select#casteId').val();
        			$("#allocatedCategory").val(allocatedCat);
        		}else{
        			$("#allocatedCategory").val(1);
        		}
        	}
        	showOrNotSubcategory(category);
        });
        
        /* $('select#casteId').change(function () {
        	var category = $('form#personalInfoForm').find('select#casteId').val();
        	if(category=='2' || category=='5' || category=='6' || category=='7' || category=='8' || category=='9'){
        		var noncreamyval = $( 'form#personalInfoForm' ).find('input[type=radio][name=nonCreamyLayer]:checked').val();
        	
        		if(noncreamyval=='1'){
        			var allocatedCat = $('form#personalInfoForm').find('select#casteId').val();
        			$("#allocatedCategory").val(allocatedCat);
        		}else{
        			$("#allocatedCategory").val(1);
        		}
        	}
        	showOrNotSubcategory(category);
        }); */
    
        $( 'form#personalInfoForm' ).find('input[type=radio][name=nonCreamyLayer]').unbind().change(function() {
            if (this.value == '1') {
            	var allocatedCategory = $('form#personalInfoForm').find('select#casteId').val();
            	jQuery('.nonCreamyLayerToggle').show();
            	$("#allocatedCategory").val(allocatedCategory);
            	if(allocatedCategory == '10'){
            		var noncreamyval = $( 'form#personalInfoForm' ).find('input[type=radio][name=nonCreamyLayer]:checked').val();
            		if(noncreamyval == '1'){
            			jQuery('.belongToSEBCYes').show();
            		}
            		jQuery('.belongToSEBCYes').show();
            		$('#certificateNumber').attr("required", false);
                    $('#certificateValidityEndingDate').attr("required", false);
            	}
            } else {
            	jQuery('.nonCreamyLayerToggle').hide();
            	jQuery('.belongToSEBCYes').hide();
            	$('#certificateValidityEndingDate').val('');
            	$('#certificateNumber').val('');
            	$("#allocatedCategory").val(1);
            	commonObj.showAgreeDisAgreePopup("<fmt:message key='processing.charges.as.of.open.category' />", nonCreamyLayerAgreeDisAgreePopup, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
            }
        });
        
        $( 'form#personalInfoForm' ).find('input[type=radio][name=isBelongToEws]').unbind().change(function() {
            if (this.value == '1') {
            	jQuery('.belongToEwsYes').show();
            	var allocatedCategory = $('form#personalInfoForm').find('select#casteId').val();
            	$("#allocatedCategory").val(allocatedCategory);
            	$('#certificateValidityEndingDate').val('');
            	$('#certificateNumber').val('');
            } else {
            	jQuery('.belongToEwsYes').hide();
            	$("#allocatedCategory").val(1);
            	commonObj.showAgreeDisAgreePopup("<fmt:message key='processing.charges.as.of.open.category' />", ewsAgreeDisagreePopUp, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
                
            }
        });
        
        
        $('#casteIdValue').val($('select[id=casteId]').val());
        var isOneMonthCompletedOnPaymentDone = applyObj.isValidate(${isOneMonthCompletedOnPaymentDone});
        var appliedForDriverCumConductor = applyObj.isValidate(${isAppliedForDriverCumConductor});
        var paymentDoneForAtLeastOnePost = applyObj.isValidate(${disablePersonalInformationFormFieldsOnPayment});
        enableDisablePIFormFieldsOnPayment(paymentDoneForAtLeastOnePost,appliedForDriverCumConductor);
    	enableDisableGenderFieldOnPayment(${isApplicantApplyForPayment});
        var lastDateOver = commonObj.isValidate(${disableFormAfterLastDateOver});
        commonObj.disableFormFields("personalInfoForm",lastDateOver);
        
         /* if(isOneMonthCompletedOnPaymentDone && ($('form#personalInfoForm').find('select#casteId').val()== '10') ||$('form#personalInfoForm').find('select#casteId').val()== '11'){
        	if($('form#personalInfoForm').find('select#casteId').val()== '10'){
        		$('#certificateNumber').attr('disabled', 'disabled');
        		$('#certificateValidityEndingDate').attr('disabled', 'disabled');
        		
        	}else if($('form#personalInfoForm').find('select#casteId').val()== '11'){
        		$('#ewscertificateNumber').attr('disabled', 'disabled');
        	}else{
        		
        		 commonObj.disableFormFields("personalInfoForm",lastDateOver);
        	}
        	
        }else{
        	
        	if($('form#personalInfoForm').find('select#casteId').val()== '10'){
        		$('#certificateNumber').removeAttr("disabled");
        		$('#certificateValidityEndingDate').removeAttr("disabled");
        		
        	}else if($('form#personalInfoForm').find('select#casteId').val()== '11'){
        		$('#ewscertificateNumber').removeAttr("disabled");
        	}
        	
        }  */
        
        
        if(!isOneMonthCompletedOnPaymentDone){
        	if($('form#personalInfoForm').find('select#casteId').val()== '10'){
        		$('#certificateNumber').removeAttr("disabled");
        		$('#certificateValidityEndingDate').removeAttr("disabled");
        		$( 'form#personalInfoForm' ).find('input[type=hidden]').removeAttr("disabled");
        		
        	}else if($('form#personalInfoForm').find('select#casteId').val()== '11'){
        		$('#ewscertificateNumber').removeAttr("disabled");
        		$( 'form#personalInfoForm' ).find('input[type=hidden]').removeAttr("disabled");
        	}
        }
        
    });
    
    //==============-----------------------===============================
function enableDisableGenderFieldOnPayment(flag, flag2){
	
	if(flag){
		$('input[name="gender"]').attr('disabled', 'disabled');
	}else{
		$('input[name="gender"]').removeAttr('disabled', 'disabled');
	}
	
}
  
    function nonCreamyCertificateRequiredAtte(){
    	
    	if($('form#personalInfoForm').find('select#casteId').val()== '10'){
    		$('#certificateNumber').attr("required", false);
            $('#certificateValidityEndingDate').attr("required", false);
    	}else{
    		$('#certificateNumber').attr("required", true);
            $('#certificateValidityEndingDate').attr("required", true);
    	}
    }

function enableNonCreamyCertificate(){
	
	 var isOneMonthCompletedOnPaymentDone = applyObj.isValidate(${isOneMonthCompletedOnPaymentDone});
	 var casteId = $('form#personalInfoForm').find('select#casteId').val();
	 if(isOneMonthCompletedOnPaymentDone && (casteId == '10' || casteId == '11') ){
		 $('#certificateValidityEndingDateCalendarIcon').hide();
			var certdate = '${applicant.certificateValidityEndingDate}';
	    	if(certdate != 'undefined' || certdate != null || certdate !='' ){
	    		$('#certificateValidityEndingDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicant.certificateValidityEndingDate}" />');
	    	}
	    	jQuery("#certificateNumber").attr("readonly",true);
	    	jQuery("#ewscertificateNumber").attr("readonly",true);
		 
	 }else if(casteId != '10' && casteId != '11'){
		 

		 $('#certificateValidityEndingDateCalendarIcon').hide();
			var certdate = '${applicant.certificateValidityEndingDate}';
	    	if(certdate != 'undefined' || certdate != null || certdate !='' ){
	    		$('#certificateValidityEndingDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicant.certificateValidityEndingDate}" />');
	    	}
	    	jQuery("#certificateNumber").attr("readonly",true);
	    	jQuery("#ewscertificateNumber").attr("readonly",true);
		 
	 }else{
		 
	    	 $('#certificateValidityEndingDate').datetimepicker({
 	            format: 'DD/MM/YYYY',
 	            ignoreReadonly: true,
 	            showTodayButton: true,
 	            //defaultDate: now,
 	            //minDate: var currentDate = new Date();,
 	            //maxDate: maxDate
 	            //date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicant.certificateValidityEndingDate}" />'
 	        });

 	        $('#certificateValidityEndingDateCalendarIcon').click(function() {
 	            $('#certificateValidityEndingDate').data("DateTimePicker").show();
 	        });

 	        jQuery("#certificateNumber").attr("readonly",false);
 	       jQuery("#ewscertificateNumber").attr("readonly",false);
	 }
}

    
function enableDisablePIFormFieldsOnPayment(flag, flag2){
	var now = new Date("02/03/2017");
	now.setFullYear(now.getFullYear() - 18);
	
	var maxDate=new Date();
	maxDate.setFullYear(maxDate.getFullYear() + 100);

	var minDate = new Date();
	minDate.setFullYear(minDate.getFullYear() - 100);
	
	var currentDate = new Date();
	
	if(flag || flag2){
		
		jQuery("#firstName").attr("readonly",true);
		jQuery("#firstName_marathi").attr("readonly",true);
		jQuery("#middleName").attr("readonly",true);
		jQuery("#middleName_marathi").attr("readonly",true);
		jQuery("#lastName").attr("readonly",true);
		jQuery("#lastName_marathi").attr("readonly",true);
		$( 'form#personalInfoForm' ).find('input[type=radio][name=childOfFarmerWhoCommittedSuicide]').click(function(){
		    return false;
		});
		//$('input[name="gender"]').attr('disabled', 'disabled');
		$('#birthDateCalendarIcon').hide();
		var date = '${applicant.birthDate}';
    	if(date != 'undefined' || date != null || date !='' ){
    		$('#birthDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicant.birthDate}" />');
    	}
    	
		jQuery("#emailAddress").attr("readonly",true);
		$( 'form#personalInfoForm' ).find('input[type=radio][name=readWriteSpeakMarathi]').click(function(){
		    return false;
		});
		
		$( 'form#personalInfoForm' ).find('input[type=radio][name=isBelongToEws]').click(function(){
		    return false;
		});
		jQuery("#casteId").attr("disabled",true);
		jQuery("#subcategory").attr("readonly",true);
		$( 'form#personalInfoForm' ).find('input[type=radio][name=nonCreamyLayer]').click(function(){
		    return false;
		});
		enableNonCreamyCertificate();
		/* $('#certificateValidityEndingDateCalendarIcon').hide();
		var certdate = '${applicant.certificateValidityEndingDate}';
    	if(certdate != 'undefined' || certdate != null || certdate !='' ){
    		$('#certificateValidityEndingDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicant.certificateValidityEndingDate}" />');
    	}
    	jQuery("#certificateNumber").attr("readonly",true); */
	
	}else{
		jQuery("#firstName").attr("readonly",false);
		jQuery("#firstName_marathi").attr("readonly",false);
		jQuery("#middleName").attr("readonly",false);
		jQuery("#middleName_marathi").attr("readonly",false);
		jQuery("#lastName").attr("readonly",false);
		jQuery("#lastName_marathi").attr("readonly",false);
		//$('input[name="gender"]').removeAttr('disabled', 'disabled');
		$('#birthDateCalendarIcon').show();
		$('#birthDate').datetimepicker({
            format: 'DD/MM/YYYY',
            ignoreReadonly: true,
            showTodayButton: true,
            minDate: minDate,
            maxDate: now
            //defaultDate: moment(),
            //date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicant.birthDate}" />'
        });

        $('#birthDateCalendarIcon').click(function() {
            $('#birthDate').data("DateTimePicker").show();
        });
        
        var date = '${applicant.birthDate}';
    	if(date != 'undefined' || date != null || date !='' )
    		$('#birthDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicant.birthDate}" />');
        
        jQuery("#emailAddress").attr("readonly",true);
		//$( 'form#personalInfoForm' ).find('input[type=radio][name=readWriteSpeakMarathi]').attr("readonly",false);
		jQuery("#casteId").attr("disabled",false);
		jQuery("#subcategory").attr("readonly",false);
		//$( 'form#personalInfoForm' ).find('input[type=radio][name=nonCreamyLayer]').attr("readonly",false);
		$('#certificateValidityEndingDateCalendarIcon').show();
		$('#certificateValidityEndingDate').datetimepicker({
            format: 'DD/MM/YYYY',
            ignoreReadonly: true,
            showTodayButton: true,
            //defaultDate: now,
            minDate: currentDate,
            maxDate: maxDate
            //date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicant.certificateValidityEndingDate}" />'
        });

        $('#certificateValidityEndingDateCalendarIcon').click(function() {
            $('#certificateValidityEndingDate').data("DateTimePicker").show();
        });
        jQuery("#certificateNumber").attr("readonly",false);
	}
}
    
 function nonCreamyLayerAgreeDisAgreePopup(flag)
 {
 	if(!flag)
 	{
 		$('#input-nonCreamyLayer-yes').prop('checked', true);
 		$('.nonCreamyLayerToggle').attr("required", true);
 		jQuery('.nonCreamyLayerToggle').show();
 		jQuery('.belongToSEBCYes').hide();
 		$('#certificateValidityEndingDate').val('');
 		$('#certificateNumber').val('');
 		var noncreamyval = $( 'form#personalInfoForm' ).find('input[type=radio][name=nonCreamyLayer]:checked').val();
 		if(noncreamyval=='1'){
			var allocatedCat = $('form#personalInfoForm').find('select#casteId').val();
			if(allocatedCat=='10'){
				jQuery('.belongToSEBCYes').show();
			}
			$("#allocatedCategory").val(allocatedCat);
		}else{
			$("#allocatedCategory").val(1);
		}
 	}
 }
    function ewsAgreeDisagreePopUp(flag){
    	
    	if(!flag){
    		$('#input-ews-yes').prop('checked', true);
    		jQuery('.belongToEwsYes').show();
    	}
    	
    }
    function checkIfShowOrHideElements() {
		if ('${applicant.nonCreamyLayer}'=='' || '${applicant.nonCreamyLayer}'=='false') {
			jQuery('.nonCreamyLayerToggle').hide();
			jQuery('.belongToSEBCYes').hide();
		}
		
		if($('form#personalInfoForm').find('select#casteId').val() =='10'){
			jQuery('.belongToSEBC').show();
		}
	
		if ('${applicant.isBelongToEws}'=='' || '${applicant.isBelongToEws}'=='false') {
			jQuery('.belongToEwsYes').hide();
		}else if('${applicant.isBelongToEws}'=='true' || '${applicant.isBelongToEws}'==true ){
			jQuery('.belongToEwsYes').show();
		}
		/* if ('${applicant.gender}'==1) {
			jQuery('#parallelReservationWomen').hide();
		}else{
			jQuery('#parallelReservationWomen').show();
		} */
		var category = $('form#personalInfoForm').find('select#casteId').val();
		
    	showOrNotSubcategory(category);
		if(category=='11'){
			jQuery('.beloangToEWS').show();
		}
    }
    
    /* $( 'form#personalInfoForm' ).find('input[type=radio][name=nonCreamyLayer]').unbind().change(function() {
        if (this.value == '1') {
        	jQuery('.nonCreamyLayerToggle').show();
        } else {
        	jQuery('.nonCreamyLayerToggle').hide();
        }
    }); */
    
    /* $( 'form#personalInfoForm' ).find('input[type=radio][name=gender]').change(function() {
        if (this.value == '1') {
        	jQuery('#parallelReservationWomen').hide();
        } else {
        	jQuery('#parallelReservationWomen').show();
        }
    }); */

    function isDraft(){
        var status = jQuery("#status").val();
        return status == 0 || status == '0';
    }


    function savePersonalInformationAsDraft()
    {
        $('#takeDecision').val('2');
        callSaveAndSaveAsDraft();

    }

    function savePersonalInformation(){
    	$('#takeDecision').val('1');
    	callSaveAndSaveAsDraft();
    	
    }
	function callSaveAndSaveAsDraft()
	{
		$('#aplicantDOB').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicant.birthDate}" />');
		var oldDate = '<tags:localDate pattern="dd/MM/yyyy" date="${applicant.birthDate}" />';
		var changeDate = ""+$('#birthDate').val();
				
    	if(oldDate != changeDate)
        {
    		commonObj.showConfirmation('<fmt:message key="confirm.change.birthDate"/>', callBack, '<fmt:message key="yes"/>', '<fmt:message key="no"/>','<fmt:message key="change.birth.date"/>');
        }else{
        	var takeDecision=$('#takeDecision').val();
    		if(takeDecision == '1' ){
    			applyObj.callSave();
    		}
    		else{
    			applyObj.callSaveAsDraft();
    		}
        }
	}
	
    function callBack(flag) {
		if(flag) {
			var changeDate = $('#birthDate').val();//'<tags:localDate pattern="dd/MM/yyyy" date="${applicant.birthDate}" />';
			applyObj.viewDisabledPostBySelectedDOB(${applicant.id}, changeDate);
		}
		else {
			//var oldDate = new Date( moment(${applicant.birthDate}).format("DD/MM/YYYY"));
			$('#birthDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicant.birthDate}" />');
			$('#takeDecision').val('');
			$('#deletedPostIds').val('');
			
		}
    }
    
    function isBeloangToNonCreamyLayer() {
    	$('#casteIdValue').val($('select[id=casteId]').val());
    	var gender = $('form#personalInfoForm').find('input[id=input-gender-male]').is(':checked');
    	var category = $('form#personalInfoForm').find('select#casteId').val();
    	
    	checkConditionForCreamyLayer(gender, category);
    	$('#certificateNumber').attr("required", true);
        $('#certificateValidityEndingDate').attr("required", true);
    	
    	if($('#casteIdValue').val($('select[id=casteId]').val()) == '10'){
    		$('#certificateNumber').attr("required", false);
            $('#certificateValidityEndingDate').attr("required", false);
    	}
    	
    }
	
    function checkConditionForCreamyLayer(gender, category) {
    	if ((gender && category == '1') || category == '3' || category == '4' || category == '') {
    		$('.beloangToNonCreamyLayer').hide();
    		$('.beloangToNonCreamyLayer').find('input[type!=radio]').val('');
    		$('.beloangToNonCreamyLayer').find('input[type=radio]').prop('checked', false);
    		$('.beloangToEWS').find('input[type=radio]').prop('checked', false);
    		$('.beloangToEWS').hide();
    		$('.belongToEwsYes').hide();
    	}else if(category =='11'){
    		$('.beloangToEWS').show();
    		$('.nonCreamyLayerToggle').hide();
    		jQuery('.belongToSEBCYes').hide();
    		$('.beloangToNonCreamyLayer').hide();
    		$('.beloangToNonCreamyLayer').find('input[type!=radio]').val('');
    		$('.beloangToNonCreamyLayer').find('input[type=radio]').prop('checked', false);
    		//$('.subcategoryToggle').hide();
    		
    	}
    	else {
    		$('.beloangToEWS').find('input[type=radio]').prop('checked', false);
    		$('.beloangToNonCreamyLayer').show();
    		$('.nonCreamyLayerToggle').attr("required", true);
    		$('.beloangToEWS').hide();
    		$('.belongToEwsYes').hide();
    		if ($("input[name='nonCreamyLayer']:checked").val()==0 || $("input[name='nonCreamyLayer']:checked").val()=='0' ) {
    			$('.nonCreamyLayerToggle').hide();
    			jQuery('.belongToSEBCYes').hide();
    			
    		}
    		
    		if(category == '1' && gender != '1'){
    			jQuery('.belongToSEBCYes').hide();
    		}
    		if(category =='10'){
    			var noncreamyval = $( 'form#personalInfoForm' ).find('input[type=radio][name=nonCreamyLayer]:checked').val();
        		if(noncreamyval=='1'){
        			jQuery('.belongToSEBCYes').show();
        		}
    			
    			$('#certificateNumber').attr("required", false);
                $('#certificateValidityEndingDate').attr("required", false);
    		}
    			
    		}
    	
    	
    
    	if (category == '1' || category=='10') {
    		showOrNotSubcategory(category);
    		
    		var noncreamyval = $( 'form#personalInfoForm' ).find('input[type=radio][name=nonCreamyLayer]:checked').val();
    		if(noncreamyval=='1' && category == '10'){
    			jQuery('.belongToSEBCYes').show();
    		}
    		$('#certificateNumber').attr("required", false);
            $('#certificateValidityEndingDate').attr("required", false);
    	}else{
    		jQuery('.belongToSEBCYes').hide();
    		$('#certificateNumber').attr("required", true);
            $('#certificateValidityEndingDate').attr("required", true);
    	}
    	
    }
    
   /*  $('select#casteId').change(function () {
    	
    	var category = $('form#personalInfoForm').find('select#casteId').val();
    	showOrNotSubcategory(category);
    }); */
    
    /* function showOrNotDroughtAffected() {
    	var districtId = $('form#personalInfoForm').find('select#districtId').val();
    	
    	validateDroughtAffected(districtId);
    	
    }
    
    function validateDroughtAffected(districtId) {
    	
    	var jsonDistrict = ${jsonDistrict};
    	
    	$.each(jsonDistrict, function (i, item) {
            //console.log("ID: " + item.id);
            
           if(districtId == jsonDistrict[i].id){
        	   if(jsonDistrict[i].isDroughtAffected){
        		   $('.droughtAffectedToggle').attr("required", true);
        		   $('.droughtAffectedToggle').show();
        	   }else{
        		   
        		$('.droughtAffectedToggle').hide();
           		$('.droughtAffectedToggle').find('input[type!=radio]').val('');
           		$('.droughtAffectedToggle').find('input[type=radio]').prop('checked', false);
        	   }
           }
           // console.log(" ");
        });
    	
    	
    } */
    
    function showOrNotSubcategory(category) {
    	
    	if (category == null || category == '' || category == '1' || category == '0' || category == '10') {
    		$('.subcategoryToggle').hide();
    		$('.beloangToEWS').hide();
    		$('.belongToEwsYes').hide()
    		$( 'form#personalInfoForm' ).find('input#subcategory').val('').prop('required', false);
    		if(category == '10'){
    			var noncreamyval = $( 'form#personalInfoForm' ).find('input[type=radio][name=nonCreamyLayer]:checked').val();
        		if(noncreamyval=='1'){
        			jQuery('.belongToSEBCYes').show();
        		}
    			$('#certificateNumber').attr("required", false);
                $('#certificateValidityEndingDate').attr("required", false);
    		}
    	} else {
    		$('.subcategoryToggle').show();
    		$('.beloangToEWS').hide();
    		$('.belongToEwsYes').hide()
    		if(category == '11'){
    			$('.beloangToEWS').show();
    			if ($("input[name='isBelongToEws']:checked").val()==1 || $("input[name='isBelongToEws']:checked").val()=='1') {
    				$('.belongToEwsYes').show()
        			
        		}else{
        			$('.belongToEwsYes').find('input[type!=radio]').val('');
        		}
    			$('.subcategoryToggle').hide();
        		//$('.belongToEwsYes').hide();
    		}
//     		$( 'form#personalInfoForm' ).find('input#subcategory').prop('required', true);
    	}
    }
    
    $('input#input-nonCreamyLayer-no').click(function() {
    	if ($('form#personalInfoForm').find('input[id=input-nonCreamyLayer-no]').is(':checked')) {
    		$('.beloangToNonCreamyLayer').find('input[type!=radio]').val('');
    	}
    });
    
    $('input#input-ews-no').click(function() {
    	if ($('form#personalInfoForm').find('input[id=input-ews-no]').is(':checked')) {
    		$('.beloangToEWS').find('input[type!=radio]').val('');
    	}
    });
  
</script>

<form class="form-horizontal" name="personalInfoForm" id="personalInfoForm"  action="<c:url value='/applicant?operation=savePersonalInformation'/>" method="POST" novalidate >

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${applicant.id}"/>
    <input type="hidden" name="status" id="status"  value="${ applicant.status }"/>
	<input type="hidden" name="aplicantDOB" id="aplicantDOB" />
	<input type="hidden" name="deletedPostIds" id="deletedPostIds" />
	<input type="hidden" name="takeDecision" id="takeDecision" />
	<input type="hidden" id="allocatedCategory" value="${ applicant.allocatedCategory }" name="allocatedCategory">
    <div class="form-group">
        <label class="control-label col-sm-4 " for="firstName"><fmt:message key="applicant.firstName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${ applicant.firstName }" type="text" class="form-control" id="firstName" placeholder="<fmt:message key="firstname.field.placeholder.english"/>" name="firstName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
        <div class="col-sm-4">
            <input value="${ applicant.firstNameMarathi }" type="text" class="form-control" id="firstName_marathi" placeholder="<fmt:message key="firstname.field.placeholder.marathi"/>" name="firstNameMarathi" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4 " for="middleName"><fmt:message key="applicant.middleName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${ applicant.middleName }" type="text" class="form-control" id="middleName" placeholder="<fmt:message key="middlename.field.placeholder.english"/>" name="middleName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
        <div class="col-sm-4">
            <input value="${ applicant.middleNameMarathi }" type="text" class="form-control" id="middleName_marathi" placeholder="<fmt:message key="middlename.field.placeholder.marathi"/>" name="middleNameMarathi" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4 " for="lastName"><fmt:message key="applicant.lastName" />: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${ applicant.lastName }"  type="text" class="form-control" id="lastName" placeholder="<fmt:message key="lastname.field.placeholder.english" />" name="lastName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
        <div class="col-sm-4">
            <input value="${ applicant.lastNameMarathi }"  type="text" class="form-control" id="lastName_marathi" placeholder="<fmt:message key="lastname.field.placeholder.marathi" />" name="lastNameMarathi" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4 " for="birthDate"><fmt:message key="applicant.birthDate"/>: <span class="red">*</span></label>
        <div class="col-sm-2">
            <div class="input-group date">
                <input type="datetime" class="form-control" id="birthDate" placeholder="<fmt:message key="applicant.birthDate"/>" name="birthDate" readonly
                       required>
                <div class="input-group-addon" id="birthDateCalendarIcon">
                    <i class="fa fa-calendar"></i>
                </div>
                <div class="help-block with-errors"></div>
            </div>
        </div>
        <div class="col-sm-3">
        	<%-- <fmt:message key="applicant.applicantAge"/>: ${applicant.applicantAgeInYears} - <fmt:message key="applicant.applicantAgeInYears"/>
										&nbsp;${applicant.applicantAgeInMonths} - <fmt:message key="applicant.applicantAgeInMonths"/>&nbsp;&nbsp;&nbsp;${applicant.applicantAgeInDays} - <fmt:message key="applicant.applicantAgeInDays"/> --%>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4 "></label>
        <div class="col-sm-8">
            <em><fmt:message key="ageAsOnDateOfAdvertisement"/>: ${ageAsOnGivenDate[0]} - <fmt:message key="applicant.applicantAgeInYears"/>
                &nbsp;${ageAsOnGivenDate[1]} - <fmt:message key="applicant.applicantAgeInMonths"/> &nbsp;${ageAsOnGivenDate[2]} - <fmt:message key="applicant.applicantAgeInDays"/></em>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4 " for="input-gender-male"><fmt:message key="applicant.gender"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
	        <div class="radio radio-inline" id="gender-male-id">
	                <input type="radio" name="gender" ${ applicant.gender eq 1 ? 'checked="checked"':''} value="1" class="form-control" id="input-gender-male" onchange="javascript:isBeloangToNonCreamyLayer()" required>
	                <label for="input-gender-male"> <fmt:message key="applicant.gender.male"/> </label>
	        </div>
	        <div class="radio radio-inline" id="gender-female-id">
	               	<input type="radio" name="gender" value="0" class="form-control" id="input-gender-female" ${ applicant.gender eq 0 ? 'checked="checked"':''} onchange="javascript:isBeloangToNonCreamyLayer()" required>
	                <label for="input-gender-female"> <fmt:message key="applicant.gender.female"/> </label>
	        </div>
	        <%-- <div id="parallelReservationWomen" class="col-sm-12">
            			<fmt:message key="parallelReservation.forWomen"/>
            </div> --%>
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div id="addressTextArea" class="form-group">
        <label class="control-label col-sm-4 " for="address"><fmt:message key="applicant.address"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <textarea class="form-control" rows="5" id="address" name="address" maxlength="1000" placeholder="<fmt:message key="applicant.address"/>">${ applicant.address }</textarea>
            <div id="addressError" class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group ">
        <label class="control-label col-sm-4 " for="pinCode"><fmt:message key="applicant.pinCode"/>: <span class="red">*</span></label>
<%--         <fmt:message key="applicant.pin.sixdigits"/> --%>
        <div class="col-sm-4">
            <input value="${ applicant.pinCode }"  name="pinCode" class="form-control" id="pinCode" type="tel" maxlength="6" placeholder="<fmt:message key="applicant.pinCode"/>" />
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group ">
        <label class="control-label col-sm-4 " for="emailAddress"><fmt:message key="applicant.emailAddress"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${ applicant.emailAddress }"  name="emailAddress" class="form-control" id="emailAddress" type="email" required maxlength="30" readonly="readonly" placeholder="<fmt:message key="applicant.emailAddress"/>" />
            <div class="help-block with-errors"></div>
            <div id="emailExistErrorDiv" class="error" style="color: #B94A48"><fmt:message key="registration.email.address.already.exists" /></div>
        </div>
    </div>

    <div class="form-group ">
        <label class="control-label col-sm-4 " for="mobileNumber"><fmt:message key="applicant.mobileNumber"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${ applicant.mobileNumber }"  name="mobileNumber" class="form-control" id="mobileNumber" type="tel" maxlength="10" placeholder="<fmt:message key="applicant.mobileNumber"/>"/>
            <div class="help-block with-errors"></div>
        </div>
    </div>
  
    <div class="form-group">
        <label class="control-label col-sm-4" for="highestQualificationDetails"><fmt:message key="applicant.highestQualification"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <select id="highestQualificationDetails" name="highestQualification" class="form-control" required oninvalid="this.setCustomValidity('<fmt:message key="validation.requiredfield"/>')">
            	
				<option value="">-- <fmt:message key="highestqualification.select"/> --</option>
            	<c:forEach items="${highestQualificationList}" var="highestqualification">
					<option value="${highestqualification.id}" ${ highestqualification.id eq applicant.highestQualification? 'selected':'' }>
						<c:choose>
							<c:when test="${locale eq 'en' }">
								${highestqualification.title}
							</c:when>
							<c:otherwise>
								${highestqualification.titleInMarathi}
							</c:otherwise>					
						</c:choose> 
					</option>
				</c:forEach>
            </select>
            <div class="help-block with-errors"></div>
        </div>
    </div>

	<div class="form-group">
	        <label for="districtId" class="control-label col-sm-4"><fmt:message key="applicant.list.district" />: <span class="red">*</span></label>
	        <div class="col-sm-4">
	                <select id="districtId" name="districtId" class="form-control" required oninvalid="this.setCustomValidity('<fmt:message key="validation.requiredfield"/>')">
					<option value="">-- <fmt:message key="please.select"/> --</option>
	                <c:forEach items="${districts}" var="district">
						<option value="${district.id}" ${ district.id eq applicant.districtId? 'selected':'' }><fmt:message key="${ district.messageKey }" /></option>
					</c:forEach>
				</select>
	<!--             <div class="help-block with-errors"></div> -->
	        </div>
	</div>
	<!--  Drought Affected -->
	<div class="form-group droughtAffected">
        <label class="control-label col-sm-4 " for="droughtAffected"> <fmt:message key="applicant.droughtAffected"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
        	<div class="radio radio-inline" id="droughtAffected-yes-id">
	                <input type="radio" name="droughtAffected" ${ applicant.droughtAffected ? 'checked="checked"':''} value="1" class="form-control" data-backdrop="static" data-keyboard="false" data-target="#droughtAffectedModal" data-toggle="modal" id="input-droughtAffectedYes" disabled=true>
	                <label for="input-droughtAffectedYes"><fmt:message key="yes"/></label>
	        </div>
	        <div class="radio radio-inline" id="droughtAffected-no-id">
	               	<input type="radio" name="droughtAffected" value="0" class="form-control" onclick="javascript:void(0);"  id="input-droughtAffected-no" ${applicant.droughtAffected eq false? 'checked="checked"':''} disabled=true>
	                <label for="input-droughtAffected-no"><fmt:message key="no"/></label>
	        </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group ">
        <label class="control-label col-sm-4 " for="input-maritalStatus-married"><fmt:message key="applicant.maritalStatus"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
        	<div class="radio radio-inline" id="maritalStatus-married-id">
	                <input type="radio" name="maritalStatus" ${ applicant.maritalStatus eq 1 ? 'checked="checked"':''} value="1" class="form-control" id="input-maritalStatus-married">
	                <label for="input-maritalStatus-married"> <fmt:message key="applicant.maritalStatus.married"/> </label>
	        </div>
	        <div class="radio radio-inline" id="maritalStatus-unmarried-id">
	               	<input type="radio" name="maritalStatus" value="0" class="form-control" id="input-maritalStatus-unmarried" ${ applicant.maritalStatus eq 0 ? 'checked="checked"':''} >
	                <label for="input-maritalStatus-unmarried"> <fmt:message key="applicant.maritalStatus.unmarried"/> </label>
	        </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4 " for="input-maharashtraDomiciled-yes"><fmt:message key="applicant.maharashtraDomiciled"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
        	<div class="radio radio-inline" id="maharashtraDomiciled-yes-id">
	                <input type="radio" name="maharashtraDomiciled" ${ applicant.maharashtraDomiciled ? 'checked="checked"':''} value="1" class="form-control" id="input-maharashtraDomiciled-yes" >
	                <label for="input-maharashtraDomiciled-yes"> <fmt:message key="yes"/> </label>
	        </div>
	        <div class="radio radio-inline" id="maharashtraDomiciled-no-id">
	               	<input type="radio" name="maharashtraDomiciled" value="0" class="form-control" onclick="javascript:void(0);" data-backdrop="static" data-keyboard="false" data-target="#maharashtraDomiciledModal" data-toggle="modal" id="input-maharashtraDomiciled-no" ${applicant.maharashtraDomiciled eq false? 'checked="checked"':''} >
	                <label for="input-maharashtraDomiciled-no"> <fmt:message key="no"/> </label>
	        </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4 "><fmt:message key="applicant.readWriteSpeakMarathi"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
        	<div class="radio radio-inline" id="readWriteSpeakMarathi-yes-id">
	                <input type="radio" name="readWriteSpeakMarathi" ${ applicant.readWriteSpeakMarathi ? 'checked="checked"':''} value="1" class="form-control" id="input-readWriteSpeakMarathi-yes" >
	                <label for="input-readWriteSpeakMarathi-yes"> <fmt:message key="yes"/> </label>
	        </div>
	        <div class="radio radio-inline" id="readWriteSpeakMarathi-no-id">
	               	<input class="radiosToCheck" type="radio" name="readWriteSpeakMarathi" value="0" class="form-control" onclick="applyObj.bindPersonalInfoForm('personalInfoForm');" id="input-readWriteSpeakMarathi-no" ${applicant.readWriteSpeakMarathi eq false? 'checked="checked"':''} >
	                <label for="input-readWriteSpeakMarathi-no"> <fmt:message key="no"/> </label>
	        </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4 " for="casteId"><fmt:message key="applicant.list.caste"/>: <span class="red">*</span> </label>
        <div class="col-sm-4">
        <input type="hidden" name="caste.id" id="casteIdValue">
            <select id="casteId" class="form-control" onchange="javascript:isBeloangToNonCreamyLayer()" required oninvalid="this.setCustomValidity('<fmt:message key="validation.requiredfield"/>')">
                <option value="" onchange="javascript:isBeloangToNonCreamyLayer()">-- <fmt:message key="please.select"/> --</option>
                <c:forEach items="${castes}" var="caste">
                    <option value="${caste.id}" ${ caste.id eq applicant.caste.id? 'selected=selected':'' }><fmt:message key="${ caste.messageKey }" /> </option>
                </c:forEach>
            </select>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group belongToSEBC" >
    	<label class="control-label col-sm-12 "><fmt:message key="sebc.belong.advantage.message"/></label>
       
    </div>
    
     <!-- Here End == Are you a child of a farmer, who committed suicide?  -->
    
    <div class="form-group subcategoryToggle">
        <label class="control-label col-sm-4 " for="subcategory"><fmt:message key="applicant.subcategory" />: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${ applicant.subcategory }"  type="text" class="form-control" id="subcategory" placeholder="<fmt:message key="applicant.subcategory" />" name="subcategory" maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    

<!--     <div class="form-group beloangToNonCreamyLayer"> -->
<%--         <label class="control-label col-sm-4 " for="nonCreamyLayer"><fmt:message key="applicant.belongtocreamylayer"/>: <span class="red"></span></label> --%>
<!--         <div class="col-sm-4"> -->
<!--             <div class="checkbox"> -->
<%--                 <input type="checkbox" ${ applicant.nonCreamyLayer? 'checked=checked':'' } name="nonCreamyLayer" id="nonCreamyLayer" placeholder="<fmt:message key="applicant.belongtocreamylayer"/>"/> --%>
<!--                 <label for="nonCreamyLayer"></label> -->
<!--             </div> -->
<!--             <div class="help-block with-errors"></div> -->
<!--         </div> -->
<!--     </div> -->
    
    <div class="form-group beloangToNonCreamyLayer">
        <label class="control-label col-sm-4 "><fmt:message key="applicant.belongtocreamylayer"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
        	<div class="radio radio-inline" id="nonCreamyLayer-yes-id">
	                <input type="radio" id="input-nonCreamyLayer-yes" name="nonCreamyLayer" ${ applicant.nonCreamyLayer ? 'checked="checked"':''} value="1" class="form-control">
	                <label for="input-nonCreamyLayer-yes"> <fmt:message key="yes"/> </label>
	        </div>
	        <div class="radio radio-inline" id="nonCreamyLayer-no-id">
	               	<input type="radio" id="input-nonCreamyLayer-no" name="nonCreamyLayer" ${applicant.nonCreamyLayer eq false? 'checked="checked"':''}  value="0" class="form-control">
	                <label for="input-nonCreamyLayer-no"> <fmt:message key="no"/> </label>
	        </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
	
	<div class="form-group belongToSEBCYes" >
    	<label class="control-label col-sm-12 "><fmt:message key="sebc.belong.advantage.message.yes"/></label>
       
    </div>
	
    <div class="form-group beloangToNonCreamyLayer nonCreamyLayerToggle">
        <label class="control-label col-sm-4 " for="certificateValidityEndingDate"><fmt:message key="applicant.certificatevalidity.endingdate"/>: <span class="red">*</span></label>
        <div class="col-sm-2">
            <div class="input-group date">
                <input type="datetime" value="'<tags:localDate pattern="dd/MM/yyyy" date="${ applicant.certificateValidityEndingDate }" />'" class="form-control" id="certificateValidityEndingDate" placeholder="<fmt:message key="applicant.certificatevalidity.endingdate"/>" name="certificateValidityEndingDate" readonly>
                <div class="input-group-addon" id="certificateValidityEndingDateCalendarIcon">
                    <i class="fa fa-calendar"></i>
                </div>
            </div>
             <div class="help-block with-errors"></div>
        </div>
        <label class="control-label col-sm-3 " for="certificateNumber"><fmt:message key="applicant.certificate.number" />: <span class="red">*</span></label>
        <div class="col-sm-3">
            <input value="${ applicant.certificateNumber }"  type="text" class="form-control" id="certificateNumber" placeholder="<fmt:message key="applicant.certificate.number" />" name="certificateNumber" maxlength="25">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    
    <div class="form-group beloangToEWS" >
        <label class="control-label col-sm-4 "><fmt:message key="ews.belongto.advantage.message"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
        	<div class="radio radio-inline" id="ews-yes-id">
	                <input type="radio" id="input-ews-yes" name="isBelongToEws" ${ applicant.isBelongToEws ? 'checked="checked"':''} value="1" class="form-control">
	                <label for="input-ews-yes"> <fmt:message key="yes"/> </label>
	        </div>
	        <div class="radio radio-inline" id="ews-no-id">
	               	<input type="radio" id="input-ews-no" name="isBelongToEws" ${applicant.isBelongToEws eq false? 'checked="checked"':''}  value="0" class="form-control">
	                <label for="input-ews-no"> <fmt:message key="no"/> </label>
	        </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group belongToEwsYes" >
    	<label class="control-label col-sm-12 "><fmt:message key="ews.advantage.yes.message"/></label>
       
    </div>
    
    <div class="form-group belongToEwsYes">
    	<div class="col-sm-3">
            <input value="${applicant.ewsCertificateNumber}"  type="text" class="form-control" id="ewscertificateNumber" placeholder="<fmt:message key="applicant.certificate.number" />" name="ewsCertificateNumber" maxlength="25">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <!-- Here Start == Are you a child of a farmer, who committed suicide?=========  -->
    
     <div class="form-group">
        <label class="control-label col-sm-4 " for="input-childOfFarmerWhoCommittedSuicide-yes"><fmt:message key="applicant.childOfFarmerWhoCommittedSuicide"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
        	<div class="radio radio-inline" id="childofafarmerwhocommittedsuicide-yes-id">
	                <input type="radio" name="childOfFarmerWhoCommittedSuicide" ${ applicant.childOfFarmerWhoCommittedSuicide ? 'checked="checked"':''} value="1" class="form-control" id="input-childOfFarmerWhoCommittedSuicide-yes" data-backdrop="static" data-keyboard="false" data-target="#childOfFarmerWhoCommittedSuicideModal" data-toggle="modal">
	                <label for="input-childOfFarmerWhoCommittedSuicide-yes"> <fmt:message key="yes"/> </label>
	        </div>
	        
	        <div class="radio radio-inline" id="childOfFarmerWhoCommittedSuicide-no-id">
	               	<input type="radio" name="childOfFarmerWhoCommittedSuicide" value="0" class="form-control" id="input-childOfFarmerWhoCommittedSuicide-no" ${applicant.childOfFarmerWhoCommittedSuicide eq false? 'checked="checked"':''} >
	                <label for="input-childOfFarmerWhoCommittedSuicide-no"> <fmt:message key="no"/> </label>
	        </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <nav class="navbar btn-toolbar sw-toolbar sw-toolbar-bottom">
        <div class="btn-group navbar-btn sw-btn-group pull-right" role="group">
            <span class="processingRequest greenTxt" style="display: none" id="processingRequestSpan">
                 	<img src="<c:url value='static/app/images/smallLoader.gif'/>" class="smallLoader">
                <fmt:message key="processingrequest"/>
            </span>&nbsp;
            <c:if test="${!disableFormAfterLastDateOver}">
                <button onclick="javascript:savePersonalInformation();" class="btn btn-default sw-btn-next skipDisabling" type="button" id="saveBtn">
                    <fmt:message key="save" />
                </button>
                <c:if test="${ disableSaveAsDraft ne 1 and disableSaveAsDraft ne '1' }">
                	<c:if test="${!disablePersonalInformationFormFieldsOnPayment }">
	                    <button onclick="javascript:savePersonalInformationAsDraft();" class="cancel btn btn-default sw-btn-next" type="button" id="saveAsDraftBtn" >
	                        <fmt:message key="saveAsDraft" />
	                    </button>
                    </c:if>
                </c:if>
            </c:if>
            
            <c:if test="${disableFormAfterLastDateOver}">
            	<c:if test="${!isOneMonthCompletedOnPaymentDone}">
            	<c:if test="${casteId ==10 || casteId == 11}">
            	<c:if test="${isSelectedEwsOrSebcYes}">
                <button  class="btn btn-default sw-btn-next skipDisabling" type="submit" id="saveBtn">
                    <fmt:message key="save" />
                </button>
                </c:if>
                </c:if>
                </c:if>
            </c:if>
            
            <button onclick="javascript:applyObj.gotoTab('2')" class="btn btn-default sw-btn-next skipDisabling" type="button" id="nextBtn">
                <fmt:message key="next" />
            </button>
        </div>
    </nav>

<jsp:include page="popup/maharashtraDomiciledPopup.jsp"/>
<jsp:include page="popup/droughtAffectedPopup.jsp"/>
<jsp:include page="popup/childOfFarmerWhoCommittedSuicidePopup.jsp"/>


</form>

<script>
	$(document).ready(function(){
		
		

		$("form[name='personalInfoForm']").validate({
		    rules: {
			      firstName: { 
			    	  required: true,
			    	  englishlettersonly: true,
			    	  noSpace :true
			      },
			      middleName: { 
			    	  required: true,
			    	  englishlettersonly: true,
			    	  noSpace :true
			      },
			      lastName: { 
			    	  required: true,
			    	  englishlettersonly: true,
			    	  noSpace :true
			      },
			      firstNameMarathi:{
			    	  required: true,
			    	  marathilettersonly: true,
			    	  noSpace :true
				  },
			      middleNameMarathi:{
			    	  required: true,
			    	  marathilettersonly: true,
			    	  noSpace :true
				  },
			      lastNameMarathi:{
			    	  required: true,
			    	  marathilettersonly: true,
			    	  noSpace :true
				  },
			      address:{
			    	 required: true,
			    	 noSpace :true
			      },
			      gender:{
				    	 required: true,
				    	 noSpace :true
				      },
			      pinCode:{
			    	  required: true,
			    	  numbersonly: true,
				      minlength: 6,
				      maxlength: 6,
				      noSpace :true
			      },
			      emailAddress: {
			        required: true,
			        email: true
			      },
			      mobileNumber:{
			    	  required: true,
			    	  numbersonly: true,
				      minlength: 10,
				      maxlength: 10,
				      noSpace :true
				    },
			      subcategory:{
			    	required: true,
			    	noSpace :true
			    	},
		    	  maritalStatus:{
		    		required: true
		    	  },
		    	  maharashtraDomiciled:{
		    		required: true
		    	  },
		    	  readWriteSpeakMarathi:{
		    		required: true
		    	  },
		    	  childOfFarmerWhoCommittedSuicide:{
			    		required: true
			    	  },
		    	  nonCreamyLayer:{
		    		  required: true 
		    	  }/* ,
		    	  certificateValidityEndingDate:{
		    		  required: true
		    	  },
		    	  certificateNumber:{
		    		  required: true
		    	  } */,
		    	  droughtAffected:{
		    		  required: true
		    	  },
		    	  isBelongToEws :{
		    		  required: true
		    	  }
		    },
		    messages:
		    {
		    	pinCode : {minlength : "<fmt:message key="number.six" var="key" /><fmt:message key="validate.minlength"><fmt:param value="${key}" /></fmt:message>"},
		   		mobileNumber : {minlength : "<fmt:message key="number.ten" var="key" /><fmt:message key="validate.minlength"><fmt:param value="${key}" /></fmt:message>"}
		    },
		    errorPlacement: function (error, element) {
		    	if ( element.is(":radio") ) 
	            {
					error.appendTo(element.parent().parent().children('.help-block.with-errors'));
					$(".form-control.error").parent().parent().siblings('label').parent().addClass('has-error');
	            }
		    	else if( element.is("input[type=datetime]"))
	            {
	                       error.insertAfter(element.parent());
	            }
		    	else
		    	{
		    		error.insertAfter( element );
		    		$(".form-control.error").parent().siblings('label').parent().addClass('has-error');
		    	}
		    }
		  });
	});   
	
</script>
<script>
	$(document).ready(function () {

		//openKeyboard("mar");

		/* enableTyping(
				new Array('firstName','middleName','lastName'),
				new Array('firstName_marathi','middleName_marathi','lastName_marathi'),
				'NAME',
				'mr_in'); */
	});

</script>