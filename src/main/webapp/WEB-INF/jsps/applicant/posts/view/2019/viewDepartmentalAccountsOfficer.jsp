<%@ include file="../../../../common/taglibs.jsp"%>

<div class="applied">
	<div class="row">
		<div class="col-xs-8">
			<strong><fmt:message key="paymentResponse.postAppliedFor" />
				:</strong>
			<fmt:message key="post.departmentalAccountsOfficer" />
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
			<th style="width: 25%"><label><fmt:message key="departmentalAccountsOfficer.degreeInCommerceFromRecognizedUniversity" />:</label></th>
			<td style="width: 25%">
			<c:if test="${ not empty applicantPostAssoc.bcomPassed}">
					<c:choose>
						<c:when test="${ applicantPostAssoc.bcomPassed eq true }">
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
		
		<tr>
			<c:if test="${ applicantPostAssoc.bcomPassed eq true }">
			
						<th style="width:25%">
							<label><fmt:message key="departmentalAccountsOfficer.degreeName" />:</label>
						</th>
						<td style="width:25%">
							<label>${applicantPostAssoc.degreeName}</label>
						</td>
						<th style="width:25%">
							<label><fmt:message key="departmentalAccountsOfficer.universityName" />:</label>
						</th>
						<td style="width:25%">
							<label>${applicantPostAssoc.universityName}</label>
						</td>
						<th style="width:25%">
							<label><fmt:message key="departmentalAccountsOfficer.marks" />:</label>
						</th>
						<td style="width:25%">
							<label>${applicantPostAssoc.requiredQualificationMarks}</label>
						</td>
			</c:if>
			</tr>
		<tr>
			<th style="width: 25%"><label><fmt:message key="departmentalAccountsOfficer.locomotorOrCerebralPalsy" />:</label></th>
			<td style="width: 25%">
			<c:if test="${ not empty applicantOtherinfo.locomotorOrCerebralPalsy}">
					<c:choose>
						<c:when test="${ applicantOtherinfo.locomotorOrCerebralPalsy eq true }">
							<label> <fmt:message key="yes" /> </label>
						</c:when>
						<c:otherwise>
							<label> <fmt:message key="no" /> </label>
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