<%@ include file="../../common/taglibs.jsp"%>

<script>

    jQuery(document).ready(function() {

    	postSelectionObj.disableFormFields ("generalManagerInformationTechnologyForm", '${applicantPostAssoc.status}');
    	postSelectionObj.bindPostForm("generalManagerInformationTechnologyForm");
// 		postSelectionObj.submittingForm("generalManagerInformationTechnologyForm");
		checkIfShowOrHideElements();
		var lastDateOver = commonObj.isValidate(${disableFormAfterLastDateOver});
	    commonObj.disableFormFields("generalManagerInformationTechnologyForm",lastDateOver);
    });
    
    function checkIfShowOrHideElements() {
    	if ('${applicantPostAssoc.itEngineer}' == ''||'${applicantPostAssoc.itEngineer}' == 'false') {
    		postSelectionObj.hideElementsByClass('generalManagerInformationTechnologyitEngineerToggle');
    	}
    	
    	if ('${applicantPostAssoc.minTenYrsExpAsItProjectManager}' == '' || '${applicantPostAssoc.minTenYrsExpAsItProjectManager}' == 'false') {
			postSelectionObj.hideElementsByClass('generalManagerInformationTechnologyExperienceToggle');
		}
    }
    
    $( 'form#generalManagerInformationTechnologyForm' ).find('input[type=radio][name=itEngineer]').unbind().change(function() {
        if (this.value == '1') {
        	$('#generalManagerInformationTechnology-degreeName').attr("required", true);
        	$('#generalManagerInformationTechnology-universityName').attr("required", true);
       	 postSelectionObj.showElementsByClass('generalManagerInformationTechnologyitEngineerToggle');
        } else {
        	$('#generalManagerInformationTechnology-degreeName').attr("required", false);
        	$('#generalManagerInformationTechnology-universityName').attr("required", false);
       	 postSelectionObj.hideElementsByClass('generalManagerInformationTechnologyitEngineerToggle');
       	 postSelectionObj.resetTextFieldById('generalManagerInformationTechnology-degreeName');
       	 postSelectionObj.resetTextFieldById('generalManagerInformationTechnology-universityName');
        }
    });
    
    $( 'form#generalManagerInformationTechnologyForm' ).find('input[type=radio][name=minTenYrsExpAsItProjectManager]').unbind().change(function() {
        if (this.value == '1') {
       	 	postSelectionObj.showElementsByClass('generalManagerInformationTechnologyExperienceToggle');
        } else {
	    	postSelectionObj.hideElementsByClass('generalManagerInformationTechnologyExperienceToggle');
	       	postSelectionObj.resetTextFieldById('generalManagerInformationTechnology-companyName');
	       	postSelectionObj.resetTextFieldById('generalManagerInformationTechnology-totalExperienceInYears');
	       	postSelectionObj.resetTextFieldById('generalManagerInformationTechnology-totalExperienceInMonths');
        }
    });
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
<form class="form-horizontal" name="generalManagerInformationTechnologyForm" id="generalManagerInformationTechnologyForm"
      action="<c:url value='/applicant?operation=saveApplicantPostDetails'/>" method="POST">

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${applicantPostAssoc.id}"/>
    <input type="hidden" name="postId" value="${post.postId}"/>
    <input type="hidden" name="status" id="status"  value="${ applicantPostAssoc.status }"/>

    <div class="form-group">
        <label class="control-label col-sm-5"><fmt:message key="post.general.manager.project.informationTechnology.itEngineer"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="itEngineer" id="generalManagerInformationTechnology-itEngineer-yes" value="1" type="radio" ${applicantPostAssoc.itEngineer ? 'checked' : ''} />
                <label for="generalManagerInformationTechnology-itEngineer-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="itEngineer" id="generalManagerInformationTechnology-itEngineer-no" value="0" type="radio" ${applicantPostAssoc.itEngineer == false ? 'checked' : ''} />
                <label for="generalManagerInformationTechnology-itEngineer-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group generalManagerInformationTechnologyitEngineerToggle">
        <label class="control-label col-sm-5 " for="generalManagerInformationTechnology-degreeName"><fmt:message key="post.general.manager.project.informationTechnology.itEngineeringDegreeName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${ applicantPostAssoc.degreeName }" type="text" class="form-control" id="generalManagerInformationTechnology-degreeName" placeholder="<fmt:message key="post.general.manager.project.informationTechnology.itEngineeringDegreeName"/>" name="degreeName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group generalManagerInformationTechnologyitEngineerToggle">
        <label class="control-label col-sm-5" for="generalManagerInformationTechnology-universityName"><fmt:message key="post.general.manager.project.informationTechnology.itEngineeringUniversityName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${ applicantPostAssoc.universityName }" type="text" class="form-control" id="generalManagerInformationTechnology-universityName" placeholder="<fmt:message key="post.general.manager.project.informationTechnology.itEngineeringUniversityName"/>" name="universityName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-5"><fmt:message key="post.general.manager.project.informationTechnology.knowledgeOfSapAndOracle"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="knowledgeOfSapAndOracle" id="generalManagerInformationTechnology-knowledgeOfSapAndOracle-yes" value="1" type="radio" ${applicantPostAssoc.knowledgeOfSapAndOracle ? 'checked' : ''} required/>
                <label for="generalManagerInformationTechnology-knowledgeOfSapAndOracle-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="knowledgeOfSapAndOracle" id="generalManagerInformationTechnology-knowledgeOfSapAndOracle-no" value="0" type="radio" ${applicantPostAssoc.knowledgeOfSapAndOracle == false ? 'checked' : ''} required/>
                <label for="generalManagerInformationTechnology-knowledgeOfSapAndOracle-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-5"><fmt:message key="post.general.manager.project.informationTechnology.minTenYrsExpAsItProjectManager"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="minTenYrsExpAsItProjectManager" id="generalManagerInformationTechnology-minTenYrsExpAsItProjectManager-yes" value="1" type="radio" ${applicantPostAssoc.minTenYrsExpAsItProjectManager ? 'checked' : ''} required/>
                <label for="generalManagerInformationTechnology-minTenYrsExpAsItProjectManager-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="minTenYrsExpAsItProjectManager" id="generalManagerInformationTechnology-minTenYrsExpAsItProjectManager-no" value="0" type="radio" ${applicantPostAssoc.minTenYrsExpAsItProjectManager == false? 'checked' : ''} required/>
                <label for="generalManagerInformationTechnology-minTenYrsExpAsItProjectManager-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group generalManagerInformationTechnologyExperienceToggle">
        <label class="control-label col-sm-5" for="generalManagerInformationTechnology-companyName"><fmt:message key="generalManagerInformationTechnology.experienced.companyName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.companyName}" type="text" class="form-control" id="generalManagerInformationTechnology-companyName" placeholder="<fmt:message key="generalManagerInformationTechnology.experienced.companyName"/>" name="companyName"  maxlength="150">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group generalManagerInformationTechnologyExperienceToggle">
        <label class="control-label col-sm-5" for="generalManagerInformationTechnology-totalExperienceInYears"><fmt:message key="generalManagerInformationTechnology.experienced.totalExperience"/>: <span class="red">*</span></label>
        <div class="col-sm-2">
            <input value="${applicantPostAssoc.totalExperienceInYears}" type="tel" class="form-control" id="generalManagerInformationTechnology-totalExperienceInYears" placeholder="<fmt:message key="generalManagerInformationTechnology.experienced.totalExperienceInYears"/>" name="totalExperienceInYears"  min="0" maxlength="2">
            <div class="help-block with-errors"></div>
        </div>
        <div class="col-sm-2">
            <input value="${applicantPostAssoc.totalExperienceInMonths}" type="tel" class="form-control" id="generalManagerInformationTechnology-totalExperienceInMonths" placeholder="<fmt:message key="generalManagerInformationTechnology.experienced.totalExperienceInMonths"/>" name="totalExperienceInMonths"  min="0" maxlength="2">
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <jsp:include page="postFooter.jsp">
    	<jsp:param name="isPostSubmitted" value="${ applicantPostAssoc.status eq 2 || applicantPostAssoc.status eq 3 }"/>
    	<jsp:param name="formId" value="generalManagerInformationTechnologyForm"/>
        <jsp:param name="postId" value="${post.postId}"/>
        <jsp:param name="disableFormAfterLastDateOver" value="${disableFormAfterLastDateOver}"/>
    </jsp:include>

</form>

<script>
 $(document).ready(function(){
 $("form[name='generalManagerInformationTechnologyForm']").validate({
 	rules:{
 		 itEngineer : "required",
 		 knowledgeOfSapAndOracle : "required", 
 		 minTenYrsExpAsItProjectManager : "required",
 		 degreeName: {required: true},
 		 universityName: {required: true},
 		 minTenYrsExpAsItProjectManager : "required",
 		 companyName : {required: true},
 		 totalExperienceInYears :{required: true, numbersonly:true, min : 10},
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