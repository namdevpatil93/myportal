<%@ include file="../common/taglibs.jsp" %>


<input type="hidden" id="searchText" name="searchText" value="${notificationSearchDTO.searchText}"/>
<input type="hidden" id="searchType" name="searchType" value="${notificationSearchDTO.searchType}"/>

<input type="hidden" id="size" name="size" value="${pageDetail.size}"/>
<input type="hidden" id="pageNumber" name="pageNumber" value="${pageDetail.pageNumber}"/>
<input type="hidden" id="sortOrder" name="sortOrder" value="${pageDetail.sortOrder}"/>
<input type="hidden" id="sortBy" name="sortBy" value="${pageDetail.sortBy}"/>
<input type="hidden" id="newPage" name="newPage" value="${pageDetail.newPage}"/>
<%-- <input type="hidden" id="orignalDescription" name="orignalDescription" value="${notification.description}"/> --%>

<tags:pagination-header page="${ page }" searchText="${notificationSearchDTO.searchText}"/>

<table id="notification-grid" class="table table-condensed table-hover table-striped table-bordered">
    <thead>
    <tr>
                <th width="30%" onclick="javascript:notificationObj.sortNotifications(this, 'title')">
            <span><fmt:message key="notification.title"/></span><span class="pull-right"><i
                aria-hidden="true"
                class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'title' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'title' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
            ></i></span></th>
                <th width="60%" onclick="javascript:notificationObj.sortNotifications(this, 'description')">
            <span><fmt:message key="notification.description"/></span><span class="pull-right"><i
                aria-hidden="true"
                class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'description' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'description' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
            ></i></span></th>
			 <th width="40%"><span><fmt:message key="actions" /></span><span
				class="pull-right"><i aria-hidden="true" class="fa fa-fw"></i></span>
			</th>
               
    </tr>
    </thead>
    <tbody>
    <c:forEach var="notification" items="${page.content}">
        <tr id="notification_${ notification.id  }">
            <td class="title">

                        <c:out value="${notification.title}"/>
                    </td>
            <td class="text">
                        
                        <c:choose>
                        	<c:when test="${ fn:length(notification.description) gt 200 }">
		                        <c:out value="${fn:substring(notification.description, 0, 197)} ..."/>
                        	</c:when>
                        	<c:otherwise><c:out value="${ notification.description  }"/></c:otherwise>
                        </c:choose>
                        
                    </td>
            <td>
               <%--  <tags:hasPermission moduleName="notification" operation="editNotification">
                    <button type="button" class="btn btn-xs btn-default command-edit"
                            onclick="javascript:notificationObj.editNotification('${notification.id}');">
                        <span class="fa fa-pencil"></span>
                    </button>
                </tags:hasPermission> --%>
                <tags:hasPermission moduleName="notification" operation="deleteNotification">
                    <button type="button" class="btn btn-xs btn-default command-delete"
                            onclick="javascript:notificationObj.deleteNotification('${notification.id}');">
                        <span class="fa fa-trash"></span>
                    </button>
                </tags:hasPermission>
                
                <tags:hasPermission moduleName="notification" operation="viewNotification">
                    <button type="button" class="btn btn-xs btn-default"
                            onclick="javascript:commonObj.viewNotification('${notification.id}','${notification.description}');">
                        <span class="fa fa-eye"></span>
                    </button>
                </tags:hasPermission>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<jsp:include page="viewNotificationPopup.jsp"/>

<tags:pagination-footer page="${ page }" callback="notificationObj.goToPage"/>

