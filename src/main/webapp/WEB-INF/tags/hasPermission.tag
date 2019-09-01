<%@ include file="../jsps/common/taglibs.jsp"%>
<%@ tag import="com.msrtc.portal.core.user.security.SecurityUtils" %>

<%@ attribute name="moduleName" required="true" %>
<%@ attribute name="operation" required="true" %>

<c:set var="hasPermission"><%= SecurityUtils.hasPermission(moduleName, operation) %></c:set>

<c:if test="${ hasPermission }">
    <jsp:doBody/>
</c:if>