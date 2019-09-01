<%@ include file="../../common/taglibs.jsp"%>

<%@ include file="../../common/taglibs.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1" %>

<div class="form-horizontal">

    <div class="form-group">
        <h4>
            <c:choose>
                <c:when test="${ txnFailed }">
                    <fmt:message key="paymentResponse.failure.msg"/>
                </c:when>
                <c:otherwise>
                    <fmt:message key="paymentResponse.success.msg"/>
                </c:otherwise>
            </c:choose>
        </h4>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4"><fmt:message key="paymentResponse.transactionID"/>:</label>
        <div class="col-sm-4">
            ${paymentTransactionResponse.orderNo}
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" ><fmt:message key="paymentResponse.transactionReferenceNo"/>:</label>
        <div class="col-sm-4">
            ${paymentTransactionResponse.txnReferenceNo}
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" ><fmt:message key="paymentResponse.transactionAmount"/>:</label>
        <div class="col-sm-4">
            ${paymentTransactionResponse.txnAmount}
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" ><fmt:message key="paymentResponse.transactionStatus"/>:</label>
        <div class="col-sm-4">
            <c:choose>
                <c:when test="${ txnFailed }">
                    <fmt:message key="paymentResponse.transactionStatus.failure"/>
                </c:when>
                <c:otherwise>
                    <fmt:message key="paymentResponse.transactionStatus.success"/>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="form-group">
        <h5>
            <c:choose>
                <c:when test="${ txnFailed }">

                </c:when>
                <c:otherwise>
                    <fmt:message key="paymentResponse.findReceipt"/>
                </c:otherwise>
            </c:choose>
        </h5>
    </div>

</div>
