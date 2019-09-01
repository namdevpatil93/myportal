<%@ include file="../../../common/taglibs.jsp"%>

<script>
    jQuery(document).ready(function() {
    	postSelectionObj.disableFormFields ("storeOfficerForm", '${applicantPostAssoc.status}');
    	postSelectionObj.bindPostForm("storeOfficerForm");
    	var lastDateOver = commonObj.isValidate(${disableFormAfterLastDateOver});
    	   commonObj.disableFormFields("storeOfficerForm",lastDateOver);
    	   
    	   
    	   //====================================
    		   
    		    if('${applicantPostAssoc.isFirstClassDegree}' == true || '${applicantPostAssoc.isFirstClassDegree}' == "true")
		{
			postSelectionObj.showElementsByClass('storeOfficerDegreeNameToggle');
			postSelectionObj.showElementsByClass('storeOfficerUniversityNameToggle');
			postSelectionObj.showElementsByClass('storeOfficerRequiredQualificationMarksToggle');
			postSelectionObj.hideElementsByClass('storeOfficerPostGraduateDegreeNameToggle');
			postSelectionObj.hideElementsByClass('storeOfficerPostGraduateMarksToggle');
			postSelectionObj.hideElementsByClass('storeOfficerPostGradDegreeInstituteNameToggle');
		}
   else if('${applicantPostAssoc.isFirstClassDegree}' == "false")
	{
	    	postSelectionObj.hideElementsByClass('storeOfficerDegreeNameToggle');
			postSelectionObj.hideElementsByClass('storeOfficerUniversityNameToggle');
			postSelectionObj.hideElementsByClass('storeOfficerRequiredQualificationMarksToggle');
			postSelectionObj.showElementsByClass('storeOfficerPostGraduateDegreeNameToggle');
			postSelectionObj.showElementsByClass('storeOfficerPostGraduateMarksToggle');
			postSelectionObj.showElementsByClass('storeOfficerPostGradDegreeInstituteNameToggle');
	}
		else
		{
			postSelectionObj.hideElementsByClass('storeOfficerDegreeNameToggle');
			postSelectionObj.hideElementsByClass('storeOfficerUniversityNameToggle');
			postSelectionObj.hideElementsByClass('storeOfficerRequiredQualificationMarksToggle');
			postSelectionObj.hideElementsByClass('storeOfficerPostGraduateDegreeNameToggle');
			postSelectionObj.hideElementsByClass('storeOfficerPostGraduateMarksToggle');
			postSelectionObj.hideElementsByClass('storeOfficerPostGradDegreeInstituteNameToggle');
		}
    
    if('${applicantPostAssoc.isSecondClassInMBA}' == true || '${applicantPostAssoc.isSecondClassInMBA}' == "true")
		{
	   		postSelectionObj.showElementsByClass('storeOfficerMBADegreeNameToggle');
			postSelectionObj.showElementsByClass('storeOfficerMBAUniversityToggle');
			postSelectionObj.showElementsByClass('storeOfficerMBAMarksToggle');
			postSelectionObj.hideElementsByClass('storeOfficerIcwaDiplomaNameToggle');
			postSelectionObj.hideElementsByClass('storeOfficerIcwaUniversityNameToggle');
			postSelectionObj.hideElementsByClass('storeOfficerIcwaMarksToggle');
		}
   else if('${applicantPostAssoc.isSecondClassInMBA}' == "false")
	{
	    postSelectionObj.hideElementsByClass('storeOfficerMBADegreeNameToggle');
		postSelectionObj.hideElementsByClass('storeOfficerMBAUniversityToggle');
		postSelectionObj.hideElementsByClass('storeOfficerMBAMarksToggle');
		postSelectionObj.showElementsByClass('storeOfficerIcwaDiplomaNameToggle');
		postSelectionObj.showElementsByClass('storeOfficerIcwaUniversityNameToggle');
		postSelectionObj.showElementsByClass('storeOfficerIcwaMarksToggle');
	}    		   
   else
	{
	   		postSelectionObj.hideElementsByClass('storeOfficerMBADegreeNameToggle');
			postSelectionObj.hideElementsByClass('storeOfficerMBAUniversityToggle');
			postSelectionObj.hideElementsByClass('storeOfficerMBAMarksToggle');
			postSelectionObj.hideElementsByClass('storeOfficerIcwaDiplomaNameToggle');
			postSelectionObj.hideElementsByClass('storeOfficerIcwaUniversityNameToggle');
			postSelectionObj.hideElementsByClass('storeOfficerIcwaMarksToggle');
	}
    });
    
   
    
    $( 'form#storeOfficerForm' ).find('input[type=radio][name=isFirstClassDegree]').unbind().change(function() {
        if (this.value == '1') {
       	 jQuery("#storeOfficerForm").validate().settings.ignore = "";
       	$('#storeOfficerPostGraduateMarks').val(0);
       	 postSelectionObj.showElementsByClass('storeOfficerDegreeNameToggle');
       	 postSelectionObj.showElementsByClass('storeOfficerUniversityNameToggle');
       	 postSelectionObj.showElementsByClass('storeOfficerRequiredQualificationMarksToggle');
       	postSelectionObj.hideElementsByClass('storeOfficerPostGraduateDegreeNameToggle');
        postSelectionObj.hideElementsByClass('storeOfficerPostGraduateMarksToggle');
        postSelectionObj.hideElementsByClass('storeOfficerPostGradDegreeInstituteNameToggle');
        } else {
       	// jQuery("#departmentalAccountsOfficerForm").validate().settings.ignore = "#departmentalAccountsOfficerUniversityName";
       	postSelectionObj.resetTextFieldById('storeOfficerDegreeName');
       	postSelectionObj.resetTextFieldById('storeOfficerUniversityName');
       	postSelectionObj.resetTextFieldById('storeOfficerRequiredQualificationMarks');
       	postSelectionObj.hideElementsByClass('storeOfficerDegreeNameToggle');
       	postSelectionObj.hideElementsByClass('storeOfficerUniversityNameToggle');
       	postSelectionObj.hideElementsByClass('storeOfficerRequiredQualificationMarksToggle');
       	postSelectionObj.resetTextFieldById('storeOfficerPostGraduateDegreeName');
       	postSelectionObj.resetTextFieldById('storeOfficerPostGraduateMarks');
       	postSelectionObj.resetTextFieldById('storeOfficerPostGradDegreeInstituteName');
        postSelectionObj.showElementsByClass('storeOfficerPostGraduateDegreeNameToggle');
        postSelectionObj.showElementsByClass('storeOfficerPostGraduateMarksToggle');
        postSelectionObj.showElementsByClass('storeOfficerPostGradDegreeInstituteNameToggle');
        $('#storeOfficerRequiredQualificationMarks').val(0);
        }
    });
    
    $( 'form#storeOfficerForm' ).find('input[type=radio][name=isSecondClassInMBA]').unbind().change(function() {
        if (this.value == '1') {
       	 jQuery("#storeOfficerForm").validate().settings.ignore = "";
       	 postSelectionObj.showElementsByClass('storeOfficerMBADegreeNameToggle');
      	 postSelectionObj.showElementsByClass('storeOfficerMBAUniversityToggle');
      	 postSelectionObj.showElementsByClass('storeOfficerMBAMarksToggle');
      	postSelectionObj.hideElementsByClass('storeOfficerIcwaDiplomaNameToggle');
       	postSelectionObj.hideElementsByClass('storeOfficerIcwaUniversityNameToggle');
       	postSelectionObj.hideElementsByClass('storeOfficerIcwaMarksToggle');
       	$('#storeOfficerIcwaMarks').val(0);
        } else {
        	postSelectionObj.resetTextFieldById('storeOfficerMBADegreeName');
           	postSelectionObj.resetTextFieldById('storeOfficerMBAUniversity');
           	postSelectionObj.resetTextFieldById('storeOfficerMBAMarks');
           	postSelectionObj.hideElementsByClass('storeOfficerMBADegreeNameToggle');
           	postSelectionObj.hideElementsByClass('storeOfficerMBAUniversityToggle');
           	postSelectionObj.hideElementsByClass('storeOfficerMBAMarksToggle');
           	postSelectionObj.resetTextFieldById('storeOfficerIcwaDiplomaName');
           	postSelectionObj.resetTextFieldById('storeOfficerIcwaUniversityName');
           	postSelectionObj.resetTextFieldById('storeOfficerIcwaMarks');
           	postSelectionObj.showElementsByClass('storeOfficerIcwaDiplomaNameToggle');
           	postSelectionObj.showElementsByClass('storeOfficerIcwaUniversityNameToggle');
           	postSelectionObj.showElementsByClass('storeOfficerIcwaMarksToggle');
           	$('#storeOfficerMBAMarks').val(0);
        }
    });
    
    
$( 'form#storeOfficerForm' ).find('input[type=radio][name=mscitOrGaccc]').unbind().change(function() {
    	
    	if(this.value == '0'){
    		 commonObj.showAgreeDisAgreePopup("<fmt:message key='mscit.equivalent.computer.certificate.alert' />", mscitCertificatePopUpStoreOfficer, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
    	     
    	}
    });
    
    function mscitCertificatePopUpStoreOfficer(flag)
    {
    	if(!flag)
    	{
    		$('#storeOfficer-skComputerCourseCertification-yes').prop('checked', true);
      	}
    }
    
</script>

<div id="downloadEligibilityCriteria" class="form-group" align="right">
    <div class="col-sm-12" align="pull-right">
        <a href="javascript:void(0);" onclick="javascript:showEligibilityCriteriaPDF(${post.postId})"><b><fmt:message key="postEligibilityCriteriaLink"/></b></a>
    </div>
</div>

<form class="form-horizontal" name="storeOfficerForm" id="storeOfficerForm" 
	action="<c:url value='/applicant?operation=saveApplicantPostDetails'/>" method="POST">

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${applicantPostAssoc.id}"/>
    <input type="hidden" name="postId" value="${post.postId}"/>
    <input type="hidden" name="status" id="status"  value="${ applicantPostAssoc.status }"/>

	<div class="form-group">
        <label class="control-label col-sm-5" for="FirstClassDegree"><fmt:message key="storeOfficer.firstClassDegreeInEngineering"/>: <span class="red">*</span></label>
         <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="isFirstClassDegree" id="storeOfficer-isFirstClassDegree-yes" value="1" type="radio" ${applicantPostAssoc.isFirstClassDegree ? 'checked' : ''} />
                <label for="storeOfficer-isFirstClassDegree-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input  name="isFirstClassDegree" id="storeOfficer-isFirstClassDegree-no" value="0" type="radio" ${applicantPostAssoc.isFirstClassDegree == false ? 'checked' : ''} />
                <label for="storeOfficer-isFirstClassDegree-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
     <div class="form-group storeOfficerDegreeNameToggle">
        <label class="control-label col-sm-5" for="DegreeName"><fmt:message key="storeOfficer.degreeName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.degreeName}" name= "degreeName" type="text" class="form-control" id="storeOfficerDegreeName" placeholder="<fmt:message key="storeOfficer.degreeName"/>" maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
	<div class="form-group storeOfficerUniversityNameToggle">
    	<label class="control-label col-sm-5" for="UniversityName"><fmt:message key="storeOfficer.universityName"/>: <span class="red">*</span></label>
    	<div class="col-sm-4">
        	<input value="${applicantPostAssoc.universityName}" name= "universityName" type="text" class="form-control" id="storeOfficerUniversityName" placeholder="<fmt:message key="storeOfficer.universityName"/>" name="universityName" maxlength="50">
        	<div class="help-block with-errors"></div>
        </div>
    </div>
 
        <div class="form-group storeOfficerRequiredQualificationMarksToggle">
        <label class="control-label col-sm-5" for="requiredQualificationMark"><fmt:message key="storeOfficer.marks"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.requiredQualificationMarks}" type="number" class="form-control" id="storeOfficerRequiredQualificationMarks" placeholder="<fmt:message key="storeOfficer.marks"/>" name="requiredQualificationMarks" maxlength="5" min="1" max="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <%-- 	<div class="form-group storeOfficerRequiredQualificationMarksToggle">
    	<label class="control-label col-sm-5" for="RequiredQualificationMarks"><fmt:message key="storeOfficer.marks"/>%:<span class="red">*</span></label>
    	<div class="col-sm-4">
           	<input value="${applicantPostAssoc.requiredQualificationMarks}" name= "requiredQualificationMarks" type="number" class="form-control" id="storeOfficerRequiredQualificationMarks" placeholder="<fmt:message key="storeOfficer.marks"/>" maxlength="50">
           	<div class="help-block with-errors"></div>
       	</div>
    </div> --%>
    
     <div class="form-group storeOfficerPostGraduateDegreeNameToggle">
        <label class="control-label col-sm-5" for="storeOfficerPostGraduateDegree"><fmt:message key="storeOfficer.postGraduateDegreeName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.postGraduateDegreeName}" name= "postGraduateDegreeName" type="text" class="form-control" id="storeOfficerPostGraduateDegreeName" placeholder="<fmt:message key="storeOfficer.postGraduateDegreeName"/>" maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
    </div>
       
     	<div class="form-group storeOfficerPostGradDegreeInstituteNameToggle">
    	<label class="control-label col-sm-5" for="storeOfficerPostUniversityName"><fmt:message key="storeOfficer.universityName"/>: <span class="red">*</span></label>
    	<div class="col-sm-4">
        	<input value="${applicantPostAssoc.postGradDegreeInstituteName}" name= "postGradDegreeInstituteName" type="text" class="form-control" id="storeOfficerPostGradDegreeInstituteName" placeholder="<fmt:message key="storeOfficer.universityName"/>" maxlength="50">
        	<div class="help-block with-errors"></div>
        </div>
    </div>
        <div class="form-group storeOfficerPostGraduateMarksToggle">
        <label class="control-label col-sm-5" for="storeOfficerPostGraduateMark"><fmt:message key="storeOfficer.marks"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.postGraduateMarks}" type="number" class="form-control" id="storeOfficerPostGraduateMarks" placeholder="<fmt:message key="storeOfficer.marks"/>" name="postGraduateMarks" maxlength="5" min="1" max="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    
<%-- 	<div class="form-group storeOfficerPostGraduateMarksToggle">
        <label class="control-label col-sm-5" for="storeOfficerPostGraduateMark"><fmt:message key="storeOfficer.marks"/>%: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.postGraduateMarks}" name= "postGraduateMarks" type="text" class="form-control" id="storeOfficerPostGraduateMarks" placeholder="<fmt:message key="storeOfficer.marks"/>" maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
    </div> --%>

 	<div class="form-group">
        <label class="control-label col-sm-5" for="secondClassInMBA"><fmt:message key="storeOfficer.2ndClassInMBA"/>: <span class="red">*</span></label>
         <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="isSecondClassInMBA" id="storeOfficer-secondClassInMBA-yes" value="1" type="radio" ${applicantPostAssoc.isSecondClassInMBA ? 'checked' : ''} />
                <label for="storeOfficer-secondClassInMBA-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input name="isSecondClassInMBA" id="storeOfficer-secondClassInMBA-no" value="0" type="radio" ${applicantPostAssoc.isSecondClassInMBA == false ? 'checked' : ''} />
                <label for="storeOfficer-secondClassInMBA-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>

	<div class="form-group storeOfficerMBADegreeNameToggle">
		<label class="control-label col-sm-5" for="storeOfficerMBADegreeName"><fmt:message key="storeOfficer.postGraduateDegreeMBA" />: <span class="red">*</span></label>
		<div class="col-sm-4">
			<input value="${applicantPostAssoc.mbaDegreeName}" name="mbaDegreeName" type="text" class="form-control" id="storeOfficerMBADegreeName" placeholder="<fmt:message key="storeOfficer.postGraduateDegreeMBA"/>" maxlength="50">
			<div class="help-block with-errors"></div>
		</div>
	</div>

	<div class="form-group storeOfficerMBAUniversityToggle">
    	<label class="control-label col-sm-5" for="MBAUniversity"><fmt:message key="storeOfficer.universityName"/>: <span class="red">*</span></label>
    	<div class="col-sm-4">
        	<input value="${applicantPostAssoc.mbaUniversity}" name="mbaUniversity" type="text" class="form-control" id="storeOfficerMBAUniversity" placeholder="<fmt:message key="storeOfficer.universityName"/>" maxlength="50"/>
        	<div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group storeOfficerMBAMarksToggle">
        <label class="control-label col-sm-5" for="MBAMarks"><fmt:message key="storeOfficer.marks"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.mbaMarks}" type="number" class="form-control" id="storeOfficerMBAMarks" placeholder="<fmt:message key="storeOfficer.marks"/>" name="mbaMarks" maxlength="5" min="1" max="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
<%--     	<div class="form-group storeOfficerMBAMarksToggle">
    	<label class="control-label col-sm-5" for="MBAMarks"><fmt:message key="storeOfficer.marks"/>%:<span class="red">*</span></label>
    	<div class="col-sm-4">
           	<input value="${applicantPostAssoc.mbaMarks}" name="mbaMarks" type="text" class="form-control" id="storeOfficerMBAMarks" placeholder="<fmt:message key="storeOfficer.marks"/>" maxlength="50">
           	<div class="help-block with-errors"></div>
       	</div>
    </div> --%>
    
    <div class="form-group storeOfficerIcwaDiplomaNameToggle">
        <label class="control-label col-sm-5" for="IcwaDiplomaName"><fmt:message key="storeOfficer.icwaDiplomaName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.icwaDiplomaName}" name="icwaDiplomaName" type="text" class="form-control" id="storeOfficerIcwaDiplomaName" placeholder="<fmt:message key="storeOfficer.icwaDiplomaName"/>" maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
        	<div class="form-group storeOfficerIcwaUniversityNameToggle">
    	<label class="control-label col-sm-5" for="IcwaUniversityName"><fmt:message key="storeOfficer.universityName"/>: <span class="red">*</span></label>
    	<div class="col-sm-4">
        	<input value="${applicantPostAssoc.icwaUniversityName}" name="icwaUniversityName" type="text" class="form-control" id="storeOfficerIcwaUniversityName" placeholder="<fmt:message key="storeOfficer.universityName"/>" maxlength="50">
        	<div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group storeOfficerIcwaMarksToggle">
        <label class="control-label col-sm-5" for="IcwaMarks"><fmt:message key="storeOfficer.marks"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.icwaMarks}" type="number" class="form-control" id="storeOfficerIcwaMarks" placeholder="<fmt:message key="storeOfficer.marks"/>" name="icwaMarks" maxlength="5" min="1" max="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
<%--     <div class="form-group storeOfficerIcwaMarksToggle">
    	<label class="control-label col-sm-5" for="IcwaMarks"><fmt:message key="storeOfficer.marks"/>%:<span class="red">*</span></label>
    	<div class="col-sm-4">
           	<input value="${applicantPostAssoc.icwaMarks}" name="icwaMarks" type="text" class="form-control" id="storeOfficerIcwaMarks" placeholder="<fmt:message key="storeOfficer.marks"/>" maxlength="50">
           	<div class="help-block with-errors"></div>
       	</div>
    </div> --%>
    
    <div class="form-group">
        <label class="control-label col-sm-5" for="storeOfficercomputerCourseCertification"><fmt:message key="machine.engineer.isMscIt"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline" >
                <input type="radio" name="mscitOrGaccc" value="1" class="form-control" id="storeOfficer-skComputerCourseCertification-yes" ${ applicantPostAssoc.mscitOrGaccc ? 'checked="checked"':''}  />
                <label for="storeOfficer-skComputerCourseCertification-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline" >
               	<input type="radio" name="mscitOrGaccc" value="0" class="form-control" id="storeOfficer-skComputerCourseCertification-no" ${ applicantPostAssoc.mscitOrGaccc == false ? 'checked="checked"':''}>
                <label for="storeOfficer-skComputerCourseCertification-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
     <jsp:include page="../postFooter.jsp">
        <jsp:param name="isPostSubmitted" value="${ applicantPostAssoc.status eq 2 || applicantPostAssoc.status eq 3 }"/>
        <jsp:param name="formId" value="storeOfficerForm"/>
        <jsp:param name="postId" value="${post.postId}"/>
        <jsp:param name="disableFormAfterLastDateOver" value="${disableFormAfterLastDateOver}"/>
    </jsp:include>

</form>

<script>
    $(document).ready(function(){
    	$("form[name='storeOfficerForm']").validate({
    	 	rules:{
    	 		isFirstClassDegree : "required",
    	 		degreeName: "required",
    	 		mscitOrGaccc :"required",
    	 		universityName: "required",
    	 		requiredQualificationMarks : {required: true, min: 60},
    	 		postGraduateDegreeName : "required",
    	 		postGradDegreeInstituteName: "required",
    	 		postGraduateMarks : {required: true, min: 45}, 
    	 		isSecondClassInMBA: "required",
    	 		mbaDegreeName: "required",
    	 		mbaUniversity : "required",
    	 		mbaMarks: {required: true, min: 45},
    	 		icwaDiplomaName : "required",
    	 		icwaUniversityName :"required", 
    	 		icwaMarks : "required"
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