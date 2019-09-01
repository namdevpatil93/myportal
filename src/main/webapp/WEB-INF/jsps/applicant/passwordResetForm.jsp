<%@ include file="../common/taglibs.jsp"%>
<script type="text/javascript">

	jQuery(document).ready(function () {
		$("#resetPasswordForm").validate({
			rules: {
				newPassword: {
					minlength: 6,
					trimSpacesFrontAndEnd: true
				},
				confirmPassword: {
					equalTo: "#newPassword",
					minlength: 6,
					trimSpacesFrontAndEnd: true
				}
			},
			messages: {
				newPassword: {
					minlength: "<fmt:message key="password.minlength.message"/>",
					trimSpacesFrontAndEnd: "<fmt:message key="validation.trimSpacesFrontAndEnd"/>"
				},
				confirmPassword: {
					equalTo: i18n("reset.password.mismatch"),
					minlength: "<fmt:message key="password.minlength.message"/>",
					trimSpacesFrontAndEnd: "<fmt:message key="validation.trimSpacesFrontAndEnd"/>"
				}
			}
		});
	});

</script>

<div class="registermain">

	<div class="registerwrap">

		<form class="form-horizontal" name="resetPasswordForm"
			id="resetPasswordForm"
			action="<c:url value='/applicant/saveUpdatedPasswordForm'/>"
			method="POST">
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" /> <input type="hidden" id="emailId"
				name="emailId" value="${emailId}" />
			<div class="panel-body">
				<c:choose>
				<c:when test="${showForm eq false}">
						<div class="form-group required">
							<label class="control-label col-xs-4"></label>
							<div class="col-xs-8">
								<label class="red"><b>${resetMessage}</b></label>
							</div>
						</div>
					</c:when>
				 <c:otherwise>
						<div class="form-group required">
							<label class="control-label col-xs-4" for="email"><fmt:message key="forgotPassword.newPassword"/>: <span class="red">*</span>
							</label>
							<div class="col-xs-8">
								<input type="password"
									placeholder="<fmt:message key="changePassword.newPassword" />"
									required name="newPassword" id="newPassword" maxlength="20"
									class="form-control">
								<div class="help-block with-errors"></div>
							</div>
						</div>

						<div class="form-group required">
							<label class="control-label col-xs-4" for="confirmPassword">
								<fmt:message key="forgotPassword.confirmPassword"/>: <span class="red">*</span>
							</label>
							<div class="col-xs-8">
								<input type="password" data-match="#newPassword"
									data-match-error="<fmt:message key="reset.password.mismatch"/>"
									placeholder="<fmt:message key="changePassword.confirmPassword" />"
									required maxlength="20" name="confirmPassword" id="confirmPassword"
									class="form-control">
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

					 </c:otherwise>
					
				</c:choose>
			</div>
		</form>
	</div>

</div>