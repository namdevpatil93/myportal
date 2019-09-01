<%@ include file="../../../common/taglibs.jsp"%>

<script>
    jQuery(document).ready(function() {

    	postSelectionObj.disableFormFields ("departmentalStatisticsOfficerForm", '${applicantPostAssoc.status}');
    	postSelectionObj.bindPostForm("departmentalStatisticsOfficerForm");
		var lastDateOver = commonObj.isValidate(${applicantPostAssoc.disableForm});
    	   commonObj.disableFormFields("departmentalStatisticsOfficerForm",lastDateOver);
    	   
    	   if('${applicantPostAssoc.postGraduateDegreeScience}' == true || '${applicantPostAssoc.postGraduateDegreeScience}' == "true")
      		{
      			postSelectionObj.showElementsByClass('departmentalStatisticsOfficerPostGraduateDegreeScienceToggle');
      			postSelectionObj.showElementsByClass('departmentalStatisticsOfficerDegreeNameToggle');
      			postSelectionObj.showElementsByClass('departmentalStatisticsOfficerRequiredQualificationMarksToggle');
      		}
      		else
      		{
      			postSelectionObj.hideElementsByClass('departmentalStatisticsOfficerPostGraduateDegreeScienceToggle');
      			postSelectionObj.hideElementsByClass('departmentalStatisticsOfficerDegreeNameToggle');
      			postSelectionObj.hideElementsByClass('departmentalStatisticsOfficerRequiredQualificationMarksToggle');
      		}
    	   
    	   $( 'form#departmentalStatisticsOfficerForm' ).find('input[type=radio][name=postGraduateDegreeScience]').unbind().change(function() {

    		   if (this.value == '1') {
					jQuery("#departmentalStatisticsOfficerForm").validate().settings.ignore = "";
              		postSelectionObj.showElementsByClass('departmentalStatisticsOfficerPostGraduateDegreeScienceToggle');
              		postSelectionObj.showElementsByClass('departmentalStatisticsOfficerDegreeNameToggle');
              		postSelectionObj.showElementsByClass('departmentalStatisticsOfficerRequiredQualificationMarksToggle');
              		
               } else {
              	 //jQuery("#departmentalStatisticsOfficerForm").validate().settings.ignore = "#departmentalStatisticsOfficerUniversityName";
              	postSelectionObj.resetTextFieldById('departmentalStatisticsOfficerUniversityName');
              	postSelectionObj.resetTextFieldById('departmentalStatisticsOfficerDegreeName');
               	postSelectionObj.resetTextFieldById('departmentalStatisticsOfficerRequiredQualificationMarks');
              	postSelectionObj.hideElementsByClass('departmentalStatisticsOfficerPostGraduateDegreeScienceToggle');
              	postSelectionObj.hideElementsByClass('departmentalStatisticsOfficerDegreeNameToggle');
               	postSelectionObj.hideElementsByClass('departmentalStatisticsOfficerRequiredQualificationMarksToggle');
              	 
               }
           });
    });
    
$( 'form#departmentalStatisticsOfficerForm' ).find('input[type=radio][name=mscitOrGaccc]').unbind().change(function() {
    	
    	if(this.value == '0'){
    		 commonObj.showAgreeDisAgreePopup("<fmt:message key='mscit.equivalent.computer.certificate.alert' />", mscitCertificatePopUpDepartmentalStatisticsOfficer, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
    	     
    	}
    });
    
    function mscitCertificatePopUpDepartmentalStatisticsOfficer(flag)
    {
    	if(!flag)
    	{
    		$('#departmentalStatisticsOfficer-skComputerCourseCertification-yes').prop('checked', true);
      	}
    }
    
</script>

<div id="downloadEligibilityCriteria" class="form-group" align="right">
    <div class="col-sm-12" align="pull-right">
        <a href="javascript:void(0);" onclick="javascript:showEligibilityCriteriaPDF(${post.postId})"><b><fmt:message key="postEligibilityCriteriaLink"/></b></a>
    </div>
</div>

<form class="form-horizontal" name="departmentalStatisticsOfficerForm" id="departmentalStatisticsOfficerForm"
      action="<c:url value='/applicant?operation=saveApplicantPostDetails'/>" method="POST">

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${applicantPostAssoc.id}"/>
    <input type="hidden" name="postId" value="${post.postId}"/>
    <input type="hidden" name="status" id="status"  value="${ applicantPostAssoc.status }"/>

  	<div class="form-group">
        <label class="control-label col-sm-5" for="postGraduateDegreeInScience"><fmt:message key="departmentalStatisticsOfficer.postGraduateDegreeInScience"/> <span class="red">*</span>:</label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="postGraduateDegreeScience" id="departmentalStatisticsOfficer-postGraduateDegreeScience-yes" value="1" type="radio" ${applicantPostAssoc.postGraduateDegreeScience ? 'checked' : ''} />
                <label for="departmentalStatisticsOfficer-postGraduateDegreeScience-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="postGraduateDegreeScience" id="departmentalStatisticsOfficer-postGraduateDegreeScience-no" value="0" type="radio" ${applicantPostAssoc.postGraduateDegreeScience == false ? 'checked' : ''} />
                <label for="departmentalStatisticsOfficer-postGraduateDegreeScience-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group departmentalStatisticsOfficerDegreeNameToggle">
        <label class="control-label col-sm-5" for="departmentalStatisticsOfficerDegreeName"><fmt:message key="departmentalStatisticsOfficer.degreeName"/> <span class="red">*</span>:</label>
        <div class="col-sm-4">
           	<input value="${applicantPostAssoc.degreeName}" name= "degreeName" type="text" class="form-control" id="departmentalStatisticsOfficerDegreeName" placeholder="<fmt:message key="departmentalStatisticsOfficer.degreeName"/>" name="degreeName" maxlength="50">
           	<div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group departmentalStatisticsOfficerPostGraduateDegreeScienceToggle">
        <label class="control-label col-sm-5" for="departmentalStatisticsOfficerUniversityName"><fmt:message key="departmentalStatisticsOfficer.universityName"/> <span class="red">*</span>:</label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.universityName}" type="text" class="form-control" id="departmentalStatisticsOfficerUniversityName" placeholder="<fmt:message key="departmentalStatisticsOfficer.universityName"/>" name="universityName" maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group departmentalStatisticsOfficerRequiredQualificationMarksToggle">
       	<label class="control-label col-sm-5" for="departmentalStatisticsOfficerRequiredQualificationMarks"><fmt:message key="departmentalStatisticsOfficer.marks"/>%<span class="red">*</span>:</label>
    	<div class="col-sm-4">
           	<input value="${applicantPostAssoc.requiredQualificationMarks}" name= "requiredQualificationMarks" type="number" class="form-control" id="departmentalStatisticsOfficerRequiredQualificationMarks" placeholder="<fmt:message key="departmentalStatisticsOfficer.marks"/>" name="requiredQualificationMarks" maxlength="50">
           	<div class="help-block with-errors"></div>
        </div>
    </div>
    
      <div class="form-group">
        <label class="control-label col-sm-5" for="departmentalStatisticsOfficercomputerCourseCertification"><fmt:message key="machine.engineer.isMscIt"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline" >
                <input type="radio" name="mscitOrGaccc" value="1" class="form-control" id="departmentalStatisticsOfficer-skComputerCourseCertification-yes" ${ applicantPostAssoc.mscitOrGaccc ? 'checked="checked"':''}  />
                <label for="departmentalStatisticsOfficer-skComputerCourseCertification-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline" >
               	<input type="radio" name="mscitOrGaccc" value="0" class="form-control" id="departmentalStatisticsOfficer-skComputerCourseCertification-no" ${ applicantPostAssoc.mscitOrGaccc == false ? 'checked="checked"':''}>
                <label for="departmentalStatisticsOfficer-skComputerCourseCertification-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    

    <jsp:include page="../postFooter.jsp">
        <jsp:param name="isPostSubmitted" value="${ applicantPostAssoc.status eq 2 || applicantPostAssoc.status eq 3 }"/>
        <jsp:param name="formId" value="departmentalStatisticsOfficerForm"/>
        <jsp:param name="postId" value="${post.postId}"/>
        <jsp:param name="disableFormAfterLastDateOver" value="${disableFormAfterLastDateOver}"/>
    </jsp:include>

</form>

<script>
    $(document).ready(function(){
    	$("form[name='departmentalStatisticsOfficerForm']").validate({
    	 	rules:{
    	 		postGraduateDegreeScience : "required",
    	 		mscitOrGaccc : "required",
    	 		universityName: {required: true},
    	 		degreeName: {required: true},
    	 		requiredQualificationMarks: {required: true,min:35, max:100},
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