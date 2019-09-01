<%@ include file="../../../common/taglibs.jsp"%>

<div class="applied">
	<strong><fmt:message key="paymentResponse.postAppliedFor" />:
	</strong>
	<fmt:message key="post.draftsman.junior" />
</div>
<div class="postalinfo">
	<form class="form-horizontal">
		<div class="row">
			<div class="col-sm-4">
				<label><fmt:message
						key="draftsman.mechanic.junior.automobile.mechanical.degree" />:</label>

			</div>
			<div class="col-sm-2">
				<c:choose>
					<c:when
						test="${ applicantPostAssoc.automobileOrMechanicalEngDegree eq true }">
						<p>
							<fmt:message key="yes" />
						</p>
					</c:when>
					<c:otherwise>
						<p>
							<fmt:message key="no" />
						</p>
					</c:otherwise>
				</c:choose>
			</div>
			<c:choose>
				<c:when
					test="${ applicantPostAssoc.automobileOrMechanicalEngDegree eq true }">
					<div class="col-sm-4">
						<label><fmt:message
								key="store.supervisor.decgree.diploma.name" />:</label>
					</div>
					<div class="col-sm-2">

						<p>${applicantPostAssoc.degreeName}</p>

					</div>
				</c:when>
			</c:choose>
		</div>

		<div class="row">
			<div class="col-sm-4"></div>
			<div class="col-sm-2"></div>
			<c:choose>
				<c:when
					test="${ applicantPostAssoc.automobileOrMechanicalEngDegree eq true }">
					<div class="col-sm-4">
						<label><fmt:message key="manager.university.name" />:</label>
					</div>
					<div class="col-sm-2">

						<p>${applicantPostAssoc.universityName}</p>

					</div>
				</c:when>
			</c:choose>
		</div>

		<div class="row">
			<div class="col-sm-4">
				<label><fmt:message
						key="draftsman.mechanic.junior.diploma.autocad" />:</label>

			</div>
			<div class="col-sm-2">
				<c:choose>
					<c:when test="${ applicantPostAssoc.diplomaInAutocad eq true }">
						<p>
							<fmt:message key="yes" />
						</p>
					</c:when>
					<c:otherwise>
						<p>
							<fmt:message key="no" />
						</p>
					</c:otherwise>
				</c:choose>
			</div>
			<c:choose>
				<c:when test="${ applicantPostAssoc.diplomaInAutocad eq true }">
					<div class="col-sm-4">
						<label><fmt:message key="manager.university.name" />: </label>
					</div>
					<div class="col-sm-2">

						<p>${applicantPostAssoc.diplomaInAutocadUniversityName}</p>

					</div>
				</c:when>
			</c:choose>
		</div>

		<div class="row">
			<div class="col-sm-4">
				<label><fmt:message
						key="draftsman.mechanic.junior.autocad.certification.government.private" />:</label>

			</div>
			<div class="col-sm-2">
				<c:choose>
					<c:when
						test="${ applicantPostAssoc.autocadCertificationFromGovernment eq true }">
						<p>
							<fmt:message key="yes" />
						</p>
					</c:when>
					<c:otherwise>
						<p>
							<fmt:message key="no" />
						</p>
					</c:otherwise>
				</c:choose>
			</div>
			<c:choose>
				<c:when
					test="${ applicantPostAssoc.autocadCertificationFromGovernment eq true }">
					<div class="col-sm-4">
						<label><fmt:message
								key="draftsman.mechanic.junior.autocad.certification.institute.name" />:</label>
					</div>
					<div class="col-sm-2">

						<p>${applicantPostAssoc.autocadCertificationFromGovernmentInstituteName}</p>

					</div>
				</c:when>
			</c:choose>
		</div>

		<div class="row">
			<div class="col-sm-4">
				<label><fmt:message
						key="draftsman.mechanic.junior.experience.autocad" />:</label>
			</div>
			<div class="col-sm-2">
				<c:choose>
					<c:when test="${ applicantPostAssoc.experienceInAutocad eq true }">
						<p>
							<fmt:message key="yes" />
						</p>
					</c:when>
					<c:otherwise>
						<p>
							<fmt:message key="no" />
						</p>
					</c:otherwise>
				</c:choose>
			</div>
			<c:choose>
				<c:when test="${ applicantPostAssoc.experienceInAutocad eq true }">
					<div class="col-sm-4">
						<label><fmt:message key="driver.experienced.companyName" />:</label>
					</div>
					<div class="col-sm-2">
						<p>${applicantPostAssoc.companyName}</p>
					</div>
				</c:when>
			</c:choose>
		</div>

		<div class="row">
			<div class="col-sm-4"></div>
			<div class="col-sm-2"></div>
			<c:choose>
				<c:when test="${ applicantPostAssoc.experienceInAutocad eq true }">
					<div class="col-sm-4">
						<label><fmt:message
								key="clerkTypistJunior.experienced.inYears" />: </label>
					</div>
					<div class="col-sm-2">
						<p>${applicantPostAssoc.totalExperienceInYears}</p>
					</div>
				</c:when>
			</c:choose>
		</div>
		<div class="row">
			<div class="col-sm-4"></div>
			<div class="col-sm-2"></div>
			<c:choose>
				<c:when test="${ applicantPostAssoc.experienceInAutocad eq true }">
					<div class="col-sm-4">
						<label><fmt:message
								key="clerkTypistJunior.experienced.inMonths" />: </label>
					</div>
					<div class="col-sm-2">
						<p>${applicantPostAssoc.totalExperienceInMonths}</p>
					</div>
				</c:when>
			</c:choose>
		</div>
	</form>
</div>