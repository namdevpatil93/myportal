<%@ include file="../common/taglibs.jsp"%>
<%@ page pageEncoding="UTF-8"%>

<script>
     $(function() {
         initiateSwitch();
     })

    function initiateSwitch(){
        $('.toggle').bootstrapToggle({
            on: 'On',
            off: 'Off'
        });
    }
</script>
<script>

    function Advertisement() {

        this.BASIC_SEARCH = 1;
        this.ADVANCED_SEARCH = 2;

        var advertisementObj = this;
        
        this.addNewAdvertisement= function () {
            var documentType = '${documentType}';
            var url = "<c:url value='/advertisement?operation=newAdvertisement&menu=advertisementListMenuOption'/>";
            jQuery(".tab-content").load(url, function(){

            });
        };

        this.editAdvertisement= function (advertisementId) {
        	var documentType = '${documentType}';
            var editURL = "<c:url value='/advertisement?operation=editAdvertisement&menu=advertisementListMenuOption'/>&id=" + advertisementId;
            jQuery(".tab-content").load(editURL, function(){

            });
        };

        this.sortAdvertisements= function (obj, sortBy) {

            $("#sortBy").val(sortBy);

            if ($(obj).find("i").hasClass('fa-sort-asc')) {
                $("#sortOrder").val("DESC");
            } else {
                $("#sortOrder").val("ASC");
            }

            advertisementObj.goToPage(1);
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
            var url = '<c:url value="/advertisement?operation=advertisementList"/>&documentType=' + documentType;
            jQuery("#advertisementListResult").load(url , advertisementObj.getPaginationData(), function(){
                initiateSwitch();
            });
        };
		
        this.changeStatus= function (advertisementId, active) {
            //var documentType = "${ documentType }";
            var url = "<c:url value='/advertisement?operation=changeStatus'/>";
            
            if(active == true || active == 'true'){
                active = false
            } else {
                active = true;
            }

            $.ajax({
                type: "POST",
                url: url,
                data: { advertisementId: advertisementId, active : active  },
                success: function(){
                	documentsObj.viewAdvertisement('${documentType}');
                },
                dataType: 'json'
            });
        };

    }

    var advertisementObj = new Advertisement();

    $(document).ready(function() {

    });

</script>

<div class="row">
    <div class="col-sm-12 text-right">
        <tags:hasPermission moduleName="advertisement" operation="saveAdvertisement">
            <input class="btn btn-primary" type="button" value="<fmt:message key='add'/>"
                   onclick="javascript:advertisementObj.addNewAdvertisement()">
        </tags:hasPermission>
    </div>
</div>
<br>

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

<%--
<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title"><fmt:message key="advertisement.list"/></h3>
    </div>
    <div class="panel-body">
--%>
        <c:choose>
            <c:when test="${ fn:length(page.content)  gt 0}">
                <div id="advertisementListResult">
                    <jsp:include page="advertisementListResult.jsp"/>
                </div>
            </c:when>
            <c:otherwise>
                    There are no advertisements to display.
            </c:otherwise>
        </c:choose>
<%--
    </div>
</div>
--%>

