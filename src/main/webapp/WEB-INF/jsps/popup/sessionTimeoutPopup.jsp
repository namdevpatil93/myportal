<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Session Timeout Popup -->
<div class="modal fade" id="sessionTimeoutPopup" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel"><fmt:message key="sessionTimeoutPopup.title"/></h4>
            </div>
            <div class="modal-body">
                <p>
                    <span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 50px 0;"></span>
                    <fmt:message key="sessionTimeoutPopup.loggedoff.msg"/> <span id="dialog-countdown" style="font-weight:bold"></span> <fmt:message key="sessionTimeoutPopup.seconds"/>.
                </p>
                <p><fmt:message key="sessionTimeoutPopup.continueSession.msg"/></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" onclick="javascript:commonObj.logout();"><fmt:message key="sessionTimeoutPopup.logout"/></button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="keepAliveSesssion" onclick="javascript:commonObj.continueSession();"><fmt:message key="sessionTimeoutPopup.continueSession"/></button>
            </div>
        </div>
    </div>
</div>