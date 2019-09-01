<%@ include file="../common/taglibs.jsp"%>
<%@ page pageEncoding="UTF-8"%>

<script>

    function Qualification() {

        var qualificationObj = this;

        this.addNewQualification= function () {
            var url = "<c:url value='/qualifications?operation=newQualification'/>";
            jQuery(".tab-content").load(url, function(){

            });
        };

        this.editQualification= function (qualificationId) {
            var url = "<c:url value='/qualifications?operation=editQualification'/>" + "&id="+ qualificationId;
            jQuery(".tab-content").load(url, function(){

            });
        };

        this.deleteQualification = function(qualificationId) {
            time = new Date().getTime();
            commonObj.showConfirmation('Are you sure you want to Delete the Qualification?', function (result) {
                if (result) {
                    var url = "<c:url value='/qualifications?operation=deleteQualification'/>"+ "&id="+ qualificationId;
                    url = url+"&time="+time;
                    $.post(url, {qualificationId: qualificationId }, function (result) {
                        var success = result.success;
                        if (success) {
                            administrationObj.goToTab("1");
                        } else {
                            commonObj.showAlert("There was some error while trying to delete the qualification.");
                        }
                    });
                }
            } , '<fmt:message key="yes"/>', '<fmt:message key="no"/>','<fmt:message key="confirmationMessage.title"/>');
        };

        this.sortQualifications= function (obj, sortBy) {
            $("#sortBy").val(sortBy);

            if ($(obj).find("i").hasClass('fa-sort-asc')) {
                $("#sortOrder").val("DESC");
            } else {
                $("#sortOrder").val("ASC");
            }

            qualificationObj.goToPage(1);
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
            var url = '<c:url value="/qualifications?operation=qualificationList"/>';
            jQuery("#qualificationListResult").load(url , qualificationObj.getPaginationData(), function(){

            });
        };
        
    }

    var qualificationObj = new Qualification();

</script>

<div class="row">
    <div class="col-sm-12 text-right">
        <tags:hasPermission moduleName="qualifications" operation="saveQualification">
            <input class="btn btn-primary" type="button" value="<fmt:message key='add'/>"
                   onclick="javascript:qualificationObj.addNewQualification();">
        </tags:hasPermission>
    </div>
</div>
<br>

<c:choose>
    <c:when test="${ fn:length(page.content)  gt 0}">
        <div id="qualificationListResult">
            <jsp:include page="qualificationListResult.jsp"/>
        </div>
    </c:when>
    <c:otherwise>
        <em>There are no qualifications to display.</em>
    </c:otherwise>
</c:choose>
