<%@ include file="../common/taglibs.jsp"%>

<script>

    function UserNotification() {

        this.BASIC_SEARCH = 1;
        this.ADVANCED_SEARCH = 2;

        var userNotificationObj = this;

       /*  this.editNotification= function (notificationId) {
            var editURL = "<c:url value='/notification?operation=editNotification&menu=notificationListMenuOption'/>&id=" + notificationId;
            commonObj.goToURL(editURL);
        };

        this.deleteNotification = function (notificationId) {
            commonObj.showConfirmation("Are you sure you want to delete this notification?", function(result){
                if(result){
                    var deleteURL = "<c:url value='/notification?operation=deleteNotification&menu=notificationListMenuOption'/>&id=" + notificationId;
                    commonObj.goToURL(deleteURL);
                }
            });
        };
 */
        this.sortUserNotifications= function (obj, sortBy) {

            $("#sortBy").val(sortBy);

            if ($(obj).find("i").hasClass('fa-sort-asc')) {
                $("#sortOrder").val("DESC");
            } else {
                $("#sortOrder").val("ASC");
            }

            userNotificationObj.goToPage(1);
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

            jQuery("#userNotificationListResult").load('<c:url value="/notification?operation=userNotificationList"/>', userNotificationObj.getPaginationData(), function(){

            });
        };


    }

    var userNotificationObj = new UserNotification();

    $(document).ready(function() {

    });

</script>
 <h4><fmt:message key="userNotification.list"/></h4>
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

<div class="panel panel-default">
    <div class="panel-body">
        <div id="userNotificationListResult">
            <c:choose>
                <c:when test="${ page.content ne null and fn:length(page.content) gt 0}">
                    <jsp:include page="userNotificationListResult.jsp"/>
                </c:when>
                <c:otherwise>
                    <em><fmt:message key='notification.notificationsNotAdded.message'/></em>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<jsp:include page="viewUserNotificationPopup.jsp"/>