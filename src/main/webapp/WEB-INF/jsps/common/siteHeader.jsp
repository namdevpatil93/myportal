<%@ include file="../common/taglibs.jsp"%>

<a class="logo-grid" href="index.html"><img src="<c:url value='/static/app/images/recruitment.jpg'/>" alt="" class="logo"></a>

<div class="top-ad-grid">
	<img src="<c:url value='/static/app/images/top-ad.jpg'/>">
</div>

<ul id="toplinks">
	<li><a title="<fmt:message key='switchToEnglishLanguage'/>" href="?lang=en"><fmt:message key="lang.english"/></a></li>
	<li><a title="<fmt:message key='switchToMarathiLanguage'/>" href="?lang=mr"><fmt:message key="lang.marathi"/></a></li>
</ul>

<jsp:include page="siteMenu.jsp"/>