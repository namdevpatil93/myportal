<%@ include file="../../../common/taglibs.jsp"%>
<div class="applied">
	<div class="row">
		<div class="col-xs-8">
			<strong><fmt:message key="paymentResponse.postAppliedFor" /> :</strong>
			<fmt:message key="post.storesupervisor.srstock.verifier.junior" />
		</div>
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
					 <label><fmt:message key="store.supervisor.junior.bachlor.diploma.holders"/>:</label>
				</th>
				<td style="width:25%">
					<c:if test="${ not empty applicantPostAssoc.bComOrBSCOrDiplomaHoldersInAutomobileOrMechanical}">
						<c:choose>
							<c:when
								test="${ applicantPostAssoc.bComOrBSCOrDiplomaHoldersInAutomobileOrMechanical eq true }">
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
				
				
					<c:if test="${ applicantPostAssoc.bComOrBSCOrDiplomaHoldersInAutomobileOrMechanical eq true }">
						<th style="width:25%">
							<label><fmt:message
									key="store.supervisor.decgree.diploma.name" />:</label>
						</th>
						<td style="width:25%">
							<label>${applicantPostAssoc.degreeName}</label>
						</td>
					</c:if>
			</tr>
			<tr>
				<c:if test="${ applicantPostAssoc.bComOrBSCOrDiplomaHoldersInAutomobileOrMechanical eq true  }">
						<th style="width:25%">
							<label><fmt:message	key="juniorEngineerCivil.universityName" />:</label>
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
				
				<%-- <th style="width:25%">
					<label><fmt:message	key="assistantJunior.otherQualification" />:</label>
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
				</td> --%>
			</tr>
			<tr>
				<th style="width:25%">
					<label><fmt:message
							key="store.supervisor.mscit.government.affiliated.computer.course.certification" />:</label>
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
					<label><fmt:message	key="store.supervisor.experience.in.hand" />:</label>
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
							key="store.supervisor.company.name" />:</label>
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
							key="accountantJunior.experienced.inYears" />:</label>
				</th>
				<td style="width:25%">
					<label>${applicantPostAssoc.totalExperienceInYears}</label>
				</td>
				<th style="width:25%">
					<label><fmt:message
							key="accountantJunior.experienced.inMonths" />:</label>
				</th>
				<td style="width:25%">
					<label>${applicantPostAssoc.totalExperienceInMonths}</label>
				</td>
				</tr>
			</c:if>
		
			
			<tr>
				<%-- <th style="width:25%">
					<label><fmt:message
							key="store.supervisor.mscit.government.affiliated.computer.course.certification" />:</label>
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
			</tr>
				
		</table>
	</form>
</div>