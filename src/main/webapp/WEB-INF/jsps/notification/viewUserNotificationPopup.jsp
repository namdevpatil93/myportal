<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Disclaimer Popup -->
<div class="modal fade" id="viewUserNotificationPopup" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel"><fmt:message key="viewUserNotificationPopup.title"/></h4>
            </div>
            <div class="modal-body">
                <div id="notificationTitle"></div><br/>
                <div id="notificationText"></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><fmt:message key="securityInspectorJr.modal.close"/></button>
            </div>
        </div>
    </div>
</div>