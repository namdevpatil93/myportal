<%@ include file="../common/taglibs.jsp" %>

<input type="hidden" id="searchText" name="searchText" value="${challanFileSearchDTO.searchText}"/>
<input type="hidden" id="searchType" name="searchType" value="${challanFileSearchDTO.searchType}"/>

<input type="hidden" id="size" name="size" value="${pageDetail.size}"/>
<input type="hidden" id="pageNumber" name="pageNumber" value="${pageDetail.pageNumber}"/>
<input type="hidden" id="sortOrder" name="sortOrder" value="${pageDetail.sortOrder}"/>
<input type="hidden" id="sortBy" name="sortBy" value="${pageDetail.sortBy}"/>
<input type="hidden" id="newPage" name="newPage" value="${pageDetail.newPage}"/>

<%--<tags:pagination-header page="${ page }" searchText="${challanFileSearchDTO.searchText}"/>--%>

<table id="challanFile-grid" class="table table-condensed table-hover table-striped table-bordered">
    <thead>
    <tr>
        <th onclick="javascript:challanFileObj.sortChallanFiles(this, 'originalFileName')">
            <span>File Name</span><span class="pull-right"><i
                aria-hidden="true"
                class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'originalFileName' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'originalFileName' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
        ></i></span></th>
        <th onclick="javascript:challanFileObj.sortChallanFiles(this, 'uploadedDate')">
            <span>Uploaded Date</span><span class="pull-right"><i
                aria-hidden="true"
                class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'uploadedDate' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'uploadedDate' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
        ></i></span></th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="challanFile" items="${page.content}">
        <tr>
            <td>
                <a href="javascript:void(0);" onclick="javascript:challanFileObj.downloadChallanFile('${challanFile.id}')">
                    ${challanFile.originalFileName}
                </a>
            </td>
            <td>
                ${challanFile.uploadedDate}
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<tags:pagination-footer page="${ page }" callback="challanFileObj.goToPage"/>

