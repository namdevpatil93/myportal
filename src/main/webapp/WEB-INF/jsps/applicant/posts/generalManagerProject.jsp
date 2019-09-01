<%@ include file="../../common/taglibs.jsp"%>

<script type="text/javascript">
	$( document ).ready(function (){
			postSelectionObj.disableFormFields ("generalManagerProjectForm", '${applicantPostAssoc.status}');
 			postSelectionObj.bindPostForm("generalManagerProjectForm");
// 			postSelectionObj.submittingForm("generalManagerProjectForm");
			mbaPassedOrFaildAction();
			experienceAction();
			var lastDateOver = commonObj.isValidate(${disableFormAfterLastDateOver});
		    commonObj.disableFormFields("generalManagerProjectForm",lastDateOver);
	});
	
	$('#manager-mbaPassed-yes').click(mbaPassedOrFaildAction);
	$('#manager-mbaPassed-no').click(mbaPassedOrFaildAction);
	
	$('#manager-experience-yes').click(experienceAction);
	$('#manager-experience-no').click(experienceAction);
	
	function mbaPassedOrFaildAction()
	{
		if(jQuery('input[id=manager-mbaPassed-yes]').is(':checked')){
			$("#governmentAffiliatedInstituteYesDiv").show();
			resetFieldsAndAttributes(['gmdegreeId', 'gmuniversityId'], true);
  		 }else if(jQuery('input[id=manager-mbaPassed-no]').is(':checked')){
  			$("#governmentAffiliatedInstituteYesDiv").hide();
  			resetFieldsAndAttributes(['gmdegreeId', 'gmuniversityId'], false);
  		 }else
  	  	 {
  			$("#governmentAffiliatedInstituteYesDiv").hide();
  			resetFieldsAndAttributes(['gmdegreeId', 'gmuniversityId'], false);
  	  	 }
	}
	
	function experienceAction()
	{
		if(jQuery('input[id=manager-experience-yes]').is(':checked')){
			$(".managerExperiencedToggle").show();
			resetFieldsAndAttributes(['manager-CompanyName', 'manager-TotalExperienceInYears','manager-TotalExperienceInMonths'], true);
  		 }else if(jQuery('input[id=manager-experience-no]').is(':checked')){
  			$(".managerExperiencedToggle").hide();
  			resetFieldsAndAttributes(['manager-CompanyName', 'manager-TotalExperienceInYears','manager-TotalExperienceInMonths'], false);
  		 }else
  	  	 {
  			$(".managerExperiencedToggle").hide();
  			resetFieldsAndAttributes(['manager-CompanyName', 'manager-TotalExperienceInYears','manager-TotalExperienceInMonths'], false);
  	  	 }
	}
	
	function resetFieldsAndAttributes(idArr, flag)
  	{
  		for (i=0; i<idArr.length; i++){
  			if(flag)
  	  	  		$('#'+idArr[i]+'').prop('required', flag);
  	  		else{
  	  			postSelectionObj.resetTextFieldById(idArr[i]);
  	  			$('#'+idArr[i]+'').prop('required', flag);
  	  	  	}
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
<form class="form-horizontal" name="generalManagerProjectForm" id="generalManagerProjectForm" action="<c:url value='/applicant?operation=saveApplicantPostDetails'/>" method="POST" novalidate>

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${applicantPostAssoc.id}"/>
    <input type="hidden" name="postId" value="${post.postId}"/>
	<input type="hidden" name="status" id="status"  value="${ applicantPostAssoc.status }"/>
	
    <div class="form-group">
        <label class="control-label col-sm-5" for="sscPassed"><fmt:message key="manager.mba.from.government.affiliated.institute"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline" id="mbaPassed-yes-id">
                <input type="radio" name="mbaFromGovernmentAffiliatedInstitute" ${ applicantPostAssoc.mbaFromGovernmentAffiliatedInstitute ? 'checked="checked"':''} value="1" class="form-control" id="manager-mbaPassed-yes">
                <label for="manager-mbaPassed-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline" id="mbaPassed-no-id">
               	<input class="radiosToCheck" type="radio" name="mbaFromGovernmentAffiliatedInstitute" value="0" class="form-control" id="manager-mbaPassed-no" ${ applicantPostAssoc.mbaFromGovernmentAffiliatedInstitute == false ? 'checked="checked"':''}>
                <label for="manager-mbaPassed-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group" id="governmentAffiliatedInstituteYesDiv">
        <label class="control-label col-sm-5" for="degree"><fmt:message key="manager.degree.name"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
                <input type="text" name="degreeName" value="${ applicantPostAssoc.degreeName}" class="form-control" id="gmdegreeId" maxlength="100" placeholder="<fmt:message key="manager.degree.name"/>" >
            <div class="help-block with-errors"></div>
        </div>
        <label class="control-label col-sm-5" for="university"><fmt:message key="manager.university.name"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
                <input type="text" name="universityName" value="${ applicantPostAssoc.universityName}" class="form-control" id="gmuniversityId" maxlength="100" placeholder="<fmt:message key="manager.university.name"/>" >
            <div id="popupId" class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group" id="experienceInCommerce">
	    <label class="control-label col-sm-5">
	    		<fmt:message key="manger.experience.note"/>: <span class="red">*</span>
	    </label>
	    <div class="col-sm-4">
            <div class="radio radio-inline">
                <input type="radio" name="fifteenYearExpInCommerce" ${ applicantPostAssoc.fifteenYearExpInCommerce ? 'checked="checked"':''} value="1" class="form-control" id="manager-experience-yes">
                <label for="manager-experience-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline" id="mbaPassed-no-id">
               	<input class="radiosToCheck" type="radio" name="fifteenYearExpInCommerce" value="0" class="form-control" id="manager-experience-no" ${ applicantPostAssoc.fifteenYearExpInCommerce == false ? 'checked="checked"':''}>
                <label for="manager-experience-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group managerExperiencedToggle">
        <label class="control-label col-sm-5" for="companyName"><fmt:message key="manager.experienced.companyName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.companyName}" type="text" class="form-control" id="manager-CompanyName" placeholder="<fmt:message key="manager.experienced.companyName"/>" name="companyName" maxlength="150">
            <div class="help-block with-errors"></div>
        </div>
    </div>
	
    <div class="form-group managerExperiencedToggle">
        <label class="control-label col-sm-5" for="totalExperienceInYears"><fmt:message key="manager.experienced.totalExperience"/>: <span class="red">*</span></label>
        <div class="col-sm-2">
            <input value="${applicantPostAssoc.totalExperienceInYears}" type="tel" class="form-control" id="manager-TotalExperienceInYears" placeholder="<fmt:message key="manager.experienced.inYears"/>" name="totalExperienceInYears" maxlength="2">
            <div class="help-block with-errors"></div>
        </div>
        <div class="col-sm-2">
            <input value="${applicantPostAssoc.totalExperienceInMonths}" type="tel" class="form-control" id="manager-TotalExperienceInMonths" placeholder="<fmt:message key="manager.experienced.inMonths"/>" name="totalExperienceInMonths" maxlength="2" >
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <jsp:include page="postFooter.jsp">
    	<jsp:param name="isPostSubmitted" value="${ applicantPostAssoc.status eq 2 || applicantPostAssoc.status eq 3 }"/>
    	<jsp:param name="formId" value="generalManagerProjectForm"/>
		<jsp:param name="postId" value="${post.postId}"/>
		<jsp:param name="disableFormAfterLastDateOver" value="${disableFormAfterLastDateOver}"/>
	</jsp:include>
 </form>
  <script>
 $(document).ready(function(){
 $("form[name='generalManagerProjectForm']").validate({
 	rules:{
		 mbaFromGovernmentAffiliatedInstitute : "required",
		 degreeName : {required: true},
		 universityName : {required: true},
		 fifteenYearExpInCommerce : "required",
		 companyName : {required: true},
 		 totalExperienceInYears :{required: true, numbersonly:true, min : 15, max:100},
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