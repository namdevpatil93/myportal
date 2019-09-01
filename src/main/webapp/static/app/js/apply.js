function Apply(appBasePath){

    var applyObj = this;

    this.appBasePath = appBasePath;

    var time=0;
    
    this.tabsIds = ['personalInformationTab','otherInformationTab','postSelectionTab','photoAndSignatureTab','confirmationTab','paymentTab'];

    this.gotoTab = function(tabNo){

        switch(tabNo){
            case '1':
            	var url = applyObj.appBasePath + 'applicant?operation=apply&tabNo=1&menu=applyMenu';
            	commonObj.goToURL(url);
            	// applyObj.showPersonalInformation();
                break;
            case '2':
                applyObj.showOtherInformation();
                break;
            case '3':
                applyObj.showPostSelection();
                break;
            case '4':
                applyObj.showApplicantFiles();
                break;
            case '5':
                applyObj.showConfirmation();
                break;
            default:
                var url = applyObj.appBasePath + 'applicant?operation=apply&tabNo=1&menu=applyMenu';
                commonObj.goToURL(url);
                //                applyObj.showPersonalInformation();
                break;
        }

    };

    this.showPersonalInformation = function(){
    	isPersonalInfoPage = true;
    	time = new Date().getTime();
        var url = applyObj.appBasePath + 'applicant?operation=showPersonalInformation&time='+time;
        jQuery("#applySteps").load(url, function(){
            applyObj.markTabAsActive("personalInformationTab");
        });
    };

    this.showOtherInformation = function(){
    	isPersonalInfoPage = false;
    	time = new Date().getTime();
        var url = applyObj.appBasePath + 'applicant?operation=showOtherInformation&time='+time;
        jQuery("#applySteps").load(url, function(){
            applyObj.markTabAsActive("otherInformationTab");
        });
    };

    this.showPostSelection = function(){
    	isPersonalInfoPage = false;
    	time = new Date().getTime();
        var url = applyObj.appBasePath +  'applicant?operation=showSelectedPosts&isPostSelectionPage=true&time='+time;
        jQuery("#applySteps").load(url, function(){
            applyObj.markTabAsActive("postSelectionTab");
            if(postId  != null && postId  != '' && postId  != 'undefined') {
                $('.postSelectionUL').find('#post_' + postId).find('a').trigger('click');
            }
        });
    };

    this.showSelectedPosts = function(){
    	time = new Date().getTime();
        var url = applyObj.appBasePath + 'applicant?operation=showSelectedPosts&time='+time;
        jQuery("#applySteps").load(url, function(){
            applyObj.markTabAsActive("postSelectionTab");
        });
    };

    this.showApplicantFiles = function(){
    	isPersonalInfoPage = false;
    	time = new Date().getTime();
        var url = applyObj.appBasePath + 'applicant?operation=showApplicantFiles&time='+time;
        jQuery("#applySteps").load(url, function(){
            applyObj.markTabAsActive("photoAndSignatureTab");
        });
    };

    this.showConfirmation = function(){
    	isPersonalInfoPage = false;
    	time = new Date().getTime();
        var url = applyObj.appBasePath + 'applicant?operation=showConfirmation&time='+time;
        jQuery("#applySteps").load(url, function(){
            applyObj.markTabAsActive("confirmationTab");
        });
    };

    this.showPayment = function(){
    	time = new Date().getTime();
        var url = applyObj.appBasePath + 'payment?operation=showPayment&time='+time;
        jQuery("#applySteps").load(url, function(){
            applyObj.markTabAsActive("paymentTab");
        });
    };

    this.markTabAsActive = function(tabId){
        var tabIds = applyObj.tabsIds;
        for(var i = 0; i< tabIds.length; i++){
            if(tabId === tabIds[i]){
                jQuery("#"+tabIds[i]).addClass("active");
            } else {
                jQuery("#"+tabIds[i]).removeClass("active");
            }
        }
    };

//    this.checkIfValidApplicationSubmission = function(){
//        var url = applyObj.appBasePath + 'applicant?operation=validateSubmission';
//
//        jQuery.ajax({
//            url : url + "&tempDate=" +new Date().getTime(),
//            async : false,
//            type: "POST",
//            dataType: 'json',
//            success : function(result) {
//                var success = result.success;
//                if(success){
//                    var errorsDTO = result.errorsDTO;
//                    if(errorsDTO.valid){
//                        applyObj.showPayment();
//                    } else {
//                        var messageHtml = "";
//
//                        messageHtml = '<div class="alert alert-danger" role="alert"> \
//                        	 Please fill in all the details to submit the form! \
//                                        </div>';
//
//                        messageHtml =  messageHtml + '<ul class="list-group">';
//
//                        if(errorsDTO.personalInformationValid == false) {
//                            messageHtml = messageHtml + '<li class="list-group-item">Personal Information</li>';
//                        }
//
//                        if(!errorsDTO.personalInformationValid) {
//                            messageHtml = messageHtml + '<li class="list-group-item">Other Information</li>';
//                        }
//
//                        if(errorsDTO.postsSelected) {
//                            for(var i = 0; i < errorsDTO.invalidPostNames ; i++){
//                                messageHtml = messageHtml + '<li class="list-group-item">errorsDTO.invalidPostNames[i]</li>';
//                            }
//                        }
//                        var subMessageHtml = '<ul> ';
//                        if (errorsDTO.postSubmissionErrorsDTOList.length > 0) {
//                        	for ( var i = 0, l = errorsDTO.postSubmissionErrorsDTOList.length; i < l; i++ ) {
//                                if (!errorsDTO.postSubmissionErrorsDTOList[ i ].formValid) {
//                                	subMessageHtml = subMessageHtml + '<li class="list-group-item">' + errorsDTO.postSubmissionErrorsDTOList[ i ].post.messageKey + ' is not saved.</li>';
//                                }
//                                if (!errorsDTO.postSubmissionErrorsDTOList[ i ].prioritySet) {
//                                	subMessageHtml = subMessageHtml + '<li class="list-group-item"> Priority for ' + errorsDTO.postSubmissionErrorsDTOList[ i ].post.messageKey + ' post is not set.</li>';
//                                }
//                            }
//                        }
//                        subMessageHtml = subMessageHtml + '</ul>';
//                        
//                        messageHtml = messageHtml + subMessageHtml;
//                        
//                        messageHtml =  messageHtml + '</ul> ';
//
//                        bootbox.dialog({
//                            title: 'Submission Errors',
//                            message: messageHtml
//                        });
//                    }
//                } else {
//                    commonObj.showAlert("There was some error while processing your request.");
//                }
//            }
//        });
//    };

    this.viewPostDetails = function(applicantPostAssocId, postTitle){
        var url = applyObj.appBasePath + 'applicant?operation=viewPostDetails';

        jQuery.ajax({
            type: 'POST',
            url: url,
            data : { 'applicantPostAssocId' : applicantPostAssocId},
            async : false,
            success: function(data) {
                bootbox.dialog({
                    message: data ,
                    title: postTitle,
                    buttons: {
                        success: {
                            label: i18n("close"),
                            className: "btn-success",
                        },
                    }
                });
            }
        });
    }
    
    this.bindPersonalInfoForm = function(formID){

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
            } else {
                jQuery("#" + formID).find('#saveAsDraftBtn').attr('disabled','disabled');
                jQuery("#" + formID).find('#saveBtn').attr('disabled','disabled');
            }
        });
    }
    
    this.isValidate = function (verifyFlag) {
    	
    	if(verifyFlag == true ) {
			return true;
		}
    	return false;
    }
    
    this.viewDisabledPostBySelectedDOB = function(applicantId, newDate) {
    	applicantId = applicantId;
    	var url = applyObj.appBasePath + 'applicant?operation=findDisabledPost';
    	
    	var token = $("meta[name='_csrf']").attr("content");
    	var header = $("meta[name='_csrf_header']").attr("content");
    	
    	jQuery.ajax({
    		type : 'POST',
    		url : url,
    		data : {'applicantId' : applicantId, 'dob' : newDate},
    		async : false,
    		beforeSend: function(xhr) {
                // here it is
                xhr.setRequestHeader(header, token);
            },
    		success : function(data) {
    			
    			var json = jQuery.parseJSON(data);
    			$('#deletedPostIds').val(json.postIds);
    			var i18nMsg = [];
    			var msgKey = ""+json.invalidPostNames;
    			
    			var arr = msgKey.split(',');
    			
    			if(typeof arr[0] !== 'undefined' && arr[0] !== null && arr[0] !== "" ){
	    			for(i=0;i<arr.length;i++)
	    			{
	    				i18nMsg.push(i18n(arr[i]));
	    			}
	    			commonObj.showConfirmation(i18n("confirm.post.not.eligible.msg1")+" [ "+i18nMsg+" ] "+i18n("confirm.post.not.eligible.msg2"), deleteApplicantPost, i18n("yes"),i18n("no"), i18n("confirm"));
    			}else{
    				deleteApplicantPost(true);
    			}	
    			
    		}
    	});
     };
    
    function deleteApplicantPost(flag) {
    	
    	if(flag) {
    		
    		var takeDecision=$('#takeDecision').val();
    		if(takeDecision == '1' ){
    			applyObj.callSave();
    		}
    		else{
    			applyObj.callSaveAsDraft();
    		}
    	}
    	else {
    		$('#birthDate').val($('#aplicantDOB').val());
    		$('#deletedPostIds').val('');
    		$('#takeDecision').val('');
    	}
    };
    
    this.callSave = function() {
    	$("#personalInfoForm").validator("destroy");
        jQuery("#status").val(1);
        jQuery("#personalInfoForm").submit();
    };
    
    this. callSaveAsDraft = function(){
    	$("#personalInfoForm").validate().settings.ignore = "*";
        jQuery("#status").val(0);
        jQuery("#personalInfoForm").submit();
    };
    
    
    
}