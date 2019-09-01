<%@ include file="../../common/taglibs.jsp"%>

 <script type="text/javascript">
 $( document ).ready(function (){
	 		postSelectionObj.disableFormFields ("storeKeeperJuniorForm", '${applicantPostAssoc.status}');
	 		postSelectionObj.bindPostForm("storeKeeperJuniorForm");
	 	
	 		bachlorOrDiplomaHoldersAction();
			experienceInHandAction();
			checkIfShowOrHideElements();
			
			//differentlyAbledOthersAction();
			//removeHelpBlockAction();
			var lastDateOver = commonObj.isValidate(${disableFormAfterLastDateOver});
		    commonObj.disableFormFields("storeKeeperJuniorForm",lastDateOver);
		});

    $('#storeKeeper-differentlyAbled-deafAndMute').click(storeKeeperCheckBoxAction);

    function storeKeeperCheckBoxAction(){
    	if(jQuery('input[id=storeKeeper-differentlyAbled-deafAndMute]').is(':checked')){
			commonObj.showAgreeDisAgreePopup("<b> <fmt:message key='assistantJunior.differentlyAbled.deafAndMute' />:</b>  <fmt:message key='storekeeper.deaf.and.dumb.popup.msg' />", storeKeeperDifferentlyAbledAction, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
    	}else {
    		$( '.storeKeeperDifferentlyAbledToggle' ).find('input').prop('required', true);
			$("#storeKeeper-differentlyAbled-yes").parent().parent().find('.help-block').empty().append("<fmt:message key="clerkTypistJunior.atleastone"/>");
    		removeHelpBlockAction();
        }
	}
 	function storeKeeperDifferentlyAbledAction(flag)
 	{
 	 	
		if(!flag)
		{
			$('#storeKeeper-differentlyAbled-deafAndMute').prop('checked', false);
			
		}
		/* else {
			alert(flag);
			$( '.storeKeeperDifferentlyAbledToggle' ).find('input').prop('required', true);
			$("#storeKeeper-differentlyAbled-yes").parent().parent().find('.help-block').empty().append("<fmt:message key="clerkTypistJunior.atleastone"/>");
			//$("#storeKeeper-differentlyAbled-yes").parent().parent().find('.help-block').empty();
		}  */
		removeHelpBlockAction();
 	}
    
	function removeHelpBlockAction()
	{
		if(jQuery('input[id=storeKeeper-differentlyAbled-deafAndMute]').is(':checked') ) {
			$("#storeKeeper-differentlyAbled-yes").parent().parent().find('.help-block').empty();
			$( '.storeKeeperDifferentlyAbledToggle' ).find('input').prop('required', false);
		}else if(jQuery('input[id=sstoreKeeper-differentlyAbled-yes]').is(':checked')){
		 	$( '.storeKeeperDifferentlyAbledToggle' ).find('input').prop('required', true);
	 		$("#storeKeeper-differentlyAbled-yes").parent().parent().find('.help-block').empty().append("<fmt:message key="clerkTypistJunior.atleastone"/>");
		 }else if(jQuery('input[id=sstoreKeeper-differentlyAbled-no]').is(':checked')){
			 	$( '.storeKeeperDifferentlyAbledToggle' ).find('input').prop('required', false);
		 		$("#storeKeeper-differentlyAbled-yes").parent().parent().find('.help-block').empty(); //.append("<fmt:message key="clerkTypistJunior.atleastone"/>");
			 }
	 	
	}
 
// $("#storeKeeper-differentlyAbled-yes").parent().parent().find('.help-block').empty()
 
//----------------------------- differentlyAbledOthersAction -------------------------
 $('#storeKeeper-differentlyAbled-others').click(differentlyAbledOthersAction);
 function differentlyAbledOthersAction()
 {
		if(jQuery('input[id=storeKeeper-differentlyAbled-others]').is(':checked')) {
			$("#storeKeeper-differentlyAbled-others-text").show();
			resetFieldsAndAttributes(['storeKeeper-differentlyAbled-others-text'], true);
			removeHelpBlockAction();
		 }else if(!jQuery('input[id=storeKeeper-differentlyAbled-others]').is(':checked')){
			$("#storeKeeper-differentlyAbled-others-text").hide();
			$("#storeKeeper-differentlyAbled-others-text").parent().find('label.error').empty();
			resetFieldsAndAttributes(['storeKeeper-differentlyAbled-others-text'], false);
			removeHelpBlockAction();
		 }else
		  {
			 $("#storeKeeper-differentlyAbled-others-text").hide();
			 resetFieldsAndAttributes(['storeKeeper-differentlyAbled-others-text'], false);
		  }
	}
 
	//-------------------- experienceInHand start --------------------
	$('#storeKeeperExperienceInHand-yes-id').click(experienceInHandAction);
	$('#storeKeeperExperienceInHand-no-id').click(experienceInHandAction);
	
	function experienceInHandAction()
	{
		//$("#checkSurfaceEnvironment-1").is(":checked")
		if(jQuery('input[id=storeKeeperExperienceInHand-yes]').is(':checked')){
			$(".storeKeeperExperienceInHandYesDiv").show();
			resetFieldsAndAttributes(['skcompanyNameId','skassistantJuniorTotalExperienceInYears', 'skassistantJuniorTotalExperienceInMonths'], true);
  		 }else if(jQuery('input[id=storeKeeperExperienceInHand-no]').is(':checked')){
  			$(".storeKeeperExperienceInHandYesDiv").hide();
  			resetFieldsAndAttributes(['skcompanyNameId','skassistantJuniorTotalExperienceInYears', 'skassistantJuniorTotalExperienceInMonths'], false); 			 
  		 }
  		 else
	  	 {
  			$(".storeKeeperExperienceInHandYesDiv").hide();
  			resetFieldsAndAttributes(['skcompanyNameId','skassistantJuniorTotalExperienceInYears', 'skassistantJuniorTotalExperienceInMonths'], false);
	  	 }
	}
  //------------------- experienceInHand end -------------------
  
  // ------------------ bachlorOrDiplomaHolders start ----------------
  	$('#storeKeeperBachlorOrDiplomaHolders-yes-id').click(bachlorOrDiplomaHoldersAction);
	$('#storeKeeperBachlorOrDiplomaHolders-no-id').click(bachlorOrDiplomaHoldersAction);
	
  	function bachlorOrDiplomaHoldersAction()
	{
  		if(jQuery('input[id=storeKeeperBachlorOrDiplomaHolders-yes]').is(':checked')){
  			$("#storeKeeperBachlorOrDiplomaHoldersYesDiv").show();
  			resetFieldsAndAttributes(['skdegreeId','skuniversityId'], true)
  		 }else if(jQuery('input[id=storeKeeperBachlorOrDiplomaHolders-no]').is(':checked')){
  			$("#storeKeeperBachlorOrDiplomaHoldersYesDiv").hide();
  			resetFieldsAndAttributes(['skdegreeId','skuniversityId'], false);
  		 }
  		 else
  	  	 {
  			$("#storeKeeperBachlorOrDiplomaHoldersYesDiv").hide();
  			resetFieldsAndAttributes(['skdegreeId','skuniversityId'], false);
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
  // ------------------ bachlorOrDiplomaHolders end ----------------
  function checkIfShowOrHideElements() {
	  if ('${applicantPostAssoc.differentlyAbled}'=='' || '${applicantPostAssoc.differentlyAbled}'=='false') {
				postSelectionObj.hideElementsByClass('storeKeeperDifferentlyAbledToggle');
				requiredDifferentlyAbledChilds(false);
			}
  }
  
  function requiredDifferentlyAbledChilds(flag) {
		$( '.storeKeeperDifferentlyAbledToggle' ).find('input').prop('required', flag);
	}
  
  $( 'form#storeKeeperJuniorForm' ).find('input[type=radio][name=differentlyAbled]').unbind().change(function() {
		actionOnCheckBoxSelected();
      if (this.value == '1') {
     	 postSelectionObj.showElementsByClass('storeKeeperDifferentlyAbledToggle');
     	 $( '.storeKeeperDifferentlyAbledToggle' ).find('input').prop('required', true);
     	if('${applicantPostAssoc.ageValid}'=='true'){
      		$('#storeKeeperJuniorFormContainerDiv').show();
      		$( 'form#storeKeeperJuniorForm' ).find('#saveBtn').show();
      		$( 'form#storeKeeperJuniorForm' ).find('#saveAsDraftBtn').show();
      		 //$('#saveBtn').show();
      		 //$('#saveAsDraftBtn').show();
      	 }else{
      		commonObj.showAlert("<fmt:message key="ageValidationError" />");
      		$('#storeKeeperJuniorFormContainerDiv').hide();
      		$( 'form#storeKeeperJuniorForm' ).find('#saveBtn').hide();
      		$( 'form#storeKeeperJuniorForm' ).find('#saveAsDraftBtn').hide();
      		//$('#saveBtn').hide();
      		//$('#saveAsDraftBtn').hide();
      	 }
      } else {
     	 postSelectionObj.hideElementsByClass('storeKeeperDifferentlyAbledToggle');
     	 postSelectionObj.resetCheckBoxById('storeKeeper-differentlyAbled-deafAndMute');
     	 $( '.storeKeeperDifferentlyAbledToggle' ).find('input').prop('required', false);
     	 $("#storeKeeper-differentlyAbled-yes").parent().parent().find('.help-block').empty();
     	
	   	if('${applicantPostAssoc.ageInvalid}'=='true'){
     		$('#storeKeeperJuniorFormContainerDiv').show();
     		$( 'form#storeKeeperJuniorForm' ).find('#saveBtn').show();
      		$( 'form#storeKeeperJuniorForm' ).find('#saveAsDraftBtn').show();
     		 
     	 }else{
     		commonObj.showAlert("<fmt:message key="ageValidationError" />");
     		$('#storeKeeperJuniorFormContainerDiv').hide();
     		$( 'form#storeKeeperJuniorForm' ).find('#saveBtn').hide();
      		$( 'form#storeKeeperJuniorForm' ).find('#saveAsDraftBtn').hide();
     		
     	 }
     	 
      }
  });
  
  function actionOnCheckBoxSelected() {
      var total = $( '.storeKeeperDifferentlyAbledToggle' ).find('input:checked').length;
      if (total > 0) {
          requiredDifferentlyAbledChilds(false);
          $("#storeKeeper-differentlyAbled-yes").parent().parent().find('.help-block').empty();
      } else {
          requiredDifferentlyAbledChilds(true);
      }
  }/*
  function showEligibilityCriteriaPDF() {
		var url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/viewPdf.pdf'/>";
		window.open(url,'_blank');
	}*/
	function viewFileStoreKeeper() {
		var url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/StroreKeeper.pdf'/>";
		window.open(url,'_blank');
	}
</script>
<div id="downloadEligibilityCriteria" class="form-group" align="right">
      <div class="col-sm-12" align="pull-right">
          <a href="javascript:void(0);" onclick="javascript:showEligibilityCriteriaPDF(${post.postId})"><b><fmt:message key="postEligibilityCriteriaLink"/></b></a>
      </div>
  </div>

<form class="form-horizontal" name="storeKeeperJuniorForm" id="storeKeeperJuniorForm" action="<c:url value='/applicant?operation=saveApplicantPostDetails'/>" method="POST">

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${applicantPostAssoc.id}"/>
    <input type="hidden" name="postId" value="${post.postId}"/>
    <input type="hidden" name="status" id="status"  value="${ applicantPostAssoc.status }"/>
    
    <div class="form-group">
        <label class="control-label col-sm-5" for="differentlyAbled"><fmt:message key="driver.differentlyAbled"/>: <span class="red">*&nbsp;&nbsp;##</span><a href="javascript:void(0);" onclick="javascript:viewFileStoreKeeper()" style="font-size: 9px; font-style: italic">	<fmt:message key="viewFile"/></a></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="differentlyAbled" id="storeKeeper-differentlyAbled-yes" value="1" type="radio" ${applicantPostAssoc.differentlyAbled ? 'checked' : ''} />
                <label for="storeKeeper-differentlyAbled-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input name="differentlyAbled" id="storeKeeper-differentlyAbled-no" value="0" type="radio" ${applicantPostAssoc.differentlyAbled == false  ? 'checked' : ''} />
                <label for="storeKeeper-differentlyAbled-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group storeKeeperDifferentlyAbledToggle">
    	<div class="col-sm-5">&nbsp;</div>
        <div class="col-sm-4">
        	<div class="checkbox">
        		<input value="1" type="checkbox" class="form-control"  id="storeKeeper-differentlyAbled-deafAndMute" placeholder="<fmt:message key="driver.differentlyAbled.deafAndMute"/>" name="deafAndMute" ${applicantPostAssoc.deafAndMute ? 'checked' : ''}>
        		<label for="storeKeeper-differentlyAbled-deafAndMute"><fmt:message key="driver.differentlyAbled.deafAndMute"/></label>
        	</div>
        	<div class="help-block with-errors"></div>
        </div>
    </div>
<div id="storeKeeperJuniorFormContainerDiv">
     <div class="form-group">
        <label class="control-label col-sm-5" for="bachlor-or-diploma-holders"><fmt:message key="store.supervisor.bachlor.diploma.holders"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline" id="storeKeeperBachlorOrDiplomaHolders-yes-id">
                <input type="radio" name="bComOrBSCOrDiplomaHoldersInAutomobileOrMechanical" value="1" class="form-control" id="storeKeeperBachlorOrDiplomaHolders-yes" ${ applicantPostAssoc.bComOrBSCOrDiplomaHoldersInAutomobileOrMechanical ? 'checked="checked"':''} >
                <label for="storeKeeperBachlorOrDiplomaHolders-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline" id="storeKeeperBachlorOrDiplomaHolders-no-id">
               	<input type="radio" class="radiosToCheck" name="bComOrBSCOrDiplomaHoldersInAutomobileOrMechanical" value="0" class="form-control" id="storeKeeperBachlorOrDiplomaHolders-no" ${ applicantPostAssoc.bComOrBSCOrDiplomaHoldersInAutomobileOrMechanical == false ? 'checked="checked"':''} >
                <label for="storeKeeperBachlorOrDiplomaHolders-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group" id="storeKeeperBachlorOrDiplomaHoldersYesDiv">
        <label class="control-label col-sm-5" for="degree"><fmt:message key="store.supervisor.decgree.diploma.name"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input type="text" name="degreeName" value="${ applicantPostAssoc.degreeName}" class="form-control" id="skdegreeId" placeholder="<fmt:message key="store.supervisor.decgree.diploma.name"/>" required maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
        <label class="control-label col-sm-5" for="university"><fmt:message key="juniorEngineerCivil.universityName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input type="text" name="universityName" value="${ applicantPostAssoc.universityName}" class="form-control" id="skuniversityId" placeholder="<fmt:message key="juniorEngineerCivil.universityName"/>" required maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
  <%--   
    <div class="form-group" >
        <label class="control-label col-sm-5" for="otherQualification"><fmt:message key="assistantJunior.otherQualification"/>: </label>
        <div class="col-sm-4">
                <input type="text" name="otherQualificationDetails" value="${ applicantPostAssoc.otherQualificationDetails}" class="form-control" id="otherQualificationId" placeholder="<fmt:message key="trafficInspectorJunior.otherQualification"/>" maxlength="100" />
            <div class="help-block with-errors"></div>
        </div>
    </div> --%>
    
    
   <%--  <div class="form-group storeKeeperDifferentlyAbledToggle">
    	<div class="col-sm-5">&nbsp;</div>
        <div class="col-sm-4">
        	<div class="checkbox">
	        	<input value="1" name="differentlyAbledOthers" type="checkbox" class="form-control"  id="storeKeeper-differentlyAbled-others" placeholder="<fmt:message key="clerkTypistJunior.differentlyAbled.others"/>" ${applicantPostAssoc.differentlyAbledOthers ? 'checked' : ''}   maxlength="100">
	        	<label for="storeKeeper-differentlyAbled-others"><fmt:message key="clerkTypistJunior.differentlyAbled.others"/></label><span class="red">*</span>
        	</div>
           	<div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group storeKeeperDifferentlyAbledToggleOthersTextToggle">
    	<div class="col-sm-5">&nbsp;</div>
        <div class="col-sm-4">
        	<input value="${applicantPostAssoc.differentlyAbledOthersText}" class="storeKeeper-differentlyAbled-others-text" name="differentlyAbledOthersText" type="text" class="form-control"  id="storeKeeper-differentlyAbled-others-text" placeholder="<fmt:message key="clerkTypistJunior.differentlyAbled.others.text"/>" maxlength="100">
        	<div class="help-block with-errors"></div>
        </div>
    </div> --%>
    <div class="form-group">
        <label class="control-label col-sm-5" for="computerCourseCertification"><fmt:message key="store.supervisor.mscit.government.affiliated.computer.course.certification"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline" id="computerCourseCertification-yes-id">
                <input type="radio" name="mscitOrGaccc" value="1" class="form-control" id="skComputerCourseCertification-yes" ${ applicantPostAssoc.mscitOrGaccc ? 'checked="checked"':''}  />
                <label for="skComputerCourseCertification-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline" id="computerCourseCertification-no-id">
               	<input type="radio" class="radiosToCheck" name="mscitOrGaccc" value="0" class="form-control" id="skComputerCourseCertification-no" ${ applicantPostAssoc.mscitOrGaccc == false ? 'checked="checked"':''}>
                <label for="skComputerCourseCertification-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group" >
        <label class="control-label col-sm-5" for="experienceInHand"><fmt:message key="store.keeper.experience.in.hand"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline" id="storeKeeperExperienceInHand-yes-id">
                <input type="radio" name="oneYearExpAsTransportAssociation" value="1" class="form-control" id="storeKeeperExperienceInHand-yes" ${ applicantPostAssoc.oneYearExpAsTransportAssociation ? 'checked="checked"':''}  />
                <label for="storeKeeperExperienceInHand-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline" id="storeKeeperExperienceInHand-no-id">
               	<input type="radio" class="radiosToCheck" name="oneYearExpAsTransportAssociation" value="0" class="form-control" id="storeKeeperExperienceInHand-no" ${ applicantPostAssoc.oneYearExpAsTransportAssociation == false ? 'checked="checked"':''} />
                <label for="storeKeeperExperienceInHand-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="form-group storeKeeperExperienceInHandYesDiv">
        <label class="control-label col-sm-5" for="companyName"><fmt:message key="store.supervisor.company.name"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
                <input type="text" name="companyName" value="${ applicantPostAssoc.companyName}" class="form-control" id="skcompanyNameId" placeholder="<fmt:message key="store.supervisor.company.name"/>" maxlength="150" />
            	<div class="help-block with-errors"></div>
        </div>
        
	</div>        
     <div class="form-group storeKeeperExperienceInHandYesDiv">
	        <label class="control-label col-sm-5" for="totalExperienceInYears"><fmt:message key="store.supervisor.total.experience"/>: <span class="red">*</span></label>
	        <div class="col-sm-2">
	            <input value="${applicantPostAssoc.totalExperienceInYears}" type="tel" class="form-control" id="skassistantJuniorTotalExperienceInYears" placeholder="<fmt:message key="accountantJunior.experienced.inYears"/>" name="totalExperienceInYears"  min="0" maxlength="2">
	            <div class="help-block with-errors"></div>
	        </div>
	        <div class="col-sm-2">
	            <input value="${applicantPostAssoc.totalExperienceInMonths}" type="tel" class="form-control" id="skassistantJuniorTotalExperienceInMonths" placeholder="<fmt:message key="accountantJunior.experienced.inMonths"/>" name="totalExperienceInMonths"  min="0" maxlength="2" >
	            <div class="help-block with-errors"></div>
	        </div>
	    </div>
</div>	    
    
    <jsp:include page="postFooter.jsp">
    	<jsp:param name="isPostSubmitted" value="${ applicantPostAssoc.status eq 2 || applicantPostAssoc.status eq 3 }"/>
    	<jsp:param name="formId" value="storeKeeperJuniorForm"/>
		<jsp:param name="postId" value="${post.postId}"/>
		<jsp:param name="disableFormAfterLastDateOver" value="${disableFormAfterLastDateOver}"/>
	</jsp:include>
</form>

<script>
 $(document).ready(function(){
  $.validator.addMethod("checkboxes", function(value, element) {
	    return $( '.storeKeeperDifferentlyAbledToggle' ).find('input:checked').length > 0;
	}, "Please select atleast one checkbox");  
  
 $("form[name='storeKeeperJuniorForm']").validate({
 	rules:{
 		 bComOrBSCOrDiplomaHoldersInAutomobileOrMechanical : "required",
 		 degreeName: {required: true},
 		 universityName: {required: true},
 		 differentlyAbled : "required",
 		 mscitOrGaccc : "required",
 		 oneYearExpAsTransportAssociation : "required",
 		 companyName : {required: true},
 		 totalExperienceInYears :{required: true, numbersonly:true, min : 1, max:100},
 		 totalExperienceInMonths :{required: true, numbersonly:true, max: 11},
 		 '#storeKeeper-differentlyAbled-deafAndMute' : { checkboxes: true }
 		  },
		  messages:{
			  totalExperienceInMonths : {max : "<fmt:message key="number.eleven" var="key" /><fmt:message key="validate.maxMonths"><fmt:param value="${key}" /></fmt:message>"}
		  },
	     errorPlacement: function (error, element) {
		    	if ( element.is(":radio")) 
	            {
					error.appendTo(element.parent().parent().children('.help-block.with-errors'));
	            }else if(element.is(":checkbox"))
		         {
	            	$("#storeKeeper-differentlyAbled-yes").parent().parent().find('.help-block').empty().append("<fmt:message key="differently.abled.select.option"/>");
		         }
		    	else
		    	{
		    		error.insertAfter( element );
		    	}
	    	}
	 });
 });
 </script>