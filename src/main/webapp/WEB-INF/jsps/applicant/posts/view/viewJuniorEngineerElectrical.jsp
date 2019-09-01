<%@ include file="../../../common/taglibs.jsp"%>

<div class="applied">
	<div class="row">
		<div class="col-xs-8">
			<strong><fmt:message key="paymentResponse.postAppliedFor" />
				:</strong>
			<fmt:message key="post.junoirengineer.electrical.junior" />
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
						key="juniorEngineerElectrical.electricalEngineeringDegree" />:</label></th>
			<td style="width: 25%"><c:if
					test="${ not empty applicantPostAssoc.electricalEngineeringDegree}">
					<c:choose>
						<c:when
							test="${ applicantPostAssoc.electricalEngineeringDegree eq true }">
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
				test="${ applicantPostAssoc.electricalEngineeringDegree eq true}">
				<th style="width: 25%"><label><fmt:message
							key="juniorEngineerElectrical.degreeName" />:</label></th>
				<td style="width: 25%"><c:if
						test="${ applicantPostAssoc.electricalEngineeringDegree eq true }">
						<label>${applicantPostAssoc.degreeName}</label>
					</c:if></td>
			</c:if> --%>
		</tr>
		<c:if
			test="${ applicantPostAssoc.electricalEngineeringDegree eq true}">
			<tr>
				<th style="width: 25%"><label><fmt:message
							key="juniorEngineerCivil.universityName" />:</label></th>
				<td style="width: 25%"><c:if
						test="${ applicantPostAssoc.electricalEngineeringDegree eq true }">
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
		<tr><th style="width:25%">
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
					</td></tr>
					
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


