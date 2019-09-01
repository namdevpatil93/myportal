<%@ include file="taglibs.jsp"%>

<div class="logo-grid">
	<a class="logo">
		<img src="<c:url value='/static/app/images/recruitment.jpg'/>" width="130" />
	</a>
</div>
<div class="header-text">
	<h4><strong><fmt:message key="mainHeader"/></strong></h4>
</div>

<sec:authentication var="securityUser" property="principal"/>

<div class="right-top-grid">
	<div class="QueryNotification">
		<c:if test="${ securityUser.parentRoleId eq 1}"> 
<%--
 			<a title="Notifications" class="notification" onclick="javascript:commonObj.goToURL('<c:url value="/notification?operation=userNotificationList&menu=userNotificationListMenuOption"/>')">
 				<i class="fa fa-bell" aria-hidden="true"><span class="counts">10n</span></i> 
 			</a> 
 			<a title="Query" class="query" onclick="javascript:commonObj.goToURL('<c:url value="/notification?operation=viewQueriesAndNotifications&menu=viewQueriesAndNotifications"/>')"> 
 				<i class="fa fa-question-circle" aria-hidden="true"><span class="counts">${unreadCount }</span></i> 
 			</a>		 
--%>
 		</c:if>
		 <c:if test="${ securityUser.parentRoleId eq 2}">
			<a title="<fmt:message key='header.notifications'/>" class="notification" onclick="javascript:commonObj.goToURL('<c:url value="/notification?operation=userNotificationList&userNotificationListMenuOption"/>&id=' + ${securityUser.applicant.id})">
				<i class="fa fa-bell" aria-hidden="true"><c:if
						test="${ userNotificationCount ne 0}">
						<c:if test="${ userNotificationCount gt 0 }">
							<span id="userNotificationCount" class="counts">${userNotificationCount}</span>
						</c:if>
					</c:if></i>
			</a>
			<a title="<fmt:message key='applicantMenu.query'/>" class="query" onclick="javascript:commonObj.goToURL('<c:url value="/applicantQuery?operation=applicantQueryList&menu=applicantQueryListMenuOption"/>&id=' + ${securityUser.applicant.id})">
				<i class="fa fa-question-circle" aria-hidden="true">
					<c:if test="${ userQueryCount gt 0 }">
						<span class="counts">
							${userQueryCount }
						</span>
					</c:if>
				</i>
 			</a> 
 		</c:if>  
	</div>	    
   
    <div class="admin-user">
    	<b><fmt:message key="welcome"/>
			<c:choose>
				<c:when test="${ securityUser.parentRoleId eq 2}">
					${ securityUser.applicant.firstName } ${ securityUser.applicant.lastName }
				</c:when>
				<c:otherwise>
					${ securityUser.user.firstname } ${ securityUser.user.lastname }
				</c:otherwise>
			</c:choose>
		</b>
    </div>
	<c:if test="${ securityUser.parentRoleId eq 2}">
		<div class="language-link">
			<a href="javascript:void(0);" onclick="javascript:commonObj.changeLanguage('en');" title="<fmt:message key='switchToEnglishLanguage'/>"><fmt:message key="lang.english"/></a>
			<a href="javascript:void(0);" onclick="javascript:commonObj.changeLanguage('mr');"  title="<fmt:message key='switchToMarathiLanguage'/>"><fmt:message key="lang.marathi"/></a>
		</div>
	</c:if>
    <div class="logout-link">
	    <form action="<c:url value='/logout'/>" method="POST" id="logoutForm" name="logoutForm">
			<input type="hidden" id="idleTimeout" name="idleTimeout" value="false"/>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <a href="javascript:void(0);" onclick="javascript:commonObj.logout();" title="<fmt:message key="menu.logout"/>"><fmt:message key="menu.logout"/></a>
	    </form>
    </div>
</div>
<div class="clearfix"></div>
