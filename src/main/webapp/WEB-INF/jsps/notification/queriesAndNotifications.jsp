<%@ include file="../common/taglibs.jsp"%>

<script>

    function viewQueries(){
        var url = '<c:url value="/applicantQuery?operation=applicantQueryListAdmin"/>';
        jQuery(".tab-content").load(url, function() {
            $("#tabQueriesLi").addClass("active");
            $("#tabNotificationLi").removeClass("active");
        });
    }

    function viewNotifications(){
        var url = '<c:url value="/notification?operation=notificationList"/>';
        jQuery(".tab-content").load(url, function() {
            $("#tabNotificationLi").addClass("active");
            $("#tabQueriesLi").removeClass("active");
        });
    }

    $(document).ready(function() {
    	var viewNotificationsPage= '${ viewNotificationsPage }';
    	if(viewNotificationsPage == true || viewNotificationsPage == 'true' ){
    		viewNotifications();
    	} else {
            viewQueries();
    	}
    });

</script>


<div class="container">
    <div class="custom-panel">
        <ul class="nav nav-pills nav-stacked">
            <li id="tabQueriesLi"><a href="javascript:void(0);" onclick="javascript:viewQueries();">Queries</a></li>
            <li id="tabNotificationLi"><a href="javascript:void(0);" onclick="javascript:viewNotifications();">Notifications</a></li>
        </ul>
        <div class="tab-content">
            <div class="tab-pane active"></div>
        </div>
    </div>
</div>
<br>
<br>
<br>
