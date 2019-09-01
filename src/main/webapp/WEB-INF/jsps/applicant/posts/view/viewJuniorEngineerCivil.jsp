<%@ include file="../../../common/taglibs.jsp"%>

<div class="applied">
	<div class="row">
		<div class="col-xs-8">
			<strong><fmt:message key="paymentResponse.postAppliedFor" />
				: </strong>
			<fmt:message key="post.junoirengineer.civil.junior" />
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
						key="juniorEngineerCivil.architectEngineeringDegree" />:</label></th>
			<td style="width: 25%"><c:if
					test="${ not empty applicantPostAssoc.architectEngineeringDegree}">
					<c:choose>
						<c:when
							test="${ applicantPostAssoc.architectEngineeringDegree eq true }">
							<label> <fmt:message key="yes" />
							</label>
						</c:when>
						<c:otherwise>
							<label> <fmt:message key="no" />
							</label>
						</c:otherwise>
					</c:choose>
				</c:if></td>

			<%-- <c:if
				test="${ applicantPostAssoc.architectEngineeringDegree eq true}">
				<th style="width: 25%"><label><fmt:message
							key="juniorEngineerCivil.degreeName" />:</label></th>
				<td style="width: 25%"><c:if
						test="${ applicantPostAssoc.architectEngineeringDegree eq true }">
						<label>${applicantPostAssoc.degreeName}</label>
					</c:if></td>
			</c:if> --%>
		</tr>

		<c:if test="${ applicantPostAssoc.architectEngineeringDegree eq true}">
			<tr>
				<th style="width: 25%"><label><fmt:message
							key="juniorEngineerCivil.universityName" />:</label></th>
				<td style="width: 25%"><c:if
						test="${ applicantPostAssoc.architectEngineeringDegree eq true }">
						<label>${applicantPostAssoc.universityName}</label>
					</c:if></td>
					<th style="width:25%">
						<label><fmt:message
								key="driverCumConductor.required.qualification.marks.obtained" />:</label>
					</th>
					<td style="width:25%">
						<label>${applicantPostAssoc.requiredQualificationMarks}</label>
					</td>
			</tr>
		</c:if>
		<tr>
			<th style="width: 25%"><label><fmt:message
						key="driver.differentlyAbled" />:</label></th>
			<td style="width: 25%"><c:if
					test="${ not empty applicantPostAssoc.architectEngineeringDegree}">
					<c:choose>
						<c:when test="${ applicantPostAssoc.differentlyAbled eq true }">
							<label> <fmt:message key="yes" />
							</label>
						</c:when>
						<c:otherwise>
							<label> <fmt:message key="no" />
							</label>
						</c:otherwise>
					</c:choose>
				</c:if></td>
			
				<c:if test="${ applicantPostAssoc.differentlyAbled eq true}">
					<c:if test="${not empty applicantPostAssoc.locomotorOrCerebralPalsy }">
						<th style="width: 25%"><label><fmt:message
									key="driver.differentlyAbled.locomotorOrCerebralPalsy" /></label></th>
						<td style="width: 25%"><c:if
								test="${ applicantPostAssoc.locomotorOrCerebralPalsy eq true }">
								<label> <fmt:message key="yes" /> </label>
							</c:if></td>
					</c:if>
					<%-- <c:if test="${ applicantPostAssoc.differentlyAbled eq true}">
						<c:if test="${applicantPostAssoc.differentlyAbledOthers eq true }">
							<th style="width: 25%"><label><fmt:message
										key="clerkTypistJunior.differentlyAbled.others" /></label></th>
							<td style="width: 25%"><c:if
									test="${ not empty applicantPostAssoc.differentlyAbledOthersText }">
									<label>	${applicantPostAssoc.differentlyAbledOthersText} </label>
								</c:if></td>
						</c:if>
					</c:if> --%>
				</c:if>
		</tr>
		<tr>
		<th style="width:25%">
						<label><fmt:message
								key="assistantTrafficSuperintendent.mscitOrGaccc" />:</label>
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
	<c:if test="${applicantPostAssoc.mscitOrGaccc eq false}">
	 <tr >
		<th colspan="1">
			<label><fmt:message key="mscit.note"/>:</label>
		</th>
		<td colspan="5">
			<label>
				<fmt:message key="mscit.equivalent.computer.certificate.alert"/>
			</label>
		</td>
	</tr>
	</c:if>
	</table>
</form>
