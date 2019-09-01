<%@ include file="../../../../common/taglibs.jsp"%>
<div class="applied">
	<div class="row">
		<div class="col-xs-8">
			<strong><fmt:message key="paymentResponse.postAppliedFor" />
				:</strong>
			<fmt:message key="post.departmentalTransportOfficer" />
		</div>
		<%-- <div class="col-xs-4">
			<strong><fmt:message key="applicant.division" /> : </strong>
			<c:choose>
				<c:when test='${divisionName eq null || divisionName eq ""}'>
					<fmt:message key="emptystring" />
				</c:when>
				<c:otherwise>
					<fmt:message key="${divisionName}" />
				</c:otherwise>
			</c:choose>
		</div> --%>
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
					<label><fmt:message key="departmental.transport.officer.degree"/>:</label>
				</th>
				<td style="width:25%">
						<c:choose>
							<c:when test="${ applicantPostAssoc.gradOrPostGrad==1}">
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
					
				</td>
				</tr>
			<c:if test="${ applicantPostAssoc.gradOrPostGrad==1 }">
				<tr>	<th style="width:25%">
						<label><fmt:message
								key="departmental.transport.officer.postGraduateName" />:</label>
					</th>
					<td style="width:25%">
						<label>${applicantPostAssoc.postGraduateDegreeName}</label>
					</td>
					
					<th style="width:25%">
						<label><fmt:message
								key="applicant.universityName" />:</label>
					</th>
					<td style="width:25%">
						<label>${applicantPostAssoc.postGradDegreeInstituteName}</label>
					</td></tr>
				<tr>	<th style="width:25%">
						<label><fmt:message
								key="driverCumConductor.required.qualification.marks.obtained" />:</label>
					</th>
					<td style="width:25%">
						<label>${applicantPostAssoc.postGraduateMarks}</label>
					</td>
					</tr>
					</c:if>
					<tr>
				<th style="width:25%">
					<label><fmt:message key="deputy.equipment.engineer.heavyDriveLicense"/>:</label>
				</th>
				<td style="width:25%">
					
						<c:choose>
							<c:when
								test="${ applicantPostAssoc.ownHeavyDrivingLicenseNumber eq true }">
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
					
				</td>
				
				<th style="width:25%">
					<label><fmt:message key="machine.engineer.isMscIt"/>:</label>
				</th>
				<td style="width:25%">
					
						
						<c:choose>
							<c:when
								test="${ applicantPostAssoc.mscitOrGaccc eq true }">
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
</div>