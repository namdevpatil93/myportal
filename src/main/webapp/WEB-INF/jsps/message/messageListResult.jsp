<%@ include file="../common/taglibs.jsp" %>
<%@ page pageEncoding="UTF-8"%>

<input type="hidden" id="searchText" name="searchText" value="${messageSearchDTO.searchText}"/>
<input type="hidden" id="searchType" name="searchType" value="${messageSearchDTO.searchType}"/>

<input type="hidden" id="size" name="size" value="${pageDetail.size}"/>
<input type="hidden" id="pageNumber" name="pageNumber" value="${pageDetail.pageNumber}"/>
<input type="hidden" id="sortOrder" name="sortOrder" value="${pageDetail.sortOrder}"/>
<input type="hidden" id="sortBy" name="sortBy" value="${pageDetail.sortBy}"/>
<input type="hidden" id="newPage" name="newPage" value="${pageDetail.newPage}"/>

<table id="message-grid" class="table table-condensed table-hover table-striped table-bordered">
    <thead>
    <tr>
            <th onclick="javascript:messageObj.sortMessages(this, 'messageText')">
            <span>Title</span><span class="pull-right"><i
                aria-hidden="true"
                class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'messageText' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'messageText' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
            ></i></span>
            </th>
            <th onclick="javascript:messageObj.sortMessages(this, 'messageInMarathi')">
            <span>Title (Marathi) </span><span class="pull-right"><i
                aria-hidden="true"
                class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'messageInMarathi' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'messageInMarathi' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
            ></i></span></th>
        <th onclick="javascript:messageObj.sortMessages(this, 'active')">
            <span>Priority</span><span class="pull-right"><i
                aria-hidden="true"
                class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'active' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'active' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
        ></i></span></th>

            <th>
            	<fmt:message key="actions"/>
            </th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="message" items="${page.content}">
        <tr>
            <td class="col-md-3">
                <c:out value="${message.messageText}"/>
            </td>
            <td class="col-md-3">
                <c:out value="${message.messageInMarathi}"/>
            </td>
            <td class="col-md-3">
                <c:choose>
                    <c:when test="${ message.active eq true or message.active eq 'true' }">
                        Active
                    </c:when>
                    <c:otherwise>
                        Inactive
                    </c:otherwise>
                </c:choose>
            </td>
            <td class="col-md-2">
                <tags:hasPermission moduleName="messages" operation="editMessage">
                    <button type="button" class="btn btn-xs btn-default command-edit"
                            onclick="javascript:messageObj.editMessage('${message.id}');">
                        <span class="fa fa-pencil fa-2x"></span>
                    </button>
                    <button type="button" class="btn btn-xs btn-default command-edit"
                           onclick="javascript:messageObj.deleteMessage('${message.id}');">
                  		<span class="fa fa-trash fa-2x"></span> 
                    </button>
                </tags:hasPermission>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<tags:pagination-footer page="${ page }" callback="messageObj.goToPage"/>

