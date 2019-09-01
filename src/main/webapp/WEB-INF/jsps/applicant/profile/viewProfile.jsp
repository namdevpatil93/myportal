<%@ include file="../../common/taglibs.jsp"%>
<div class="container">
	<div class="custom-panel">
		<ul class="nav nav-pills nav-stacked">
		    <li class="active"><a href="#personalInformationTab" data-toggle="pill"><fmt:message key="apply.personalInformation"/></a></li>
			<c:if test="${ applicantOtherinfo ne null}">
		    	<li><a href="#otherInformationTab" data-toggle="pill"><fmt:message key="apply.otherInformation"/> </a></li>
			</c:if>
		</ul>
		<div class="tab-content">
		    <div class="tab-pane active" id="personalInformationTab">
		        <jsp:include page="personalInformation.jsp"/>
		    </div>
			<c:if test="${ applicantOtherinfo ne null}">
				<div class="tab-pane" id="otherInformationTab">
					<jsp:include page="otherInformation.jsp"/>
				</div>
			</c:if>
		</div>
	</div>
</div>
<br>
<br>
<br>
