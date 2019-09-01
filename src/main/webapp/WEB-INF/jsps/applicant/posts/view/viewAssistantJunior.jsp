<%@ include file="../../../common/taglibs.jsp"%>
<div class="applied">
	<div class="row">
		<div class="col-xs-8">
			<strong><fmt:message key="paymentResponse.postAppliedFor" /> :</strong>
			<fmt:message key="post.assistant.junior" />
		</div>
		<div class="col-xs-4">
			<strong><fmt:message key="applicant.division" /> : </strong>
			<c:choose>
			<c:when test='${divisionName eq null || divisionName eq ""}'>
				<fmt:message key="emptystring"/>
			</c:when>
			<c:otherwise>
				<fmt:message key="${divisionName}" />
			</c:otherwise> 
			</c:choose>
		</div>
	</div>
</div>
<div class="postalinfo">
	<form class="form-horizontal">

<table style="width:100%">
			<tr>
				<th style="width:25%">
					<label><fmt:message key="assistantJunior.itiPass"/>:</label>
				</th>
				<td style="width:25%">
				<c:if test="${ not empty applicantPostAssoc.itiPassed}">
					<c:choose>
						<c:when
							test="${ applicantPostAssoc.itiPassed eq true }">
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
				<th style="width: 25%"><label><fmt:message
							key="assistantJunior.trade" />:</label></th>
				<td style="width: 25%"><c:choose>
						<c:when test="${ not empty tradeName }">
							<label>
								<fmt:message key="${tradeName}" />
							</label>
						</c:when>
						<c:otherwise>
							<label> <fmt:message key="NA" />
							</label>
						</c:otherwise>
					</c:choose></td>
					
			</tr>

			<tr>
			
			<th style="width:25%">
					<label><fmt:message	key="assistantJunior.experience" />:</label>
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
							key="assistantJunior.experienced.companyName" />:</label>
					</th>
					<td style="width:25%">
						<label>${applicantPostAssoc.companyName}</label>
					</td>
					
					
				</c:if>
			</tr>
			
			<c:if test="${ applicantPostAssoc.experienced eq true }">
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
				<th style="width:25%">
					<label><fmt:message key="assistantJunior.nightBlindness"/>:</label>
				</th>
				<td style="width:25%">
				<c:if test="${ not empty applicantPostAssoc.nightBlindness}">
					<c:choose>
						<c:when
							test="${ applicantPostAssoc.nightBlindness eq true }">
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
					<label><fmt:message key="assistantJunior.colorBlindness"/>:</label>
				</th>
				<td style="width:25%">
				<c:if test="${ not empty applicantPostAssoc.colorBlindness}">
					<c:choose>
						<c:when
							test="${ applicantPostAssoc.colorBlindness eq true }">
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
					<th style="width: 25%"><label><fmt:message
								key="assistantJunior.light.motor.vehicle" />:</label></th>
					<td style="width: 25%"><c:if
							test="${ not empty applicantPostAssoc.lightMotorVechicle}">
							<c:choose>
								<c:when
									test="${ applicantPostAssoc.lightMotorVechicle eq true }">
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
				 	
				 	<c:if test="${ not empty applicantPostAssoc.lightMotorVechicle}">
						<c:choose>
							<c:when
								test="${ applicantPostAssoc.lightMotorVechicle eq false }">
								<th style="width: 25%"><label><fmt:message
									key="assistantJunior.light.motor.vehicle.license.no" />:</label></th>
								<td style="width: 25%">
								<label> <fmt:message key="assistantJunior.light.motor.vehicle.confirmation.msg" />
								</label></td>
							</c:when>
							<c:otherwise>
								<th style="width: 25%"><label><fmt:message
									key="assistantJunior.light.motor.vehicle.license.no" />:</label></th>
								<td style="width: 25%">
								<label>${applicantPostAssoc.lightMotorVechicleLicenseNo}
								</label></td>
							</c:otherwise>
						</c:choose>
					</c:if>	
				</tr>
				
				<%-- <c:if test="${ applicantPostAssoc.lightMotorVechicle eq false }">
					<tr>
						<th style="width: 25%"><label><fmt:message
									key="assistantJunior.learning.license" />:</label></th>
						<td style="width: 25%"><c:if
								test="${ not empty applicantPostAssoc.learningLicense}">
								<c:choose>
									<c:when
										test="${ applicantPostAssoc.learningLicense eq true }">
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
					 	
					 	<c:if test="${ not empty applicantPostAssoc.learningLicense}">
							<c:choose>
								<c:when
									test="${ applicantPostAssoc.learningLicense eq false }">
									<th style="width: 25%"><label><fmt:message
										key="assistantJunior.learning.license.no" />:</label></th>
									<td style="width: 25%">
									<label> <fmt:message key="assistantJunior.learning.license.confirmation.msg" />
									</label></td>
								</c:when>
								<c:otherwise>
									<th style="width: 25%"><label><fmt:message
										key="assistantJunior.learning.license.no" />:</label></th>
									<td style="width: 25%">
									<label>${applicantPostAssoc.learningLicenseNo}
									</label></td>
								</c:otherwise>
							</c:choose>
						</c:if>	
					</tr>
					<c:if test="${ not empty applicantPostAssoc.learningLicense}">
						<c:if test="${ applicantPostAssoc.learningLicense eq true }">
							<tr>
								<th style="width: 25%"><label><fmt:message
										key="assistantJunior.learning.license.issue.date" />:</label></th>
								<td style="width: 25%">
									<label><tags:localDate pattern="dd/MM/yyyy"
										date="${applicantPostAssoc.learningLicenseIssueDate}" />
									</label>
								</td>
							</tr>
						</c:if>
					</c:if>
				</c:if> --%>
				
				<tr>
					<th style="width:25%">
						<label><fmt:message key="assistantJunior.apprenticeshipInMSRTC"/>:</label>
					</th>
					<td style="width:25%">
					<c:if test="${ not empty applicantPostAssoc.apprenticeshipInMSRTC}">
						<c:choose>
							<c:when
								test="${ applicantPostAssoc.apprenticeshipInMSRTC eq true }">
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
					
					<c:if test="${ applicantPostAssoc.apprenticeshipInMSRTC eq true }">
						<th style="width:25%">
						<label><fmt:message
								key="assistantJunior.trade" />:</label>
						</th>
						<td style="width:25%">
							<label>${applicantPostAssoc.apprenticeshipInMSRTCTrade}</label>
						</td>
					</c:if>
				
				</tr>
				
				<c:if test="${ applicantPostAssoc.apprenticeshipInMSRTC eq true }">
				<tr>
				<th style="width:25%">
					<label><fmt:message
							key="assistantJunior.apprenticeshipInMSRTC.year" />:</label>
				</th>
				<td style="width:25%">
					<label>${applicantPostAssoc.apprenticeshipInMSRTCYear}</label>
				</td>
				<th style="width:25%">
					<label><fmt:message
							key="assistantJunior.apprenticeshipInMSRTC.division" />:</label>
				</th>
				<td style="width:25%">
					<label>${applicantPostAssoc.apprenticeshipInMSRTCDivision}</label>
				</td>
				</tr>
			</c:if>
</table>
</form>
</div>