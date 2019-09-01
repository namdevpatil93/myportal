<%@ include file="../common/taglibs.jsp" %>
<%@page pageEncoding="UTF-8"%>

<input type="hidden" id="searchText" name="searchText" value="${applicantQuerySearchDTO.searchText}"/>
<input type="hidden" id="searchType" name="searchType" value="${applicantQuerySearchDTO.searchType}"/>

<input type="hidden" id="size" name="size" value="${pageDetail.size}"/>
<input type="hidden" id="pageNumber" name="pageNumber" value="${pageDetail.pageNumber}"/>
<input type="hidden" id="sortOrder" name="sortOrder" value="${pageDetail.sortOrder}"/>
<input type="hidden" id="sortBy" name="sortBy" value="${pageDetail.sortBy}"/>
<input type="hidden" id="newPage" name="newPage" value="${pageDetail.newPage}"/>

<%-- <tags:pagination-header page="${ page }" searchText="${applicantQuerySearchDTO.searchText}"/> --%>

<table id="applicantQuery-grid" class="table table-condensed table-hover table-striped table-bordered">
    <thead>
    <tr>
         <th onclick="javascript:applicantQueryObj.sortApplicantQueries(this, 'type')">
           <span><fmt:message key="applicantQuery.type"/></span><span class="pull-right"><i aria-hidden="true" class="fa fa-fw 
           	<c:choose>
           		<c:when test="${pageDetail.sortBy == 'type' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when>
           		<c:when test="${pageDetail.sortBy == 'type' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when>
           		<c:otherwise>fa-sort text-muted</c:otherwise>
           	</c:choose>"></i></span>
         </th>
         <th onclick="javascript:applicantQueryObj.sortApplicantQueries(this, 'title')">
            <span><fmt:message key="applicantQuery.title"/></span><span class="pull-right"><i
                aria-hidden="true"
                class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'title' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'title' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
            ></i></span>
		 </th>
         <th onclick="javascript:applicantQueryObj.sortApplicantQueries(this, 'description')">
            <span><fmt:message key="applicantQuery.description"/></span><span class="pull-right"><i
                aria-hidden="true"
                class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'description' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'description' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
            ></i></span>
		 </th>
         <c:if test="${ userRole eq 1}">
	         <th onclick="javascript:applicantQueryObj.sortApplicantQueries(this, 'applicantId')">
	            <span><fmt:message key="applicantQuery.applicantId"/></span><span class="pull-right"><i
	                aria-hidden="true"
	                class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'applicantId' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'applicantId' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
	            ></i></span>
	         </th>
	         <th><fmt:message key="applicant.list.name"/></th>
         </c:if>
         <th><fmt:message key="actions"/></th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="applicantQuery" items="${page.content}">
        <tr>
        	<td>
				<c:forEach items="${queryTypes}" var="queryType">
			           <c:if test="${queryType.value eq applicantQuery.type}">
			           	${queryType.queryType}
			           </c:if>
			       </c:forEach>
            </td>
            <td>
            <c:out value="${applicantQuery.title}"/>
            </td>
            <td>
            <c:out value="${applicantQuery.description}"/>
            </td>
            <c:if test="${ userRole eq 1}">
            	<td>
                ${applicantQuery.applicant.applicationId}
            	</td>
            </c:if>
            <c:if test="${ userRole eq 1}">
	            <td>
	                <c:out value="${applicantQuery.applicant.firstName}"/> <c:out value="${applicantQuery.applicant.lastName}"/>
	            </td>
            </c:if>
            <td>
                <tags:hasPermission moduleName="applicantQuery" operation="editApplicantQuery">
                    <button type="button" class="btn btn-xs btn-default command-edit"
                            onclick="javascript:applicantQueryObj.editApplicantQuery('${applicantQuery.id}');">
                        <span class="fa fa-pencil"></span>
                    </button>
                </tags:hasPermission>
                <tags:hasPermission moduleName="applicantQuery" operation="deleteApplicantQuery">
                    <button type="button" class="btn btn-xs btn-default command-delete"
                            onclick="javascript:applicantQueryObj.deleteApplicantQuery('${applicantQuery.id}');">
                        <span class="fa fa-trash"></span>
                    </button>
                </tags:hasPermission>
                
                <tags:hasPermission moduleName="applicantQuery" operation="replyApplicantQuery">
                 	<button type="button" class="btn btn-xs btn-default command-edit1"
                            onclick="javascript:applicantQueryObj.replyApplicantQuery('${applicantQuery.id}');">
                        <span class="fa fa-commenting" ></span>
                    </button>
                </tags:hasPermission>
                
                <tags:hasPermission moduleName="applicantQuery" operation="adminReplyApplicantQuery">
                 	<button type="button" class="btn btn-xs btn-default command-edit"
                            onclick="javascript:applicantQueryObj.replyApplicantQuery('${applicantQuery.id}');">
                        <span class="fa fa-commenting" aria-hidden="true"></span>
                    </button>
                </tags:hasPermission>
                
                
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<tags:pagination-footer page="${ page }" callback="applicantQueryObj.goToPage"/>

