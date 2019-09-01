<%@ include file="../common/taglibs.jsp"%>
<div class="registermain">
	<div class="registerwrap">

		<form class="form-horizontal" name="forgotPasswordForm"
			id="forgotPasswordForm" data-toggle="validator"
			action="<c:url value='/applicant/saveForgotPasswordForm'/>"
			method="POST">
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
			<div class="panel-body">
				<c:choose>
					<c:when test="${showForm eq false}">

						<div class="form-group required">
							<label class="control-label col-xs-4"></label>
							<div class="col-xs-8">
								<label class="red"><b>${message}</b></label>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div class="form-group required">
							<label class="control-label col-xs-4" for="email"><fmt:message key="enter.email"/>: <span class="red">*</span>
							</label>
							<div class="col-xs-8">
								<input name="email" class="form-control" id="email" type="email" maxlength="64"
									required />
								<div class="help-block with-errors"></div>
							</div>
						</div>

						<div class="form-group required">
							<label class="control-label col-xs-4"></label>
							<div class="col-xs-8">
								<input class="btn btn-success" id="submit" value="<fmt:message key="submit"/>"
									type="submit" />
							</div>
						</div>

						<div class="form-group required">
							<label class="control-label col-xs-4"></label>
							<div class="col-xs-8">
								<label class="red"><b>${message}</b></label>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
			</form>
	</div>
	

</div>

