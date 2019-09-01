<%@ include file="../../common/taglibs.jsp"%>

<script>
var isSaveOrSaveAsDraft;
jQuery(document).ready(function() {
     
	var lastDateOver = commonObj.isValidate(${disableFormAfterLastDateOver});
    commonObj.disableFormFields("postPriorityForm",lastDateOver);
     
    jQuery("#postPriorityForm").ajaxForm({
        dataType:  'json',
        beforeSubmit:  function(arr){
        	if(isSaveOrSaveAsDraft=='draft'){
        		$("div .error").remove();
        	}
        	if(isSaveOrSaveAsDraft=='save'){
        		var elements1 = document.getElementsByClassName("postPriority");
	        	for(i=0; i < elements1.length ; i++){
	        		$(elements1[i]).closest("div .errorDiv").html('');
	        	if(elements1[i].value=='0'){
	        		$(elements1[i]).closest("div").append('<div class="error"><fmt:message key="post.priority.slect.priority" /></div>');
	        		//jQuery("#postPriorityForm").find('#saveAsDraftBtn').attr('disabled','disabled');
	                jQuery("#postPriorityForm").find('#saveBtn').attr('disabled','disabled');
	                //jQuery("#postPriorityForm").find('#nextBtn').attr('disabled','disabled');
        			}
        		}
	        	
        	}
        	$(".postPriority").each(function(){
           	 var sPId = $(this).attr('selectedpostId');
        	 var pp = $(this).val();
        	 var val = sPId+"_"+pp; 
        	 arr.push({name:'postPriorityName', value:val})
            });
        	if($('#postPriorityForm').find(".error").length > 0){
        		return false;
        	}else{
        		jQuery("#postPriorityForm").find('#saveAsDraftBtn').attr('disabled','disabled');
        		jQuery("#postPriorityForm").find('#saveBtn').attr('disabled','disabled');
                jQuery("#postPriorityForm").find('#nextBtn').attr('disabled','disabled');
        		return true;
        }
        },
        success:  function(result){
        	var success = result.success;
            if(success){
            	jQuery("#postPriorityForm").find('#saveAsDraftBtn').removeAttr('disabled');
                jQuery("#postPriorityForm").find('#saveBtn').removeAttr('disabled');
                jQuery("#postPriorityForm").find('#nextBtn').removeAttr('disabled');
            	applyObj.showApplicantFiles();
                return false;
            } else {
                commonObj.showAlert("There was some error while trying to save the Post priority Information.");
            }
        }

    });
    
});
    


    function resetDuplicatePriority(val, id, divId){
    	//var elements = document.getElementsByClassName("postPriority");
    	//jQuery("#postPriorityForm").find('#saveAsDraftBtn').removeAttr('disabled');
        jQuery("#postPriorityForm").find('#saveBtn').removeAttr('disabled');
        //jQuery("#postPriorityForm").find('#nextBtn').removeAttr('disabled');
    	var elements = $("#"+divId).find(".postPriority");
    	
    	for(i=0; i < elements.length ; i++){
    		$("div .error").remove();
    			if(elements[i].value==val && elements[i].id!=id){
    		 elements[i].selectedIndex= 0;
    	}
    }
   }
    
    function saveApplicantPostPriorityAsDraft(){
        isSaveOrSaveAsDraft='draft';
        jQuery("#postPriorityForm").submit();
    }

    function saveApplicantPostPriority(){
        isSaveOrSaveAsDraft='save';
        jQuery("#postPriorityForm").submit();
    }

</script>
<form  name="postPriorityForm" id="postPriorityForm" action="<c:url value='/applicant?operation=savePostPriority'/>" method="POST">
<div align="left"><strong><fmt:message key="post.priority.note"/></strong></div>
<c:forEach items="${selectedPostSuperCategory }" var="postSuperCategory">
<c:if test="${postSuperCategory.id eq supervisorSuperCat || postSuperCategory.id eq OfficersSuperCat}">
<%-- <c:if test="${postSuperCategory.id eq supervisorSuperCat }"> --%>
	<%-- <h3><fmt:message key="${postSuperCategory.messageKey }"/> </h3> --%>
	<c:set var="count" value="0"  scope="page"/>
		<c:forEach items="${postSuperCategory.posCategorytList }" var="availablePost">
		<c:if test="${availablePost.postList.size() > 1 && count == 0}">
			
			<h3><fmt:message key="${postSuperCategory.messageKey }"/> </h3>
			<c:set var="count" value="${count + 1}" scope="page"/> 
		</c:if>
			<c:choose>
			<c:when test="${availablePost.id eq techPostCategoryId && noOfTechPostsSelected > 1}">
				<div id="postCategory_${availablePost.id }">
					<h3><fmt:message key="${availablePost.messageKey }"/> </h3>
					<c:forEach items="${availablePost.applicantPostAssocs }" var="post" varStatus="status">
						<div class="row">
		                    <div class="col-md-5">
		                        <label for="selectBox_${post.id }">
		                            <fmt:message key="${post.post.messageKey }"/>
		                        </label> 
		                     </div>
		                     <div class="col-md-3">
		                        <select class="postPriority  form-control col-md-4" name="priority[${status.index }]" id="selectBox_${post.id }" onchange="resetDuplicatePriority(this.value,this.id,'postCategory_${availablePost.id}');" required selectedpostId="${post.id }">
									<option value="0">-- <fmt:message key="please.select"/> --</option>
		                		<c:forEach items="${availablePost.applicantPostAssocs}" varStatus="loop">
		                    		<option value="${loop.index + 1}"  ${ loop.index + 1 eq post.priority? 'selected=selected':'' }><tags:tagLocale no="${loop.index + 1}" language="${ pageContext.response.locale eq 'mr'?'hi':'en'}" country="IN"/> <fmt:message key="setPriority.preference"/></option>
		                		</c:forEach>
								</select>
							</div>
		                </div>
					</c:forEach>
				</div>
			</c:when>
			<c:when test="${availablePost.id eq nontechPostCategoryId && noOfNonTechPostsSelected > 1}">
				<div id="postCategory_${availablePost.id }">
					<h3><fmt:message key="${availablePost.messageKey }"/> </h3>
					<c:forEach items="${availablePost.applicantPostAssocs }" var="post" varStatus="status">
						<div class="row">
		                    <div class="col-md-5">
		                        <label for="selectBox_${post.id }">
		                            <fmt:message key="${post.post.messageKey }"/>
		                        </label> 
		                     </div>
		                     <div class="col-md-3">
		                        <select class="postPriority  form-control col-md-4" name="priority[${status.index }]" id="selectBox_${post.id }" onchange="resetDuplicatePriority(this.value,this.id,'postCategory_${availablePost.id}');" required selectedpostId="${post.id }">
									<option value="0">-- <fmt:message key="please.select"/> --</option>
		                		<c:forEach items="${availablePost.applicantPostAssocs}" varStatus="loop">
		                    		<option value="${loop.index + 1}"  ${ loop.index + 1 eq post.priority? 'selected=selected':'' }><tags:tagLocale no="${loop.index + 1}" language="${ pageContext.response.locale eq 'mr'?'hi':'en'}" country="IN"/> <fmt:message key="setPriority.preference"/> </option>
		                		</c:forEach>
								</select>
							</div>
		                </div>
					</c:forEach>
				</div>
			</c:when>
			<c:when test="${availablePost.id eq techPostCategoryIdForOfficer && noOfTechPostsSelectedForOfficer > 1}">
				<div id="postCategory_${availablePost.id }">
					<h3><fmt:message key="${availablePost.messageKey }"/> </h3>
					<c:forEach items="${availablePost.applicantPostAssocs }" var="post" varStatus="status">
						<div class="row">
		                    <div class="col-md-5">
		                        <label for="selectBox_${post.id }">
		                            <fmt:message key="${post.post.messageKey }"/>
		                        </label> 
		                     </div>
		                     <div class="col-md-3">
		                        <select class="postPriority  form-control col-md-4" name="priority[${status.index }]" id="selectBox_${post.id }" onchange="resetDuplicatePriority(this.value,this.id,'postCategory_${availablePost.id}');" required selectedpostId="${post.id }">
									<option value="0">-- <fmt:message key="please.select"/> --</option>
		                		<c:forEach items="${availablePost.applicantPostAssocs}" varStatus="loop">
		                    		<option value="${loop.index + 1}"  ${ loop.index + 1 eq post.priority? 'selected=selected':'' }><tags:tagLocale no="${loop.index + 1}" language="${ pageContext.response.locale eq 'mr'?'hi':'en'}" country="IN"/> <fmt:message key="setPriority.preference"/></option>
		                		</c:forEach>
								</select>
							</div>
		                </div>
					</c:forEach>
				</div>
			</c:when>
			<c:when test="${availablePost.id eq nontechPostCategoryIdIdForOfficer && noOfNonTechPostsSelectedForOfficer > 1}">
				<div id="postCategory_${availablePost.id }">
					<h3><fmt:message key="${availablePost.messageKey }"/> </h3>
					<c:forEach items="${availablePost.applicantPostAssocs }" var="post" varStatus="status">
						<div class="row">
		                    <div class="col-md-5">
		                        <label for="selectBox_${post.id }">
		                            <fmt:message key="${post.post.messageKey }"/>
		                        </label> 
		                     </div>
		                     <div class="col-md-3">
		                        <select class="postPriority  form-control col-md-4" name="priority[${status.index }]" id="selectBox_${post.id }" onchange="resetDuplicatePriority(this.value,this.id,'postCategory_${availablePost.id}');" required selectedpostId="${post.id }">
									<option value="0">-- <fmt:message key="please.select"/> --</option>
		                		<c:forEach items="${availablePost.applicantPostAssocs}" varStatus="loop">
		                    		<option value="${loop.index + 1}"  ${ loop.index + 1 eq post.priority? 'selected=selected':'' }><tags:tagLocale no="${loop.index + 1}" language="${ pageContext.response.locale eq 'mr'?'hi':'en'}" country="IN"/> <fmt:message key="setPriority.preference"/> </option>
		                		</c:forEach>
								</select>
							</div>
		                </div>
					</c:forEach>
				</div>
			</c:when>
			</c:choose>
		</c:forEach>
		</c:if>
<%-- </c:if> --%>
</c:forEach>

    <nav class="navbar btn-toolbar sw-toolbar sw-toolbar-bottom">
        <div class="btn-group navbar-btn sw-btn-group pull-right" role="group">
            <span class="processingRequest greenTxt" style="display: none" id="processingRequestSpan">
                 	<img src="<c:url value='static/app/images/smallLoader.gif'/>" class="smallLoader">
                <fmt:message key="processingrequest"/>
            </span>&nbsp;
            <c:if test="${!disableFormAfterLastDateOver}">
	            <button onclick="javascript:saveApplicantPostPriority();" class="btn btn-default sw-btn-next" type="button" id="saveBtn">
	                <fmt:message key="save" />
	            </button>
	            <button onclick="javascript:saveApplicantPostPriorityAsDraft();" class="btn btn-default sw-btn-next" type="button" id="saveAsDraftBtn">
	                <fmt:message key="saveAsDraft" />
	            </button>
	       </c:if>
            <button onclick="javascript:applyObj.gotoTab('4')" class="btn btn-default sw-btn-next skipDisabling" type="button" id="nextBtn">
                <fmt:message key="next" />
            </button>
        </div>
    </nav>

</form>