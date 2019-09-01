<%@ include file="../../common/taglibs.jsp"%>

 <script type="text/javascript">
 
  $( document ).ready(function ()
  {
	  postSelectionObj.disableFormFields ("storeSuperviserJuniorForm", '${applicantPostAssoc.status}');
	  postSelectionObj.bindPostForm("storeSuperviserJuniorForm");
	  
	  experienceInHandAction();
	  bachlorOrDiplomaHoldersAction();
	  
	  var lastDateOver = commonObj.isValidate(${disableFormAfterLastDateOver});
	  commonObj.disableFormFields("storeSuperviserJuniorForm",lastDateOver);
	 
  });
	//-------------------- experienceInHand start --------------------
	$('#storeSupervisorExperienceInHand-yes').click(experienceInHandAction);
	$('#storeSupervisorExperienceInHand-no').click(experienceInHandAction);
	
	function experienceInHandAction()
	{
		if(jQuery('input[id=storeSupervisorExperienceInHand-yes]').is(':checked')){
			$(".storeSupervisorExperienceInHandYesDiv").show();
			resetFieldsAndAttributes(['sscompanyNameId','ssassistantJuniorTotalExperienceInYears','ssassistantJuniorTotalExperienceInMonths'], true)
  		 }else if(jQuery('input[id=storeSupervisorExperienceInHand-no]').is(':checked')){
  			$(".storeSupervisorExperienceInHandYesDiv").hide();
  			resetFieldsAndAttributes(['sscompanyNameId','ssassistantJuniorTotalExperienceInYears','ssassistantJuniorTotalExperienceInMonths'], false)
  		 }else
  	  	 {
  			$(".storeSupervisorExperienceInHandYesDiv").hide();
  			resetFieldsAndAttributes(['sscompanyNameId','ssassistantJuniorTotalExperienceInYears','ssassistantJuniorTotalExperienceInMonths'], false)
  	  	 }
	}
  //------------------- experienceInHand end -------------------
  
  // ------------------ bachlorOrDiplomaHolders start ----------------
  	$('#bachlorOrDiplomaHolders-yes').click(bachlorOrDiplomaHoldersAction);
	$('#bachlorOrDiplomaHolders-no').click(bachlorOrDiplomaHoldersAction);
	
  	function bachlorOrDiplomaHoldersAction()
	{
  		if(jQuery('input[id=bachlorOrDiplomaHolders-yes]').is(':checked')){
  			$("#bachlorOrDiplomaHoldersYesDiv").show();
  			resetFieldsAndAttributes(['ssdegreeId','ssuniversityId','ssRequiredQualificationMarks'], true)
  		 }else if(jQuery('input[id=bachlorOrDiplomaHolders-no]').is(':checked')){
  			$("#bachlorOrDiplomaHoldersYesDiv").hide();
  			resetFieldsAndAttributes(['ssdegreeId','ssuniversityId','ssRequiredQualificationMarks'], false)
  		 }else
  	  	 {
  			$("#bachlorOrDiplomaHoldersYesDiv").hide();
  			resetFieldsAndAttributes(['ssdegreeId','ssuniversityId','ssRequiredQualificationMarks'], false)
  	  	 }
  	}
  // ------------------ bachlorOrDiplomaHolders end ----------------
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
  
  $( 'form#storeSuperviserJuniorForm' ).find('input[type=radio][name=mscitOrGaccc]').unbind().change(function() {
  	
  	if(this.value == '0'){
  		 commonObj.showAgreeDisAgreePopup("<fmt:message key='mscit.equivalent.computer.certificate.alert' />", mscitCertificatePopUpStoreSuperviserJunior, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
  	     
  	}
  });
  
  function mscitCertificatePopUpStoreSuperviserJunior(flag)
  {
  	if(!flag)
  	{
  		$('#computerCourseCertification-yes').prop('checked', true);
    	}
  }
  </script>   
  <div id="downloadEligibilityCriteria" class="form-group" align="right">
         <div class="col-sm-12" align="pull-right">
             <a href="javascript:void(0);" onclick="javascript:showEligibilityCriteriaPDF(${post.postId})"><b><fmt:message key="postEligibilityCriteriaLink"/></b></a>
         </div>
     </div>

<form class="form-horizontal" name="storeSuperviserJuniorForm" id="storeSuperviserJuniorForm" action="<c:url value='/applicant?operation=saveApplicantPostDetails'/>" method="POST">

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${applicantPostAssoc.id}"/>
    <input type="hidden" name="postId" value="${post.postId}"/>
    <input type="hidden" name="status" id="status"  value="${ applicantPostAssoc.status }"/>
    
     <div class="form-group">
        <label class="control-label col-sm-5" for="bachlor-or-diploma-holders"><fmt:message key="store.supervisor.junior.bachlor.diploma.holders"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline" id="bachlorOrDiplomaHolders-yes-id">
                <input type="radio" name="bComOrBSCOrDiplomaHoldersInAutomobileOrMechanical" value="1" class="form-control" id="bachlorOrDiplomaHolders-yes" ${ applicantPostAssoc.bComOrBSCOrDiplomaHoldersInAutomobileOrMechanical ? 'checked="checked"':''}  />
                <label for="bachlorOrDiplomaHolders-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline" id="bachlorOrDiplomaHolders-no-id">
               	<input class="radiosToCheck" type="radio" name="bComOrBSCOrDiplomaHoldersInAutomobileOrMechanical" value="0" class="form-control" id="bachlorOrDiplomaHolders-no" ${ applicantPostAssoc.bComOrBSCOrDiplomaHoldersInAutomobileOrMechanical == false ? 'checked="checked"':''}  />
                <label for="bachlorOrDiplomaHolders-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
  
    <div class="form-group" id="bachlorOrDiplomaHoldersYesDiv">
        <label class="control-label col-sm-5" for="degree"><fmt:message key="store.supervisor.decgree.diploma.name"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
                <input type="text" name="degreeName" value="${ applicantPostAssoc.degreeName}" class="form-control" id="ssdegreeId" placeholder="<fmt:message key="store.supervisor.decgree.diploma.name"/>" required maxlength="100" />
            <div class="help-block with-errors"></div>
        </div>
        <label class="control-label col-sm-5" for="university"><fmt:message key="juniorEngineerCivil.universityName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input type="text" name="universityName" value="${ applicantPostAssoc.universityName}" class="form-control" id="ssuniversityId" placeholder="<fmt:message key="juniorEngineerCivil.universityName"/>" required maxlength="100" />
            <div class="help-block with-errors"></div>
        </div>
        
        <label class="control-label col-sm-5" for="ssRequiredQualificationMarks"><fmt:message key="driverCumConductor.required.qualification.marks.obtained"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.requiredQualificationMarks}" type="number" class="form-control" id="ssRequiredQualificationMarks" placeholder="<fmt:message key="driverCumConductor.required.qualification.marks.obtained"/>" name="requiredQualificationMarks" maxlength="5" min="1" max="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
   <%--  <div class="form-group" >
        <label class="control-label col-sm-5" for="otherQualification"><fmt:message key="assistantJunior.otherQualification"/>: </label>
        <div class="col-sm-4">
                <input type="text" name="otherQualificationDetails" value="${ applicantPostAssoc.otherQualificationDetails}" class="form-control" id="otherQualificationId" placeholder="<fmt:message key="trafficInspectorJunior.otherQualification"/>" maxlength="100" />
            <div class="help-block with-errors"></div>
        </div>
    </div> --%>
    <div class="form-group">
        <label class="control-label col-sm-5" for="computerCourseCertification"><fmt:message key="store.supervisor.mscit.government.affiliated.computer.course.certification"/>: <span class="red">*&nbsp;&nbsp;##</span><a href="javascript:void(0);" onclick="javascript:viewFileMscit(1)" style="font-size: 9px; font-style: italic"><fmt:message key="post.mscit.one"/></a>&nbsp;&nbsp; 
        <a href="javascript:void(0);" onclick="javascript:viewFileMscit(2)" style="font-size: 9px; font-style: italic"><fmt:message key="post.mscit.two"/></a></label>
        <div class="col-sm-4">
            <div class="radio radio-inline" id="computerCourseCertification-yes-id">
                <input type="radio" name="mscitOrGaccc" value="1" class="form-control" id="computerCourseCertification-yes" ${ applicantPostAssoc.mscitOrGaccc ? 'checked="checked"':''}  />
                <label for="computerCourseCertification-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline" id="computerCourseCertification-no-id">
               	<input  type="radio" name="mscitOrGaccc" value="0" class="form-control" id="computerCourseCertification-no" ${ applicantPostAssoc.mscitOrGaccc == false ? 'checked="checked"':''} >
                <label for="computerCourseCertification-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group" >
        <label class="control-label col-sm-5" for="storeSupervisorExperienceInHand"><fmt:message key="store.supervisor.experience.in.hand"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline" id="storeSupervisorExperienceInHand-yes-id">
                <input type="radio" name="twoYearExpAsTransportAssociation" value="1" class="form-control" id="storeSupervisorExperienceInHand-yes" ${ applicantPostAssoc.twoYearExpAsTransportAssociation ? 'checked="checked"':''}  />
                <label for="storeSupervisorExperienceInHand-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline" id="storeSupervisorExperienceInHand-no-id">
               	<input class="radiosToCheck" type="radio" name="twoYearExpAsTransportAssociation" value="0" class="form-control" id="storeSupervisorExperienceInHand-no" ${ applicantPostAssoc.twoYearExpAsTransportAssociation == false ? 'checked="checked"':''} />
                <label for="storeSupervisorExperienceInHand-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group storeSupervisorExperienceInHandYesDiv">
        <label class="control-label col-sm-5" for="companyName"><fmt:message key="store.supervisor.company.name"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
                <input type="text" name="companyName" value="${ applicantPostAssoc.companyName}" class="form-control" id="sscompanyNameId" placeholder="<fmt:message key="store.supervisor.company.name"/>" maxlength="150" /> 
            <div class="help-block with-errors"></div>
        </div>
    </div>
      <div class="form-group storeSupervisorExperienceInHandYesDiv">
	        <label class="control-label col-sm-5" for="totalExperienceInYears"><fmt:message key="store.supervisor.total.experience"/>: <span class="red">*</span></label>
	        <div class="col-sm-2">
           <input value="${applicantPostAssoc.totalExperienceInYears}" type="tel" class="form-control" id="ssassistantJuniorTotalExperienceInYears" placeholder="<fmt:message key="accountantJunior.experienced.inYears"/>" name="totalExperienceInYears"  min="0" maxlength="2">
	            <div class="help-block with-errors"></div>
	        </div>
	        <div class="col-sm-2">
           <input value="${applicantPostAssoc.totalExperienceInMonths}" type="tel" class="form-control" id="ssassistantJuniorTotalExperienceInMonths" placeholder="<fmt:message key="accountantJunior.experienced.inMonths"/>" name="totalExperienceInMonths"  min="0" maxlength="2">
	            <div class="help-block with-errors"></div>
	        </div>
	    </div>
    
    <jsp:include page="postFooter.jsp">
    	<jsp:param name="isPostSubmitted" value="${ applicantPostAssoc.status eq 2 || applicantPostAssoc.status eq 3 }"/>
    	<jsp:param name="formId" value="storeSuperviserJuniorForm"/>
		<jsp:param name="postId" value="${post.postId}"/>
		<jsp:param name="disableFormAfterLastDateOver" value="${disableFormAfterLastDateOver}"/>
	</jsp:include>
</form>

 
<script>
 $(document).ready(function(){
 $("form[name='storeSuperviserJuniorForm']").validate({
 	rules:{
 		bComOrBSCOrDiplomaHoldersInAutomobileOrMechanical : "required",
 		 degreeName: {required: true},
 		 universityName: {required: true},
 		requiredQualificationMarks:{required: true , min:35},
 		 mscitOrGaccc : "required",
 		 twoYearExpAsTransportAssociation : "required",
 		 companyName : {required: true},
 		 totalExperienceInYears :{required: true, numbersonly:true, min : 2, max:100},
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