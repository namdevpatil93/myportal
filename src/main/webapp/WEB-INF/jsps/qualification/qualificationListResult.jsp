<%@ include file="../common/taglibs.jsp" %>
<%@ page pageEncoding="UTF-8"%>

<input type="hidden" id="searchText" name="searchText" value="${qualificationSearchDTO.searchText}"/>
<input type="hidden" id="searchType" name="searchType" value="${qualificationSearchDTO.searchType}"/>

<input type="hidden" id="size" name="size" value="${pageDetail.size}"/>
<input type="hidden" id="pageNumber" name="pageNumber" value="${pageDetail.pageNumber}"/>
<input type="hidden" id="sortOrder" name="sortOrder" value="${pageDetail.sortOrder}"/>
<input type="hidden" id="sortBy" name="sortBy" value="${pageDetail.sortBy}"/>
<input type="hidden" id="newPage" name="newPage" value="${pageDetail.newPage}"/>

<table id="qualification-grid" class="table table-condensed table-hover table-striped table-bordered">
    <thead>
    <tr>
            <th onclick="javascript:qualificationObj.sortQualifications(this, 'title')">
            <span>Title</span><span class="pull-right"><i
                aria-hidden="true"
                class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'title' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'title' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
            ></i></span>
            </th>
            <th onclick="javascript:qualificationObj.sortQualifications(this, 'titleInMarathi')">
            <span>Title (Marathi) </span><span class="pull-right"><i
                aria-hidden="true"
                class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'titleInMarathi' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'titleInMarathi' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
            ></i></span></th>
        <th onclick="javascript:qualificationObj.sortQualifications(this, 'priority')">
            <span>Priority</span><span class="pull-right"><i
                aria-hidden="true"
                class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'priority' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'priority' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
        ></i></span></th>
        
         <th onclick="javascript:qualificationObj.sortQualifications(this, 'priority')">
            <span>Status</span><span class="pull-right"><i
                aria-hidden="true"
                class="fa fa-fw "></i></span></th>

            <th>
            	<fmt:message key="actions"/>
            </th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="qualification" items="${page.content}">
        <tr>
            <td class="col-md-2">
                <c:out value="${qualification.title}"/>
            </td>
            <td class="col-md-2">
                <c:out value="${qualification.titleInMarathi}"/>
            </td>
            <td class="col-md-2">
                <c:out value="${qualification.priority}"/>
            </td>
             <td class="col-md-3">
             <c:if test="${qualification.active==true}">Active</c:if>
               <c:if test="${qualification.active==false}">In-Active</c:if>  
            </td>
            <td class="col-md-2">
                <tags:hasPermission moduleName="qualifications" operation="editQualification">
                    <button type="button" class="btn btn-xs btn-default command-edit"
                            onclick="javascript:qualificationObj.editQualification('${qualification.id}');">
                        <span class="fa fa-pencil fa-2x"></span>
                    </button>
                    <button type="button" class="btn btn-xs btn-default command-edit"
                           onclick="javascript:qualificationObj.deleteQualification('${qualification.id}');">
                  		<span class="fa fa-trash fa-2x"></span> 
                    </button>
                </tags:hasPermission>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<tags:pagination-footer page="${ page }" callback="qualificationObj.goToPage"/>

