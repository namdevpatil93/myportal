<%@ include file="taglibs.jsp" %>

<ul class="mainmenu">
    <li class="${ menu =='home'? 'activeMenu':'' }">
        <a href="javascript:commonObj.goToURL('<c:url value="/?&menu=home"/>')"><fmt:message key="menu.home"/></a>
    </li>
    <li class="${ menu =='recruitmentFee'? 'activeMenu':'' }">
        <a href="javascript:void(0)" onclick="javascript:commonObj.goToURL('<c:url value="/recruitmentFee?&menu=recruitmentFee"/>')"><fmt:message key="menu.recruitmentFee"/></a>
    </li>
    <li class="${ menu =='importantInformation'? 'activeMenu':'' }">
        <a href="javascript:void(0)" onclick="javascript:commonObj.goToURL('<c:url value="/importantInformation?&menu=importantInformation"/>')"><fmt:message key="menu.importantInformation"/></a>
    </li>
    <li class="${ menu =='instructionsForRegistration'? 'activeMenu':'' }">
        <a href="javascript:void(0)" onclick="javascript:commonObj.goToURL('<c:url value="/instructionForRegistration?&menu=instructionsForRegistration"/>')"><fmt:message key="menu.instructionsForRegistration"/></a>
    </li>
    <li class="${ menu =='timetable'? 'activeMenu':'' }">
        <a href="javascript:void(0)" onclick="javascript:commonObj.goToURL('<c:url value="/timetable?&menu=timetable"/>')"><fmt:message key="menu.timetable"/></a>
    </li>
     <li class="${ menu =='result'? 'activeMenu':'' }">
        <a href="javascript:void(0)" onclick="javascript:commonObj.goToURL('<c:url value="/result?&menu=result"/>')"><fmt:message key="menu.result"/></a>
    </li>
    <li class="${ menu =='announcements'? 'activeMenu':'' }">
        <a href="javascript:void(0)" onclick="javascript:commonObj.goToURL('<c:url value="/documents/viewAnnouncementList?&menu=announcements"/>')"><fmt:message key="announcement.header"/></a>
    </li>
    <li class="${ menu =='aboutUs'? 'activeMenu':'' }">
        <a href="javascript:void(0)" onclick="javascript:commonObj.goToURL('<c:url value="/aboutUs?&menu=aboutUs"/>')"><fmt:message key="menu.aboutUs"/></a>
    </li>
     
</ul>