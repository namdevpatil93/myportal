<%@ include file="../../../common/taglibs.jsp"%>

<div class="applied">
	<div class="row">
		<div class="col-xs-8">
			<strong><fmt:message key="paymentResponse.postAppliedFor" />
				:</strong>
			<fmt:message key="post.driver.conductor" />
		</div>
		<div class="col-xs-4">
			<strong><fmt:message key="applicant.division" /> : </strong>
			<c:choose>
				<c:when test='${divisionName eq null || divisionName eq ""}'>
					<fmt:message key="emptystring" />
				</c:when>
				<c:otherwise>
					<fmt:message key="${divisionName}" />
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>
<form class="form-horizontal">
	<table style="width: 100%">
		<tr>
			<th style="width: 25%"><label><fmt:message
						key="driver.educationSSCpass" />:</label></th>
			<td style="width: 25%"><c:if
					test="${ not empty applicantPostAssoc.sscPassed}">
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
				</c:if></td>
				
				<th style="width: 25%"><label><fmt:message
						key="driverCumConductor.required.qualification.marks.obtained" />: </label></th>
				<td style="width: 25%"><c:choose>
					<c:when
						test="${not empty applicantPostAssoc.requiredQualificationMarks }">
						<label>${applicantPostAssoc.requiredQualificationMarks}</label>
					</c:when>
					<c:otherwise>
						<label> <fmt:message key="NA" />
						</label>
					</c:otherwise>
				</c:choose></td>
		</tr>
		
		<%-- <tr>
				<th style="width: 25%"><label><fmt:message
						key="driver.otherQualification" />: </label></th>
				<td style="width: 25%"><c:choose>
					<c:when
						test="${not empty postOtherQualification }">
						<label>${postOtherQualification}</label>
					</c:when>
					<c:otherwise>
						<label> <fmt:message key="NA" />
						</label>
					</c:otherwise>
				</c:choose></td>
				
		</tr> --%>
		
		<tr>
			<th style="width: 25%"><label><fmt:message
						key="driver.nightBlindness" />:</label></th>
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
						key="driver.colorBlindness" />:</label></th>
				<td style="width: 25%">
					<c:if test="${ not empty applicantPostAssoc.colorBlindness}">
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
					</c:if>
				</td>
		</tr>

		<tr>
				<th style="width: 25%"><label><fmt:message
						key="driver.visionAcuity" />:</label></th>
				<td style="width: 25%">
					<c:if test="${ not empty applicantPostAssoc.visionAcuity}">
						<c:choose>
							<c:when test="${ applicantPostAssoc.visionAcuity eq true }">
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
		<!-- ============================================================= -->
		<c:if test="${applicant.gender eq 0}">
		<tr>
			<th style="width: 25%"><label><fmt:message
						key="assistantJunior.light.motor.vehicle" />:</label>
				</th>
				<td style="width: 25%">
					<c:if test="${ not empty applicantPostAssoc.lightMotorVechicle}">
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
		
			<c:if
				test="${ applicantPostAssoc.lightMotorVechicle eq true }">
				<th style="width: 25%"><label><fmt:message
							key="assistantJunior.light.motor.vehicle.license.no" />:</label></th>
				<td style="width: 25%"><c:if
						test="${ applicantPostAssoc.lightMotorVechicle eq true }">
						<label>${applicantPostAssoc.lightMotorVechicleLicenseNo}</label>
					</c:if></td>
					
					
			</c:if>
		</tr>
		<tr>
			
			<c:if
				test="${ applicantPostAssoc.lightMotorVechicle eq true }">
				<th style="width: 25%"><label><fmt:message
							key="assistantJunior.light.motor.vehicle.license.issue.date" />:</label></th>
				<td style="width: 25%">
						<label>${applicantPostAssoc.lightMotorVechicleIssueDate}</label>
					</td>
			</c:if>
			
		</tr>
		</c:if>
	<!-- ================================================================= -->	
		<tr>
			<th style="width: 25%"><label><fmt:message
						key="driver.ownHeavyDrivingLicenseNo" />:</label>
				</th>
				<td style="width: 25%">
					<c:if test="${ not empty applicantPostAssoc.ownHeavyDrivingLicenseNumber}">
						<c:choose>
							<c:when
								test="${ applicantPostAssoc.ownHeavyDrivingLicenseNumber eq true }">
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
		
			<c:if
				test="${ applicantPostAssoc.ownHeavyDrivingLicenseNumber eq true }">
				<th style="width: 25%"><label><fmt:message
							key="driver.ownHeavyDrivingLicenseNo.number" />:</label></th>
				<td style="width: 25%"><c:if
						test="${ applicantPostAssoc.ownHeavyDrivingLicenseNumber eq true }">
						<label>${applicantPostAssoc.heavyDrivingLicenseNumber}</label>
					</c:if></td>
			</c:if>
		</tr>

		<c:if test="${ applicantPostAssoc.ownHeavyDrivingLicenseNumber eq true }">
			<tr>
				<th style="width: 25%"><label><fmt:message
							key="driver.ownHeavyDrivingLicenseNo.issueDate" />:</label></th>
				<td style="width: 25%"><c:if
						test="${ applicantPostAssoc.ownHeavyDrivingLicenseNumber eq true }">

						<label> <tags:localDate pattern="dd/MM/yyyy"
								date="${applicantPostAssoc.heavyDrivingLicenseIssueDate}" />
						</label>
					</c:if></td>

				<th style="width: 25%"><label><fmt:message
							key="driver.ownHeavyDrivingLicenseNo.endDate" />:</label></th>
				<td style="width: 25%"><c:if
						test="${ applicantPostAssoc.ownHeavyDrivingLicenseNumber eq true }">

						<label> <tags:localDate pattern="dd/MM/yyyy"
								date="${applicantPostAssoc.heavyDrivingLicenseEndDate}" />
						</label>
					</c:if></td>
			</tr>
		</c:if>

		<tr>
			<th style="width: 25%"><label><fmt:message
						key="driver.ownPsvBadgeNo" />:</label></th>
			<td style="width: 25%"><c:if
					test="${ not empty applicantPostAssoc.ownPsvBatchNumber}">
					<c:choose>
						<c:when test="${ applicantPostAssoc.ownPsvBatchNumber eq true }">
							<label> <fmt:message key="yes" />
							</label>
						</c:when>
						<c:otherwise>
							<label> <fmt:message key="no" />
							</label>
						</c:otherwise>
					</c:choose>
				</c:if></td>
			<c:if test="${ applicantPostAssoc.ownPsvBatchNumber eq true }">
				<th style="width: 25%"><label><fmt:message
							key="driver.psvBadgeNo" />:</label></th>
				<td style="width: 25%"><c:if
						test="${ applicantPostAssoc.ownPsvBatchNumber eq true }">
						<label>${applicantPostAssoc.psvBatchNumber}</label>
					</c:if></td>
			</c:if>
		</tr>

		<tr>
			<th style="width: 25%"><label><fmt:message
						key="driver.ownConductorbatchNo" />: </label></th>
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

			<c:if
				test="${ not empty applicantPostAssoc.ownConductorBatchNumber }">
				<th style="width: 25%"><c:if
						test="${(applicantPostAssoc.ownConductorBatchNumber eq true and  not empty applicantPostAssoc.conductorBatchNumber) or  applicantPostAssoc.ownConductorBatchNumber eq false}">
						<label><fmt:message
								key="driver.ownConductorbatchNo.number" />:</label>
					</c:if></th>
				<td style="width: 25%"><c:if
						test="${ not empty applicantPostAssoc.ownConductorBatchNumber}">
						<c:choose>
							<c:when
								test="${ applicantPostAssoc.ownConductorBatchNumber eq true }">

								<label>${applicantPostAssoc.conductorBatchNumber}</label>
							</c:when>
							<c:otherwise>
								<fmt:message key="conductorbatch.no.agree.to.submit.later.note" />
							</c:otherwise>
						</c:choose>
					</c:if></td>
			</c:if>
		</tr>
		<c:if test="${ not empty applicantPostAssoc.ownConductorBatchNumber }">
			<tr>
				<c:if
					test="${ not empty applicantPostAssoc.conductorBatchNumberIssueDate }">
					<th style="width: 25%"><label><fmt:message
								key="driver.ownConductorbatchNo.issueDate" />:</label></th>
					<td style="width: 25%"><c:if
							test="${ applicantPostAssoc.ownConductorBatchNumber eq true }">
							<label> <tags:localDate pattern="dd/MM/yyyy"
									date="${applicantPostAssoc.conductorBatchNumberIssueDate}" />
							</label>
						</c:if></td>
				</c:if>
				<c:if
					test="${ not empty applicantPostAssoc.conductorBatchNumberEndDate }">
					<th style="width: 25%"><label><fmt:message
								key="driver.ownConductorbatchNo.endDate" />:</label></th>
					<td style="width: 25%"><c:if
							test="${ applicantPostAssoc.ownConductorBatchNumber eq true }">

							<label> <tags:localDate pattern="dd/MM/yyyy"
									date="${applicantPostAssoc.conductorBatchNumberEndDate}" />
							</label>
						</c:if></td>
				</c:if>
			</tr>
		</c:if>
		<tr>
		<c:choose>
						<c:when test="${applicantPostAssoc.ownHeavyDrivingLicenseNumber eq true}">
							<th style="width: 25%"><label><fmt:message key="driver.experienced" />:</label></th>
						</c:when>
						<c:otherwise>
							<th style="width: 25%"><label><fmt:message key="driver.experienced.female" />:</label></th>
						</c:otherwise>
		</c:choose>
			<td style="width: 25%"><c:if
					test="${ not empty applicantPostAssoc.experienced}">
					<c:choose>
						<c:when test="${ applicantPostAssoc.experienced eq true }">
							<label> <fmt:message key="yes" />
							</label>
						</c:when>
						<c:otherwise>
							<label> <fmt:message key="no" />
							</label>
						</c:otherwise>
					</c:choose>
				</c:if></td>
			<c:if test="${ applicantPostAssoc.experienced eq true }">
				<th style="width: 25%"><label><fmt:message
							key="driver.experienced.companyName" />:</label></th>
				<td style="width: 25%"><c:if
						test="${ applicantPostAssoc.experienced eq true }">
						<label>${applicantPostAssoc.companyName}</label>
					</c:if></td>
			</c:if>
		</tr>
		<c:if test="${ applicantPostAssoc.experienced eq true }">
			<tr>
				<th style="width: 25%"><label><fmt:message
							key="accountantJunior.experienced.inYears" />:</label></th>
				<td style="width: 25%"><c:if
						test="${ applicantPostAssoc.experienced eq true }">

						<label>${applicantPostAssoc.totalExperienceInYears}</label>
					</c:if></td>
				<th style="width: 25%"><label><fmt:message
							key="accountantJunior.experienced.inMonths" />:</label></th>
				<td style="width: 25%"><c:if
						test="${ applicantPostAssoc.experienced eq true }">

						<label>${applicantPostAssoc.totalExperienceInMonths}</label>
					</c:if></td>
			</tr>
		</c:if>
	<%-- 	<tr>
			<th style="width: 25%"><label><fmt:message
						key="driver.experienced.upload" />:</label></th>
			<td style="width: 25%"><c:if
					test="${ applicantPostAssoc.experienced eq true }">

					<label>${applicantPostAssoc.experienceLetterUpload}</label>
				</c:if></td>
		</tr> --%>

		<tr>
			<th style="width: 25%">
				<label><fmt:message	key="conductor.guarantorPersonNameAndMobileNo" />:</label>
			</th>
			<td style="width: 25%">
			 	<c:if test="${ not empty applicantPostAssoc.guarantorPersonNameAndMobileNo}">
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
			<th style="width: 25%">
				<label><fmt:message	key="guarantorPersonNameAndMobileNo.guarantorPersonName" />:</label>
			</th>
			<td style="width: 25%">
				<c:if test="${ not empty applicantPostAssoc.guarantorPersonName }">
					<label>${applicantPostAssoc.guarantorPersonName}</label>
				</c:if>
			</td>
		</c:if>
		</tr>

		<tr>
			<c:if test="${ not empty applicantPostAssoc.guarantorPersonNameAndMobileNo}">
				<th style="width: 25%">
					<label><fmt:message key="guarantorPersonNameAndMobileNo.guarantorPersonMobileNumber" />:</label>
				</th>
				<td style="width: 25%">
					<c:if test="${ not empty applicantPostAssoc.guarantorPersonMobileNumber }">
						<label>${applicantPostAssoc.guarantorPersonMobileNumber}</label>
					</c:if>
				</td>
			</c:if>
		</tr>

		<tr>
		<c:choose>
			<c:when test="${applicant.gender eq 1}">
				<th style="width: 25%"><label><fmt:message
						key="driver.height" />:</label></th>
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
				</c:if>
			</td>
			</c:when>
			<c:otherwise>
				<th style="width: 25%"><label><fmt:message
						key="driver.height.female" />:</label></th>
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
				</c:if>
			</td>
			</c:otherwise>
		</c:choose>
			
			
			<th style="width: 25%">
				 <label><fmt:message key="driver.pastAccidentalDeathIncident"/>: </label>
			</th>
			
			<td style="width: 25%">
				<c:choose>
					<c:when test="${ applicantPostAssoc.pastAccidentalOrDeathIncident eq true }">
						<label> <fmt:message key="yes" /></label>
					</c:when>
					<c:otherwise>
						<label> <fmt:message key="no" /></label>
					</c:otherwise>
				</c:choose>
			</td> 
		</tr>
		


		<%-- <div class="row">
			<div class="col-sm-4">
				<label><fmt:message key="applicant.division" />:</label>
			</div>
			<c:choose>
				<c:when test="${ not empty divisionName }">
					<div class="col-sm-2">
						<label><fmt:message key="${divisionName }"/></label>
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
	<br>
	<div align="center" class="form-group"><label class="control-label col-sm-15" > <Strong style="color: red"><fmt:message key="divisionController.note"/> : </Strong><fmt:message key="driverCumConductor.Special.Note"/> </label></div>
</form>
