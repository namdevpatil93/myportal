<%@ include file="../../../common/taglibs.jsp"%>
<%@ page contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>

<script>
	if ("${applicant.birthDate}" != "") {
		$('#birthDate')
				.datetimepicker(
						{
							format : 'DD/MM/YYYY',
							ignoreReadonly : true,
							showTodayButton : true,
							defaultDate : moment(),
							date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicant.birthDate}" />'
						});
		$('#birthDate').click(function() {
			$('#birthDate').data("DateTimePicker").show();
		});
	}
</script>
<form class="form-horizontal" name="personalInfoForm"
	id="personalInfoForm" data-toggle="validator"
	action="<c:url value='/applicant?operation=savePersonalInformation'/>"
	method="POST" novalidate>

	<div class="row readonlyinfo">
		<div class="col-sm-9" style="width:100%">
			<div class="row">
				<table style="width:100%; border:none;">
					<tr>
						<th style="">
							<label><fmt:message	key="applicant.applicationId" />:</label>
						</th>
						<td style="">
							<label>${ applicant.applicationId }</label>
						</td>
					</tr>
					<tr>
						<th style="width:25%"><label><fmt:message
									key="applicant.firstName" />:</label></th>
						<td style="width:25%"><label>${ applicant.firstName }</label>
						</td>
						<td style="width:25%"><label>${ applicant.firstNameMarathi }</label>
						</td>
						<td style="width:25%; border:none;"></label>
						</td>
					</tr>
					<tr>
						<th style=""><label><fmt:message
									key="applicant.middleName" />:</label></th>
						<td style=""><label>${ applicant.middleName }</label>
						</td>
						<td style=""><label>${ applicant.middleNameMarathi }</label>
						</td>
					</tr>
					<tr>
						<th style=""><label><fmt:message
									key="applicant.lastName" />:</label></th>
						<td style=""><label>${ applicant.lastName }</label>
						</td>
						<td style=""><label>${ applicant.lastNameMarathi }</label>
						</td>
					</tr>

					<tr>
						<th style=""><label><fmt:message
									key="applicant.birthDate" />:</label></th>
						<td style=""><label><tags:localDate
									pattern="dd/MM/yyyy" date="${applicant.birthDate}" /></label></td>
					</tr>
				</table>
			</div>
		</div>

		<%-- <div class="col-sm-3">
			<div class="row profilepic">
				<div class="col-sm-12">
					<img
						src="<c:url value='/file?operation=viewPhoto'/>&applicationId=${applicationId}&photo=${applicantFiles.photoFileName}"
						style="width: 100px;" />
				</div>
			</div>
			<div class="row signature">
				<div class="col-sm-12">
					<img
						src="<c:url value='/file?operation=viewSignature'/>&applicationId=${applicationId}&signature=${applicantFiles.signatureFileName}"
						style="width: 100px;" />
				</div>
			</div>
		</div> --%>
	</div>

	<!-- two -->
	<div class="row readonlyinfo">
		<table style="width: 100%">
			<tr>
				<th style="width: 25%"><label><fmt:message
							key="applicant.gender" />:</label></th>
				<td style="width: 25%"><c:if
						test="${not empty applicant.gender}">
						<c:choose>
							<c:when test="${applicant.gender eq 1}">
								<label> <fmt:message key="applicant.gender.male" />
								</label>
							</c:when>
							<c:otherwise>
								<label> <fmt:message key="applicant.gender.female" />
								</label>
							</c:otherwise>
						</c:choose>
					</c:if></td>
				<th style="width: 25%"><label><fmt:message
							key="applicant.address" />:</label></th>
				<td style="width: 25%"><label>${ applicant.address }</label></td>
			</tr>

			<tr>
				
				<th style="width: 25%"><label><fmt:message
							key="applicant.pinCode" />:</label></th>
				<td style="width: 25%"><label>${ applicant.pinCode }</label></td>
				<th style="width: 25%"><label><fmt:message
							key="applicant.highestQualification" />:</label></th>
				<td style="width: 25%"><label>
				
				<c:choose>
							<c:when test="${locale eq 'en' }">
								${qualification.title}
							</c:when>
							<c:otherwise>
								${qualification.titleInMarathi}
							</c:otherwise>	
				</c:choose>				
				</label>
				</td>
			</tr>
		
			<tr>
				<th style="width: 25%"><label><fmt:message
							key="applicant.emailAddress" />:</label></th>
				<td style="width: 25%"><label>${ applicant.emailAddress }</label>
				</td>
				<th style="width: 25%"><label><fmt:message
							key="applicant.mobileNumber" />:</label></th>
				<td style="width: 25%"><label>${ applicant.mobileNumber }</label>
				</td>
			</tr>

			<tr>
				<th style="width: 25%"><label><fmt:message
							key="applicant.list.district" />:</label></th>
				<td style="width: 25%"><c:forEach items="${districts}"
						var="district">
						<c:if test="${district.id eq applicant.districtId}">
							<label><fmt:message key="${ district.messageKey }" /></label>
						</c:if>
					</c:forEach></td>
				<th style="width: 25%"><label><fmt:message
							key="applicant.maritalStatus" />:</label></th>
				<td style="width: 25%"><c:if
						test="${ not empty applicant.maritalStatus}">
						<c:choose>
							<c:when test="${applicant.maritalStatus eq 1}">
								<label><fmt:message
										key="applicant.maritalStatus.married" /></label>
							</c:when>
							<c:otherwise>
								<label><fmt:message
										key="applicant.maritalStatus.unmarried" /></label>
							</c:otherwise>
						</c:choose>
					</c:if></td>
				
			</tr>

			<tr>
				<th style="width: 25%"><label><fmt:message
							key="applicant.maharashtraDomiciled" />:</label></th>
				<td style="width: 25%"><c:if
						test="${ not empty applicant.maharashtraDomiciled}">
						<c:choose>
							<c:when test="${applicant.maharashtraDomiciled eq true}">
								<label><fmt:message key="yes" /></label>
							</c:when>
							<c:otherwise>
								<label><fmt:message key="no" /></label>
							</c:otherwise>
						</c:choose>
					</c:if></td>
				<th style="width: 25%"><label><fmt:message
							key="applicant.readWriteSpeakMarathi" />:</label></th>
				<td style="width: 25%"><c:if
						test="${ not empty applicant.readWriteSpeakMarathi}">
						<c:choose>
							<c:when test="${applicant.readWriteSpeakMarathi eq true}">
								<label><fmt:message key="yes" /></label>
							</c:when>
							<c:otherwise>
								<label><fmt:message key="no" /></label>
							</c:otherwise>
						</c:choose>
					</c:if></td>
					
			
			
			</tr>

            <tr>
                <th style="width: 25%"><label><fmt:message
                            key="applicant.list.caste" />:</label></th>
                <td style="width: 25%"><c:forEach items="${castes}" var="caste">
                        <c:if test="${caste.id eq applicant.caste.id}">
                            <label><fmt:message key="${ caste.messageKey }" /></label>
                        </c:if>
                    </c:forEach></td>
                
                </tr>

			
				
				<c:choose>
				 <c:when test="${applicant.gender==0 && applicant.caste.id==1 && applicant.nonCreamyLayer == false}">
                     <th style="width: 25%">
                        <label><fmt:message key="applicant.allocated.category" />:</label>
                     </th>
                     <td style="width: 25%">
                        <c:forEach items="${castes}" var="caste">

						<c:if test="${caste.id eq applicant.allocatedCategory}">
						<label><fmt:message key="${ caste.messageKey }" /></label>
						</c:if>
					    
					    <c:if test="${applicant.allocatedCategory == null}">
                           <label><fmt:message key="caste.open" /></label>
						</c:if>
						</c:forEach>
                    </td>
                        
                    <th style="width: 25%">
                      <label><fmt:message key="divisionController.note" />:</label>
                    </th>
                    <td style="width: 25%">
						
				<label><fmt:message key="applicant.open.female.note" /></label>
					</td>
			
				</c:when>
					
				<c:when test="${applicant.caste.id==applicant.allocatedCategory && applicant.caste.id != 1 && applicant.caste.id != 3 && applicant.caste.id != 4}">
                       <th style="width: 25%">
                          <label><fmt:message key="applicant.allocated.category" />:</label>
                       </th>
                        <td style="width: 25%">
                            <label><fmt:message key="${ applicant.caste.messageKey }" /></label>
                        </td>
				</c:when>
					
				<c:when test="${applicant.caste.id != applicant.allocatedCategory && applicant.allocatedCategory==1 }">
                        <th style="width: 25%">
                            <label><fmt:message key="applicant.allocated.category" />:</label>
                        </th>
                        <td style="width: 25%">
                            <label><fmt:message key="caste.open" /></label>
                        </td>
                        <th style="width: 25%">
                        <label><fmt:message key="divisionController.note" />:</label>
                        </th>
                        <td style="width: 25%">

						<label><fmt:message key="applicant.nonCreamy.no" /></label>
				                        </td>
                </c:when>

				
				<c:otherwise>
                        <th style="width: 25%">
                            <label><fmt:message key="applicant.allocated.category" />:</label>
                        </th>
                        <td style="width: 25%">
                            <label><fmt:message key="${ applicant.caste.messageKey }" /></label>
                        </td>
              </c:otherwise>

		</c:choose>
				
			
				<tr>
				<c:if test="${ not empty applicant.subcategory }">
					<th style="width: 25%"><label><fmt:message
								key="applicant.subcategory" />:</label></th>
					<td style="width: 25%"><label>${ applicant.subcategory }</label>
					</td>
				</c:if>
				
				<!-- Add Here================ -->
				<th style="width: 25%"><label><fmt:message
								key="applicant.droughtAffected" />:</label></th>
				
				<td style="width: 25%"><c:choose>
							<c:when test="${applicant.droughtAffected eq true}">
								<label> <fmt:message key="yes" />
								</label>
							</c:when>
							<c:otherwise>
								<label> <fmt:message key="no" />
								</label>
							</c:otherwise>
						</c:choose></td>
			</tr>

			<tr>
				<c:if test="${ not empty applicant.nonCreamyLayer}">
					<th style="width: 25%"><label><fmt:message
								key="applicant.belongtocreamylayer" />:</label></th>
					<td style="width: 25%"><c:choose>
							<c:when test="${applicant.nonCreamyLayer eq true}">
								<label> <fmt:message key="yes" />
								</label>
							</c:when>
							<c:otherwise>
								<label> <fmt:message key="no" />
								</label>
							</c:otherwise>
						</c:choose></td>
				</c:if>
				<c:if
					test="${applicant.nonCreamyLayer eq true and not empty applicant.nonCreamyLayer}">
					<th style="width: 25%"><label><fmt:message
								key="applicant.certificatevalidity.endingdate" />:</label></th>
					<td style="width: 25%"><label><tags:localDate
								pattern="dd/MM/yyyy"
								date="${ applicant.certificateValidityEndingDate }" /></label></td>
				</c:if>
			</tr>
			<tr>
				<c:if
					test="${applicant.nonCreamyLayer eq true and not empty applicant.nonCreamyLayer}">
					<th style="width: 25%"><label><fmt:message
								key="applicant.certificate.number" />:</label></th>
					<td style="width: 25%"><label>${ applicant.certificateNumber }</label></td>
				</c:if>
			</tr>
			
			
			<tr>
				<c:if test="${ not empty applicant.isBelongToEws}">
					<th style="width: 25%"><label><fmt:message key="ews.belongto.advantage.message"/>:</label></th>
					<td style="width: 25%"><c:choose>
							<c:when test="${applicant.isBelongToEws eq true}">
								<label> <fmt:message key="yes" />
								</label>
							</c:when>
							<c:otherwise>
								<label> <fmt:message key="no" />
								</label>
							</c:otherwise>
						</c:choose></td>
				</c:if>
				<c:if
					test="${applicant.isBelongToEws eq true and not empty applicant.isBelongToEws}">
					<th style="width: 25%"><label><fmt:message
								key="applicant.certificate.number" />:</label></th>
					<td style="width: 25%"><label>${ applicant.ewsCertificateNumber }</label></td>
				</c:if>
			</tr>
			

		<tr>
			<th style="width: 25%"><label><fmt:message
							key="applicant.childOfFarmerWhoCommittedSuicide" />:</label></th>
			<td style="width: 25%"><c:if
						test="${ not empty applicant.childOfFarmerWhoCommittedSuicide}">
						<c:choose>
							<c:when test="${applicant.childOfFarmerWhoCommittedSuicide eq true}">
								<label><fmt:message key="yes" /></label>
							</c:when>
							<c:otherwise>
								<label><fmt:message key="no" /></label>
							</c:otherwise>
						</c:choose>
					</c:if></td>
		</tr>
		</table>
	</div>
</form>











