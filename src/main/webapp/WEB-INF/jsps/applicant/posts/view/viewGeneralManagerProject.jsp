<%@ include file="../../../common/taglibs.jsp"%>

<div class="applied">
	<strong><fmt:message key="paymentResponse.postAppliedFor" />
		: </strong>
	<fmt:message key="post.general.manager.project" />
</div>
	<form class="form-horizontal">
		<table style="width:100%">
			<tr>
				<th style="width:25%">
					<label><fmt:message key="manager.mba.from.government.affiliated.institute"/>:</label>
				</th>
				<td style="width:25%">
					<c:if test="${ not empty applicantPostAssoc.mbaFromGovernmentAffiliatedInstitute}">
						<c:choose>
							<c:when
								test="${ applicantPostAssoc.mbaFromGovernmentAffiliatedInstitute eq true }">
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
			
			<c:choose>
				<c:when test="${ applicantPostAssoc.mbaFromGovernmentAffiliatedInstitute eq true }">
					<tr>
						<th style="width:25%">
							<label><fmt:message key="manager.degree.name" />:</label>
						</th>
						<td style="width:25%">
							<label>${applicantPostAssoc.degreeName}</label>
						</td>
						
						<th style="width:25%">
							<label><fmt:message key="manager.university.name" />:</label>
						</th>
						
						<td style="width:25%">
						<label>${applicantPostAssoc.universityName}</label>
					</td>
					</tr>
				</c:when>
			</c:choose>
			
			
			<tr>
				<th style="width:25%">
					<label><fmt:message key="manger.experience.note"/>:</label>
				</th>
				<td style="width:25%">
					<c:if test="${ not empty applicantPostAssoc.fifteenYearExpInCommerce}">
						<c:choose>
							<c:when test="${ applicantPostAssoc.fifteenYearExpInCommerce eq true }">
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
				
				<c:if test="${applicantPostAssoc.fifteenYearExpInCommerce eq true}">
					<th style="width:25%">
						<label><fmt:message key="manager.experienced.companyName"/>:</label>
					</th>
					<td style="width:25%">
						<label>${applicantPostAssoc.companyName}</label>
					</td>
				</c:if>
			</tr>
			
			<c:if test="${applicantPostAssoc.fifteenYearExpInCommerce eq true}">
				<tr>
					<th style="width: 25%">
						<label><fmt:message	key="manager.experienced.inYears" />:</label></th>
					<td style="width: 25%">
						<label>${applicantPostAssoc.totalExperienceInYears}</label>
					</td>
					<th style="width: 25%">
						<label><fmt:message	key="manager.experienced.inMonths" />:</label></th>
					<td style="width: 25%">
						<label>${applicantPostAssoc.totalExperienceInMonths}</label>
					</td>
				</tr>
			</c:if>
		</table>
	</form>
