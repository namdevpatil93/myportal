<%@ include file="../common/taglibs.jsp"%>

<script>

    function ChallanFile() {

        this.BASIC_SEARCH = 1;
        this.ADVANCED_SEARCH = 2;

        var challanFileObj = this;

        this.downloadChallanFile = function(challanFileId){
            var url = "<c:url value='/file?operation=downloadChallanFile'/>" + "&challanFileId=" + challanFileId;
            commonObj.goToURL(url);
        };

        this.sortChallanFiles= function (obj, sortBy) {

            $("#sortBy").val(sortBy);

            if ($(obj).find("i").hasClass('fa-sort-asc')) {
                $("#sortOrder").val("DESC");
            } else {
                $("#sortOrder").val("ASC");
            }

            challanFileObj.goToPage(1);
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

            jQuery("#challanFileListResult").load('<c:url value="/challan?operation=challanFileList"/>', challanFileObj.getPaginationData(), function(){

            });
        };


    }

    var challanFileObj = new ChallanFile();

    $(document).ready(function() {

    });

</script>

<c:choose>
    <c:when test="${ page.content ne null and fn:length(page.content) gt 0 }">
        <div class="panel panel-default">
            <div class="panel-body">
                <div id="challanFileListResult">
                    <jsp:include page="challanFileListResult.jsp"/>
                </div>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        There are no records to display
    </c:otherwise>
</c:choose>