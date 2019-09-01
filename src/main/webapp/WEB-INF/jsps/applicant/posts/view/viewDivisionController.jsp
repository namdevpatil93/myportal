<%@ include file="../../../common/taglibs.jsp"%>

<div class="applied">
	<div class="row">
		<div class="col-xs-8">
			<strong><fmt:message key="paymentResponse.postAppliedFor" />
				: </strong>
			<fmt:message key="post.division.controller" />
		</div>
		<%-- <div class="col-xs-4">
			<strong><fmt:message key="view.priority.label" /> : </strong>
			<fmt:message key="post.technical" />
			- ${applicantPostAssoc.priority eq 0 || applicantPostAssoc.priority eq null ? "" :applicantPostAssoc.priority}
		</div> --%>
	</div>
</div>

<form class="form-horizontal">
	<table style="width: 100%">
		<tr>
			<%-- <th style="width: 25%"><label><fmt:message
						key="divisionController.educationDetails" />:</label></th>
			<td style="width: 25%"><c:if
					test="${ not empty applicantPostAssoc.gradOrPostGrad}">
					<c:choose>
						<c:when test="${ applicantPostAssoc.gradOrPostGrad eq 1 }">
							<label> <fmt:message key="divisionController.graduate" />
							</label>
						</c:when>
						<c:when test="${ applicantPostAssoc.gradOrPostGrad eq 2 }">
							<label> <fmt:message key="divisionController.postGraduate" />
							</label>
						</c:when>
						<c:otherwise>
							<label> <fmt:message key="NA" />
							</label>
						</c:otherwise>
					</c:choose>
				</c:if></td> --%>
				
				<th style="width: 25%"><label><fmt:message
						key="divisionController.marks" /> % : </label></th>
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
		
		<tr>
			<th style="width: 25%"><label><fmt:message
						key="divisionController.degreeName" />: </label></th>
			<td style="width: 25%"><c:if
					test="${ not empty applicantPostAssoc.degreeName}">
					<label>${applicantPostAssoc.degreeName}</label>
				</c:if></td>
				
				<th style="width: 25%"><label><fmt:message
						key="divisionController.universityName" />: </label></th>
			<td style="width: 25%"><c:if
					test="${ not empty applicantPostAssoc.universityName}">
					<label>${applicantPostAssoc.universityName}</label>
				</c:if></td>
		</tr>
		
		<!-- PostGraduation -->
	<c:if test="${applicantPostAssoc.requiredQualificationMarks < 60 && applicantPostAssoc.requiredQualificationMarks >= 45 }">
		<tr>
			<th style="width: 25%"><label><fmt:message
						key="postgraddegree.label" />: </label></th>
			<td style="width: 25%"><c:if
					test="${ not empty applicantPostAssoc.postGradDegreeTypeId}">
					<c:choose>
						<c:when test="${ applicantPostAssoc.postGradDegreeTypeId eq 1 }">
							<label> <fmt:message key="postgraddegree.type1" />
							</label>
						</c:when>
						<c:when test="${ applicantPostAssoc.postGradDegreeTypeId eq 2}">
							<label> <fmt:message key="postgraddegree.type2" />
							</label>
						</c:when>
						<c:when test="${ applicantPostAssoc.postGradDegreeTypeId eq 3 }">
							<label> <fmt:message key="postgraddegree.type3" />
							</label>
						</c:when>
						<c:otherwise>
							<label> <fmt:message key="NA" />
							</label>
						</c:otherwise>
					</c:choose>
				</c:if>
				</td>
				
				<th style="width: 25%"><label><fmt:message
						key="postgraddegree.instituteName" />: </label></th>
			<td style="width: 25%"><c:if
					test="${ not empty applicantPostAssoc.postGradDegreeInstituteName}">
					<label>${applicantPostAssoc.postGradDegreeInstituteName}</label>
				</c:if></td>
		</tr>
		</c:if>
		
		<tr>
			<th style="width: 25%"><label><fmt:message
						key="divisionController.mscitOrGaccc" />: </label></th>
			<td style="width: 25%"><c:if
					test="${ not empty applicantPostAssoc.mscitOrGaccc}">
					<c:choose>
						<c:when
							test="${ applicantPostAssoc.mscitOrGaccc eq true }">
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
						key="divisionController.instituteName" />: </label></th>
			<td style="width: 25%"><c:if
					test="${ not empty applicantPostAssoc.instituteName}">
					<label>${applicantPostAssoc.instituteName}</label>
				</c:if></td>
				
		</tr>
		
		<tr>
			<th style="width: 25%"><label><fmt:message
						key="divisionController.workExp" />: </label></th>
			<td style="width: 25%"><c:if
					test="${ not empty applicantPostAssoc.workExp}">
					<c:choose>
						<c:when test="${ applicantPostAssoc.workExp eq 1 }">
							<label> <fmt:message key="divisionController.workExp.option1" />
							</label>
						</c:when>
						<c:when test="${ applicantPostAssoc.workExp eq 2 }">
							<label> <fmt:message key="divisionController.workExp.option2" />
							</label>
						</c:when>
						<c:when test="${ applicantPostAssoc.workExp eq 3 }">
							<label> <fmt:message key="divisionController.workExp.option3" />
							</label>
						</c:when>
						<c:when test="${ applicantPostAssoc.workExp eq 4 }">
							<label> <fmt:message key="divisionController.workExp.option4" />
							</label>
						</c:when>
						<c:otherwise>
							<label> <fmt:message key="NA" />
							</label>
						</c:otherwise>
					</c:choose>
				</c:if></td>
				<c:if test="${ applicantPostAssoc.workExp eq 1 || applicantPostAssoc.workExp eq 2 || applicantPostAssoc.workExp eq 3}">
				<th style="width: 25%"><label><fmt:message
						key="divisionController.organizationName" />: </label></th>
			<td style="width: 25%"><c:if
					test="${ not empty applicantPostAssoc.companyName}">
					<label>${applicantPostAssoc.companyName}</label>
				</c:if></td>
				</c:if>
		</tr>
		
		<c:if test="${ not empty applicantPostAssoc.workExp }">
		<c:choose>
			<c:when test="${ applicantPostAssoc.workExp eq 1 || applicantPostAssoc.workExp eq 2 || applicantPostAssoc.workExp eq 3}">
				<tr>
				<th style="width: 25%"><label><fmt:message
							key="divisionController.expInYears" />:</label></th>
				<td style="width: 25%"><c:if
						test="${ not empty applicantPostAssoc.workExp }">

						<label>${applicantPostAssoc.totalExperienceInYears}</label>
					</c:if></td>
				<th style="width: 25%"><label><fmt:message
							key="divisionController.expInMonths" />:</label></th>
				<td style="width: 25%"><c:if
						test="${ not empty applicantPostAssoc.workExp }">

						<label>${applicantPostAssoc.totalExperienceInMonths}</label>
					</c:if></td>
			</tr>
			</c:when>
			<c:when test="${ applicantPostAssoc.workExp eq 4}">
				<tr>
				<th style="width: 25%"><label><fmt:message
							key="divisionController.postName" />:</label></th>
				<td style="width: 25%"><c:if
						test="${ not empty applicantPostAssoc.workExp }">

						<label>${applicantPostAssoc.postName}</label>
					</c:if></td>
				<th style="width: 25%"><label><fmt:message
							key="divisionController.division" />:</label></th>
				<td style="width: 25%"><c:if
						test="${ not empty applicantPostAssoc.workExp }">

						<fmt:message key="${dcDivisionName}" />
					</c:if></td>
			</tr>
			</c:when>
		</c:choose>
		
		</c:if>
		
	</table>
</form>
