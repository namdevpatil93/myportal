<%@ include file="../../common/taglibs.jsp"%>
<div class="registermain">
	<div class="registerwrap">
		<form class="form-horizontal" name="applicantOtherInformationForm"
			id="applicantOtherInformationForm" data-toggle="validator">
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" /> <input type="hidden" name="id"
				value="${applicant.id}" />
			<div id="otherInformationDiv">
				<div class="row form-group">
					<div class="col-xs-3">
						<fmt:message key="applicant.projectEffected" />
						:
					</div>
					<div class="col-xs-3">&nbsp;</div>
					<div class="col-xs-3">
						<c:if test="${ not empty applicantOtherinfo.projectEffected}">
							<c:choose>
								<c:when test="${applicantOtherinfo.projectEffected == true }">
									<fmt:message key="yes" />
								</c:when>
								<c:otherwise>
									<fmt:message key="no" />
								</c:otherwise>
							</c:choose>
						</c:if>
					</div>
					<div class="col-xs-3">&nbsp;</div>
				</div> 

				<div class="row form-group">
					<div class="col-xs-3">
						<fmt:message key="applicant.earthQuakeEffected" />
						:
					</div>
					<div class="col-xs-3">&nbsp;</div>
					<div class="col-xs-3">
						<c:if test="${ not empty applicantOtherinfo.earthQuakeEffected}">
							<c:choose>
								<c:when test="${applicantOtherinfo.earthQuakeEffected == true }">
									<fmt:message key="yes" />
								</c:when>
								<c:otherwise>
									<fmt:message key="no" />
								</c:otherwise>
							</c:choose>
						</c:if>
					</div>
					<div class="col-xs-3">&nbsp;</div>
				</div> 

				<div class="row form-group">
					<div class="col-xs-3">
						<fmt:message key="applicant.exServiceMan" />
						:
					</div>
					<div class="col-xs-3">&nbsp;</div>
					<div class="col-xs-3">
						<c:if test="${ not empty applicantOtherinfo.exServiceMan}">
							<c:choose>
								<c:when test="${applicantOtherinfo.exServiceMan == true }">
									<fmt:message key="yes" />
								</c:when>
								<c:otherwise>
									<fmt:message key="no" />
								</c:otherwise>
							</c:choose>
						</c:if>
					</div>
					<div class="col-xs-3">&nbsp;</div>
				</div>
				<c:if test="${applicantOtherinfo.exServiceMan}">
					<div class="row form-group">
						<div class="col-xs-3">
							<fmt:message key="otherInfo.totalServicePeriod" />
							:
						</div>
						<div class="col-xs-3"></div>
						<c:if test="${ not empty applicantOtherinfo.exServiceMan}">
							<c:choose>
								<c:when test="${applicantOtherinfo.exServiceMan }">
									<div class="col-xs-3">
										${applicantOtherinfo.exServicemanTotalExperienceInYears} -
										<fmt:message key="applicant.applicantBithOfYears" />
										&nbsp;&nbsp;&nbsp;${applicantOtherinfo.exServicemanTotalExperienceInMonths}
										-
										<fmt:message key="applicant.applicantAgeInMonths" />
									</div>
								</c:when>
								<c:otherwise>
									<fmt:message key="no" />
								</c:otherwise>
							</c:choose>
						</c:if>

						<div class="col-xs-3">&nbsp;</div>
					</div>
				</c:if>
				<div class="row form-group">
					<div class="col-xs-6">
						<fmt:message key="applicant.partTimeEmployee" />
						:
					</div>
					<div class="col-xs-3">
						<c:if test="${ not empty applicantOtherinfo.partTimeEmployee}">
							<c:choose>
								<c:when test="${applicantOtherinfo.partTimeEmployee == true }">
									<fmt:message key="yes" />
								</c:when>
								<c:otherwise>
									<fmt:message key="no" />
								</c:otherwise>
							</c:choose>
						</c:if>
					</div>
					<div class="col-xs-3">&nbsp;</div>
				</div>
				<c:if test="${applicantOtherinfo.partTimeEmployee}">
					<div class="row form-group">
						<div class="col-xs-3">
							<fmt:message key="trafficInspector.experienced.totalExperience" />
							:
						</div>
						<div class="col-xs-3">&nbsp;</div>
						<div class="col-xs-3">
							<c:if test="${ not empty applicantOtherinfo.partTimeEmployee}">
								<c:choose>
									<c:when test="${applicantOtherinfo.partTimeEmployee == true }">
								${applicantOtherinfo.partTimeEmployeeTotalExperienceInYears} - <fmt:message
											key="applicant.applicantBithOfYears" />
											&nbsp;&nbsp;&nbsp;${applicantOtherinfo.partTimeEmployeeTotalExperienceInMonths} - <fmt:message
											key="applicant.applicantAgeInMonths" />
									</c:when>
									<c:otherwise>
										<fmt:message key="no" />
									</c:otherwise>
								</c:choose>
							</c:if>
						</div>
						<div class="col-xs-3">&nbsp;</div>
					</div> 
				</c:if>
				<div class="row form-group">
					<div class="col-xs-3">
						<fmt:message key="applicant.sportsPerson" />
						:
					</div>
					<div class="col-xs-3">&nbsp;</div>
					<div class="col-xs-3">
						<c:if test="${ not empty applicantOtherinfo.sportsPerson}">
							<c:choose>
								<c:when test="${applicantOtherinfo.sportsPerson == true }">
									<fmt:message key="yes" />
								</c:when>
								<c:otherwise>
									<fmt:message key="no" />
								</c:otherwise>
							</c:choose>
						</c:if>
					</div>
					<div class="col-xs-3">&nbsp;</div>
				</div>
				<c:if test="${applicantOtherinfo.sportsPerson}">
				<div class="row form-group">
					<div class="col-xs-3">
						<fmt:message key="applicant.sportsLevel" />:
					</div>
					<div class="col-xs-3">&nbsp;</div>
					<div class="col-xs-3">
						<c:if test="${ not empty applicantOtherinfo.sportsPerson}">
							<c:choose>
								<c:when test="${applicantOtherinfo.sportsPerson == true }">
									<c:choose>
										<c:when test="${applicantOtherinfo.sportsLevel == 'State' }">
											<fmt:message key="applicant.sportsLevel.state" />
										</c:when>
										<c:when test="${applicantOtherinfo.sportsLevel == 'International' }">
											<fmt:message key="applicant.sportsLevel.international" />
										</c:when>
										<c:otherwise>
											<c:if test="${applicantOtherinfo.sportsLevel == 'National' }">
												<fmt:message key="applicant.sportsLevel.national" />
											</c:if>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<fmt:message key="no" />
								</c:otherwise>
							</c:choose>
						</c:if>
					</div>
					<div class="col-xs-3">&nbsp;</div>
				</div>
				</c:if>
				<div class="row form-group">
					<div class="col-xs-3">
						<fmt:message key="applicant.stEmployee" />
						:
					</div>
					<div class="col-xs-3">&nbsp;</div>
					<div class="col-xs-3">
						<c:if test="${ not empty applicantOtherinfo.stEmployee}">
							<c:choose>
								<c:when test="${applicantOtherinfo.stEmployee == true }">
									<fmt:message key="yes" />
								</c:when>
								<c:otherwise>
									<fmt:message key="no" />
								</c:otherwise>
							</c:choose>
						</c:if>
					</div>
					
					<div class="col-xs-3">&nbsp;</div>
				</div>
				
				<div class="row form-group">
					<div class="col-xs-3">
						<fmt:message key="applicant.OrphanedPerson" />
						:
					</div>
					<div class="col-xs-3">&nbsp;</div>
					<div class="col-xs-3">
						<c:if test="${ not empty applicantOtherinfo.orphanedPerson}">
							<c:choose>
								<c:when test="${applicantOtherinfo.orphanedPerson == true }">
									<fmt:message key="yes" />
								</c:when>
								<c:otherwise>
									<fmt:message key="no" />
								</c:otherwise>
							</c:choose>
						</c:if>
					</div>
					
					<div class="col-xs-3">&nbsp;</div>
				</div>

				<div class="row form-group">
					<div class="col-xs-3">
						<fmt:message key="applicant.locomotorOrCerebralPalsy" /> :
					</div>
					<div class="col-xs-3">&nbsp;</div>
					<div class="col-xs-3">
						<c:if test="${ not empty applicantOtherinfo.locomotorOrCerebralPalsy}">
							<c:choose>
								<c:when test="${applicantOtherinfo.locomotorOrCerebralPalsy == true }">
									<fmt:message key="yes" />
								</c:when>
								<c:otherwise>
									<fmt:message key="no" />
								</c:otherwise>
							</c:choose>
						</c:if>
					</div>

					<div class="col-xs-3">&nbsp;</div>
				</div>

				<div class="row form-group">
					<div class="col-xs-3">
						<fmt:message key="applicant.deaf" /> :
					</div>
					<div class="col-xs-3">&nbsp;</div>
					<div class="col-xs-3">
						<c:if
							test="${ not empty applicantOtherinfo.deafAndMute}">
							<c:choose>
								<c:when
									test="${applicantOtherinfo.deafAndMute == true }">
									<fmt:message key="yes" />
								</c:when>
								<c:otherwise>
									<fmt:message key="no" />
								</c:otherwise>
							</c:choose>
						</c:if>
					</div>

					<div class="col-xs-3">&nbsp;</div>
				</div>

				<div class="row form-group">
					<div class="col-xs-3">
						<fmt:message key="city.preferredCities" />
						:
					</div>
					<div class="col-xs-3">&nbsp;</div>
					<div class="col-xs-3">&nbsp;</div>
				</div>

				 <div class="row form-group">
					<div class="col-xs-3">
						<fmt:message key="city.first.preference" />
						:
					</div>
					<div class="col-xs-3">&nbsp;</div>
					<div class="col-xs-3">
						<c:if test="${ not empty applicantOtherinfo.preferredCity1}">
							<c:choose>
								<c:when test="${applicantOtherinfo.preferredCity1 eq null}">
									N/A	
							</c:when>
								<c:otherwise>
									<fmt:message key="${city.messageKey}" />
								</c:otherwise>
							</c:choose>
						</c:if>
					</div>
					<div class="col-xs-3">&nbsp;</div>
				</div>
				<div class="row form-group">
					<div class="col-xs-3">
						<fmt:message key="city.second.preference" />
						:
					</div>
					<div class="col-xs-3">&nbsp;</div>
					<div class="col-xs-3">
						<c:if test="${ not empty applicantOtherinfo.preferredCity2}">
							<c:choose>
								<c:when test="${applicantOtherinfo.preferredCity2 eq null}">
									N/A	
							</c:when>
								<c:otherwise>
									<fmt:message key="${citySecond.messageKey}" />
								</c:otherwise>
							</c:choose>
						</c:if>
					</div>
					<div class="col-xs-3">&nbsp;</div>
				</div>
				<div class="row form-group">
					<div class="col-xs-3">
						<fmt:message key="city.third.preference" />
						:
					</div>
					<div class="col-xs-3">&nbsp;</div>
					<div class="col-xs-3">
						<c:if test="${ not empty applicantOtherinfo.preferredCity3}">
							<c:choose>
								<c:when test="${applicantOtherinfo.preferredCity3 eq null}">
									N/A	
							</c:when>
								<c:otherwise>
									<fmt:message key="${citythird.messageKey}" />
								</c:otherwise>
							</c:choose>
						</c:if>
					</div>
					<div class="col-xs-3">&nbsp;</div>
				</div>
			</div> 


			<div class="row">
				<div class="form-group">
					<label class="control-label col-xs-4"></label>
					<div class="col-xs-8 text-right">
						<a class="fa fa-pencil-square-o fa-3x" aria-hidden="true"
							href="javascript:void(0);"
							onclick="javascript:commonObj.goToURL('<c:url value="/applicant?operation=apply&tabNo=2&&menu=applyMenu"/>')"></a>
						<a class="fa fa-print fa-3x" aria-hidden="true"
							href="javascript:void(0);"
							onclick="javascript:printContent('otherInformationDiv');"></a>
					</div>
				</div>
			</div>
		</form>
		<div class="form-group"><label class="control-label col-sm-15" > <Strong style="color: red"><fmt:message key="divisionController.note"/> : </Strong><fmt:message key="apply.otherInformation.note"/> </label></div>
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