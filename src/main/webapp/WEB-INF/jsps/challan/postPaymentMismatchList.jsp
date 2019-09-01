<%@ include file="../common/taglibs.jsp"%>

<script type="text/javascript">
	function PostPaymentMismatch(){
		
		this.BASIC_SEARCH = 1;
        this.ADVANCED_SEARCH = 2;
        
        var postPaymentMisMatchObj = this;
		
		this.getPaginationData = function() {

            var searchType = 1;

            switch(searchType){
                case "1":
                    return {
                        size : $("#size").val(),
                        pageNumber : $("#pageNumber").val(),
                        sortBy : $("#sortBy").val(),
                        sortOrder : $("#sortOrder").val(),
                        newPage : $("#newPage").val(),
                        fromDateForCount : $("#sDate").val(),
                        toDateForCount : $("#tDate").val()
                    };
                    break;
                default:
                    return {
                        size : $("#size").val(),
                        pageNumber : $("#pageNumber").val(),
                        sortBy : $("#sortBy").val(),
                        sortOrder : $("#sortOrder").val(),
                        newPage : $("#newPage").val(),
                        fromDateForCount : $("#sDate").val(),
                        toDateForCount : $("#tDate").val()
                    };
                    break;
            }
        }
		
		this.goToPage = function(pageNumber) {
            $("#pageNumber").val(pageNumber);
            $("#newPage").val(true);

            jQuery("#postPaymentMismatchListResult").load('<c:url value="/challan?operation=showPostPaymentMismatchCount"/>', postPaymentMisMatchObj.getPaginationData(), function(){

            });
        };
	}
	var postPaymentMisMatchObj = new PostPaymentMismatch();
</script>
<c:choose>
    <c:when test="${ pageData.content ne null and fn:length(pageData.content) gt 0 }">
        <div class="panel panel-default">
            <div class="panel-body">
                <div id="postPaymentMismatchListResult">
                    <jsp:include page="postPaymentMismatchResultList.jsp"/>
                </div>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        There are no records to display
    </c:otherwise>
</c:choose>