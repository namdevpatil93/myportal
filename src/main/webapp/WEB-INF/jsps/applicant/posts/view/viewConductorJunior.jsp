<%@ include file="../../../common/taglibs.jsp"%>

<div class="applied">
	<div class="row">
		<div class="col-xs-8">
			<strong><fmt:message key="paymentResponse.postAppliedFor" />
				:</strong>
			<fmt:message key="post.conductor.junior" />
		</div>
		<div class="col-xs-4">
			<strong><fmt:message key="applicant.division" /> : </strong>
			<c:choose>
				<c:when test='${divisionName eq null || divisionName eq ""}'>
					<fmt:message key="emptystring" />
				</c:when>
				<c:otherwise>
					<fmt:message key="${divisionName }" />
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>
<form class="form-horizontal">
	<table style="width: 100%">
		<tr>
			<th style="width: 25%"><label><fmt:message
						key="conductor.educationQualification" />:</label></th>
			<td style="width: 25%">
				<c:if test="${ not empty applicantPostAssoc.sscPassed}">
					<c:choose>
						<c:when test="${ applicantPostAssoc.sscPassed eq true }">
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
				
			<th style="width: 25%"><label><fmt:message
					key="conductor.otherQualificationDetails" />:</label></th>
			<td style="width: 25%">
				<c:choose>
					<c:when	test="${not empty applicantPostAssoc.otherQualificationDetails }">
						<label>${applicantPostAssoc.otherQualificationDetails}</label>
					</c:when>
					<c:otherwise>
						<label> <fmt:message key="NA" />
						</label>
					</c:otherwise>
				</c:choose>
			</td>
		</tr>

		<tr>
			<th style="width: 25%"><label><fmt:message
						key="conductor.nightBlindness" />:</label></th>
			<td style="width: 25%"><c:if
					test="${ not empty applicantPostAssoc.nightBlindness}">
					<c:choose>
						<c:when test="${ applicantPostAssoc.nightBlindness eq true }">
							<label> <fmt:message key="yes" />
							</label>
						</c:when>
						<c:otherwise>
							<label> <fmt:message key="no" />
							</label>
						</c:otherwise>
					</c:choose>
				</c:if></td>
				
				<th style="width: 25%"><label><fmt:message
						key="conductor.colorBlindness" />:</label></th>
				<td style="width: 25%"><c:if
					test="${ not empty applicantPostAssoc.colorBlindness}">
					<c:choose>
						<c:when test="${ applicantPostAssoc.colorBlindness eq true }">
							<label> <fmt:message key="yes" />
							</label>
						</c:when>
						<c:otherwise>
							<label> <fmt:message key="no" />
							</label>
						</c:otherwise>
					</c:choose>
				</c:if></td>
		</tr>

		
		<%-- <div class="row">
			<div class="col-sm-4">
				<label><fmt:message key="conductor.differentlyAbled" />:</label>
			</div>
			<div class="col-sm-2">
			<c:if test="${ not empty applicantPostAssoc.differentlyAbled}">
				<c:choose>
					<c:when test="${ applicantPostAssoc.differentlyAbled eq true }">
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
			</div>
			<c:choose>
				<c:when
					test="${ not empty applicantPostAssoc.blindnessAndLowVision }">
					<div class="col-sm-4">
						<label><fmt:message
								key="conductor.differentlyAbled.blindnessAndLowVision" /></label>
					</div>
					<div class="col-sm-2">
						<label>${applicantPostAssoc.blindnessAndLowVision}</label>
					</div>
				</c:when>
			</c:choose>
		</div>

		<div class="row">
			<div class="col-sm-4"></div>
			<div class="col-sm-2"></div>
			<c:choose>
				<c:when test="${ not empty applicantPostAssoc.deafAndMute }">
					<div class="col-sm-4">
						<label><fmt:message
								key="conductor.differentlyAbled.deafAndMute" /></label>
					</div>
					<div class="col-sm-2">
						<label>${applicantPostAssoc.deafAndMute}</label>
					</div>
				</c:when>
			</c:choose>
		</div>

		<div class="row">
			<div class="col-sm-4"></div>
			<div class="col-sm-2"></div>
			<c:choose>
				<c:when
					test="${ not empty applicantPostAssoc.locomotorOrCerebralPalsy }">
					<div class="col-sm-4">
						<label><fmt:message
								key="conductor.differentlyAbled.locomotorOrCerebralPalsy" /></label>
					</div>
					<div class="col-sm-2">
						<label>${applicantPostAssoc.locomotorOrCerebralPalsy}</label>
					</div>
				</c:when>
			</c:choose>
		</div> --%>

		<tr>
			<th style="width: 25%"><label><fmt:message
						key="conductor.ownConductorBatchNumber" />:</label></th>
			<td style="width: 25%"><c:if
					test="${ not empty applicantPostAssoc.ownConductorBatchNumber}">
					<c:choose>
						<c:when
							test="${ applicantPostAssoc.ownConductorBatchNumber eq true }">
							<label> <fmt:message key="yes" />
							</label>
						</c:when>
						<c:otherwise>
							<label> <fmt:message key="no" />
							</label>
						</c:otherwise>
					</c:choose>
				</c:if></td>
				
			<c:if test="${ not empty applicantPostAssoc.ownConductorBatchNumber}">	
				<th style="width: 25%"><label><fmt:message
							key="conductor.ownConductorBatchNumber.conductorBatchNumber" />:</label></th>
				<td style="width: 25%"><c:if
						test="${ not empty applicantPostAssoc.conductorBatchNumber }">
						<label>${applicantPostAssoc.conductorBatchNumber}</label>
					</c:if></td>
			</c:if>
		</tr>

		<tr>
			<c:if test="${ not empty applicantPostAssoc.ownConductorBatchNumber}">	
				<th style="width: 25%"><label><fmt:message
							key="conductor.ownConductorBatchNumber.issueDate" />:</label></th>
				<td style="width: 25%"><c:if
						test="${ not empty applicantPostAssoc.conductorBatchNumberIssueDate }">
						<label><tags:localDate pattern="dd/MM/yyyy"
								date="${applicantPostAssoc.conductorBatchNumberIssueDate}" /></label>
					</c:if></td>
				<th style="width: 25%"><label><fmt:message
							key="conductor.ownConductorBatchNumber.endDate" />:</label></th>
				<td style="width: 25%"><c:if
						test="${ not empty applicantPostAssoc.conductorBatchNumberEndDate }">
						<label><tags:localDate pattern="dd/MM/yyyy"
								date="${applicantPostAssoc.conductorBatchNumberEndDate}" /></label>
					</c:if></td>
			</c:if>
		</tr>
		<tr>
			<th style="width: 25%"><label><fmt:message
						key="conductor.light.motor.vehicle" />:</label></th>
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
							key="conductor.light.motor.vehicle.license.no" />:</label></th>
						<td style="width: 25%">
						<label> <fmt:message key="conductor.light.motor.vehicle.confirmation.msg" />
						</label></td>
					</c:when>
					<c:otherwise>
						<th style="width: 25%"><label><fmt:message
							key="conductor.light.motor.vehicle.license.no" />:</label></th>
						<td style="width: 25%">
						<label>${applicantPostAssoc.lightMotorVechicleLicenseNo}
						</label></td>
					</c:otherwise>
				</c:choose>
			</c:if>	
		</tr>
		
		<c:if test="${ not empty applicantPostAssoc.lightMotorVechicle}">
			<c:if test="${ applicantPostAssoc.lightMotorVechicle eq true }">
				<tr>
					<th style="width: 25%"><label><fmt:message
							key="conductor.light.motor.vehicle.license.issue.date" />:</label></th>
					<td style="width: 25%">
						<label><tags:localDate pattern="dd/MM/yyyy"
							date="${applicantPostAssoc.lightMotorVechicleIssueDate}" />
						</label>
					</td>
				</tr>
			</c:if>
		</c:if>
		
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
							<label> <fmt:message key="conductor.learning.license.confirmation.msg" />
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
			<th style="width: 25%"><label><fmt:message
						key="conductor.guarantorPersonNameAndMobileNo" />:</label></th>
			<td style="width: 25%"><c:if
					test="${ not empty applicantPostAssoc.guarantorPersonNameAndMobileNo}">
					<c:choose>
						<c:when
							test="${ applicantPostAssoc.guarantorPersonNameAndMobileNo eq true }">
							<label> <fmt:message key="yes" />
							</label>
						</c:when>
						<c:otherwise>
							<label> <fmt:message key="no" />
							</label>
						</c:otherwise>
					</c:choose>
				</c:if></td>

		<c:if test="${ not empty applicantPostAssoc.guarantorPersonNameAndMobileNo}">
			<th style="width: 25%"><label><fmt:message
						key="guarantorPersonNameAndMobileNo.guarantorPersonName" />:</label></th>
			<td style="width: 25%"><c:if
					test="${ not empty applicantPostAssoc.guarantorPersonName }">
					<label>${applicantPostAssoc.guarantorPersonName}</label>
				</c:if></td>
		</c:if>
		</tr>

		<tr>
			<c:if test="${ not empty applicantPostAssoc.guarantorPersonNameAndMobileNo}">
			<th style="width: 25%"><label><fmt:message
						key="guarantorPersonNameAndMobileNo.guarantorPersonMobileNumber" />:</label></th>
			<td style="width: 25%"><c:if
					test="${ not empty applicantPostAssoc.guarantorPersonMobileNumber }">
					<label>${applicantPostAssoc.guarantorPersonMobileNumber}</label>
				</c:if></td>
			</c:if>
			<th style="width: 25%"><label><fmt:message
						key="conductor.heightWithinRange" />:</label></th>
			<td style="width: 25%"><c:if
					test="${ not empty applicantPostAssoc.heightWithinRange}">
					<c:choose>
						<c:when test="${ applicantPostAssoc.heightWithinRange eq true }">
							<label> <fmt:message key="yes" />
							</label>
						</c:when>
						<c:otherwise>
							<label> <fmt:message key="no" />
							</label>
						</c:otherwise>
					</c:choose>
				</c:if></td>
		</tr>

		<%-- <div class="row">
			<div class="col-sm-4">
				<label><fmt:message key="applicant.division" />:</label>
			</div>
			<c:choose>
				<c:when test="${ not empty divisionName }">
					<div class="col-sm-2">
						<label>${divisionName}</label>
					</div>
				</c:when>
				<c:otherwise>
					<div class="col-sm-2">
						<label>
							<fmt:message key="NA" />
						</label>
					</div>
				</c:otherwise>
			</c:choose>
		</div> --%>
	</table>
</form>