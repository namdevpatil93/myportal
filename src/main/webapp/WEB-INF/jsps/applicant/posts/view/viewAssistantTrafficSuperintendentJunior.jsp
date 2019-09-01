<%@ include file="../../../common/taglibs.jsp"%>
<div class="applied">
	<div class="row">
		<div class="col-xs-8">
			<strong><fmt:message key="paymentResponse.postAppliedFor" /> :</strong>
			<fmt:message key="post.assistant.traffic.superitendent.junior" />
		</div>
		<div class="col-xs-4">
			<strong><fmt:message key="view.priority.label" /> : </strong>
			<fmt:message key="post.nontechnical" /> -  ${applicantPostAssoc.priority eq 0 || applicantPostAssoc.priority eq null ? "" :applicantPostAssoc.priority}
		</div>
	</div>
</div>
<div class="postalinfo">
	<form class="form-horizontal">
		<table style="width:100%">
			<tr>
				<th style="width:25%">
					<label><fmt:message key="assistantTrafficSuperintendent.graduateFromAffiliatedInstitute"/>:</label>
				</th>
				<td style="width:25%">
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
				
					<c:if test="${ applicantPostAssoc.graduateFromAffiliatedInstitute eq true }">
						<th style="width:25%">
							<label><fmt:message key="assistantTrafficSuperintendent.graduateFromAffiliatedInstitute.degreeName"/>:</label>
						</th>
						<td style="width:25%">
							<label>${applicantPostAssoc.degreeName}</label>
						</td>
					</c:if>
			</tr>
			<tr>
					<c:if test="${ applicantPostAssoc.graduateFromAffiliatedInstitute eq true }">
							<th style="width:25%">
								<label><fmt:message	key="assistantTrafficSuperintendent.graduateFromAffiliatedInstitute.universityName" />:</label>
							</th>
							<td style="width:25%">
								<label>${applicantPostAssoc.universityName}</label>
							</td>
							<th style="width:25%">
							<label><fmt:message key="driverCumConductor.required.qualification.marks.obtained" />:</label>
							</th>
							<td style="width:25%">
							<label>${applicantPostAssoc.requiredQualificationMarks}</label>
							</td>
					</c:if>
					
				<%--  <th style="width:25%">
						<label><fmt:message	key="assistantTrafficSuperintendent.otherQualificationDetails" />:</label>
					</th>
					<td style="width:25%">
						<c:choose>
							<c:when
								test="${not empty applicantPostAssoc.otherQualificationDetails }">
								<label>${applicantPostAssoc.otherQualificationDetails}</label>
							</c:when>
							<c:otherwise>
								<label>
									<fmt:message key="NA" />
								</label>
							</c:otherwise>
						</c:choose>
					</td>  --%>
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
	
				<tr>	
					<th style="width:25%">
						<label><fmt:message
								key="assistantTrafficSuperintendent.heightWithinRange" />:</label>
					</th>
					<td style="width:25%">
						<c:if test="${ not empty applicantPostAssoc.heightWithinRange}">
						<c:choose>
							<c:when test="${ applicantPostAssoc.heightWithinRange eq true }">
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
					<label><fmt:message	key="assistantTrafficSuperintendent.twoYearExpAsTransportAssociation" />:</label>
				</th>
				<td style="width:25%">
					<c:if test="${ not empty applicantPostAssoc.twoYearExpAsTransportAssociation}">
					<c:choose>
						<c:when
							test="${ applicantPostAssoc.twoYearExpAsTransportAssociation eq true }">
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
				
				<c:if test="${ applicantPostAssoc.twoYearExpAsTransportAssociation eq true }">
						<th style="width:25%">
						<label><fmt:message
								key="assistantTrafficSuperintendent.experienced.companyName" />:</label>
						</th>
						<td style="width:25%">
							<label>${applicantPostAssoc.companyName}</label>
						</td>
				</c:if>
			</tr>
			
			<c:if test="${ applicantPostAssoc.twoYearExpAsTransportAssociation eq true }">
				<tr>
				<th style="width:25%">
					<label><fmt:message
							key="trafficInspector.experienced.inYears" />:</label>
				</th>
				<td style="width:25%">
					<label>${applicantPostAssoc.totalExperienceInYears}</label>
				</td>
				<th style="width:25%">
					<label><fmt:message
							key="trafficInspector.experienced.inMonths" />:</label>
				</th>
				<td style="width:25%">
					<label>${applicantPostAssoc.totalExperienceInMonths}</label>
				</td>
				</tr>
			</c:if>
				
				<tr>
					<th style="width:25%">
						<label><fmt:message key="assistantTrafficSuperintendent.ownHeavyDrivingLicenseNumber" />:</label>
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

				<c:if
					test="${ not empty applicantPostAssoc.ownHeavyDrivingLicenseNumber }">
					<th style="width: 25%"><c:if
							test="${(applicantPostAssoc.ownHeavyDrivingLicenseNumber eq true and  not empty applicantPostAssoc.heavyDrivingLicenseNumber) or  applicantPostAssoc.ownHeavyDrivingLicenseNumber eq false}">
							<label><fmt:message
									key="assistantTrafficSuperintendent.ownHeavyDrivingLicenseNumber.number" />:</label>
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
									key="assistantTrafficSuperintendent.ownHeavyDrivingLicenseNumber.issueDate" />:</label>
						</th>
						<td style="width: 25%"><c:if
								test="${ applicantPostAssoc.ownHeavyDrivingLicenseNumber eq true }">
								<label><tags:localDate pattern="dd/MM/yyyy"
										date="${applicantPostAssoc.heavyDrivingLicenseIssueDate}" /></label>
							</c:if></td>
					</c:if>
					<c:if
						test="${ not empty applicantPostAssoc.heavyDrivingLicenseEndDate }">
						<th style="width: 25%"><label><fmt:message
									key="assistantTrafficSuperintendent.ownHeavyDrivingLicenseNumber.endDate" />:</label>
						</th>
						<td style="width: 25%"><c:if
								test="${ applicantPostAssoc.ownHeavyDrivingLicenseNumber eq true }">
								<label><tags:localDate pattern="dd/MM/yyyy"
										date="${applicantPostAssoc.heavyDrivingLicenseEndDate}" /></label>
							</c:if></td>
					</c:if>
				</tr>
			</c:if>


			<tr>
					<%-- <th style="width:25%">
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
					</td> --%>
					
					<%-- <th style="width:25%">
						<label><fmt:message
								key="assistantTrafficSuperintendent.heightWithinRange" />:</label>
					</th>
					<td style="width:25%">
						<c:if test="${ not empty applicantPostAssoc.heightWithinRange}">
						<c:choose>
							<c:when test="${ applicantPostAssoc.heightWithinRange eq true }">
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
					</td> --%>
				</tr>
				
		</table>
	</form>
</div>