<%@ include file="../../../../common/taglibs.jsp"%>

<div class="applied">
	<div class="row">
		<div class="col-xs-8">
			<strong><fmt:message key="paymentResponse.postAppliedFor" />
				:</strong>
			<fmt:message key="post.storeOfficer" />
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
			<th style="width: 25%"><label><fmt:message key="storeOfficer.firstClassDegreeInEngineering" />:</label></th>
			<td style="width: 25%">
			<c:if test="${ not empty applicantPostAssoc.isFirstClassDegree}">
					<c:choose>
						<c:when test="${ applicantPostAssoc.isFirstClassDegree eq true }">
							<label> <fmt:message key="yes" />
							</label>
						</c:when>
						<c:otherwise>
							<label> <fmt:message key="no" />
							</label>
						</c:otherwise>
					</c:choose>
				</c:if>
			</td>
		</tr>
		<c:if test="${ applicantPostAssoc.isFirstClassDegree eq true }">
			<tr>
				<th style="width:25%">
					<label><fmt:message key="storeOfficer.degreeName" />:</label>
				</th>
				<td style="width:25%">
					<label>${applicantPostAssoc.degreeName}</label>
				</td>
				<th style="width:25%">
					<label><fmt:message key="storeOfficer.universityName" />:</label>
				</th>
					<td style="width:25%">
						<label>${applicantPostAssoc.universityName}</label>
					</td>
			</tr>
			<tr>
				<th style="width:25%">
					<label><fmt:message key="storeOfficer.marks" />:</label>
				</th>
				<td style="width:25%">
					<label>${applicantPostAssoc.requiredQualificationMarks}</label>
				</td>
			</tr>
		</c:if>
		
		<c:if test="${ applicantPostAssoc.isFirstClassDegree eq false }">
			<tr>
				<th style="width:25%">
					<label><fmt:message key="storeOfficer.postGraduateDegreeName" />:</label>
				</th>
				<td style="width:25%">
					<label>${applicantPostAssoc.postGraduateDegreeName}</label>
				</td>
				<th style="width:25%">
					<label><fmt:message key="storeOfficer.universityName" />:</label>
				</th>
				<td style="width:25%">
					<label>${applicantPostAssoc.postGradDegreeInstituteName}</label>
				</td>
			</tr>
			<tr>
				<th style="width:25%">
					<label><fmt:message key="storeOfficer.marks" />:</label>
				</th>
				<td style="width:25%">
					<label>${applicantPostAssoc.postGraduateMarks}</label>
				</td>
			</tr>
			</c:if>
			
		<tr>
			<th style="width: 25%"><label><fmt:message key="storeOfficer.2ndClassInMBA" />:</label></th>
			<td style="width: 25%">
				<c:if test="${ not empty applicantPostAssoc.isSecondClassInMBA}">
					<c:choose>
						<c:when test="${ applicantPostAssoc.isSecondClassInMBA eq true }">
							<label> <fmt:message key="yes" />
							</label>
						</c:when>
						<c:otherwise>
							<label> <fmt:message key="no" />
							</label>
						</c:otherwise>
					</c:choose>
				</c:if>
			</td>
		</tr>
		<c:if test="${ applicantPostAssoc.isSecondClassInMBA eq true }">
			<tr>
				<th style="width:25%">
					<label><fmt:message key="storeOfficer.postGraduateDegreeMBA" />:</label>
				</th>
				<td style="width:25%">
					<label>${applicantPostAssoc.mbaDegreeName}</label>
				</td>
				<th style="width:25%">
					<label><fmt:message key="storeOfficer.universityName" />:</label>
				</th>
				<td style="width:25%">
					<label>${applicantPostAssoc.mbaUniversity}</label>
				</td>
			</tr>
			<tr>
				<th style="width:25%">
					<label><fmt:message key="storeOfficer.marks" />:</label>
				</th>
					<td style="width:25%">
					<label>${applicantPostAssoc.mbaMarks}</label>
				</td>
			</tr>
		</c:if>
		<c:if test="${ applicantPostAssoc.isSecondClassInMBA eq false }">
			<tr>
				<th style="width:25%">
					<label><fmt:message key="storeOfficer.icwaDiplomaName" />:</label>
				</th>
					<td style="width:25%">
						<label>${applicantPostAssoc.icwaDiplomaName}</label>
					</td>
					<th style="width:25%">
						<label><fmt:message key="storeOfficer.universityName" />:</label>
					</th>
					<td style="width:25%">
						<label>${applicantPostAssoc.icwaUniversityName}</label>
					</td>
			</tr>
			<tr>
				<th style="width:25%">
					<label><fmt:message key="storeOfficer.marks" />:</label>
				</th>
				<td style="width:25%">
					<label>${applicantPostAssoc.icwaMarks}</label>
				</td>
			</tr>
		</c:if>
			<tr><th style="width:25%">
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