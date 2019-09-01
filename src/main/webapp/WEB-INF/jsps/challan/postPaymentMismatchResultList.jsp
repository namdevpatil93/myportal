<%@ include file="../common/taglibs.jsp" %>
<%@ page pageEncoding="UTF-8"%>

<%@ page import="org.springframework.data.domain.Page"%>

<input type="hidden" id="size" name="size" value="${pageDetail.size}"/>
<input type="hidden" id="pageNumber" name="pageNumber" value="${pageDetail.pageNumber}"/>
<input type="hidden" id="sortOrder" name="sortOrder" value="${pageDetail.sortOrder}"/>
<input type="hidden" id="sortBy" name="sortBy" value="${pageDetail.sortBy}"/>
<input type="hidden" id="newPage" name="newPage" value="${pageDetail.newPage}"/>
<input type="hidden" id="sDate" value="${startDate}"/>
<input type="hidden" id="tDate" name="newPage" value="${toDate}"/>
<span class="elementFloatRigth">
 	<label>Unmatched Transactions</label> : ${pageHasRecords}
</span>
<table id="postPaymentMismatch-grid" class="table table-condensed table-hover table-bordered">
	<thead>
		<tr>
			<th><fmt:message key="postPaymentMismatch.list.sNo"/></th>
			<th><fmt:message key="postPaymentMismatch.list.applicantId"/></th>
			<th><fmt:message key="postPaymentMismatch.list.caste"/></th>
			<th><fmt:message key="postPaymentMismatch.list.nonCreamy"/></th>
			<th><fmt:message key="postPaymentMismatch.list.gender"/></th>
			<th><fmt:message key="postPaymentMismatch.list.amountReceived"/></th>
			<th><fmt:message key="postPaymentMismatch.list.paymentSuccessfulFor"/></th>
			<th><fmt:message key="postPaymentMismatch.list.transactionDate"/></th>
			<th><fmt:message key="postPaymentMismatch.list.action"/></th>
		</tr>
	</thead>
	<tbody>
		<c:set value="${((beginPage-1) * pageDetail.size)}" var="counter"/>
		<c:forEach var="paymentMismatch" items="${pageData.content}">
			<c:set value="${ counter + 1 }" var="counter"/>
			<tr>
				<td>${counter}</td>
				<td>${paymentMismatch[1]}</td>
				<td>${paymentMismatch[4]}</td>
				<td>
					<c:if test="${paymentMismatch[2] ne null}">
						<c:choose>
							<c:when test="${paymentMismatch[2] eq true}">
								<fmt:message key="yes"/>
							</c:when>
							<c:otherwise>
								<fmt:message key="no"/>
							</c:otherwise>
						</c:choose>
					</c:if>
				</td>
				<td>
					<c:if test="${paymentMismatch[3] ne null}">
						<c:choose>
							<c:when test="${paymentMismatch[3] eq 1}">
								<fmt:message key="male"/>
							</c:when>
							<c:otherwise>
								<fmt:message key="female"/>
							</c:otherwise>
						</c:choose>
					</c:if>
				</td>
				<td>
					Rs. ${paymentMismatch[7]} - ${paymentMismatch[9]} Posts
				</td>
				<td>
					${paymentMismatch[10]} Posts
				</td>
				<td>
					${paymentMismatch[11]}
				</td>
				<td>
					<a href="javascript:void(0);" onclick="javascript:commonObj.goToURL('<c:url value="challan?operation=showPaymentSearchForm&menu=showPaymentSearchForm&applicantId=${paymentMismatch[1]}"/>');"><fmt:message key="postPaymentMismatch.list.reconcile"/></a>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
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
                            <li><a href="javascript:void(0);" onclick="javascript:postPaymentMisMatchObj.goToPage('1');">&laquo;</a></li>
                            <%-- go to previous page --%>
                            <li><a href="javascript:void(0);" onclick="javascript:postPaymentMisMatchObj.goToPage('${currentPageNo - 1}');">&lt;</a></li>
                        </c:otherwise>
                    </c:choose>
                    <c:forEach var="i" begin="${beginIndex}" end="${endIndex}">
                        <c:choose>
                            <c:when test="${i eq currentPageNo}">
                                <li class="active"><a><c:out value="${i}" /></a></li>
                            </c:when>
                            <c:otherwise>
                                <li><a href="javascript:void(0);" onclick="javascript:postPaymentMisMatchObj.goToPage('${i}');"><c:out value="${i}" /></a></li>
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
                            <li><a href="javascript:void(0);" onclick="javascript:postPaymentMisMatchObj.goToPage('${currentPageNo + 1}');">&gt;</a></li>
                            <%-- go to last page --%>
                            <li><a href="javascript:void(0);" onclick="javascript:postPaymentMisMatchObj.goToPage('${totalPages}');">&raquo;</a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </div>
</nav>