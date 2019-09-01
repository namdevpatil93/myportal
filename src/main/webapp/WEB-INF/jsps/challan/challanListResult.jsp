<%@ include file="../common/taglibs.jsp" %>


<input type="hidden" id="searchText" name="searchText" value="${challanSearchDTO.searchText}"/>
<input type="hidden" id="searchType" name="searchType" value="${challanSearchDTO.searchType}"/>

<input type="hidden" id="size" name="size" value="${pageDetail.size}"/>
<input type="hidden" id="pageNumber" name="pageNumber" value="${pageDetail.pageNumber}"/>
<input type="hidden" id="sortOrder" name="sortOrder" value="${pageDetail.sortOrder}"/>
<input type="hidden" id="sortBy" name="sortBy" value="${pageDetail.sortBy}"/>
<input type="hidden" id="newPage" name="newPage" value="${pageDetail.newPage}"/>

<tags:pagination-header page="${ page }" searchText="${challanSearchDTO.searchText}"/>

<c:choose>
    <c:when test="${ page.content ne null and fn:length(page.content) gt 0 }">
		<div class="table-responsive">
			<table id="challan-grid" class="table table-condensed table-hover table-striped table-bordered">
			    <thead>
			    <tr>
			                <th onclick="javascript:challanObj.sortChallans(this, 'jrnlNo')">
			            <span><fmt:message key="challan.jrnlNo"/></span><span class="pull-right"><i
			                aria-hidden="true"
			                class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'jrnlNo' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'jrnlNo' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
			            ></i></span></th>
			
			                <th onclick="javascript:challanObj.sortChallans(this, 'feeType')">
			            <span><fmt:message key="challan.feeType"/></span><span class="pull-right"><i
			                aria-hidden="true"
			                class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'feeType' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'feeType' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
			            ></i></span></th>
			                <th onclick="javascript:challanObj.sortChallans(this, 'applicationNo')">
			            <span><th onclick="javascript:challanObj.sortChallans(this, 'validationData')">
			            <span><fmt:message key="challan.validationData"/></span><span class="pull-right"><i
			                aria-hidden="true"
			                class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'validationData' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'validationData' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
			            ></i></span></th>
			                <th onclick="javascript:challanObj.sortChallans(this, 'tranDate')">
			            <span><fmt:message key="challan.tranDate"/></span><span class="pull-right"><i
			                aria-hidden="true"
			                class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'tranDate' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'tranDate' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
			            ></i></span></th>
			                <th onclick="javascript:challanObj.sortChallans(this, 'tranBranch')">
			            <span><fmt:message key="challan.tranBranch"/></span><span class="pull-right"><i
			                aria-hidden="true"
			                class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'tranBranch' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'tranBranch' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
			            ></i></span></th>
			                <th onclick="javascript:challanObj.sortChallans(this, 'tranTime')">
			            <span><fmt:message key="challan.tranTime"/></span><span class="pull-right"><i
			                aria-hidden="true"
			                class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'tranTime' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'tranTime' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
			            ></i></span></th>
			                <th onclick="javascript:challanObj.sortChallans(this, 'accountNo')">
			            <span><fmt:message key="challan.accountNo"/></span><span class="pull-right"><i
			                aria-hidden="true"
			                class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'accountNo' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'accountNo' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
			            ></i></span></th>
			                <th onclick="javascript:challanObj.sortChallans(this, 'amount')">
			            <span><fmt:message key="challan.amount"/></span><span class="pull-right"><i
			                aria-hidden="true"
			                class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'amount' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'amount' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
			            ></i></span></th>
			                <th onclick="javascript:challanObj.sortChallans(this, 'applicantName')">
			            <span><fmt:message key="challan.applicantName"/></span><span class="pull-right"><i
			                aria-hidden="true"
			                class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'applicantName' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'applicantName' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
			            ></i></span></th>
			
			    </tr>
			    </thead>
			    <tbody>
			    <c:forEach var="challan" items="${page.content}">
			        <tr>
			            <td>
			                ${challan.jrnlNo}
			            </td>
			            <td>
			                ${challan.feeType}
			            </td>
			            <td>
			                ${challan.applicationNo}
			            </td>
			            <td>
			                ${challan.tranDate}
			            </td>
			            <td>
			                ${challan.tranBranch}
			            </td>
			            <td>
			                ${challan.tranTime}
			            </td>
			            <td>
			                ${challan.accountNo}
			            </td>
			            <td>
			                ${challan.amount}
			            </td>
			            <td>
			                ${challan.applicantName}
			            </td>
			        </tr>
			    </c:forEach>
			    </tbody>
			</table>
		</div>
		
		<tags:pagination-footer page="${ page }" callback="challanObj.goToPage"/>
	</c:when>
    <c:otherwise>
        There are no records to display
    </c:otherwise>
</c:choose>