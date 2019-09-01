<%@ include file="../../common/taglibs.jsp"%>

<script>

    jQuery(document).ready(function() {
        postSelectionObj.disableFormFields ("divisionControllerForm", '${applicantPostAssoc.status}');
        postSelectionObj.bindPostForm("divisionControllerForm");

        var lastDateOver = commonObj.isValidate(${disableFormAfterLastDateOver});
	    commonObj.disableFormFields("divisionControllerForm",lastDateOver);

       // educationDetailsToggle('${ applicantPostAssoc.gradOrPostGrad  }');
	    toggleWorkExp('${ applicantPostAssoc.workExp  }');
	    
	    toggleGraduationMarks('${applicantPostAssoc.requiredQualificationMarks }');
    });

    /* function educationDetailsToggle(gradOrPostGrad){

        if(gradOrPostGrad == "" || gradOrPostGrad == null || gradOrPostGrad == undefined){
            jQuery(".divisionControllerRequiredQualificationMarks").hide();
            jQuery(".divisionControllerDegreeName").hide();
            jQuery(".divisionControllerUniversityName").hide();

            jQuery(".divisionControllerMscitOrGaccc").hide();
            jQuery(".divisionControllerInstituteName").hide();

            jQuery(".divisionControllerWorkExp").hide();

            jQuery(".divisionControllerPostName").hide();
            jQuery(".divisionControllerDivision").hide();

            jQuery(".divisionControllerOrganizationName").hide();
            jQuery(".divisionControllerTotalExperience").hide();

        } else {

            jQuery(".divisionControllerRequiredQualificationMarks").show();
            jQuery(".divisionControllerDegreeName").show();
            jQuery(".divisionControllerUniversityName").show();

            jQuery(".divisionControllerMscitOrGaccc").show();
            jQuery(".divisionControllerInstituteName").show();

            jQuery(".divisionControllerWorkExp").show();

        //    jQuery(".divisionControllerPostName").show();
        //    jQuery(".divisionControllerDivision").show();

        //    jQuery(".divisionControllerOrganizationName").show();
        //    jQuery(".divisionControllerTotalExperience").show();

        }

    } */
    
    function eligibleMsg(marks){
    	
    	if(marks<45){
    		$('#divisionControllerForm').find(".divisionControllerRequiredQualificationMarks").find(".help-block").html(jQuery("#notEligibleForPost").val());
       	 
    	}else{
    		$('#divisionControllerForm').find(".divisionControllerRequiredQualificationMarks").find(".help-block").html("");
    	}
    	
    }
    
    function toggleGraduationMarks(marks){
        if(marks == "" || marks == null || marks == undefined || marks == '0.0' ){
            jQuery(".postgraddegreeDiv").hide();
        }else if(marks >= 45 && marks < 60){
        	jQuery(".postgraddegreeDiv").show();
        	$('#divisionControllerForm').find('#saveAsDraftBtn').removeAttr("disabled");
        	$('#divisionControllerForm').find('#saveBtn').removeAttr("disabled");
        	$('#divisionControllerForm').find('#postGradDegreeTypeId').prop('required', true);
        	$('#divisionControllerForm').find('#postGradDegreeInstituteName').prop('required', true);
        	eligibleMsg(marks);
        	
        	var mscitOrGacccVal = $("input:radio[name=mscitOrGaccc]:checked").val()
        	
        	if(mscitOrGacccVal== '0'){
        		 $('#divisionControllerForm').find('#saveAsDraftBtn').attr('disabled', 'disabled');
            	 $('#divisionControllerForm').find('#saveBtn').attr('disabled', 'disabled');
        	}
        	 /* if($('#divisionControllerForm').find('#divisionController-mscitOrGaccc-no').val() == 0){
        		 $('#divisionControllerForm').find('#saveAsDraftBtn').attr('disabled', 'disabled');
            	 $('#divisionControllerForm').find('#saveBtn').attr('disabled', 'disabled');
        	 } */
        		 
        	
        	/* $('#postGradDegreeTypeId').validate({
                rules: {
                	postGradDegreeTypeId: "required : true"
                }
            }); */
        	
        }else if(marks < 45){
        		jQuery(".postgraddegreeDiv").hide();
        	 $('#divisionControllerForm').find('#saveAsDraftBtn').attr('disabled', 'disabled');
        	 $('#divisionControllerForm').find('#saveBtn').attr('disabled', 'disabled');
        	 $('#divisionControllerForm').find('#postGradDegreeTypeId').prop('required',false);
        	 $('#divisionControllerForm').find('#postGradDegreeInstituteName').prop('required',false);
        	
        	 eligibleMsg(marks);
        	 
        }else{
        	jQuery(".postgraddegreeDiv").hide();
        	$('#divisionControllerForm').find('#saveAsDraftBtn').removeAttr("disabled");
        	$('#divisionControllerForm').find('#saveBtn').removeAttr("disabled");
        	 $('#divisionControllerForm').find('#postGradDegreeTypeId').prop('required', false);
        	 $('#divisionControllerForm').find('#postGradDegreeInstituteName').prop('required', false);
        	 
        	 eligibleMsg(marks);
        	 var mscitOrGacccVal = $("input:radio[name=mscitOrGaccc]:checked").val()
         	
         	if(mscitOrGacccVal== '0'){
         		 $('#divisionControllerForm').find('#saveAsDraftBtn').attr('disabled', 'disabled');
             	 $('#divisionControllerForm').find('#saveBtn').attr('disabled', 'disabled');
         	}
        }
       
        
    }
    

    function toggleWorkExp(workExpId){
        if(workExpId == "" || workExpId == null || workExpId == undefined){
            jQuery(".divisionControllerPostName").hide();
            jQuery(".divisionControllerDivision").hide();

            jQuery(".divisionControllerOrganizationName").hide();
            jQuery(".divisionControllerTotalExperience").hide();

        } else if(workExpId == 4){
        	$("#divisionController-companyName").parent().parent().find("label.error").empty();
			$("#divisionControllerTotalExperienceInYears").parent().parent().find("label.error").empty();
			$("#divisionControllerTotalExperienceInMonths").parent().parent().find("label.error").empty();
			postSelectionObj.resetTextFieldById('divisionController-companyName');
			postSelectionObj.resetTextFieldById('divisionControllerTotalExperienceInYears');
			postSelectionObj.resetTextFieldById('divisionControllerTotalExperienceInMonths');
			jQuery(".divisionControllerOrganizationName").hide();
            jQuery(".divisionControllerTotalExperience").hide();
            jQuery(".divisionControllerPostName").show();
            jQuery(".divisionControllerDivision").show();
        } else {
        	$("#divisionController-postName").parent().parent().find("label.error").empty();
			$("#divisionControllerDivision").parent().parent().find("label.error").empty();
			postSelectionObj.resetTextFieldById('divisionController-postName');
			postSelectionObj.resetTextFieldById('divisionControllerDivision');
            jQuery(".divisionControllerPostName").hide();
            jQuery(".divisionControllerDivision").hide();

            jQuery(".divisionControllerOrganizationName").show();
            jQuery(".divisionControllerTotalExperience").show();
        }
    }

</script>

<div id="downloadEligibilityCriteria" class="form-group" align="right">
    <div class="col-sm-12" align="pull-right">
        <a href="javascript:void(0);" onclick="javascript:showEligibilityCriteriaPDF(${post.postId})"><b><fmt:message key="postEligibilityCriteriaLink"/></b></a>
    </div>
</div>

<form class="form-horizontal" name="divisionControllerForm" id="divisionControllerForm" action="<c:url value='/applicant?operation=saveApplicantPostDetails'/>" method="POST">

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${applicantPostAssoc.id}"/>
    <input type="hidden" name="postId" value="${post.postId}"/>
    <input type="hidden" name="status" id="status"  value="${ applicantPostAssoc.status }"/>

	<%-- <div class="form-group">
        <label class="control-label col-sm-5" for="sscPassed"><fmt:message key="divisionController.educationDetails"/>: <span class="red">*</span></label>
       </div> --%>

   <%--  <div class="form-group">
        <label class="control-label col-sm-5" for="sscPassed"><fmt:message key="divisionController.educationDetails"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="gradOrPostGrad"  onclick="javascript:educationDetailsToggle(1)" id="divisionController-gradOrPostGrad-yes" value="1" type="radio" ${applicantPostAssoc.gradOrPostGrad eq 1 ? 'checked' : ''} />
                <label for="divisionController-gradOrPostGrad-yes"> <fmt:message key="divisionController.graduate"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="" name="gradOrPostGrad"  onclick="javascript:educationDetailsToggle(2)" onclick="javascript:void(0);" data-backdrop="static" data-keyboard="false" data-target="#divisionControllerPostGraduateModal" data-toggle="modal" id="divisionController-gradOrPostGrad-no" value="2" type="radio" ${applicantPostAssoc.gradOrPostGrad eq 2 ? 'checked' : ''} />
                <label for="divisionController-gradOrPostGrad-no"> <fmt:message key="divisionController.postGraduate"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div> --%>

    <div class="form-group divisionControllerRequiredQualificationMarks">
        <label class="control-label col-sm-5" for="divisionControllerRequiredQualificationMarks"><fmt:message key="divisionController.marks"/> %: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.requiredQualificationMarks}"  oninput="javascript:toggleGraduationMarks(this.value);" type="number" class="form-control" id="divisionControllerRequiredQualificationMarks" placeholder="<fmt:message key="divisionController.marks"/>" name="requiredQualificationMarks" maxlength="5" min="1" max="100">
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group divisionControllerDegreeName">
        <label class="control-label col-sm-5" for="divisionController-degreeName"><fmt:message key="divisionController.degreeName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input onblur="javascript:this.value=this.value.toUpperCase().trim();" value="${applicantPostAssoc.degreeName}" type="text" class="form-control" id="divisionController-degreeName" placeholder="<fmt:message key="divisionController.degreeName"/>" name="degreeName" maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group divisionControllerUniversityName">
        <label class="control-label col-sm-5" for="divisionController-universityName"><fmt:message key="divisionController.universityName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.universityName}" type="text" class="form-control" id="divisionController-universityName" placeholder="<fmt:message key="divisionController.universityName"/>" name="universityName" maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    
    <div class="postgraddegreeDiv" id="postgraddegreeDiv" hidden>
    <div class="form-group postgraddegree">
        <label class="control-label col-sm-5" for="postgraddegree"><fmt:message key="postgraddegree.label"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <select id="postGradDegreeTypeId" name="postGradDegreeTypeId" class="form-control">
                <option value="">-- <fmt:message key="divisionController.postGradDegreeTypeId.select"/> --</option>
                <option value="1" ${ applicantPostAssoc.postGradDegreeTypeId eq 1? 'selected':'' }><fmt:message key="postgraddegree.type1" /></option>
                <option value="2" ${ applicantPostAssoc.postGradDegreeTypeId eq 2? 'selected':'' }><fmt:message key="postgraddegree.type2" /></option>
                <option value="3" ${ applicantPostAssoc.postGradDegreeTypeId eq 3? 'selected':'' }><fmt:message key="postgraddegree.type3" /></option>
            </select>
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <div class="form-group postgradinstituteName">
        <label class="control-label col-sm-5" for="postgradinstituteName"><fmt:message key="postgraddegree.instituteName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.postGradDegreeInstituteName}" type="text" class="form-control" id="postGradDegreeInstituteName" placeholder="<fmt:message key="divisionController.universityName"/>" name="postGradDegreeInstituteName" maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
    </div>
   </div>
 
    

    <div class="form-group divisionControllerMscitOrGaccc">
        <label class="control-label col-sm-5"><fmt:message key="divisionController.mscitOrGaccc"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <div class="radio radio-inline">
                <input name="mscitOrGaccc" ${ applicantPostAssoc.mscitOrGaccc ? 'checked="checked"':''} id="divisionController-mscitOrGaccc-yes" value="1" type="radio" />
                <label for="divisionController-mscitOrGaccc-yes"> <fmt:message key="yes"/> </label>
            </div>
            <div class="radio radio-inline">
                <input class="radiosToCheck" name="mscitOrGaccc" ${applicantPostAssoc.mscitOrGaccc == false ? 'checked="checked"':''} id="divisionController-mscitOrGaccc-no" value="0" type="radio" />
                <label for="divisionController-mscitOrGaccc-no"> <fmt:message key="no"/> </label>
            </div>
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group divisionControllerInstituteName">
        <label class="control-label col-sm-5" for="divisionController-instituteName"><fmt:message key="divisionController.instituteName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.instituteName}" type="text" class="form-control" id="divisionController-instituteName" placeholder="<fmt:message key="divisionController.instituteName"/>" name="instituteName" maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group divisionControllerWorkExp">
        <label class="control-label col-sm-5" for="divisionController-workExp"><fmt:message key="divisionController.workExp"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <select id="divisionController-workExp"  onchange="javascript:toggleWorkExp(this.value);" name="workExp" class="form-control" required oninvalid="this.setCustomValidity('<fmt:message key="validation.requiredfield"/>')">
                <option value="">-- <fmt:message key="divisionController.workExp.select"/> --</option>
                <option value="1" ${ applicantPostAssoc.workExp eq 1? 'selected':'' }><fmt:message key="divisionController.workExp.option1" /></option>
                <option value="2" ${ applicantPostAssoc.workExp eq 2? 'selected':'' }><fmt:message key="divisionController.workExp.option2" /></option>
                <option value="3" ${ applicantPostAssoc.workExp eq 3? 'selected':'' }><fmt:message key="divisionController.workExp.option3" /></option>
                <option value="4" ${ applicantPostAssoc.workExp eq 4? 'selected':'' }><fmt:message key="divisionController.workExp.option4" /></option>
            </select>
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group divisionControllerOrganizationName">
        <label class="control-label col-sm-5" for="divisionController-companyName"><fmt:message key="divisionController.organizationName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.companyName}" type="text" class="form-control" id="divisionController-companyName" placeholder="<fmt:message key="divisionController.organizationName"/>" name="companyName" maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group divisionControllerTotalExperience">
        <label class="control-label col-sm-5"><fmt:message key="divisionController.totalExp"/>: <span class="red">*</span></label>
        <div class="col-sm-2">
            <input value="${applicantPostAssoc.totalExperienceInYears}" type="number" class="form-control" id="divisionControllerTotalExperienceInYears" placeholder="<fmt:message key="divisionController.expInYears"/>" name="totalExperienceInYears" maxlength="2" min="0">
            <div class="help-block with-errors"></div>
        </div>
        <div class="col-sm-2">
            <input value="${applicantPostAssoc.totalExperienceInMonths}" type="number" class="form-control" id="divisionControllerTotalExperienceInMonths" placeholder="<fmt:message key="divisionController.expInMonths"/>" name="totalExperienceInMonths"  min="0" maxlength="2" max="12">
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group divisionControllerPostName">
        <label class="control-label col-sm-5" for="divisionController-postName"><fmt:message key="divisionController.postName"/>: <span class="red">*</span></label>
        <div class="col-sm-4">
            <input value="${applicantPostAssoc.postName}" type="text" class="form-control" id="divisionController-postName" placeholder="<fmt:message key="divisionController.postName"/>" name="postName" maxlength="50">
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group divisionControllerDivision">
        <label for="divisionControllerDivision" class="col-sm-5 control-label"><fmt:message key="divisionController.division" />:<span class="red">*</span></label>
        <div class="col-sm-4">
            <select id="divisionControllerDivision" name="dcDivisionId" class="form-control" data-size="5" required oninvalid="this.setCustomValidity('<fmt:message key="validation.requiredfield"/>')">
                <option value="">-- <fmt:message key="division.select"/> --</option>
                <c:forEach items="${divisionList}" var="division">
                    <option value="${division.divisionId}" ${ division.divisionId eq applicantPostAssoc.dcDivisionId? 'selected':'' }><fmt:message key="${ division.messageKey }" /></option>
                </c:forEach>
            </select>
            <div class="help-block with-errors"></div>
        </div>
    </div>
	<jsp:include page="popup/divisionControllerPostGraduatePopup.jsp"/>
    <jsp:include page="postFooter.jsp">
        <jsp:param name="isPostSubmitted" value="${ applicantPostAssoc.status eq 2 || applicantPostAssoc.status eq 3 }"/>
        <jsp:param name="formId" value="divisionControllerForm"/>
        <jsp:param name="postId" value="${post.postId}"/>
        <jsp:param name="disableFormAfterLastDateOver" value="${disableFormAfterLastDateOver}"/>
    </jsp:include>

</form>

<script>
 $(document).ready(function(){
     $("form[name='divisionControllerForm']").validate({
         rules: {
             gradOrPostGrad: "required",
             requiredQualificationMarks: {
                 required: true,
                // numbersonly: true,
                 min: function() {
                     var min = 0;

                     if($("#divisionController-gradOrPostGrad-yes").is(":checked")){
                        min = 60;
                     }

                     if($("#divisionController-gradOrPostGrad-no").is(":checked")){
                         min = 45;
                     }

                     return min;
                 },
                 max: 100},
             degreeName: {required: true, lettersonly : true},
             universityName: "required",
             mscitOrGaccc: "required",
             instituteName: "required",
             workExp : "required",
             companyName : {
                 required: function(element){
                     var workExpId = $("#divisionController-workExp").val();
                     if(workExpId == 4 || workExpId == '4'){
                         return false;
                     } else {
                         return true;
                     }
                 }
             },
             totalExperienceInYears: {required: function(element){
                     var workExpId = $("#divisionController-workExp").val();
                     if(workExpId == 4 || workExpId == '4'){
                         return false;
                     } else {
                         return true;
                     }
                 }, numbersonly: true, min: function() {
                     var min = 0;
                     var workExpId = $("#divisionController-workExp").val();
                     
                     if(workExpId == 2 || workExpId == '2'){
                        min = 3;
                     }else{
                    	 min=10
                     }

                     return min;
                 }, max: 100},
             totalExperienceInMonths: {required: function(element){
                     var workExpId = $("#divisionController-workExp").val();
                     if(workExpId == 4 || workExpId == '4'){
                         return false;
                     } else {
                         return true;
                     }
                 }, numbersonly: true, max: 11, min: 0},
             postName : {
                 required: function(element){
                     var workExpId = $("#divisionController-workExp").val();
                     if(workExpId == 4 || workExpId == '4'){
                         return true;
                     } else {
                         return false;
                     }
                 }
             },
             dcDivisionId: {
                 required: function(element){
                     var workExpId = $("#divisionController-workExp").val();
                     if(workExpId == 4 || workExpId == '4'){
                         return true;
                     } else {
                         return false;
                     }
                 }
             }
         } ,
         errorPlacement: function (error, element) {
             if ( element.is(":radio"))
             {
                 error.appendTo(element.parent().parent().children('.help-block.with-errors'));
             } else
             {
                 error.insertAfter( element );
             }
         }
     });
 });
 </script>