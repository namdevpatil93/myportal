<%@ include file="../common/taglibs.jsp" %>
<%@page pageEncoding="UTF-8"%>
<script>


 function DocumentCategory() {

        var categorysObj = this;

    	
        
        this.changeCategoryStatus= function (categoryId, active) {
        	
            var categorytype = $("#categorytype").val();
            var url = "<c:url value='/documents?operation=changeCategoryStatus'/>";
            
            if(active == true || active == 'true'){
                active = false;
               
            } else {
            	
                active = true;
            }

            $.ajax({
            	
                type: "POST",
                url: url,
                data: { categoryId: categoryId, active : active },
                success: function(){
                	
                	 url = '<c:url value="/documents?operation=categoryList"/>';
                	 jQuery(".tab-content").load(url, function() {
                	 });
                	 
                },
                dataType: 'json'
            });
            
        };
        
 this.sortDocuments= function (obj, sortBy) {

     $("#sortBy").val(sortBy);

     if ($(obj).find("i").hasClass('fa-sort-asc')) {
         $("#sortOrder").val("DESC");
     } else {
         $("#sortOrder").val("ASC");
     }

     categoryObj.goToPage(1);
 };

 }
 var categorysObj = new DocumentCategory();
 </script>
<input type="hidden" id="size" name="size" value="${pageDetail.size}"/>
<input type="hidden" id="pageNumber" name="pageNumber" value="${pageDetail.pageNumber}"/>
<input type="hidden" id="sortOrder" name="sortOrder" value="${pageDetail.sortOrder}"/>
<input type="hidden" id="sortBy" name="sortBy" value="${pageDetail.sortBy}"/>
<input type="hidden" id="newPage" name="newPage" value="${pageDetail.newPage}"/>

<%--<tags:pagination-header page="${ page }" searchText="${documentSearchDTO.searchText}"/>--%>


<table id="document-grid" class="table table-condensed table-hover table-striped table-bordered">
    <thead>
    <tr>
            <th onclick="javascript:categorysObj.sortDocuments(this, 'documentType')">
            <span><fmt:message key="category.categoryType"/></span><span class="pull-right"><i
                aria-hidden="true"
                class="fa fa-fw <c:choose> <c:when test="${pageDetail.sortBy == 'documentType' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when> <c:when test="${pageDetail.sortBy == 'documentType' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
            ></i></span>
            </th>
            <th onclick="javascript:categorysObj.sortDocuments(this, 'categoryTitle')">
            <span><fmt:message key="category.categoryTitle"/></span><span class="pull-right"><i
                aria-hidden="true"
                class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'categoryTitle' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'categoryTitle' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
            ></i></span></th>
            <th onclick="javascript:categorysObj.sortDocuments(this, 'categoryTitleMarathi')">
            <span><fmt:message key="category.categoryTitleMarathi"/></span><span class="pull-right"><i
                aria-hidden="true"
                class="fa fa-fw <c:choose> <c:when test="${pageDetail.sortBy == 'categoryTitleMarathi' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when> <c:when test="${pageDetail.sortBy == 'categoryTitleMarathi' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
            ></i></span>
            </th>
            <th>
            	<fmt:message key="actions"/>
            </th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="category" items="${page.content}">
    
        <tr>
            <td class="col-md-3">
                <c:out value="${category.documentTypeLable}"/>
            </td>
            
            <td class="col-md-3">
                <c:out value="${category.categoryTitle}"/>
            </td>
             <td class="col-md-3">
                <c:out value="${category.categoryTitleMarathi}"/>
            </td>
           
            <td class="col-md-2">
                <tags:hasPermission moduleName="documents" operation="editCategory">
                    <button type="button" class="btn btn-xs btn-default command-edit"
                            onclick="javascript:categoryObj.editCategory('${category.id}');">
                        <span class="fa fa-pencil fa-2x"></span>
                    </button>
                    <button type="button" class="btn btn-xs btn-default command-edit"
                           onclick="javascript:categoryObj.deleteDocumentCategory('${category.id}', '${ category.documentType }');">
                  		<span class="fa fa-trash fa-2x"></span> 
                    </button>

                    <button type="button" class="btn btn-xs btn-default command-edit" onclick="javascript:categorysObj.changeCategoryStatus('${category.id}','${ category.active }')" >
                        <span class="fa ${category.active ? 'fa-toggle-on':'fa-toggle-off'} fa-2x" ></span>
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

<tags:pagination-footer page="${ page }" callback="categoryObj.goToPage"/>

