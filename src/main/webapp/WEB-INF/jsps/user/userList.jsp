<%@ include file="../common/taglibs.jsp" %>

<script>

    function User() {

        var userObj = this;

        this.editUser = function (userId) {
            var editURL = "<c:url value='/user?operation=editUser&menu=adminMenuOption'/>&userId=" + userId;
            commonObj.goToURL(editURL);
        };

        this.deleteUser = function (userId) {
            commonObj.showConfirmation("Are you sure you want to delete this user?", function(result){
                if(result){
                    var deleteURL = "<c:url value='/user?operation=deleteUser&menu=adminMenuOption'/>&userId=" + userId;
                    commonObj.goToURL(deleteURL);
                }
            });
        };

        this.sortUsers = function (obj, sortBy) {

            $("#sortBy").val(sortBy);

            if ($(obj).find("i").hasClass('fa-sort-asc')) {
                $("#sortOrder").val("DESC");
            } else {
                $("#sortOrder").val("ASC");
            }

            userObj.goToPage(1);
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

            jQuery("#userListResult").load('<c:url value="/user?operation=userList"/>', userObj.getPaginationData(), function(){

            });
        };


    }

    var userObj = new User();

    $(document).ready(function() {

    });

</script>

<div>
    <h4><fmt:message key="user.list"/></h4>

    <tags:app-message message="${ message }"/>
    <tags:app-error error="${ error }" />

    <div class="row">
        <div class="col-lg-12">
            <div id="userListResult">
                <jsp:include page="userListResult.jsp"/>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-12">
            <tags:hasPermission moduleName="user" operation="saveUser">
                <input class="btn btn-primary" type="button" value="<fmt:message key='user.addNew'/>"
                       onclick="javascript:commonObj.goToURL('<c:url value='/user?operation=newUser&menu=adminMenuOption'/>');">
            </tags:hasPermission>
        </div>
    </div>

</div>

