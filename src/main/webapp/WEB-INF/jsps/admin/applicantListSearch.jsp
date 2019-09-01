<%@ include file="../common/taglibs.jsp"%>

<form class="form-horizontal" name="applicantsListSearchForm" id="applicantsListSearchForm"  action="<c:url value='/admin?operation=applicantsPostAssocList'/>" method="POST" novalidate >
	<input id="menu" type="hidden" name="menu" value="applicantsList"/>
	<jsp:include page="applicantSearchFields.jsp"/>
</form>