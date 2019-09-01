<%@ include file="../../common/taglibs.jsp"%>

<div class="registermain">
	<div class="registerwrap">
		<form class="form-horizontal" name="registerNewUserForm" id="registerNewUserForm" data-toggle="validator">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			
			<div id="printDiv">
				<div class="row form-group">
					<div class="col-xs-3"><fmt:message key="applicant.firstName"/>:</div>
					<div class="col-xs-3">&nbsp;</div>
					<div class="col-xs-3">${applicant.firstName}</div>
					<div class="col-xs-3">&nbsp;</div>
				</div>
				<div class="row form-group">
					<div class="col-xs-3"><fmt:message key="applicant.middleName"/>:</div>
					<div class="col-xs-3">&nbsp;</div>
					<div class="col-xs-3">${applicant.middleName}</div>
					<div class="col-xs-3">&nbsp;</div>
				</div>				
				<div class="row form-group">
					<div class="col-xs-3"><fmt:message key="applicant.lastName" />:</div>
					<div class="col-xs-3">&nbsp;</div>
					<div class="col-xs-3">${applicant.lastName}</div>
					<div class="col-xs-3">&nbsp;</div>
				</div>
				<div class="row form-group">
					<div class="col-xs-3"><fmt:message key="applicant.birthDate"/>:</div>
					<div class="col-xs-3">&nbsp;</div>
					<div class="col-xs-6">
						<tags:localDate pattern="dd/MM/yyyy" date="${applicant.birthDate}" /> <%-- &nbsp;&nbsp;&nbsp;&nbsp;<fmt:message key="applicant.applicantAge"/>: ${applicant.applicantAgeInYears} - <fmt:message key="applicant.applicantAgeInYears"/>
										&nbsp;&nbsp;&nbsp;${applicant.applicantAgeInMonths} - <fmt:message key="applicant.applicantAgeInMonths"/> &nbsp;&nbsp;&nbsp;${applicant.applicantAgeInDays} - <fmt:message key="applicant.applicantAgeInDays"/> --%>
					</div>
				</div>
				<div class="row form-group">
					<div class="col-xs-3"><fmt:message key="ageAsOnDateOfAdvertisement"/>:</div>
					<div class="col-xs-3">&nbsp;</div>
					<div class="col-xs-6">
						<em> ${ageAsOnGivenDate[0]} - <fmt:message key="applicant.applicantAgeInYears"/>
						&nbsp;${ageAsOnGivenDate[1]} - <fmt:message key="applicant.applicantAgeInMonths"/> &nbsp;${ageAsOnGivenDate[2]} - <fmt:message key="applicant.applicantAgeInDays"/></em>
					</div>
				</div>
				<div class="row form-group">
					<div class="col-xs-3"><fmt:message key="applicant.gender"/>:</div>
					<div class="col-xs-3">&nbsp;</div>
					<div class="col-xs-3">
					<c:if test="${not empty applicant.gender}">
						<c:choose>
							<c:when test="${applicant.gender == 1}">
								<fmt:message key="applicant.gender.male"/>
							</c:when>
							<c:otherwise>
								<fmt:message key="applicant.gender.female"/>
							</c:otherwise>
						</c:choose>
						</c:if>
					</div>
					<div class="col-xs-3">&nbsp;</div>
				</div>
				<div class="row form-group">
					<div class="col-xs-3"><fmt:message key="applicant.address"/>:</div>
					<div class="col-xs-3">&nbsp;</div>
					<div class="col-xs-3">${applicant.address}</div>
					<div class="col-xs-3">&nbsp;</div>
				</div>
				<div class="row form-group">
					<div class="col-xs-3"><fmt:message key="applicant.pinCode"/>:<fmt:message key="applicant.pin.sixdigits"/></div>
					<div class="col-xs-3">&nbsp;</div>
					<div class="col-xs-3">${applicant.pinCode}</div>
					<div class="col-xs-3">&nbsp;</div>
				</div>
				<div class="row form-group">
					<div class="col-xs-3"><fmt:message key="applicant.emailAddress"/>:</div>
					<div class="col-xs-3">&nbsp;</div>
					<div class="col-xs-3">${applicant.emailAddress}</div>
					<div class="col-xs-3">&nbsp;</div>
				</div>
				<div class="row form-group">
					<div class="col-xs-3"><fmt:message key="applicant.mobileNumber"/>:</div>
					<div class="col-xs-3">&nbsp;</div>
					<div class="col-xs-3">${applicant.mobileNumber}</div>
					<div class="col-xs-3">&nbsp;</div>
				</div>
				<div class="row form-group">
					<div class="col-xs-3"><fmt:message key="applicant.highestQualification"/>:</div>
					<div class="col-xs-3">&nbsp;</div>
					<div class="col-xs-3">
					<c:choose>
					<c:when test="${locale eq 'en' }">
								${qualification.title}
							</c:when>
							<c:otherwise>
								${qualification.titleInMarathi}
							</c:otherwise>	
					</c:choose>
					</div>
					<div class="col-xs-3">&nbsp;</div>
				</div>
			
				<div class="row form-group">
					<div class="col-xs-3"><fmt:message key="applicant.list.district"/>:</div>
					<div class="col-xs-3">&nbsp;</div>
					<div class="col-xs-3">
						<c:choose>
							<c:when test="${applicant.districtId eq null}">
									<%--N/A--%>
							</c:when>
							<c:otherwise>
										<fmt:message key="${district.messageKey}"/>
							</c:otherwise>
						</c:choose>	
					</div>
					<div class="col-xs-3">&nbsp;</div>
				</div>
				<div class="row form-group">
					<div class="col-xs-3"><fmt:message key="applicant.droughtAffected"/>:</div>
					<div class="col-xs-3">&nbsp;</div>
					<div class="col-xs-3">
					<c:if test="${ not empty applicant.droughtAffected}">
						<c:choose>
							<c:when test="${applicant.droughtAffected == true}">
								<fmt:message key="yes"/>
							</c:when>
							<c:otherwise>
								<fmt:message key="no"/>
							</c:otherwise>
						</c:choose>
						</c:if>
					</div>
					<div class="col-xs-3">&nbsp;</div>
				</div>
				
				<div class="row form-group">
					<div class="col-xs-3"><fmt:message key="applicant.maritalStatus"/>:</div>
					<div class="col-xs-3">&nbsp;</div>
					<div class="col-xs-3">
					<c:if test="${ not empty applicant.maritalStatus}">
						<c:choose>
							<c:when test="${applicant.maritalStatus == 1}">
								<fmt:message key="applicant.maritalStatus.married"/>
							</c:when>
							<c:otherwise>
								<fmt:message key="applicant.maritalStatus.unmarried"/>
							</c:otherwise>
						</c:choose>
						</c:if>
					</div>
					<div class="col-xs-3">&nbsp;</div>
				</div>
				<div class="row form-group">
					<div class="col-xs-3"><fmt:message key="applicant.maharashtraDomiciled"/>:</div>
					<div class="col-xs-3">&nbsp;</div>
					<div class="col-xs-3">
					<c:if test="${ not empty applicant.maharashtraDomiciled}">
						<c:choose>
							<c:when test="${applicant.maharashtraDomiciled == true}">
								<fmt:message key="yes"/>
							</c:when>
							<c:otherwise>
								<fmt:message key="no"/>
							</c:otherwise>
						</c:choose>
						</c:if>
					</div>
					<div class="col-xs-3">&nbsp;</div>
				</div>
				<div class="row form-group">
					<div class="col-xs-3"><fmt:message key="applicant.readWriteSpeakMarathi"/>:</div>
					<div class="col-xs-3">&nbsp;</div>
					<div class="col-xs-3">
					<c:if test="${ not empty applicant.readWriteSpeakMarathi}">
						<c:choose>
							<c:when test="${applicant.readWriteSpeakMarathi == true}">
								<fmt:message key="yes"/>
							</c:when>
							<c:otherwise>
								<fmt:message key="no"/>
							</c:otherwise>
						</c:choose>
						</c:if>
					</div>
					<div class="col-xs-3">&nbsp;</div>
				</div>
				
				<div class="row form-group">
					<div class="col-xs-3"><fmt:message key="applicant.list.caste"/>:</div>
					<div class="col-xs-3">&nbsp;</div>
					<div class="col-xs-3">
						<c:choose>
							<c:when test="${applicant.caste eq null}">
									<%--N/A	--%>
							</c:when>
							<c:otherwise>
										<fmt:message key="${applicant.caste.messageKey}"/>
							</c:otherwise>
						</c:choose>	
					</div>
					<div class="col-xs-3">&nbsp;</div>
				</div>
				<div class="row form-group">
					<div class="col-xs-3"><fmt:message key="applicant.childOfFarmerWhoCommittedSuicide"/>:</div>
					<div class="col-xs-3">&nbsp;</div>
					<div class="col-xs-3">
					<c:if test="${ not empty applicant.childOfFarmerWhoCommittedSuicide}">
						<c:choose>
							<c:when test="${applicant.childOfFarmerWhoCommittedSuicide == true}">
								<fmt:message key="yes"/>
							</c:when>
							<c:otherwise>
								<fmt:message key="no"/>
							</c:otherwise>
						</c:choose>
						</c:if>
					</div>
					<div class="col-xs-3">&nbsp;</div>
				</div>
				
				<c:if test="${not empty applicant.subcategory}">
					<div class="row form-group">
						<div class="col-xs-3">
							<fmt:message key="applicant.subcategory" />:
						</div>
						<div class="col-xs-3">&nbsp;</div>
						<div class="col-xs-3">${applicant.subcategory}</div>
						<div class="col-xs-3">&nbsp;</div>
					</div>
				</c:if>
				
				<c:if test="${ not empty applicant.nonCreamyLayer}">
				<div class="row form-group">
					<div class="col-xs-3"><fmt:message key="applicant.belongtocreamylayer"/>:</div>
					<div class="col-xs-3">&nbsp;</div>
					<div class="col-xs-3">
					<c:if test="${ not empty applicant.nonCreamyLayer}">
							<c:choose>
							<c:when test="${applicant.nonCreamyLayer == true}">
								<fmt:message key="yes"/>
							</c:when>
							<c:otherwise>
								<fmt:message key="no"/>
							</c:otherwise>
						</c:choose>
						</c:if>
					</div>
					<div class="col-xs-3">&nbsp;</div>
				</div>
				</c:if>
				
				<c:if test="${applicant.nonCreamyLayer == true and not empty applicant.certificateValidityEndingDate}">
					<div class="row form-group">
						<div class="col-xs-3">
							<fmt:message key="applicant.certificatevalidity.endingdate" />:
						</div>
						<div class="col-xs-3">&nbsp;</div>
						<div class="col-xs-3"><tags:localDate pattern="dd/MM/yyyy" date="${applicant.certificateValidityEndingDate}" /></div>
						<div class="col-xs-3">&nbsp;</div>
					</div>
				</c:if>
				<c:if test="${applicant.nonCreamyLayer == true and not empty applicant.certificateNumber}">
					<div class="row form-group">
						<div class="col-xs-3">
							<fmt:message key="applicant.certificate.number" />:
						</div>
						<div class="col-xs-3">&nbsp;</div>
						<div class="col-xs-3">${applicant.certificateNumber}</div>
						<div class="col-xs-3">&nbsp;</div>
					</div>
				</c:if>
			</div>
				<div class="row">
					<div class="form-group">
						<label class="control-label col-xs-4"></label>
						<div class="col-xs-8 text-right">
							<a class="fa fa-pencil-square-o fa-3x" aria-hidden="true" href="javascript:void(0);" onclick="javascript:commonObj.goToURL('<c:url value="/applicant?operation=apply&tabNo=1&&menu=applyMenu"/>')""></a>
							<a class="fa fa-print fa-3x" aria-hidden="true" href="javascript:void(0);" onclick="javascript:printContent('printDiv');"></a>
						</div>
					</div>
				</div>
		</form>
	</div>
</div>
<script type="text/javascript">
	function printContent(el){
		var restorepage = $('body').html();
		var printcontent = $('#' + el).clone();
		$('body').empty().html(printcontent);
		window.print();
		$('body').html(restorepage);
	}
</script>