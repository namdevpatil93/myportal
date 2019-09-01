<%@ include file="../common/taglibs.jsp" %>

<!-- <script>
	$('#joBiID').click(function() {
		alert("1444469436");
	});
</script> -->
<script>

$(document).ready(function(){
	
	<c:forEach var="userNotification" items="${ page.content }">
		if ( ${ userNotification.notificationRead } ) {
			$('tr#userNotification_${ userNotification.id }').addClass('activerow');
		}
	</c:forEach>
	
	$('#userNotification-grid .readNotification').click(function(){
		$(this).parents('tr').addClass('activerow');
	});
});
	
</script>

<input type="hidden" id="searchText" name="searchText" value="${userNotificationSearchDTO.searchText}"/>
<input type="hidden" id="searchType" name="searchType" value="${userNotificationSearchDTO.searchType}"/>

<input type="hidden" id="size" name="size" value="${pageDetail.size}"/>
<input type="hidden" id="pageNumber" name="pageNumber" value="${pageDetail.pageNumber}"/>
<input type="hidden" id="sortOrder" name="sortOrder" value="${pageDetail.sortOrder}"/>
<input type="hidden" id="sortBy" name="sortBy" value="${pageDetail.sortBy}"/>
<input type="hidden" id="newPage" name="newPage" value="${pageDetail.newPage}"/>

<table id="userNotification-grid"
	class="table table-condensed table-hover  table-bordered">
	<thead>
		<tr>
			<th width="30%"><span><fmt:message key="notification.title" /></span><span
				class="pull-right"><i aria-hidden="true" class="fa fa-fw"></i></span></th>
			<th width="50%"><span><fmt:message key="notification.description" /></span><span
				class="pull-right"><i aria-hidden="true" class="fa fa-fw"></i></span></th>
			<th width="15%"><span><fmt:message key="userNotification.sentOn" /></span><span
				class="pull-right"><i aria-hidden="true" class="fa fa-fw"></i></span>
			</th>
			<%-- <th><span><fmt:message key="userNotification.view" /></span><span
				class="pull-right"><i aria-hidden="true" class="fa fa-fw"></i></span>
			</th> --%>
			<th width="40%"><span><fmt:message key="actions" /></span><span
				class="pull-right"><i aria-hidden="true" class="fa fa-fw"></i></span>
			</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="userNotification" items="${page.content}">
			<tr id="userNotification_${ userNotification.id  }">
				<td class="title">
				<input type="hidden" id="markedAsRead_${ userNotification.id  }" value="${ userNotification.notificationRead }"/>
				${userNotification.notification.title}
				</td>
				<td class="text"><c:choose>
                        	<c:when test="${ fn:length(userNotification.notification.description) gt 200 }">
		                        <c:out value="${fn:substring(userNotification.notification.description, 0, 197)} ..."/>
                        	</c:when>
                        	<c:otherwise><c:out value="${ userNotification.notification.description  }"/></c:otherwise>
                        </c:choose></td>
				<td>
					<c:set var="changedDateTime" value="${fn:replace(userNotification.sentOn, 'T', ' ')}" />
					<fmt:parseDate   value="${ changedDateTime }" pattern="yyyy-MM-dd HH:mm" var="parsedDateTime" type="both" />
					<fmt:formatDate  pattern="dd/MM/yyyy HH:mm aa" value="${ parsedDateTime }" var="formattedDate"/>
					${formattedDate}
				</td>
				<td>
                <tags:hasPermission moduleName="notification" operation="userNotificationList">
                    <button type="button" class="btn btn-xs btn-default readNotification"
                            onclick="javascript:commonObj.viewUserNotification('${userNotification.id}','${userNotification.notification.description}');">
                        <span class="fa fa-eye"></span>
                    </button>
                </tags:hasPermission>
            </td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<tags:pagination-footer page="${ page }" callback="userNotificationObj.goToPage"/>


