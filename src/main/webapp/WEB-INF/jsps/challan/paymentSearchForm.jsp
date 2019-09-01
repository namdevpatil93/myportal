<%@ include file="../common/taglibs.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1" %>

<style>

    table .collapse.in {
        display:table-row;
    }

    .fa-exclamation-triangle {
        color: red;
    }

</style>

<script>

    function markPostAsSubmitted(postAssocId){

        var orderNo = $("#orderNo_" + postAssocId).val();

        if(orderNo == null || orderNo == '' || orderNo == undefined){
            commonObj.showAlert("Please enter order number.");
            return;
        }

        var orderNumberNotMatched = false;

        $(".orderNo").each(function( index, value ) {
            if($(value).val() === orderNo){
                orderNumberNotMatched = true;
            }
        });

        if(orderNumberNotMatched == false || orderNumberNotMatched == "false"){
            commonObj.showAlert("The Order number you entered does not match against the order numbers associated with the transactions done by the applicant.");
            return;
        }

        var paymenStatusOfOrder = $("#"+ orderNo +"_status").val();

        if(paymenStatusOfOrder != 1){
            commonObj.showAlert("The Order number ["  + orderNo  + "] you entered does not have the payment status = 'SUCCESS' ");
            return;
        }

        commonObj.showConfirmation("Are you sure you want to mark this Post as submitted?", function(result){
            if(result){
                var url = '<c:url value='/challan?operation=markPostAsSubmitted'/>';
                var searchedApplicationId = $("#searchedApplicationId").val();

                $.post(url, { postAssocId : postAssocId , orderNo : orderNo, applicationId : searchedApplicationId }, function(result){
                    var success = result.success;
                    if(success){
                        commonObj.showAlert("The post has been successfully marked as submitted.");
                    } else {
                        commonObj.showAlert("There was some error while trying to mark the Post as submitted.");
                    }
                });
            }
        }, '<fmt:message key="yes"/>', '<fmt:message key="no"/>', '<fmt:message key="confirmationMessage.title"/>' );
    }

</script>

<div class="panel panel-default">
    <div class="panel-heading">Request</div>
    <div class="panel-body">
        <form class="form-horizontal"
              name="paymentSearchForm"
              id="paymentSearchForm"
              action="<c:url value='/challan?operation=searchPayments'/>"
              method="POST">

            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input type="hidden" id="menu" name="menu" value="showPaymentSearchForm" />

            <div class="form-group">
                <label class="control-label col-sm-2" for="applicationId">Application ID: <span class="red">*</span></label>
                <div class="col-sm-2">
                    <input type="text" maxlength="12" class="form-control" id="applicationId" placeholder="Application Id" name="applicationId" value="${ applicationId }" required>
                    <div class="help-block with-errors"></div>
                </div>
                <div class="col-sm-1">
                    <button class="btn btn-default btn-primary" type="submit">
                        Search
                    </button>
                </div>
            </div>

        </form>

    </div>
</div>

<c:choose>
<c:when test="${ result eq true}">

    <input type="hidden" name="searchedApplicationId" id="searchedApplicationId" value="${ applicationId }"/>

    <div class="panel panel-default">
        <div class="panel-heading">Applicant Details</div>
        <div class="panel-body">

            <div class="form-horizontal">
                <div class="form-group">
                    <label class="control-label col-sm-2" >First name</label>
                    <div class="col-sm-4">
                            ${applicant.firstName}
                    </div>
                </div>
            </div>

            <div class="form-horizontal">
                <div class="form-group">
                    <label class="control-label col-sm-2" >Middle name</label>
                    <div class="col-sm-4">
                            ${applicant.middleName}
                    </div>
                </div>
            </div>

            <div class="form-horizontal">
                <div class="form-group">
                    <label class="control-label col-sm-2" >Last name</label>
                    <div class="col-sm-4">
                            ${applicant.lastName}
                    </div>
                </div>
            </div>

            <div class="form-horizontal">
                <div class="form-group">
                    <label class="control-label col-sm-2" >Gender</label>
                    <div class="col-sm-4">
                        <c:choose>
                            <c:when test="${ applicant.gender eq 0}">Female</c:when>
                            <c:when test="${ applicant.gender eq 1}">Male</c:when>
                            <c:otherwise>NA</c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <div class="form-horizontal">
                <div class="form-group">
                    <label class="control-label col-sm-2" >Email Address</label>
                    <div class="col-sm-4">
                            ${applicant.emailAddress}
                    </div>
                </div>
            </div>

            <div class="form-horizontal">
                <div class="form-group">
                    <label class="control-label col-sm-2" >Mobile Number</label>
                    <div class="col-sm-4">
                            ${applicant.mobileNumber}
                    </div>
                </div>
            </div>

            <div class="form-horizontal">
                <div class="form-group">
                    <label class="control-label col-sm-2" >Caste</label>
                    <div class="col-sm-4">
                            ${applicant.caste.casteTitle}
                    </div>
                </div>
            </div>


            <div class="form-horizontal">
                <div class="form-group">
                    <label class="control-label col-sm-2" >Non-Creamy Layer</label>
                    <div class="col-sm-4">
                        <c:if test="${ not empty applicant.nonCreamyLayer}">
                            <c:choose>
                                <c:when test="${applicant.nonCreamyLayer == true}">
                                    <fmt:message key="yes"/>
                                </c:when>
                                <c:otherwise>
                                    <fmt:message key="no"/>
                                </c:otherwise>
                            </c:choose>
                        </c:if>
                    </div>
                </div>
            </div>



        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading">Payment Transactions</div>
        <div class="panel-body">

            <table class="table table-responsive table-hover">
                <thead>
                <tr>
                    <th width="1%"></th>
                    <th></th>
                    <th>Order No</th>
                    <th>Amount</th>
                    <th>Payment Mode</th>
                    <th>Txn Reference No</th>
                    <th>Auth Status</th>
                    <th>Response Message</th>
                    <th>Status</th>
                    <th>Created Date</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="paymentTransaction" items="${paymentTransactionList}" varStatus="counter">
                    <c:set var="postsApplied" value="${paymentTransaction.applicantPostAssocList ne null and fn:length(paymentTransaction.applicantPostAssocList) gt 0}"/>
                    <tr  data-toggle="collapse" data-target="#posts_${ paymentTransaction.id}" class="clickable">
                        <td>
                            <c:if test="${ !postsApplied and paymentTransaction.status eq 1}">
                                <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
                            </c:if>
                        </td>
                        <td><i class="glyphicon glyphicon-plus"></i></td>
                        <td>
                            <input type="hidden" class="orderNo" value="${ paymentTransaction.orderNo}"/>
                            ${ paymentTransaction.orderNo}
                        </td>
                        <td>
                             ${ paymentTransaction.amount}
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${ paymentTransaction.paymentMode eq 1}">Online</c:when>
                                <c:otherwise>Offline</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                                ${ paymentTransaction.txnReferenceNo}
                        </td>
                        <td>
                                ${ paymentTransaction.authStatus}
                        </td>
                        <td>
                                ${ paymentTransaction.responseMessage}
                        </td>
                        <td>
                            <input id="${ paymentTransaction.orderNo }_status" type="hidden" class="status" value="${ paymentTransaction.status}"/>
                            <c:choose>
                                <c:when test="${ paymentTransaction.status eq 1}">
                                    Success
                                </c:when>
                                <c:when test="${ paymentTransaction.status eq 2}">
                                    Failure
                                </c:when>
                                <c:otherwise>
                                    Pending
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <tags:localDateTime pattern="dd/MM/yyyy hh:mm:ss" datetime="${paymentTransaction.createdDate}" />
                        </td>
                    </tr>

                    <c:if test="${paymentTransaction.applicantPostAssocList ne null and fn:length(paymentTransaction.applicantPostAssocList) gt 0}">
                        <tr class="collapse" id="posts_${ paymentTransaction.id}">
                            <td></td>
                            <td></td>
                            <td colspan="8">
                                <c:forEach var="appPostAssoc" items="${paymentTransaction.applicantPostAssocList}" varStatus="index">
                                     ${index.index + 1}) ${ appPostAssoc.post.postTitle} <br />
                                </c:forEach>
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
                </tbody>
            </table>

        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading">Total Applications</div>
        <div class="panel-body">

            <table class="table table-condensed table-hover">
                <thead>
                <tr>
                    <th width="20%">Post </th>
                    <th>Order No</th>
                    <th>Status</th>
                    <th>Submitted Date</th>
                    <th>Created Date</th>
                    <th>Last Modified Date</th>
                    <th width="30%"></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="applicantPostAssoc" items="${applicantPostAssocList}" varStatus="counter">
                    <tr id="row_${ applicantPostAssoc.id }">
                        <td>
                                ${ applicantPostAssoc.post.postTitle}
                        </td>
                        <td>
                                ${ applicantPostAssoc.txnOrderNo}
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${ applicantPostAssoc.status eq 0}">
                                    Draft
                                </c:when>
                                <c:when test="${ applicantPostAssoc.status eq 1}">
                                    Saved
                                </c:when>
                                <c:when test="${ applicantPostAssoc.status eq 2}">
                                    Submitted
                                </c:when>
                                <c:when test="${ applicantPostAssoc.status eq 3}">
                                    Pending
                                </c:when>
                            </c:choose>
                        </td>
                        <td>
                            <tags:localDate pattern="dd/MM/yyyy" date="${applicantPostAssoc.submittedDate}" />
                        </td>
                        <td>
                            <tags:localDateTime pattern="dd/MM/yyyy hh:mm:ss" datetime="${applicantPostAssoc.createdDate}" />
                        </td>
                        <td>
                            <tags:localDateTime pattern="dd/MM/yyyy hh:mm:ss" datetime="${applicantPostAssoc.lastModifiedDate}" />
                        </td>
                        <td>
                            <c:if test="${ paymentTransactionList ne null and fn:length(paymentTransactionList) gt 0}">
                                <c:if test="${ applicantPostAssoc.status eq 1 or applicantPostAssoc.status eq 3}">
                                    <div class="form-group">
                                        <div class="col-sm-5">
                                            <input id="orderNo_${ applicantPostAssoc.id }" size="10" class="form-control" type="text" value="" placeholder="Order No" maxlength="10"/>
                                        </div>
                                        <div class="col-sm-1">
                                            <button class="btn btn-default btn-primary" type="button" onclick="javascript:markPostAsSubmitted('${ applicantPostAssoc.id }', '${ applicantPostAssoc.postId }');">
                                                Mark as Submitted
                                            </button>
                                        </div>
                                    </div>
                                </c:if>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

        </div>
    </div>

</c:when>
<c:when test="${ applicationId ne null && !isRedirectedFromPaymentScreen}">
    <b>Applicant with the given Application ID does not exist in the System.</b>
</c:when>
</c:choose>