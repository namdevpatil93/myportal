<%@ include file="taglibs.jsp"%>

<sec:authentication var="securityUser" property="principal"/>

<sec:authorize access="isAuthenticated()">
    <ul>
        <c:choose>
            <c:when test="${ securityUser.parentRoleId eq 2}">
                <%--Applicant Menu Starts here--%>
                <tags:hasPermission moduleName="applicant" operation="applicantDashboard">
                    <li class="${ menu =='applicantDashboard'? 'activeMenu':'' }">
                        <a href="javascript:void(0);" onclick="javascript:commonObj.goToURL('<c:url value="/applicant?operation=applicantDashboard&menu=applicantDashboard"/>')"><fmt:message key="applicantMenu.home"/></a>
                    </li>
                </tags:hasPermission>
                <tags:hasPermission moduleName="applicant" operation="viewProfile">
                    <li class="${ menu =='viewProfile'? 'activeMenu':'' }">
                        <a href="javascript:void(0);" onclick="javascript:commonObj.goToURL('<c:url value="/applicant?operation=viewProfile&menu=viewProfile"/>')"><fmt:message key="applicantMenu.profile"/></a>
                    </li>
                </tags:hasPermission>
                <tags:hasPermission moduleName="applicant" operation="apply">
                    <li class="${ menu =='applyMenu'? 'activeMenu':'' }">
                        <a href="javascript:void(0);" onclick="javascript:commonObj.goToURL('<c:url value="/applicant?operation=apply&tabNo=1&menu=applyMenu"/>')"><fmt:message key="applicantMenu.apply"/></a>
                    </li>
                </tags:hasPermission>
                <tags:hasPermission moduleName="applicant" operation="myAccount">
                    <li class="${ menu =='myAccount'? 'activeMenu':'' }">
                        <a href="javascript:void(0);" onclick="javascript:commonObj.goToURL('<c:url value="/applicant?operation=myAccount&menu=myAccount"/>')"><fmt:message key="applicantMenu.myAccount"/></a>
                    </li>
                </tags:hasPermission>
                <%--Applicant Menu Ends here--%>
            </c:when>
            <c:otherwise>
                <%-- Admin Menu Starts here--%>
                <%-- <tags:hasPermission moduleName="admin" operation="adminDashboard">
                    <li class="${ menu =='adminDashboard'? 'activeMenu':'' }">
                        <a href="javascript:void(0);" onclick="javascript:commonObj.goToURL('<c:url value="/admin?operation=adminDashboard&menu=adminDashboard"/>')">
                            <fmt:message key="adminMenu.dashboard"/>
                        </a>
                    </li>
                </tags:hasPermission> --%>
                <tags:hasPermission moduleName="reports" operation="viewReports">
                    <li class="${ menu =='viewReports'? 'activeMenu':'' }">
                        <a href="javascript:void(0);" onclick="javascript:commonObj.goToURL('<c:url value="/reports?operation=viewReports&menu=viewReports"/>')">
                            <fmt:message key="adminMenu.dashboard"/>
                        </a>
                    </li>
                </tags:hasPermission>
                <tags:hasPermission moduleName="admin" operation="applicantsPostAssocList">
                    <li class="${ menu =='applicantsList'? 'activeMenu':'' }">
                        <a href="javascript:void(0);" onclick="javascript:commonObj.goToURL('<c:url value="/admin?operation=showApplicantsPostAssocList&menu=applicantsList"/>')">
                            <fmt:message key="adminMenu.applications"/>
                        </a>
                    </li>
                </tags:hasPermission>
                <tags:hasPermission moduleName="challan" operation="showUploadChallan">
                    <li class="${ menu =='showUploadChallan'? 'activeMenu':'' }">
                        <a href="javascript:void(0);" onclick="javascript:commonObj.goToURL('<c:url value="/challan?operation=showUploadChallan&menu=showUploadChallan"/>')">
                            Payments
                        </a>
                    </li>
                </tags:hasPermission>
                <tags:hasPermission moduleName="documents" operation="allDocuments">
                    <li class="${ menu =='allDocuments'? 'activeMenu':'' }">
                        <a href="javascript:void(0);" onclick="javascript:commonObj.goToURL('<c:url value="/documents?operation=allDocuments&menu=allDocuments"/>')">
                            Documents
                        </a>
                    </li>
                </tags:hasPermission>
                <tags:hasPermission moduleName="challan" operation="onlineQueryApi">
                    <li class="${ menu =='onlineQueryApi'? 'activeMenu':'' }">
                        <a href="javascript:void(0);" onclick="javascript:commonObj.goToURL('<c:url value="/challan?operation=onlineQueryApi&menu=onlineQueryApi"/>')">
                            Online Query Api
                        </a>
                    </li>
                </tags:hasPermission>
                <tags:hasPermission moduleName="challan" operation="showPaymentSearchForm">
                    <li class="${ menu =='showPaymentSearchForm'? 'activeMenu':'' }">
                        <a href="javascript:void(0);" onclick="javascript:commonObj.goToURL('<c:url value="/challan?operation=showPaymentSearchForm&menu=showPaymentSearchForm"/>')">
                            Reconcile Payments
                        </a>
                    </li>
                </tags:hasPermission>
                <tags:hasPermission moduleName="notification" operation="viewQueriesAndNotifications">
                    <li class="${ menu =='viewQueriesAndNotifications'? 'activeMenu':'' }">
                        <a href="javascript:void(0);" onclick="javascript:commonObj.goToURL('<c:url value="/notification?operation=viewQueriesAndNotifications&menu=viewQueriesAndNotifications"/>')">
                            Queries & Notifications
                        </a>
                    </li>
                </tags:hasPermission>
                <tags:hasPermission moduleName="admin" operation="applicantAttachmentDownloadForm">
                    <li class="${ menu =='applicantAttachmentDownloadForm'? 'activeMenu':'' }">
                        <a href="javascript:void(0);" onclick="javascript:commonObj.goToURL('<c:url value="/admin?operation=applicantAttachmentDownloadForm&menu=applicantAttachmentDownloadForm"/>')">
                            Applicant Form
                        </a>
                    </li>
                </tags:hasPermission>
                <tags:hasPermission moduleName="admin" operation="administration">
                    <li class="${ menu =='administration'? 'activeMenu':'' }">
                        <a href="javascript:void(0);" onclick="javascript:commonObj.goToURL('<c:url value="/admin?operation=administration&menu=administration"/>')">
                            Administration
                        </a>
                    </li>
                </tags:hasPermission>
                <%-- Admin Menu Ends here--%>
            </c:otherwise>
        </c:choose>
    </ul>
</sec:authorize>