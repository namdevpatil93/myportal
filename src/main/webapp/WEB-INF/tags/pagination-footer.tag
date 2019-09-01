<%@ include file="../jsps/common/taglibs.jsp"%>

<%@ attribute name="page" type="org.springframework.data.domain.Page" required="true" rtexprvalue="true" description="The Current Page" %>
<%@ attribute name="callback" required="true" rtexprvalue="true" description="The js function name to get next page." %>

<c:set var="currentPageNo"  value="${page.number + 1}"/>
<%-- <c:set var="beginIndex"     value="${Math.max(1, currentPageNo - 5)}" />
<c:set var="endIndex"       value="${Math.min(beginIndex + 10, Long.valueOf(page.totalPages))}"/>
 --%>
<script>

    function Pagination(){

        this.goToPage = function(pageNumber){
            var callback = ${ callback };
            callback(pageNumber);
        }
    }

    var paginationObj = new Pagination();

</script>

<nav>
    <div id="role-grid-footer" class="pagination-footer container-fluid">
        <div class="row">
            <div class="pull-left">
                <div class="infos">
                   <em>
                       Showing ${ currentPageNo * page.size - (page.size - 1 )} to ${(currentPageNo * page.size - (page.size ))+ page.numberOfElements} of ${page.totalElements} entries
                   </em>
                </div>
            </div>
            <div class="pull-right">
                <ul class="pagination pagination-sm">
                    <c:choose>
                        <c:when test="${currentPageNo == 1}">
                            <li class="disabled"><a>&laquo;</a></li>
                            <li class="disabled"><a>&lt;</a></li>
                        </c:when>
                        <c:otherwise>
                            <%-- go to first page --%>
                            <li><a href="javascript:void(0);" onclick="javascript:paginationObj.goToPage('1');">&laquo;</a></li>
                            <%-- go to previous page --%>
                            <li><a href="javascript:void(0);" onclick="javascript:paginationObj.goToPage('${currentPageNo - 1}');">&lt;</a></li>
                        </c:otherwise>
                    </c:choose>
                    <c:forEach var="i" begin="${beginIndex}" end="${endIndex}">
                        <c:choose>
                            <c:when test="${i == currentPageNo}">
                                <li class="active"><a><c:out value="${i}" /></a></li>
                            </c:when>
                            <c:otherwise>
                                <li><a href="javascript:void(0);" onclick="javascript:paginationObj.goToPage('${i}');"><c:out value="${i}" /></a></li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:choose>
                        <c:when test="${currentPageNo == page.totalPages}">
                            <li class="disabled"><a>&gt;</a></li>
                            <li class="disabled"><a>&raquo;</a></li>
                        </c:when>
                        <c:otherwise>
                            <%-- go to next page --%>
                            <li><a href="javascript:void(0);" onclick="javascript:paginationObj.goToPage('${currentPageNo + 1}');">&gt;</a></li>
                            <%-- go to last page --%>
                            <li><a href="javascript:void(0);" onclick="javascript:paginationObj.goToPage('${page.totalPages}');">&raquo;</a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </div>
</nav>