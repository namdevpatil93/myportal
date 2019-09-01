<%@ include file="../../../common/taglibs.jsp"%>
<div class="applied">
	<div class="row">
		<div class="col-xs-8">
			<strong><fmt:message key="paymentResponse.postAppliedFor" />
				:</strong>
			<fmt:message key="post.chargeman.junior" />
		</div>
		<div class="col-xs-4">
			<strong><fmt:message key="view.priority.label" /> : </strong>
			<fmt:message key="post.technical" />
			- ${applicantPostAssoc.priority eq 0 || applicantPostAssoc.priority eq null ? "" :applicantPostAssoc.priority}
		</div>
	</div>
</div>
<form class="form-horizontal">
	<table style="width: 100%">
		<tr>
			<th style="width: 25%"><label><fmt:message
						key="chargeManJunior.automobileOrMechanicalEngDegree" />:</label></th>
			<td style="width: 25%"><c:if
					test="${ not empty applicantPostAssoc.automobileOrMechanicalEngDegree}">
					<c:choose>
						<c:when
							test="${ applicantPostAssoc.automobileOrMechanicalEngDegree eq true }">
							<label> <fmt:message key="yes" />
							</label>
						</c:when>
						<c:otherwise>
							<label> <fmt:message key="no" />
							</label>
						</c:otherwise>
					</c:choose>
				</c:if></td>

			<c:if
				test="${ applicantPostAssoc.automobileOrMechanicalEngDegree eq true }">
				<th style="width: 25%"><label><fmt:message
							key="chargeManJunior.degreeName" />:</label></th>
				<td style="width: 25%"><c:if
						test="${ applicantPostAssoc.automobileOrMechanicalEngDegree eq true }">
						<label>${applicantPostAssoc.degreeName}</label>
					</c:if></td>
			</c:if>
		</tr>
		<c:if
			test="${ applicantPostAssoc.automobileOrMechanicalEngDegree eq true }">
			<tr>
				<th style="width: 25%"><label><fmt:message
							key="chargeManJunior.automobileOrMechanicalEngDegree.universityName" />:</label></th>
				<td style="width: 25%"><c:if
						test="${ applicantPostAssoc.automobileOrMechanicalEngDegree eq true }">
						<label>${applicantPostAssoc.universityName}</label>
					</c:if></td>
			</tr>
		</c:if>
		<%-- <tr>
			<th style="width: 25%"><label><fmt:message
						key="chargeManJunior.otherQualification" />: </label></th>
			<td style="width: 25%"><c:choose>
					<c:when
						test="${not empty applicantPostAssoc.otherQualificationDetails }">
						<label>${applicantPostAssoc.otherQualificationDetails}</label>
					</c:when>
					<c:otherwise>
						<label> <fmt:message key="NA" />
						</label>
					</c:otherwise>
				</c:choose></td>
		</tr>
 --%>
		<tr>
			<th style="width: 25%"><label><fmt:message
						key="chargeManJunior.experience" />:</label></th>
			<td style="width: 25%"><c:if
					test="${ not empty applicantPostAssoc.oneYearExpInAutomobileRepairing}">
					<c:choose>
						<c:when
							test="${ applicantPostAssoc.oneYearExpInAutomobileRepairing eq true }">
							<label> <fmt:message key="yes" />
							</label>
						</c:when>
						<c:otherwise>
							<label> <fmt:message key="no" />
							</label>
						</c:otherwise>
					</c:choose>
				</c:if></td>

			<c:if
				test="${ applicantPostAssoc.oneYearExpInAutomobileRepairing eq true }">
				<th style="width: 25%"><label><fmt:message
							key="chargeMan.experienced.companyName" />:</label></th>
				<td style="width: 25%"><c:if
						test="${ applicantPostAssoc.oneYearExpInAutomobileRepairing eq true }">
						<label>${applicantPostAssoc.companyName}</label>
					</c:if></td>
			</c:if>
		</tr>
		<c:if
			test="${ applicantPostAssoc.oneYearExpInAutomobileRepairing eq true }">
			<tr>
				<th style="width: 25%"><label><fmt:message
							key="accountantJunior.experienced.inYears" />:</label></th>
				<td style="width: 25%"><c:if
						test="${ applicantPostAssoc.oneYearExpInAutomobileRepairing eq true }">
						<label>${applicantPostAssoc.totalExperienceInYears}</label>
					</c:if></td>
				<th style="width: 25%"><label><fmt:message
							key="accountantJunior.experienced.inMonths" />:</label></th>
				<td style="width: 25%"><c:if
						test="${ applicantPostAssoc.oneYearExpInAutomobileRepairing eq true }">
						<label>${applicantPostAssoc.totalExperienceInMonths}</label>
					</c:if></td>
			</tr>
		</c:if>
		<tr>
			<th style="width: 25%"><label><fmt:message
						key="chargeManJunior.ownHeavyDrivingLicenseNo" />:</label></th>
			<td style="width: 25%"><c:if
					test="${ not empty applicantPostAssoc.ownHeavyDrivingLicenseNumber}">
					<c:choose>
						<c:when
							test="${ applicantPostAssoc.ownHeavyDrivingLicenseNumber eq true }">
							<label> <fmt:message key="yes" />
							</label>
						</c:when>
						<c:otherwise>
							<label> <fmt:message key="no" />
							</label>
						</c:otherwise>
					</c:choose>
				</c:if></td>
			<c:if
				test="${ not empty applicantPostAssoc.ownHeavyDrivingLicenseNumber }">
				<th style="width: 25%"><c:if
						test="${(applicantPostAssoc.ownHeavyDrivingLicenseNumber eq true and  not empty applicantPostAssoc.heavyDrivingLicenseNumber) or  applicantPostAssoc.ownHeavyDrivingLicenseNumber eq false}">
						<label><fmt:message
								key="chargeManJunior.ownHeavyDrivingLicenseNo.number" />:</label>
					</c:if></th>
				<td style="width: 25%"><c:choose>
						<c:when
							test="${ applicantPostAssoc.ownHeavyDrivingLicenseNumber eq true }">
							<label>${applicantPostAssoc.heavyDrivingLicenseNumber}</label>
						</c:when>
						<c:otherwise>
							<fmt:message key="heavydrivinglicence.no.agree.to.submit.later" />
						</c:otherwise>
					</c:choose></td>
			</c:if>

		</tr>
		<c:if
			test="${ not empty applicantPostAssoc.ownHeavyDrivingLicenseNumber }">
			<tr>
				<c:if
					test="${ not empty applicantPostAssoc.heavyDrivingLicenseIssueDate }">
					<th style="width: 25%"><label><fmt:message
								key="chargeManJunior.ownHeavyDrivingLicenseNo.issueDate" />:</label></th>
					<td style="width: 25%"><c:if
							test="${ applicantPostAssoc.ownHeavyDrivingLicenseNumber eq true }">
							<label><tags:localDate pattern="dd/MM/yyyy"
									date="${applicantPostAssoc.heavyDrivingLicenseIssueDate}" /></label>
						</c:if></td>
				</c:if>
				<c:if
					test="${ not empty applicantPostAssoc.heavyDrivingLicenseEndDate }">
					<th style="width: 25%"><label><fmt:message
								key="chargeManJunior.ownHeavyDrivingLicenseNo.endDate" />:</label></th>
					<td style="width: 25%"><c:if
							test="${ applicantPostAssoc.ownHeavyDrivingLicenseNumber eq true }">
							<label><tags:localDate pattern="dd/MM/yyyy"
									date="${applicantPostAssoc.heavyDrivingLicenseEndDate}" /></label>
						</c:if></td>
				</c:if>
			</tr>
		</c:if>
	</table>
</form>