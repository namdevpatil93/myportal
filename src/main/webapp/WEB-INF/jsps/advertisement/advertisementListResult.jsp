<%@ include file="../common/taglibs.jsp" %>

<style>
    .toggle.ios, .toggle-on.ios, .toggle-off.ios { border-radius: 20px; }
    .toggle.ios .toggle-handle { border-radius: 20px; }
</style>

<input type="hidden" id="searchText" name="searchText" value="${advertisementSearchDTO.searchText}"/>
<input type="hidden" id="searchType" name="searchType" value="${advertisementSearchDTO.searchType}"/>

<input type="hidden" id="size" name="size" value="${pageDetail.size}"/>
<input type="hidden" id="pageNumber" name="pageNumber" value="${pageDetail.pageNumber}"/>
<input type="hidden" id="sortOrder" name="sortOrder" value="${pageDetail.sortOrder}"/>
<input type="hidden" id="sortBy" name="sortBy" value="${pageDetail.sortBy}"/>
<input type="hidden" id="newPage" name="newPage" value="${pageDetail.newPage}"/>

<%-- <tags:pagination-header page="${ page }" searchText="${advertisementSearchDTO.searchText}"/> --%>

<table id="advertisement-grid" class="table table-condensed table-hover table-striped table-bordered">
    <thead>
    <tr>
                <th onclick="javascript:advertisementObj.sortAdvertisements(this, 'title')">
            <span><fmt:message key="advertisement.title"/></span><span class="pull-right"><i
                aria-hidden="true"
                class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'title' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'title' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
            ></i></span></th>
                <th onclick="javascript:advertisementObj.sortAdvertisements(this, 'description')">
            <span><fmt:message key="advertisement.description"/></span><span class="pull-right"><i
                aria-hidden="true"
                class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'description' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'description' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
            ></i></span></th>
                <th onclick="javascript:advertisementObj.sortAdvertisements(this, 'documentName')">
            <span><fmt:message key="advertisement.advertisementNo"/></span><span class="pull-right"><i
                aria-hidden="true"
                class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'advertisementNo' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'advertisementNo' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
            ></i></span></th>
                <th onclick="javascript:advertisementObj.sortAdvertisements(this, 'startDate')">
            <span><fmt:message key="advertisement.startDate"/></span><span class="pull-right"><i
                aria-hidden="true"
                class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'startDate' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'startDate' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
            ></i></span></th>
                <th onclick="javascript:advertisementObj.sortAdvertisements(this, 'closingDate')">
            <span><fmt:message key="advertisement.closingDate"/></span><span class="pull-right"><i
                aria-hidden="true"
                class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'closingDate' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'closingDate' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
            ></i></span></th>
            <th onclick="javascript:advertisementObj.sortAdvertisements(this, 'createdDate')">
            	<span>
            		<fmt:message key="createdOn"/>
            	</span>
            	<span class="pull-right">
	            	<i aria-hidden="true" class="fa fa-fw 
		            	<c:choose>
		            		<c:when test="${pageDetail.sortBy == 'createdDate' && pageDetail.sortOrder eq 'ASC'}">
		            			fa-sort-asc
		            		</c:when>
		            		<c:when test="${pageDetail.sortBy == 'createdDate' && pageDetail.sortOrder eq 'DESC'}">
		            			fa-sort-desc
		            		</c:when>
		            		<c:otherwise>
		            			fa-sort text-muted
		            		</c:otherwise>
		            	</c:choose>"
		            >
		            </i>
	            </span>
            </th>
            <th onclick="javascript:advertisementObj.sortAdvertisements(this, 'lastModifiedDate')">
            	<span>
            		<fmt:message key="updatedOn"/>
            	</span>
            	<span class="pull-right">
	            	<i aria-hidden="true" class="fa fa-fw 
		            	<c:choose>
		            		<c:when test="${pageDetail.sortBy == 'lastModifiedDate' && pageDetail.sortOrder eq 'ASC'}">
		            			fa-sort-asc
		            		</c:when>
		            		<c:when test="${pageDetail.sortBy == 'lastModifiedDate' && pageDetail.sortOrder eq 'DESC'}">
		            			fa-sort-desc
		            		</c:when>
		            		<c:otherwise>
		            			fa-sort text-muted
		            		</c:otherwise>
		            	</c:choose>"
		            >
		            </i>
	            </span>
            </th>
            <th>
            	<fmt:message key="actions"/>
            </th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="advertisement" items="${page.content}">
        <tr>
            <td class="col-md-2">

               <c:out value="${advertisement.title}"/>
            </td>
            <td class="col-md-3">

                <c:out value="${advertisement.description}"/>
            </td>
            <td class="col-md-1">

                <c:out value="${advertisement.advertisementNo}"/>
            </td>
            <td class="col-md-1">
				<fmt:parseDate value="${advertisement.startDate}" pattern="yyyy-MM-dd" var="startDate" type="date"/>
               <fmt:formatDate type="date" pattern="dd/MM/yyyy" value="${startDate}" />
            </td>
            <td class="col-md-1">
				<fmt:parseDate value="${advertisement.closingDate}" pattern="yyyy-MM-dd" var="closingDate" type="date"/>
                <fmt:formatDate type="date" pattern="dd/MM/yyyy" value="${closingDate}" />
            </td>
            <td class="col-md-1">
                <fmt:formatDate type="date" pattern="dd/MM/yyyy" value="${advertisement.createdDate}" />
            </td>
            <td class="col-md-1">
                <fmt:formatDate type="date" pattern="dd/MM/yyyy" value="${advertisement.lastModifiedDate}" />
            </td>
            <td class="col-md-2">
                <tags:hasPermission moduleName="advertisement" operation="editAdvertisement">
                    <button type="button" class="btn btn-xs btn-default command-edit"
                            onclick="javascript:advertisementObj.editAdvertisement('${advertisement.id}');">
                        <span class="fa fa-pencil fa-2x"></span>
                    </button>
                </tags:hasPermission>
                <tags:hasPermission moduleName="advertisement" operation="deleteAdvertisement">
                    <button type="button" class="btn btn-xs btn-default command-delete"
                            onclick="javascript:documentsObj.deleteAdvertisement('${advertisement.id}', '${ documentType }');">
                        <span class="fa fa-trash fa-2x"></span>
                    </button>
                    <button type="button" class="btn btn-xs btn-default command-edit" onclick="javascript:advertisementObj.changeStatus('${advertisement.id}', '${ advertisement.active }')" >
                        <span class="fa ${advertisement.active ? 'fa-toggle-on':'fa-toggle-off'} fa-2x" ></span>
                    </button>
                </tags:hasPermission>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<tags:pagination-footer page="${ page }" callback="advertisementObj.goToPage"/>


