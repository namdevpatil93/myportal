<%@ include file="../../common/taglibs.jsp"%>


<script type="text/javascript">

$(document).ready(function() 
{
	postSelectionObj.disableFormFields ("accountantJuniorForm", '${applicantPostAssoc.status}');
	showSelectedOptions();
	postSelectionObj.bindPostForm("accountantJuniorForm");
	function showSelectedOptions()
	{
		if('${applicantPostAssoc.bcomPassed}'== "true" || '${applicantPostAssoc.bcomPassed}'== true)
		{
			postSelectionObj.showElementsByClass('accountantJuniorBcomPassedToggle');
		}
		else
		{
			postSelectionObj.hideElementsByClass('accountantJuniorBcomPassedToggle');
		}
		if('${ applicantPostAssoc.oneYearExpAsAccountant}' == "true" || '${ applicantPostAssoc.oneYearExpAsAccountant}' == true)
		{
			postSelectionObj.showElementsByClass('accountantJuniorExperiencedToggle');
		}
		else
		{
			postSelectionObj.hideElementsByClass('accountantJuniorExperiencedToggle');
		}
	}
	
	var lastDateOver = commonObj.isValidate(${disableFormAfterLastDateOver});
    commonObj.disableFormFields("accountantJuniorForm",lastDateOver);
});



	$( 'form#accountantJuniorForm' ).find('input[type=radio][name=mscitOrGaccc]').unbind().change(function() {
        if (this.value == '0') {
//         	postSelectionObj.notEligiblePopup();
        }
    });
	
	$( 'form#accountantJuniorForm' ).find('input[type=radio][name=bcomPassed]').unbind().change(function() {
        if (this.value == '1') 
        {
        	$('#accountantJunior-UniversityName').attr("required", true);
       	 	postSelectionObj.showElementsByClass('accountantJuniorBcomPassedToggle');
        } 
        else 
        {
        	$('#accountantJunior-UniversityName').attr("required", false);
        	postSelectionObj.resetTextFieldById('accountantJunior-UniversityName');
        	postSelectionObj.hideElementsByClass('accountantJuniorBcomPassedToggle');
//        		postSelectionObj.notEligiblePopup();
        }
    });
	
	$( 'form#accountantJuniorForm' ).find('input[type=radio][name=oneYearExpAsAccountant]').unbind().change(function() {
        if (this.value == '1') 
        {
        	$('#accountantJunior-CompanyName').attr("required", true);
        	$('#accountantJunior-TotalExperienceInYears').attr("required", true);
        	$('#accountantJunior-TotalExperienceInMonths').attr("required", true);
       		 postSelectionObj.showElementsByClass('accountantJuniorExperiencedToggle');
        } 
        else 
        {
        	$('#accountantJunior-CompanyName').attr("required", false);
        	$('#accountantJunior-TotalExperienceInYears').attr("required", false);
        	$('#accountantJunior-TotalExperienceInMonths').attr("required", false);
        	postSelectionObj.resetTextFieldById('accountantJunior-TotalExperienceInYears');
        	postSelectionObj.resetTextFieldById('accountantJunior-TotalExperienceInMonths');
        	postSelectionObj.resetTextFieldById('accountantJunior-CompanyName');
        	postSelectionObj.hideElementsByClass('accountantJuniorExperiencedToggle');
//        		postSelectionObj.notEligiblePopup();
        }
    });
/*

	function showEligibilityCriteriaPDF() {
		var url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/viewPdf.pdf'/>";
		window.open(url,'_blank');
	}
*/

</script>
	 <div id="downloadEligibilityCriteria" class="form-group" align="right">
	        <div class="col-sm-12" align="pull-right">
	            <a href="javascript:void(0);" onclick="javascript:showEligibilityCriteriaPDF(${post.postId})"><b><fmt:message key="postEligibilityCriteriaLink"/></b></a>
	        </div>
	    </div>
<form class="form-horizontal" name="accountantJuniorForm" id="accountantJuniorForm" action="<c:url value='/applicant?operation=saveApplicantPostDetails'/>" method="POST" style="z-index:0;">

	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="hidden" name="id" value="${applicantPostAssoc.id}"/>
	<input type="hidden" name="postId" value="${post.postId}"/>
	<input type="hidden" name="status" id="status"  value="${ applicantPostAssoc.status }"/>

	<div class="form-group">
		<label class="control-label col-sm-5"><fmt:message key="accountantJunior.bcomPassed"/>: <span class="red">*</span></label>
		<div class="col-sm-4">
			<div class="radio radio-inline">
				<input name="bcomPassed" ${ applicantPostAssoc.bcomPassed ? 'checked="checked"':''} id="accountantJunior-bcomPassed-yes" value="1" type="radio" />
				<label for="accountantJunior-bcomPassed-yes"> <fmt:message key="yes"/> </label>
			</div>
			<div class="radio radio-inline">
				<input class="radiosToCheck" name="bcomPassed" ${applicantPostAssoc.bcomPassed == false ? 'checked="checked"':''} id="accountantJunior-bcomPassed-no" value="0" type="radio" />
				<label for="accountantJunior-bcomPassed-no"> <fmt:message key="no"/> </label>
			</div>
			<div class="help-block with-errors"></div>
		</div>
	</div>
	<div class="form-group accountantJuniorBcomPassedToggle">
        <label class="control-label col-sm-5" for="bcomPassedUniversityName"><fmt:message key="accountantJunior.BcomPassed.universityName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.universityName}" type="text" class="form-control" id="accountantJunior-UniversityName" placeholder="<fmt:message key="accountantJunior.BcomPassed.universityName"/>" name="universityName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
<%-- 	<div class="form-group ">
		<label class="control-label col-sm-5"><fmt:message key="accountantJunior.otherQualification"/>: </label>
		<div class="col-sm-4">
			<input value="${ applicantPostAssoc.otherQualificationDetails }"  name="otherQualificationDetails" class="form-control" id="accountantJunior-otherQualificationDetails" type="text" placeholder="<fmt:message key="accountantJunior.otherQualification"/>" maxlength="100" />
			<div class="help-block with-errors"></div>
		</div>
	</div> --%>
	<div class="form-group">
		<label class="control-label col-sm-5"><fmt:message key="accountantJunior.mscitOrGaccc"/>: <span class="red">*</span></label>
		<div class="col-sm-4">
			<div class="radio radio-inline">
				<input name="mscitOrGaccc" ${ applicantPostAssoc.mscitOrGaccc ? 'checked="checked"':''} id="accountantJunior-mscitOrGaccc-yes" value="1" type="radio" />
				<label for="accountantJunior-mscitOrGaccc-yes"> <fmt:message key="yes"/> </label>
			</div>
			<div class="radio radio-inline">
				<input class="radiosToCheck" name="mscitOrGaccc" ${applicantPostAssoc.mscitOrGaccc == false ? 'checked="checked"':''} id="accountantJunior-mscitOrGaccc-no" value="0" type="radio" />
				<label for="accountantJunior-mscitOrGaccc-no"> <fmt:message key="no"/> </label>
			</div>
			<div class="help-block with-errors"></div>
		</div>
	</div>
	<div class="form-group ">
		<label class="control-label col-sm-5"><fmt:message key="accountantJunior.experience"/>: <span class="red">*</span></label>
		<div class="col-sm-4">
			<div class="radio radio-inline">
				<input name="oneYearExpAsAccountant" ${ applicantPostAssoc.oneYearExpAsAccountant ? 'checked="checked"':''} id="accountantJunior-experienced-yes" value="1" type="radio" />
				<label for="accountantJunior-experienced-yes"> <fmt:message key="yes"/> </label>
			</div>
			<div class="radio radio-inline">
				<input class="radiosToCheck" name="oneYearExpAsAccountant" ${applicantPostAssoc.oneYearExpAsAccountant == false ? 'checked="checked"':''} id="accountantJunior-experienced-no" value="0" type="radio" />
				<label for="accountantJunior-experienced-no"> <fmt:message key="no"/> </label>
			</div>
			<div class="help-block with-errors"></div>
		</div>
	</div>
	
	<div class="form-group accountantJuniorExperiencedToggle">
        <label class="control-label col-sm-5" for="companyName"><fmt:message key="accountantJunior.experienced.companyName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.companyName}" type="text" class="form-control" id="accountantJunior-CompanyName" placeholder="<fmt:message key="accountantJunior.experienced.companyName"/>" name="companyName" maxlength="150">
            <div class="help-block with-errors"></div>
        </div>
    </div>
	
    <div class="form-group accountantJuniorExperiencedToggle">
        <label class="control-label col-sm-5" for="totalExperienceInYears"><fmt:message key="accountantJunior.experienced.totalExperience"/>: <span class="red">*</span></label>
        <div class="col-sm-2">
            <input value="${applicantPostAssoc.totalExperienceInYears}" type="tel" class="form-control" id="accountantJunior-TotalExperienceInYears" placeholder="<fmt:message key="accountantJunior.experienced.inYears"/>" name="totalExperienceInYears" min="0" maxlength="2">
            <div class="help-block with-errors"></div>
        </div>
        <div class="col-sm-2">
            <input value="${applicantPostAssoc.totalExperienceInMonths}" type="tel" class="form-control" id="accountantJunior-TotalExperienceInMonths" placeholder="<fmt:message key="accountantJunior.experienced.inMonths"/>" name="totalExperienceInMonths" min="0" maxlength="2">
            <div class="help-block with-errors"></div>
        </div>
    </div>
	
	<jsp:include page="postFooter.jsp">
		<jsp:param name="isPostSubmitted" value="${ applicantPostAssoc.status eq 2 || applicantPostAssoc.status eq 3 }"/>
		<jsp:param name="formId" value="accountantJuniorForm"/>
		<jsp:param name="postId" value="${post.postId}"/>
		<jsp:param name="disableFormAfterLastDateOver" value="${disableFormAfterLastDateOver}"/>
	</jsp:include>

</form>


<script>
 $(document).ready(function(){
 $("form[name='accountantJuniorForm']").validate({
 	rules:{
	 		bcomPassed : "required",
	 		universityName: {required: true},
	 		mscitOrGaccc : "required",
	 		oneYearExpAsAccountant : "required",
	 		companyName : {required: true},
	 		totalExperienceInYears :{required: true, numbersonly:true, min : 1, max:100},
	 		totalExperienceInMonths :{required: true, numbersonly:true, max: 11}
 		  },
		  messages:{
			  totalExperienceInMonths : {max : "<fmt:message key="number.eleven" var="key" /><fmt:message key="validate.maxMonths"><fmt:param value="${key}" /></fmt:message>"}
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