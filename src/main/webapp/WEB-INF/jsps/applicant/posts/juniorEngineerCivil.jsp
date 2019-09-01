<%@ include file="../../common/taglibs.jsp"%>

<script>

    jQuery(document).ready(function() {
        postSelectionObj.disableFormFields ("juniorEngineerCivilForm", '${applicantPostAssoc.status}');
        postSelectionObj.bindPostForm("juniorEngineerCivilForm");
		
        checkIfShowOrHideElements();

        differentlyAbledOthersAction();
        actionOnCheckBoxSelected();
        var lastDateOver = commonObj.isValidate(${disableFormAfterLastDateOver});
	    commonObj.disableFormFields("juniorEngineerCivilForm",lastDateOver);
    });

 // ----------------------------- differentlyAbledOthersAction -------------------------
 	//$('#juniorEngineerCivil-differentlyAbled-locomotorOrCerebralPalsy').click(removeHelpBlockAction);
 	
 	$('#juniorEngineerCivil-differentlyAbled-locomotorOrCerebralPalsy').click(juniorEngCivilCheckBoxAction);
 	$('#juniorEngineer-differentlyAbled-others').click(differentlyAbledOthersAction);

	function juniorEngCivilCheckBoxAction(){
		if(jQuery('input[id=juniorEngineerCivil-differentlyAbled-locomotorOrCerebralPalsy]').is(':checked')){
			commonObj.showAgreeDisAgreePopup("<b> <fmt:message key='driver.differentlyAbled.osteogenesisOrLocomotorOrCerebralPalsy' />:</b>  <fmt:message key='junior.engg.civil.locomotive.or.cerebralpalsy.agree.disagree.popup.msg' />", juniorEngCivilDifferentlyAbledAction, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
			removeHelpBlockAction();
		}else
		{
			$( '.juniorEngineerCivilDifferentlyAbledToggle' ).find('input').prop('required', true);
			$("#juniorEngineerCivil-differentlyAbled-yes").parent().parent().find('.help-block').empty().append("<fmt:message key="differently.abled.select.option"/>")
		}
	}
 	function juniorEngCivilDifferentlyAbledAction(flag)
 	{
		if(!flag)
		{
			$('#juniorEngineerCivil-differentlyAbled-locomotorOrCerebralPalsy').prop('checked', false);
			$( '.juniorEngineerCivilDifferentlyAbledToggle' ).find('input').prop('required', true);
		}else
		{
			$("#juniorEngineerCivil-differentlyAbled-yes").parent().parent().find('.help-block').empty();
		}
 	}
 	function removeHelpBlockAction()
 	{
 	 	var locoPalsy = jQuery('input[id=juniorEngineerCivil-differentlyAbled-locomotorOrCerebralPalsy]').is(':checked');
 	 	var other = jQuery('input[id=juniorEngineer-differentlyAbled-others]').is(':checked');
 	 	commonValidation(locoPalsy, other);
 	 	
 	}

	function commonValidation(flagOne, flagTwo)
	{
		if(flagOne || flagTwo)
		{
			$("#juniorEngineerCivil-differentlyAbled-yes").parent().parent().find('.help-block').empty();
	 		$( '.juniorEngineerCivilDifferentlyAbledToggle' ).find('input').prop('required', false);
		}else 
		{
			$( '.juniorEngineerCivilDifferentlyAbledToggle' ).find('input').prop('required', true);
		}
	}
	
	function differentlyAbledOthersAction()
	{
		var locoPalsy = jQuery('input[id=juniorEngineerCivil-differentlyAbled-locomotorOrCerebralPalsy]').is(':checked');
 	 	var other = jQuery('input[id=juniorEngineer-differentlyAbled-others]').is(':checked');
 	 	commonValidation(locoPalsy, other);
 	 	
		if(jQuery('input[id=juniorEngineer-differentlyAbled-others]').is(':checked')) {
			$("#juniorEngineer-differentlyAbled-others-text").show();
			resetFieldsAndAttributes(['juniorEngineer-differentlyAbled-others-text'], true);
			 			
		 }else if(!jQuery('input[id=juniorEngineer-differentlyAbled-others]').is(':checked')){
			$("#juniorEngineer-differentlyAbled-others-text").hide();
			resetFieldsAndAttributes(['juniorEngineer-differentlyAbled-others-text'], false);
			$("#juniorEngineer-differentlyAbled-others-text").parent().find('label.error').empty();
		 }else
		  {
			 $("#juniorEngineer-differentlyAbled-others-text").hide();
			 resetFieldsAndAttributes(['juniorEngineer-differentlyAbled-others-text'], false);
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
   // ----------------------------------------------------------------
    
    function checkIfShowOrHideElements() {
    	
    	if ('${applicantPostAssoc.differentlyAbled}'=='' || '${applicantPostAssoc.differentlyAbled}'=='false') {
			postSelectionObj.hideElementsByClass('juniorEngineerCivilDifferentlyAbledToggle');
			postSelectionObj.resetCheckBoxById('juniorEngineer-differentlyAbled-others');
			$("#juniorEngineer-differentlyAbled-others-text").parent().find('label.error').empty();
			removeHelpBlockAction();
		}else{
			removeHelpBlockAction();
		}
    	
    	if ('${applicantPostAssoc.architectEngineeringDegree}' == ''||'${applicantPostAssoc.architectEngineeringDegree}' == 'false') {
    		postSelectionObj.hideElementsByClass('architectEngineeringDegreeToggle');
    	}
    }
    
    $( 'form#juniorEngineerCivilForm' ).find('input[type=radio][name=architectEngineeringDegree]').unbind().change(function() {
        if (this.value == '1') 
        {
        	$('#juniorEngineerCivil-degreeName').attr("required", true);
        	$('#juniorEngineerCivil-universityName').attr("required", true);
        	$('#juniorEngineerCivil-RequiredQualificationMarks').attr("required", true);
       		 postSelectionObj.showElementsByClass('architectEngineeringDegreeToggle');
        } 
        else 
        {
        	$('#juniorEngineerCivil-degreeName').attr("required", false);
        	$('#juniorEngineerCivil-universityName').attr("required", false);
        	$('#juniorEngineerCivil-RequiredQualificationMarks').attr("required", false);
        	postSelectionObj.resetTextFieldById('juniorEngineerCivil-degreeName');
        	postSelectionObj.resetTextFieldById('juniorEngineerCivil-universityName');
        	postSelectionObj.resetTextFieldById('juniorEngineerCivil-RequiredQualificationMarks');
        	postSelectionObj.hideElementsByClass('architectEngineeringDegreeToggle');
        }
    });

    function actionOnCheckBoxSelected() {
       
        var total = $( '.juniorEngineerCivilDifferentlyAbledToggle' ).find('input:checked').length;
        if (total > 0) {
            removeHelpBlockAction();
            $("#juniorEngineerCivil-differentlyAbled-yes").parent().parent().find('.help-block').empty();
        } else {
            removeHelpBlockAction();
        }
    }
    
    $( '.juniorEngineerCivilDifferentlyAbledToggle' ).find('input').click(function() {
    	removeHelpBlockAction();
  });
    

    $( 'form#juniorEngineerCivilForm' ).find('input[type=radio][name=differentlyAbled]').unbind().change(function() {
		 
        if (this.value == '1') {
	       	 postSelectionObj.showElementsByClass('juniorEngineerCivilDifferentlyAbledToggle');
	       	 $( '.juniorEngineerCivilDifferentlyAbledToggle' ).find('input').prop('required', true);
	       	 if('${applicantPostAssoc.ageValid}'=='true'){
	       		 $('#juniorEnggCivilFormContainerDiv').show();
	       		 $( 'form#juniorEngineerCivilForm' ).find('#saveBtn').show();
	       		 $( 'form#juniorEngineerCivilForm' ).find('#saveAsDraftBtn').show();
	       		 //$('#saveBtn').show();
	       		 //$('#saveAsDraftBtn').show();
	       	 }else{
	       		commonObj.showAlert("<fmt:message key="ageValidationError" />");
	       		$('#juniorEnggCivilFormContainerDiv').hide();
	       		$( 'form#juniorEngineerCivilForm' ).find('#saveBtn').hide();
	       		$( 'form#juniorEngineerCivilForm' ).find('#saveAsDraftBtn').hide();
	       		//$('#saveBtn').hide();
	       		//$('#saveAsDraftBtn').hide();
	       	 }
        } else {
        	$("#juniorEngineerCivil-differentlyAbled-yes").parent().parent().find('.help-block').empty();
	       	 postSelectionObj.hideElementsByClass('juniorEngineerCivilDifferentlyAbledToggle');
	       	 postSelectionObj.resetCheckBoxById('juniorEngineer-differentlyAbled-others');
	       	 postSelectionObj.resetCheckBoxById('juniorEngineerCivil-differentlyAbled-locomotorOrCerebralPalsy');
	       	 $("#juniorEngineer-differentlyAbled-others-text").hide();
	       	 postSelectionObj.resetTextFieldById('juniorEngineer-differentlyAbled-others-text');
	       	$("#juniorEngineer-differentlyAbled-others-text").parent().find('label.error').empty();
	       	if('${applicantPostAssoc.ageInvalid}'=='true'){
	       		 $('#juniorEnggCivilFormContainerDiv').show();
	       		 $( 'form#juniorEngineerCivilForm' ).find('#saveBtn').show();
	       		 $( 'form#juniorEngineerCivilForm' ).find('#saveAsDraftBtn').show();
	       		 //$('#saveBtn').show();
	       		 //$('#saveAsDraftBtn').show();
	       	 }else{
	       		commonObj.showAlert("<fmt:message key="ageValidationError" />");
	       		$('#juniorEnggCivilFormContainerDiv').hide();
	       		$( 'form#juniorEngineerCivilForm' ).find('#saveBtn').hide();
	       		$( 'form#juniorEngineerCivilForm' ).find('#saveAsDraftBtn').hide();
	       		//$('#saveBtn').hide();
	       		//$('#saveAsDraftBtn').hide();
	       	 }
        }
    });
    function viewFileCivil() {
    	var url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/Civil.pdf'/>";
    	window.open(url,'_blank');
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
    
    $( 'form#juniorEngineerCivilForm' ).find('input[type=radio][name=mscitOrGaccc]').unbind().change(function() {
    	
    	if(this.value == '0'){
    		 commonObj.showAgreeDisAgreePopup("<fmt:message key='mscit.equivalent.computer.certificate.alert' />", mscitCertificatePopUpCivil, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
    	     
    	}
    });
    
    function mscitCertificatePopUpCivil(flag)
    {
    	if(!flag)
    	{
    		$('#juniorEngineerCivil-mscitOrGaccc-yes').prop('checked', true);
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

<form class="form-horizontal" name="juniorEngineerCivilForm" id="juniorEngineerCivilForm" action="<c:url value='/applicant?operation=saveApplicantPostDetails'/>" method="POST">

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${applicantPostAssoc.id}"/>
    <input type="hidden" name="postId" value="${post.postId}"/>
    <input type="hidden" name="status" id="status"  value="${ applicantPostAssoc.status }"/>

	<div class="form-group">
        <label class="control-label col-sm-5" for="differentlyAbled"><fmt:message key="driver.differentlyAbled"/>: <span class="red">*&nbsp;&nbsp;</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="differentlyAbled" id="juniorEngineerCivil-differentlyAbled-yes" value="1" type="radio" ${applicantPostAssoc.differentlyAbled ? 'checked' : ''} />
                <label for="juniorEngineerCivil-differentlyAbled-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input name="differentlyAbled" id="juniorEngineerCivil-differentlyAbled-no" value="0" type="radio" ${applicantPostAssoc.differentlyAbled == false  ? 'checked' : ''} />
                <label for="juniorEngineerCivil-differentlyAbled-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group juniorEngineerCivilDifferentlyAbledToggle">
    	<div class="col-sm-5">&nbsp;</div>
        <div class="col-sm-4">
        	<div class="checkbox">
	        	 <input value="1" type="checkbox" class="form-control"  id="juniorEngineerCivil-differentlyAbled-locomotorOrCerebralPalsy" placeholder="<fmt:message key="driver.differentlyAbled.osteogenesisOrLocomotorOrCerebralPalsy"/>" name="locomotorOrCerebralPalsy" ${applicantPostAssoc.locomotorOrCerebralPalsy ? 'checked' : ''}>
               <label for="juniorEngineerCivil-differentlyAbled-locomotorOrCerebralPalsy"><fmt:message key="driver.differentlyAbled.osteogenesisOrLocomotorOrCerebralPalsy"/></label>
	        	
        	</div>
           	<div class="help-block with-errors"></div>
        </div>
    </div>
<div id="juniorEnggCivilFormContainerDiv">
 	<div class="form-group">
        <label class="control-label col-sm-5" for="architectEngineeringDegree"><fmt:message key="juniorEngineerCivil.architectEngineeringDegree"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="architectEngineeringDegree" id="juniorEngineerCivil-architectEngineeringDegree-yes" value="1" type="radio" ${applicantPostAssoc.architectEngineeringDegree ? 'checked' : ''} />
                <label for="juniorEngineerCivil-architectEngineeringDegree-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="architectEngineeringDegree" id="juniorEngineerCivil-architectEngineeringDegree-no" value="0" type="radio" ${applicantPostAssoc.architectEngineeringDegree == false ? 'checked' : ''} />
                <label for="juniorEngineerCivil-architectEngineeringDegree-no"> <fmt:message key="no"/> </label>
            </div> <div class="help-block with-errors"></div>
        </div>
    </div>
    <%-- <div class="form-group architectEngineeringDegreeToggle">
        <label class="control-label col-sm-5" for="degreeName"><fmt:message key="juniorEngineerCivil.degreeName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.degreeName}" type="text" class="form-control" id="juniorEngineerCivil-degreeName" placeholder="<fmt:message key="juniorEngineerCivil.degreeName"/>" name="degreeName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div> --%>
    <div class="form-group architectEngineeringDegreeToggle">
        <label class="control-label col-sm-5" for="universityName"><fmt:message key="juniorEngineerCivil.universityName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.universityName}" type="text" class="form-control" id="juniorEngineerCivil-universityName" placeholder="<fmt:message key="juniorEngineerCivil.universityName"/>" name="universityName" maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
     <div class="form-group architectEngineeringDegreeToggle">
      <label class="control-label col-sm-5" for="juniorEngineerCivil-RequiredQualificationMarks"><fmt:message key="driverCumConductor.required.qualification.marks.obtained"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.requiredQualificationMarks}" type="number" class="form-control" id="juniorEngineerCivil-RequiredQualificationMarks" placeholder="<fmt:message key="driverCumConductor.required.qualification.marks.obtained"/>" name="requiredQualificationMarks" maxlength="5" min="1" max="100">
            <div class="help-block with-errors"></div>
        </div>
     </div>
    
    <div class="form-group">
        <label class="control-label col-sm-5" for="juniorEngineerCivilMscit"><fmt:message key="assistantTrafficSuperintendent.mscitOrGaccc"/>: <span class="red">*&nbsp;&nbsp;##</span><a href="javascript:void(0);" onclick="javascript:viewFileMscit(1)" style="font-size: 9px; font-style: italic"><fmt:message key="post.mscit.one"/></a>&nbsp;&nbsp; 
        <a href="javascript:void(0);" onclick="javascript:viewFileMscit(2)" style="font-size: 9px; font-style: italic"><fmt:message key="post.mscit.two"/></a></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="mscitOrGaccc" id="juniorEngineerCivil-mscitOrGaccc-yes" value="1" type="radio" ${applicantPostAssoc.mscitOrGaccc ? 'checked' : ''} />
                <label for="juniorEngineerCivil-mscitOrGaccc-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input  name="mscitOrGaccc" id="juniorEngineerCivil-mscitOrGaccc-no" value="0" type="radio" ${applicantPostAssoc.mscitOrGaccc == false ? 'checked' : ''} />
                <label for="juniorEngineerCivil-mscitOrGaccc-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    
  <%--   
    <div class="form-group juniorEngineerCivilDifferentlyAbledToggle">
    	<div class="col-sm-5">&nbsp;</div>
        <div class="col-sm-4">
        	<div class="checkbox">
	        	<input value="1" name="differentlyAbledOthers" type="checkbox" class="form-control"  id="juniorEngineer-differentlyAbled-others" placeholder="<fmt:message key="clerkTypistJunior.differentlyAbled.others"/>" ${applicantPostAssoc.differentlyAbledOthers ? 'checked' : ''}   maxlength="100">
	        	<label for="juniorEngineer-differentlyAbled-others"><fmt:message key="clerkTypistJunior.differentlyAbled.others"/></label><span class="red">*</span>
        	</div>
           	<div class="help-block with-errors"></div>
        </div>
    </div>
	<div class="form-group juniorEngineerCivilDifferentlyAbledToggledOthersTextToggle">
    	<div class="col-sm-5">&nbsp;</div>
        <div class="col-sm-4">
        	<input value="${applicantPostAssoc.differentlyAbledOthersText}" name="differentlyAbledOthersText" type="text" class="form-control"  id="juniorEngineer-differentlyAbled-others-text" placeholder="<fmt:message key="clerkTypistJunior.differentlyAbled.others.text"/>" maxlength="100">
        	<div class="help-block with-errors"></div>
        </div>
    </div> --%>
 </div>   
    <jsp:include page="postFooter.jsp">
        <jsp:param name="isPostSubmitted" value="${ applicantPostAssoc.status eq 2 || applicantPostAssoc.status eq 3 }"/>
        <jsp:param name="formId" value="juniorEngineerCivilForm"/>
        <jsp:param name="postId" value="${post.postId}"/>
        <jsp:param name="disableFormAfterLastDateOver" value="${disableFormAfterLastDateOver}"/>
    </jsp:include>

</form>

<script>
 $(document).ready(function(){

	 $.validator.addMethod("checkboxes", function(value, element) {
		    return $( '.juniorEngineerCivilDifferentlyAbledToggle' ).find('input:checked').length > 0;
		}, "Please select atleast one checkbox");
	 
 $("form[name='juniorEngineerCivilForm']").validate({
 	rules:{
 		 architectEngineeringDegree : "required",
 		 differentlyAbled : "required", 
 		 mscitOrGaccc : "required",
 		 degreeName: {required: true},
 		 universityName: {required: true},
 		requiredQualificationMarks:{required: true , min:35},
 		 '#juniorEngineer-differentlyAbled-others' : { checkboxes: true }
 		  },
	     errorPlacement: function (error, element) {
		    	if ( element.is(":radio"))
	            {
					error.appendTo(element.parent().parent().children('.help-block.with-errors'));
	            }
		    	else if (element.is(":checkbox") )
		    	{
					//$("#juniorEngineerCivil-differentlyAbled-yes").parent().parent().find('.help-block').empty().append("<fmt:message key="clerkTypistJunior.atleastone"/>")
					$("#juniorEngineerCivil-differentlyAbled-yes").parent().parent().find('.help-block').empty().append("<fmt:message key="differently.abled.select.option"/>")
		    		
		    	}
		    	else
		    	{
		    		error.insertAfter( element );
		    	}
	    	}
	 });
 });
 </script>