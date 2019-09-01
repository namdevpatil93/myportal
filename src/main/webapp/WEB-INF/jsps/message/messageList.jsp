<%@ include file="../common/taglibs.jsp"%>
<%@ page pageEncoding="UTF-8"%>

<script>

    function Message() {

        var messageObj = this;

        this.addNewMessage= function () {
            var url = "<c:url value='/messages?operation=newMessage'/>";
            jQuery(".tab-content").load(url, function(){

            });
        };

        this.editMessage= function (messageId) {
            var url = "<c:url value='/messages?operation=editMessage'/>" + "&id="+ messageId;
            jQuery(".tab-content").load(url, function(){

            });
        };

        this.deleteMessage = function(messageId) {
            time = new Date().getTime();
            commonObj.showConfirmation('Are you sure you want to Delete the Message?', function (result) {
                if (result) {
                    var url = "<c:url value='/messages?operation=deleteMessage'/>"+ "&id="+ messageId;
                    url = url+"&time="+time;
                    $.post(url, {messageId: messageId }, function (result) {
                        var success = result.success;
                        if (success) {
                            administrationObj.goToTab("3");
                        } else {
                            commonObj.showAlert("There was some error while trying to delete the message.");
                        }
                    });
                }
            } , '<fmt:message key="yes"/>', '<fmt:message key="no"/>','<fmt:message key="confirmationMessage.title"/>');
        };

        this.sortMessages= function (obj, sortBy) {
            $("#sortBy").val(sortBy);

            if ($(obj).find("i").hasClass('fa-sort-asc')) {
                $("#sortOrder").val("DESC");
            } else {
                $("#sortOrder").val("ASC");
            }

            messageObj.goToPage(1);
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
            var url = '<c:url value="/messages?operation=messageList"/>';
            jQuery("#messageListResult").load(url , messageObj.getPaginationData(), function(){

            });
        };
        
    }

    var messageObj = new Message();

</script>

<div class="row">
    <div class="col-sm-12 text-right">
        <tags:hasPermission moduleName="messages" operation="saveMessage">
            <input class="btn btn-primary" type="button" value="<fmt:message key='add'/>"
                   onclick="javascript:messageObj.addNewMessage();">
        </tags:hasPermission>
    </div>
</div>
<br>

<c:choose>
    <c:when test="${ fn:length(page.content)  gt 0}">
        <div id="messageListResult">
            <jsp:include page="messageListResult.jsp"/>
        </div>
    </c:when>
    <c:otherwise>
        <em>There are no messages to display.</em>
    </c:otherwise>
</c:choose>
