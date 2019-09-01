<%@ include file="../../common/taglibs.jsp"%>
<script>
	$(document).ready(function() {
		postSelectionObj.disableFormFields ("securityInspectorJuniorForm", '${applicantPostAssoc.status}');
		postSelectionObj.bindPostForm("securityInspectorJuniorForm");
		
// 		jQuery("#securityInspectorJuniorForm").ajaxForm({
// 	        dataType:  'json',
// 	        beforeSubmit:  function() {
// 	            if (!$('#securityInspectorJuniorForm').validator('validate').has('.has-error').length) {
// 	                return true;
// 	            } else {
// 	                return false;
// 	            }
// 	        },
// 	        success:  function(result) {
// 	            var success = result.success;
// 	            if(success){
// 	                postSelectionObj.goToNextPost();
// 	                return false;
// 	            } else {
// 	                commonObj.showAlert("There was some error while trying to save the Driver form.");
// 	            }
// 	        }

// 	    });	  
		
		checkIfShowOrHideElements();

		var lastDateOver = commonObj.isValidate(${disableFormAfterLastDateOver});
		commonObj.disableFormFields("securityInspectorJuniorForm",lastDateOver);
	});
	
	function checkIfShowOrHideElements() {
		if ( '${applicantPostAssoc.graduateFromAffiliatedInstitute}' == '' || '${applicantPostAssoc.graduateFromAffiliatedInstitute}' == 'false') {
			postSelectionObj.hideElementsByClass('securityInspectorGraduateFromAffiliatedInstituteToggle');
		}
	}
	
	$( 'form#securityInspectorJuniorForm' ).find('input[type=radio][name=graduateFromAffiliatedInstitute]').unbind().change(function() {
        if (this.value == '1') {
       	 	postSelectionObj.showElementsByClass('securityInspectorGraduateFromAffiliatedInstituteToggle');
        } else {
	       	postSelectionObj.hideElementsByClass('securityInspectorGraduateFromAffiliatedInstituteToggle');
	       	postSelectionObj.resetTextFieldById('securityInspector-degreeName');
	       	postSelectionObj.resetTextFieldById('securityInspector-universityName');
        }
    });
	/*
	function showEligibilityCriteriaPDF() {
		var url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/viewPdf.pdf'/>";
		window.open(url,'_blank');
	}*/
</script>   
 <c:if test="${ !formReadOnly }">
	<div class="form-group">
	   <div class="pull-right">
            <a href="javascript:void(0);" onclick="javascript:showEligibilityCriteriaPDF(${post.postId})"><b><fmt:message key="postEligibilityCriteriaLink"/></b></a><br>
	       <a href="javascript:void(0);" data-toggle="modal" data-target="#securityInspectorJuniorPopup"><b><fmt:message key="physicaltest"/></b></a>
	   </div>
	</div>
</c:if>
<form class="form-horizontal" name="securityInspectorJuniorForm" id="securityInspectorJuniorForm" action="<c:url value='/applicant?operation=saveApplicantPostDetails'/>" method="POST">

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${applicantPostAssoc.id}"/>
    <input type="hidden" name="postId" value="${post.postId}"/>
    <input type="hidden" name="status" id="status"  value="${ applicantPostAssoc.status }"/>
    
    <div class="form-group">
        <label class="control-label col-sm-5" for="graduateFromAffiliatedInstitute"><fmt:message key="securityInspector.graduateFromAffiliatedInstitute"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="graduateFromAffiliatedInstitute" id="securityInspector-graduateFromAffiliatedInstitute-yes" value="1" type="radio" ${applicantPostAssoc.graduateFromAffiliatedInstitute ? 'checked' : ''} />
                <label for="securityInspector-graduateFromAffiliatedInstitute-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="graduateFromAffiliatedInstitute" id="securityInspector-graduateFromAffiliatedInstitute-no" value="0" type="radio" ${applicantPostAssoc.graduateFromAffiliatedInstitute == false ? 'checked' : ''} />
                <label for="securityInspector-graduateFromAffiliatedInstitute-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    
    <div class="form-group securityInspectorGraduateFromAffiliatedInstituteToggle">
        <label class="control-label col-sm-5" for="securityInspector-degreeName"><fmt:message key="securityInspector.graduateFromAffiliatedInstitute.degreeName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.degreeName}" type="text" class="form-control" id="securityInspector-degreeName" placeholder="<fmt:message key="securityInspector.graduateFromAffiliatedInstitute.degreeName"/>" name="degreeName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group securityInspectorGraduateFromAffiliatedInstituteToggle">
        <label class="control-label col-sm-5" for="securityInspector-universityName"><fmt:message key="securityInspector.graduateFromAffiliatedInstitute.universityName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.universityName}" type="text" class="form-control" id="securityInspector-universityName" placeholder="<fmt:message key="securityInspector.graduateFromAffiliatedInstitute.universityName"/>" name="universityName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
 <%--    <div class="form-group">
        <label class="control-label col-sm-5" for="securityInspector-otherQualificationDetails"><fmt:message key="securityInspector.otherQualificationDetails"/>:</label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.otherQualificationDetails}" type="text" class="form-control" id="securityInspector-otherQualificationDetails" placeholder="<fmt:message key="securityInspector.otherQualificationDetails"/>" name="otherQualificationDetails" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div> --%>
    
    <div class="form-group">
        <label class="control-label col-sm-5" for="height"><fmt:message key="securityInspector.mscitOrGaccc"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="mscitOrGaccc" id="securityInspector-mscitOrGaccc-yes" value="1" type="radio" ${applicantPostAssoc.mscitOrGaccc ? 'checked' : ''} />
                <label for="securityInspector-mscitOrGaccc-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="mscitOrGaccc" id="securityInspector-mscitOrGaccc-no" value="0" type="radio" ${applicantPostAssoc.mscitOrGaccc == false ? 'checked' : ''} />
                <label for="securityInspector-mscitOrGaccc-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group">
        <label class="control-label col-sm-5" for="height"><fmt:message key="securityInspector.heightWithinRange"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="heightWithinRange" id="securityInspector-heightWithinRange-yes" value="1" type="radio" ${applicantPostAssoc.heightWithinRange ? 'checked' : ''} />
                <label for="securityInspector-heightWithinRange-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="heightWithinRange" id="securityInspector-heightWithinRange-no" value="0" type="radio" ${applicantPostAssoc.heightWithinRange == false ? 'checked' : ''} />
                <label for="securityInspector-heightWithinRange-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <jsp:include page="postFooter.jsp">
    	<jsp:param name="isPostSubmitted" value="${ applicantPostAssoc.status eq 2 || applicantPostAssoc.status eq 3 }"/>
    	<jsp:param name="formId" value="securityInspectorJuniorForm"/>
        <jsp:param name="postId" value="${post.postId}"/>
        <jsp:param name="disableFormAfterLastDateOver" value="${disableFormAfterLastDateOver}"/>
    </jsp:include>
    
    <jsp:include page="eligibilityCriterias/securityInspectorJr.jsp"/>
</form>


<script>
 $(document).ready(function(){
 $("form[name='securityInspectorJuniorForm']").validate({
 	rules:{
 		 graduateFromAffiliatedInstitute : "required",
 		 degreeName: {required: true},
 		 universityName: {required: true},
 		 heightWithinRange : "required",
 		 mscitOrGaccc : "required"
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