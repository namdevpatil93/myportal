<%@ include file="../../common/taglibs.jsp"%>


<script type="text/javascript">

$(document).ready(function() 
{
	postSelectionObj.disableFormFields ("trafficInspectorJuniorForm", '${applicantPostAssoc.status}');
	
	postSelectionObj.bindPostForm("trafficInspectorJuniorForm");

	postSelectionObj.validateDate('trafficInspectorJuniorHeavyDrivingLicenseIssueDate', 'trafficInspectorJuniorHeavyDrivingLicenseEndDate');
	
	showSelectedOptions();
	var lastDateOver = commonObj.isValidate(${disableFormAfterLastDateOver});
    commonObj.disableFormFields("trafficInspectorJuniorForm",lastDateOver);
});

	function showSelectedOptions()
	{
		if('${applicantPostAssoc.graduateFromAffiliatedInstitute}' == "true" || '${applicantPostAssoc.graduateFromAffiliatedInstitute}' == true)
		{
			postSelectionObj.showElementsByClass('trafficInspectorJuniorDegreeNameToggle');
			postSelectionObj.showElementsByClass('trafficInspectorJuniorgraduateFromAffiliatedInstituteToggle');
		}
		else
		{
			postSelectionObj.hideElementsByClass('trafficInspectorJuniorgraduateFromAffiliatedInstituteToggle');
        	postSelectionObj.hideElementsByClass('trafficInspectorJuniorDegreeNameToggle');
		}
		if('${ applicantPostAssoc.oneYearExpAsTransportAssociation}' == "true" || '${ applicantPostAssoc.oneYearExpAsTransportAssociation}' == true)
		{
			postSelectionObj.showElementsByClass('trafficInspectorJuniorExperiencedToggle');
		}
		else
		{
			postSelectionObj.hideElementsByClass('trafficInspectorJuniorExperiencedToggle');
		}
		
		if('${ applicantPostAssoc.ownHeavyDrivingLicenseNumber}' == "true" || '${ applicantPostAssoc.ownHeavyDrivingLicenseNumber}' == true)
		{
			postSelectionObj.showElementsByClass('trafficInspectorJuniorOwnHeavyDrivingLicenseToggle');
		}
		else
		{
			postSelectionObj.hideElementsByClass('trafficInspectorJuniorOwnHeavyDrivingLicenseToggle');
		}
		
			$('#trafficInspectorJuniorHeavyDrivingLicenseIssueDate').datetimepicker({
		         format: 'DD/MM/YYYY',
		         ignoreReadonly: true,
		         showTodayButton: true,
		         minDate: postSelectionObj.minDate(),
		         maxDate: postSelectionObj.maxDate()
		         //date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseIssueDate}" />'
		     });
			 $('#trafficInspectorJuniorCalendarIconHeavyDrivingLicenseIssueDate').click(function() {
		         $('#trafficInspectorJuniorHeavyDrivingLicenseIssueDate').data("DateTimePicker").show();
		     });
		
			$('#trafficInspectorJuniorHeavyDrivingLicenseEndDate').datetimepicker({
		         format: 'DD/MM/YYYY',
		         ignoreReadonly: true,
		         showTodayButton: true,
		         minDate: postSelectionObj.minDate(),
		         maxDate: postSelectionObj.maxDate()
		         //date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseEndDate}" />'
		     });
			 $('#trafficInspectorJuniorCalendarIconHeavyDrivingLicenseEndDate').click(function() {
		         $('#trafficInspectorJuniorHeavyDrivingLicenseEndDate').data("DateTimePicker").show();
		     });

			var date = '${applicantPostAssoc.heavyDrivingLicenseIssueDate}';
			if(date != 'undefined' || date != null || data !='' )
				$('#trafficInspectorJuniorHeavyDrivingLicenseIssueDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseIssueDate}" />');
			
			date = '${applicantPostAssoc.heavyDrivingLicenseEndDate}';
			if(date != 'undefined' || date != null || data !='' )
				$('#trafficInspectorJuniorHeavyDrivingLicenseEndDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseEndDate}" />');
	}	

	$( 'form#trafficInspectorJuniorForm' ).find('input[type=radio][name=mscitOrGaccc]').unbind().change(function() {
        if (this.value == '0') {
//         	postSelectionObj.notEligiblePopup();
        }
    });
	
	$( 'form#trafficInspectorJuniorForm' ).find('input[type=radio][name=heightWithinRange]').unbind().change(function() {
        if (this.value == '0') {
//         	postSelectionObj.notEligiblePopup();
        }
    });
	
	
	$( 'form#trafficInspectorJuniorForm' ).find('input[type=radio][name=graduateFromAffiliatedInstitute]').unbind().change(function() {
        if (this.value == '1') 
        {
        	$('#trafficInspectorJunior-DegreeName').attr("required", true);
        	$('#trafficInspectorJunior-UniversityName').attr("required", true);
       	 	postSelectionObj.showElementsByClass('trafficInspectorJuniorDegreeNameToggle');
       	 	postSelectionObj.showElementsByClass('trafficInspectorJuniorgraduateFromAffiliatedInstituteToggle');
       	 
        } 
        else 
        {
        	$('#trafficInspectorJunior-DegreeName').attr("required", false);
        	$('#etrafficInspectorJunior-UniversityName').attr("required", false);
        	postSelectionObj.resetTextFieldById('trafficInspectorJunior-DegreeName');
        	postSelectionObj.resetTextFieldById('trafficInspectorJunior-UniversityName');
        	postSelectionObj.hideElementsByClass('trafficInspectorJuniorgraduateFromAffiliatedInstituteToggle');
        	postSelectionObj.hideElementsByClass('trafficInspectorJuniorDegreeNameToggle');
//        		postSelectionObj.notEligiblePopup();
        }
    });
	
	$( 'form#trafficInspectorJuniorForm' ).find('input[type=radio][name=oneYearExpAsTransportAssociation]').unbind().change(function() {
        if (this.value == '1') 
        {
        	$('#trafficInspector-TotalExperienceInYears').attr("required", true);
        	$('#trafficInspector-TotalExperienceInMonths').attr("required", true);
        	$('#trafficInspectorJunior-CompanyName').attr("required", true);
       		 postSelectionObj.showElementsByClass('trafficInspectorJuniorExperiencedToggle');
        } 
        else 
        {
        	$('#trafficInspector-TotalExperienceInYears').attr("required", false);
        	$('#trafficInspector-TotalExperienceInMonths').attr("required", false);
        	$('#trafficInspectorJunior-CompanyName').attr("required", false);
        	postSelectionObj.resetTextFieldById('trafficInspector-TotalExperienceInYears');
        	postSelectionObj.resetTextFieldById('trafficInspector-TotalExperienceInMonths');
        	postSelectionObj.resetTextFieldById('trafficInspectorJunior-CompanyName');
        	postSelectionObj.hideElementsByClass('trafficInspectorJuniorExperiencedToggle');
//        		postSelectionObj.notEligiblePopup();
        }
    });
	
	$( 'form#trafficInspectorJuniorForm' ).find('input[type=radio][name=ownHeavyDrivingLicenseNumber]').unbind().change(function() {
        if (this.value == '1') {
        	$('#trafficInspectorJuniorHeavyDrivingLicenseNumber').attr("required", true);
        	 postSelectionObj.showElementsByClass('trafficInspectorJuniorOwnHeavyDrivingLicenseToggle');
        }
        else
        {
        	$('#trafficInspectorJuniorHeavyDrivingLicenseNumber').attr("required", false);
        	postSelectionObj.resetTextFieldById('trafficInspectorJuniorHeavyDrivingLicenseNumber');
        	postSelectionObj.resetTextFieldById('trafficInspectorJuniorHeavyDrivingLicenseIssueDate');
        	postSelectionObj.resetTextFieldById('trafficInspectorJuniorHeavyDrivingLicenseEndDate');
        	postSelectionObj.hideElementsByClass('trafficInspectorJuniorOwnHeavyDrivingLicenseToggle');
            //commonObj.showAlert("<fmt:message key='heavyDrivingLicenseNumber.onNoSelect.alert' />");
            commonObj.showAgreeDisAgreePopup("<fmt:message key='heavyDrivingLicenseNumber.onNoSelect.alert' />", trafficInspectorJuniorAgreeDisAgreePopup, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
        }
    });
	function trafficInspectorJuniorAgreeDisAgreePopup(flag)
	{
	   	if(!flag)
	   	{
	   		$('#trafficInspectorJunior-ownHeavyDrivingLicenseNumber-yes').prop('checked', true);
	   		$('#trafficInspectorJuniorHeavyDrivingLicenseNumber').attr("required", true);
       	 	postSelectionObj.showElementsByClass('trafficInspectorJuniorOwnHeavyDrivingLicenseToggle');
	   		postSelectionObj.resetTextFieldById('trafficInspectorJuniorHeavyDrivingLicenseNumber');
        	postSelectionObj.resetTextFieldById('trafficInspectorJuniorHeavyDrivingLicenseIssueDate');
        	postSelectionObj.resetTextFieldById('trafficInspectorJuniorHeavyDrivingLicenseEndDate');
			
	   	}
	}
	
	</script>   
	 <div id="downloadEligibilityCriteria" class="form-group" align="right">
	        <div class="col-sm-12" align="pull-right">
	            <a href="javascript:void(0);" onclick="javascript:showEligibilityCriteriaPDF(${post.postId})"><b><fmt:message key="postEligibilityCriteriaLink"/></b></a>
	        </div>
	    </div>

<form class="form-horizontal" name="trafficInspectorJuniorForm" id="trafficInspectorJuniorForm" action="<c:url value='/applicant?operation=saveApplicantPostDetails'/>" method="POST" style="z-index:0;">

	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="hidden" name="id" value="${applicantPostAssoc.id}"/>
	<input type="hidden" name="postId" value="${post.postId}"/>
	<input type="hidden" name="status" id="status"  value="${ applicantPostAssoc.status }"/>

	<div class="form-group">
		<label class="control-label col-sm-5"><fmt:message key="trafficInspectorJunior.graduateFromAffiliatedInstitute"/>: <span class="red">*</span></label>
		<div class="col-sm-4">
			<div class="radio radio-inline">
				<input name="graduateFromAffiliatedInstitute" ${ applicantPostAssoc.graduateFromAffiliatedInstitute ? 'checked="checked"':''} id="trafficInspectorJunior-graduateFromAffiliatedInstitute-yes" value="1" type="radio"/>
				<label for="trafficInspectorJunior-graduateFromAffiliatedInstitute-yes"> <fmt:message key="yes"/> </label>
			</div>
			<div class="radio radio-inline">
				<input class="radiosToCheck" name="graduateFromAffiliatedInstitute" ${applicantPostAssoc.graduateFromAffiliatedInstitute == false ? 'checked="checked"':''} id="trafficInspectorJunior-graduateFromAffiliatedInstitute-no" value="0" type="radio"/>
				<label for="trafficInspectorJunior-graduateFromAffiliatedInstitute-no"> <fmt:message key="no"/> </label>
			</div>
			<div class="help-block with-errors"></div>
		</div>
	</div>
	
	<div class="form-group trafficInspectorJuniorDegreeNameToggle">
        <label class="control-label col-sm-5" for="degreeName"><fmt:message key="trafficInspectorJunior.degreeName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.degreeName}" type="text" class="form-control" id="trafficInspectorJunior-DegreeName" placeholder="<fmt:message key="trafficInspectorJunior.degreeName"/>" name="degreeName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
	<div class="form-group trafficInspectorJuniorgraduateFromAffiliatedInstituteToggle">
        <label class="control-label col-sm-5" for="graduateFromAffiliatedInstituteUniversityName"><fmt:message key="trafficInspectorJunior.graduateFromAffiliatedInstitute.universityName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.universityName}" type="text" class="form-control" id="trafficInspectorJunior-UniversityName" placeholder="<fmt:message key="trafficInspectorJunior.graduateFromAffiliatedInstitute.universityName"/>" name="universityName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
   
<%-- 	<div class="form-group ">
		<label class="control-label col-sm-5"><fmt:message key="trafficInspectorJunior.otherQualification"/>: </label>
		<div class="col-sm-4">
			<input value="${ applicantPostAssoc.otherQualificationDetails }"  name="otherQualificationDetails" class="form-control" id="trafficInspectorJunior-otherQualificationDetails" type="text" placeholder="<fmt:message key="trafficInspectorJunior.otherQualification"/>" maxlength="100" />
			<div class="help-block with-errors"></div>
		</div>
	</div> --%>
	<div class="form-group">
		<label class="control-label col-sm-5"><fmt:message key="trafficInspectorJunior.mscitOrGaccc"/>: <span class="red">*</span></label>
		<div class="col-sm-4">
			<div class="radio radio-inline">
				<input name="mscitOrGaccc" ${ applicantPostAssoc.mscitOrGaccc ? 'checked="checked"':''} id="trafficInspectorJunior-mscitOrGaccc-yes" value="1" type="radio" />
				<label for="trafficInspectorJunior-mscitOrGaccc-yes"> <fmt:message key="yes"/> </label>
			</div>
			<div class="radio radio-inline">
				<input class="radiosToCheck" name="mscitOrGaccc" ${applicantPostAssoc.mscitOrGaccc == false ? 'checked="checked"':''} id="trafficInspectorJunior-mscitOrGaccc-no" value="0" type="radio" />
				<label for="trafficInspectorJunior-mscitOrGaccc-no"> <fmt:message key="no"/> </label>
			</div>
			<div class="help-block with-errors"></div>
		</div>
	</div>
	
	<div class="form-group">
		<label class="control-label col-sm-5"><fmt:message key="trafficInspectorJunior.heightWithinRange"/>: <span class="red">*</span></label>
		<div class="col-sm-4">
			<div class="radio radio-inline">
				<input name="heightWithinRange" ${ applicantPostAssoc.heightWithinRange ? 'checked="checked"':''} id="trafficInspectorJunior-heightWithinRange-yes" value="1" type="radio" />
				<label for="trafficInspectorJunior-heightWithinRange-yes"> <fmt:message key="yes"/> </label>
			</div>
			<div class="radio radio-inline">
				<input class="radiosToCheck" name="heightWithinRange" ${applicantPostAssoc.heightWithinRange == false ? 'checked="checked"':''} id="trafficInspectorJunior-heightWithinRange-no" value="0" type="radio" />
				<label for="trafficInspectorJunior-heightWithinRange-no"> <fmt:message key="no"/> </label>
			</div>
			<div class="help-block with-errors"></div>
		</div>
	</div>
	
	<div class="form-group ">
		<label class="control-label col-sm-5"><fmt:message key="trafficInspectorJunior.experience"/>: <span class="red">*</span></label>
		<div class="col-sm-4">
			<div class="radio radio-inline">
				<input name="oneYearExpAsTransportAssociation" ${ applicantPostAssoc.oneYearExpAsTransportAssociation ? 'checked="checked"':''} id="trafficInspectorJunior-experienced-yes" value="1" type="radio" />
				<label for="trafficInspectorJunior-experienced-yes"> <fmt:message key="yes"/> </label>
			</div>
			<div class="radio radio-inline">
				<input class="radiosToCheck" name="oneYearExpAsTransportAssociation" ${applicantPostAssoc.oneYearExpAsTransportAssociation == false? 'checked="checked"':''} id="trafficInspectorJunior-experienced-no" value="0" type="radio" />
				<label for="trafficInspectorJunior-experienced-no"> <fmt:message key="no"/> </label>
			</div>
			<div class="help-block with-errors"></div>
		</div>
	</div>
	
	<div class="form-group trafficInspectorJuniorExperiencedToggle">
        <label class="control-label col-sm-5" for="companyName"><fmt:message key="trafficInspector.experienced.companyName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.companyName}" type="text" class="form-control" id="trafficInspectorJunior-CompanyName" placeholder="<fmt:message key="trafficInspector.experienced.companyName"/>" name="companyName" maxlength="150">
            <div class="help-block with-errors"></div>
        </div>
    </div>
	
    <div class="form-group trafficInspectorJuniorExperiencedToggle">
        <label class="control-label col-sm-5" for="totalExperienceInYears"><fmt:message key="trafficInspector.experienced.totalExperience"/>: <span class="red">*</span></label>
        <div class="col-sm-2">
            <input value="${applicantPostAssoc.totalExperienceInYears}" type="tel" class="form-control" id="trafficInspector-TotalExperienceInYears" placeholder="<fmt:message key="trafficInspector.experienced.inYears"/>" name="totalExperienceInYears" min="0" maxlength="2">
            <div class="help-block with-errors"></div>
        </div>
        <div class="col-sm-2">
            <input value="${applicantPostAssoc.totalExperienceInMonths}" type="tel" class="form-control" id="trafficInspector-TotalExperienceInMonths" placeholder="<fmt:message key="trafficInspector.experienced.inMonths"/>" name="totalExperienceInMonths" min="0" maxlength="2">
            <div class="help-block with-errors"></div>
        </div>
    </div>
	
	<div class="form-group">
        <label class="control-label col-sm-5" for="ownHeavyDrivingLicenseNumber"><fmt:message key="trafficInspectorJunior.ownHeavyDrivingLicenseNo"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="ownHeavyDrivingLicenseNumber" id="trafficInspectorJunior-ownHeavyDrivingLicenseNumber-yes" value="1" type="radio" ${applicantPostAssoc.ownHeavyDrivingLicenseNumber ? 'checked' : ''} />
                <label for="trafficInspectorJunior-ownHeavyDrivingLicenseNumber-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input name="ownHeavyDrivingLicenseNumber" id="trafficInspectorJunior-ownHeavyDrivingLicenseNumber-no" value="0" type="radio" ${applicantPostAssoc.ownHeavyDrivingLicenseNumber == false ? 'checked' : ''} />
                <label for="trafficInspectorJunior-ownHeavyDrivingLicenseNumber-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group trafficInspectorJuniorOwnHeavyDrivingLicenseToggle">
      	<label class="control-label col-sm-5" for="heavyDrivingLicenseNumber"><fmt:message key="trafficInspectorJunior.ownHeavyDrivingLicenseNo.number"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.heavyDrivingLicenseNumber}" type="text" class="form-control" id="trafficInspectorJuniorHeavyDrivingLicenseNumber" placeholder="<fmt:message key="trafficInspectorJunior.ownHeavyDrivingLicenseNo.number"/>" name="heavyDrivingLicenseNumber" maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
   </div>
   <div class="form-group trafficInspectorJuniorOwnHeavyDrivingLicenseToggle">
        <label class="control-label col-sm-5" for="trafficInspectorJuniorHeavyDrivingLicenseIssueDate"><fmt:message key="trafficInspectorJunior.ownHeavyDrivingLicenseNo.issueDate"/> <span class="red">*</span></label>
        <div class="col-sm-3">
        	<div class="input-group date">
	            <input type="datetime" class="form-control" id="trafficInspectorJuniorHeavyDrivingLicenseIssueDate" placeholder="<fmt:message key="trafficInspectorJunior.ownHeavyDrivingLicenseNo.issueDate"/>" name="heavyDrivingLicenseIssueDate" readonly>
	            <div class="input-group-addon" id="trafficInspectorJuniorCalendarIconHeavyDrivingLicenseIssueDate">
					<i class="fa fa-calendar"></i>
				</div>
	            <div class="help-block with-errors"></div>
            </div>
        </div>
   </div>
   <div class="form-group trafficInspectorJuniorOwnHeavyDrivingLicenseToggle">
       <label class="control-label col-sm-5" for="trafficInspectorJuniorHeavyDrivingLicenseEndDate"><fmt:message key="trafficInspectorJunior.ownHeavyDrivingLicenseNo.endDate"/> <span class="red">*</span></label>
        <div class="col-sm-3">
        	<div class="input-group date">
	            <input type="datetime" class="form-control" id="trafficInspectorJuniorHeavyDrivingLicenseEndDate" placeholder="<fmt:message key="trafficInspectorJunior.ownHeavyDrivingLicenseNo.endDate"/>" name="heavyDrivingLicenseEndDate" readonly >
	            <div class="input-group-addon" id="trafficInspectorJuniorCalendarIconHeavyDrivingLicenseEndDate">
					<i class="fa fa-calendar"></i>
				</div>
	            <div class="help-block with-errors"></div>
            </div>
        </div>
    </div>
	
	<jsp:include page="postFooter.jsp">
		<jsp:param name="isPostSubmitted" value="${ applicantPostAssoc.status eq 2 || applicantPostAssoc.status eq 3 }"/>
	<jsp:param name="formId" value="trafficInspectorJuniorForm"/>
		<jsp:param name="postId" value="${post.postId}"/>
		<jsp:param name="disableFormAfterLastDateOver" value="${disableFormAfterLastDateOver}"/>
	</jsp:include>

</form>

<script>
 $(document).ready(function(){
 $("form[name='trafficInspectorJuniorForm']").validate({
	// ignore : "#trafficInspectorJuniorHeavyDrivingLicenseIssueDate, #trafficInspectorJuniorHeavyDrivingLicenseEndDate",
 	rules:{
 		 graduateFromAffiliatedInstitute : "required",
 		 degreeName: {required: true},
 		 universityName: {required: true},
 		 mscitOrGaccc : "required",
 		 heightWithinRange : "required",
 		 oneYearExpAsTransportAssociation : "required",
 		 companyName : {required: true},
 		 totalExperienceInYears :{required: true, numbersonly:true, min : 1, max:100},
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
 