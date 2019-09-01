<%@ include file="taglibs.jsp" %>

<jsp:useBean id="date" class="java.util.Date"/>
<div class="footersub">
     <p><a href="javascript:void(0);" onclick="javascript:commonObj.showTermsAndConditionPopup();"><fmt:message key="footer.termsOfUse"/></a> | <a href="javascript:void(0);" onclick="javascript:commonObj.showDisclaimerAndPoliciesPopup();"><fmt:message key="footer.disclaimerAndPolicies"/></a> | <a href="javascript:void(0);" onclick="javascript:commonObj.showHyperlinkingPolicyPopup();"><fmt:message key="footer.hyperlinkingPolicy"/></a> | <a href="javascript:void(0);" onclick="javascript:commonObj.showPrivacyPolicyPopup();"><fmt:message key="footer.privacyPolicy"/></a> | <a href="javascript:void(0);" onclick="javascript:commonObj.showCopyrightPolicyPopup();"><fmt:message key="footer.copyrightPolicy"/></a> </p>
    <%--<p class="disclimar"><fmt:message key="footer.disclaimer"/></p>--%>
    <%--<p><fmt:message key="footer.helpline"/> &nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-earphone"></span> &nbsp;&nbsp;&nbsp;<a href="callto:00000000"><fmt:message key="footer.call"/> </a> <span style="margin-left: 25px;"><span class="glyphicon glyphicon-envelope"></span> &nbsp;&nbsp;&nbsp;<a href="mailto:support@msrtcexams.in"><fmt:message key="footer.mailTo"/></a></span></p>--%>
    <%--<p><fmt:message key="footer.copyright"/> &copy; <fmt:formatDate value="${date}" pattern="yyyy" /> <a href="#">msrtcexam.in</a>&nbsp;<fmt:message key="footer.copyrightOf"/></p>--%>
    <p><fmt:message key="browser.compatibility.message"/></p>
</div>
<%--
<p class="left"><font> <fmt:message key="copyright"/> &copy; <fmt:formatDate value="${date}" pattern="yyyy" /> </font><a href="http://localhost/MSRTC/index.php#"><font><font>महाराष्ट्र राज्य
    परिवहन महामंडळाच्या</font></font></a><font><font> - सर्व हक्क राखीव</font></font></p>
<p class="right"><a href="http://localhost/MSRTC/index.php"><font><font>रचना</font></font></a><font><font> करून </font></font><a
        href="http://localhost/MSRTC/index.php"><font><font>Arceus इन्फोटेक प्रा. </font><font>लि</font></font></a></p>
<div style="clear:both;">&nbsp;</div>--%>

<jsp:include page="googleAnalytics.jsp"/>
