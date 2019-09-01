<%@ page contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1" %>
<%@ include file="../../common/taglibs.jsp"%>

<script>
    $(document).ready(function(){
        $("#gotoOnlinePaymentPageForm").submit();
    });
</script>
<div style="width:100%;" class="text-center">
<form action="${ billDeskURL }" id="gotoOnlinePaymentPageForm" name="gotoOnlinePaymentPageForm" method="post">
    <input type="hidden" name="msg" value="${msg}">
</form>

<p> <p>Redirecting to payment gateway.</p><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i></p>
</div>