<%@ include file="common/taglibs.jsp"%>

<div class="error-box text-center animated fadeInDown">
    <h1><fmt:message key="404"/></h1>
    <h3 class="font-bold"><fmt:message key="404.title"/></h3>
    <div class="error-desc">
        <fmt:message key="404.msg"/>
    </div>
</div>
<br>
<br>

<!--

Exception:  ${exception.message}
<c:forEach items="${exception.stackTrace}" var="ste">    ${ste}
</c:forEach>

-->