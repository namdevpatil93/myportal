<%@ include file="../common/taglibs.jsp"%>
<%@ page pageEncoding="UTF-8"%>

<script>

    function savePostSettings(postId){
        time = new Date().getTime();
        commonObj.showConfirmation('Are you sure you want to update the Post settings?', function (result) {
            if (result) {
                var url = "<c:url value='/admin?operation=savePostSettings'/>";
                url = url+"&time="+time;

                var active = $("#post_" + postId).find(".active").is(":checked");
                var showAdmitCard = $("#post_" + postId).find(".showAdmitCard").is(":checked");
                var showUserResponse =$("#post_" + postId).find(".showUserResponse").is(":checked");

                var postSettings = {postId : postId, active : active, showAdmitCard : showAdmitCard, showUserResponse: showUserResponse};

                $.post(url, postSettings, function (result) {
                    var status = result.status;
                    if (status == 1 || status == '1') {
                        commonObj.showAlert("The post settings has been updated successfully.");
                        administrationObj.goToTab("7");
                    } else {
                        commonObj.showAlert("There was some error while trying to save the post settings.");
                    }
                });
            } else {
                administrationObj.goToTab("7");
            }
        } , '<fmt:message key="yes"/>', '<fmt:message key="no"/>','<fmt:message key="confirmationMessage.title"/>');

    }

    jQuery(document).ready(function() {

    });

</script>

<div class="form-group">
    <div class="col-sm-5">
        <span style="font-size: 9px; font-weight: bold">Post</span>
    </div>
    <div class="col-sm-2">
        <span style="font-size: 9px;font-weight: bold">Active</span>
    </div>
    <div class="col-sm-2">
        <span style="font-size: 9px;font-weight: bold">Show Admit Card</span>
    </div>
    <div class="col-sm-2">
        <span style="font-size: 9px;font-weight: bold">Show User Response</span>
    </div>
    <div class="col-sm-1">
    </div>
</div>
<hr/>

<c:forEach items="${ postList }" var="post">

    <div class="form-group" id="post_${post.postId}">
        <div class="col-sm-5">
            <span style="font-size: 10px">${ post.postTitle }</span>
        </div>
        <div class="col-sm-2">
            <div class="checkbox">
                <input type="checkbox" id="${post.postId}_active" class="active" name="active" ${ post.active ? 'checked=checked':'' } >
                <label for="${post.postId}_active"></label>
            </div>
        </div>
        <div class="col-sm-2">
            <div class="checkbox">
                <input type="checkbox" id="${post.postId}_showAdmitCard" class="showAdmitCard" name="active" ${ post.showAdmitCard ? 'checked=checked':'' } >
                <label for="${post.postId}_showAdmitCard"></label>
            </div>
        </div>
        <div class="col-sm-2">
            <div class="checkbox">
                <input type="checkbox" id="${post.postId}_showUserResponse" class="showUserResponse" name="active" ${ post.showUserResponse ? 'checked=checked':'' } >
                <label for="${post.postId}_showUserResponse"></label>
            </div>
        </div>
        <div class="col-sm-1">
            <button type="button" class="btn btn-xs btn-default command-edit"
                    onclick="javascript:savePostSettings('${post.postId}');">
                <span class="fa fa-save fa-2x"></span>
            </button>
        </div>
    </div>

</c:forEach>