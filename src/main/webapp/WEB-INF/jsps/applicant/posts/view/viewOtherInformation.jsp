<%@ include file="../../../common/taglibs.jsp"%>
<div class="row readonlyinfo">
<table style="width:100%">
	
	<c:choose>
		<c:when test="${applicantPostAssoc.postId eq 19 || applicantPostAssoc.postId eq 20 || applicantPostAssoc.postId eq 23 || applicantPostAssoc.postId eq 24 ||  applicantPostAssoc.postId eq 25 ||  applicantPostAssoc.postId eq 26 ||
		 applicantPostAssoc.postId eq 27 ||  applicantPostAssoc.postId eq 28 ||  applicantPostAssoc.postId eq 29 ||  applicantPostAssoc.postId eq 30 ||
		  applicantPostAssoc.postId eq 31 || applicantPostAssoc.postId eq 5||  applicantPostAssoc.postId eq 8
		  ||  applicantPostAssoc.postId eq 13||  applicantPostAssoc.postId eq 14||  applicantPostAssoc.postId eq 15
		  ||  applicantPostAssoc.postId eq 18}">
<!-- 			dont display -->
		</c:when>
		<c:otherwise>
		
			<tr>
				<th style="width:25%">
					<label><fmt:message key="applicant.earthQuakeEffected"/>:</label>
				</th>
				<td style="width:25%">
					<c:if test="${ not empty applicantOtherinfo.earthQuakeEffected}">
						<c:choose>
							<c:when test="${applicantOtherinfo.earthQuakeEffected == true }">
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
					<label><fmt:message key="applicant.projectEffected"/>:</label>
				</th>
				<td style="width:25%">
					<c:if test="${ not empty applicantOtherinfo.projectEffected}">
						<c:choose>
							<c:when test="${applicantOtherinfo.projectEffected == true }">
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
				<th style="width:25%">
					<label><fmt:message key="applicant.exServiceMan"/>:</label>
				</th>
				<td style="width:25%">
					<c:if test="${ not empty applicantOtherinfo.exServiceMan}">
							<c:choose>
								<c:when test="${applicantOtherinfo.exServiceMan == true }">
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
				<c:if test="${ applicantOtherinfo.exServiceMan == true}">
					<th style="width:25%">
						<label><fmt:message key="otherInfo.totalServicePeriod"/>:</label>
					</th>
					<td style="width:25%">
						<c:if test="${ not empty applicantOtherinfo.exServiceMan}">
								<c:choose>
									<c:when test="${applicantOtherinfo.exServiceMan == true }">
										<label>${applicantOtherinfo.exServicemanTotalExperienceInYears}
											-
											<fmt:message key="applicant.applicantBithOfYears" />
											&nbsp;&nbsp;&nbsp;${applicantOtherinfo.exServicemanTotalExperienceInMonths}
											-
											<fmt:message key="applicant.applicantBithOfMonth" />
										</label>
									</c:when>
									<c:otherwise>
										<label>
											<fmt:message key="NA" />
										</label>
									</c:otherwise>
								</c:choose>
						</c:if>
					</td>
				</c:if>
			</tr>
	
			<tr>
				 <th style="width:25%">
					<label><fmt:message key="applicant.partTimeEmployee"/>:</label>
				</th>
				<td style="width:25%">
					<c:if test="${ not empty applicantOtherinfo.partTimeEmployee}">
						<c:choose>
							<c:when test="${applicantOtherinfo.partTimeEmployee == true }">
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
				<c:if test="${ applicantOtherinfo.partTimeEmployee == true}">
				<th style="width:25%">
					<label><fmt:message key="applicant.exServicemanTotalExperienceInYears"/>:</label>
				</th>
				<td style="width:25%">
					<c:if test="${ not empty applicantOtherinfo.partTimeEmployee}">
						<c:choose>
							<c:when test="${applicantOtherinfo.partTimeEmployee == true }">
								<label>${applicantOtherinfo.partTimeEmployeeTotalExperienceInYears}
									-
									<fmt:message key="applicant.applicantBithOfYears" />
									&nbsp;&nbsp;&nbsp;${applicantOtherinfo.partTimeEmployeeTotalExperienceInMonths}
									-
									<fmt:message key="applicant.applicantBithOfMonth" />
								</label>
							</c:when>
							<c:otherwise>
								<label>
									<fmt:message key="NA" />
								</label>
							</c:otherwise>
						</c:choose>
					</c:if>
				</td>
				</c:if>
			</tr>
	
			<tr>
				<th style="width:25%">
					<label><fmt:message key="applicant.sportsPerson"/>:</label>
				</th>
				<td style="width:25%">
					<c:if test="${ not empty applicantOtherinfo.sportsPerson}">
						<c:choose>
							<c:when test="${applicantOtherinfo.sportsPerson == true }">
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
				<c:if test="${ applicantOtherinfo.sportsPerson == true}">
				<th style="width:25%">
					<label><fmt:message key="applicant.sportsLevel"/>:</label>
				</th>
				<td style="width:25%">
					<c:if test="${ not empty applicantOtherinfo.sportsPerson}">
						<c:choose>
							<c:when test="${applicantOtherinfo.sportsPerson == true }">
								<c:choose>
									<c:when test="${applicantOtherinfo.sportsLevel == 'State' }">
										<label>
											<fmt:message key="applicant.sportsLevel.state" />
										</label>
									</c:when>
									<c:when test="${applicantOtherinfo.sportsLevel == 'International' }">
										<label>
											<fmt:message key="applicant.sportsLevel.international" />
										</label>
									</c:when>
									<c:otherwise>
										<label>
											<fmt:message key="applicant.sportsLevel.national" />
										</label>
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								<fmt:message key="no" />
							</c:otherwise>
						</c:choose>
					</c:if>
				</td>
				</c:if>
			</tr>
	
			<tr>
				<th style="width:25%">
					<label><fmt:message key="applicant.stEmployee"/>:</label>
				</th>
				<td style="width:25%">
					<c:if test="${ not empty applicantOtherinfo.stEmployee}">
						<c:choose>
							<c:when test="${applicantOtherinfo.stEmployee == true }">
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
				<th style="width:25%">
					<label><fmt:message key="applicant.OrphanedPerson"/>:</label>
				</th>
				<td style="width:25%">
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
				</td>
			</tr>
			
			


			</c:otherwise>
	</c:choose>
	
		  <c:if test="${applicantPostAssoc.postId eq 23 || applicantPostAssoc.postId eq 24 ||  applicantPostAssoc.postId eq 25 ||  applicantPostAssoc.postId eq 26 ||
		 applicantPostAssoc.postId eq 27 ||  applicantPostAssoc.postId eq 28 ||  applicantPostAssoc.postId eq 29 ||  applicantPostAssoc.postId eq 30 ||
		  applicantPostAssoc.postId eq 31 ||  applicantPostAssoc.postId eq 5||  applicantPostAssoc.postId eq 8
		  ||  applicantPostAssoc.postId eq 13||  applicantPostAssoc.postId eq 14||  applicantPostAssoc.postId eq 15
		  ||  applicantPostAssoc.postId eq 18}">
	<tr>
				<th style="width:25%">
					<label><fmt:message key="applicant.locomotorOrCerebralPalsy"/>:</label>
				</th>
				<td style="width:25%">
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
				</td>
			</tr>

				<tr>
					<th style="width: 25%"><label><fmt:message key="applicant.deaf" />:</label></th>
					<td style="width: 25%">
					<c:if test="${ not empty applicantOtherinfo.deafAndMute}">
							<c:choose>
								<c:when test="${applicantOtherinfo.deafAndMute == true }">
									<fmt:message key="yes" />
								</c:when>
								<c:otherwise>
									<fmt:message key="no" />
								</c:otherwise>
							</c:choose>
						</c:if></td>
				</tr>
				<tr>
				<th style="width:25%">
					<label><fmt:message key="applicant.stEmployee"/>:</label>
				</th>
				<td style="width:25%">
					<c:if test="${ not empty applicantOtherinfo.stEmployee}">
						<c:choose>
							<c:when test="${applicantOtherinfo.stEmployee == true }">
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
				<th style="width:25%">
					<label><fmt:message key="applicant.sportsPerson"/>:</label>
				</th>
				<td style="width:25%">
					<c:if test="${ not empty applicantOtherinfo.sportsPerson}">
						<c:choose>
							<c:when test="${applicantOtherinfo.sportsPerson == true }">
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
				<c:if test="${ applicantOtherinfo.sportsPerson == true}">
				<th style="width:25%">
					<label><fmt:message key="applicant.sportsLevel"/>:</label>
				</th>
				<td style="width:25%">
					<c:if test="${ not empty applicantOtherinfo.sportsPerson}">
						<c:choose>
							<c:when test="${applicantOtherinfo.sportsPerson == true }">
								<c:choose>
									<c:when test="${applicantOtherinfo.sportsLevel == 'State' }">
										<label>
											<fmt:message key="applicant.sportsLevel.state" />
										</label>
									</c:when>
									<c:when test="${applicantOtherinfo.sportsLevel == 'International' }">
										<label>
											<fmt:message key="applicant.sportsLevel.international" />
										</label>
									</c:when>
									<c:otherwise>
										<label>
											<fmt:message key="applicant.sportsLevel.national" />
										</label>
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								<fmt:message key="no" />
							</c:otherwise>
						</c:choose>
					</c:if>
				</td>
				</c:if>
			</tr>
			
			<tr>
				<th style="width:25%">
					<label><fmt:message key="applicant.OrphanedPerson"/>:</label>
				</th>
				<td style="width:25%">
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
				</td>
			</tr>
				</c:if>
				
	 <tr>
		<th style="width:25%">
			<label><fmt:message key="city.preferredCities" />:</label>
		</th>
	</tr>
	<tr>
		<th style="width:25%">
			<label><fmt:message key="city.first.preference"/>:</label>
		</th>
		<td style="width:25%">
			<c:if test="${ not empty applicantOtherinfo.preferredCity1}">
				<c:choose>
					<c:when test="${applicantOtherinfo.preferredCity1 eq null}">
								<label>N/A</label>
						</c:when>
					<c:otherwise>
						<label><fmt:message key="${city.messageKey}" /></label>
					</c:otherwise>
				</c:choose>
			</c:if>
		</td>
	</tr>
	
	<tr>
		<th style="width:25%">
			<label><fmt:message key="city.second.preference"/>:</label>
		</th>
		<td style="width:25%">
			<c:if test="${ not empty applicantOtherinfo.preferredCity2}">
				<c:choose>
					<c:when test="${applicantOtherinfo.preferredCity2 eq null}">
							<label>N/A</label>
						</c:when>
					<c:otherwise>
						<label><fmt:message key="${citySecond.messageKey}" /></label>
					</c:otherwise>
				</c:choose>
			</c:if>
		</td>
	</tr>
	
	
	
	<tr>
		<th style="width:25%">
			<label><fmt:message key="city.third.preference"/>:</label>
		</th>
		<td style="width:25%">
			<c:if test="${ not empty applicantOtherinfo.preferredCity3}">
				<c:choose>
					<c:when test="${applicantOtherinfo.preferredCity3 eq null}">
								<label>N/A</label>
						</c:when>
					<c:otherwise>
						<label><fmt:message key="${citythird.messageKey}" /></label>
					</c:otherwise>
				</c:choose>
			</c:if>
		</td>
	</tr> 
	
 </table>
 <br>
 <div class="form-group"><label class="control-label col-sm-15" > <Strong style="color: red"><fmt:message key="divisionController.note"/> : </Strong><fmt:message key="apply.otherInformation.note"/> </label></div>
</div> 
