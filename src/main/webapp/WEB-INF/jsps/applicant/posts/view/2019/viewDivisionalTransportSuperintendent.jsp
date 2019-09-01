<%@ include file="../../../../common/taglibs.jsp"%>

<div class="applied">
	<div class="row">
		<div class="col-xs-8">
			<strong><fmt:message key="paymentResponse.postAppliedFor" />
				:</strong>
			<fmt:message key="post.divisionalTransportSuperintendent" />
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
<form class="form-horizontal">
	<table style="width: 100%">
		
		<tr>
				<th style="width:25%">
					<label><fmt:message key="divisional.transport.superintendent.degree"/>:</label>
				</th>
				<td style="width:25%">
					<c:if test="${ not empty applicantPostAssoc.gradOrPostGrad}">
						<c:choose>
							<c:when
								test="${ applicantPostAssoc.gradOrPostGrad eq 1 }">
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
			<c:if test="${ applicantPostAssoc.gradOrPostGrad eq 1 }">
			
			
						<th style="width:25%">
							<label><fmt:message
									key="applicant.degreeName" />:</label>
						</th>
						<td style="width:25%">
							<label>${applicantPostAssoc.degreeName}</label>
						</td>
						<th style="width:25%">
							<label><fmt:message
									key="applicant.universityName" />:</label>
						</th>
						<td style="width:25%">
							<label>${applicantPostAssoc.instituteName}</label>
						</td>
						<th style="width:25%">
							<label><fmt:message
									key="driverCumConductor.required.qualification.marks.obtained" />:</label>
						</th>
						<td style="width:25%">
							<label>${applicantPostAssoc.requiredQualificationMarks}</label>
						</td>
			
			</c:if>
			</tr>
			
			<%-- <tr>
			<c:if test="${ applicantPostAssoc.gradOrPostGrad eq 1 }">
			
			
						<th style="width:25%">
							<label><fmt:message
									key="postgraddegree.label" />:</label>
						</th>
						<td style="width:25%">
							<label>${applicantPostAssoc.postGraduateDegreeName}</label>
						</td>
						<th style="width:25%">
							<label><fmt:message
									key="postgraddegree.instituteName" />:</label>
						</th>
						<td style="width:25%">
							<label>${applicantPostAssoc.postGradDegreeInstituteName}</label>
						</td>
						<th style="width:25%">
							<label><fmt:message
									key="driverCumConductor.required.qualification.marks.obtained" />:</label>
						</th>
						<td style="width:25%">
							<label>${applicantPostAssoc.postGraduateMarks}</label>
						</td>
			
			</c:if>
			</tr> --%>
			<tr>
				<th style="width:25%">
					<label><fmt:message
									key="deputy.equipment.engineer.heavyDriveLicense" /></label>
				</th>
				<td style="width:25%">
					<c:if test="${ not empty applicantPostAssoc.ownHeavyDrivingLicenseNumber}">
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
					</c:if>
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
