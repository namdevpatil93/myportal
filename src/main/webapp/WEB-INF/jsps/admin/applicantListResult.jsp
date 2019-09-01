<%@ include file="../common/taglibs.jsp" %>
<%@ page pageEncoding="UTF-8"%>

<%@ page import="org.springframework.data.domain.Page"%>

<script>
function showPostDetailToAdmin(applicantPostAssocId,applicantId,postTitle){
	var url = '<c:url value="/applicant?operation=viewPostDetails"/>';
    jQuery.ajax({
        type: 'POST',
        url: url,
        data : { 'applicantPostAssocId' : applicantPostAssocId,'applicantId' : applicantId},
        async : false,
        success: function(data) {
            bootbox.dialog({
                message: data ,
                title: postTitle,
                buttons: {
                    success: {
                        label: "Close",
                        className: "btn-success",
                    },
                }
            });
        }
    });
}

function Pagination(){

    this.goToPage = function(pageNumber) {
    	$('form#applicantsListSearchForm').find('#pageNumber').val(pageNumber);
    	$('#applicantsListSearchForm').submit();
        callback(pageNumber);
    }
}

var paginationObj = new Pagination();
</script>
<input type="hidden" id="searchText" name="searchText" value="${applicantSearchDTO.searchText}"/>
<input type="hidden" id="searchType" name="searchType" value="${applicantSearchDTO.searchType}"/>
<%--
 <input type="hidden" id="firstname" name="firstname" value="${applicantSearchDTO.firstname}"/>
 <input type="hidden" id="lastname" name="lastname" value="${applicantSearchDTO.lastname}"/>
 <input type="hidden" id="email" name="email" value="${applicantSearchDTO.email}"/>
--%>

<input type="hidden" id="size" name="size" value="${pageDetail.size}"/>
<input type="hidden" id="pageNumber" name="pageNumber" value="${pageDetail.pageNumber}"/>
<input type="hidden" id="sortOrder" name="sortOrder" value="${pageDetail.sortOrder}"/>
<input type="hidden" id="sortBy" name="sortBy" value="${pageDetail.sortBy}"/>
<input type="hidden" id="newPage" name="newPage" value="${pageDetail.newPage}"/>
<fmt:message key="status.registered" var="registeredText"/>
<fmt:message key="staus.paid" var="paidText"/>
<%--<tags:pagination-header page="${ page }" searchText="${applicantSearchDTO.searchText}"/>--%>
<span class="elementFloatRigth">
 	<label><fmt:message key="application.list.label"/></label> : ${pageHasRecords} <%--${totalApplicant} --%>
</span>
<table id="applicant-grid" class="table table-condensed table-hover table-bordered">
    <thead>
        <tr>
            <th><fmt:message key="applicant.list.sNo"/></th>
            <th onclick="javascript:applicantObj.sortApplicants(this, 'applicantId')">
                <span><fmt:message key="applicant.list.applicantID"/></span><span class="pull-right"><i
                    class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'applicantId' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'applicationId' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
                    aria-hidden="true"></i></span></th>
                    <!-- uncomment the below header for sort and solve the problem of firstname -->
            <%-- <th onclick="javascript:applicantObj.sortApplicants(this, 'firstName')">
                <span><fmt:message key="applicant.list.name"/></span><span class="pull-right"><i
                    class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'firstName' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'firstName' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
                    aria-hidden="true"></i></span></th> --%>
            <th><fmt:message key="applicant.list.name"/></th>
            <!-- uncomment the below header for sort and solve the problem of email address -->
			<%-- <th onclick="javascript:applicantObj.sortApplicants(this, 'emailAddress')">
                <span><fmt:message key="applicant.list.emailId"/></span><span class="pull-right"><i
                    class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'emailAddress' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'emailAddress' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
                    aria-hidden="true"></i></span></th> --%>
            <th><fmt:message key="applicant.list.mobileNumber"/></th>
            <th><fmt:message key="applicant.list.emailId"/></th>
            <th><fmt:message key="applicant.list.post"/></th>
             <th><fmt:message key="applicant.list.division"/></th>
            <th><fmt:message key="applicant.list.caste"/></th>
            <th><fmt:message key="applicant.list.subCaste"/></th>
            
<%--
            <th onclick="javascript:applicantObj.sortApplicants(this, 'roleId')">
                <span><fmt:message key="applicant.list.viewProfile"/></span><span class="pull-right"><i
                    class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'roleId' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'roleId' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
                    aria-hidden="true"></i></span></th>
--%>
            <th><fmt:message key="applicant.list.status"/></th>
             <th><fmt:message key="applicant.list.admit.card"/></th>
             
<%--
            <th onclick="javascript:applicantObj.sortApplicants(this, 'email')">
                <span><fmt:message key="applicant.list.examStatus"/></span><span class="pull-right"><i
                    class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'email' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'email' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
                    aria-hidden="true"></i></span></th>
            <th onclick="javascript:applicantObj.sortApplicants(this, 'roleId')">
                <span><fmt:message key="applicant.list.paymentMode"/></span><span class="pull-right"><i
                    class="fa fa-fw <c:choose><c:when test="${pageDetail.sortBy == 'roleId' && pageDetail.sortOrder eq 'ASC'}">fa-sort-asc</c:when><c:when test="${pageDetail.sortBy == 'roleId' && pageDetail.sortOrder eq 'DESC'}">fa-sort-desc</c:when><c:otherwise>fa-sort text-muted</c:otherwise></c:choose>"
                    aria-hidden="true"></i></span></th>
--%>
        </tr>
    </thead>
    <tbody>
    <c:set value="${((beginPage-1) * pageDetail.size)}" var="counter"/>
    <c:forEach var="applicantPostAssoc" items="${pageData.content}">
    	<c:set value="${ counter + 1 }" var="counter"/>
        <tr>
            <td>${counter}</td>
            <td>${applicantPostAssoc[1]}</td>
            <td><c:out value="${applicantPostAssoc[2]}"/></td>
            <td>${applicantPostAssoc[3]}</td>
            <td>${applicantPostAssoc[4]}</td>
            <td><a href="javascript:void(0);"  onclick="showPostDetailToAdmin('${ applicantPostAssoc[0]  }','${applicantPostAssoc[10]}','${applicantPostAssoc[5] }')">${applicantPostAssoc[5] }</a> </td>
           <td>${applicantPostAssoc[6]}</td>
            <td>${applicantPostAssoc[7]}</td>
            <td><c:out value="${applicantPostAssoc[8] eq null || applicantPostAssoc[8] eq '' ? 'NA' : applicantPostAssoc[8]}"/></td>
<%--
            <td>Icon</td>
--%>
<%-- 			<td>${applicantPostAssoc[9] }</td> --%>
            <td>${applicantPostAssoc[9] eq 2? paidText : registeredText}</td>
             <td><c:choose> 
					 <c:when test="${applicantPostAssoc[9] eq 2 && applicantPostAssoc[12] eq 1 }">					 
					 <a href="javascript:void(0);" onclick="javascript:commonObj.goToURL('<c:url value="/admin?operation=downloadAdmitCard"/>&applicantId=${ applicantPostAssoc[10]}&postId=${applicantPostAssoc[11] }&applicationId=${ applicantPostAssoc[1] }')">Download</a>
					 </c:when>
				<c:otherwise>
					NA					   		 
				</c:otherwise>
				</c:choose> </td>            
<%--
            <td>Icon</td>
            <td>MOP</td>
--%>
        </tr>
    </c:forEach>
    </tbody>
</table>

<%-- <tags:pagination-footer page="${ page }" callback="applicantObj.goToPage"/> --%>
<c:set var="currentPageNo"  value="${beginPage}"/>
<nav>
    <div id="role-grid-footer" class="pagination-footer container-fluid">
        <div class="row">
            <div class="pull-left">
                <div class="infos">
                   <em>
                   	Showing ${ totalPages eq 0 ? 0 : currentPageNo * pageSize - ( pageSize - 1 )} to ${(currentPageNo * pageSize - ( pageSize ))+ pageData.numberOfElements} of ${pageHasRecords} entries
                   </em>
                </div>
            </div>
            <div class="pull-right">
                <ul class="pagination pagination-sm">
                    <c:choose>
                        <c:when test="${currentPageNo == 1}">
                            <li class="disabled"><a>&laquo;</a></li>
                            <li class="disabled"><a>&lt;</a></li>
                        </c:when>
                        <c:otherwise>
                            <%-- go to first page --%>
                            <li><a href="javascript:void(0);" onclick="javascript:paginationObj.goToPage('1');">&laquo;</a></li>
                            <%-- go to previous page --%>
                            <li><a href="javascript:void(0);" onclick="javascript:paginationObj.goToPage('${currentPageNo - 1}');">&lt;</a></li>
                        </c:otherwise>
                    </c:choose>
                    <c:forEach var="i" begin="${beginIndex}" end="${endIndex}">
                        <c:choose>
                            <c:when test="${i eq currentPageNo}">
                                <li class="active"><a><c:out value="${i}" /></a></li>
                            </c:when>
                            <c:otherwise>
                                <li><a href="javascript:void(0);" onclick="javascript:paginationObj.goToPage('${i}');"><c:out value="${i}" /></a></li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:choose>
                        <c:when test="${(currentPageNo eq totalPages) || totalPages eq 0 }">
                            <li class="disabled"><a>&gt;</a></li>
                            <li class="disabled"><a>&raquo;</a></li>
                        </c:when>
                        <c:otherwise>
                            <%-- go to next page --%>
                            <li><a href="javascript:void(0);" onclick="javascript:paginationObj.goToPage('${currentPageNo + 1}');">&gt;</a></li>
                            <%-- go to last page --%>
                            <li><a href="javascript:void(0);" onclick="javascript:paginationObj.goToPage('${totalPages}');">&raquo;</a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </div>
</nav>