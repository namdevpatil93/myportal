<%@ include file="../../common/taglibs.jsp"%>

<script>

    jQuery(document).ready(function() {

        postSelectionObj.disableFormFields ("juniorEngineerElectricalForm", '${applicantPostAssoc.status}');
        postSelectionObj.bindPostForm("juniorEngineerElectricalForm");
    	
       /*  jQuery("#juniorEngineerElectricalForm").ajaxForm({
            dataType:  'json',
            beforeSubmit:  function(){
                if (!$('#juniorEngineerElectricalForm').validator('validate').has('.has-error').length) {
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
                    commonObj.showAlert("There was some error while trying to save the Junior Engineer Electrical Form.");
                }
            }

        }); */
        
    	//postSelectionObj.hideElementsByClass('electricalEngineeringDegreeToggle');
//         postSelectionObj.submittingForm("juniorEngineerElectricalForm");
    	checkIfShowOrHideElements();

    	var lastDateOver = commonObj.isValidate(${disableFormAfterLastDateOver});
	    commonObj.disableFormFields("juniorEngineerElectricalForm",lastDateOver);

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
    	
    	if ('${applicantPostAssoc.electricalEngineeringDegree}' == ''||'${applicantPostAssoc.electricalEngineeringDegree}' == 'false') {
    		postSelectionObj.hideElementsByClass('electricalEngineeringDegreeToggle');
    	}
    }
    
    $( 'form#juniorEngineerElectricalForm' ).find('input[type=radio][name=electricalEngineeringDegree]').unbind().change(function() {
        if (this.value == '1') 
        {
        	$('#juniorEngineerElectrical-degreeName').attr("required", true);
        	$('#juniorEngineerElectrical-universityName').attr("required", true);
        	$('#juniorEngineerElectrical-RequiredQualificationMarks').attr("required", true);
       		 postSelectionObj.showElementsByClass('electricalEngineeringDegreeToggle');
        } 
        else 
        {
        	$('#juniorEngineerElectrical-degreeName').attr("required", false);
        	$('#juniorEngineerElectrical-universityName').attr("required", false);
        	$('#juniorEngineerElectrical-RequiredQualificationMarks').attr("required", false);
        	postSelectionObj.resetTextFieldById('juniorEngineerElectrical-degreeName');
        	postSelectionObj.resetTextFieldById('juniorEngineerElectrical-universityName');
        	postSelectionObj.resetTextFieldById('juniorEngineerElectrical-RequiredQualificationMarks');
        	postSelectionObj.hideElementsByClass('electricalEngineeringDegreeToggle');
        }
    });
    
$( 'form#juniorEngineerElectricalForm' ).find('input[type=radio][name=mscitOrGaccc]').unbind().change(function() {
    	
    	if(this.value == '0'){
    		 commonObj.showAgreeDisAgreePopup("<fmt:message key='mscit.equivalent.computer.certificate.alert' />", mscitCertificatePopUpJuniorEngineerElectrical, i18n("popup.agree"), i18n("popup.disagree"), i18n("message"));
    	     
    	}
    });
    
    function mscitCertificatePopUpJuniorEngineerElectrical(flag)
    {
    	if(!flag)
    	{
    		$('#juniorEngineerElectrical-mscitOrGaccc-yes').prop('checked', true);
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

<form class="form-horizontal" name="juniorEngineerElectricalForm" id="juniorEngineerElectricalForm" action="<c:url value='/applicant?operation=saveApplicantPostDetails'/>" method="POST">

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${applicantPostAssoc.id}"/>
    <input type="hidden" name="postId" value="${post.postId}"/>
    <input type="hidden" name="status" id="status"  value="${ applicantPostAssoc.status }"/>

<div class="form-group">
        <label class="control-label col-sm-5" for="electricalEngineeringDegree"><fmt:message key="juniorEngineerElectrical.electricalEngineeringDegree"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="electricalEngineeringDegree" id="juniorEngineerElectrical-electricalEngineeringDegree-yes" value="1" type="radio" ${applicantPostAssoc.electricalEngineeringDegree ? 'checked' : ''} />
                <label for="juniorEngineerElectrical-electricalEngineeringDegree-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="electricalEngineeringDegree" id="juniorEngineerElectrical-electricalEngineeringDegree-no" value="0" type="radio" ${applicantPostAssoc.electricalEngineeringDegree == false ? 'checked' : ''} />
                <label for="juniorEngineerElectrical-electricalEngineeringDegree-no"> <fmt:message key="no"/> </label>
            </div> <div class="help-block with-errors"></div>
        </div>
    </div>
    <%-- <div class="form-group electricalEngineeringDegreeToggle">
        <label class="control-label col-sm-5" for="degreeName"><fmt:message key="juniorEngineerElectrical.degreeName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.degreeName}" type="text" class="form-control" id="juniorEngineerElectrical-degreeName" placeholder="<fmt:message key="juniorEngineerCivil.degreeName"/>" name="degreeName"  maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div> --%>
    <div class="form-group electricalEngineeringDegreeToggle">
        <label class="control-label col-sm-5" for="universityName"><fmt:message key="juniorEngineerCivil.universityName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.universityName}" type="text" class="form-control" id="juniorEngineerElectrical-universityName" placeholder="<fmt:message key="juniorEngineerCivil.universityName"/>" name="universityName"  maxlength="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
     <div class="form-group electricalEngineeringDegreeToggle">
      <label class="control-label col-sm-5" for="juniorEngineerElectrical-RequiredQualificationMarks"><fmt:message key="driverCumConductor.required.qualification.marks.obtained"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.requiredQualificationMarks}" type="number" class="form-control" id="juniorEngineerElectrical-RequiredQualificationMarks" placeholder="<fmt:message key="driverCumConductor.required.qualification.marks.obtained"/>" name="requiredQualificationMarks" maxlength="5" min="1" max="100">
            <div class="help-block with-errors"></div>
        </div>
     </div>
    
     <div class="form-group">
        <label class="control-label col-sm-5" for="juniorEngineerElectricalMscit"><fmt:message key="assistantTrafficSuperintendent.mscitOrGaccc"/>: <span class="red">*&nbsp;&nbsp;##</span><a href="javascript:void(0);" onclick="javascript:viewFileMscit(1)" style="font-size: 9px; font-style: italic"><fmt:message key="post.mscit.one"/></a>&nbsp;&nbsp; 
        <a href="javascript:void(0);" onclick="javascript:viewFileMscit(2)" style="font-size: 9px; font-style: italic"><fmt:message key="post.mscit.two"/></a></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="mscitOrGaccc" id="juniorEngineerElectrical-mscitOrGaccc-yes" value="1" type="radio" ${applicantPostAssoc.mscitOrGaccc ? 'checked' : ''} />
                <label for="juniorEngineerElectrical-mscitOrGaccc-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input  name="mscitOrGaccc" id="juniorEngineerElectrical-mscitOrGaccc-no" value="0" type="radio" ${applicantPostAssoc.mscitOrGaccc == false ? 'checked' : ''} />
                <label for="juniorEngineerElectrical-mscitOrGaccc-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    

	<jsp:include page="postFooter.jsp">
        <jsp:param name="isPostSubmitted" value="${ applicantPostAssoc.status eq 2 || applicantPostAssoc.status eq 3 }"/>
        <jsp:param name="formId" value="juniorEngineerElectricalForm"/>
		<jsp:param name="postId" value="${post.postId}" />
		<jsp:param name="disableFormAfterLastDateOver" value="${disableFormAfterLastDateOver}"/>
	</jsp:include>
</form>


<script>
 $(document).ready(function(){
 $("form[name='juniorEngineerElectricalForm']").validate({
 	rules:{
 		 electricalEngineeringDegree : "required",
 		 mscitOrGaccc : "required",
 		 degreeName: {required: true},
 		 universityName: {required: true},
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