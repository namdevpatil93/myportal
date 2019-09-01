
<%@ include file="../../common/taglibs.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1" %>

<link rel="stylesheet" href="<c:url value='/static/libs/bootstrap-fileinput/css/fileinput.min.css'/>" >
<script type="text/javascript" src="<c:url value='/static/libs/bootstrap-fileinput/js/fileinput.min.js'/>"></script>

<link rel="stylesheet" href="<c:url value='/static/libs/imageviewer/dist/viewer.min.css'/>" >
<script type="text/javascript" src="<c:url value='/static/libs/imageviewer/dist/viewer.min.js'/>"></script>

<script>

    function selectAdvtNo(advtNo){
        $("#driverCumConductor-form-div").show();
        $("#driverCumConductor-advt-no-selection-div").hide();

        $("#driverCumConductorForm").find("#advtNo").val(advtNo);

        if( advtNo == '2'){
            $("#advtNo2DivisionList").show();
            commonObj.disableFormFields("advtNo1DivisionList",true);
            $("#advtNo1DivisionList").hide();
        } else if( advtNo == '1'){
            $("#advtNo1DivisionList").show();
            commonObj.disableFormFields("advtNo2DivisionList",true);
            $("#advtNo2DivisionList").hide();
        }
    }

    function showOrHideDriverCumConductorForm(){
        var advtNo = $("#driverCumConductorForm").find("#advtNo").val();

        if(advtNo == null || advtNo == '' || advtNo == undefined){
            $("#driverCumConductor-form-div").hide();
            $("#driverCumConductor-advt-no-selection-div").show();
        } else {
            $("#driverCumConductor-form-div").show();
            $("#driverCumConductor-advt-no-selection-div").hide();

            if( advtNo == '2'){
                $("#advtNo2DivisionList").show();
                commonObj.disableFormFields("advtNo1DivisionList",true);
                $("#advtNo1DivisionList").hide();
                $("#advtNo1DivisionList").remove();
            } else if( advtNo == '1'){
                $("#advtNo1DivisionList").show();
                commonObj.disableFormFields("advtNo2DivisionList",true);
                $("#advtNo2DivisionList").hide();
                $("#advtNo2DivisionList").remove();
            }
        }

    }

	$(document).ready(function() {
        showOrHideDriverCumConductorForm();
        var gender='${applicant.gender}';
       if(gender =='0'){
    	  
    	   var heavyVehicle='${applicantPostAssoc.ownHeavyDrivingLicenseNumber}';
    	   var lightWeight='${applicantPostAssoc.lightMotorVechicle}';
    	   if(heavyVehicle=='true'){
    		   $('label[for="experienced"]').show();
    	       	$('label[for="experiencedFemale"]').hide();
    	       	$("input#driverCumConductor-experienced-no").addClass("radiosToCheck");
    	   }else if(lightWeight=='true'){
    		   $('label[for="experienced"]').hide();
   	       	$('label[for="experiencedFemale"]').show();
   	  	$("input#driverCumConductor-experienced-no").removeClass("radiosToCheck");
    	   }else{
    	   $('label[for="experienced"]').hide();
       	$('label[for="experiencedFemale"]').show();
    	}
       }else{
    	   $('label[for="experiencedFemale"]').hide();
           $('label[for="experienced"]').show();
           $("input#driverCumConductor-experienced-no").addClass("radiosToCheck");
       }
		postSelectionObj.disableFormFields ("driverCumConductorForm", '${applicantPostAssoc.status}');
		postSelectionObj.bindPostForm("driverCumConductorForm");
	    
		postSelectionObj.validateDate('driverCumConductorHeavyDrivingLicenseIssueDate','driverCumConductorHeavyDrivingLicenseEndDate');
	    postSelectionObj.validateDate('driverCumConductorBatchNumberIssueDate','driverCumConductorBatchNumberEndDate');
		
	   $('#driverCumConductorHeavyDrivingLicenseIssueDate').datetimepicker({
           format: 'DD/MM/YYYY',
           ignoreReadonly: true,
           showTodayButton: true,
           minDate: postSelectionObj.minDate(),
           maxDate: postSelectionObj.maxDate()
           //date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseIssueDate}" />'
       });
       
       $('#driverCumConductorCalendarIconHeavyDrivingLicenseIssueDate').click(function() {
           $('#driverCumConductorHeavyDrivingLicenseIssueDate').data("DateTimePicker").show();
       });
	    
	   $('#driverCumConductorHeavyDrivingLicenseEndDate').datetimepicker({
           format: 'DD/MM/YYYY',
           ignoreReadonly: true,
           showTodayButton: true,
           minDate: postSelectionObj.minDate(),
           maxDate: postSelectionObj.maxDate()
          // date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseEndDate}" />'
       });
       
       $('#driverCumConductorCalendarIconHeavyDrivingLicenseEndDate').click(function() {
           $('#driverCumConductorHeavyDrivingLicenseEndDate').data("DateTimePicker").show();
       });
      /*  ================================================================================================= */
     $('#driverCumConductor-lightMotorVechicleIssueDate').datetimepicker({
          format: 'DD/MM/YYYY',
          ignoreReadonly: true,
          showTodayButton: true,
          //minDate: postSelectionObj.minDate(),
          maxDate: '${startDateOfExam}'
          //date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseIssueDate}" />'
      });
      $('#driverCumConductor-calendarIcon-lightMotorVechicleIssueDate').click(function() {
	        $('#driverCumConductor-lightMotorVechicleIssueDate').data("DateTimePicker").show();
	    });
      var date = '${applicantPostAssoc.lightMotorVechicleIssueDate}';
		if(date != 'undefined' || date != null || data !='' )
			$('#driverCumConductor-lightMotorVechicleIssueDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicantPostAssoc.lightMotorVechicleIssueDate}" />');
		hideLightMotorVechicleElements();
	   /*  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
	       
		$('#driverCumConductorBatchNumberIssueDate').datetimepicker({
           format: 'DD/MM/YYYY',
           ignoreReadonly: true,
           showTodayButton: true,
           minDate: postSelectionObj.minDate(),
           maxDate: postSelectionObj.maxDate()
           //date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicantPostAssoc.conductorBatchNumberIssueDate}" />'
       });
       $('#driverCumConductorCalendarIconConductorBatchNumberIssueDate').click(function() {
           $('#driverCumConductorBatchNumberIssueDate').data("DateTimePicker").show();
       });
		
	   $('#driverCumConductorBatchNumberEndDate').datetimepicker({
           format: 'DD/MM/YYYY',
           ignoreReadonly: true,
           showTodayButton: true,
           minDate: postSelectionObj.minDate(),
           maxDate: postSelectionObj.maxDate()
           //date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicantPostAssoc.conductorBatchNumberEndDate}" />'
       });
       $('#driverCumConductorCalendarIconConductorBatchNumberEndDate').click(function() {
           $('#driverCumConductorBatchNumberEndDate').data("DateTimePicker").show();
       });

       checkIfShowOrHideElements();

       var licenceIssuedate = '${applicantPostAssoc.heavyDrivingLicenseIssueDate}';
		if(licenceIssuedate != 'undefined' || licenceIssuedate != null || licenceIssuedate !='' )
			$('#driverCumConductorHeavyDrivingLicenseIssueDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseIssueDate}" />');
		
	   var licenceEnddate = '${applicantPostAssoc.heavyDrivingLicenseEndDate}';
		if(licenceEnddate != 'undefined' || licenceEnddate != null || licenceEnddate !='' )
			$('#driverCumConductorHeavyDrivingLicenseEndDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseEndDate}" />');

		var batchNumberIssuedate = '${applicantPostAssoc.conductorBatchNumberIssueDate}';
		if(batchNumberIssuedate != 'undefined' || batchNumberIssuedate != null || batchNumberIssuedate !='')
			$('#driverCumConductorBatchNumberIssueDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicantPostAssoc.conductorBatchNumberIssueDate}" />');
		
		var batchNumberEnddate = '${applicantPostAssoc.conductorBatchNumberEndDate}';
		if(batchNumberEnddate != 'undefined' || batchNumberEnddate != null || batchNumberEnddate !='')
			$('#driverCumConductorBatchNumberEndDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicantPostAssoc.conductorBatchNumberEndDate}" />');
		
		var lastDateOver = commonObj.isValidate(${applicantPostAssoc.disableForm});
	    commonObj.disableFormFields("driverCumConductorForm",lastDateOver);
	});

	
	function hideLightMotorVechicleElements() {
		if(!jQuery('input[id=driverCumConductor-lightMotorVechicle-yes]').is(':checked') ) {
			$("#driverCumConductor-lightMotorVechicle-yes").parent().parent().find('.help-block').empty();
			$( '.driverCumConductorLightMotorVechicleToggle' ).find('input').prop('required', false);
			postSelectionObj.hideElementsByClass('driverCumConductorLightMotorVechicleToggle');
		} 
	} 
	function checkIfShowOrHideElements() {
		/* if ('${applicantPostAssoc.differentlyAbled}'=='' || '${applicantPostAssoc.differentlyAbled}'=='false') {
			postSelectionObj.hideElementsByClass('driverDifferentlyAbledToggle');
			requiredDifferentlyAbledChilds(false);
		} */
		
		if ('${applicantPostAssoc.sscPassed}'=='' || '${applicantPostAssoc.sscPassed}'=='false') {
			postSelectionObj.hideElementsByClass('driverCumConductorRequiredQualificationMarksToggle');
		}
		
		if ('${applicantPostAssoc.ownHeavyDrivingLicenseNumber}'=='' || '${applicantPostAssoc.ownHeavyDrivingLicenseNumber}'=='false') {
			postSelectionObj.hideElementsByClass('driverCumConductorOwnHeavyDrivingLicenseToggle');
		}
		
		if ('${applicantPostAssoc.ownPsvBatchNumber}'=='' || '${applicantPostAssoc.ownPsvBatchNumber}'=='false') {
			postSelectionObj.hideElementsByClass('driverCumConductorOwnPsvBadgeToggle');
		}
		if ( '${applicantPostAssoc.lightMotorVechicle}'=='' || '${applicantPostAssoc.lightMotorVechicle}'=='false') {
// 			requiredConductorBatchChilds(false);
			 $("#driverCumConductor-lightMotorVechicleLicenseNo").parent().parent().find("label.error").empty();
			 $("#driverCumConductor-lightMotorVechicleIssueDate").parent().parent().find("label.error").empty();
			// $("#driverCumConductorBatchNumberEndDate").parent().parent().find("label.error").empty();
			 postSelectionObj.hideElementsByClass('driverCumConductorLightMotorVechicleToggle');
		}
		
		if ( '${applicantPostAssoc.ownConductorBatchNumber}'=='' || '${applicantPostAssoc.ownConductorBatchNumber}'=='false') {
// 			requiredConductorBatchChilds(false);
			 $("#driverCumConductorBatchNumber").parent().parent().find("label.error").empty();
			 $("#driverCumConductorBatchNumberIssueDate").parent().parent().find("label.error").empty();
			 $("#driverCumConductorBatchNumberEndDate").parent().parent().find("label.error").empty();
			 postSelectionObj.hideElementsByClass('driverCumConductorOwnConductorBatchToggle');
		}
	
		if ('${applicantPostAssoc.experienced}'=='' || '${applicantPostAssoc.experienced}'=='false') {
			postSelectionObj.hideElementsByClass('driverCumConductorExperiencedToggle');
		}
		
		if ('${applicantPostAssoc.pastAccidentalOrDeathIncident}'=='' || '${applicantPostAssoc.pastAccidentalOrDeathIncident}'=='false') {
			//postSelectionObj.hideElementsByClass('driverPastAccidentalToggle');
			//$( '.driverPastAccidentalToggle' ).find('input').prop('required', false);
			
		} 
		
		if ('${applicantPostAssoc.guarantorPersonNameAndMobileNo}' == ''||'${applicantPostAssoc.guarantorPersonNameAndMobileNo}' == 'false') {
			postSelectionObj.hideElementsByClass('driverCumConductorguarantorPersonNameAndMobileNoToggle');
		}
	}	
	
	function requiredConductorBatchChilds(flag) {
		//$( '.driverCumConductorOwnConductorBatchToggle' ).find('input').prop('required', flag);
	}
	
	/* function requiredDifferentlyAbledChilds(flag) {
		$( '.driverDifferentlyAbledToggle' ).find('input').prop('required', flag);
	} */
	
	/* $( 'form#driverCumConductorForm' ).find('input[type=radio][name=differentlyAbled]').unbind().change(function() {
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
     
     $( 'form#driverCumConductorForm' ).find('input[type=radio][name=sscPassed]').unbind().change(function() {
         if (this.value == '1') {
        	 postSelectionObj.showElementsByClass('driverCumConductorRequiredQualificationMarksToggle');
         } else {
        	 postSelectionObj.hideElementsByClass('driverCumConductorRequiredQualificationMarksToggle');
        	 postSelectionObj.resetTextFieldById('driverCumConductorRequiredQualificationMarks');
         }
     });
	 
	$( 'form#driverCumConductorForm' ).find('input[type=radio][name=ownHeavyDrivingLicenseNumber]').unbind().change(function() {
         if (this.value == '1') {
        	 jQuery("#driverCumConductorForm").validate().settings.ignore = "";
        	 postSelectionObj.showElementsByClass('driverCumConductorOwnHeavyDrivingLicenseToggle');
        	 $('label[for="experiencedFemale"]').hide();
        	 $('label[for="experienced"]').show();
        	 $("input#driverCumConductor-experienced-no").addClass("radiosToCheck");
         } else {
        	 $('#experiencedError').html("");
        	 	$('#experiencedError').parent().parent().removeClass( 'has-error has-danger' );
        	 	 $("input#driverCumConductor-experienced-no").removeClass("radiosToCheck");
        	 $('label[for="experiencedFemale"]').show();
        	 $('label[for="experienced"]').hide();
        	 jQuery("#driverCumConductorForm").validate().settings.ignore = "#driverCumConductorHeavyDrivingLicenseNumber, #driverCumConductorHeavyDrivingLicenseIssueDate";
        	 postSelectionObj.hideElementsByClass('driverCumConductorOwnHeavyDrivingLicenseToggle');
        	 postSelectionObj.resetTextFieldById('driverCumConductorHeavyDrivingLicenseNumber');
        	 postSelectionObj.resetTextFieldById('driverCumConductorHeavyDrivingLicenseIssueDate');
        	 postSelectionObj.resetTextFieldById('driverCumConductorHeavyDrivingLicenseEndDate');
         }
     });
	 
	$( 'form#driverCumConductorForm' ).find('input[type=radio][name=ownPsvBatchNumber]').unbind().change(function() {
         if (this.value == '1') {
        	 postSelectionObj.showElementsByClass('driverCumConductorOwnPsvBadgeToggle');
         } else {
        	 postSelectionObj.hideElementsByClass('driverCumConductorOwnPsvBadgeToggle');
        	 postSelectionObj.resetTextFieldById('driverCumConductorPsvBatchNumber');
         }
     });
	/* ====================================================================================== */
	 $( 'form#driverCumConductorForm' ).find('input[type=radio][name=lightMotorVechicle]').unbind().change(function() {
	    if (this.value == '1') {
	    	 $('#experiencedError').html("");
     	 	$('#experiencedError').parent().parent().removeClass( 'has-error has-danger' );
	    	$('label[for="experiencedFemale"]').show();
	    	$('label[for="experienced"]').hide();
	    	$('.driverCumConductorLightMotorVechicleToggle').attr("required", true);
	   	 	postSelectionObj.showElementsByClass('driverCumConductorLightMotorVechicleToggle');
	   	 $("input#driverCumConductor-experienced-no").removeClass("radiosToCheck");
	   	 	//$( 'form#assistantJuniorForm' ).find('input[type=radio][name=learningLicense]').attr("required", false).attr('checked', false);
	   	 	//postSelectionObj.hideElementsByClass('assistantJuniorLearningLicenseRadioToggle');
	   	 	//assistantJuniorEffectLearningLicenseChild();
	    } else {
	    	$('label[for="experiencedFemale"]').hide();
	    	$('label[for="experienced"]').show();
	    	$('.driverCumConductorLightMotorVechicleToggle').attr("required", false);
	    	 $("input#driverCumConductor-experienced-no").addClass("radiosToCheck");
	   	 	postSelectionObj.hideElementsByClass('driverCumConductorLightMotorVechicleToggle');
	   	 	postSelectionObj.resetTextFieldById('driverCumConductor-lightMotorVechicleLicenseNo');
	   	 	postSelectionObj.resetTextFieldById('driverCumConductor-lightMotorVechicleIssueDate');
	   	 $("#driverCumConductor-lightMotorVechicleLicenseNo").parent().parent().find("label.error").empty();
		 $("#driverCumConductor-lightMotorVechicleIssueDate").parent().parent().find("label.error").empty();
//	   	 	commonObj.showAlert("<fmt:message key='assistantJunior.light.motor.vehicle.no.msg' />");
			//New changes
	   		//commonObj.showAgreeDisAgreePopup("<fmt:message key='assistantJunior.light.motor.vehicle.no.msg' />", assistantJuniorLightMotoVechiclePopup, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
		    //$( 'form#assistantJuniorForm' ).find('input[type=radio][name=learningLicense]').attr("required", true);
		    //postSelectionObj.showElementsByClass('assistantJuniorLearningLicenseRadioToggle');
	    }
	}); 
	/* ============================================================================================== */
	 
	$( 'form#driverCumConductorForm' ).find('input[type=radio][name=ownConductorBatchNumber]').unbind().change(function() {
         if (this.value == '1') {
        	 postSelectionObj.showElementsByClass('driverCumConductorOwnConductorBatchToggle');
//         	 requiredConductorBatchChilds(true);
         } else {
        	 //$('driverCumConductorOwnConductorBatchToggle').find('input').prop('required', false);
        	 postSelectionObj.resetTextFieldById('driverCumConductorBatchNumber');
        	 postSelectionObj.resetTextFieldById('driverCumConductorBatchNumberIssueDate');
        	 postSelectionObj.resetTextFieldById('driverCumConductorBatchNumberEndDate');
			 $("#driverCumConductorBatchNumber").parent().parent().find("label.error").empty();
			 $("#driverCumConductorBatchNumberIssueDate").parent().parent().find("label.error").empty();
			 $("#driverCumConductorBatchNumberEndDate").parent().parent().find("label.error").empty();
			 postSelectionObj.hideElementsByClass('driverCumConductorOwnConductorBatchToggle');
// 			 commonObj.showAlert("<fmt:message key='conductorbatch.onNoSelect.alert' />");
//              $(this).parent().parent().parent().removeClass( 'has-error has-danger' );
			 commonObj.showAgreeDisAgreePopup("<fmt:message key='conductorbatch.onNoSelect.alert' />", driverCumConductorJuniorAgreeDisAgreePopup, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
         }
     });

	function driverCumConductorJuniorAgreeDisAgreePopup(flag)
	{
		
	   	if(!flag)
	   	{
		   	$('#driverCumConductor-ownConductorBatchNumber-yes').prop('checked', true);
	   		$('driverCumConductorOwnConductorBatchToggle').find('input').prop('required', true);
	   		postSelectionObj.showElementsByClass('driverCumConductorOwnConductorBatchToggle');
     	 	postSelectionObj.resetTextFieldById('driverCumConductorBatchNumber');
	       	postSelectionObj.resetTextFieldById('driverCumConductorBatchNumberIssueDate');
	        postSelectionObj.resetTextFieldById('driverCumConductorBatchNumberEndDate');
	   	}else
		{
	   		$('driverCumConductorOwnConductorBatchToggle').find('input').prop('required', false);
	   		/* $('#driverCumConductorBatchNumber').prop('required', false);
	   		$('#driverCumConductorBatchNumberIssueDate').prop('required', false);
	   		$('#driverCumConductorBatchNumberEndDate').prop('required', false); */
		}
	}	
	 
	$( 'form#driverCumConductorForm' ).find('input[type=radio][name=experienced]').unbind().change(function() {
         if (this.value == '1') {
        	 postSelectionObj.showElementsByClass('driverCumConductorExperiencedToggle');
         } else {
        	 postSelectionObj.hideElementsByClass('driverCumConductorExperiencedToggle');
        	 postSelectionObj.resetTextFieldById('driverCumConductorCompanyName');
        	 postSelectionObj.resetTextFieldById('driverCumConductorTotalExperienceInYears');
        	 postSelectionObj.resetTextFieldById('driverCumConductorTotalExperienceInMonths');
         }
     });
	 
	$( 'form#driverCumConductorForm' ).find('input[type=radio][name=pastAccidentalOrDeathIncident]').unbind().change(function() {
         if (this.value == '1') {
        	 //postSelectionObj.showElementsByClass('driverPastAccidentalToggle');
        	 //$( '.driverPastAccidentalToggle' ).find('input').prop('required', true);
         } else {
        	 //postSelectionObj.hideElementsByClass('driverPastAccidentalToggle');
        	 postSelectionObj.resetTextFieldById('driverCumConductorPastAccidentalOrDeathIncidentReason');
        	// $( '.driverPastAccidentalToggle' ).find('input').prop('required', false);
         }
     });
	
	$( 'form#driverCumConductorForm' ).find('input[type=radio][name=guarantorPersonNameAndMobileNo]').unbind().change(function() {
	    if (this.value == '1') 
	    {
	    	$('#driverCumConductor-guarantorPersonNameAndMobileNo-guarantorPersonName').attr("required", true);
	    	$('#driverCumConductor-guarantorPersonNameAndMobileNo-guarantorPersonMobileNumber').attr("required", true);
	   		 postSelectionObj.showElementsByClass('driverCumConductorguarantorPersonNameAndMobileNoToggle');
	    } 
	    else 
	    {
	    	$('#driverCumConductor-guarantorPersonNameAndMobileNo-guarantorPersonName').attr("required", false);
	    	$('#driverCumConductor-guarantorPersonNameAndMobileNo-guarantorPersonMobileNumber').attr("required", false);
	    	postSelectionObj.hideElementsByClass('driverCumConductorguarantorPersonNameAndMobileNoToggle');
	    	postSelectionObj.resetTextFieldById('driverCumConductor-guarantorPersonNameAndMobileNo-guarantorPersonName');
	    	postSelectionObj.resetTextFieldById('driverCumConductor-guarantorPersonNameAndMobileNo-guarantorPersonMobileNumber');
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

<style>
    .cat-selection {
        font-size: 14px;
        font-weight: bolder;
    }
</style>

<div id="driverCumConductor-advt-no-selection-div" style="display: none;">
    <div style="text-align: center; vertical-align: middle;margin-top: 20px;">
        <a class="cat-selection" href="javascript:void(0);" onclick="javascript:selectAdvtNo(1);"> <fmt:message key="driverCumConductor.advtNo1"/> </a><br><br> <fmt:message key="or.message"/><br><br> 
         <a class="cat-selection" href="javascript:void(0);" onclick="javascript:selectAdvtNo(2);"> <fmt:message key="driverCumConductor.advtNo2"/> </a>
    </div>
</div>

<div id="driverCumConductor-form-div" style="display: none">
 <div id="downloadEligibilityCriteria" class="form-group" align="right">
        <div class="col-sm-12" align="pull-right">
            <a href="javascript:void(0);" onclick="javascript:showEligibilityCriteriaPDF(${post.postId})"><b><fmt:message key="postEligibilityCriteriaLink"/></b></a>
        </div>
    </div>
<form class="form-horizontal" name="driverCumConductorForm" id="driverCumConductorForm" action="<c:url value='/applicant?operation=saveApplicantPostDetails'/>" method="POST">

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${applicantPostAssoc.id}"/>
    <input type="hidden" name="advtNo" id="advtNo" value="${applicantPostAssoc.advtNo}"/>
    <input type="hidden" name="postId" value="${post.postId}"/>
    <input type="hidden" name="status" id="status"  value="${ applicantPostAssoc.status }"/>
	<input type="hidden" id="applicantGender" value="${applicant.gender }"/>

    <div class="form-group">
        <label class="control-label col-sm-5" for="sscPassed"><fmt:message key="driver.educationSSCpass"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="sscPassed" id="driverCumConductor-sscPassed-yes" value="1" type="radio" ${applicantPostAssoc.sscPassed ? 'checked' : ''} />
                <label for="driverCumConductor-sscPassed-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="sscPassed" id="driverCumConductor-sscPassed-no" value="0" type="radio" ${applicantPostAssoc.sscPassed == false ? 'checked' : ''} />
                <label for="driverCumConductor-sscPassed-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group driverCumConductorRequiredQualificationMarksToggle">
        <label class="control-label col-sm-5" for="driverCumConductorRequiredQualificationMarks"><fmt:message key="driverCumConductor.required.qualification.marks.obtained"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.requiredQualificationMarks}" type="number" class="form-control" id="driverCumConductorRequiredQualificationMarks" placeholder="<fmt:message key="driverCumConductor.required.qualification.marks.obtained"/>" name="requiredQualificationMarks" maxlength="5" min="1" max="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <%-- <div class="form-group">
        <label class="control-label col-sm-5" for="otherQualificationDetails"><fmt:message key="driver.otherQualification"/>: </label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.otherQualificationDetails}" type="text" class="form-control" id="driverCumConductorOtherQualificationDetails" placeholder="<fmt:message key="driver.otherQualification"/>" name="otherQualificationDetails" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div> --%>
    
<%-- <div class="form-group">
        <label class="control-label col-sm-5" for="otherQualification"><fmt:message key="driver.otherQualification"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <select id="driverCumConductorOtherQualificationDetails" name="otherQualification" class="form-control" required oninvalid="this.setCustomValidity('<fmt:message key="validation.requiredfield"/>')">
            	<option value="">-- <fmt:message key="otherqualification.select"/> --</option>
            	<c:forEach items="${otherQualificationList}" var="postotherqualification">
					<option value="${postotherqualification.id}" ${ postotherqualification.id eq applicantPostAssoc.otherQualification? 'selected':'' }>
						<c:choose>
							<c:when test="${locale eq 'en' }">
								${postotherqualification.title}
							</c:when>
							<c:otherwise>
								${postotherqualification.titleInMarathi}
							</c:otherwise>					
						</c:choose> 
					</option>
				</c:forEach>
            </select>
            <div class="help-block with-errors"></div>
        </div>
    </div> --%>

<div class="form-group">
        <label for="division" class="col-sm-5 control-label"><fmt:message key="driver.division" />:<span class="red">*</span></label>
        
    <div class="col-sm-4" id="advtNo2DivisionList" style="display: none;">
            <select id="driverCumConductorDivision" name="divisionId" class="form-control" data-size="5" required oninvalid="this.setCustomValidity('<fmt:message key="validation.requiredfield"/>')">
                <option value="">-- <fmt:message key="division.select"/> --</option>
                <c:forEach items="${advtNo2DivisionList}" var="division">
                    <option value="${division.divisionId}" ${ division.divisionId eq applicantPostAssoc.divisionId? 'selected':'' }><fmt:message key="${ division.messageKey }" /></option>
                </c:forEach>
            </select>
            
            <div class="help-block with-errors"></div>
        </div>

    <div class="col-sm-4" id="advtNo1DivisionList" style="display: none;">
        <%-- <c:choose>
            <c:when test="${applicant.droughtAffected}"> --%>
                <select id="driverCumConductorDivision" name="divisionId" class="form-control" data-size="5" required oninvalid="this.setCustomValidity('<fmt:message key="validation.requiredfield"/>')">
                    <option value="">-- <fmt:message key="division.select"/> --</option>
                    <c:forEach items="${divisionListDraughtAffected}" var="divisionListDraughtAffected">
                        <option value="${divisionListDraughtAffected.divisionId}" ${divisionListDraughtAffected.divisionId eq applicantPostAssoc.divisionId? 'selected':'' } ><fmt:message key="${ divisionListDraughtAffected.messageKey }" /></option>
                    </c:forEach>
                </select>

           <%-- </c:when>
             <c:otherwise>
                <select id="driverCumConductorDivision" name="divisionId" class="form-control" data-size="5" required oninvalid="this.setCustomValidity('<fmt:message key="validation.requiredfield"/>')">
                    <option value="">-- <fmt:message key="division.select"/> --</option>
                    <c:forEach items="${driverCumConductorJrDivisionList}" var="postdivision">
                        <option value="${postdivision.division.divisionId}" ${ postdivision.division.divisionId eq applicantPostAssoc.divisionId? 'selected':'' }><fmt:message key="${ postdivision.division.messageKey }" /></option>
                    </c:forEach>
                </select>

            </c:otherwise> 
        </c:choose>--%>

        <div class="help-block with-errors"></div>
    </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-5" for="nightBlindness"><fmt:message key="driver.nightBlindness"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="nightBlindness" id="driverCumConductor-nightBlindness-yes" value="1" type="radio" ${applicantPostAssoc.nightBlindness ? 'checked' : ''} />
                <label for="driverCumConductor-nightBlindness-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input name="nightBlindness"  id="driverCumConductor-nightBlindness-no" value="0" type="radio" ${applicantPostAssoc.nightBlindness == false  ? 'checked' : ''} />
                <label for="driverCumConductor-nightBlindness-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-5" for="colorBlindness"><fmt:message key="driver.colorBlindness"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="colorBlindness" id="driverCumConductor-colorBlindness-yes" value="1" ${applicantPostAssoc.colorBlindness ? 'checked' : ''} type="radio" />
                <label for="driverCumConductor-colorBlindness-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input name="colorBlindness" id="driverCumConductor-colorBlindness-no" value="0" type="radio" ${applicantPostAssoc.colorBlindness == false  ? 'checked' : ''} />
                <label for="driverCumConductor-colorBlindness-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group">
        <label class="control-label col-sm-5" for="visionAcuity"><fmt:message key="driver.visionAcuity"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="visionAcuity" id="driverCumConductor-visionAcuity-yes" value="1" type="radio" ${applicantPostAssoc.visionAcuity ? 'checked' : ''} />
                <label for="driverCumConductor-visionAcuity-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="visionAcuity" id="driverCumConductor-visionAcuity-no" value="0" type="radio" ${applicantPostAssoc.visionAcuity == false  ? 'checked' : ''} />
                <label for="driverCumConductor-visionAcuity-no"> <fmt:message key="no"/> </label>
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
                <input name="ownHeavyDrivingLicenseNumber" id="driverCumConductor-ownHeavyDrivingLicenseNumber-yes" value="1" type="radio" ${applicantPostAssoc.ownHeavyDrivingLicenseNumber ? 'checked' : ''} />
                <label for="driverCumConductor-ownHeavyDrivingLicenseNumber-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="${ applicant.gender eq 1 ? 'radiosToCheck':''}" name="ownHeavyDrivingLicenseNumber" id="driverCumConductor-ownHeavyDrivingLicenseNumber-no" value="0" type="radio" ${applicantPostAssoc.ownHeavyDrivingLicenseNumber == false  ? 'checked' : ''} />
                <label for="driverCumConductor-ownHeavyDrivingLicenseNumber-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group driverCumConductorOwnHeavyDrivingLicenseToggle">
        <label class="control-label col-sm-5" for="driverCumConductorHeavyDrivingLicenseNumber"><fmt:message key="driver.ownHeavyDrivingLicenseNo.number"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.heavyDrivingLicenseNumber}" type="text" class="form-control" id="driverCumConductorHeavyDrivingLicenseNumber" placeholder="<fmt:message key="driver.ownHeavyDrivingLicenseNo.number"/>" name="heavyDrivingLicenseNumber" maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
    </div>
   
    <div class="form-group driverCumConductorOwnHeavyDrivingLicenseToggle">
        <label class="control-label col-sm-5" for="driverCumConductorHeavyDrivingLicenseIssueDate"><fmt:message key="driver.ownHeavyDrivingLicenseNo.issueDate"/>: <span class="red">*</span></label>
        <div class="col-sm-3">
        	<div class="input-group date">
	            <input type="datetime" class="form-control" id="driverCumConductorHeavyDrivingLicenseIssueDate" placeholder="<fmt:message key="driver.ownHeavyDrivingLicenseNo.issueDate"/>" name="heavyDrivingLicenseIssueDate" readonly>
	            <div class="input-group-addon" id="driverCumConductorCalendarIconHeavyDrivingLicenseIssueDate">
					<i class="fa fa-calendar"></i>
				</div>
	            <div class="help-block with-errors"></div>
            </div>
        </div>
   </div>
   
    <div class="form-group driverCumConductorOwnHeavyDrivingLicenseToggle">
        <label class="control-label col-sm-5" for="driverCumConductorHeavyDrivingLicenseEndDate"><fmt:message key="driver.ownHeavyDrivingLicenseNo.endDate"/>: <span class="red">*</span></label>
        <div class="col-sm-3">
        	<div class="input-group date">
	            <input type="datetime" class="form-control" id="driverCumConductorHeavyDrivingLicenseEndDate" placeholder="<fmt:message key="driver.ownHeavyDrivingLicenseNo.endDate"/>" name="heavyDrivingLicenseEndDate" readonly >
	            <div class="input-group-addon" id="driverCumConductorCalendarIconHeavyDrivingLicenseEndDate">
					<i class="fa fa-calendar"></i>
				</div>
	            <div class="help-block with-errors"></div>
            </div>
        </div>
    </div>
    <c:if test="${applicant.gender eq 0}">
    <div align="center"><strong ><fmt:message key="draftsman.diploma.certification.in.autocad"/></strong></div>
    <br>
    <div class="form-group">
        <label class="control-label col-sm-5" for="driverCumConductorLightMotorVechicle"><fmt:message key="assistantJunior.light.motor.vehicle"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="lightMotorVechicle" id="driverCumConductor-lightMotorVechicle-yes" value="1" type="radio" ${applicantPostAssoc.lightMotorVechicle ? 'checked' : ''} />
                <label for="driverCumConductor-lightMotorVechicle-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input name="lightMotorVechicle" id="driverCumConductor-lightMotorVechicle-no" value="0" type="radio" ${applicantPostAssoc.lightMotorVechicle == false ? 'checked' : ''} />
                <label for="driverCumConductor-lightMotorVechicle-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group driverCumConductorLightMotorVechicleToggle">
        <label class="control-label col-sm-5" for="lightMotorVechicleLicenseNo"><fmt:message key="assistantJunior.light.motor.vehicle.license.no"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.lightMotorVechicleLicenseNo}" type="text"  name="lightMotorVechicleLicenseNo" maxlength="30" class="form-control" id="driverCumConductor-lightMotorVechicleLicenseNo" placeholder="<fmt:message key="assistantJunior.light.motor.vehicle.license.no"/>" >
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group driverCumConductorLightMotorVechicleToggle">
        <label class="control-label col-sm-5" for="lightMotorVechicleIssueDate"><fmt:message key="assistantJunior.light.motor.vehicle.license.issue.date"/>: <span class="red">*</span></label>
        <div class="col-sm-3">
        	<div class="input-group date">
	            <input type="datetime" class="form-control" id="driverCumConductor-lightMotorVechicleIssueDate" placeholder="<fmt:message key="assistantJunior.light.motor.vehicle.license.issue.date"/>" name="lightMotorVechicleIssueDate" readonly >
	            <div class="input-group-addon" id="driverCumConductor-calendarIcon-lightMotorVechicleIssueDate">
					<i class="fa fa-calendar"></i>
				</div>
	            <div class="help-block with-errors"></div>
            </div>
        </div>
    </div>
    </c:if>
    <div class="form-group">
        <label class="control-label col-sm-5" for="ownPsvBadgeNo"><fmt:message key="driver.ownPsvBadgeNo"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="ownPsvBatchNumber" id="driverCumConductor-ownPsvBadgeNo-yes" value="1" type="radio" ${applicantPostAssoc.ownPsvBatchNumber ? 'checked' : ''} />
                <label for="driverCumConductor-ownPsvBadgeNo-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input  class="${ applicant.gender eq 1 ? 'radiosToCheck':''}" name="ownPsvBatchNumber" id="driverCumConductor-ownPsvBadgeNo-no" value="0" type="radio" ${applicantPostAssoc.ownPsvBatchNumber == false ? 'checked' : ''} />
                <label for="driverCumConductor-ownPsvBadgeNo-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
   
    <div class="form-group driverCumConductorOwnPsvBadgeToggle">
        <label class="control-label col-sm-5" for="psvBatchNumber"><fmt:message key="driver.psvBadgeNo"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.psvBatchNumber}" type="text" class="form-control" id="driverCumConductorPsvBatchNumber" placeholder="<fmt:message key="driver.psvBadgeNo"/>" name="psvBatchNumber"  maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-5" for="conductorbatchNo"><fmt:message key="driver.ownConductorbatchNo"/>:</label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="ownConductorBatchNumber" id="driverCumConductor-ownConductorBatchNumber-yes" value="1" type="radio" ${applicantPostAssoc.ownConductorBatchNumber ? 'checked' : ''}/>
                <label for="driverCumConductor-ownConductorBatchNumber-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input name="ownConductorBatchNumber" id="driverCumConductor-ownConductorBatchNumber-no" value="0" type="radio" ${applicantPostAssoc.ownConductorBatchNumber == false ? 'checked' : ''}/>
                <label for="driverCumConductor-ownConductorBatchNumber-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group driverCumConductorOwnConductorBatchToggle">
        <label class="control-label col-sm-5" for="conductorBatchNumber"><fmt:message key="driver.ownConductorbatchNo.number"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.conductorBatchNumber}" type="text" class="form-control" id="driverCumConductorBatchNumber" placeholder="<fmt:message key="driver.ownConductorbatchNo.number"/>" name="conductorBatchNumber"  maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group driverCumConductorOwnConductorBatchToggle">
        <label class="control-label col-sm-5" for="driverCumConductorBatchNumberIssueDate"><fmt:message key="driver.ownConductorbatchNo.issueDate"/>: <span class="red">*</span></label>
        <div class="col-sm-3">
        	<div class="input-group date">
	            <input type="datetime" class="form-control" id="driverCumConductorBatchNumberIssueDate" placeholder="<fmt:message key="driver.ownConductorbatchNo.issueDate"/>" name="conductorBatchNumberIssueDate" readonly>
	            <div class="input-group-addon" id="driverCumConductorCalendarIconConductorBatchNumberIssueDate">
					<i class="fa fa-calendar"></i>
				</div>
	            <div class="help-block with-errors"></div>
            </div>
        </div>
    </div>
    <div class="form-group driverCumConductorOwnConductorBatchToggle">
        <label class="control-label col-sm-5" for="driverCumConductorBatchNumberEndDate"><fmt:message key="driver.ownConductorbatchNo.endDate"/>: <span class="red">*</span></label>
        <div class="col-sm-3">
        	<div class="input-group date">
        		<input type="datetime" class="form-control" id="driverCumConductorBatchNumberEndDate" placeholder="<fmt:message key="driver.ownConductorbatchNo.endDate"/>" name="conductorBatchNumberEndDate" readonly>
	            <div class="input-group-addon" id="driverCumConductorCalendarIconConductorBatchNumberEndDate">
					<i class="fa fa-calendar"></i>
				</div>
	            <div class="help-block with-errors"></div>
        	</div>
        </div>
    </div>

    <div class="form-group">
    <label id="driverExperienced" class="control-label col-sm-5" for=experienced><fmt:message key="driver.experienced"/>: <span class="red">*</span></label>
    <label id="driverExperiencedFemale" class="control-label col-sm-5" for=experiencedFemale><fmt:message key="driver.experienced.female"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="experienced" id="driverCumConductor-experienced-yes" value="1" type="radio" ${applicantPostAssoc.experienced ? 'checked' : ''}/>
                <label for="driverCumConductor-experienced-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="" name="experienced" id="driverCumConductor-experienced-no" value="0" type="radio" ${applicantPostAssoc.experienced == false ? 'checked' : ''}/>
                <label for="driverCumConductor-experienced-no"> <fmt:message key="no"/> </label>
            </div>
            <div  id="experiencedError" class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group driverCumConductorExperiencedToggle">
        <label class="control-label col-sm-5" for="companyName"><fmt:message key="driver.experienced.companyName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.companyName}" type="text" class="form-control" id="driverCumConductorCompanyName" placeholder="<fmt:message key="driver.experienced.companyName"/>" name="companyName" maxlength="150">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group driverCumConductorExperiencedToggle">
        <label class="control-label col-sm-5" for="totalExperienceInYears"><fmt:message key="driver.experienced.totalExperience"/>: <span class="red">*</span></label>
        <div class="col-sm-2">
            <input value="${applicantPostAssoc.totalExperienceInYears}" type="tel" class="form-control" id="driverCumConductorTotalExperienceInYears" placeholder="<fmt:message key="driver.experienced.inYears"/>" name="totalExperienceInYears" maxlength="2">
            <div class="help-block with-errors"></div>
        </div>
        <div class="col-sm-2">
            <input value="${applicantPostAssoc.totalExperienceInMonths}" type="tel" class="form-control" id="driverCumConductorTotalExperienceInMonths" placeholder="<fmt:message key="driver.experienced.inMonths"/>" name="totalExperienceInMonths"  min="0" maxlength="2">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div id="experienceLetterScanCopyDiv" class="form-group driverCumConductorExperiencedToggle">
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
        <label class="control-label col-sm-5" for="guarantorPersonNameAndMobileNo"><fmt:message key="conductor.guarantorPersonNameAndMobileNo"/>:<span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="guarantorPersonNameAndMobileNo" id="driverCumConductor-guarantorPersonNameAndMobileNo-yes" value="1" type="radio" ${applicantPostAssoc.guarantorPersonNameAndMobileNo ? 'checked' : ''} />
                <label for="driverCumConductor-guarantorPersonNameAndMobileNo-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="guarantorPersonNameAndMobileNo" id="driverCumConductor-guarantorPersonNameAndMobileNo-no" value="0" type="radio" ${applicantPostAssoc.guarantorPersonNameAndMobileNo == false ? 'checked' : ''} />
                <label for="driverCumConductor-guarantorPersonNameAndMobileNo-no"> <fmt:message key="no"/> </label>
            </div>
            <div  class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group driverCumConductorguarantorPersonNameAndMobileNoToggle">
        <label class="control-label col-sm-5" for="guarantorPersonName"><fmt:message key="guarantorPersonNameAndMobileNo.guarantorPersonName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.guarantorPersonName}" type="text" class="form-control" id="driverCumConductor-guarantorPersonNameAndMobileNo-guarantorPersonName" placeholder="<fmt:message key="guarantorPersonNameAndMobileNo.guarantorPersonName"/>" name="guarantorPersonName" maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
    </div>
     <div class="form-group driverCumConductorguarantorPersonNameAndMobileNoToggle">
        <label class="control-label col-sm-5" for="guarantorPersonMobileNumber"><fmt:message key="guarantorPersonNameAndMobileNo.guarantorPersonMobileNumber"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.guarantorPersonMobileNumber}" type="tel" maxlength="10" class="form-control" id="driverCumConductor-guarantorPersonNameAndMobileNo-guarantorPersonMobileNumber" placeholder="<fmt:message key="guarantorPersonNameAndMobileNo.guarantorPersonMobileNumber"/>" name="guarantorPersonMobileNumber" maxlength="10">
            <div class="help-block with-errors"></div>
        </div>
    </div>
   <div>
   <c:choose>
   <c:when test="${applicant.gender eq 1}">
    <div class="form-group">
        <label class="control-label col-sm-5" for="height"><fmt:message key="driver.height"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="heightWithinRange" id="driverCumConductor-height-yes" value="1" type="radio" ${applicantPostAssoc.heightWithinRange ? 'checked' : ''} />
                <label for="driverCumConductor-height-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="heightWithinRange" id="driverCumConductor-height-no" value="0" type="radio" ${applicantPostAssoc.heightWithinRange == false ? 'checked' : ''} />
                <label for="driverCumConductor-height-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
        </div>
        </c:when>
        <c:otherwise>
        	<div class="form-group">
        <label class="control-label col-sm-5" for="height"><fmt:message key="driver.height.female"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="heightWithinRange" id="driverCumConductor-height-yes" value="1" type="radio" ${applicantPostAssoc.heightWithinRange ? 'checked' : ''} />
                <label for="driverCumConductor-height-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="heightWithinRange" id="driverCumConductor-height-no" value="0" type="radio" ${applicantPostAssoc.heightWithinRange == false ? 'checked' : ''} />
                <label for="driverCumConductor-height-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
        </div>
        </c:otherwise>
     </c:choose> 
    </div>
	<div class="form-group">
        <label class="control-label col-sm-5" for="driverCumConductorPastAccidentalDeathIncident"><fmt:message key="driver.pastAccidentalDeathIncident"/>: </label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="pastAccidentalOrDeathIncident" id="driverCumConductor-pastAccidentalDeathIncident-yes" value="1" type="radio" ${applicantPostAssoc.pastAccidentalOrDeathIncident ? 'checked' : ''} />
                <label for="driverCumConductor-pastAccidentalDeathIncident-yes"> <fmt:message key="yes"/> </label>
            </div>
			<div class="radio radio-inline">
                <input name="pastAccidentalOrDeathIncident" id="driverCumConductor-pastAccidentalDeathIncident-no" value="0" type="radio" ${applicantPostAssoc.pastAccidentalOrDeathIncident == false ? 'checked' : ''} />
                <label for="driverCumConductor-pastAccidentalDeathIncident-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
   <div class="form-group"><label class="control-label col-sm-15" > <Strong style="color: red"><fmt:message key="divisionController.note"/> : </Strong><fmt:message key="driverCumConductor.Special.Note"/> </label></div>
    
    <%-- <div class="form-group driverPastAccidentalToggle">
        <label class="control-label col-sm-5" for="companyName"><fmt:message key="driver.pastAccidentalDeathIncident.reason"/>: </label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.pastAccidentalOrDeathIncidentReason}" type="text" class="form-control" id="driverPastAccidentalOrDeathIncidentReason" placeholder="<fmt:message key="driver.pastAccidentalDeathIncident.reason"/>" name="pastAccidentalOrDeathIncidentReason" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div> --%>
    
    <jsp:include page="postFooter.jsp">
    	<jsp:param name="isPostSubmitted" value="${ applicantPostAssoc.status eq 2 || applicantPostAssoc.status eq 3 }"/>
        <jsp:param name="formId" value="driverCumConductorForm"/>
        <jsp:param name="postId" value="${post.postId}"/>
        <jsp:param name="disableFormAfterLastDateOver" value="${disableFormAfterLastDateOver}"/>
    </jsp:include>

</form>

</div>
<script>
 $(document).ready(function(){
 $("form[name='driverCumConductorForm']").validate({
 	rules:{
 		sscPassed : "required",
 		requiredQualificationMarks : {required: true, min: 35},
 		experienced : "required",
 		nightBlindness : "required",
 		colorBlindness : "required",
 		ownPsvBatchNumber : "required",
 		psvBatchNumber: {required: true},
 		//ownConductorBatchNumber : "required",
   		conductorBatchNumber: {required: true},
 		ownHeavyDrivingLicenseNumber : "required",
 		heavyDrivingLicenseNumber: {required: true},
 		// lightMotorVechicle: "required",
 		companyName: {required: true},
 		totalExperienceInYears :{required: true, numbersonly:true, min: 1, max:100},
 		totalExperienceInMonths :{required: true, numbersonly:true, max: 11},
 		visionAcuity : "required",
//  		experienceLetterScanCopy : "required",
 		heightWithinRange : "required",
//  		pastAccidentalOrDeathIncident : "required",
//  		pastAccidentalOrDeathIncidentReason: {required: true, lettersandspaceonly:true},
 		heavyDrivingLicenseEndDate : {	required: true },
 		heavyDrivingLicenseIssueDate : {required: true },
 		lightMotorVechicleLicenseNo :{required: true },
 		lightMotorVechicleIssueDate : {required: true },
 		guarantorPersonNameAndMobileNo : "required",
 		guarantorPersonName: {required: true, lettersandspaceonly:true},
 		guarantorPersonMobileNumber:{required: true, numbersonly:true, minlength: 10, maxlength: 10},
 		conductorBatchNumberIssueDate : { required: true},
 		conductorBatchNumberEndDate : { required: true}
 		  },
 		  messages:{
 			 /*totalExperienceInYears : {min : "<fmt:message key="validation.minlengthfield"/>"},*/
 			 totalExperienceInMonths : {max : "<fmt:message key="number.eleven" var="key" /><fmt:message key="validate.maxMonths"><fmt:param value="${key}" /></fmt:message>"},
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