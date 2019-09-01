<%@ include file="../common/taglibs.jsp" %>

<input type="hidden" id="searchText" name="searchText" value="${userSearchDTO.searchText}"/>
<input type="hidden" id="searchType" name="searchType" value="${userSearchDTO.searchType}"/>
<input type="hidden" id="firstname" name="firstname" value="${userSearchDTO.firstname}"/>
<input type="hidden" id="lastname" name="lastname" value="${userSearchDTO.lastname}"/>
<input type="hidden" id="email" name="email" value="${userSearchDTO.email}"/>

<input type="hidden" id="size" name="size" value="${pageDetail.size}"/>
<input type="hidden" id="pageNumber" name="pageNumber" value="${pageDetail.pageNumber}"/>
<input type="hidden" id="sortOrder" name="sortOrder" value="${pageDetail.sortOrder}"/>
<input type="hidden" id="sortBy" name="sortBy" value="${pageDetail.sortBy}"/>
<input type="hidden" id="newPage" name="newPage" value="${pageDetail.newPage}"/>

<tags:pagination-header page="${ page }" searchText="${userSearchDTO.searchText}"/>

<table id="user-grid" class="table table-condensed table-hover table-bordered">
    <thead>
        <tr>
            <th onclick="javascript:userObj.sortUsers(this, 'firstname')">
                <span><fmt:message key="user.firstname"/></span><span class="pull-right"><i
                    class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'firstname' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'firstname' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
                    aria-hidden="true"></i></span></th>
            <th onclick="javascript:userObj.sortUsers(this, 'lastname')">
                <span><fmt:message key="user.lastname"/></span><span class="pull-right"><i
                    class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'lastname' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'lastname' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
                    aria-hidden="true"></i></span></th>
            <th onclick="javascript:userObj.sortUsers(this, 'email')">
                <span><fmt:message key="user.email"/></span><span class="pull-right"><i
                    class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'email' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'email' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
                    aria-hidden="true"></i></span></th>
            <th onclick="javascript:userObj.sortUsers(this, 'roleId')">
                <span><fmt:message key="user.role"/></span><span class="pull-right"><i
                    class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'roleId' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'roleId' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
                    aria-hidden="true"></i></span></th>
            <th><fmt:message key="actions"/></th>
        </tr>
    </thead>
    <tbody>
    <c:forEach var="user" items="${page.content}">
        <tr>
            <td class="col-md-2">${user.firstname}</td>
            <td class="col-md-2">${user.lastname}</td>
            <td class="col-md-4">${user.email}</td>
            <td class="col-md-2">${user.role.title}</td>
            <td class="col-md-1 ">
                <tags:hasPermission moduleName="user" operation="editUser">
                    <button type="button" class="btn btn-xs btn-default command-edit"  data-toggle="tooltip" title="Edit"
                            onclick="javascript:userObj.editUser('${user.id}');">
                        <span class="fa fa-pencil"></span>
                    </button>
                </tags:hasPermission>
                <tags:hasPermission moduleName="user" operation="deleteUser">
                    <button type="button" class="btn btn-xs btn-default command-delete" data-toggle="tooltip" title="Delete"
                            onclick="javascript:userObj.deleteUser('${user.id}');">
                        <span class="fa fa-trash"></span>
                    </button>
                </tags:hasPermission>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<tags:pagination-footer page="${ page }" callback="userObj.goToPage"/>

