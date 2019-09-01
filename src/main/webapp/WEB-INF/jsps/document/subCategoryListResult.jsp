<%@ include file="../common/taglibs.jsp" %>
<%@page pageEncoding="UTF-8"%>


<input type="hidden" id="size" name="size" value="${pageDetail.size}"/>
<input type="hidden" id="pageNumber" name="pageNumber" value="${pageDetail.pageNumber}"/>
<input type="hidden" id="sortOrder" name="sortOrder" value="${pageDetail.sortOrder}"/>
<input type="hidden" id="sortBy" name="sortBy" value="${pageDetail.sortBy}"/>
<input type="hidden" id="newPage" name="newPage" value="${pageDetail.newPage}"/>

<%--<tags:pagination-header page="${ page }" searchText="${documentSearchDTO.searchText}"/>--%>

<table id="document-grid" class="table table-condensed table-hover table-striped table-bordered" >
    <thead>
    <tr>
    		 <th style="width: 140px" onclick="javascript:subCategoryObj.sortDocuments(this, 'documentType')" >
            <span><fmt:message key="category.subcategoryDocumentType"/></span><span class="pull-right"><i
                aria-hidden="true"
                class="fa fa-fw <c:choose> <c:when test="${pageDetail.sortBy == 'documentType' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when> <c:when test="${pageDetail.sortBy == 'documentType' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
            ></i></span>
            </th>
    		 <th style="width: 140px" onclick="javascript:subCategoryObj.sortDocuments(this, 'categoryType')"  >
            <span><fmt:message key="category.subcategoryType"/></span><span class="pull-right"><i
                aria-hidden="true"
                class="fa fa-fw <c:choose> <c:when test="${pageDetail.sortBy == 'categoryType' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when> <c:when test="${pageDetail.sortBy == 'categoryType' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
            ></i></span>
            </th>
            <th style="width: 140px" onclick="javascript:subCategoryObj.sortDocuments(this, 'subCategoryTitle')" >
            <span><fmt:message key="category.subcategoryTitle"/></span><span class="pull-right"><i
                aria-hidden="true"
                class="fa fa-fw <c:choose> <c:when test="${pageDetail.sortBy == 'subCategoryTitle' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when> <c:when test="${pageDetail.sortBy == 'subCategoryTitle' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
            ></i></span>
            </th>
           <th  style="width: 140px" onclick="javascript:subCategoryObj.sortDocuments(this, 'subCategoryTitleMarathi')" >
            <span><fmt:message key="category.subcategoryTitleMarathi"/></span><span class="pull-right"><i
                aria-hidden="true"
                class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'subCategoryTitleMarathi' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'subCategoryTitleMarathi' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
            ></i></span></th>
           
            <th style="width: 130px"  > 
        <fmt:message key="actions" />                 
            </th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="subCategory" items="${page.content}">
        <tr>
            <td  style="width: 140px"  class="col-md-3">
                <c:out value="${subCategory.documentTypeLable}"/>
            </td>
            <td style="width: 140px" class="col-md-3">
                <c:out value="${subCategory.categoryTypeLable}"/>
            </td>
            <td style="width: 140px" class="col-md-3">
                <c:out value="${subCategory.subCategoryTitle}"/>
            </td>
           <td style="width: 140px" class="col-md-3">
                <c:out value="${subCategory.subCategoryTitleMarathi}"/>
            </td> 
           
            <td  style="width: 120px" class="col-md-2">
                <tags:hasPermission moduleName="documents" operation="editSubCategory">
                    <button type="button" class="btn btn-xs btn-default command-edit"
                            onclick="javascript:subCategoryObj.editDocument('${subCategory.id}');">
                        <span class="fa fa-pencil fa-2x"></span>
                    </button>
                    <button type="button" class="btn btn-xs btn-default command-edit"
                           onclick="javascript:subCategoryObj.deletesubCategory('${subCategory.id}');">
                  		<span class="fa fa-trash fa-2x"></span> 
                    </button>

                    <button type="button" class="btn btn-xs btn-default command-edit" onclick="javascript:subCategoryObj.changeStatus('${subCategory.id}', '${ subCategory.active }')" >
                        <span class="fa ${subCategory.active ? 'fa-toggle-on':'fa-toggle-off'} fa-2x" ></span>
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

<tags:pagination-footer page="${ page }" callback="subCategoryObj.goToPage"/>

