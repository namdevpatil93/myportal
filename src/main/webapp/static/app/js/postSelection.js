
function PostSelection(){

    var postSelectionObj = this;

    this.appBasePath = appBasePath;

    this.goToNextPost = function(){
        var nextPostIndex = 0;
        var nextPostIndexFound = false;

        $('.postSelectionUL li').each(function(i, elem){
            if(i != 0) {
                if(nextPostIndexFound){
                    $(elem).find('a').trigger('click');
                    return false;
                } else {
                    if ($(elem).hasClass('active')) {
                        nextPostIndex = i + 1;
                        nextPostIndexFound = true;
                    }
                }
            }
        });       
    };

    this.showPostSelection = function(){
        /*var url = applyObj.appBasePath +  'applicant?operation=showSelectedPosts';
        jQuery("#applySteps").load(url, function(){
            applyObj.markTabAsActive("postSelectionTab");
        });*/

        $('.postSelectionUL li').each(function(i, elem){
            if(i == 0) {
                $(elem).find('a').trigger('click');
            }
        });
    };

    this.deletePost = function(postId){
        commonObj.showConfirmation("Are you sure you want to delete this Post?", function(result){
            if(result){
                var url = applyObj.appBasePath + 'applicant?operation=deleteApplicantPost';
                $.post(url, { postId:postId }, function(result){
                    var success = result.success;
                    if(success){
                        var noOfPosts = $('.postLi').length;
                        if(noOfPosts != null && noOfPosts !=  'undefined' && noOfPosts > 1 ){
                            applyObj.showSelectedPosts();
                        } else {
                            applyObj.showPostSelection();
                        }
                    } else {
                        commonObj.showAlert("There was some error while trying to delete the Applicant's Post.");
                    }
                });
            }
        });
    };

    this.showElementsByClass = function(className) {
        $('.'+className).show();
    };

    this.hideElementsByClass = function(className) {
        $('.'+className).hide();
    };

    this.resetTextFieldById = function(elementId) {
        $('#'+elementId).val('');
    };

    this.resetRadioButtonByName = function(elementName) {
        $('input[type=radio][name=' + elementName + ']').prop('checked', false);
    };

    this.resetCheckBoxById = function(elementId) {
        $('#' + elementId ).prop('checked', false);
    };

    this.notEligiblePopup = function() {
        commonObj.showAlert("You are not Eligible for this Post.");
    };

    this.applyDatetimepickerWithoutDefaultDate = function(elementId, calenderIconId) {
        $('#'+elementId).datetimepicker({
            format: 'DD/MM/YYYY',
            ignoreReadonly: true,
            showTodayButton: true
        });
        $('#'+calenderIconId).click(function() {
            $('#'+elementId).data("DateTimePicker").show();
        });
    };

    this.disableFormFields = function(formID, status){
        if(status == 2 || status == '2') {
            $('#' + formID).find('input, textarea, button, select').not("#cancelBtn").attr('disabled', 'disabled');
        }
        $(".skipDisabling").removeAttr("disabled");
    };

    this.bindPostForm = function(formID){
    	jQuery("#" + formID).find('.radio-inline').click(function() {
            var eligibleToApplyForPost = true;

            jQuery("#" + formID).find('.radiosToCheck').each(function(){
                if($(this).is(":checked")) {
                	 eligibleToApplyForPost = false;
                	 $(this).parent().parent().find(".help-block").html(jQuery("#notEligibleForPost").val());
                     $(this).parent().parent().parent().addClass( 'has-error' );
                } else {
                    $(this).parent().parent().find(".help-block").html("");
                    $(this).parent().parent().parent().removeClass( 'has-error has-danger' );
                }
            });
            if(eligibleToApplyForPost) {
                jQuery("#" + formID).find('.radiosToCheck').each(function(){
                	
                	
                    $(this).parent().parent().find(".help-block").html("");
                    $(this).parent().parent().parent().removeClass( 'has-error has-danger' );
                });
                jQuery("#" + formID).find('#saveAsDraftBtn').removeAttr('disabled');
                jQuery("#" + formID).find('#saveBtn').removeAttr('disabled');
                if($("#divisionControllerRequiredQualificationMarks").val()<45){
            		$('#divisionControllerForm').find('#saveAsDraftBtn').attr('disabled', 'disabled');
               	 $('#divisionControllerForm').find('#saveBtn').attr('disabled', 'disabled');
            	}
            } else {
                jQuery("#" + formID).find('#saveAsDraftBtn').attr('disabled','disabled');
                jQuery("#" + formID).find('#saveBtn').attr('disabled','disabled');
                if($("#divisionControllerRequiredQualificationMarks").val()<45){
            		$('#divisionControllerForm').find('#saveAsDraftBtn').attr('disabled', 'disabled');
               	 $('#divisionControllerForm').find('#saveBtn').attr('disabled', 'disabled');
            	}
            }
        });
    	
//    	jQuery("#" + formID).ajaxForm({
//            dataType:  'json',          
//            success:  function(result){
//                jQuery("#processingRequestSpan").hide();
//                jQuery("#saveBtn").attr("disabled",false);
//                jQuery("#saveAsDraftBtn").attr("disabled",false);
//                jQuery("#delBtn").attr("disabled",false);
//                jQuery("#cancelBtn").attr("disabled",false);
//
//                var success = result.success;
//                if(success)
//                {
//                    return false;
//                }  
//                else 
//                {
//                    commonObj.showAlert("There was some error while trying to save the form.");
//                }
//            }
//        });
    	
        jQuery("#" + formID).ajaxForm({
            dataType:  'json',
            beforeSubmit:  function(){
            	if(!postSelectionObj.isDraft(formID))
            	{
	            	if(formID == "clerkTypistJuniorForm" )
	            	{
		    	    	if(checkExperienceClerkTypist())
		    			{
		    				postSelectionObj.experienceNotePopup();
		    				return false;
		    			}
	            	}
	            	else if( formID == "assistantJuniorForm")
	            	{
	            		if(checkExperienceAssistantJr())
		    			{
		    				postSelectionObj.experienceNotePopup();
		    				return false;
		    			}
	            	}
            	}
//                if (postSelectionObj.isDraft(formID) || $('#'+formID).validator('validate').has('.has-error').length == 0) {
            	if (postSelectionObj.isDraft(formID) || $('#'+formID).valid()) {
                    jQuery("#processingRequestSpan").show();
                    jQuery("#saveBtn").attr("disabled",true);
                    jQuery("#saveAsDraftBtn").attr("disabled",true);
                    jQuery("#delBtn").attr("disabled",true);
                    jQuery("#cancelBtn").attr("disabled",true);
                    return true;
                } else {
                    return false;
                }
            },
            success:  function(result){
                jQuery("#processingRequestSpan").hide();
                jQuery("#saveBtn").attr("disabled",false);
                jQuery("#saveAsDraftBtn").attr("disabled",false);
                jQuery("#delBtn").attr("disabled",false);
                jQuery("#cancelBtn").attr("disabled",false);

                var success = result.success;

                if(success){
                	if($('#priorityLiId').length){
                		postSelectionObj.goToNextPost();
                	}else{
                		var postId=jQuery("#" + formID).find('input[name="postId"]').val();
                		if(!$('#post_'+postId).is(':last-child')){
                			postSelectionObj.goToNextPost();
                		}else{
                			applyObj.gotoTab('4');
                		}
                	}
                    return false;
                } else {
                    commonObj.showAlert("There was some error while trying to save the form.");
                }
            }
        });
    };

    this.isDraft = function(formID){
        var status = jQuery("#"+formID).find("#status").val();
        return status == 0 || status == '0';
    };

    this.changeBackgroundColor = function(formID, status){
        var postId = 0;

        switch(formID){
            case "driverForm":
                postId = 1;
                break;
            case "conductorForm":
                postId = 2;
                break;
            case "clerkTypistJuniorForm":
                postId = 3;
                break;
            case "assistantJuniorForm":
                postId = 4;
                break;
            case "assistantTrafficSuperintendentJuniorForm":
                postId = 5;
                break;
            case "trafficInspectorJuniorForm":
                postId = 6;
                break;
            case "accountantJuniorForm":
                postId = 7;
                break;
            case "storeSuperviserJuniorForm":
                postId = 8;
                break;
            case "storeKeeperJuniorForm":
                postId = 9;
                break;
            case "securityInspectorJuniorForm":
                postId = 10;
                break;
            case "asstSecurityInspectorJuniorForm":
                postId = 11;
                break;
            case "fireWardenJuniorForm":
                postId = 12;
                break;
            case "juniorEngineerCivilForm":
                postId = 13;
                break;
            case "juniorEngineerElectricalForm":
                postId = 14;
                break;
            case "asstWorkSuperintendentJuniorForm":
                postId = 15;
                break;
            case "chargeManJuniorForm":
                postId = 16;
                break;
            case "seniorComputerOperatorJuniorForm":
                postId = 18;
                break;
            case "generalManagerProjectForm":
                postId = 19;
                break;
            case "generalManagerInformationTechnologyForm":
                postId = 20;
                break;
            case "driverCumConductorForm":
                postId = 21;
                break;
            case "divisionControllerForm":
                postId = 22;
            case "machineEngineerForm":
                postId = 23;
            case "departmentalTransportOfficerForm":
                postId = 24;
            case "deputyEquipmentEngineerForm":
                postId = 25;
            case "accountingOfficerForm":
                postId = 26;
            case "storeOfficerForm":
                postId = 27;
            case "divisionalTransportSuperintendentForm":
                postId = 28;
            case "assistantEquipmentEngineerForm":
                postId = 29;
            case "departmentalAccountsOfficerForm":
                postId = 30;
            case "departmentalStatisticsOfficerForm":
                postId = 31;
                break;
        }

        if(status == 0) {
            $(".postSelectionUL").find("#post_" + postId).addClass("redPostBG");
            $(".postSelectionUL").find("#post_" + postId).removeClass("greenPostBG");
        } else if(status == 1) {
            $(".postSelectionUL").find("#post_" + postId).addClass("greenPostBG");
            $(".postSelectionUL").find("#post_" + postId).removeClass("redPostBG");
        } else {
            $(".postSelectionUL").find("#post_" + postId).addClass("grayPostBG");
        }

    };

    this.saveFormAsDraft = function(formID){
        this.changeBackgroundColor(formID, 0);
    	jQuery("#"+formID).validate().settings.ignore = "*";
        jQuery("#"+formID).find("#status").val(0);
        if($("#divisionControllerRequiredQualificationMarks").val()<45){
   		 $('#divisionControllerForm').find(".divisionControllerRequiredQualificationMarks").find(".help-block").html(jQuery("#notEligibleForPost").val());
   	}else{
       jQuery("#"+ formID).submit();
   	}
    };

    this.saveForm = function(formID){
    	this.validateFormBeforeSave(formID);
        this.changeBackgroundColor(formID, 1);
    	jQuery("#"+formID).find("#status").val(1);
    	if($("#divisionControllerRequiredQualificationMarks").val()<45){
            $('#divisionControllerForm').find(".divisionControllerRequiredQualificationMarks").find(".help-block").html(jQuery("#notEligibleForPost").val());
       }else{
        jQuery("#"+ formID).submit();
    	}
    };
   
    this.validateFormBeforeSave = function(formID)
    {
    	if(formID == "asstWorkSuperintendentJuniorForm")
        {
        	if($("#awsassitWSJunior-ownHeavyDrivingLicenseNumber-yes").is(":checked"))
    		{
        		jQuery("#"+formID).validate().settings.ignore = "";
        	}
        	else
        	{
        		jQuery("#"+formID).validate().settings.ignore = "#assitWSHeavyDrivingLicenseNumber,#assitWSHeavy-DrivingLicenseIssueDate,#assitWSHeavy-DrivingLicenseEndDate";
        	}
        }
    	else if(formID == "departmentalAccountsOfficerForm")
        {
        	if($("#departmentalAccountsOfficer-degreeInCommerce-yes").is(":checked"))
    		{
        		jQuery("#"+formID).validate().settings.ignore = "";
        	}
        	else
        	{
        		jQuery("#"+formID).validate().settings.ignore = "#departmentalAccountsOfficerUniversityName,#departmentalAccountsOfficerDegreeName,#departmentalAccountsOfficerRequiredQualificationMarks";
        	}
        }
    	else if(formID == "departmentalStatisticsOfficerForm")
        {
        	if($("#departmentalStatisticsOfficer-postGraduateDegreeScience-yes").is(":checked"))
    		{
        		jQuery("#"+formID).validate().settings.ignore = "";
        	}
        	else
        	{
        		jQuery("#"+formID).validate().settings.ignore = "#departmentalStatisticsOfficerUniversityName,#departmentalStatisticsOfficerDegreeName,#departmentalStatisticsOfficerRequiredQualificationMarks";
        	}
        }
    	else if(formID == "storeOfficerForm")
        {
    		var storeValidatiion="";
        	if($("#storeOfficer-isFirstClassDegree-yes").is(":checked"))
    		{
        		if(storeValidatiion==''){
            		storeValidatiion=storeValidatiion+"#storeOfficerPostGraduateDegreeName,#storeOfficerPostGradDegreeInstituteName,#storeOfficerPostGraduateMarks";
            		}
            		else{
            			storeValidatiion=storeValidatiion+",#storeOfficerPostGraduateDegreeName,#storeOfficerPostGradDegreeInstituteName,#storeOfficerPostGraduateMarks"
            		}
        	}
        	else
        	{
        		if(storeValidatiion==''){
            		storeValidatiion=storeValidatiion+"#storeOfficerDegreeName,#storeOfficerUniversityName,#storeOfficerRequiredQualificationMarks";
            		}
            		else{
            			storeValidatiion=storeValidatiion+",#storeOfficerDegreeName,#storeOfficerUniversityName,#storeOfficerRequiredQualificationMarks"
            		}
          	}
        	if($("#storeOfficer-secondClassInMBA-yes").is(":checked"))
    		{
        		if(storeValidatiion==''){
        			storeValidatiion=storeValidatiion+"#storeOfficerIcwaDiplomaName,#storeOfficerIcwaUniversityName,#storeOfficerIcwaMarks";
        		}
        		else{
        			storeValidatiion=storeValidatiion+",#storeOfficerIcwaDiplomaName,#storeOfficerIcwaUniversityName,#storeOfficerIcwaMarks"
        		}
        	}
        	else
        	{
        		if(storeValidatiion==''){
        			storeValidatiion=storeValidatiion+"#storeOfficerMBADegreeName,#storeOfficerMBAUniversity,#storeOfficerMBAMarks";
        		}
        		else{
        			storeValidatiion=storeValidatiion+",#storeOfficerMBADegreeName,#storeOfficerMBAUniversity,#storeOfficerMBAMarks"
        		}
        	}
        	jQuery("#"+formID).validate().settings.ignore = storeValidatiion;
        	storeValidatiion = "";
        }
    	else if(formID == "chargeManJuniorForm")
        {
         	if($("#chargeManJunior-ownHeavyDrivingLicenseNumber-yes").is(":checked"))
         	{
        		jQuery("#"+formID).validate().settings.ignore = "";
        	}
        	else
         	{
         		jQuery("#"+formID).validate().settings.ignore = "#chargeManJuniorHeavyDrivingLicenseNumber,#chargeManJuniorHeavyDrivingLicenseIssueDate,#chargeManJuniorHeavyDrivingLicenseEndDate";
         	}
         }
    	else if(formID == "driverForm")
        {
         	if($("#driver-ownConductorBatchNumber-yes").is(":checked"))
         	{
        		jQuery("#"+formID).validate().settings.ignore = "";
        	}
        	else
         	{
         		jQuery("#"+formID).validate().settings.ignore = "#driverConductorBatchNumber,#driverConductorBatchNumberIssueDate,#driverConductorBatchNumberEndDate";
         	}
         }
    	else if(formID == "driverCumConductorForm")
        {
    		// driverCumConductor-ownHeavyDrivingLicenseNumber-yes
    		// driverCumConductor-lightMotorVechicle-yes
    		var gender = $("#applicantGender").val();
    		var ignoreVal = "";
    		if(gender == '0'){
	    		if(!$("#driverCumConductor-ownHeavyDrivingLicenseNumber-yes").is(":checked") && 
	    		   !$("#driverCumConductor-lightMotorVechicle-yes").is(":checked")){
	    			commonObj.showAlert(i18n("drive.select.one"));
	    			return; 
	    		}
    		}
    		if($("#driverCumConductor-ownHeavyDrivingLicenseNumber-yes").is(":checked"))
         	{
    			ignoreVal = ignoreVal + "";
        	}
        	else
         	{
        		ignoreVal = ignoreVal + "#driverCumConductorHeavyDrivingLicenseEndDate,#driverCumConductorHeavyDrivingLicenseIssueDate,#driverCumConductorHeavyDrivingLicenseNumber";
         	}
    		if(gender == '0'){
	    		if($("#driverCumConductor-lightMotorVechicle-yes").is(":checked"))
	         	{
	    			ignoreVal = ignoreVal + "";
	        	}
	        	else
	         	{
	        		if(ignoreVal == ''){
	            		ignoreVal = ignoreVal + "#driverCumConductor-lightMotorVechicleIssueDate,#driverCumConductor-lightMotorVechicleLicenseNo";
	        		} else {
	            		ignoreVal = ignoreVal + ",#driverCumConductor-lightMotorVechicleIssueDate,#driverCumConductor-lightMotorVechicleLicenseNo";
	        		}
	         	}
	    		if($("#driverCumConductor-ownPsvBadgeNo-yes").is(":checked"))
	         	{
	    			ignoreVal = ignoreVal + "";
	        	}
	        	else
	         	{
	        		if(ignoreVal == ''){
	            		ignoreVal = ignoreVal + "#driverCumConductorPsvBatchNumber";
	        		} else {
	            		ignoreVal = ignoreVal + ",#driverCumConductorPsvBatchNumber";
	        		}
	         	}
	    		
    		}
         	if($("#driverCumConductor-ownConductorBatchNumber-yes").is(":checked"))
         	{
         		ignoreVal = ignoreVal + "";
        	}
        	else
         	{
        		if(ignoreVal == ''){
            		ignoreVal = ignoreVal + "#driverCumConductorBatchNumber,#driverCumConductorBatchNumberIssueDate,#driverCumConductorBatchNumberEndDate";
        		} else {
            		ignoreVal = ignoreVal + ",#driverCumConductorBatchNumber,#driverCumConductorBatchNumberIssueDate,#driverCumConductorBatchNumberEndDate";
         	}
         	}
         	jQuery("#"+formID).validate().settings.ignore = ignoreVal;
         	ignoreVal = "";
         }
    	 else if(formID == "assistantTrafficSuperintendentJuniorForm")
         {
          	if($("#assistantTrafficSuperintendent-ownHeavyDrivingLicenseNumber-yes").is(":checked"))
          	{
        		jQuery("#"+formID).validate().settings.ignore = "";
        	}
        	else
          	{
          		jQuery("#"+formID).validate().settings.ignore = "#assistantTrafficSuperintendent-heavyDrivingLicenseNumber,#assistantTrafficSuperintendent-heavyDrivingLicenseIssueDate,#assistantTrafficSuperintendent-heavyDrivingLicenseEndDate";
          	}
          }
    	 else if(formID == "trafficInspectorJuniorForm")
         {
          	if($("#trafficInspectorJunior-ownHeavyDrivingLicenseNumber-yes").is(":checked"))
          	{
        		jQuery("#"+formID).validate().settings.ignore = "";
        	}
        	else
          	{
          		jQuery("#"+formID).validate().settings.ignore = "#trafficInspectorJuniorHeavyDrivingLicenseNumber,#trafficInspectorJuniorHeavyDrivingLicenseIssueDate,#trafficInspectorJuniorHeavyDrivingLicenseEndDate";
          	}
          }
    	 else if(formID == "fireWardenJuniorForm")
    	 {
    		 if($("#fireWardenJunior-qualificationForMilitaryForce-yes").is(":checked"))
    		 {
         		jQuery("#"+formID).validate().settings.ignore = "";
         	 }
         	 else
    		 {
    			 jQuery("#"+formID).validate().settings.ignore = "#fireWardenJunior-qualificationForMilitaryForceDegreeName,#fireWardenJunior-qualificationForMilitaryForceUniversityName";
           	 }
    		 if($("#fireWardenJunior-fireSafetyDegreeFromAffiliatedInstitute-yes").is(":checked"))
    		 {
         		jQuery("#"+formID).validate().settings.ignore = "";
         	 }
         	 else
    		 {
    			 jQuery("#"+formID).validate().settings.ignore = "#fireWardenJunior-fireSafetyDegreeName,#fireWardenJunior-fireSafetyUniversityName";
           	 }
    	 }
    	 else if(formID == "clerkTypistJuniorForm")
    	 {
    		 if($("#clerkTypistJunior-experienced-yes").is(":checked"))
    		 {
    			 if($("#clerkTypistJunior-differentlyAbled-yes").is(":checked"))
    			 {
    				 jQuery("#"+formID).validate().settings.ignore = "";
    			 }
    			 else
    			 {
    				 jQuery("#"+formID).validate().settings.ignore = "#clerkTypistJunior-differentlyAbled-blindnessAndLowVision,#clerkTypistJunior-differentlyAbled-deafAndMute,#clerkTypistJunior-differentlyAbled-locomotorOrCerebralPalsy";
    			 }
           	 }
    		 else
    		 {
    			 if($("#clerkTypistJunior-differentlyAbled-yes").is(":checked"))
    			 {
    				 jQuery("#"+formID).validate().settings.ignore = "#clerkTypistJunior-companyName,#clerkTypistJunior-totalExperienceInYears,#clerkTypistJunior-TotalExperienceInMonths";
    			 }
    			 else
    			 {
    				jQuery("#"+formID).validate().settings.ignore = "#clerkTypistJunior-companyName,#clerkTypistJunior-totalExperienceInYears,#clerkTypistJunior-TotalExperienceInMonths,#clerkTypistJunior-differentlyAbled-blindnessAndLowVision,#clerkTypistJunior-differentlyAbled-deafAndMute,#clerkTypistJunior-differentlyAbled-locomotorOrCerebralPalsy";
    			 }
    		 }
    	 }
    	 else if(formID == "assistantJuniorForm")
    	 {
    		 if($("#assistantJunior-experienced-yes").is(":checked"))
    		 {
    			 if($("#assistantJunior-apprenticeshipInMSRTC-yes").is(":checked"))
    			 {
    				 
    				 jQuery("#"+formID).validate().settings.ignore = "";
    			 }
    			 else
    			 {
    				
    				 jQuery("#"+formID).validate().settings.ignore = "#apprenticeshipInMSRTCTrade,#apprenticeshipInMSRTCYear,#apprenticeshipInMSRTCDivision";
    			 }
           	 }
    		 else
    		 {
    			 if($("#assistantJunior-apprenticeshipInMSRTC-yes").is(":checked"))
    			 {
    				 jQuery("#"+formID).validate().settings.ignore = "#assistantJuniorCompanyName,#assistantJuniorTotalExperienceInYears,#assistantJuniorTotalExperienceInMonths";
    			 }
    			 else
    			 {
    				jQuery("#"+formID).validate().settings.ignore = "#assistantJuniorCompanyName,#assistantJuniorTotalExperienceInYears,#assistantJuniorTotalExperienceInMonths,#apprenticeshipInMSRTCTrade,#apprenticeshipInMSRTCYear,#apprenticeshipInMSRTCDivision";
    			 }
    		 }
    	 }
    	 else if(formID == "chargeManJuniorForm")
    	 {
    		if($("#chargeManJunior-ownHeavyDrivingLicenseNumber-yes").is(":checked"))
           	{
         		jQuery("#"+formID).validate().settings.ignore = "";
         	}
         	else
           	{
           		jQuery("#"+formID).validate().settings.ignore = "#chargeManJuniorHeavyDrivingLicenseNumber,#chargeManJuniorHeavyDrivingLicenseIssueDate,#chargeManJuniorHeavyDrivingLicenseEndDate";
           	}
    	 }
    	 else if(formID == "juniorEngineerCivilForm")
    	 {
    		 if($("#juniorEngineerCivil-differentlyAbled-yes").is(":checked"))
             {
          	 	 jQuery("#"+formID).validate().settings.ignore = "";
          	 }
          	else
            {
            	jQuery("#"+formID).validate().settings.ignore = "#juniorEngineerCivil-differentlyAbled-locomotorOrCerebralPalsy";
            }
    	 }
    	 else if(formID == "machineEngineerForm")
    	{
    		 var ignoreValidation="";
    		 if($("#machineEngineer-gradOrPostGrad-yes").is(":checked"))
    		 {
    			 ignoreValidation = ignoreValidation + "";
         	 }
         	 else
    		 {
         		if(ignoreValidation == ''){
         			ignoreValidation = ignoreValidation + "#machineEngineer-degreeName,#machineEngineer-universityName,#machineEngineerrequiredQualificationMarks,#machineEngineer-postGraduateDegreeName,#machineEngineer-postGradDegreeInstituteName,#machineEngineerPostGraduateMarks";
        		} else {
        			ignoreValidation = ignoreValidation + ",#machineEngineer-degreeName,#machineEngineer-universityName,#machineEngineerrequiredQualificationMarks,#machineEngineer-postGraduateDegreeName,#machineEngineer-postGradDegreeInstituteName,#machineEngineerPostGraduateMarks";
        		}
    		 }
    		 if($("#machineEngineer-mbaFromGovernmentAffiliatedInstitute-yes").is(":checked"))
    		 {
    			 ignoreValidation = ignoreValidation + "";
         	 }
         	 else
    		 {
         		if(ignoreValidation == ''){
         			ignoreValidation = ignoreValidation + "#machineEngineer-mbaDegreeName,#machineEngineer-mbaUniversity,#machineEngineermbaMarks";
        		} else {
        			ignoreValidation = ignoreValidation + ",#machineEngineer-mbaDegreeName,#machineEngineer-mbaUniversity,#machineEngineermbaMarks";
        		}
           	 }
    		 jQuery("#"+formID).validate().settings.ignore = ignoreValidation;
    		 ignoreValidation = "";
    	 }
    	 else
    	 {
    		 jQuery("#"+formID).validate().settings.ignore = "";
    	 }
    }
    
    this.submittingForm = function(formID)
    {
    	if($('#priorityLiId').length)
        	{
        		postSelectionObj.goToNextPost();
        	}else
        	{
        		var postId=jQuery("#" + formID).find('input[name="postId"]').val();
        		if(!$('#post_'+postId).is(':last-child')){
        			postSelectionObj.goToNextPost();
        		}
        		else{
        			applyObj.gotoTab('4');
        		}
        	}
    };
    
    this.validateDate = function (fromDateId, toDateId){
    	
    	$('#'+fromDateId).on("dp.change", function (e) {
    		//var fromDate = moment($('#'+fromDateId).val()).format("DD/MM/YYYY");
        	//var toDate = moment($('#'+toDateId).val()).format("DD/MM/YYYY");
    		//if(e.date != undefined || e.date != null) 		date.toLocaleDateString()
    		//moment(new Date()).format("YYYY/MM/DD");
    		
    		var date = new Date(e.date);
    		date.setDate(date.getDate() + 30);
    		var toDate = $('#'+toDateId).val();
    		if(date == toDate)
    		{
    			date.setDate(date.getDate() + 30);
    		}
    		if(date != undefined || date != null)
    			$('#'+toDateId).data("DateTimePicker").minDate(date);
    		
        });
        $('#'+toDateId).on("dp.change", function (e) {
        	var fromDate = new Date( moment($('#'+fromDateId).val()).format("DD/MM/YYYY"));
        	var toDate = new Date( moment($('#'+toDateId).val()).format("DD/MM/YYYY"));
        	if(fromDate == toDate)
        	{
        		toDate.setDate(toDate.getDate() + 30);
        		if(toDate != undefined || toDate != null)
        			$('#'+toDateId).data("DateTimePicker").minDate(toDate);
        	}
        	else
        	{
        		if(e.date != undefined || e.date != null)
        			$('#'+fromDateId).data("DateTimePicker").maxDate(e.date);
        	}
        	
        });
    };
    
    this.experienceNotePopup = function() {
    	commonObj.showAlert(i18n("otherInfo.experience"));
    };
    
    this.maxDate = function()
    {
    	var maxDate=new Date();
		maxDate.setFullYear(maxDate.getFullYear() + 100);
		return maxDate;
    }
    
    this.minDate = function()
    {
    	var minDate = new Date();
		minDate.setFullYear(minDate.getFullYear() - 100);
		return minDate;
    }
    
    this.moveNext = function(formID){
    	if($('#priorityLiId').length){
    		postSelectionObj.goToNextPost();
    	}else{
    		var postId=jQuery("#" + formID).find('input[name="postId"]').val();
    		if(!$('#post_'+postId).is(':last-child')){
    			postSelectionObj.goToNextPost();
    		}else{
    			applyObj.gotoTab('4');
    		}
    	}
    }
    
}