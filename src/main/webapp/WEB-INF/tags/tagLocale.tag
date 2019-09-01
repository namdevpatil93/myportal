<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags/" %>
<%@tag import ="com.msrtc.portal.core.common.util.NumberFormatMultiLang" %>

<%@ attribute name="no" required="true" type="java.lang.Integer" %>
<%@ attribute name="language" required="true" %>
<%@ attribute name="country" required="true" %>

<c:set var="localizedNumber"><%= NumberFormatMultiLang.localize(no, language, country) %></c:set>
<c:out value="${ localizedNumber }"/>