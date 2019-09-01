<%@ include file="../common/taglibs.jsp"%>

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
            commonObj.showConfirmation("<fmt:message key='applicantQuery.confirmDelete'/>", function(result){
                if(!result){
                    var deleteURL = "<c:url value='/applicantQuery?operation=deleteApplicantQuery&menu=applicantQueryListMenuOption'/>&id=" + applicantQueryId;
                    commonObj.goToURL(deleteURL);
                }
            },"<fmt:message key='no'/>","<fmt:message key='yes'/>","<fmt:message key='applicantQuery.delete'/>");
        };
        
        this.replyApplicantQuery= function (applicantQueryId) {
            var url = "<c:url value='/applicantQuery?operation=replyApplicantQuery'/>" + "&id="+ applicantQueryId;
            commonObj.goToURL(url);
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

            jQuery("#applicantQueryListResult").load('<c:url value="/applicantQuery?operation=applicantQueryList"/>', applicantQueryObj.getPaginationData(), function(){

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

<div class="row">
    <div class="col-sm-6">
        <tags:hasPermission moduleName="applicantQuery" operation="saveApplicantQuery">
            <input class="btn btn-primary" type="button" value="<fmt:message key='applicantQuery.addNew'/>"
                   onclick="javascript:commonObj.goToURL('<c:url value='/applicantQuery?operation=newApplicantQuery&menu=applicantQueryListMenuOption'/>');">
        </tags:hasPermission>
        <br> <br>
    </div>
</div>

<div id="applicantQueryListResult">
    <c:choose>
        <c:when test="${ page.content ne null and fn:length(page.content) gt 0}">
            <jsp:include page="applicantQueryListResult.jsp"/>
        </c:when>
        <c:otherwise>
            <em><fmt:message key='applicantQuery.queryNotAdded.message'/></em>
        </c:otherwise>
    </c:choose>
</div>

