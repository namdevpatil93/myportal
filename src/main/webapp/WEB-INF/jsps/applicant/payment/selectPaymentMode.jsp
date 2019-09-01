<%@ page contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1" %>
<%@ include file="../../common/taglibs.jsp"%>

<script>

    function selectPaymentMode(flag, isCancelClicked){
    	if(!isCancelClicked){
    		jQuery("#paymentProceedBtn").attr("disabled",true);
    	}
        
    	if (flag)
        {
	        var onlinePayment = $("#onlinePayment").is(":checked");
	        var paymentMode = 2;
	
	        if(onlinePayment ){
	            paymentMode = 1;
	        }
	
	        var url = "<c:url value='/payment?operation=makePayment'/>";
	
	        jQuery("#applySteps").load(url, $('#selectPaymentModeForm').serializeArray(), function(){
	            applyObj.markTabAsActive("paymentTab");
	        });
    	}
    }
   
	function offlinePaymentConfirmPopup()
	{
		var total = $( '.checkbox' ).find('input:checked').length;
		
		if ($("input[type=radio]:checked").length < 1) {
			var msg = '<fmt:message key="apply.payment.select.one"/>' ;
    		commonObj.showAlert(msg);
    		return;
		}
		if(total < 1)
		{
			var msg = '<fmt:message key="payment.selectPosts"/>' ;
    		commonObj.showAlert(msg);
    		return;
		}
		else
		{
			if($("#offlinePayment").is(":checked"))
			{
				//var msg = "<fmt:message key='payment.offline.confirm'/>" ;
				commonObj.showConfirmation('<fmt:message key="payment.offline.confirm"/>', selectPaymentMode, '<fmt:message key="confirm"/>', '<fmt:message key="cancel"/>','<fmt:message key="payment.offline.mode"/>');
			}else
			{
				selectPaymentMode(true, false);
			}
		}
	}

</script>

<form class="form-horizontal"
      name="selectPaymentModeForm"
      id="selectPaymentModeForm"
      data-toggle="validator"
      method="POST"
      novalidate
      style="width:100%;">

    <%--<h4 class="">Please select the Posts to make Payment.</h4>--%>
    <div class="form-group">
        <label class="control-label col-sm-3 "><fmt:message key="payment.selectPosts"/> : <span class="red">*</span></label>
        <div class="col-sm-8">
            <c:forEach items="${postsAppliedFor }" var="postAppliedFor">
            	<c:choose>
            		<c:when test="${postAppliedFor.transactionStatus == 0 || postAppliedFor.transactionStatus == 2 }">
		                <div class="checkbox">
		                    <input id="checkBox_${ postAppliedFor.id }" type="checkbox" name="selectedPostAssocIds" value="${ postAppliedFor.id }"/>
		                    <label for="checkBox_${ postAppliedFor.id }"><fmt:message key="${postAppliedFor.post.messageKey }"/></label>
		                </div>
		            </c:when>
		            <c:otherwise>
		            	<div class="checkbox">
		                    <input id="checkBox_${ postAppliedFor.id }" type="hidden" name="selectedPostAssocIds" value="${ postAppliedFor.id }" disabled="disabled"/>
		                    <label class="checkbox_disabled" for="checkBox_${ postAppliedFor.id }"><fmt:message key="${postAppliedFor.post.messageKey }" /></label>
		                </div>
		            </c:otherwise>
	           </c:choose>
            </c:forEach>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-3 "><fmt:message key="payment.paymentMode"/> : <span class="red">*</span></label>
        <div class="col-sm-8">
            <div id="onlinePaymentId" class="radio radio-inline">
                <input type="radio" name="paymentMode" value="1" class="form-control" id="onlinePayment" required>
                <label for="onlinePayment"> <fmt:message key="payment.online"/></label>
            </div>
            <div id="offlinePaymentId" class="radio radio-inline">
                <input type="radio" name="paymentMode" value="2" class="form-control" id="offlinePayment" required>
                <label for="offlinePayment"> <fmt:message key="payment.offline"/> </label>
            </div>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-3 "></label>
        <div class="col-sm-8">
            <div class="radio radio-inline">
                <!-- <button type="button" onclick="javascript:selectPaymentMode();" class="btn btn-primary"> -->
                <button id="paymentProceedBtn" type="button" onclick="javascript:offlinePaymentConfirmPopup();" class="btn btn-primary">
                    <fmt:message key="payment.proceed"/>
                </button>
            </div>
        </div>
    </div>
    </div>
</form>
