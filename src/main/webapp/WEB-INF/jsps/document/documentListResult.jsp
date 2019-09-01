<%@ include file="../common/taglibs.jsp" %>


<input type="hidden" id="searchText" name="searchText" value="${documentSearchDTO.searchText}"/>
<input type="hidden" id="searchType" name="searchType" value="${documentSearchDTO.searchType}"/>

<input type="hidden" id="size" name="size" value="${pageDetail.size}"/>
<input type="hidden" id="pageNumber" name="pageNumber" value="${pageDetail.pageNumber}"/>
<input type="hidden" id="sortOrder" name="sortOrder" value="${pageDetail.sortOrder}"/>
<input type="hidden" id="sortBy" name="sortBy" value="${pageDetail.sortBy}"/>
<input type="hidden" id="newPage" name="newPage" value="${pageDetail.newPage}"/>

<%--<tags:pagination-header page="${ page }" searchText="${documentSearchDTO.searchText}"/>--%>

<table id="document-grid" class="table table-condensed table-hover table-striped table-bordered">
    <thead>
    <tr>
            <th onclick="javascript:documentObj.sortDocuments(this, 'title')">
            <span><fmt:message key="document.title"/></span><span class="pull-right"><i
                aria-hidden="true"
                class="fa fa-fw <c:choose> <c:when test="${pageDetail.sortBy == 'title' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when> <c:when test="${pageDetail.sortBy == 'title' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
            ></i></span>
            </th>
            <th onclick="javascript:documentObj.sortDocuments(this, 'description')">
            <span><fmt:message key="document.description"/></span><span class="pull-right"><i
                aria-hidden="true"
                class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'description' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'description' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
            ></i></span></th>
           <c:if test="${documentType!=6 }"> <th onclick="javascript:documentObj.sortDocuments(this, 'categoryType')">
            <span><fmt:message key="document.categorytitle"/></span><span class="pull-right"><i
                aria-hidden="true"
                class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'categoryType' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'categoryType' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
            ></i></span></th>
             <th onclick="javascript:documentObj.sortDocuments(this, 'subCategoryType')">
            <span><fmt:message key="document.subcategorytitle"/></span><span class="pull-right"><i
                aria-hidden="true"
                class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'subCategoryType' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'subCategoryType' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
            ></i></span></th></c:if> 
           <%--  <th onclick="javascript:documentObj.sortDocuments(this, 'createdDate')">
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
            <th onclick="javascript:documentObj.sortDocuments(this, 'lastModifiedDate')">
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
            </th> --%>
            <th>
            	<fmt:message key="actions"/>
            </th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="document" items="${page.content}">
        <tr>
            <td class="col-md-2">
                <c:out value="${document.title}"/>
            </td>
            <td class="col-md-2">
                <c:out value="${document.description}"/>
            </td>
          <c:if test="${documentType!=6 }">   
           <td class="col-md-2">
                <c:out value="${document.lableCategoryTitle}"/>
            </td>
             <td class="col-md-2">
                <c:out value="${document.lableSubCategoryTitle}"/>
            </td>
            </c:if>
         <%--    <td class="col-md-2">
                <fmt:formatDate type="date" pattern="dd/MM/yyyy" value="${document.createdDate}" />
            </td>
            <td class="col-md-2">
                <fmt:formatDate type="date" pattern="dd/MM/yyyy" value="${document.lastModifiedDate}" />
            </td> --%>
            <td class="col-md-2">
                <tags:hasPermission moduleName="documents" operation="editDocument">
                    <button type="button" class="btn btn-xs btn-default command-edit"
                            onclick="javascript:documentObj.editDocument('${document.id}');">
                        <span class="fa fa-pencil fa-2x"></span>
                    </button>
                    <button type="button" class="btn btn-xs btn-default command-edit"
                           onclick="javascript:documentsObj.deleteDocument('${document.id}', '${ document.documentType }');">
                  		<span class="fa fa-trash fa-2x"></span> 
                    </button>

                    <button type="button" class="btn btn-xs btn-default command-edit" onclick="javascript:documentObj.changeStatus('${document.id}', '${ document.active }')" >
                        <span class="fa ${document.active ? 'fa-toggle-on':'fa-toggle-off'} fa-2x" ></span>
                    </button>

                </tags:hasPermission>
<%--                 <tags:hasPermission moduleName="documents" operation="deleteDocument"> --%>
<!--                 	<button type="button" class="btn btn-xs btn-default command-edit" -->
<%--                             onclick="javascript:documentObj.deleteDocument('${document.id}', '${ document.documentType }');"> --%>
<!--                         <span class="fa fa-trash"></span> -->
<!--                     </button> -->
<%--                 </tags:hasPermission> --%>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<tags:pagination-footer page="${ page }" callback="documentObj.goToPage"/>

