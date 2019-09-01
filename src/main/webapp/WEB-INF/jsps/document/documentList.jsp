<%@ include file="../common/taglibs.jsp"%>
<%@ page pageEncoding="UTF-8"%>

<script>

    function Document() {

        var documentObj = this;

        this.addNewDocument= function () {
            var documentType = $("#documentType").val();
            var url = "<c:url value='/documents?operation=newDocument'/>" + "&documentType=" + documentType;
            jQuery(".tab-content").load(url, function(){

            });
        };

        this.editDocument= function (documentId) {
            var documentType = $("#documentType").val();
            var url = "<c:url value='/documents?operation=editDocument'/>" + "&id="+ documentId +"&documentType=" + documentType;
            jQuery(".tab-content").load(url, function(){

            });
        };

        this.changeStatus= function (documentId, active) {
            var documentType = $("#documentType").val();
            var url = "<c:url value='/documents?operation=changeStatus'/>";

            if(active == true || active == 'true'){
                active = false
            } else {
                active = true;
            }

            $.ajax({
                type: "POST",
                url: url,
                data: { documentId: documentId, active : active },
                success: function(){
                    documentsObj.viewDocuments(documentType);
                },
                dataType: 'json'
            });
        };

        this.sortDocuments= function (obj, sortBy) {

            $("#sortBy").val(sortBy);

            if ($(obj).find("i").hasClass('fa-sort-asc')) {
                $("#sortOrder").val("DESC");
            } else {
                $("#sortOrder").val("ASC");
            }

            documentObj.goToPage(1);
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
            var documentType = $("#documentType").val();
            var url = '<c:url value="/documents?operation=documentList"/>&documentType=' + documentType;
            jQuery("#documentListResult").load(url , documentObj.getPaginationData(), function(){

            });
        };
        
    }

    var documentObj = new Document();

</script>

<div class="row">
    <div class="col-sm-12 text-right">
        <tags:hasPermission moduleName="documents" operation="saveDocument">
            <input class="btn btn-primary" type="button" value="<fmt:message key='add'/>"
                   onclick="javascript:documentObj.addNewDocument();">
        </tags:hasPermission>
    </div>
</div>
<br>

<%--
<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title"><fmt:message key="document.list"/></h3>
    </div>
    <div class="panel-body">
--%>
        <c:choose>
            <c:when test="${ fn:length(page.content)  gt 0}">
                <div id="documentListResult">
                    <jsp:include page="documentListResult.jsp"/>
                </div>
            </c:when>
            <c:otherwise>
                <em>There are no records to display.</em>
            </c:otherwise>
        </c:choose>
<%--
    </div>
</div>
--%>




