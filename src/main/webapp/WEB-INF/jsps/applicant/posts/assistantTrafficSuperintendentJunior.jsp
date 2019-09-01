<%@ include file="../../common/taglibs.jsp"%>

<script>
	$(document).ready(function() {

		postSelectionObj.disableFormFields ("assistantTrafficSuperintendentJuniorForm", '${applicantPostAssoc.status}');
	    postSelectionObj.bindPostForm("assistantTrafficSuperintendentJuniorForm");
	    
	    postSelectionObj.validateDate('assistantTrafficSuperintendent-heavyDrivingLicenseIssueDate','assistantTrafficSuperintendent-heavyDrivingLicenseEndDate');
	    
	   $('#assistantTrafficSuperintendent-heavyDrivingLicenseIssueDate').datetimepicker({
           format: 'DD/MM/YYYY',
           ignoreReadonly: true,
           showTodayButton: true,
           minDate: postSelectionObj.minDate(),
           maxDate: postSelectionObj.maxDate()
           //date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseIssueDate}" />'
       });
       $('#assistantTrafficSuperintendent-calendarIcon-heavyDrivingLicenseIssueDate').click(function() {
           $('#assistantTrafficSuperintendent-heavyDrivingLicenseIssueDate').data("DateTimePicker").show();
       });
		
	   $('#assistantTrafficSuperintendent-heavyDrivingLicenseEndDate').datetimepicker({
           format: 'DD/MM/YYYY',
           ignoreReadonly: true,
           showTodayButton: true,
           minDate: postSelectionObj.minDate(),
           maxDate: postSelectionObj.maxDate()
           //date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseEndDate}" />'
       });
       $('#assistantTrafficSuperintendent-calendarIcon-heavyDrivingLicenseEndDate').click(function() {
           $('#assistantTrafficSuperintendent-heavyDrivingLicenseEndDate').data("DateTimePicker").show();
       });
	
		checkIfShowOrHideElements();

		var date = '${applicantPostAssoc.heavyDrivingLicenseIssueDate}';
		if(date != 'undefined' || date != null || data !='' )
			$('#assistantTrafficSuperintendent-heavyDrivingLicenseIssueDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseIssueDate}" />');
		
		date = '${applicantPostAssoc.heavyDrivingLicenseEndDate}';
		if(date != 'undefined' || date != null || data !='' )
		 { 
			$('#assistantTrafficSuperintendent-heavyDrivingLicenseEndDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseEndDate}" />');
		 }
		var lastDateOver = commonObj.isValidate(${disableFormAfterLastDateOver});
	    commonObj.disableFormFields("assistantTrafficSuperintendentJuniorForm",lastDateOver);
	});
	
	function checkIfShowOrHideElements() {
		if ('${applicantPostAssoc.graduateFromAffiliatedInstitute}' == '' || '${applicantPostAssoc.graduateFromAffiliatedInstitute}' == 'false') {
			postSelectionObj.hideElementsByClass('assistantTrafficSuperintendentGraduateFromAffiliatedInstituteToggle');
		}
		
		if ('${applicantPostAssoc.twoYearExpAsTransportAssociation}' == '' || '${applicantPostAssoc.twoYearExpAsTransportAssociation}' == 'false') {
			postSelectionObj.hideElementsByClass('assistantTrafficSuperintendentTwoYearExpAsTransportAssociationToggle');
		}
		if ('${applicantPostAssoc.ownHeavyDrivingLicenseNumber}' == '' || '${applicantPostAssoc.ownHeavyDrivingLicenseNumber}' == 'false') {
			postSelectionObj.hideElementsByClass('assistantTrafficSuperintendentOwnHeavyDrivingLicenseToggle');
		}
	}
	
	$( 'form#assistantTrafficSuperintendentJuniorForm' ).find('input[type=radio][name=graduateFromAffiliatedInstitute]').unbind().change(function() {
        if (this.value == '1') {
       	 	postSelectionObj.showElementsByClass('assistantTrafficSuperintendentGraduateFromAffiliatedInstituteToggle');
        } else {
	       	postSelectionObj.hideElementsByClass('assistantTrafficSuperintendentGraduateFromAffiliatedInstituteToggle');
	       	postSelectionObj.resetTextFieldById('assistantTrafficSuperintendent-degreeName');
	       	postSelectionObj.resetTextFieldById('assistantTrafficSuperintendent-universityName');
	       	postSelectionObj.resetTextFieldById('assistantTrafficSuperintendent-RequiredQualificationMarks');
        }
    });
	
	$( 'form#assistantTrafficSuperintendentJuniorForm' ).find('input[type=radio][name=twoYearExpAsTransportAssociation]').unbind().change(function() {
        if (this.value == '1') {
       	 	postSelectionObj.showElementsByClass('assistantTrafficSuperintendentTwoYearExpAsTransportAssociationToggle');
        } else {
	    	postSelectionObj.hideElementsByClass('assistantTrafficSuperintendentTwoYearExpAsTransportAssociationToggle');
	       	postSelectionObj.resetTextFieldById('assistantTrafficSuperintendent-companyName');
	       	postSelectionObj.resetTextFieldById('assistantTrafficSuperintendent-totalExperienceInYears');
	       	postSelectionObj.resetTextFieldById('assistantTrafficSuperintendent-motalExperienceInMonths');
        }
    });
	
	$( 'form#assistantTrafficSuperintendentJuniorForm' ).find('input[type=radio][name=ownHeavyDrivingLicenseNumber]').unbind().change(function() {
        if (this.value == '1') {
       	 	postSelectionObj.showElementsByClass('assistantTrafficSuperintendentOwnHeavyDrivingLicenseToggle');
        } else {
	       	postSelectionObj.hideElementsByClass('assistantTrafficSuperintendentOwnHeavyDrivingLicenseToggle');
	       	postSelectionObj.resetTextFieldById('assistantTrafficSuperintendent-heavyDrivingLicenseNumber');
	       	postSelectionObj.resetTextFieldById('assistantTrafficSuperintendent-heavyDrivingLicenseIssueDate');
	       	postSelectionObj.resetTextFieldById('assistantTrafficSuperintendent-heavyDrivingLicenseEndDate');
            //commonObj.showAlert("<fmt:message key='heavyDrivingLicenseNumber.onNoSelect.alert' />");
	       	commonObj.showAgreeDisAgreePopup("<fmt:message key='heavyDrivingLicenseNumber.onNoSelect.alert' />", asstTrafficAgreeDisAgreePopup, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));

        }
    });
	
	function asstTrafficAgreeDisAgreePopup(flag)
	{
		if(!flag)
		{
			$('#assistantTrafficSuperintendent-ownHeavyDrivingLicenseNumber-yes').prop('checked', true);
			$('.assistantTrafficSuperintendentOwnHeavyDrivingLicenseToggle').attr("required", true);
			postSelectionObj.showElementsByClass('assistantTrafficSuperintendentOwnHeavyDrivingLicenseToggle');
			postSelectionObj.resetTextFieldById('assistantTrafficSuperintendent-heavyDrivingLicenseNumber');
	       	postSelectionObj.resetTextFieldById('assistantTrafficSuperintendent-heavyDrivingLicenseIssueDate');
	       	postSelectionObj.resetTextFieldById('assistantTrafficSuperintendent-heavyDrivingLicenseEndDate');
			
	   	 	//postSelectionObj.showElementsByClass('conductorLightMotorVechicleToggle');
	   	 	//resetFieldsAndAttributes(['conductor-lightMotorVechicleLicenseNo', 'conductor-lightMotorVechicleIssueDate'], true);
		}
	}
	
	function viewFileMscit(part) {
		//var url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/Important_Instructions_to_the_Candidate.pdf'/>";
		if(part == 1 || part == '1'){
		var url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/mscit1.pdf'/>";
		window.open(url,'_blank');
		}else if(part == 2 || part == '2'){
			var url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/mscit2.pdf'/>";
			window.open(url,'_blank');
		}
	}
	
$( 'form#assistantTrafficSuperintendentJuniorForm' ).find('input[type=radio][name=mscitOrGaccc]').unbind().change(function() {
    	
    	if(this.value == '0'){
    		 commonObj.showAgreeDisAgreePopup("<fmt:message key='mscit.equivalent.computer.certificate.alert' />", mscitCertificatePopUpAssistantTrafficSuperintendent, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
    	     
    	}
    });
    
    function mscitCertificatePopUpAssistantTrafficSuperintendent(flag)
    {
    	if(!flag)
    	{
    		$('#assistantTrafficSuperintendent-mscitOrGaccc-yes').prop('checked', true);
      	}
    }
	
	</script>   
	 <div id="downloadEligibilityCriteria" class="form-group" align="right">
	        <div class="col-sm-12" align="pull-right">
	            <a href="javascript:void(0);" onclick="javascript:showEligibilityCriteriaPDF(${post.postId})"><b><fmt:message key="postEligibilityCriteriaLink"/></b></a>
	        </div>
	    </div>

<form class="form-horizontal" name="assistantTrafficSuperintendentJuniorForm" id="assistantTrafficSuperintendentJuniorForm" data-toggle="validator" action="<c:url value='/applicant?operation=saveApplicantPostDetails'/>" method="POST">

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${applicantPostAssoc.id}"/>
    <input type="hidden" name="postId" value="${post.postId}"/>
    <input type="hidden" name="status" id="status"  value="${ applicantPostAssoc.status }"/>
    
    <div class="form-group">
        <label class="control-label col-sm-5" for="graduateFromAffiliatedInstitute"><fmt:message key="assistantTrafficSuperintendent.graduateFromAffiliatedInstitute"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="graduateFromAffiliatedInstitute" id="assistantTrafficSuperintendent-graduateFromAffiliatedInstitute-yes" value="1" type="radio" ${applicantPostAssoc.graduateFromAffiliatedInstitute ? 'checked' : ''} />
                <label for="assistantTrafficSuperintendent-graduateFromAffiliatedInstitute-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="graduateFromAffiliatedInstitute" id="assistantTrafficSuperintendent-graduateFromAffiliatedInstitute-no" value="0" type="radio" ${applicantPostAssoc.graduateFromAffiliatedInstitute == false ? 'checked' : ''} />
                <label for="assistantTrafficSuperintendent-graduateFromAffiliatedInstitute-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    
    <div class="form-group assistantTrafficSuperintendentGraduateFromAffiliatedInstituteToggle">
        <label class="control-label col-sm-5" for="assistantTrafficSuperintendent-degreeName"><fmt:message key="assistantTrafficSuperintendent.graduateFromAffiliatedInstitute.degreeName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.degreeName}" type="text" class="form-control" id="assistantTrafficSuperintendent-degreeName" placeholder="<fmt:message key="assistantTrafficSuperintendent.graduateFromAffiliatedInstitute.degreeName"/>" name="degreeName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group assistantTrafficSuperintendentGraduateFromAffiliatedInstituteToggle">
        <label class="control-label col-sm-5" for="assistantTrafficSuperintendent-universityName"><fmt:message key="assistantTrafficSuperintendent.graduateFromAffiliatedInstitute.universityName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.universityName}" type="text" class="form-control" id="assistantTrafficSuperintendent-universityName" placeholder="<fmt:message key="assistantTrafficSuperintendent.graduateFromAffiliatedInstitute.universityName"/>" name="universityName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group assistantTrafficSuperintendentGraduateFromAffiliatedInstituteToggle">
     	<label class="control-label col-sm-5" for="assistantTrafficSuperintendent-RequiredQualificationMarks"><fmt:message key="driverCumConductor.required.qualification.marks.obtained"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.requiredQualificationMarks}" type="number" class="form-control" id="assistantTrafficSuperintendent-RequiredQualificationMarks" placeholder="<fmt:message key="driverCumConductor.required.qualification.marks.obtained"/>" name="requiredQualificationMarks" maxlength="5" min="1" max="100">
            <div class="help-block with-errors"></div>
        </div>
     </div>
    
  <%--   <div class="form-group">
        <label class="control-label col-sm-5" for="assistantTrafficSuperintendent-otherQualificationDetails"><fmt:message key="assistantTrafficSuperintendent.otherQualificationDetails"/>:</label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.otherQualificationDetails}" type="text" class="form-control" id="assistantTrafficSuperintendent-otherQualificationDetails" placeholder="<fmt:message key="assistantTrafficSuperintendent.otherQualificationDetails"/>" name="otherQualificationDetails" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div> --%>
    
    <div class="form-group">
        <label class="control-label col-sm-5" for="height"><fmt:message key="assistantTrafficSuperintendent.mscitOrGaccc"/>: <span class="red">*&nbsp;&nbsp;##</span><a href="javascript:void(0);" onclick="javascript:viewFileMscit(1)" style="font-size: 9px; font-style: italic"><fmt:message key="post.mscit.one"/></a>&nbsp;&nbsp; 
        <a href="javascript:void(0);" onclick="javascript:viewFileMscit(2)" style="font-size: 9px; font-style: italic"><fmt:message key="post.mscit.two"/></a></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="mscitOrGaccc" id="assistantTrafficSuperintendent-mscitOrGaccc-yes" value="1" type="radio" ${applicantPostAssoc.mscitOrGaccc ? 'checked' : ''} />
                <label for="assistantTrafficSuperintendent-mscitOrGaccc-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input  name="mscitOrGaccc" id="assistantTrafficSuperintendent-mscitOrGaccc-no" value="0" type="radio" ${applicantPostAssoc.mscitOrGaccc == false ? 'checked' : ''} />
                <label for="assistantTrafficSuperintendent-mscitOrGaccc-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group">
        <label class="control-label col-sm-5" for="height"><fmt:message key="assistantTrafficSuperintendent.heightWithinRange"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="heightWithinRange" id="assistantTrafficSuperintendent-heightWithinRange-yes" value="1" type="radio" ${applicantPostAssoc.heightWithinRange ? 'checked' : ''} />
                <label for="assistantTrafficSuperintendent-heightWithinRange-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="heightWithinRange" id="assistantTrafficSuperintendent-heightWithinRange-no" value="0" type="radio" ${applicantPostAssoc.heightWithinRange == false ? 'checked' : ''} />
                <label for="assistantTrafficSuperintendent-heightWithinRange-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group">
        <label class="control-label col-sm-5" for="twoYearExpAsTransportAssociation"><fmt:message key="assistantTrafficSuperintendent.twoYearExpAsTransportAssociation"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="twoYearExpAsTransportAssociation" id="assistantTrafficSuperintendent-twoYearExpAsTransportAssociation-yes" value="1" type="radio" ${applicantPostAssoc.twoYearExpAsTransportAssociation ? 'checked' : ''} />
                <label for="assistantTrafficSuperintendent-twoYearExpAsTransportAssociation-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="twoYearExpAsTransportAssociation" id="assistantTrafficSuperintendent-twoYearExpAsTransportAssociation-no" value="0" type="radio" ${applicantPostAssoc.twoYearExpAsTransportAssociation == false ? 'checked' : ''} />
                <label for="assistantTrafficSuperintendent-twoYearExpAsTransportAssociation-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group assistantTrafficSuperintendentTwoYearExpAsTransportAssociationToggle">
        <label class="control-label col-sm-5" for="assistantTrafficSuperintendent-companyName"><fmt:message key="assistantTrafficSuperintendent.experienced.companyName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.companyName}" type="text" class="form-control" id="assistantTrafficSuperintendent-companyName" placeholder="<fmt:message key="assistantTrafficSuperintendent.experienced.companyName"/>" name="companyName"  maxlength="150">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group assistantTrafficSuperintendentTwoYearExpAsTransportAssociationToggle">
        <label class="control-label col-sm-5" for="assistantTrafficSuperintendent-totalExperienceInYears"><fmt:message key="assistantTrafficSuperintendent.experienced.totalExperience"/>: <span class="red">*</span></label>
        <div class="col-sm-2">
            <input value="${applicantPostAssoc.totalExperienceInYears}" type="tel" class="form-control" id="assistantTrafficSuperintendent-totalExperienceInYears" placeholder="<fmt:message key="assistantTrafficSuperintendent.experienced.totalExperienceInYears"/>" name="totalExperienceInYears"  min="0" maxlength="2">
            <div class="help-block with-errors"></div>
        </div>
        <div class="col-sm-2">
            <input value="${applicantPostAssoc.totalExperienceInMonths}" type="tel" class="form-control" id="assistantTrafficSuperintendent-motalExperienceInMonths" placeholder="<fmt:message key="assistantTrafficSuperintendent.experienced.totalExperienceInMonths"/>" name="totalExperienceInMonths"  min="0" maxlength="2">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group">
        <label class="control-label col-sm-5" for="ownHeavyDrivingLicenseNumber"><fmt:message key="assistantTrafficSuperintendent.ownHeavyDrivingLicenseNumber"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="ownHeavyDrivingLicenseNumber" id="assistantTrafficSuperintendent-ownHeavyDrivingLicenseNumber-yes" value="1" type="radio" ${applicantPostAssoc.ownHeavyDrivingLicenseNumber ? 'checked' : ''} />
                <label for="assistantTrafficSuperintendent-ownHeavyDrivingLicenseNumber-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <%-- <input class="radiosToCheck" name="ownHeavyDrivingLicenseNumber" id="assistantTrafficSuperintendent-ownHeavyDrivingLicenseNumber-no" value="0" type="radio" ${applicantPostAssoc.ownHeavyDrivingLicenseNumber == false ? 'checked' : ''} /> --%>
                <input name="ownHeavyDrivingLicenseNumber" id="assistantTrafficSuperintendent-ownHeavyDrivingLicenseNumber-no" value="0" type="radio" ${applicantPostAssoc.ownHeavyDrivingLicenseNumber == false ? 'checked' : ''} />
                <label for="assistantTrafficSuperintendent-ownHeavyDrivingLicenseNumber-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group assistantTrafficSuperintendentOwnHeavyDrivingLicenseToggle">
        <label class="control-label col-sm-5" for="assistantTrafficSuperintendent-heavyDrivingLicenseNumber"><fmt:message key="assistantTrafficSuperintendent.ownHeavyDrivingLicenseNumber.number"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.heavyDrivingLicenseNumber}" type="text" class="form-control" id="assistantTrafficSuperintendent-heavyDrivingLicenseNumber" placeholder="<fmt:message key="assistantTrafficSuperintendent.ownHeavyDrivingLicenseNumber.number"/>" name="heavyDrivingLicenseNumber" maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group assistantTrafficSuperintendentOwnHeavyDrivingLicenseToggle">
        <label class="control-label col-sm-5" for="assistantTrafficSuperintendent-calendarIcon-heavyDrivingLicenseIssueDate"><fmt:message key="assistantTrafficSuperintendent.ownHeavyDrivingLicenseNumber.issueDate"/>: <span class="red">*</span></label>
        <div class="col-sm-3">
        	<div class="input-group date">
	            <input type="datetime" class="form-control" id="assistantTrafficSuperintendent-heavyDrivingLicenseIssueDate" placeholder="<fmt:message key="assistantTrafficSuperintendent.ownHeavyDrivingLicenseNumber.issueDate"/>" name="heavyDrivingLicenseIssueDate" readonly >
	            <div class="input-group-addon" id="assistantTrafficSuperintendent-calendarIcon-heavyDrivingLicenseIssueDate">
					<i class="fa fa-calendar"></i>
				</div>
	            <div class="help-block with-errors"></div>
            </div>
        </div>
   </div>
   <div class="form-group assistantTrafficSuperintendentOwnHeavyDrivingLicenseToggle">
        <label class="control-label col-sm-5" for="assistantTrafficSuperintendent-heavyDrivingLicenseEndDate"><fmt:message key="assistantTrafficSuperintendent.ownHeavyDrivingLicenseNumber.endDate"/>: <span class="red">*</span></label>
        <div class="col-sm-3">
        	<div class="input-group date">
	            <input type="datetime" class="form-control" id="assistantTrafficSuperintendent-heavyDrivingLicenseEndDate" placeholder="<fmt:message key="assistantTrafficSuperintendent.ownHeavyDrivingLicenseNumber.endDate"/>" name="heavyDrivingLicenseEndDate" readonly >
	            <div class="input-group-addon" id="assistantTrafficSuperintendent-calendarIcon-heavyDrivingLicenseEndDate">
					<i class="fa fa-calendar"></i>
				</div>
	            <div class="help-block with-errors"></div>
            </div>
        </div>
    </div>
    
    <jsp:include page="postFooter.jsp">
    	<jsp:param name="isPostSubmitted" value="${ applicantPostAssoc.status eq 2 || applicantPostAssoc.status eq 3 }"/>
    	<jsp:param name="formId" value="assistantTrafficSuperintendentJuniorForm"/>
		<jsp:param name="postId" value="${post.postId}"/>
		<jsp:param name="disableFormAfterLastDateOver" value="${disableFormAfterLastDateOver}"/>
	</jsp:include>
</form>

<script>
 $(document).ready(function(){
 $("form[name='assistantTrafficSuperintendentJuniorForm']").validate({
	 //ignore : "#assitWSHeavyDrivingLicenseIssueDate, #assitWSHeavyDrivingLicenseEndDate",
 	rules:{
 		 graduateFromAffiliatedInstitute : "required",
 		 degreeName: {required: true},
 		 universityName: {required: true},
 		requiredQualificationMarks:{required: true , min:35},
 		 mscitOrGaccc : "required",
 		 heightWithinRange : "required",
 		 twoYearExpAsTransportAssociation : "required",
 		 companyName : {required: true},
 		 totalExperienceInYears :{required: true, numbersonly:true, min : 2, max:100},
 		 totalExperienceInMonths :{required: true, numbersonly:true, max: 11},
 		 ownHeavyDrivingLicenseNumber : "required",
 		 heavyDrivingLicenseNumber : {required: true},
 		 
 		 heavyDrivingLicenseEndDate : {required: true},
 		 heavyDrivingLicenseIssueDate : {required: true}
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
 