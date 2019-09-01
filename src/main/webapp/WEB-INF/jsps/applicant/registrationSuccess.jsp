<%@ include file="../common/taglibs.jsp"%>
<div class="registermain">
	
	<div class="registerwrap">
		<br>
		<h4>
			<fmt:message key="hello"/> ${firstName } ${lastName },
		</h4>
		<strong>
			<fmt:message key="registration.success.thank.you"/><br>
			<fmt:message key="registration.success.login.credentials.sent.on.mailbox"/><br><br>
			<fmt:message key="msrtc"/>
		</strong>
		<br>
		<%-- <fmt:message key="registration.success.warm.regards"/></p> --%>
		<a href="javascript:void(0);" onclick="javascript:commonObj.goToURL('<c:url value='/'/>');">
			<fmt:message key="registration.success.click.here.to.login"/>
		</a>
	</div>
</div>
