<%@ include file="common/taglibs.jsp"%>
<%@ page pageEncoding="UTF-8"%>

<script>
    function checkLogin(){
        if (!$('#checkLoginForm').validator('validate').has('.has-error').length) {
            $("#username").val( commonObj.USER_TYPE_ADMIN +  commonObj.SEPARATOR  + $("#j_username").val());
            $("#checkLoginForm").submit();
        }
    }
    
    $(document).ready(function(e) {

		$('form.no_autofill').attr('autocomplete','off');
		//$('#j_username input').attr('autocomplete','off');
		//$('#password input').attr('autocomplete','off');
		
	    if ($.browser.webkit) {
	        $('#password').val(' ').val('');
	        $('#j_username').val(' ').val('');
	    }
	});
</script>

<div class="users form ">
    <div class="login-block">
        <form name="checkLoginForm" id="checkLoginForm" class="login-form no_autofill" action="<c:url value='/checkLogin'/>" method="POST" data-toggle="validator" autocomplete="false" >
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <input type="hidden" id="username" name="username"  value=""/>

            <center><h3><fmt:message key="login.login"/></h3></center>
            <div class="form-group">
                <label for="j_username" class="control-label"><fmt:message key="login.email"/></label>
                <div>
                    <input type="email" title="<fmt:message key="login.username.required"/>"  class="form-control" id="j_username" name="j_username" placeholder="<fmt:message key="login.email"/>" readonly onfocus="this.removeAttribute('readonly');" maxlength="25" required>
                    <div class="help-block with-errors"></div>
                </div>
            </div>
            <br>
            <div class="form-group">
                <label for="password" class="control-label"><fmt:message key="login.password"/></label>
                <div>
                    <input type="password" title="<fmt:message key="login.password.required"/>"  class="form-control" id="password" name="password" placeholder="<fmt:message key="login.password"/>" readonly onfocus="this.removeAttribute('readonly');" maxlength="25" required>
                    <div class="help-block with-errors"></div>
                </div>
            </div>
            <br>
            <div class="form-group">
                <div>
                    <button type="button" class="btn btn-primary" value="<fmt:message key="login.login"/>" onclick="javascript:checkLogin();">
                        <fmt:message key="login.login"/>
                    </button>
                </div>
            </div>
            <br>
            <c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION and param.login_error eq 1}">
                <div class="alert alert-danger" role="alert">
                    <fmt:message key="login.error"/>
                </div>
            </c:if>
        </form>
    </div>
</div>
