<%@ include file="../../../common/taglibs.jsp"%>

<div class="applied">
	<strong><fmt:message key="paymentResponse.postAppliedFor" />
		: </strong>
	<fmt:message key="post.general.manager.project.informationTechnology" />
</div>
<div class="postalinfo">
	<form class="form-horizontal">
		<table style="width:100%">
			<tr>
				<th style="width:25%">
					<label><fmt:message key="post.general.manager.project.informationTechnology.itEngineer" />:</label>
				</th>
				<td style="width:25%">
					<c:if test="${ not empty applicantPostAssoc.itEngineer}">
					<c:choose>
						<c:when test="${ applicantPostAssoc.itEngineer eq true }">
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
				
				<c:choose>
				<c:when test="${ applicantPostAssoc.itEngineer eq true }">
						<th style="width:25%">
							<label><fmt:message
									key="post.general.manager.project.informationTechnology.itEngineeringDegreeName" />:</label>
						</th>
						<td style="width:25%">
							<label>${applicantPostAssoc.degreeName}</label>
						</td>
				</c:when>
			</c:choose>
			</tr>
			
			
			
			<c:choose>
				<c:when test="${ applicantPostAssoc.itEngineer eq true }">
					<tr>
						<th style="width:25%">
							<label><fmt:message	key="post.general.manager.project.informationTechnology.itEngineeringUniversityName" />:</label>
						</th>
					<td style="width:25%">
						<label>${applicantPostAssoc.universityName}</label>
					</td>
					</tr>
				</c:when>
			</c:choose>
			
			<tr>
				<th style="width:25%">
					<label><fmt:message key="post.general.manager.project.informationTechnology.knowledgeOfSapAndOracle" />:</label>
				</th>
				<td style="width:25%">
					<c:if test="${ not empty applicantPostAssoc.knowledgeOfSapAndOracle}">
						<c:choose>
							<c:when
								test="${ applicantPostAssoc.knowledgeOfSapAndOracle eq true }">
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
					<label><fmt:message key="post.general.manager.project.informationTechnology.minTenYrsExpAsItProjectManager" />:</label>
				</th>
				<td style="width:25%">
					<c:if test="${ not empty applicantPostAssoc.minTenYrsExpAsItProjectManager}">
						<c:choose>
							<c:when
								test="${ applicantPostAssoc.minTenYrsExpAsItProjectManager eq true }">
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
				
				<c:if test="${ applicantPostAssoc.minTenYrsExpAsItProjectManager eq true }">
						<th style="width:25%">
						<label><fmt:message
								key="generalManagerInformationTechnology.experienced.companyName" />:</label>
						</th>
						<td style="width:25%">
							<label>${applicantPostAssoc.companyName}</label>
						</td>
				</c:if>
			</tr>
			
			<c:if test="${ applicantPostAssoc.minTenYrsExpAsItProjectManager eq true }">
				<tr>
				<th style="width:25%">
					<label><fmt:message
							key="generalManagerInformationTechnology.experienced.totalExperienceInYears" />:</label>
				</th>
				<td style="width:25%">
					<label>${applicantPostAssoc.totalExperienceInYears}</label>
				</td>
				<th style="width:25%">
					<label><fmt:message
							key="generalManagerInformationTechnology.experienced.totalExperienceInMonths" />:</label>
				</th>
				<td style="width:25%">
					<label>${applicantPostAssoc.totalExperienceInMonths}</label>
				</td>
				</tr>
			</c:if>
		</table>
</form>
</div>
