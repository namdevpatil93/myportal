<%@ include file="../common/taglibs.jsp"%>
<%@page pageEncoding="UTF-8"%>

<script>

    function Notification() {

        this.BASIC_SEARCH = 1;
        this.ADVANCED_SEARCH = 2;

        var notificationObj = this;

        this.addNewNotification = function () {
            var url = "<c:url value='/notification?operation=newNotification'/>";
            jQuery(".tab-content").load(url, function(){

            });
        };
        
        this.deleteNotification = function (notificationId) {
            commonObj.showConfirmation("Are you sure you want to delete this notification?", function(result){
                if(result){
                    var deleteURL = "<c:url value='/notification?operation=deleteNotification&menu=notificationListMenuOption'/>&id=" + notificationId;
                    commonObj.goToURL(deleteURL);
                }
            }, '<fmt:message key="yes"/>', '<fmt:message key="no"/>','<fmt:message key="confirmationMessage.title"/>');
        };

        this.sortNotifications= function (obj, sortBy) {

            $("#sortBy").val(sortBy);

            if ($(obj).find("i").hasClass('fa-sort-asc')) {
                $("#sortOrder").val("DESC");
            } else {
                $("#sortOrder").val("ASC");
            }

            notificationObj.goToPage(1);
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

            jQuery("#notificationListResult").load('<c:url value="/notification?operation=notificationList"/>', notificationObj.getPaginationData(), function(){

            });
        };


    }

    var notificationObj = new Notification();

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

<!-- <div class="panel panel-default"> -->
    <!-- <div class="panel-heading"> -->
       <%-- <h3 class="panel-title"><fmt:message key="notification.list"/></h3>--%>
    <!-- </div> -->
    <!-- <div class="panel-body"> -->
        <div id="notificationListResult">
            <c:choose>
                <c:when test="${ page.content ne null and fn:length(page.content) gt 0}">
                    <jsp:include page="notificationListResult.jsp"/>
                </c:when>
                <c:otherwise>
                    <em>You have not sent any notifications yet. <br><br> </em>
                </c:otherwise>
            </c:choose>
        </div>
    <!-- </div> -->
<!-- </div> -->


<div class="row">
    <div class="col-sm-6">
        <tags:hasPermission moduleName="notification" operation="saveNotification">
            <input class="btn btn-primary" type="button" value="<fmt:message key='notification.addNew'/>"
                   onclick="javascript:notificationObj.addNewNotification();">
        </tags:hasPermission>
    </div>
</div>

