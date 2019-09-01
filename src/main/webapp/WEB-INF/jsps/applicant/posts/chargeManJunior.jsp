<%@ include file="../../common/taglibs.jsp"%>


<script type="text/javascript">

$(document).ready(function() 
{
	postSelectionObj.disableFormFields ("chargeManJuniorForm", '${applicantPostAssoc.status}');
	showSelectedOptions();
	postSelectionObj.bindPostForm("chargeManJuniorForm");

	postSelectionObj.validateDate('chargeManJuniorHeavyDrivingLicenseIssueDate', 'chargeManJuniorHeavyDrivingLicenseEndDate');
	
	function showSelectedOptions()
	{
		if('${applicantPostAssoc.automobileOrMechanicalEngDegree}' == "true" || '${applicantPostAssoc.automobileOrMechanicalEngDegree}' == true)
		{
			postSelectionObj.showElementsByClass('chargeManJuniorDegreeNameToggle');
			postSelectionObj.showElementsByClass('chargeManJuniorgraduateFromAffiliatedInstituteToggle');
		}
		else
		{
			postSelectionObj.hideElementsByClass('chargeManJuniorgraduateFromAffiliatedInstituteToggle');
        	postSelectionObj.hideElementsByClass('chargeManJuniorDegreeNameToggle');
		}
		
		if('${ applicantPostAssoc.oneYearExpInAutomobileRepairing}' == "true" || '${ applicantPostAssoc.oneYearExpInAutomobileRepairing}' == true)
		{
			postSelectionObj.showElementsByClass('chargeManJuniorExperiencedToggle');
		}
		else
		{
			postSelectionObj.hideElementsByClass('chargeManJuniorExperiencedToggle');
		}
		
		if('${ applicantPostAssoc.ownHeavyDrivingLicenseNumber}' == "true" || '${ applicantPostAssoc.ownHeavyDrivingLicenseNumber}' == true)
		{
			postSelectionObj.showElementsByClass('chargeManJuniorOwnHeavyDrivingLicenseToggle');
		}
		else
		{
			postSelectionObj.hideElementsByClass('chargeManJuniorOwnHeavyDrivingLicenseToggle');
		}

		var maxDate=new Date();
		maxDate.setFullYear(maxDate.getFullYear() + 50);
		
			$('#chargeManJuniorHeavyDrivingLicenseIssueDate').datetimepicker({
		         format: 'DD/MM/YYYY',
		         ignoreReadonly: true,
		         showTodayButton: true,
		         minDate: postSelectionObj.minDate(),
		         maxDate: postSelectionObj.maxDate()
		         //defaultDate: moment(),
		         //date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseIssueDate}" />'
		     });
			 $('#chargeManJuniorCalendarIconHeavyDrivingLicenseIssueDate').click(function() {
		         $('#chargeManJuniorHeavyDrivingLicenseIssueDate').data("DateTimePicker").show();
		     });
		
			$('#chargeManJuniorHeavyDrivingLicenseEndDate').datetimepicker({
		         format: 'DD/MM/YYYY',
		         ignoreReadonly: true,
		         showTodayButton: true,
		         minDate: postSelectionObj.minDate(),
		         maxDate: postSelectionObj.maxDate()
		         //defaultDate: moment(),
		         //date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseEndDate}" />'
		     });
			 $('#chargeManJuniorCalendarIconHeavyDrivingLicenseEndDate').click(function() {
		         $('#chargeManJuniorHeavyDrivingLicenseEndDate').data("DateTimePicker").show();
		     });

			var date = '${applicantPostAssoc.heavyDrivingLicenseIssueDate}';
			if(date != 'undefined' || date != null || data !='' )
				$('#chargeManJuniorHeavyDrivingLicenseIssueDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseIssueDate}" />');
			
			date = '${applicantPostAssoc.heavyDrivingLicenseEndDate}';
			if(date != 'undefined' || date != null || data !='' )
				$('#chargeManJuniorHeavyDrivingLicenseEndDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseEndDate}" />');
				
	}
	
	var lastDateOver = commonObj.isValidate(${disableFormAfterLastDateOver});
    commonObj.disableFormFields("chargeManJuniorForm",lastDateOver);
});

	$( 'form#chargeManJuniorForm' ).find('input[type=radio][name=automobileOrMechanicalEngDegree]').unbind().change(function() {
        if (this.value == '1') 
        {
        	$('#chargeManJunior-DegreeName').attr("required", true);
        	$('#chargeManJunior-UniversityName').attr("required", true);
       	 	postSelectionObj.showElementsByClass('chargeManJuniorDegreeNameToggle');
       	 	postSelectionObj.showElementsByClass('chargeManJuniorgraduateFromAffiliatedInstituteToggle');
       	 
        } 
        else 
        {
        	$('#chargeManJunior-DegreeName').attr("required", false);
        	$('#chargeManJunior-UniversityName').attr("required", false);
        	postSelectionObj.resetTextFieldById('chargeManJunior-DegreeName');
        	postSelectionObj.resetTextFieldById('chargeManJunior-UniversityName');
        	postSelectionObj.hideElementsByClass('chargeManJuniorDegreeNameToggle');
        	postSelectionObj.hideElementsByClass('chargeManJuniorgraduateFromAffiliatedInstituteToggle');
//        		postSelectionObj.notEligiblePopup();
        }
    });
	
	$( 'form#chargeManJuniorForm' ).find('input[type=radio][name=oneYearExpInAutomobileRepairing]').unbind().change(function() {
        if (this.value == '1') 
        {
        	$('#chargeManJunior-CompanyName').attr("required", true);
        	$('#chargeMan-TotalExperienceInYears').attr("required", true);
        	$('#chargeMan-TotalExperienceInMonths').attr("required", true);
       		 postSelectionObj.showElementsByClass('chargeManJuniorExperiencedToggle');
        } 
        else 
        {
        	$('#chargeManJunior-CompanyName').attr("required", false);
        	$('#chargeMan-TotalExperienceInYears').attr("required", false);
        	$('#chargeMan-TotalExperienceInMonths').attr("required", false);
        	postSelectionObj.resetTextFieldById('chargeMan-TotalExperienceInYears');
        	postSelectionObj.resetTextFieldById('chargeMan-TotalExperienceInMonths');
        	postSelectionObj.resetTextFieldById('chargeManJunior-CompanyName');
        	postSelectionObj.hideElementsByClass('chargeManJuniorExperiencedToggle');
//        		postSelectionObj.notEligiblePopup();
        }
    });
	
	$( 'form#chargeManJuniorForm' ).find('input[type=radio][name=ownHeavyDrivingLicenseNumber]').unbind().change(function() {
        if (this.value == '1') {
        	$('#chargeManJuniorHeavyDrivingLicenseNumber').attr("required", true);
        	 postSelectionObj.showElementsByClass('chargeManJuniorOwnHeavyDrivingLicenseToggle');
        }
        else
        {
        	$('#chargeManJuniorHeavyDrivingLicenseNumber').attr("required", false);
        	postSelectionObj.resetTextFieldById('chargeManJuniorHeavyDrivingLicenseNumber');
        	postSelectionObj.resetTextFieldById('chargeManJuniorHeavyDrivingLicenseIssueDate');
        	postSelectionObj.resetTextFieldById('chargeManJuniorHeavyDrivingLicenseEndDate');
        	postSelectionObj.hideElementsByClass('chargeManJuniorOwnHeavyDrivingLicenseToggle');
//            commonObj.showAlert("<fmt:message key='heavyDrivingLicenseNumber.onNoSelect.alert' />");
        	commonObj.showAgreeDisAgreePopup("<fmt:message key='heavyDrivingLicenseNumber.onNoSelect.alert' />", chargemanJuniorAgreeDisAgreePopup, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));

        }
    });

   function chargemanJuniorAgreeDisAgreePopup(flag)
   {
	   	if(!flag)
	   	{
	   		$('#chargeManJunior-ownHeavyDrivingLicenseNumber-yes').prop('checked', true);
	   		$('#chargeManJuniorHeavyDrivingLicenseNumber').attr("required", true);
	      	 	postSelectionObj.showElementsByClass('chargeManJuniorOwnHeavyDrivingLicenseToggle');
	   		postSelectionObj.resetTextFieldById('chargeManJuniorHeavyDrivingLicenseNumber');
	       	postSelectionObj.resetTextFieldById('chargeManJuniorHeavyDrivingLicenseIssueDate');
	       	postSelectionObj.resetTextFieldById('chargeManJuniorHeavyDrivingLicenseEndDate');
	   	}
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

<form class="form-horizontal" name="chargeManJuniorForm" id="chargeManJuniorForm" action="<c:url value='/applicant?operation=saveApplicantPostDetails'/>" method="POST" style="z-index:0;">

	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="hidden" name="id" value="${applicantPostAssoc.id}"/>
	<input type="hidden" name="postId" value="${post.postId}"/>
	<input type="hidden" name="status" id="status"  value="${ applicantPostAssoc.status }"/>

	<div class="form-group">
		<label class="control-label col-sm-5"><fmt:message key="chargeManJunior.automobileOrMechanicalEngDegree"/>: <span class="red">*</span></label>
		<div class="col-sm-4">
			<div class="radio radio-inline">
				<input name="automobileOrMechanicalEngDegree" ${ applicantPostAssoc.automobileOrMechanicalEngDegree ? 'checked="checked"':''} id="chargeManJunior-automobileOrMechanicalEngDegree-yes" value="1" type="radio" />
				<label for="chargeManJunior-automobileOrMechanicalEngDegree-yes"> <fmt:message key="yes"/> </label>
			</div>
			<div class="radio radio-inline">
				<input class="radiosToCheck" name="automobileOrMechanicalEngDegree" ${applicantPostAssoc.automobileOrMechanicalEngDegree == false ? 'checked="checked"':''} id="chargeManJunior-automobileOrMechanicalEngDegree-no" value="0" type="radio" />
				<label for="chargeManJunior-automobileOrMechanicalEngDegree-no"> <fmt:message key="no"/> </label>
			</div>
			<div class="help-block with-errors"></div>
		</div>
	</div>
	
	<div class="form-group chargeManJuniorDegreeNameToggle">
        <label class="control-label col-sm-5" for="degreeName"><fmt:message key="chargeManJunior.degreeName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.degreeName}" type="text" class="form-control" id="chargeManJunior-DegreeName" placeholder="<fmt:message key="chargeManJunior.degreeName"/>" name="degreeName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
	
	<div class="form-group chargeManJuniorgraduateFromAffiliatedInstituteToggle">
        <label class="control-label col-sm-5" for="graduateFromAffiliatedInstituteUniversityName"><fmt:message key="chargeManJunior.automobileOrMechanicalEngDegree.universityName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.universityName}" type="text" class="form-control" id="chargeManJunior-UniversityName" placeholder="<fmt:message key="chargeManJunior.automobileOrMechanicalEngDegree.universityName"/>" name="universityName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
<!--     Qualifit -->
   
	<%-- <div class="form-group ">
		<label class="control-label col-sm-5"><fmt:message key="chargeManJunior.otherQualification"/>: </label>
		<div class="col-sm-4">
			<input value="${ applicantPostAssoc.otherQualificationDetails }"  name="otherQualificationDetails" class="form-control" id="chargeManJunior-otherQualificationDetails" type="text" maxlength="100" placeholder="<fmt:message key="chargeManJunior.otherQualification"/>" />
			<div class="help-block with-errors"></div>
		</div>
	</div> --%>
<!-- 	Experiecne -->
	<div class="form-group ">
		<label class="control-label col-sm-5"><fmt:message key="chargeManJunior.experience"/>: <span class="red">*</span></label>
		<div class="col-sm-4">
			<div class="radio radio-inline">
				<input name="oneYearExpInAutomobileRepairing" ${ applicantPostAssoc.oneYearExpInAutomobileRepairing ? 'checked="checked"':''} id="chargeManJunior-experienced-yes" value="1" type="radio" />
				<label for="chargeManJunior-experienced-yes"> <fmt:message key="yes"/> </label>
			</div>
			<div class="radio radio-inline">
				<input class="radiosToCheck" name="oneYearExpInAutomobileRepairing" ${applicantPostAssoc.oneYearExpInAutomobileRepairing == false ? 'checked="checked"':''} id="chargeManJunior-experienced-no" value="0" type="radio" />
				<label for="chargeManJunior-experienced-no"> <fmt:message key="no"/> </label>
			</div>
			<div class="help-block with-errors"></div>
		</div>
	</div>
	
	<div class="form-group chargeManJuniorExperiencedToggle">
        <label class="control-label col-sm-5" for="companyName"><fmt:message key="chargeMan.experienced.companyName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.companyName}" type="text" class="form-control" id="chargeManJunior-CompanyName" placeholder="<fmt:message key="chargeMan.experienced.companyName"/>" name="companyName" maxlength="150">
            <div class="help-block with-errors"></div>
        </div>
    </div>
	
    <div class="form-group chargeManJuniorExperiencedToggle">
        <label class="control-label col-sm-5" for="totalExperienceInYears"><fmt:message key="chargeMan.experienced.totalExperience"/>: <span class="red">*</span></label>
        <div class="col-sm-2">
            <input value="${applicantPostAssoc.totalExperienceInYears}" type="tel" class="form-control" id="chargeMan-TotalExperienceInYears" placeholder="<fmt:message key="chargeMan.experienced.inYears"/>" name="totalExperienceInYears" min="0" maxlength="2">
            <div class="help-block with-errors"></div>
        </div>
        <div class="col-sm-2">
            <input value="${applicantPostAssoc.totalExperienceInMonths}" type="tel" class="form-control" id="chargeMan-TotalExperienceInMonths" placeholder="<fmt:message key="chargeMan.experienced.inMonths"/>" name="totalExperienceInMonths" min="0" maxlength="2" >
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
     <div class="form-group">
        <label class="control-label col-sm-5" for="ownHeavyDrivingLicenseNumber"><fmt:message key="chargeManJunior.ownHeavyDrivingLicenseNo"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="ownHeavyDrivingLicenseNumber" id="chargeManJunior-ownHeavyDrivingLicenseNumber-yes" value="1" type="radio" ${applicantPostAssoc.ownHeavyDrivingLicenseNumber ? 'checked' : ''} />
                <label for="chargeManJunior-ownHeavyDrivingLicenseNumber-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <%-- <input class="radiosToCheck" name="ownHeavyDrivingLicenseNumber" id="chargeManJunior-ownHeavyDrivingLicenseNumber-no" value="0" type="radio" ${applicantPostAssoc.ownHeavyDrivingLicenseNumber == false ? 'checked' : ''} /> --%>
                <input name="ownHeavyDrivingLicenseNumber" id="chargeManJunior-ownHeavyDrivingLicenseNumber-no" value="0" type="radio" ${applicantPostAssoc.ownHeavyDrivingLicenseNumber == false ? 'checked' : ''} />
                <label for="chargeManJunior-ownHeavyDrivingLicenseNumber-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group chargeManJuniorOwnHeavyDrivingLicenseToggle">
      	<label class="control-label col-sm-5" for="heavyDrivingLicenseNumber"><fmt:message key="chargeManJunior.ownHeavyDrivingLicenseNo.number"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.heavyDrivingLicenseNumber}" type="text" class="form-control" id="chargeManJuniorHeavyDrivingLicenseNumber" placeholder="<fmt:message key="chargeManJunior.ownHeavyDrivingLicenseNo.number"/>" name="heavyDrivingLicenseNumber" maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
     <div class="form-group chargeManJuniorOwnHeavyDrivingLicenseToggle">
        <label class="control-label col-sm-5" for="heavyDrivingLicenseIssueDate"><fmt:message key="chargeManJunior.ownHeavyDrivingLicenseNo.issueDate"/>: <span class="red">*</span></label>
        <div class="col-sm-3">
        	<div class="input-group date">
	            <input type="datetime" class="form-control" id="chargeManJuniorHeavyDrivingLicenseIssueDate" placeholder="<fmt:message key="chargeManJunior.ownHeavyDrivingLicenseNo.issueDate"/>" name="heavyDrivingLicenseIssueDate" readonly >
	            <div class="input-group-addon" id="chargeManJuniorCalendarIconHeavyDrivingLicenseIssueDate">
					<i class="fa fa-calendar"></i>
				</div>
	            <div class="help-block with-errors"></div>
            </div>
        </div>
    </div>
	<div class="form-group chargeManJuniorOwnHeavyDrivingLicenseToggle">
       <label class="control-label col-sm-5" for="heavyDrivingLicenseEndDate"><fmt:message key="chargeManJunior.ownHeavyDrivingLicenseNo.endDate"/>: <span class="red">*</span></label>
        <div class="col-sm-3">
        	<div class="input-group date">
	            <input type="datetime" class="form-control" id="chargeManJuniorHeavyDrivingLicenseEndDate" placeholder="<fmt:message key="chargeManJunior.ownHeavyDrivingLicenseNo.endDate"/>" name="heavyDrivingLicenseEndDate" readonly >
	            <div class="input-group-addon" id="chargeManJuniorCalendarIconHeavyDrivingLicenseEndDate">
					<i class="fa fa-calendar"></i>
				</div>
	            <div class="help-block with-errors"></div>
            </div>
        </div>
    </div>
	
	
	
	<jsp:include page="postFooter.jsp">
		<jsp:param name="isPostSubmitted" value="${ applicantPostAssoc.status eq 2 || applicantPostAssoc.status eq 3 }"/>
		<jsp:param name="formId" value="chargeManJuniorForm"/>
		<jsp:param name="postId" value="${post.postId}"/>
		<jsp:param name="disableFormAfterLastDateOver" value="${disableFormAfterLastDateOver}"/>
	</jsp:include>

</form>

<script>
 $(document).ready(function(){
 $("form[name='chargeManJuniorForm']").validate({
	// ignore : "#chargeManJuniorHeavyDrivingLicenseIssueDate, #chargeManJuniorHeavyDrivingLicenseEndDate",
 	rules:{
 		 automobileOrMechanicalEngDegree : "required",
 		 degreeName: {required: true},
 		 universityName: {required: true},
 		 oneYearExpInAutomobileRepairing : "required",
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