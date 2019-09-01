function Common(appBasePath){

    var commonObj = this;

    this.appBasePath = appBasePath;
    this.mainDivId = "appMainContentDiv";

    this.USER_TYPE_ADMIN = 1;
    this.USER_TYPE_APPLICANT = 2;
    this.SEPARATOR = "|";

    this.changeLanguage = function(languageCode){
		var url = window.location.href; 
		if (url.indexOf('?') == -1) 
		{	
			url = "";
			url += '&lang='+languageCode;
		}
		else if(url.indexOf('lang=') > -1) 
		{
			var newUrl = this.splitUrl(url);
			url = "";
			url = newUrl[0] + 'lang=' + languageCode; //newUrl + paramValue
		} 
		else 
		{
		   url += '&lang='+languageCode;
		}
		alert(url);
		window.location.href = url;
    };
	
	this.splitUrl = function splitUrl(url) 
	{
		return url.split("lang=");		 
	};
    
    this.setMainDivId= function(mainDivId){
        this.mainDivId = mainDivId;
    };

	this.goToURL = function(url){
		window.location.href = url;
	};

    this.logout = function() {
        if(idleTimeout == true){
            $("#idleTimeout").val(true);
        }
        $( "#logoutForm" ).submit();
    };
    this.showConfirmation = function(confirmationMessage, callback, yesLabel, noLabel, title) {

        bootbox.dialog({
            closeButton: false,
            onEscape : false,
            title : "<span class='fa fa-warning'></span> " + title,
            message: confirmationMessage,
            animate : false,
            buttons: {
                cancel: {
                    label: yesLabel,
                    className: "btn-danger",
                    callback: function(result) {
                        callback(true, false);
                    }
                },
                confirm: {
                    label: noLabel,
                    className: "btn-default",
                    callback: function(result) {
                        callback(false, true);
                    }
                }
            }
        });
    };

    
    this.getAdmitCardData= function(admitCardURL,applicationId){
    	   var url = this.appBasePath +'applicant?operation=viewAdmitCardAttachment&admitCardURL='+admitCardURL+'&applicationId='+applicationId;
    	   $('#admitCardPicture').attr('src', url);
 					commonObj.showPopup('admitCardPopup',"");
      };
      
      this.showPopup = function(id,url) {
     	 $('#'+id).modal('show');
     }
      
    this.showAgreeDisAgreePopup = function(confirmationMessage, callback, yesLabel, noLabel, title) {
        bootbox.dialog({
            closeButton: false,
            onEscape : false,
            title : "<span class='fa fa-warning'></span> " + title,
            message: confirmationMessage,
            animate : false,
            buttons: {
                cancel: {
                    label: yesLabel,
                    className: "btn-default",
                    callback: function(result) {
                        callback(true);
                    }
                },
                confirm: {
                    label: noLabel,
                    className: "btn-default",
                    callback: function(result) {
                        callback(false);
                    }
                }
            }
        });
    };

    this.showAlert = function(message, callback) {

        bootbox.alert({
            title : "<span class='fa fa-check-circle'></span>&nbsp;" + i18n("message"),
            message: message,
            buttons: {
                ok: {
                    label: i18n("ok"),
                    className: "btn-default"
                }
            },
            callback: function() {
                if(callback != null && callback != "" && callback != undefined) {
                    callback();
                }
            }
        });
    };
    
    this.notEligiblePopup = function() {
        commonObj.showAlert("You are not Eligible for this Post.");
    };

    this.showSessionTimeoutPopup = function(){
        $('#sessionTimeoutPopup').modal({
            backdrop: 'static',
            keyboard: false
        });
    };

    this.continueSession = function(){
        $.ajax({url:commonObj.appBasePath + 'continueSession', success:function(data){}});
    };

    this.showTermsAndConditionPopup = function(){
        $('#termsAndConditionPopup').modal({
            backdrop: 'static',
            keyboard: false
        });
    };

    this.showDisclaimerAndPoliciesPopup = function(){
        $('#disclaimerPopup').modal({
            backdrop: 'static',
            keyboard: false
        });
    };
    
    this.showHyperlinkingPolicyPopup = function(){
        $('#hyperlinkingPolicyPopup').modal({
            backdrop: 'static',
            keyboard: false
        });
    };
    
    this.showPrivacyPolicyPopup = function(){
        $('#privacyPolicyPopup').modal({
            backdrop: 'static',
            keyboard: false
        });
    };
    
    this.showCopyrightPolicyPopup = function(){
        $('#copyrightPolicyPopup').modal({
            backdrop: 'static',
            keyboard: false
        });
    };
    

    this.viewUserNotification = function(userNotificationId,description){
    	var isMarkedAsRead = $("#markedAsRead_"+ userNotificationId ).val(); 
    	
    	if(isMarkedAsRead == false  || isMarkedAsRead == 'false' || isMarkedAsRead == null || isMarkedAsRead == ''){
        	var url = appBasePath + "notification?operation=markUserNotificationAsRead&userNotificationId=" + userNotificationId;
        	$.ajax({
                type: "POST",
                dataType: 'json',
                url: url,
                success: function(result){
                	if ( result.success ) {
                		$("#markedAsRead_"+ userNotificationId ).val('true');
                		$('#userNotificationCount').text( result.unreadUserNotification );
                		if(result.unreadUserNotification==0){
                			$('#userNotificationCount').remove();
                		}
                	}
                }
            });
    	}

    	var title = $("#userNotification_"+ userNotificationId ).find(".title").html();
    	var text = description;
    	
    	$("#notificationTitle").html(title);
    	$("#notificationText").html(text);
    	
        $('#viewUserNotificationPopup').modal({
            backdrop: 'static',
            keyboard: false
        });
    	
    };
    
this.viewNotification = function(notificationId,description){
    	
    	var title = $("#notification_"+ notificationId ).find(".title").html();
    	var text = description;
    	
    	$("#notificationTitle").html(title);
    	$("#notificationText").html(text);
    	//alert("56745");
        $('#viewNotificationPopup').modal({
            backdrop: 'static',
            keyboard: false
        });
    };
    
this.isValidate = function (verifyFlag) {
    	
    	if(verifyFlag == true ) {
			return true;
		}
    	return false;
    }
    
    this.disableFormFields = function(formID, status){
        if(status == true) {
            $('#' + formID).find('input, textarea, button, select').not("#cancelBtn").attr('disabled', 'disabled');
            //jQuery("#" + formID).find('#saveAsDraftBtn').hide();
            //jQuery("#" + formID).find('#saveBtn').hide();
        }
        $(".skipDisabling").removeAttr("disabled");
    };
    
    this.getDataFromExamBench = function(applicantPostAssocId,postId,lng){
    	var url = appBasePath + "applicant?operation=getExamDataFromExamBench&applicantPostAssocId=" + applicantPostAssocId+'&lngCode='+lng+'&postId='+postId;
    	var myWindow = window.open(url);
    	//commonObj.goToURL(url);
    	
    };
}