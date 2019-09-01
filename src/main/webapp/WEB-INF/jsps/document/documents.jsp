<%@ include file="../common/taglibs.jsp" %>



<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script type="text/javascript" src="<c:url value='/static/libs/jQuery-bootstrap/scripts/jquery.bootstrap.newsbox.min.js'/>"></script>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>


<%@ include file="../common/taglibs.jsp" %>
<script>
	function showPdfInNewTab( documentId, locale) {
		var url = "<c:url value='/file/viewPdf'/>?documentId="+documentId+"&locale="+locale;
		window.open(url,'_blank');
	}
</script>
<%-- <div class="headerbar">${headerTitle}</div> --%>
<c:if test="${ fn:length(announcementList)  gt 0}">
	<div class="headerbar" style="margin-top: 10px !important;"><fmt:message key="announcement.header" /></div>
	<div class="panel panel-default">
		<div class="panel-body">
			<div class="row">
				<div class="col-xs-12">
					<div class="adversetable">
						<table class="table table-bordered">
								<tr>
						            <th width="20%"><fmt:message key="document.title" /></th>
						            <th width="73%"><fmt:message key="document.description" /></th>
						            <th width="7%"><fmt:message key="document.file" /></th>
						        </tr>
							</table>
						<div class="announcementList">
							<c:forEach var="announcement" items="${announcementList}">
								<div class="news-item">
									<table class="table table-bordered">
										<tr>
											<td width="20%">${announcement[1]}</td>
								            <td width="73%">${announcement[2]}</td>
								            <td width="7%" class="text-center">
								            	<a href="javascript:void(0)" onclick="javascript:showPdfInNewTab('${announcement[0]}', '${ pageContext.response.locale }')" title="<fmt:message key="document.viewPdf"/>">
													<i class="fa fa-file-pdf-o fa-4" aria-hidden="true"></i>
								            	</a>
								            </td>
										</tr>
									</table>
								</div>
							</c:forEach>
				
						</div>						
					</div>
				</div>
			</div>
		</div>
	</div>
</c:if>

</body>
</html>