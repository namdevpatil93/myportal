<%@ include file="../../../common/taglibs.jsp"%>
<div class="applied">
	<div class="row">
		<div class="col-xs-8">
			<strong><fmt:message key="paymentResponse.postAppliedFor" /> :</strong>
			<fmt:message key="post.accountant.jrstock.verifier.junior" />
		</div>
		<div class="col-xs-4">
			<strong><fmt:message key="view.priority.label" /> : </strong>
			<fmt:message key="post.nontechnical" /> - ${applicantPostAssoc.priority eq 0 || applicantPostAssoc.priority eq null ? "" :applicantPostAssoc.priority}
		</div>
	</div>
</div>
<div class="postalinfo">
	<form class="form-horizontal">
	<table style="width:100%">
			
		<tr>
			<th style="width:25%">
				<label><fmt:message	key="accountantJunior.bcomPassed" />:</label>
			</th>
			<td style="width:25%">
				<c:if test="${ not empty applicantPostAssoc.bcomPassed}">
				<c:choose>
					<c:when test="${ applicantPostAssoc.bcomPassed eq true }">
						<label>
							<fmt:message key="yes" />
						</label>
					</c:when>
					<c:otherwise>
						<label>
							<fmt:message key="no" />
						</label>
					</c:otherwise>
				</c:choose>
				</c:if>
			</td>	
			<c:if test="${ applicantPostAssoc.bcomPassed eq true }">
				<th style="width:25%">
					<label><fmt:message	key="accountantJunior.BcomPassed.universityName" />:</label>
				</th>
				<td style="width:25%">
					<label>${applicantPostAssoc.universityName}</label>
				</td>
			</c:if>
		</tr>
		<tr>
		<%-- 	<th style="width:25%">
				<label><fmt:message	key="accountantJunior.otherQualification" />:</label>
			</th>
			<td style="width:25%">
				<c:choose>
					<c:when
						test="${not empty applicantPostAssoc.otherQualificationDetails }">
						<label>${applicantPostAssoc.otherQualificationDetails}</label>
					</c:when>
					<c:otherwise>
						<label>
							<fmt:message key="NA" />
						</label>
					</c:otherwise>
				</c:choose>
			</td> --%>
			
			<th style="width:25%">
					<label><fmt:message key="accountantJunior.mscitOrGaccc" />:</label>
			</th>
			<td style="width:25%">
					<c:if test="${ not empty applicantPostAssoc.mscitOrGaccc}">
						<c:choose>
							<c:when test="${ applicantPostAssoc.mscitOrGaccc eq true }">
								<label>
									<fmt:message key="yes" />
								</label>
							</c:when>
							<c:otherwise>
								<label>
									<fmt:message key="no" />
								</label>
							</c:otherwise>
						</c:choose>
					</c:if>
				</td>
				
		</tr>
		
		<tr>
			<th style="width:25%">
					<label><fmt:message	key="accountantJunior.experience" />:</label>
			</th>
			<td style="width:25%">
				<c:if test="${ not empty applicantPostAssoc.oneYearExpAsAccountant}">
				<c:choose>
					<c:when
						test="${ applicantPostAssoc.oneYearExpAsAccountant eq true }">
						<label>
							<fmt:message key="yes" />
						</label>
					</c:when>
					<c:otherwise>
						<label>
							<fmt:message key="no" />
						</label>
					</c:otherwise>
				</c:choose>
				</c:if>
			</td>
		
			<c:if test="${ applicantPostAssoc.oneYearExpAsAccountant eq true }">
				
				<th style="width:25%">
				<label><fmt:message
						key="accountantJunior.experienced.companyName" />:</label>
				</th>
				<td style="width:25%">
					<label>${applicantPostAssoc.companyName}</label>
				</td>
				
			</c:if>
			
		</tr>
	
		<c:if test="${ applicantPostAssoc.oneYearExpAsAccountant eq true }">
			<tr>
			
				<th style="width:25%">
					<label><fmt:message
							key="accountantJunior.experienced.inYears" />:</label>
				</th>
				<td style="width:25%">
					<label>${applicantPostAssoc.totalExperienceInYears}</label>
				</td>
				<th style="width:25%">
					<label><fmt:message
							key="accountantJunior.experienced.inMonths" />:</label>
				</th>
				<td style="width:25%">
					<label>${applicantPostAssoc.totalExperienceInMonths}</label>
				</td>
		
				
			</tr>
	  </c:if>
 	</table>
	</form>
</div>