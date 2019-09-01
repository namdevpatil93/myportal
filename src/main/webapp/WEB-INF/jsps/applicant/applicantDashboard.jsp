<%@ include file="../common/taglibs.jsp"%>

<sec:authentication var="user" property="principal"/>

<script type="text/javascript">
function showPostDetailinViewMode(applicantPostAssocId,applicantId,postTitle){
	var url = '<c:url value="/applicant?operation=viewPostDetails"/>';
    jQuery.ajax({
        type: 'POST',
        url: url,
        data : { 'applicantPostAssocId' : applicantPostAssocId,'applicantId' : applicantId},
        async : false,
        success: function(data) {
            bootbox.dialog({
                message: data ,
                title: postTitle,
                buttons: {
                    success: {
                        label: "Close",
                        className: "btn-success",
                    },
                }
            });
        }
    });
}
</script>
<div class="form-group">
    <label> <fmt:message key="applicant.applicationId" /> </label> : ${ user.username }
</div>
<h4><fmt:message key="applicant.post.list.title"/></h4>
<%-- <span class="elementFloatRigth">
	<label><fmt:message key="applicant.post.list.label"/></label> : ${totalPostsApplied}
</span> --%>
<div class="row">
        <div class="col-lg-12">
            <div id="applicantListResult">
<table id="applicant-grid" class="table table-condensed table-hover">
    <thead>
        <tr>
            <%-- <th><fmt:message key="applicant.list.sNo"/></th> --%>
            <th><fmt:message key="applicant.list.post"/></th>
            <th><fmt:message key="applicant.application.date"/></th>
            <th><fmt:message key="applicant.list.admit.card"/></th>
			<th><fmt:message key="applicant.list.status"/></th>
			<th><fmt:message key="applicant.list.paymentMode"/></th>
			<th><fmt:message key="apply.payment"/></th>
			<th><fmt:message key="apply.examRespnse"/></th>
        </tr>
    </thead>
    <tbody>
    <c:forEach var="applicantPostAssoc" items="${applicantPostAssocs}" varStatus="counter">
        <tr>
            <%-- <td>${counter.count}</td> --%>
            <td>
				<a href="javascript:void(0);"  onclick="showPostDetailinViewMode('${ applicantPostAssoc.id  }','${applicantPostAssoc.applicantId}','<fmt:message key="${applicantPostAssoc.post.messageKey }"/>')"><fmt:message key="${applicantPostAssoc.post.messageKey }"/></a>
			</td>
            <td>
            	<c:choose>
            		<c:when test="${ applicantPostAssoc.status eq 2 }">
            			<tags:localDate pattern="dd/MM/yyyy" date="${applicantPostAssoc.submittedDate}" />
            		</c:when>
            		<c:otherwise>
            			N/A
            		</c:otherwise>
            	</c:choose>
            </td>
            <td>
            <c:choose>
            		<c:when test="${applicantPostAssoc.transactionStatus eq 1 && applicantPostAssoc.post.showAdmitCard eq true}">
            			<a href="javascript:void(0);" onclick="javascript:commonObj.getAdmitCardData('${applicantPostAssoc.admitCardUrl}','${applicantPostAssoc.applicationId}');" ><fmt:message key="common.view"/></a><br>
            		</c:when>
            		<c:otherwise>
            			N/A
            		</c:otherwise>
            	</c:choose>
            <!-- Applicant post assoc status -->
            </td>
            <td>
            <c:choose>
            	<c:when test="${applicantPostAssoc.status eq 0}"><fmt:message key="status.draft"/></c:when>
            	<c:when test="${applicantPostAssoc.status eq 1}"><fmt:message key="status.saved"/></c:when>
            	<c:when test="${applicantPostAssoc.status eq 3}"><fmt:message key="status.pending"/></c:when>
            	<c:otherwise><fmt:message key="status.submitted"/></c:otherwise>
            </c:choose>
            </td>
            <!-- payment mode -->
            <td>
	            <c:choose>
	            	<c:when test="${applicantPostAssoc.status eq 0 || applicantPostAssoc.status eq 1}"><fmt:message key="not.applicable"/></c:when>
	            	<c:when test="${applicantPostAssoc.status eq 2 || applicantPostAssoc.status eq 3}">
	            	<c:choose>
            			<c:when test="${applicantPostAssoc.paymentMode eq 1}"><fmt:message key="payment.online"/></c:when>
            			<c:when test="${applicantPostAssoc.paymentMode eq 2}">
            				<c:choose>
            					<c:when test="${applicantPostAssoc.txnOrderNo ne null}">
            						<a href="javascript:void(0);" onclick="javascript:commonObj.goToURL('<c:url value='/applicant?operation=viewChallan&txnOrderNo=${applicantPostAssoc.txnOrderNo}'/>')" >
            							<fmt:message key="payment.offline"/>
            						</a>
            					</c:when>
            					<c:otherwise>
            						<fmt:message key="payment.offline"/>
            					</c:otherwise>
            				</c:choose>
            			</c:when>
            		</c:choose>
	            	</c:when>
	            </c:choose>
            </td>
            <!-- payment status -->
            <td>
              		<c:choose>
              			<c:when test="${applicantPostAssoc.paymentMode eq 1}">
              				<c:choose>
              					<c:when test="${applicantPostAssoc.transactionStatus eq 0}"><fmt:message key="status.pending"/></c:when>
              					<c:when test="${applicantPostAssoc.transactionStatus eq 1}"><fmt:message key="status.success"/></c:when>
              					<c:when test="${applicantPostAssoc.transactionStatus eq 2}"><fmt:message key="status.failed"/></c:when>
              				</c:choose>
              			</c:when>
              			<c:when test="${applicantPostAssoc.paymentMode eq 2}">
              				<c:choose>
              					<c:when test="${applicantPostAssoc.transactionStatus eq 0}"><fmt:message key="status.pending"/></c:when>
              					<c:when test="${applicantPostAssoc.transactionStatus eq 1}"><fmt:message key="status.success"/></c:when>
              					<c:when test="${applicantPostAssoc.transactionStatus eq 2}"><fmt:message key="status.failed"/></c:when>
              				</c:choose>
              			</c:when>
              			<c:otherwise>
              				<fmt:message key="not.applicable"/>
              			</c:otherwise>
              		</c:choose>
            </td>
            <td>
            
             <c:choose>
              			<c:when test="${applicantPostAssoc.paymentMode eq 1}">
              				<c:choose>
              					<c:when test="${applicantPostAssoc.transactionStatus eq 0}"><fmt:message key="not.applicable"/></c:when>
              					<c:when test="${applicantPostAssoc.transactionStatus eq 2}"><fmt:message key="not.applicable"/></c:when>
              					<c:when test="${applicantPostAssoc.transactionStatus eq 1 && applicantPostAssoc.post.showUserResponse eq true}">
              					<a href="javascript:void(0);" onclick="javascript:commonObj.getDataFromExamBench('${ applicantPostAssoc.id  }','${applicantPostAssoc.postId}','en');" ><fmt:message key="common.view"/></a><br>
              					</c:when>
								<c:otherwise>
									<fmt:message key="not.applicable"/>
								</c:otherwise>
              				</c:choose>
             			</c:when>
              				<c:when test="${applicantPostAssoc.paymentMode eq 2}">
              				<c:choose>
              					<c:when test="${applicantPostAssoc.transactionStatus eq 0}"><fmt:message key="not.applicable"/></c:when>
              					<c:when test="${applicantPostAssoc.transactionStatus eq 2}"><fmt:message key="not.applicable"/></c:when>
              					<c:when test="${applicantPostAssoc.transactionStatus eq 1 && applicantPostAssoc.post.showUserResponse eq true}">
              					<a href="javascript:void(0);" onclick="javascript:commonObj.getDataFromExamBench('${ applicantPostAssoc.id  }','${applicantPostAssoc.postId}','en');" ><fmt:message key="common.view"/></a><br>
              				</c:when>
								<c:otherwise>
									<fmt:message key="not.applicable"/>
								</c:otherwise>
             			</c:choose>
            				</c:when>
              			<c:otherwise>
              				<fmt:message key="not.applicable"/>
              			</c:otherwise>
            </c:choose>
            	<%--<fmt:message key="not.applicable"/>--%>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
 </div>
</div>
<jsp:include page="../popup/admitCardPopup.jsp"/>
</div>

