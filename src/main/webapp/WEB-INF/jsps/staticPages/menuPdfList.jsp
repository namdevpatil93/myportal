<%@ include file="../common/taglibs.jsp" %>
<script>
	function showPdfInNewTab( documentId, locale) {
		var url = "<c:url value='/file/viewPdf'/>?documentId="+documentId+"&locale="+locale;
		window.open(url,'_blank');
	}
</script>
<%-- <div class="headerbar">${headerTitle}</div> --%>

<c:choose>
    <c:when test="${ fn:length(documentList)  gt 0}">
		
		<div  class="adversetable">
		<br>
    <c:forEach var="category" items="${docCategoryList}">
   
 <h4><font style="font-weight: bold; "> ${category[1] }</font></h4>
   
      <c:forEach var="subcategory" items="${subdocCategoryList}">   
              
       <c:if test="${category[0]==subcategory[0] }">
           
   <div style="padding-bottom: 15px;padding-top: 10px;">  <h5><font style="font-weight: bold; margin-left: 20px"> ${subcategory[1] }</font></h5></div>
   
		    <table class="table table-bordered" style="margin-left:30px; width: 90%">
		        <tr>
		            <th width="20%"><fmt:message key="document.title" /></th>
		            <th><fmt:message key="document.description" /></th>
		            <th width="10%"><fmt:message key="document.file" /></th>
		        </tr> 
		       <c:forEach var="document" items="${documentList}">
		         
		       <c:if test="${category[0]==document[3] && document[4]==subcategory[2] }">
		       <tr>
			            <td>${document[1]}</td>
			            <td>${document[2]}</td>
			            <td class="text-center">
			            	<a href="javascript:void(0)" onclick="javascript:showPdfInNewTab('${document[0]}', '${ pageContext.response.locale }')" title="<fmt:message key="document.viewPdf"/>">
			            		<i class="fa fa-file-pdf-o fa-4" aria-hidden="true"></i>
			            	</a>
			            </td>
			        </tr>
			        </c:if>   
			       </c:forEach> 
		    </table>
		    <br>
		    </c:if>
		    </c:forEach> 
		     </c:forEach>     
		</div>
    </c:when>
    <c:otherwise>
    	<h4>&nbsp;</h4>
        <em>
			<fmt:message key="comingSoon" />
		</em>
    </c:otherwise>
</c:choose>

