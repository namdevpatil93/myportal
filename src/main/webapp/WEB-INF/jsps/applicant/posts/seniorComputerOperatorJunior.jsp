<%@ include file="../../common/taglibs.jsp"%>

<script>

    jQuery(document).ready(function() {
    	postSelectionObj.disableFormFields ("seniorComputerOperatorJuniorForm", '${applicantPostAssoc.status}');
        postSelectionObj.bindPostForm("seniorComputerOperatorJuniorForm");
// 		postSelectionObj.submittingForm("seniorComputerOperatorJuniorForm");
        /* jQuery("#seniorComputerOperatorJuniorForm").ajaxForm({
            dataType:  'json',
            beforeSubmit:  function(){
                if (!$('#seniorComputerOperatorJuniorForm').validator('validate').has('.has-error').length) {
                    return true;
                } else {
                    return false;
                }
            },
            success:  function(result){
                var success = result.success;
                if(success){
                    showOtherInformation();
                    return false;
                } else {
                    commonObj.showAlert("There was some error while trying to save the Senior Computer Operator Junior Form.");
                }
            }

        });
 */
	//postSelectionObj.hideElementsByClass('itEngineerToggle');
    checkIfShowOrHideElements();
    var lastDateOver = commonObj.isValidate(${disableFormAfterLastDateOver});
    commonObj.disableFormFields("seniorComputerOperatorJuniorForm",lastDateOver);
    });
    
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
 function checkIfShowOrHideElements() {
    	
    	if ('${applicantPostAssoc.itEngineer}' == ''||'${applicantPostAssoc.itEngineer}' == 'false') {
    		postSelectionObj.hideElementsByClass('itEngineerToggle');
    	}
    }
    
    $( 'form#seniorComputerOperatorJuniorForm' ).find('input[type=radio][name=itEngineer]').unbind().change(function() {
        if (this.value == '1') 
        {
        	$('#seniorComputerOperatorJunior-degreeName').attr("required", true);
        	$('#seniorComputerOperatorJunior-universityName').attr("required", true);
        	$('#seniorComputerOperatorJunior-RequiredQualificationMarks').attr("required", true); 
        	postSelectionObj.showElementsByClass('itEngineerToggle');
        } 
        else 
        {
        	$('#seniorComputerOperatorJunior-degreeName').attr("required", false);
        	$('#seniorComputerOperatorJunior-universityName').attr("required", false);
        	$('#seniorComputerOperatorJunior-RequiredQualificationMarks').attr("required", false);
        	postSelectionObj.resetTextFieldById('seniorComputerOperatorJunior-degreeName');
        	postSelectionObj.resetTextFieldById('seniorComputerOperatorJunior-universityName');
        	postSelectionObj.resetTextFieldById('seniorComputerOperatorJunior-RequiredQualificationMarks');
        	postSelectionObj.hideElementsByClass('itEngineerToggle');
        }
    });
    
$( 'form#seniorComputerOperatorJuniorForm' ).find('input[type=radio][name=mscitOrGaccc]').unbind().change(function() {
    	
    	if(this.value == '0'){
    		 commonObj.showAgreeDisAgreePopup("<fmt:message key='mscit.equivalent.computer.certificate.alert' />", mscitCertificatePopUpSeniorComputerOperatorJunior, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
    	     
    	}
    });
    
    function mscitCertificatePopUpSeniorComputerOperatorJunior(flag)
    {
    	if(!flag)
    	{
    		$('#seniorComputerOperatorJunior-mscitOrGaccc-yes').prop('checked', true);
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

<form class="form-horizontal" name="seniorComputerOperatorJuniorForm" id="seniorComputerOperatorJuniorForm" data-toggle="validator" action="<c:url value='/applicant?operation=saveApplicantPostDetails'/>" method="POST">

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${applicantPostAssoc.id}"/>
    <input type="hidden" name="postId" value="${post.postId}"/>
    <input type="hidden" name="status" id="status"  value="${ applicantPostAssoc.status }"/>

<div class="form-group">
        <label class="control-label col-sm-5" for="itEngineer"><fmt:message key="seniorComputerOperatorJunior.itEngineer"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="itEngineer" id="seniorComputerOperatorJunior-itEngineer-yes" value="1" type="radio" ${applicantPostAssoc.itEngineer ? 'checked' : ''} required/>
                <label for="seniorComputerOperatorJunior-itEngineer-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="itEngineer" id="seniorComputerOperatorJunior-itEngineer-no" value="0" type="radio" ${applicantPostAssoc.itEngineer == false ? 'checked' : ''} required/>
                <label for="seniorComputerOperatorJunior-itEngineer-no"> <fmt:message key="no"/> </label>
            </div> <div class="help-block with-errors"></div>
        </div>
    </div>
    <%-- <div class="form-group itEngineerToggle">
        <label class="control-label col-sm-5" for="degreeName"><fmt:message key="applicant.degreeName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.degreeName}" type="text" class="form-control" id="seniorComputerOperatorJunior-degreeName" placeholder="<fmt:message key="applicant.degreeName"/>" name="degreeName" required  maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div> --%>
    <div class="form-group itEngineerToggle">
        <label class="control-label col-sm-5" for="universityName"><fmt:message key="applicant.universityName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.universityName}" type="text" class="form-control" id="seniorComputerOperatorJunior-universityName" placeholder="<fmt:message key="applicant.universityName"/>" name="universityName" required  maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group itEngineerToggle">
    <label class="control-label col-sm-5" for="seniorComputerOperatorJunior-RequiredQualificationMarks"><fmt:message key="driverCumConductor.required.qualification.marks.obtained"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.requiredQualificationMarks}" type="number" class="form-control" id="seniorComputerOperatorJunior-RequiredQualificationMarks" placeholder="<fmt:message key="driverCumConductor.required.qualification.marks.obtained"/>" name="requiredQualificationMarks" maxlength="5" min="1" max="100">
            <div class="help-block with-errors"></div>
        </div>
       </div> 
    
     <div class="form-group">
        <label class="control-label col-sm-5" for="seniorComputerOperatorJuniorMscit"><fmt:message key="assistantTrafficSuperintendent.mscitOrGaccc"/>: <span class="red">*&nbsp;&nbsp;##</span><a href="javascript:void(0);" onclick="javascript:viewFileMscit(1)" style="font-size: 9px; font-style: italic"><fmt:message key="post.mscit.one"/></a>&nbsp;&nbsp; 
        <a href="javascript:void(0);" onclick="javascript:viewFileMscit(2)" style="font-size: 9px; font-style: italic"><fmt:message key="post.mscit.two"/></a></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="mscitOrGaccc" id="seniorComputerOperatorJunior-mscitOrGaccc-yes" value="1" type="radio" ${applicantPostAssoc.mscitOrGaccc ? 'checked' : ''} />
                <label for="seniorComputerOperatorJunior-mscitOrGaccc-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input  name="mscitOrGaccc" id="seniorComputerOperatorJunior-mscitOrGaccc-no" value="0" type="radio" ${applicantPostAssoc.mscitOrGaccc == false ? 'checked' : ''} />
                <label for="seniorComputerOperatorJunior-mscitOrGaccc-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <jsp:include page="postFooter.jsp">
    	<jsp:param name="isPostSubmitted" value="${ applicantPostAssoc.status eq 2 || applicantPostAssoc.status eq 3 }"/>
        <jsp:param name="formId" value="seniorComputerOperatorJuniorForm"/>
        <jsp:param name="postId" value="${post.postId}"/>
        <jsp:param name="disableFormAfterLastDateOver" value="${disableFormAfterLastDateOver}"/>
    </jsp:include>

</form>

<script>
 $(document).ready(function(){
 $("form[name='seniorComputerOperatorJuniorForm']").validate({
 	rules:{
 		 itEngineer : "required",
 		 mscitOrGaccc : "required",
		 degreeName : {required: true},
		 universityName : {required: true},
		 requiredQualificationMarks:{required: true , min:35}
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