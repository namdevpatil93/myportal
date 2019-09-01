<%@ include file="../../common/taglibs.jsp"%>

 <script type="text/javascript">

 	 $( document ).ready(function (){
 	 	 
 		postSelectionObj.disableFormFields ("asstWorkSuperintendentJuniorForm", '${applicantPostAssoc.status}');
 		postSelectionObj.bindPostForm("asstWorkSuperintendentJuniorForm");

		postSelectionObj.validateDate('assitWSHeavy-DrivingLicenseIssueDate', 'assitWSHeavy-DrivingLicenseEndDate');

		 var maxDate=new Date();
		 maxDate.setFullYear(maxDate.getFullYear() + 50);
		
		$('#assitWSHeavy-DrivingLicenseIssueDate').datetimepicker({
           format: 'DD/MM/YYYY',
           ignoreReadonly: true,
           showTodayButton: true,
           minDate: postSelectionObj.minDate(),
           maxDate: postSelectionObj.maxDate()
           //date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseIssueDate}" />'
       });
       $('#assitWSCalendarIconHeavyDrivingLicenseIssueDate').click(function() {
           $('#assitWSHeavy-DrivingLicenseIssueDate').data("DateTimePicker").show();
       });
		
		$('#assitWSHeavy-DrivingLicenseEndDate').datetimepicker({
           format: 'DD/MM/YYYY',
           ignoreReadonly: true,
           showTodayButton: true,
           minDate: postSelectionObj.minDate(),
           maxDate: postSelectionObj.maxDate()
           //date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseEndDate}" />'
       });
	    
       $('#assitWSCalendarIconHeavyDrivingLicenseEndDate').click(function() {
           $('#assitWSHeavy-DrivingLicenseEndDate').data("DateTimePicker").show();
       });

        bachlorOrDiplomaHoldersAction();
	 	experienceInHandAction();
		assitWSOwnHeavyDrivingLicenseAction();
		
		var date = '${applicantPostAssoc.heavyDrivingLicenseIssueDate}';
		if(date != 'undefined' || date != null || data !='' )
			$('#assitWSHeavy-DrivingLicenseIssueDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseIssueDate}" />');
		
		date = '${applicantPostAssoc.heavyDrivingLicenseEndDate}';
		if(date != 'undefined' || date != null || data !='' )
			$('#assitWSHeavy-DrivingLicenseEndDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseEndDate}" />');
		
		var lastDateOver = commonObj.isValidate(${disableFormAfterLastDateOver});
	    commonObj.disableFormFields("asstWorkSuperintendentJuniorForm",lastDateOver);
	});

	function checkIfShowOrHideElements() {
		
		if ('${applicantPostAssoc.ownHeavyDrivingLicenseNumber}' == 'true' || '${applicantPostAssoc.ownHeavyDrivingLicenseNumber}' == true) {
			postSelectionObj.showElementsByClass('assitWSOwnHeavyDrivingLicenseToggle');
		}else
		{
			 $("#assitWSHeavyDrivingLicenseNumber").parent().parent().find("label.error").empty();
	    	 $("#assitWSHeavy-DrivingLicenseIssueDate").parent().parent().find("label.error").empty();
	    	 $("#assitWSHeavy-DrivingLicenseEndDate").parent().parent().find("label.error").empty();
			postSelectionObj.hideElementsByClass('assitWSOwnHeavyDrivingLicenseToggle');
		}
	}
//-------------------- experienceInHand start --------------------
	$('#assitWSExperienceInHand-yes-id').click(experienceInHandAction);
	$('#assitWSExperienceInHand-no-id').click(experienceInHandAction);
	
	function experienceInHandAction()
	{
		if(jQuery('input[id=assitWSExperienceInHand-yes]').is(':checked')) {
			$("#assitWSExperienceInHandYesDiv").show();
			resetFieldsAndAttributes(['awscompanyNameId', 'awsassitWSJuniorTotalExperienceInYears','awsassitWSJuniorTotalExperienceInMonths'], true);
		 }else if(jQuery('input[id=assitWSExperienceInHand-no]').is(':checked')){
			$("#assitWSExperienceInHandYesDiv").hide();
			resetFieldsAndAttributes(['awscompanyNameId', 'awsassitWSJuniorTotalExperienceInYears','awsassitWSJuniorTotalExperienceInMonths'], false);
		 }else
		  {
			 $("#assitWSExperienceInHandYesDiv").hide();
			 resetFieldsAndAttributes(['awscompanyNameId', 'awsassitWSJuniorTotalExperienceInYears','awsassitWSJuniorTotalExperienceInMonths'], false);
		  }
	}
//------------------- experienceInHand end -------------------
  
  // ------------------ bachlorOrDiplomaHolders start ----------------
  	$('#asstWorkSuperintendentBachlorOrDiplomaHolders-yes').click(bachlorOrDiplomaHoldersAction);
	$('#asstWorkSuperintendentBachlorOrDiplomaHolders-no').click(bachlorOrDiplomaHoldersAction);
	
  	function bachlorOrDiplomaHoldersAction()
	{
  		if(jQuery('input[id=asstWorkSuperintendentBachlorOrDiplomaHolders-yes]').is(':checked')){
  			$("#asstWorkSuperintendentBachlorOrDiplomaHoldersYesDiv").show();
  			resetFieldsAndAttributes(['awsdegreeId', 'awsuniversityId' ,'awsRequiredQualificationMarks'], true)
  		 }else if(jQuery('input[id=asstWorkSuperintendentBachlorOrDiplomaHolders-no]').is(':checked')){
  			$("#asstWorkSuperintendentBachlorOrDiplomaHoldersYesDiv").hide();
  			 resetFieldsAndAttributes(['awsdegreeId', 'awsuniversityId' , 'awsRequiredQualificationMarks'], false)
  		 }else
		  {
  			$("#asstWorkSuperintendentBachlorOrDiplomaHoldersYesDiv").hide();
 			 resetFieldsAndAttributes(['awsdegreeId', 'awsuniversityId', 'awsRequiredQualificationMarks'], false)
		  }
  	}
  // ------------------ bachlorOrDiplomaHolders end ----------------
  
  $('#awsassitWSJunior-ownHeavyDrivingLicenseNumber-yes').click(assitWSOwnHeavyDrivingLicenseAction);
  $('#awsassitWSJunior-ownHeavyDrivingLicenseNumber-no').click(assitWSOwnHeavyDrivingLicenseAction);
  
  function assitWSOwnHeavyDrivingLicenseAction() {
	  if(jQuery('input[id=awsassitWSJunior-ownHeavyDrivingLicenseNumber-yes]').is(':checked')){
		  
			$("#assitWSOwnHeavyDrivingLicenseYesDiv").show();
// 			resetFieldsAndAttributes(['assitWSHeavyDrivingLicenseNumber', 'assitWSHeavy-DrivingLicenseIssueDate', 'assitWSHeavy-DrivingLicenseEndDate'], true);
			
		 }else if(jQuery('input[id=awsassitWSJunior-ownHeavyDrivingLicenseNumber-no]').is(':checked')){
			 
			$("#assitWSOwnHeavyDrivingLicenseYesDiv").hide();
// 			resetFieldsAndAttributes(['assitWSHeavyDrivingLicenseNumber', 'assitWSHeavy-DrivingLicenseIssueDate', 'assitWSHeavy-DrivingLicenseEndDate'], false);
		 }else
		  {
			 $("#assitWSOwnHeavyDrivingLicenseYesDiv").hide();
// 		   	 resetFieldsAndAttributes(['assitWSHeavyDrivingLicenseNumber', 'assitWSHeavy-DrivingLicenseIssueDate', 'assitWSHeavy-DrivingLicenseEndDate'], false);
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
 
   $( 'form#asstWorkSuperintendentJuniorForm' ).find('input[type=radio][name=ownHeavyDrivingLicenseNumber]').unbind().change(function() {
      if (this.value == '1') {
    	  $("#assitWSOwnHeavyDrivingLicenseYesDiv").show();
    	  resetFieldsAndAttributes(['assitWSHeavyDrivingLicenseNumber', 'assitWSHeavy-DrivingLicenseIssueDate', 'assitWSHeavy-DrivingLicenseEndDate'], true);
      }else{
    	  $("#assitWSOwnHeavyDrivingLicenseYesDiv").hide();
    	  $("#assitWSHeavyDrivingLicenseNumber").parent().parent().find("label.error").empty();
    	  $("#assitWSHeavy-DrivingLicenseIssueDate").parent().parent().find("label.error").empty();
    	  $("#assitWSHeavy-DrivingLicenseEndDate").parent().parent().find("label.error").empty();
		  resetFieldsAndAttributes(['assitWSHeavyDrivingLicenseNumber', 'assitWSHeavy-DrivingLicenseIssueDate', 'assitWSHeavy-DrivingLicenseEndDate'], false);
		  //commonObj.showAlert("<fmt:message key='heavyDrivingLicenseNumber.onNoSelect.alert' />");
		  commonObj.showAgreeDisAgreePopup("<fmt:message key='heavyDrivingLicenseNumber.onNoSelect.alert' />", asstWorkSuperndentAgreeDisAgreePopup, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
      }
  });

   function asstWorkSuperndentAgreeDisAgreePopup(flag)
   {
   	if(!flag)
   	{
   		$('#awsassitWSJunior-ownHeavyDrivingLicenseNumber-yes').prop('checked', true);
   		$("#assitWSOwnHeavyDrivingLicenseYesDiv").show();
     	resetFieldsAndAttributes(['assitWSHeavyDrivingLicenseNumber', 'assitWSHeavy-DrivingLicenseIssueDate', 'assitWSHeavy-DrivingLicenseEndDate'], true);
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
    
   $( 'form#asstWorkSuperintendentJuniorForm' ).find('input[type=radio][name=mscitOrGaccc]').unbind().change(function() {
   	
   	if(this.value == '0'){
   		 commonObj.showAgreeDisAgreePopup("<fmt:message key='mscit.equivalent.computer.certificate.alert' />", mscitCertificatePopUpAsstWorkSuperintendentJunior, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
   	     
   	}
   });
   
   function mscitCertificatePopUpAsstWorkSuperintendentJunior(flag)
   {
   	if(!flag)
   	{
   		$('#asstWorkSuperintendent-mscitOrGaccc-yes').prop('checked', true);
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

<form class="form-horizontal" name="asstWorkSuperintendentJuniorForm" id="asstWorkSuperintendentJuniorForm" data-toggle="validator" action="<c:url value='/applicant?operation=saveApplicantPostDetails'/>" method="POST">

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${applicantPostAssoc.id}"/>
    <input type="hidden" name="postId" value="${post.postId}"/>
    <input type="hidden" name="status" id="status"  value="${ applicantPostAssoc.status }"/>
    
     <div class="form-group">
        <label class="control-label col-sm-5" for="bachlor-or-diploma-holders"><fmt:message key="asst.work.superintendent.engineer"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline" id="asstWorkSuperintendentBachlorOrDiplomaHolders-yes-id">
                <input type="radio" name="automobileOrMechanicalEngDegree" value="1" class="form-control" id="asstWorkSuperintendentBachlorOrDiplomaHolders-yes" ${ applicantPostAssoc.automobileOrMechanicalEngDegree ? 'checked="checked"':''} >
                <label for="asstWorkSuperintendentBachlorOrDiplomaHolders-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline" id="asstWorkSuperintendentBachlorOrDiplomaHolders-no-id">
               	<input class="radiosToCheck" type="radio" name="automobileOrMechanicalEngDegree" value="0" class="form-control" id="asstWorkSuperintendentBachlorOrDiplomaHolders-no" ${ applicantPostAssoc.automobileOrMechanicalEngDegree == false ? 'checked="checked"':''} >
                <label for="asstWorkSuperintendentBachlorOrDiplomaHolders-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
   
    <div class="form-group" id="asstWorkSuperintendentBachlorOrDiplomaHoldersYesDiv">
        <label class="control-label col-sm-5" for="degree"><fmt:message key="juniorEngineerCivil.degreeName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
                <input type="text" name="degreeName" value="${ applicantPostAssoc.degreeName}" class="form-control" id="awsdegreeId" maxlength="100" placeholder="<fmt:message key="juniorEngineerCivil.degreeName"/>" >
            <div class="help-block with-errors"></div>
        </div>
        <label class="control-label col-sm-5" for="university"><fmt:message key="juniorEngineerCivil.universityName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
                <input type="text" name="universityName" value="${ applicantPostAssoc.universityName}" class="form-control" id="awsuniversityId" maxlength="100" placeholder="<fmt:message key="juniorEngineerCivil.universityName"/>" >
            <div class="help-block with-errors"></div>
        </div>
       
        <label class="control-label col-sm-5" for="awsRequiredQualificationMarks"><fmt:message key="driverCumConductor.required.qualification.marks.obtained"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.requiredQualificationMarks}" type="number" class="form-control" id="awsRequiredQualificationMarks" placeholder="<fmt:message key="driverCumConductor.required.qualification.marks.obtained"/>" name="requiredQualificationMarks" maxlength="5" min="1" max="100">
            <div class="help-block with-errors"></div>
        </div>

    </div>
    
    <%--  <div class="form-group" >
        <label class="control-label col-sm-5" for="otherQualification"><fmt:message key="assistantJunior.otherQualification"/>: </label>
        <div class="col-sm-4">
                <input type="text" name="otherQualificationDetails" value="${ applicantPostAssoc.otherQualificationDetails}" class="form-control" id="otherQualificationId" maxlength="100" placeholder="<fmt:message key="trafficInspectorJunior.otherQualification"/>" />
            <div class="help-block with-errors"></div>
        </div>
    </div> --%> 
    
    <div class="form-group" >
        <label class="control-label col-sm-5" for="experienceInHand"><fmt:message key="asst.work.superintendent.year.experience"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline" id="assitWSExperienceInHand-yes-id">
                <input type="radio" name="oneYearExpInAutomobileRepairing" value="1" class="form-control" id="assitWSExperienceInHand-yes" ${ applicantPostAssoc.oneYearExpInAutomobileRepairing ? 'checked="checked"':''}  />
                <label for="assitWSExperienceInHand-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline" id="assitWSExperienceInHand-no-id">
               	<input class="radiosToCheck" type="radio" name="oneYearExpInAutomobileRepairing" value="0" class="form-control" id="assitWSExperienceInHand-no" ${ applicantPostAssoc.oneYearExpInAutomobileRepairing == false ? 'checked="checked"':''} />
                <label for="assitWSExperienceInHand-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group" id="assitWSExperienceInHandYesDiv">
        <label class="control-label col-sm-5" for="companyName"><fmt:message key="assistantTrafficSuperintendent.experienced.companyName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
                <input type="text" name="companyName" value="${ applicantPostAssoc.companyName}" class="form-control" id="awscompanyNameId" maxlength="150" placeholder="<fmt:message key="assistantTrafficSuperintendent.experienced.companyName"/>" >
            <div class="help-block with-errors"></div>
        </div>
	        <label class="control-label col-sm-5" for="totalExperienceInYears"><fmt:message key="asst.work.superintendent.total.experience"/>: <span class="red">*</span></label>
	        <div class="col-sm-2">
	            <input value="${applicantPostAssoc.totalExperienceInYears}" type="tel" class="form-control telToCheck" id="awsassitWSJuniorTotalExperienceInYears" placeholder="<fmt:message key="accountantJunior.experienced.inYears"/>" name="totalExperienceInYears"  min="0" maxlength="2"> 
	            <div class="help-block with-errors"></div>
	        </div>
	        <div class="col-sm-2">
	            <input value="${applicantPostAssoc.totalExperienceInMonths}" type="tel" class="form-control telToCheck" id="awsassitWSJuniorTotalExperienceInMonths" placeholder="<fmt:message key="accountantJunior.experienced.inMonths"/>" name="totalExperienceInMonths"  min="0" maxlength="2">
	            <div class="help-block with-errors"></div>
	        </div>
    </div>
    
    <div class="form-group">
        <label class="control-label col-sm-5" for="ownHeavyDrivingLicenseNumber"><fmt:message key="driver.ownHeavyDrivingLicenseNo"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="ownHeavyDrivingLicenseNumber" id="awsassitWSJunior-ownHeavyDrivingLicenseNumber-yes" value="1" type="radio" ${applicantPostAssoc.ownHeavyDrivingLicenseNumber ? 'checked' : ''} />
                <label for="awsassitWSJunior-ownHeavyDrivingLicenseNumber-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <%-- <input class="radiosToCheck" name="ownHeavyDrivingLicenseNumber" id="awsassitWSJunior-ownHeavyDrivingLicenseNumber-no" value="0" type="radio" ${applicantPostAssoc.ownHeavyDrivingLicenseNumber == false ? 'checked' : ''} /> --%>
                <input name="ownHeavyDrivingLicenseNumber" id="awsassitWSJunior-ownHeavyDrivingLicenseNumber-no" value="0" type="radio" ${applicantPostAssoc.ownHeavyDrivingLicenseNumber == false ? 'checked' : ''} />
                <label for="awsassitWSJunior-ownHeavyDrivingLicenseNumber-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div id="assitWSOwnHeavyDrivingLicenseYesDiv">
	    <div class="form-group">
	        <label class="control-label col-sm-5" for="heavyDrivingLicenseNumber"><fmt:message key="driver.ownHeavyDrivingLicenseNo.number"/>: <span class="red">*</span></label>
	        <div class="col-sm-4">
	            <input value="${applicantPostAssoc.heavyDrivingLicenseNumber}" type="text" class="form-control" id="assitWSHeavyDrivingLicenseNumber" placeholder="<fmt:message key="driver.ownHeavyDrivingLicenseNo.number"/>" name="heavyDrivingLicenseNumber"  maxlength="50">
	            <div class="help-block with-errors"></div>
	        </div>
	    </div>
	    <div class="form-group">
	        <label class="control-label col-sm-5" for="assitWSHeavy-DrivingLicenseIssueDate"><fmt:message key="chargeManJunior.ownHeavyDrivingLicenseNo.issueDate"/>: <span class="red">*</span></label>
	        <div class="col-sm-3">
	        	<div class="input-group date">
		            <input type="datetime" class="form-control" id="assitWSHeavy-DrivingLicenseIssueDate" placeholder="<fmt:message key="driver.ownHeavyDrivingLicenseNo.issueDate"/>" name="heavyDrivingLicenseIssueDate" readonly />
		            <div class="input-group-addon" id="assitWSCalendarIconHeavyDrivingLicenseIssueDate">
						<i class="fa fa-calendar"></i>
					</div>
		            <div class="help-block with-errors"></div>
	            </div>
	        </div>
	     </div>
	     <div class="form-group"> 
	        <label class="control-label col-sm-5" for="assitWSHeavy-DrivingLicenseEndDate"><fmt:message key="trafficInspectorJunior.ownHeavyDrivingLicenseNo.endDate"/>:<span class="red">*</span></label>
	        <div class="col-sm-3">
	        	<div class="input-group date">
		            <input type="datetime" class="form-control" id="assitWSHeavy-DrivingLicenseEndDate" placeholder="<fmt:message key="asst.work.superintendent.ownHeavyDrivingLicenseNo.enddate"/>" name="heavyDrivingLicenseEndDate" readonly />
		            <div class="input-group-addon" id="assitWSCalendarIconHeavyDrivingLicenseEndDate">
						<i class="fa fa-calendar"></i>
					</div>
		            <div class="help-block with-errors"></div>
	            </div>
	        </div>
	    </div>
     </div>
     
      <div class="form-group">
        <label class="control-label col-sm-5" for="asstWorkSuperintendentMscit"><fmt:message key="assistantTrafficSuperintendent.mscitOrGaccc"/>: <span class="red">*&nbsp;&nbsp;##</span><a href="javascript:void(0);" onclick="javascript:viewFileMscit(1)" style="font-size: 9px; font-style: italic"><fmt:message key="post.mscit.one"/></a>&nbsp;&nbsp; 
        <a href="javascript:void(0);" onclick="javascript:viewFileMscit(2)" style="font-size: 9px; font-style: italic"><fmt:message key="post.mscit.two"/></a></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="mscitOrGaccc" id="asstWorkSuperintendent-mscitOrGaccc-yes" value="1" type="radio" ${applicantPostAssoc.mscitOrGaccc ? 'checked' : ''} />
                <label for="asstWorkSuperintendent-mscitOrGaccc-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input  name="mscitOrGaccc" id="asstWorkSuperintendent-mscitOrGaccc-no" value="0" type="radio" ${applicantPostAssoc.mscitOrGaccc == false ? 'checked' : ''} />
                <label for="asstWorkSuperintendent-mscitOrGaccc-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <jsp:include page="postFooter.jsp">
    	<jsp:param name="isPostSubmitted" value="${ applicantPostAssoc.status eq 2 || applicantPostAssoc.status eq 3}"/>
    	<jsp:param name="formId" value="asstWorkSuperintendentJuniorForm"/>
		<jsp:param name="postId" value="${post.postId}"/>
		<jsp:param name="disableFormAfterLastDateOver" value="${disableFormAfterLastDateOver}"/>
	</jsp:include>
 </form>


<script>
 $(document).ready(function(){
 $("form[name='asstWorkSuperintendentJuniorForm']").validate({
	//ignore : "#assitWSHeavyDrivingLicenseIssueDate, #assitWSHeavyDrivingLicenseEndDate",
 	rules:{
 		automobileOrMechanicalEngDegree : "required",
 		 mscitOrGaccc : "required",
 		 degreeName: {required: true},
 		 universityName: {required: true},
 		requiredQualificationMarks:{required: true , min:35},
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
 