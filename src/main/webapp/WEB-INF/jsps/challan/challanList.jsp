<%@ include file="../common/taglibs.jsp"%>

<script>

    function Challan() {

        this.BASIC_SEARCH = 1;
        this.ADVANCED_SEARCH = 2;

        var challanObj = this;

        this.sortChallans= function (obj, sortBy) {

            $("#sortBy").val(sortBy);

            if ($(obj).find("i").hasClass('fa-sort-asc')) {
                $("#sortOrder").val("DESC");
            } else {
                $("#sortOrder").val("ASC");
            }

            challanObj.goToPage(1);
        };

        this.getPaginationData = function() {

            var searchType = $("#searchType").val();

            switch(searchType){
                case "1":
                    return {
                        size : $("#size").val(),
                        pageNumber : $("#pageNumber").val(),
                        sortBy : $("#sortBy").val(),
                        sortOrder : $("#sortOrder").val(),
                        newPage : $("#newPage").val(),
                        searchType : $("#searchType").val(),
                        searchText : $("#searchText").val()
                    };
                    break;
                default:
                    return {
                        size : $("#size").val(),
                        pageNumber : $("#pageNumber").val(),
                        sortBy : $("#sortBy").val(),
                        sortOrder : $("#sortOrder").val(),
                        newPage : $("#newPage").val(),
                        searchType : $("#searchType").val()
                    };
                    break;
            }
        };

        this.goToPage = function(pageNumber) {
            $("#pageNumber").val(pageNumber);
            $("#newPage").val(true);

            jQuery("#challanListResult").load('<c:url value="/challan?operation=challanList"/>', challanObj.getPaginationData(), function(){

            });
        };
    }

    var challanObj = new Challan();
    $(document).ready(function() {

    });

</script>

<c:choose>
    <c:when test="${ page.content ne null and fn:length(page.content) gt 0 }">
        <div class="panel panel-default">
            <div class="panel-body">
                <div id="challanListResult">
                    <jsp:include page="challanListResult.jsp"/>
                </div>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        There are no records to display
    </c:otherwise>
</c:choose>