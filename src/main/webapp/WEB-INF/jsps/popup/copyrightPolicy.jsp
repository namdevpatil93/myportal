<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Terms Of Use Popup -->
<div class="modal fade" id="copyrightPolicyPopup" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel"><fmt:message key="copyrightPolicy.heading"/></h4>
            </div>
            <div class="modal-body">
                <p><fmt:message key="copyrightPolicy.text1"/></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="skipDisabling btn btn-default" data-dismiss="modal"><fmt:message key="securityInspectorJr.modal.close"/></button>
            </div>
        </div>
    </div>
</div>