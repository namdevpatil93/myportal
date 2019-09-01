<%@ include file="../common/taglibs.jsp"%>
<%@page pageEncoding="UTF-8"%>

<script>

    function ApplicantQuery() {

        this.BASIC_SEARCH = 1;
        this.ADVANCED_SEARCH = 2;

        var applicantQueryObj = this;

        this.editApplicantQuery= function (applicantQueryId) {
            var editURL = "<c:url value='/applicantQuery?operation=editApplicantQuery&menu=applicantQueryListMenuOption'/>&id=" + applicantQueryId;
            commonObj.goToURL(editURL);
        };

        this.deleteApplicantQuery = function (applicantQueryId) {
            commonObj.showConfirmation("Are you sure you want to delete this applicantQuery?", function(result){
                if(result){
                    var deleteURL = "<c:url value='/applicantQuery?operation=deleteApplicantQuery&menu=applicantQueryListMenuOption'/>&id=" + applicantQueryId;
                    commonObj.goToURL(deleteURL);
                }
            });
        };

        this.replyApplicantQuery= function (applicantQueryId) {
            var url = "<c:url value='/applicantQuery?operation=adminReplyApplicantQuery'/>" + "&id="+ applicantQueryId;
            jQuery(".tab-content").load(url, function(){

            });
        };
        
        this.sortApplicantQueries= function (obj, sortBy) {

            $("#sortBy").val(sortBy);

            if ($(obj).find("i").hasClass('fa-sort-asc')) {
                $("#sortOrder").val("DESC");
            } else {
                $("#sortOrder").val("ASC");
            }

            applicantQueryObj.goToPage(1);
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

            jQuery("#applicantQueryListResult").load('<c:url value="/applicantQuery?operation=applicantQueryListAdmin"/>', applicantQueryObj.getPaginationData(), function(){

            });
        };


    }

    var applicantQueryObj = new ApplicantQuery();

    $(document).ready(function() {

    });

</script>

<c:if test="${!empty message}">
    <div class="alert alert-success alert-dismissible" role="alert">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        ${ message }
    </div>
</c:if>

<c:if test="${!empty error}">
    <div class="alert alert-danger alert-dismissible" role="alert">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        ${ error }
    </div>
</c:if>

    <div class="panel-body">
        <div id="applicantQueryListResult">
            <c:choose>
                <c:when test="${ page.content ne null and fn:length(page.content) gt 0}">
                    <jsp:include page="applicantQueryListResult.jsp"/>
                </c:when>
                <c:otherwise>
                    <em>There are no queries yet.</em>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

