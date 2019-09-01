<%@ include file="../../../common/taglibs.jsp"%>

<div class="applied">
	<div class="row">
		<div class="col-xs-8">
			<strong><fmt:message key="paymentResponse.postAppliedFor" />
				:</strong>
			<fmt:message key="post.clerk.typist.junior" />
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
						key="clerkTypistJunior.graduateFromAffiliatedInstitute" />:</label></th>
			<td style="width: 25%"><c:if
					test="${ not empty applicantPostAssoc.graduateFromAffiliatedInstitute}">
					<c:choose>
						<c:when
							test="${ applicantPostAssoc.graduateFromAffiliatedInstitute eq true }">
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
						key="applicant.degreeName" />: </label></th>
			<td style="width: 25%"><c:if
					test="${ applicantPostAssoc.graduateFromAffiliatedInstitute eq true }">
					<label>${applicantPostAssoc.degreeName}</label>
				</c:if></td>
		</tr>
		<tr>
			<th style="width: 25%"><label><fmt:message
						key="applicant.universityName" />: </label></th>
			<td style="width: 25%"><c:if
					test="${ applicantPostAssoc.graduateFromAffiliatedInstitute eq true }">
					<label>${applicantPostAssoc.universityName}</label>
				</c:if></td>
				
			<%--  <th style="width: 25%"><label><fmt:message
						key="clerkTypistJunior.otherQualificationDetails" />: </label></th>
			<td style="width: 25%"><c:choose>
					<c:when
						test="${not empty applicantPostAssoc.otherQualificationDetails }">
						<label>${applicantPostAssoc.otherQualificationDetails}</label>
					</c:when>
					<c:otherwise>
						<label> <fmt:message key="NA" />
						</label>
					</c:otherwise>
				</c:choose></td>  --%>
		</tr>

		<tr>
			<th style="width: 25%"><label><fmt:message
						key="clerkTypistJunior.mscitOrDoeaccPassCertification" />: </label></th>
			<td style="width: 25%"><c:if
					test="${ not empty applicantPostAssoc.mscitOrDoeaccPassCertification}">
					<c:choose>
						<c:when
							test="${ applicantPostAssoc.mscitOrDoeaccPassCertification eq true }">
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
						key="clerkTypistJunior.typingExamPassed" />: </label></th>
				<td style="width: 25%"><c:if
					test="${ not empty applicantPostAssoc.typingExamPassed}">
					<c:choose>
						<c:when test="${ applicantPostAssoc.typingExamPassed eq true }">
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

		<tr>
			<th style="width: 25%"><label><fmt:message
						key="clerkTypistJunior.experienced" />: </label></th>
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
							key="clerkTypistJunior.experienced.companyName" />: </label></th>
				<td style="width: 25%"><c:if
						test="${ applicantPostAssoc.experienced eq true }">
						<label>${applicantPostAssoc.companyName}</label>
					</c:if></td>
			</c:if>
		</tr>

		<c:if test="${ applicantPostAssoc.experienced eq true }">
			<tr>
				<th style="width: 25%"><label><fmt:message
							key="clerkTypistJunior.experienced.inYears" />: </label></th>
				<td style="width: 25%"><c:if
						test="${ applicantPostAssoc.experienced eq true }">
						<label>${applicantPostAssoc.totalExperienceInYears}</label>
					</c:if></td>

				<th style="width: 25%"><label><fmt:message
							key="clerkTypistJunior.experienced.inMonths" />: </label></th>
				<td style="width: 25%"><c:if
						test="${ applicantPostAssoc.experienced eq true }">
						<label>${applicantPostAssoc.totalExperienceInMonths}</label>
					</c:if></td>
			</tr>
		</c:if>
		<%-- <div class="row">
			<div class="col-sm-4">
				<label><fmt:message key="clerkTypistJunior.nightBlindness" />:
				</label>
			</div>
			<div class="col-sm-2">
			<c:if test="${ not empty applicantPostAssoc.nightBlindness}">
				<c:choose>
					<c:when test="${ applicantPostAssoc.nightBlindness eq true }">
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
		</div>

		<div class="row">
			<div class="col-sm-4">
				<label><fmt:message key="clerkTypistJunior.colorBlindness" />:
				</label>
			</div>
			<div class="col-sm-2">
			<c:if test="${ not empty applicantPostAssoc.colorBlindness}">
				<c:choose>
					<c:when test="${ applicantPostAssoc.colorBlindness eq true }">
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
		</div>
 --%>
		<tr>
			<th style="width: 25%"><label><fmt:message
						key="clerkTypistJunior.differentlyAbled" />: </label></th>
			<td style="width: 25%"><c:if
					test="${ not empty applicantPostAssoc.differentlyAbled}">
					<c:choose>
						<c:when test="${ applicantPostAssoc.differentlyAbled eq true }">
							<label> <fmt:message key="yes" />
							</label>
						</c:when>
						<c:otherwise>
							<label> <fmt:message key="no" />
							</label>
						</c:otherwise>
					</c:choose>
				</c:if></td>
			<c:if test="${ applicantPostAssoc.differentlyAbled eq true }">
				<c:if test="${not empty applicantPostAssoc.blindnessAndLowVision }">
					<th style="width: 25%"><label
						for="clerkTypistJunior-differentlyAbled-blindnessAndLowVision"><fmt:message
								key="clerkTypistJunior.differentlyAbled.blindnessAndLowVision" /></label></th>
					<td style="width: 25%"><c:if
							test="${ applicantPostAssoc.blindnessAndLowVision eq true }">
							<label> <fmt:message key="yes" />
							</label>
						</c:if></td>
				</c:if>
			</c:if>
		</tr>
		<c:if test="${ applicantPostAssoc.differentlyAbled eq true }">
			<tr>
				<c:if test="${not empty applicantPostAssoc.deafAndMute }">
					<th style="width: 25%"><label
						for="clerkTypistJunior-differentlyAbled-deafAndMute"><fmt:message
								key="clerkTypistJunior.differentlyAbled.deafAndMute" /></label></th>
					<td style="width: 25%"><c:if
							test="${ applicantPostAssoc.deafAndMute eq true }">
							<label> <fmt:message key="yes" />
							</label>
						</c:if></td>
				</c:if>
				<c:if
					test="${not empty applicantPostAssoc.locomotorOrCerebralPalsy }">
					<th style="width: 25%"><label
						for="clerkTypistJunior-differentlyAbled-locomotorOrCerebralPalsy"><fmt:message
								key="clerkTypistJunior.differentlyAbled.locomotorOrCerebralPalsy" /></label></th>
					<td style="width: 25%"><c:if
							test="${ applicantPostAssoc.locomotorOrCerebralPalsy eq true }">
							<label> <fmt:message key="yes" />
							</label>
						</c:if></td>
				</c:if>
			</tr>
		</c:if>
		<%-- <c:if test="${ applicantPostAssoc.differentlyAbled eq true }">
			<tr>
				<c:if test="${applicantPostAssoc.differentlyAbledOthers eq true }">
					<th style="width: 25%"><label><fmt:message
								key="clerkTypistJunior.differentlyAbled.others" /></label></th>
					<td style="width: 25%"><c:if
							test="${ not empty applicantPostAssoc.differentlyAbledOthersText }">
							<label>	${applicantPostAssoc.differentlyAbledOthersText} </label>
						</c:if></td>
				</c:if>
			</tr>
		</c:if> --%>
		
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
		</div>
 --%>
	</table>
</form>
