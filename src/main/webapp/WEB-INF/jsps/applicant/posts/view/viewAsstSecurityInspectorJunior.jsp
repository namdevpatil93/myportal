<%@ include file="../../../common/taglibs.jsp"%>
<div class="applied">
	<div class="row">
		<div class="col-xs-8">
			<strong><fmt:message key="paymentResponse.postAppliedFor" /> :</strong>
			<fmt:message key="post.assistant.security.inspector.junior" />
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
					<label><fmt:message key="asstSecurityInspector.graduateFromAffiliatedInstitute"/>:</label>
				</th>
				<td style="width:25%">
					<c:if test="${ not empty applicantPostAssoc.graduateFromAffiliatedInstitute}">
						<c:choose>
							<c:when
								test="${ applicantPostAssoc.graduateFromAffiliatedInstitute eq true }">
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
				
					<c:if test="${ applicantPostAssoc.graduateFromAffiliatedInstitute eq true }">
						<th style="width:25%">
							<label><fmt:message
									key="applicant.degreeName" />:</label>
						</th>
						<td style="width:25%">
							<label>${applicantPostAssoc.degreeName}</label>
						</td>
					</c:if>
			</tr>
			<tr>
				<c:if test="${ applicantPostAssoc.graduateFromAffiliatedInstitute eq true  }">
						<th style="width:25%">
							<label><fmt:message	key="applicant.universityName" />:</label>
						</th>
						<td style="width:25%">
							<label>${applicantPostAssoc.universityName}</label>
						</td>
				</c:if>
				
				<%-- <th style="width:25%">
					<label><fmt:message	key="asstSecurityInspector.otherQualificationDetails" />:</label>
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
			</tr>
			
			<tr>
				<th style="width:25%">
					<label><fmt:message
							key="asstSecurityInspector.mscitOrGaccc" />:</label>
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
				
				<th style="width:25%">
					<label><fmt:message key="asstSecurityInspector.heightWithinRange" />:</label>
				</th>
				<td style="width:25%">
				<c:if test="${ not empty applicantPostAssoc.heightWithinRange}">
					<c:choose>
						<c:when test="${ applicantPostAssoc.heightWithinRange eq true }">
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
	</table>
	</form>
</div>