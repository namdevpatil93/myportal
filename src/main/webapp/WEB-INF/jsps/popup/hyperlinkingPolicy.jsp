<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Terms Of Use Popup -->
<div class="modal fade" id="hyperlinkingPolicyPopup" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel"><fmt:message key="hyperlinkingPolicy.heading"/></h4>
            </div>
            <div class="modal-body">
                <p><fmt:message key="hyperlinkingPolicy.text1"/></p>
                <p><fmt:message key="hyperlinkingPolicy.text2"/></p>
                <p><fmt:message key="hyperlinkingPolicy.text3"/></p>
                <p><fmt:message key="hyperlinkingPolicy.text4"/></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="skipDisabling btn btn-default" data-dismiss="modal"><fmt:message key="securityInspectorJr.modal.close"/></button>
            </div>
        </div>
    </div>
</div>