<%@ include file="../../common/taglibs.jsp"%>

<link rel="stylesheet" href="<c:url value='/static/libs/smartwizard/css/smart_wizard.min.css'/>" >
<link rel="stylesheet" href="<c:url value='/static/libs/smartwizard/css/smart_wizard_theme_circles.min.css'/>" >
<link rel="stylesheet" href="<c:url value='/static/libs/smartwizard/css/smart_wizard_theme_arrows.min.css'/>" >
<link rel="stylesheet" href="<c:url value='/static/libs/smartwizard/css/smart_wizard_theme_dots.min.css'/>" >

<script type="text/javascript" src="<c:url value='/static/app/js/apply.js'/>"></script>

<script>

    var appBasePath = '<c:url value="/"/>';
    var applyObj = new Apply(appBasePath);
    var postId = '${ postId }';

    jQuery(document).ready(function() {
        if(postId != null && postId != '' && postId != undefined){
            applyObj.gotoTab('${ tabNo }')
        }
    });

</script>

<br><br>
<input type="hidden" id="notEligibleForPost" value="<fmt:message key="notEligibleForPost"/>"/>
<div class="container">
    <div class="sw-main sw-theme-arrows">
        <ul class="nav nav-tabs step-anchor">
            <li class="active" onclick="javascript:applyObj.gotoTab('1')" id="personalInformationTab"><a><fmt:message key="apply.personalInformation" /><br></a></li>
            <li onclick="javascript:applyObj.gotoTab('2')"  id="otherInformationTab"><a><fmt:message key="apply.otherInformation" /><br></a></li>
            <c:if test="${ disablePostSelection ne 1 and disablePostSelection ne '1'}">
                <li onclick="javascript:applyObj.gotoTab('3')" id="postSelectionTab"><a><fmt:message key="apply.postSelection" /><br></a></li>
            </c:if>
            <li onclick="javascript:applyObj.gotoTab('4')" id="photoAndSignatureTab"><a><fmt:message key="apply.photoAndSignature" /><br></a></li>
            <li onclick="javascript:applyObj.gotoTab('5')" id="confirmationTab"><a><fmt:message key="apply.confirmation" /><br></a></li>

            <c:if test="${ disablePayments ne 1 and disablePayments ne '1'}">
                <li id="paymentTab"><a><fmt:message key="apply.payment" /><br></a></li>
            </c:if>
        </ul>
        <div class="sw-container">
            <div id="applySteps" class="step-content custom-panel" style="display: block;">
                <jsp:include page="personalInformation.jsp" />
            </div>
        </div>
    </div>
</div>