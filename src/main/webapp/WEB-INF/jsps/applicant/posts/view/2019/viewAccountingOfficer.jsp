<%@ include file="../../../../common/taglibs.jsp"%>

<div class="applied">
	<div class="row">
		<div class="col-xs-8">
			<strong><fmt:message key="paymentResponse.postAppliedFor" />
				:</strong>
			<fmt:message key="post.accountingOfficer" />
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
				<th style="width:75%">
					<label><fmt:message key="accounting.audit.officer.postgraduate.degree"/>:</label>
				</th>
				<td style="width:50%">
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
				</tr>
				<tr>
					<c:if test="${ applicantPostAssoc.graduateFromAffiliatedInstitute eq true }">
						
						<th style="width:25%">
							<label><fmt:message
									key="accounting.audit.officer.degree.university" />:</label>
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
			
			<tr>
			<c:if test="${ applicantPostAssoc.graduateFromAffiliatedInstitute eq true }">
			
			
						<th style="width:25%">
							<label><fmt:message key="post.graduate.degree.name"/> :</label>
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
						</td>
						<th style="width:25%">
							<label><fmt:message
									key="driverCumConductor.required.qualification.marks.obtained" />:</label>
						</th>
						<td style="width:25%">
							<label>${applicantPostAssoc.postGraduateMarks}</label>
						</td>
			
			</c:if>
			</tr>
			
			<tr>
				<th style="width:25%">
					<label><fmt:message key="audit.examination.supervisor.in.government"/>:</label>
				</th>
				<td style="width:25%">
				<c:if test="${ not empty applicantPostAssoc.experienced}">
					<c:choose>
							<c:when
								test="${ applicantPostAssoc.experienced eq true }">
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
				<c:if test="${ applicantPostAssoc.experienced eq true }">
						
						<th style="width:25%">
							<label><fmt:message
									key="divisionController.organizationName" />:</label>
						</th>
						<td style="width:25%">
							<label>${applicantPostAssoc.companyName}</label>
						</td>
						<th style="width:25%">
							<label><fmt:message
									key="accounting.audit.officer.company.address" />:</label>
						</th>
						<td style="width:25%">
							<label>${applicantPostAssoc.companyAddress}</label>
						</td>
						
						
					</c:if>
				
			</tr>
			<tr>
				
					<c:if test="${ applicantPostAssoc.experienced eq true }">
						
						<th style="width:25%">
							<label><fmt:message
									key="accounting.audit.officer.company.start.date" />:</label>
						</th>
						<td style="width:25%">
							<label>${applicantPostAssoc.organisationTimeFrom}</label>
						</td>
						<th style="width:25%">
							<label><fmt:message
									key="accounting.audit.officer.company.end.date" />:</label>
						</th>
						<td style="width:25%">
							<label>${applicantPostAssoc.organisationTimeTo}</label>
						</td>
					
					</c:if>
			
						
			</tr>
		
			<tr>
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
