<%@ include file="../../common/taglibs.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1" %>

<script type="text/javascript" src="<c:url value='/static/app/js/postSelection.js'/>"></script>

<script>
    var postSelectionObj = new PostSelection();

    function handlePostSelectionClick(postId){
        if(postId == '21'){
            showOrHideDriverCumConductorForm();
        }
    }

    function deletePost(postId) {

        commonObj.showConfirmation('<fmt:message key="confirmDeletePost"/>', function (result) {
            if (result) {
                var url = applyObj.appBasePath + 'applicant?operation=deleteApplicantPost';
                $.post(url, {postId: postId}, function (result) {
                    var success = result.success;
                    if (success) {
                        var noOfPosts = $('.postLi').length;
                        if (noOfPosts != null && noOfPosts != 'undefined' && noOfPosts > 1) {
                            applyObj.showSelectedPosts();
                        } else {
                            applyObj.showPostSelection();
                        }
                    } else {
                        commonObj.showAlert("There was some error while trying to delete the Applicant's Post.");
                    }
                });
            }
        } , '<fmt:message key="yes"/>', '<fmt:message key="no"/>','<fmt:message key="confirmationMessage.title"/>');
    }

    jQuery(document).ready(function() {

    	// Payment transaction success post are all disabled 
        var disablePosts = ${paymentTransactionSuccessPostsId};
        if(disablePosts != null)
        {    
	        for(var i=0;i<disablePosts.length;i++){

	        	//jQuery('#tab_post_'+disablePosts[i]).find('input').attr('readonly', true);
	        	//jQuery('#tab_post_'+disablePosts[i]).find('select').attr('readonly', true);
	        	//jQuery('#tab_post_'+disablePosts[i]).find('datetime').attr('readonly', true);

	        	$('#tab_post_' + disablePosts[i]).find('input, textarea, button, select').not("#cancelBtn").attr('disabled', 'disabled');
	        	//$('#tab_post_' + disablePosts[i]).find('input, textarea, select').attr('disabled', 'disabled');

	        	jQuery('#tab_post_' + disablePosts[i]).find('#saveAsDraftBtn').hide();
                jQuery('#tab_post_' + disablePosts[i]).find('#saveBtn').hide();	
                jQuery('#tab_post_' + disablePosts[i]).find('#delBtn').hide();
                jQuery('#tab_post_' + disablePosts[i]).find('#cancelBtn').hide();
             
	        }
	        
        }  
        

        var disablePostAfterLastDate = ${postApplyLastDatePostIdList};
        
        if(disablePostAfterLastDate != null){
        	
        	for(var i=0;i<disablePostAfterLastDate.length;i++){

	        	//jQuery('#tab_post_'+disablePosts[i]).find('input').attr('readonly', true);
	        	//jQuery('#tab_post_'+disablePosts[i]).find('select').attr('readonly', true);
	        	//jQuery('#tab_post_'+disablePosts[i]).find('datetime').attr('readonly', true);

	        	$('#tab_post_' + disablePostAfterLastDate[i]).find('input, textarea, button, select').not("#cancelBtn").attr('disabled', 'disabled');
	        	//$('#tab_post_' + disablePosts[i]).find('input, textarea, select').attr('disabled', 'disabled');

	        	jQuery('#tab_post_' + disablePostAfterLastDate[i]).find('#saveAsDraftBtn').hide();
                jQuery('#tab_post_' + disablePostAfterLastDate[i]).find('#saveBtn').hide();	
                jQuery('#tab_post_' + disablePostAfterLastDate[i]).find('#delBtn').hide();
                jQuery('#tab_post_' + disablePostAfterLastDate[i]).find('#cancelBtn').hide();
             
	        }
        	
        }
        
    });

    function showEligibilityCriteriaPDF(postId) {
        var url = "";
        switch(postId){
        case 1:
        	url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/viewPdf.pdf'/>";
        	window.open(url,'_blank');
        	break;
        case 2:
        	url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/viewPdf.pdf'/>";
        	window.open(url,'_blank');
        	break;
        case 3:
        	url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/ClerkTypiest.pdf'/>";
        	window.open(url,'_blank');
        	break;
        case 4:
        	url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/Assistant.pdf'/>";
        	window.open(url,'_blank');
        	break;
        case 5:
        	url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/AssistantTrafficSuperintendent(Junior).pdf'/>";
        	window.open(url,'_blank');
        	break;
        case 6:
        	url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/TraficInspector(Jr.).pdf'/>";
        	window.open(url,'_blank');
        	break;
        case 7:
        	url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/AccountntStockverifier(Jr.).pdf'/>";
        	window.open(url,'_blank');
        	break;
        case 8:
        	url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/StoreSupervisorStockVerifier(Jr.).pdf'/>";
        	window.open(url,'_blank');
        	break;
        case 9:
        	url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/StoreKeeper(Jr.).pdf'/>";
        	window.open(url,'_blank');
        	break;
        case 10:
        	url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/SecurityInspector(Jr.).pdf'/>";
        	window.open(url,'_blank');
        	break;
        case 11:
        	url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/Asst.Securityinspector(Jr.).pdf'/>";
        	window.open(url,'_blank');
        	break;
        case 12:
        	url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/Firewarden(Jr.).pdf'/>";
        	window.open(url,'_blank');
        	break;
        case 13:
        	url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/JuniorEngineer(Civil).pdf'/>";
        	window.open(url,'_blank');
        	break;
        case 14:
        	url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/Jr.Engineer(Electrical).pdf'/>";
        	window.open(url,'_blank');
        	break;
        case 15:
        	url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/Asst.workshopsuperintendent.pdf'/>";
        	window.open(url,'_blank');
        	break;
        case 16:
        	url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/Chargeman(Jr.).pdf'/>";
        	window.open(url,'_blank');
        	break;
        case 17:
        	url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/viewPdf.pdf'/>";
        	window.open(url,'_blank');
        	break;
        case 18:
        	url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/Sr.ComputerOperator(Jr.).pdf'/>";
        	window.open(url,'_blank');
        	break;
        case 19:
        	url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/viewPdf.pdf'/>";
        	window.open(url,'_blank');
        	break;
        case 20:
        	url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/viewPdf.pdf'/>";
        	window.open(url,'_blank');
        	break;
        case 21:
        	url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/DriverCumConductor.pdf'/>";
        	window.open(url,'_blank');
        	break;
        case 22:
            url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/DivisionController.pdf'/>";
            window.open(url,'_blank');
            break;
        case 23:
            url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/machineEngineer.pdf'/>";
            window.open(url,'_blank');
            break;
        case 24:
            url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/departmentalTransportOfficer.pdf'/>";
            window.open(url,'_blank');
            break;
        case 25:
            url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/deputyEquipmentEngineer.pdf'/>";
            window.open(url,'_blank');
            break;
        case 26:
            url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/accountingOfficer.pdf'/>";
            window.open(url,'_blank');
            break;
        case 27:
            url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/storeOfficer.pdf'/>";
            window.open(url,'_blank');
            break;
        case 28:
            url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/divisionalTransportSuperintendent.pdf'/>";
            window.open(url,'_blank');
            break;
        case 29:
            url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/assistantEquipmentEngineer.pdf'/>";
            window.open(url,'_blank');
            break;
        case 30:
            url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/departmentalAccountsOfficer.pdf'/>";
            window.open(url,'_blank');
            break;
        case 31:
            url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/postEligibilityCriteria/departmentalStatisticsOfficer.pdf'/>";
            window.open(url,'_blank');
            break;
        }
    }

</script>

<input type="hidden" id="notEligibleForPost" value="<fmt:message key="notEligibleForPost"/>"/>

<ul class="postSelectionUL  nav nav-pills nav-stacked">
    <li class="${ isPostSelectionPage ?  'active':'' }"><a href="#tab_a" data-toggle="pill"><fmt:message key="select.post"/></a></li>
    <c:forEach items="${ selectedPosts }" var="selectedPost" varStatus="loop">
        <c:choose>
            <c:when test="${ selectedPost.status eq 0  }">
                <c:set var="statusClass" value="redPostBG " />
            </c:when>
            <c:when test="${ selectedPost.status eq 1 }">
                <c:set var="statusClass" value="greenPostBG" />
            </c:when>
            <c:otherwise>
                <c:set var="statusClass" value="grayPostBG" />
            </c:otherwise>
        </c:choose>
        <c:set var="postNumber" value="${ loop.index + 1}"/>
        <li onclick="javascript:handlePostSelectionClick('${ selectedPost.post.postId }');" id="post_${ selectedPost.post.postId }" class="${ statusClass } postLi ${ (!isPostSelectionPage and postNumber eq 1 ) ? 'active' : ''}"><a class="postLink" href="#tab_post_${ selectedPost.post.postId }" data-toggle="pill"><fmt:message key="${ selectedPost.post.messageKey }"/></a></li>
    </c:forEach>
    <%-- <c:forEach items="${selectedPostSuperCategory }" var="postSuperCategory"> --%>
    <c:if test="${selectedPostSuperCategory != null }">
    <%-- <c:if test="${postSuperCategory.id eq supervisorSuperCat || postSuperCategory.id eq OfficersSuperCat}"> --%>
    	<c:if test="${noOfTechPostsSelected > 1 || noOfNonTechPostsSelected > 1 || noOfTechPostsSelectedForOfficer >1 ||noOfNonTechPostsSelectedForOfficer >1 }">
        	<li class="priorityLi" id="priorityLiId"><a class="priorityLink" href="#tab_priority" data-toggle="pill"><fmt:message key="priority"/> </a></li>
       <%--  </c:if> --%>
    </c:if>
    </c:if>
    <%-- </c:forEach> --%>
</ul>

<div class="tab-content">
    <div class="tab-pane ${ isPostSelectionPage ?  'active':'' }" id="tab_a">
        <jsp:include page="selectPosts.jsp" />
    </div>
    <c:forEach items="${ selectedPosts }" var="selectedPost" varStatus="loop">
    	<input type="hidden" name="nam${selectedPost.post.postId}" value="${selectedPost.post.postId}">
        <c:set var="postNumber" value="${ loop.index + 1}"/>
        
        <div class="tab-pane ${ (!isPostSelectionPage and postNumber eq 1 ) ? 'active' : ''}" id="tab_post_${ selectedPost.post.postId }">
            <c:set var="post" value="${ selectedPost.post }" scope="request" />
            <c:set var="applicantPostAssoc" value="${ selectedPost }" scope="request" />
			<c:choose>
				<c:when test="${ !personalOrOtherInfoStatus}" >
					<div class="alert alert-danger" role="alert">
						<fmt:message key="personal.otherinformation.incomplete.msg"/>
	       			</div>
	     		</c:when>
            	<c:when test="${ !selectedPost.ageValid }">
                    <div class="alert alert-danger" role="alert"><fmt:message key="ageValidationError" /></div>
                    <nav class="navbar btn-toolbar sw-toolbar sw-toolbar-bottom">
                        <div class="btn-group navbar-btn sw-btn-group pull-right" role="group">
                            <button onclick="javascript:postSelectionObj.showPostSelection();" class="btn btn-default sw-btn-next" type="button" id="cancelBtn">
                                <fmt:message key="cancel" />
                            </button>
                            <button onclick="javascript:deletePost('${ selectedPost.post.postId }');" class="btn btn-danger sw-btn-next" type="button" id="delBtn">
                                <fmt:message key="delete" />
                            </button>
                        </div>
                    </nav>

                </c:when>
                <c:otherwise>
                    <c:choose>
                        <c:when test="${ selectedPost.post.postId  eq 1 }">
                            <jsp:include page="../posts/driverJunior.jsp" />
                        </c:when>
                        <c:when test="${ selectedPost.post.postId  eq 2 }">
                            <jsp:include page="../posts/conductorJunior.jsp" />
                        </c:when>
                        <c:when test="${ selectedPost.post.postId  eq 3 }">
                            <jsp:include page="../posts/clerkTypistJunior.jsp" />
                        </c:when>
                        <c:when test="${ selectedPost.post.postId  eq 4 }">
                            <jsp:include page="../posts/assistantJunior.jsp" />
                        </c:when>
                        <c:when test="${ selectedPost.post.postId  eq 5 }">
                            <jsp:include page="../posts/assistantTrafficSuperintendentJunior.jsp" />
                        </c:when>
                        <c:when test="${ selectedPost.post.postId  eq 6 }">
                            <jsp:include page="../posts/trafficInspectorJunior.jsp" />
                        </c:when>
                        <c:when test="${ selectedPost.post.postId  eq 7 }">
                            <jsp:include page="../posts/accountantJunior.jsp" />
                        </c:when>
                        <c:when test="${ selectedPost.post.postId  eq 8 }">
                            <jsp:include page="../posts/storeSuperviserJunior.jsp" />
                        </c:when>
                        <c:when test="${ selectedPost.post.postId  eq 9 }">
                            <jsp:include page="../posts/storeKeeperJunior.jsp" />
                        </c:when>
                        <c:when test="${ selectedPost.post.postId  eq 10 }">
                            <jsp:include page="../posts/securityInspectorJunior.jsp" />
                        </c:when>
                        <c:when test="${ selectedPost.post.postId  eq 11 }">
                            <jsp:include page="../posts/asstSecurityInspectorJunior.jsp" />
                        </c:when>
                        <c:when test="${ selectedPost.post.postId  eq 12 }">
                            <jsp:include page="../posts/fireWardenJunior.jsp" />
                        </c:when>
                        <c:when test="${ selectedPost.post.postId  eq 13 }">
                            <jsp:include page="../posts/juniorEngineerCivil.jsp" />
                        </c:when>
                        <c:when test="${ selectedPost.post.postId  eq 14 }">
                            <jsp:include page="../posts/juniorEngineerElectrical.jsp" />
                        </c:when>
                        <c:when test="${ selectedPost.post.postId eq 15 }">
                            <jsp:include page="../posts/asstWorkSuperintendentJunior.jsp"/>
                        </c:when>
                        <c:when test="${ selectedPost.post.postId  eq 16 }">
                            <jsp:include page="../posts/chargeManJunior.jsp" />
                        </c:when>
                        <c:when test="${ selectedPost.post.postId  eq 17 }">
                            <jsp:include page="../posts/draftsmanMechanicsJunior.jsp" />
                        </c:when>
                        <c:when test="${ selectedPost.post.postId  eq 18 }">
                            <jsp:include page="../posts/seniorComputerOperatorJunior.jsp" />
                        </c:when>
                        <c:when test="${ selectedPost.post.postId  eq 19 }">
                            <jsp:include page="../posts/generalManagerProject.jsp" />
                        </c:when>
                        <c:when test="${ selectedPost.post.postId  eq 20 }">
                            <jsp:include page="../posts/generalManagerInformationTechnology.jsp" />
                        </c:when>
                          <c:when test="${ selectedPost.post.postId  eq 21 }">
                            <jsp:include page="../posts/driverCumConductor.jsp" />
                        </c:when>
                        <c:when test="${ selectedPost.post.postId  eq 22 }">
                            <jsp:include page="../posts/divisionController.jsp" />
                        </c:when>
                        <c:when test="${ selectedPost.post.postId  eq 23 }">
                            <jsp:include page="../posts/2019/machineEngineer.jsp" />
                        </c:when>
                        <c:when test="${ selectedPost.post.postId  eq 24 }">
                            <jsp:include page="../posts/2019/departmentalTransportOfficer.jsp" />
                        </c:when>
                        <c:when test="${ selectedPost.post.postId  eq 25 }">
                            <jsp:include page="../posts/2019/deputyEquipmentEngineer.jsp" />
                        </c:when>
                        <c:when test="${ selectedPost.post.postId  eq 26 }">
                            <jsp:include page="../posts/2019/accountingOfficer.jsp" />
                        </c:when>
                        <c:when test="${ selectedPost.post.postId  eq 27 }">
                            <jsp:include page="../posts/2019/storeOfficer.jsp" />
                        </c:when>
                        <c:when test="${ selectedPost.post.postId  eq 28 }">
                            <jsp:include page="../posts/2019/divisionalTransportSuperintendent.jsp" />
                        </c:when>
                        <c:when test="${ selectedPost.post.postId  eq 29 }">
                            <jsp:include page="../posts/2019/assistantEquipmentEngineer.jsp" />
                        </c:when>
                        <c:when test="${ selectedPost.post.postId  eq 30 }">
                            <jsp:include page="../posts/2019/departmentalAccountsOfficer.jsp" />
                        </c:when>
                        <c:when test="${ selectedPost.post.postId  eq 31 }">
                            <jsp:include page="../posts/2019/departmentalStatisticsOfficer.jsp" />
                        </c:when>
                    </c:choose>
                </c:otherwise>
            </c:choose>
        </div>
    </c:forEach>
    <c:if test="${ fn:length(selectedPosts) > 0 }">
        <div class="tab-pane" id="tab_priority">
            <jsp:include page="postPriorities.jsp" />
        </div>
    </c:if>
</div>

<br>
<br>
<br>
