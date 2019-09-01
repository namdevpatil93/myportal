<%@ include file="../common/taglibs.jsp"%>

<script>

	jQuery(document).ready(function () {

		
		if( ${applicant.mobileNoVerified eq true}  ) {
			$("#verifiedLabel").empty();
            $("#verifiedLabel").append('<fmt:message key="verified"/>').css({'color':'green'}); //rgb(15,99,30)
            //$("#verifiedButton").prop("disabled", true);
            $("#verifiedButton").hide();
		}
		
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

<div class="custom-panel">

<div class="frm">
	<div class="registerwrap">
		<form class="form-horizontal" name="changePasswordForm" id="changePasswordForm" action="<c:url value='/applicant?operation=changePassword'/>" method="POST">

			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			<input type="hidden" name="id" value="${applicant.id}"/>
			<input type="hidden" name="isMyAccountPage" value="${  true  }"/>
			<input type="hidden" id="menu" name="menu" value="myAccount" />

			<tags:app-message message="${message}" />

			<div class="form-group required">
				<label class="col-xs-4"><fmt:message key="myAccount.firstName"/>: </label>
				<div class="col-xs-8">
					<span>${applicant.firstName}</span>
				</div>
			</div>

			<div class="form-group required">
				<label class="col-xs-4"><fmt:message key="myAccount.lastName"/>: </label>
				<div class="col-xs-8">
					<span>${applicant.lastName}</span>
				</div>
			</div>

			<div class="form-group required">
				<label class="col-xs-4"><fmt:message key="myAccount.email"/>: </label>
				<div class="col-xs-8">
					<span>${applicant.emailAddress}</span>
				</div>
			</div>
			
			<div class="form-group required">
				<label class="col-xs-4"><fmt:message key="myAccount.applicationId"/>: </label>
				<div class="col-xs-8">
					<span>${applicant.applicationId}</span>
				</div>
			</div>
			
			<div class="form-group required">
				<label class="col-xs-4"><fmt:message key="myAccount.mobile"/>: </label>
				<div class="col-xs-8">
					<span>${applicant.mobileNumber}</span>
					<button type="button" id="verifiedButton" class="btn btn-default btn-xs" onclick="openModal()"><fmt:message key="verify"/></button>
					<label id="verifiedLabel"></label>
				</div>
			</div>
			
			<div class="form-group required">
<%-- 				<label class="col-xs-6"><fmt:message key="myAccount.mobile"/>: </label> --%>
				<div class="col-xs-12">
					
				</div>
			</div>
			<div class="col-xs-12">
				<h4 style="text-align: center;"><fmt:message key="myAccount.passwordChange"/></h4>
			</div>
			<div class="form-group required">
				<label class="col-xs-4" for="password"><fmt:message key="myAccount.oldPassword"/>: <span class="red">*</span> </label>
				<div class="col-xs-5">
					<input type="password" class="form-control" id="password" placeholder="" name="password" maxlength="20" required >
					<div class="help-block with-errors"></div>
				</div>
			</div>

			<div class="form-group required">
				<label class="col-xs-4" for="password"><fmt:message key="myAccount.newPassword"/>: <span class="red">*</span> </label>
				<div class="col-xs-5">
					<input type="password" class="form-control" id="newPassword" placeholder="" maxlength="20" name="newPassword" required>
					<div class="help-block with-errors"></div>
				</div>
			</div>

			<div class="form-group required">
				<label class="col-xs-4" for="confirmPassword"><fmt:message key="myAccount.confirmPassword"/>: <span class="red">*</span> </label>
				<div class="col-xs-5">
					<input type="password" data-match="#newPassword" data-match-error="<fmt:message key="myAccount.password.mismatch"/>" maxlength="20"
						   class="form-control" id="confirmPassword" placeholder="" name="confirmPassword" required>
					<div class="help-block with-errors"></div>
				</div>
			</div>

			<div class="form-group required">
				<label class="col-xs-4"></label>
				<div class="col-xs-8">
					<input class="btn btn-success" id="submit" value="<fmt:message key="myAccount.update"/>" type="submit" />
				</div>
			</div>

		</form>
	</div>
</div>
</div>

<%@ include file="verifyOTP.jsp"%>
