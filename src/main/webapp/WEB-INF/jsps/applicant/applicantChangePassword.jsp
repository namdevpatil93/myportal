<%@ include file="../common/taglibs.jsp"%>

<script type="text/javascript">

	jQuery(document).ready(function () {
		$("#changePasswordForm").validate({
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
<h4><fmt:message key="changePassword.heading"/></h4>
<div class="clearfix"></div>
<div class="panel panel-default">	
	<div class="frm clearfix">
		<div class="registerwrap col-sm-12">
			<form class="form-horizontal" name="changePasswordForm" id="changePasswordForm" action="<c:url value='/applicant?operation=changePassword'/>" method="POST">
	
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<input type="hidden" name="id" value="${applicant.id}"/>
				<tags:app-message message="${message}" />
				<br><br>
				<div class="form-group required">
					<label class="col-xs-4" for="password"><fmt:message key="changePassword.oldPassword"/>: <span class="red">*</span> </label>
					<div class="col-xs-8">
						<input type="password" class="form-control" id="password" placeholder="" name="password" maxlength="20" required >
						<div class="help-block with-errors"></div>
					</div>
				</div>
	
				<div class="form-group required">
					<label class="col-xs-4" for="password"><fmt:message key="changePassword.newPassword"/>: <span class="red">*</span> </label>
					<div class="col-xs-8">
						<input type="password" class="form-control" id="newPassword" placeholder="" maxlength="20" name="newPassword" required>
						<div class="help-block with-errors"></div>
					</div>
				</div>
	
				<div class="form-group required">
					<label class="col-xs-4" for="confirmPassword"><fmt:message key="changePassword.confirmPassword"/>: <span class="red">*</span> </label>
					<div class="col-xs-8">
						<input type="password" data-match="#newPassword" data-match-error="<fmt:message key="user.password.mismatch"/>" maxlength="20"
							   class="form-control" id="confirmPassword" placeholder="" name="confirmPassword" required>
						<div class="help-block with-errors"></div>
					</div>
				</div>
	
				<div class="form-group required">
					<label class="col-xs-4"></label>
					<div class="col-xs-8">
						<input class="btn btn-success" id="submit" value="<fmt:message key='changePassword.submitButton'/>" type="submit" />
					</div>
				</div>
	
			</form>
		</div>
	</div>
</div>
