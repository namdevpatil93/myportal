<%@ include file="../common/taglibs.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1" %>

<script>
    jQuery(document).ready(function() {
        $("#onlineQueryApiForm").validate();
        $("#changeStatusForm").validate();

        jQuery("#changeStatusForm").ajaxForm({
            dataType:  'json',
            beforeSubmit:  function(){
                return true;
            },
            success:  function(result){
                var success = result.success;
                if(success){
                    commonObj.showAlert("Status has been changed successfully.");
                    return false;
                } else {
                    commonObj.showAlert("There was some error while trying to change the status.");
                }
            }
        });
        
        var currentDate=new Date();
    	//maxDate.setFullYear(maxDate.getFullYear() + 50);
    	
    	$('#exportQueryApiExcelFromdate').datetimepicker({
            format: 'DD/MM/YYYY',
            ignoreReadonly: true,
            showTodayButton: true,
            defaultDate: currentDate
            //date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseIssueDate}" />'
        });
    	
        $('#exportQueryApiExcelCalendarIconFromdate').click(function() {
            $('#exportQueryApiExcelFromdate').data("DateTimePicker").show();
        });
        
        $('#exportQueryApiExcelToDate').datetimepicker({
            format: 'DD/MM/YYYY',
            ignoreReadonly: true,
            showTodayButton: true,
            defaultDate: currentDate
            //maxDate: maxDate
           // date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseEndDate}" />'
        });
        $('#exportQueryApiExcelCalendarIconToDate').click(function() {
            $('#exportQueryApiExcelToDate').data("DateTimePicker").show();
        });
    });
</script>
<%--
<form action="https://www.billdesk.com/pgidsk/PGIQueryController">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="msg" value="0122|MSRTCHR|2145658356|201612131407|6E20252B504E3346944577F9F7958B2E53E7B683767C2C212690B4112C210D4F">
    <input type="submit">
</form>--%>

<div class="panel panel-default">
    <div class="panel-heading">Request</div>
    <div class="panel-body">
        <form class="form-horizontal"
              name="onlineQueryApiForm"
              id="onlineQueryApiForm"
              action="<c:url value='/challan?operation=submitQuery'/>"
              method="POST">

            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input type="hidden" id="menu" name="menu" value="onlineQueryApi" />

            <div class="form-group">
                <label class="control-label col-sm-2" for="orderNo">Order No: <span class="red">*</span></label>
                <div class="col-sm-2">
                    <input type="number" max="999999999999" class="form-control" id="orderNo" placeholder="Order No" name="orderNo" value="${ onlineQueryApiResponse.orderNo }" required>
                    <div class="help-block with-errors"></div>
                </div>
                <div class="col-sm-1">
                    <button class="btn btn-default btn-primary" type="submit">
                        <fmt:message key="submit" />
                    </button>
                </div>
            </div>

        </form>

    </div>
</div>

<c:if test="${ onlineQueryApiResponse ne null}">
    <div class="panel panel-default">
        <div class="panel-heading">Response</div>
        <div class="panel-body">

            <div class="form-horizontal">
                <div class="form-group">
                    <label class="control-label col-sm-2" >Request Type:</label>
                    <div class="col-sm-4">
                            ${onlineQueryApiResponse.requestType}
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2" >Order No :</label>
                    <div class="col-sm-4">
                            ${onlineQueryApiResponse.orderNo}
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2" >Txn Reference No :</label>
                    <div class="col-sm-4">
                            ${onlineQueryApiResponse.txnReferenceNo}
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2" >Txn Amount:</label>
                    <div class="col-sm-4">
                            ${onlineQueryApiResponse.txnAmount}
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2" >Auth Status:</label>
                    <div class="col-sm-4">
                            ${onlineQueryApiResponse.authStatus}
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2" >Refund Status:</label>
                    <div class="col-sm-4">
                            ${onlineQueryApiResponse.refundStatus}
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2" >Mobile:</label>
                    <div class="col-sm-4">
                            ${onlineQueryApiResponse.mobile}
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2" >Email :</label>
                    <div class="col-sm-4">
                            ${onlineQueryApiResponse.email}
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2" >Error Status :</label>
                    <div class="col-sm-4">
                            ${onlineQueryApiResponse.errorStatus}
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2" >Error Description :</label>
                    <div class="col-sm-4">
                            ${onlineQueryApiResponse.errorDescription }
                    </div>
                </div>
            </div>
        </div>
    </div>

    <c:if test="${ onlineQueryApiResponse.success }">
        <div class="panel panel-default">
            <div class="panel-heading">Change Status</div>
            <div class="panel-body">

                <form class="form-horizontal"
                      name="changeStatusForm"
                      id="changeStatusForm"
                      action="<c:url value='/challan?operation=changeStatus'/>"
                      method="POST">

                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <input type="hidden" name="orderNo" value="${onlineQueryApiResponse.orderNo}"/>

                    <div class="form-horizontal">
                        <div class="form-group">
                            <label class="control-label col-sm-2" >Status:</label>
                            <div class="col-sm-3">
                                <select class="form-control" name="status" id="status" required>
                                    <option value="">-- Please select status --</option>
                                    <option value="1">Success</option>
                                    <option value="2">Failure</option>
                                </select>
                                <div class="help-block with-errors"></div>
                            </div>
                            <div class="col-sm-3">
                                <button class="btn btn-default btn-primary" type="submit">
                                    <fmt:message key="submit" />
                                </button>
                            </div>
                        </div>

                    </div>
                </form>
            </div>
        </div>
    </c:if>

</c:if>

<form name="onlineListQueryApiForm" id="onlineListQueryApiForm" data-toggle="validator" class="form-horizontal" action="<c:url value='/challan?operation=submitQueryList'/>" method="POST">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" id="menu" name="menu" value="viewReports" />
    <div class="form-group">
		<label class="control-label col-sm-2" for="exportQueryApiExcel">Generate onlineQueryApi Data:</label>
        <div class="col-sm-3">
        	<div class="input-group date">
	            <input name="fromDate" type="datetime" class="form-control" id="exportQueryApiExcelFromdate" placeholder="<fmt:message key="export.challan.from.date"/>" readonly>
	            <div class="input-group-addon" id="exportQueryApiExcelCalendarIconFromdate">
					<i class="fa fa-calendar"></i>
				</div>
	            <div class="help-block with-errors"></div>
            </div>
        </div>
        <div class="col-sm-1"><label>To</label></div>
        <div class="col-sm-3">
        	<div class="input-group date">
	            <input name="toDate" type="datetime" class="form-control" id="exportQueryApiExcelToDate" placeholder="<fmt:message key="export.challan.to.date"/>" readonly >
	            <div class="input-group-addon" id="exportQueryApiExcelCalendarIconToDate">
					<i class="fa fa-calendar"></i>
				</div>
	            <div class="help-block with-errors"></div>
            </div>
        </div>
        <div class="col-sm-3">
        	<%-- <a class="btn btn-primary" href="<c:url value='/admin?operation=downloadChallanData'/>"><fmt:message key="export.challan.btn.label"/></a> --%>
        	<button type="submit" class="btn btn-primary">Submit </button>
        </div>
	</div>
</form>
