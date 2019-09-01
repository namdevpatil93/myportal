<%@ include file="../../common/taglibs.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1" %>

<script type="text/javascript" src="<c:url value='/static/app/js/postSelection.js'/>"></script>


<script>
    var postSelectionObj = new PostSelection();
    jQuery(document).ready(function() {
        $('#postDetails').find('input, textarea, select').attr('disabled','disabled');
        $('#personalInfo').find('input, textarea, select').attr('disabled','disabled');
        
    });
</script>

<div id="printDiv">
<table>
	<tr>
		<td valign="top" class="headerprint" style="width:15%;"><img src="static/app/images/recruitment.jpg" width="100"></td>
		<td valign="top" class="headerprint popuphead" style="width:63%;"><h5><fmt:message key="mainTitle"/></h5></td>
		<td style="width:23%;">
			<div class="row profilepic">
				<div class="col-sm-12">
					<img
						src="<c:url value='/file?operation=viewPhoto'/>&applicationId=${applicationId}&photo=${applicantFiles.photoFileName}"
						style="width: 100px;" />
				</div>
			</div>
			<div class="row signature">
				<div class="col-sm-12">
					<img
						src="<c:url value='/file?operation=viewSignature'/>&applicationId=${applicationId}&signature=${applicantFiles.signatureFileName}"
						style="width: 100px;" />
				</div>
			</div>
		</td>
	</tr>
	<tr>
	<div class="row" >
				<div class="col-sm-12" align="right">
					<p  id="currentTime" class="currentTimeClass"><%= (new java.util.Date()).toLocaleString()%></p>
				</div>
	</div>
	</tr>
</table>
<%-- <div class="row popuphead">
	<div class="col-sm-2"><img src="static/app/images/MSRTC-Recruitment.jpg" width="100"></div>
	<div class="col-sm-7">
		<h5><fmt:message key="mainTitle"/></h5>
	</div>
</div> --%>

<div id="personalInfo">
	<jsp:include page="../posts/view/viewPersonalInformation.jsp" />
</div>

<div id="OtherInfo" class="print-page-break">
	<jsp:include page="../posts/view/viewOtherInformation.jsp" />
</div>

<div id="postDetails">
    <c:choose>
        <c:when test="${ applicantPostAssoc.postId  eq 1 }">
            <jsp:include page="../posts/view/viewDriverJunior.jsp" />
        </c:when>
        <c:when test="${ applicantPostAssoc.postId  eq 2 }">
            <jsp:include page="../posts/view/viewConductorJunior.jsp" />
        </c:when>
        <c:when test="${ applicantPostAssoc.postId  eq 3 }">
            <jsp:include page="../posts/view/viewClerkTypistJunior.jsp" />
        </c:when>
        <c:when test="${ applicantPostAssoc.postId  eq 4 }">
            <jsp:include page="../posts/view/viewAssistantJunior.jsp" />
        </c:when>
        <c:when test="${ applicantPostAssoc.postId  eq 5 }">
            <jsp:include page="../posts/view/viewAssistantTrafficSuperintendentJunior.jsp" />
        </c:when>
        <c:when test="${ applicantPostAssoc.postId  eq 6 }">
            <jsp:include page="../posts/view/viewTrafficInspectorJunior.jsp" />
        </c:when>
        <c:when test="${ applicantPostAssoc.postId  eq 7 }">
            <jsp:include page="../posts/view/viewAccountantJunior.jsp" />
        </c:when>
        <c:when test="${ applicantPostAssoc.postId  eq 8 }">
            <jsp:include page="../posts/view/viewStoreSuperviserJunior.jsp" />
        </c:when>
        <c:when test="${ applicantPostAssoc.postId  eq 9 }">
            <jsp:include page="../posts/view/viewStoreKeeperJunior.jsp" />
        </c:when>
        <c:when test="${ applicantPostAssoc.postId  eq 10 }">
            <jsp:include page="../posts/view/viewSecurityInspectorJunior.jsp" />
        </c:when>
        <c:when test="${ applicantPostAssoc.postId  eq 11 }">
            <jsp:include page="../posts/view/viewAsstSecurityInspectorJunior.jsp" />
        </c:when>
        <c:when test="${ applicantPostAssoc.postId  eq 12 }">
            <jsp:include page="../posts/view/viewFireWardenJunior.jsp" />
        </c:when>
        <c:when test="${ applicantPostAssoc.postId  eq 13 }">
            <jsp:include page="../posts/view/viewJuniorEngineerCivil.jsp" />
        </c:when>
        <c:when test="${ applicantPostAssoc.postId  eq 14 }">
            <jsp:include page="../posts/view/viewJuniorEngineerElectrical.jsp" />
        </c:when>
        <c:when test="${ applicantPostAssoc.postId  eq 15 }">
            <jsp:include page="../posts/view/viewAsstWorkSuperintendentJunior.jsp"/>
        </c:when>
        <c:when test="${ applicantPostAssoc.postId  eq 16 }">
            <jsp:include page="../posts/view/viewChargeManJunior.jsp" />
        </c:when>
         <c:when test="${ applicantPostAssoc.postId  eq 17 }">
            <jsp:include page="../posts/view/viewDraftsmanMechanicsJunior.jsp" />
        </c:when>
        <c:when test="${ applicantPostAssoc.postId  eq 18 }">
            <jsp:include page="../posts/view/viewSeniorComputerOperatorJunior.jsp" />
        </c:when>
        <c:when test="${ applicantPostAssoc.postId  eq 19 }">
            <jsp:include page="../posts/view/viewGeneralManagerProject.jsp" />
        </c:when>
        <c:when test="${ applicantPostAssoc.postId  eq 20 }">
            <jsp:include page="../posts/view/viewGeneralManagerInformationTechnology.jsp" />
        </c:when>
         <c:when test="${ applicantPostAssoc.postId  eq 21 }">
            <jsp:include page="../posts/view/viewDriverCumConductor.jsp" />
        </c:when>
        <c:when test="${ applicantPostAssoc.postId  eq 22 }">
            <jsp:include page="../posts/view/viewDivisionController.jsp" />
        </c:when>
        <c:when test="${ applicantPostAssoc.postId  eq 23 }">
            <jsp:include page="../posts/view/2019/viewMachineEngineer.jsp" />
        </c:when>
        <c:when test="${ applicantPostAssoc.postId  eq 24 }">
            <jsp:include page="../posts/view/2019/viewDepartmentalTransportOfficer.jsp" />
        </c:when>
        <c:when test="${ applicantPostAssoc.postId  eq 25 }">
            <jsp:include page="../posts/view/2019/viewDeputyEquipmentEngineer.jsp" />
        </c:when>
        <c:when test="${ applicantPostAssoc.postId  eq 26 }">
            <jsp:include page="../posts/view/2019/viewAccountingOfficer.jsp" />
        </c:when>
        <c:when test="${ applicantPostAssoc.postId  eq 27 }">
            <jsp:include page="../posts/view/2019/viewStoreOfficer.jsp" />
        </c:when>
        <c:when test="${ applicantPostAssoc.postId  eq 28 }">
            <jsp:include page="../posts/view/2019/viewDivisionalTransportSuperintendent.jsp" />
        </c:when>
        <c:when test="${ applicantPostAssoc.postId  eq 29 }">
            <jsp:include page="../posts/view/2019/viewAssistantEquipmentEngineer.jsp" />
        </c:when>
        <c:when test="${ applicantPostAssoc.postId  eq 30 }">
            <jsp:include page="../posts/view/2019/viewDepartmentalAccountsOfficer.jsp" />
        </c:when>
        <c:when test="${ applicantPostAssoc.postId  eq 31 }">
            <jsp:include page="../posts/view/2019/viewDepartmentalStatisticsOfficer.jsp" />
        </c:when>
    </c:choose>
</div>
  <div class="certificate">
		<p class="text-center"><fmt:message key="undertakingTitle"/></p>
		<c:choose>
			<c:when test="${ applicantPostAssoc.postId eq 21 }">
				<p><fmt:message key="drivercumconductorUndertaking"/></p>
			</c:when>
			<c:otherwise>
				<p><fmt:message key="undertaking"/></p>
			</c:otherwise>
		</c:choose>
		<div class="row">
			<div class="col-xs-12">
				<fmt:message key="Date"/> :
			</div>
		</div>
		<div class="row">
			<div class="col-xs-6">
				<fmt:message key="Place"/> :
			</div>
			<div class="col-xs-6 text-center">
				<fmt:message key="Signature"/>
			</div>
		</div>
	</div>  
</div>
<p class="printpage" title="Print"><span class="glyphicon glyphicon-print" id="btnPrint" ></span></p>

<script type="text/javascript">


document.getElementById("btnPrint").onclick = function() 
{
// 	printElement(document.getElementById("printDiv"));
// 	 window.print();
// 	$("#printSection").remove();  
	 var printWindow = window.open('', '', '');
	   printWindow.document.write('<html><head><link rel="stylesheet" media="all" type="text/css" href="<c:url value='/static/libs/bootstrap/dist/css/bootstrap.min.css'/>"/><link rel="stylesheet" type="text/css" href="<c:url value='/static/app/css/style.css'/>"/></head><body>');
	   var divContents = $("#printDiv").html() +
	       "<script>" +
	       "window.onload = function() {" +
	       "     window.print(); window.close()" +
	       "};" +
	       "<" + "/script>";
	       printWindow.document.write(divContents);
	       printWindow.document.close();
}

<%-- 
function printElement(elem) 
{
    var domClone = elem.cloneNode(true);
    var $printSection = document.getElementById("printSection");

    if (!$printSection) {
        var $printSection = document.createElement("div");
        $printSection.id = "printSection";
        document.body.appendChild($printSection);
    }

    $printSection.appendChild(domClone);
}
--%>
</script>
