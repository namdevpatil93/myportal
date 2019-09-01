<%@ page contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1" %>
<%@ include file="../../common/taglibs.jsp"%>

<script>

jQuery(document).ready(function() {
	/* var lastDateOver = commonObj.isValidate(${disableFormAfterLastDateOver});
    commonObj.disableFormFields("confirmApplicationForm",lastDateOver); */
    
    var lastDateOfPayment = commonObj.isValidate(${disableFormAfterLastDateOfPayment});
    commonObj.disableFormFields("confirmApplicationForm",lastDateOfPayment);
});
    function confirmSubmission(){
        if(${isAllPostSelected != 0 }){
	        var msg = "<fmt:message key="confirmation.applyForAnotherPost"/>";
	        commonObj.showConfirmation(msg, function(result){
	            if(result){
	                applyObj.showPostSelection();
	            } else {
	                // applyObj.showPayment();
	                checkIfValidApplicationSubmission();
	            }
	        }, '<fmt:message key="yes"/>', '<fmt:message key="no"/>', '<fmt:message key="confirmationMessage.title"/>' );
        } else {
        	checkIfValidApplicationSubmission();
         }
    }
    
    function checkIfValidApplicationSubmission(){
        var url = applyObj.appBasePath + 'applicant?operation=validateSubmission';

        jQuery.ajax({
            url : url + "&tempDate=" +new Date().getTime(),
            async : false,
            type: "POST",
            dataType: 'json',
            success : function(result) {
                var success = result.success;
                if(success){
                    var errorsDTO = result.errorsDTO;
                    if(errorsDTO.valid){
                    	
                    	if(errorsDTO.otherInformationFieldValid == false){
                    		var msg = "<fmt:message key="confirmation.otherInformationFieldValid"/>";
                    		commonObj.showConfirmation(msg, function(result){
                	            if(result){
                	                applyObj.showOtherInformation();
                	            }else{
                	            	applyObj.showPayment();
                	            }
                	        }, '<fmt:message key="yes"/>', '<fmt:message key="no"/>', '<fmt:message key="confirmationMessage.title"/>' );
                    	}else{
                    		applyObj.showPayment();
                    	}
                        
                    } else {
                        var messageHtml = "";

                        messageHtml = '<div class="alert alert-danger" role="alert"> \
                        	 ' + '<fmt:message key="confirmation.messages.error" />' + ' \
                                        </div>';

                        messageHtml =  messageHtml + '<ul class="list-group">';

                        if(errorsDTO.personalInformationValid == false) {
                        	var personalInformation = '<fmt:message key="confirmation.personalInformation" />';
                            messageHtml = messageHtml + '<li class="list-group-item">' + personalInformation + '</li>';
                        }
                        
                        if(errorsDTO.readWriteSpeakMarathi == false) {
                        	var readWriteSpeakMarathiError = '<fmt:message key="confirmation.readwritespeakmarathi" />';
                            messageHtml = messageHtml + '<li class="list-group-item">' + readWriteSpeakMarathiError + '</li>';
                        }

                        if(!errorsDTO.otherInformationValid) {
                        	var otherInformation = '<fmt:message key="confirmation.otherInformation" />';
                            messageHtml = messageHtml + '<li class="list-group-item">' + otherInformation + '</li>';
                        }
                        
                        if(!errorsDTO.photoValid) {
                        	var applicantPhoto = '<fmt:message key="confirmation.applicantPhoto" />';
                            messageHtml = messageHtml + '<li class="list-group-item">' + applicantPhoto + '</li>';
                        }
                        
                        if(!errorsDTO.signatureValid) {
                        	var applicantSignature = '<fmt:message key="confirmation.applicantSignature" />';
                            messageHtml = messageHtml + '<li class="list-group-item">' + applicantSignature + '</li>';
                        }
                        
                        if(!errorsDTO.postsSelected) {
                        	var noPostSelected = '<fmt:message key="confirmation.noPostSelected" />';
                            messageHtml = messageHtml + '<li class="list-group-item">' + noPostSelected + '</li>';
                        }

//                         if(errorsDTO.postsSelected) {
//                             for(var i = 0; i < errorsDTO.invalidPostNames ; i++){
//                                 messageHtml = messageHtml + '<li class="list-group-item">errorsDTO.invalidPostNames[i]</li>';
//                             }
//                         }

                        var subMessageHtml = '<ul> ';
                        if (errorsDTO.postSubmissionErrorsDTOList.length > 0) {
                        	for ( var i = 0, l = errorsDTO.postSubmissionErrorsDTOList.length; i < l; i++ ) {
                        		var msg = errorsDTO.postSubmissionErrorsDTOList[ i ].post.messageKey;
                        		var postName = "";

                        		switch (errorsDTO.postSubmissionErrorsDTOList[ i ].post.postId) {
                        	    
	                        	    case 1:
	                        	    	postName = '<fmt:message key="post.driver.junior" />';
	                        	        break;
	                        	    case 2:
	                        	    	postName = '<fmt:message key="post.conductor.junior" />';
	                        	        break;
	                        	    case 3:
	                        	    	postName = '<fmt:message key="post.clerk.typist.junior" />';
	                        	        break;
	                        	    case 4:
	                        	    	postName = '<fmt:message key="post.assistant.junior" />';
	                        	        break;
	                        	    case 5:
	                        	    	postName = '<fmt:message key="post.assistant.traffic.superitendent.junior" />';
	                        	        break;
	                        	    case 6:
	                        	    	postName = '<fmt:message key="post.traffic.inspector.junior" />';
	                        	    	break;
	                        	    case 7:
	                        	    	postName = '<fmt:message key="post.accountant.jrstock.verifier.junior" />';
	                        	        break;
	                        	    case 8:
	                        	    	postName = '<fmt:message key="post.storesupervisor.srstock.verifier.junior" />';
	                        	        break;
	                        	    case 9:
	                        	    	postName = '<fmt:message key="post.store.keeper.junior" />';
										break;
	                        	    case 10:
	                        	    	postName = '<fmt:message key="post.security.inspector.junior" />';
	                        	        break;
	                        	    case 11:
	                        	    	postName = '<fmt:message key="post.assistant.security.inspector.junior" />';
	                        	        break;
	                        	    case 12:
	                        	    	postName = '<fmt:message key="post.firewarden.junior" />';
	                        	        break;
	                        	    case 13:
	                        	    	postName = '<fmt:message key="post.junoirengineer.civil.junior" />';
	                        	        break;
	                        	    case 14:
	                        	    	postName = '<fmt:message key="post.junoirengineer.electrical.junior" />';
	                        	        break;
	                        	    case 15:
	                        	    	postName = '<fmt:message key="post.assistant.workshop.superintendent.junior" />';
	                        	        break;
	                        	    case 16:
	                        	    	postName = '<fmt:message key="post.chargeman.junior" />';
	                        	    	break;
	                        	    case 17:
	                        	    	postName = '<fmt:message key="post.draftsman.junior" />';
	                        	        break;
	                        	    case 18:
	                        	    	postName = '<fmt:message key="post.senior.computeroperator.junior" />';
	                        	        break;
	                        	    case 19:
	                        	    	postName = '<fmt:message key="post.general.manager.project" />';
	                        	    	break;
	                        	    case 20:
	                        	    	postName = '<fmt:message key="post.general.manager.project.informationTechnology" />';
	                        	        break;
	                        	    case 21:
	                        	    	postName = '<fmt:message key="post.driver.conductor" />';
	                        	        break;
                                    case 22:
                                        postName = '<fmt:message key="post.division.controller" />';
                                        break;
                                    case 23:
                                        postName = '<fmt:message key="post.machineEngineer" />';
                                        break;
                                    case 24:
                                        postName = '<fmt:message key="post.departmentalTransportOfficer" />';
                                        break;
                                    case 25:
                                        postName = '<fmt:message key="post.deputyEquipmentEngineer" />';
                                        break;
                                    case 26:
                                        postName = '<fmt:message key="post.accountingOfficer" />';
                                        break;
                                    case 27:
                                        postName = '<fmt:message key="post.storeOfficer" />';
                                        break;
                                    case 28:
                                        postName = '<fmt:message key="post.divisionalTransportSuperintendent" />';
                                        break;
                                    case 29:
                                        postName = '<fmt:message key="post.assistantEquipmentEngineer" />';
                                        break;
                                    case 30:
                                        postName = '<fmt:message key="post.departmentalAccountsOfficer" />';
                                        break;
                                    case 31:
                                        postName = '<fmt:message key="post.departmentalStatisticsOfficer" />';
                                        break;
	                        	}
                        		
                                if (!errorsDTO.postSubmissionErrorsDTOList[ i ].formValid) {
                                	subMessageHtml = subMessageHtml + '<li class="list-group-item">' + '<fmt:message key="confirmation.post.formNotSave"><fmt:param value="' + postName +'"/></fmt:message>' + '</li>';
                                }
                                if (!errorsDTO.postSubmissionErrorsDTOList[ i ].prioritySet) {
                                	subMessageHtml = subMessageHtml + '<li class="list-group-item">' + '<fmt:message key="confirmation.post.priorityNotSet"><fmt:param value="' + postName +'"/></fmt:message>' + '</li>';
                                }
                            }
                        }
                        
                        subMessageHtml = subMessageHtml + '</ul>';
                        
                        messageHtml = messageHtml + subMessageHtml;
                        
                        messageHtml =  messageHtml + '</ul> ';

                        if(!errorsDTO.prioritySet) {
                        	messageHtml = messageHtml + '<div class="alert alert-danger" id="setPriorityInstructionDiv"><fmt:message key="setpriority.resolve.error.instruction"/></div>';
                        }
                        
                        bootbox.dialog({
                            title: i18n("submission.errors"),
                            message: messageHtml,
                            buttons: {
                                success: {
                                    label: i18n("close"),
                                    className: "btn-success",
                                },
                            }
                        });
                    }
                } else {
                    commonObj.showAlert("There was some error while processing your request.");
                }
            }
        });
    }

    function confirmCheckBoxAction()
    {
    	if(jQuery('input[id=confirmCheckBoxId]').is(':checked')){
    		confirmSubmission();
  		 }else{
  			 commonObj.showAlert("<fmt:message key="confirmation.notCheckedTermsConditions" />"); 			 
  		 }
    }
    
</script>

<form class="form-horizontal" id="confirmApplicationForm">
<div class="form-group">
	<div class="col-sm-12">
		<ul class="list-group">
		<c:forEach items="${applicantPostAssocList }" var="applicantPostAssoc">
		<%-- <c:if test="${applicantPostAssoc.status ne 2 }"> --%>
			<a href="javascript:void(0);" onclick="javascript:applyObj.viewPostDetails('${ applicantPostAssoc.id  }', '<fmt:message key="${applicantPostAssoc.post.messageKey }"/>');" class="list-group-item">
				<fmt:message key="${applicantPostAssoc.post.messageKey }"/>
			</a>
		<%-- </c:if> --%>
		</c:forEach>
	</div>
</div>

<div class="form-group">
	<div class="col-sm-1">
		<input type="checkbox" checked="checked" id="confirmCheckBoxId">
	</div>
	<div class="col-sm-11">
		<fmt:message key='undertaking' />
	</div>
</div>

<div class="form-group">
	<nav class="navbar btn-toolbar sw-toolbar sw-toolbar-bottom">
		<div class="btn-group navbar-btn sw-btn-group pull-right" role="group">
			<c:if test="${!disableFormAfterLastDateOver}">

				<c:choose>
					<c:when test="${ disablePayments eq 1 or disablePayments eq '1' }">
						<button  onclick="javascript:commonObj.goToURL('<c:url value="/applicant?operation=applicantDashboard&menu=applicantDashboard"/>')" class="btn btn-default sw-btn-next" type="button"><fmt:message key="confirm" /></button>
					</c:when>
					<c:otherwise>
						<button onclick="javascript:confirmCheckBoxAction();" class="btn btn-default sw-btn-next" type="button"><fmt:message key="confirm" /></button>
					</c:otherwise>
				</c:choose>

			</c:if>
			<button onclick="javascript:commonObj.goToURL('<c:url value="/applicant?operation=applicantDashboard&menu=applicantDashboard"/>')" class="btn btn-default sw-btn-next skipDisabling" type="button"><fmt:message key="cancel" /></button>
			<c:if test="${!disableFormAfterLastDateOver}">
				<button onclick="javascript:applyObj.gotoTab('1')"  class="btn btn-default sw-btn-next" type="button"><fmt:message key="modify" /></button>
			</c:if>
		</div>
	</nav>
</div>

</form>
<%--

<div class="row">
    <div class="col-md-4">
        <c:forEach items="${applicantPostAssocList }" var="applicantPostAssoc">
            <a href="javascript:void(0);" onclick="javascript:applyObj.viewPostDetails('${ applicantPostAssoc.id  }', '<fmt:message key="${applicantPostAssoc.post.messageKey }"/>');"><fmt:message key="${applicantPostAssoc.post.messageKey }"/></a>
        </c:forEach>
    </div>
</div>

<div class="row">
	<form class="form-horizontal col-md-12"
		  name="applicantFilesForm"
		  id="applicantFilesForm"
		  data-toggle="validator"
		  action="<c:url value='/applicant?operation=saveApplicantFiles'/>"
		  method="POST">

		<div class="form-group">
			<div class="col-sm-1">
				<input type="checkbox">
			</div>
			<div class="col-sm-11">
				<fmt:message key='undertaking' />
			</div>
		</div>

		<nav class="navbar btn-toolbar sw-toolbar sw-toolbar-bottom">
			<div class="btn-group navbar-btn sw-btn-group pull-right" role="group">
				<button onclick="javascript:confirmSubmission();" class="btn btn-default sw-btn-next" type="button"><fmt:message key="confirm" /></button>
				<button onclick="javascript:commonObj.goToURL('<c:url value="/applicant?operation=applicantDashboard&menu=applicantDashboard"/>')" class="btn btn-default sw-btn-next" type="button"><fmt:message key="cancel" /></button>
				<button class="btn btn-default sw-btn-next" type="button"><fmt:message key="modify" /></button>
			</div>
		</nav>

		<br>
		<br>
	</form>
</div>
--%>
