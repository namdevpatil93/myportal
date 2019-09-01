<%@ include file="../../common/taglibs.jsp"%>

 <script type="text/javascript">
 
  $( document ).ready(function ()
  {
	  postSelectionObj.disableFormFields ("draftsmanMechanicsJuniorForm", '${applicantPostAssoc.status}');
	  postSelectionObj.bindPostForm("draftsmanMechanicsJuniorForm");
	  
	  experienceInHandAction();
	  draftsmanAutomobileORMechanicalHoldersAction();
	  draftsmanDiplomaInAutocadAction();
	  autocadCertificationAction();
	  var lastDateOver = commonObj.isValidate(${disableFormAfterLastDateOver});
      commonObj.disableFormFields("draftsmanMechanicsJuniorForm",lastDateOver);
  });
	//-------------------- experienceInHand start --------------------
	$('#draftsmanExperienceInHand-yes').click(experienceInHandAction);
	$('#draftsmanExperienceInHand-no').click(experienceInHandAction);
	
	function experienceInHandAction()
	{
		if(jQuery('input[id=draftsmanExperienceInHand-yes]').is(':checked')){
			$("#draftsmanExperienceInHandYesDiv").show();
			resetFieldsAndAttributes(['companyNameId','assistantJuniorTotalExperienceInMonths', 'assistantJuniorTotalExperienceInYears'], true);
  		 }else if(jQuery('input[id=draftsmanExperienceInHand-no]').is(':checked')){
  			$("#draftsmanExperienceInHandYesDiv").hide();
  			resetFieldsAndAttributes(['companyNameId','assistantJuniorTotalExperienceInMonths', 'assistantJuniorTotalExperienceInYears'], false);
  		 }
  		else
	  	 {
  			$("#draftsmanExperienceInHandYesDiv").hide(); 
	  	 }
	}
  //------------------- experienceInHand end -------------------
  
  // ------------------ bachlorOrDiplomaHolders start ----------------
  	$('#draftsmanAutomobileORMechanicalHolders-yes').click(draftsmanAutomobileORMechanicalHoldersAction);
	$('#draftsmanAutomobileORMechanicalHolders-no').click(draftsmanAutomobileORMechanicalHoldersAction);
	
  	function draftsmanAutomobileORMechanicalHoldersAction()
	{
  		if(jQuery('input[id=draftsmanAutomobileORMechanicalHolders-yes]').is(':checked')){
  			$("#draftsmanAutomobileORMechanicalHoldersYesDiv").show();
  			resetFieldsAndAttributes(['degreeId', 'universityId'], true);
  		 }else if(jQuery('input[id=draftsmanAutomobileORMechanicalHolders-no]').is(':checked')){
  			$("#draftsmanAutomobileORMechanicalHoldersYesDiv").hide();
  			 resetFieldsAndAttributes(['degreeId', 'universityId'], false);
  		 }
  		 else
	  	 {
  			$("#draftsmanAutomobileORMechanicalHoldersYesDiv").hide(); 
	  	 }
  	}
  // ------------------ bachlorOrDiplomaHolders end ----------------
  // ------------------ draftsmanDiplomaInAutocad start ----------------
    $('#draftsmanDiplomaInAutocad-yes').click(draftsmanDiplomaInAutocadAction);
	$('#draftsmanDiplomaInAutocad-no').click(draftsmanDiplomaInAutocadAction);
	
	function draftsmanDiplomaInAutocadAction()
	{
		if(jQuery('input[id=draftsmanDiplomaInAutocad-yes]').is(':checked')){
			$("#draftsmanDiplomaInAutocadYesDiv").show();
			resetFieldsAndAttributes(['diplomaInAutocadUniversityId'], true);
  		 }else if(jQuery('input[id=draftsmanDiplomaInAutocad-no]').is(':checked')){
  			$("#draftsmanDiplomaInAutocadYesDiv").hide();
  			resetFieldsAndAttributes(['diplomaInAutocadUniversityId'], false);
  		 }
  		else
 	  	 {
  			$("#draftsmanDiplomaInAutocadYesDiv").hide(); 
 	  	 }
	}
	// ------------------ draftsmanDiplomaInAutocad end ----------------
 	// ------------------ draftsmanAutocadCertification start ----------------
 	$('#autocadCertification-yes').click(autocadCertificationAction);
	$('#autocadCertification-no').click(autocadCertificationAction);
	
	function autocadCertificationAction()
	{
		//$("#checkSurfaceEnvironment-1").is(":checked")
		if(jQuery('input[id=autocadCertification-yes]').is(':checked')){
			$("#autocadCertificationYesDiv").show();
			resetFieldsAndAttributes(['autocadCertificationInstituteId'], true);
  		 }else if(jQuery('input[id=autocadCertification-no]').is(':checked')){
  			$("#autocadCertificationYesDiv").hide();
  			resetFieldsAndAttributes(['autocadCertificationInstituteId'], false);
  		 }
  		 else
  	  	 {
  			$("#autocadCertificationYesDiv").hide(); 
  	  	 }
	}
	 // ------------------ draftsmanAutocadCertification end ----------------
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
</script>

<form class="form-horizontal" name="draftsmanMechanicsJuniorForm" id="draftsmanMechanicsJuniorForm" data-toggle="validator" action="<c:url value='/applicant?operation=saveApplicantPostDetails'/>" method="POST">

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${applicantPostAssoc.id}"/>
    <input type="hidden" name="postId" value="${post.postId}"/>
    <input type="hidden" name="status" id="status"  value="${ applicantPostAssoc.status }"/>
    
     <div class="form-group">
        <label class="control-label col-sm-5" for="bachlor-or-diploma-holders"><fmt:message key="draftsman.mechanic.junior.automobile.mechanical.degree"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline" id="draftsmanAutomobileORMechanicalHolders-yes-id">
                <input type="radio" name="automobileOrMechanicalEngDegree" value="1" class="form-control" id="draftsmanAutomobileORMechanicalHolders-yes" ${ applicantPostAssoc.automobileOrMechanicalEngDegree ? 'checked="checked"':''} required />
                <label for="draftsmanAutomobileORMechanicalHolders-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline" id="draftsmanAutomobileORMechanicalHolders-no-id">
               	<input class="radiosToCheck" type="radio" name="automobileOrMechanicalEngDegree" value="0" class="form-control" id="draftsmanAutomobileORMechanicalHolders-no" ${ applicantPostAssoc.automobileOrMechanicalEngDegree == false ? 'checked="checked"':''} required />
                <label for="draftsmanAutomobileORMechanicalHolders-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
   
    <div class="form-group" id="draftsmanAutomobileORMechanicalHoldersYesDiv">
        <label class="control-label col-sm-5" for="degree"><fmt:message key="store.supervisor.decgree.diploma.name"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input type="text" name="degreeName" value="${ applicantPostAssoc.degreeName}" class="form-control" id="degreeId" required />
            </div>
            <div class="help-block with-errors"></div>
        </div>
        <label class="control-label col-sm-5" for="university"><fmt:message key="manager.university.name"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input type="text" name="universityName" value="${ applicantPostAssoc.universityName}" class="form-control" id="universityId" required />
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-5" for="draftsmanDiplomaInAutocad"><fmt:message key="draftsman.mechanic.junior.diploma.autocad"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline" id="draftsmanDiplomaInAutocad-yes-id">
                <input type="radio" name="diplomaInAutocad" value="1" class="form-control" id="draftsmanDiplomaInAutocad-yes" ${ applicantPostAssoc.diplomaInAutocad ? 'checked="checked"':''} required />
                <label for="draftsmanDiplomaInAutocad-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline" id="draftsmanDiplomaInAutocad-no-id">
               	<input type="radio" name="diplomaInAutocad" value="0" class="form-control" id="draftsmanDiplomaInAutocad-no" ${ applicantPostAssoc.diplomaInAutocad == false ? 'checked="checked"':''} required>
                <label for="draftsmanDiplomaInAutocad-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group" id="draftsmanDiplomaInAutocadYesDiv" >
        <label class="control-label col-sm-5" for="diplomaInAutocadUniversityName"><fmt:message key="manager.university.name"/>: </label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input type="text" name="diplomaInAutocadUniversityName" value="${ applicantPostAssoc.diplomaInAutocadUniversityName}" class="form-control" id="diplomaInAutocadUniversityId" />
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group">
        <label class="control-label col-sm-5" for="computerCourseCertification"><fmt:message key="draftsman.diploma.certification.in.autocad"/></label>
        <div class="col-sm-4">
            <div class="radio radio-inline" id="computerCourseCertification-yes-id">
            </div>
            <div class="radio radio-inline" id="computerCourseCertification-no-id">
               	
            </div>
        </div>
    </div>
    
    <div class="form-group">
        <label class="control-label col-sm-5" for="autocadCertification"><fmt:message key="draftsman.mechanic.junior.autocad.certification.government.private"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline" id="autocadCertification-yes-id">
                <input type="radio" name="autocadCertificationFromGovernment" value="1" class="form-control" id="autocadCertification-yes" ${ applicantPostAssoc.autocadCertificationFromGovernment ? 'checked="checked"':''} required />
                <label for="autocadCertification-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline" id="autocadCertification-no-id">
               	<input type="radio" name="autocadCertificationFromGovernment" value="0" class="form-control" id="autocadCertification-no" ${ applicantPostAssoc.autocadCertificationFromGovernment == false ? 'checked="checked"':''} required />
                <label for="autocadCertification-no"> <fmt:message key="no"/> </label>
            </div>
        </div>
    </div>
    
    <div class="form-group" id="autocadCertificationYesDiv" >
        <label class="control-label col-sm-5" for="autocadCertificationInstituteName"><fmt:message key="draftsman.mechanic.junior.autocad.certification.institute.name"/>: </label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input type="text" name="autocadCertificationFromGovernmentInstituteName" value="${ applicantPostAssoc.autocadCertificationFromGovernmentInstituteName}" class="form-control" id="autocadCertificationInstituteId" />
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group" >
        <label class="control-label col-sm-5" for="experienceInHand"><fmt:message key="draftsman.mechanic.junior.experience.autocad"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline" id="experienceInHand-yes-id">
                <input type="radio" name="experienceInAutocad" value="1" class="form-control" id="draftsmanExperienceInHand-yes" ${ applicantPostAssoc.experienceInAutocad ? 'checked="checked"':''}  required />
                <label for="draftsmanExperienceInHand-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline" id="experienceInHand-no-id">
               	<input class="radiosToCheck" type="radio" name="experienceInAutocad" value="0" class="form-control" id="draftsmanExperienceInHand-no" ${ applicantPostAssoc.experienceInAutocad == false ? 'checked="checked"':''} required />
                <label for="draftsmanExperienceInHand-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group" id="draftsmanExperienceInHandYesDiv">
        <label class="control-label col-sm-5" for="companyName"><fmt:message key="driver.experienced.companyName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input type="text" name="companyName" value="${ applicantPostAssoc.companyName}" class="form-control" id="companyNameId" placeholder="<fmt:message key="trafficInspector.experienced.companyName"/>" required>
            </div>
            <div class="help-block with-errors"></div>
        </div>
        <div class="form-group ">
	        <label class="control-label col-sm-5" for="totalExperienceInYears"><fmt:message key="draftsman.mechanic.junior.total.experience"/>: <span class="red">*</span></label>
	        <div class="col-sm-2">
	            <input name="totalExperienceInYears" value="${applicantPostAssoc.totalExperienceInYears}" type="number" class="form-control" id="assistantJuniorTotalExperienceInYears" placeholder="<fmt:message key="accountantJunior.experienced.inYears"/>"  required  min="0">
	            <div class="help-block with-errors"></div>
	        </div>
	        <div class="col-sm-2">
	            <input name="totalExperienceInMonths" value="${applicantPostAssoc.totalExperienceInMonths}" type="number" class="form-control" id="assistantJuniorTotalExperienceInMonths" placeholder="<fmt:message key="accountantJunior.experienced.inMonths"/>"  required  min="0" max="12">
	            <div class="help-block with-errors"></div>
	        </div>
	    </div>
    </div>
         
    <jsp:include page="postFooter.jsp">
    	<jsp:param name="isPostSubmitted" value="${ applicantPostAssoc.status eq 2 || applicantPostAssoc.status eq 3 }"/>
    	<jsp:param name="formId" value="draftsmanMechanicsJuniorForm"/>
		<jsp:param name="postId" value="${post.postId}"/>
		<jsp:param name="disableFormAfterLastDateOver" value="${disableFormAfterLastDateOver}"/>
	</jsp:include>
</form>
