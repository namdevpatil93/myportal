<%@ include file="../common/taglibs.jsp"%>

<script type="text/javascript">
    jQuery(document).ready(function () {
    	var currentDate=new Date();
		//maxDate.setFullYear(maxDate.getFullYear() + 50);
		
    	$('#exportChallanExcelFromdate').datetimepicker({
            format: 'DD/MM/YYYY',
            ignoreReadonly: true,
            showTodayButton: true,
            defaultDate: currentDate
            //date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseIssueDate}" />'
        });
        
        $('#exportChallanExcelCalendarIconFromdate').click(function() {
            $('#exportChallanExcelFromdate').data("DateTimePicker").show();
        });
        $('#exportChallanExcelFromdate').on("dp.change", function (e) {
    		//var fromDate = moment($('#'+fromDateId).val()).format("DD/MM/YYYY");
        	//var toDate = moment($('#'+toDateId).val()).format("DD/MM/YYYY");
    		//if(e.date != undefined || e.date != null) 		date.toLocaleDateString()
    		//moment(new Date()).format("YYYY/MM/DD");
    		
    		var date = new Date(e.date);
    		date.setDate(date.getDate());
    		var toDate = $('#exportChallanExcelToDate').val();
    		if(date == toDate)
    		{
    			date.setDate(date.getDate());
    		}
    		if(date != undefined || date != null)
    			$('#exportChallanExcelToDate').data("DateTimePicker").minDate(date);
    		
        });
        $('#exportChallanExcelToDate').on("dp.change", function (e) {
        	var fromDate = new Date( moment($('#exportChallanExcelFromdate').val()).format("DD/MM/YYYY"));
        	var toDate = new Date( moment($('#exportChallanExcelToDate').val()).format("DD/MM/YYYY"));
        	if(fromDate == toDate)
        	{
        		toDate.setDate(toDate.getDate());
        		if(toDate != undefined || toDate != null)
        			$('#exportChallanExcelToDate').data("DateTimePicker").minDate(toDate);
        	}
        	else
        	{
        		if(e.date != undefined || e.date != null)
        			$('#exportChallanExcelFromdate').data("DateTimePicker").maxDate(e.date);
        	}
        	
        });
        
 	   $('#exportChallanExcelToDate').datetimepicker({
            format: 'DD/MM/YYYY',
            ignoreReadonly: true,
            showTodayButton: true,
            defaultDate: currentDate
            //maxDate: maxDate
           // date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseEndDate}" />'
        });
 	  
 	  $('#exportChallanExcelCalendarIconToDate').click(function() {
          $('#exportChallanExcelToDate').data("DateTimePicker").show();
      });
 	  
 	  //==============================
 		  
 	 $('#postPaymentCountFromdate').datetimepicker({
         format: 'DD/MM/YYYY',
         ignoreReadonly: true,
         showTodayButton: true,
         defaultDate: currentDate
         //date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseIssueDate}" />'
     });
 	  
 	$('#postPaymentCountCalendarIconFromdate').click(function() {
        $('#postPaymentCountFromdate').data("DateTimePicker").show();
    });
 	
 	$('#postPaymentCountFromdate').on("dp.change", function (e) {
		//var fromDate = moment($('#'+fromDateId).val()).format("DD/MM/YYYY");
    	//var toDate = moment($('#'+toDateId).val()).format("DD/MM/YYYY");
		//if(e.date != undefined || e.date != null) 		date.toLocaleDateString()
		//moment(new Date()).format("YYYY/MM/DD");
		
		var date = new Date(e.date);
		date.setDate(date.getDate());
		var toDate = $('#postPaymentCountToDate').val();
		if(date == toDate)
		{
			date.setDate(date.getDate());
		}
		if(date != undefined || date != null)
			$('#postPaymentCountToDate').data("DateTimePicker").minDate(date);
		
    });
 	
 	 $('#postPaymentCountToDate').on("dp.change", function (e) {
     	var fromDate = new Date( moment($('#postPaymentCountFromdate').val()).format("DD/MM/YYYY"));
     	var toDate = new Date( moment($('#postPaymentCountToDate').val()).format("DD/MM/YYYY"));
     	if(fromDate == toDate)
     	{
     		toDate.setDate(toDate.getDate());
     		if(toDate != undefined || toDate != null)
     			$('#postPaymentCountToDate').data("DateTimePicker").minDate(toDate);
     	}
     	else
     	{
     		if(e.date != undefined || e.date != null)
     			$('#postPaymentCountFromdate').data("DateTimePicker").maxDate(e.date);
     	}
     	
     });
     
	   $('#postPaymentCountToDate').datetimepicker({
         format: 'DD/MM/YYYY',
         ignoreReadonly: true,
         showTodayButton: true,
         defaultDate: currentDate
         //maxDate: maxDate
        // date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseEndDate}" />'
     });
	  
	  $('#postPaymentCountCalendarIconToDate').click(function() {
       $('#postPaymentCountToDate').data("DateTimePicker").show();
   });

	  loadPostPaymentMismatchCount(true);
 	  
    });
    
    /* function exportChallanData(){
    	var url = commonObj.appBasePath + 'challan?operation=downloadChallanData';
    	var fromDate = $('#exportChallanExcelFromdate').val();
    	var toDate = $('#exportChallanExcelToDate').val();
    	 jQuery.ajax({
             type: 'POST',
             url: url,
             data : { fromDate : fromDate,
            	 	  toDate : toDate},
             async : false,
             success: function(data) {
                
             }
         });
    } */
    
    function exportChallanData(){
    	
    	var fromDate = $('#exportChallanExcelFromdate').val();
    	var toDate = $('#exportChallanExcelToDate').val();
    	$("#downloadChallanForm").find("#fromDate").val(fromDate);
    	$("#downloadChallanForm").find("#toDate").val(toDate);
    	$("#downloadChallanForm").submit();
    	
    }
    function saveCreateChallanForm() {
    	var challanFile = $('#challanFile').val();
    	var challanFileExt = challanFile.substr(challanFile.lastIndexOf('.') + 1);
    	var challanFileInLowerCase = challanFileExt.toLowerCase();
    	if( 'csv' == challanFileInLowerCase ) {
			jQuery("#btnSubmit").attr("disabled", true);
	    }
	    $("#createChallanForm").submit();
    }
    
function correctChallanOrderNo(){
    	
    	var fromOrderDate = $('#exportChallanExcelFromdate').val();
    	var toOrderDate = $('#exportChallanExcelToDate').val();
    	$("#correctChallanOrderForm").find("#fromOrderDate").val(fromOrderDate);
    	$("#correctChallanOrderForm").find("#toOrderDate").val(toOrderDate);
    	$("#correctChallanOrderForm").submit();
    	
    }
    
 function countApplicantPostAssocByPaymentModePaymentStatusBetweenDates(){
	 $("#processingRequestSpan").show();
	 var fromDateForCount = $('#postPaymentCountFromdate').val();
	 var toDateForCount = $('#postPaymentCountToDate').val();
	 var url = commonObj.appBasePath + 'challan?operation=showPostPaymentCount';
	 jQuery.ajax({
         type: 'POST',
         url: url,
         data : { fromDateForCount : fromDateForCount, toDateForCount : toDateForCount},
         async : false,
         success:  function(result){
        	 $("#processingRequestSpan").hide();
             var success = result.success;
             var successfulOnlinePaymentPostCount = result.successfulOnlinePaymentPostCount;
     		 var successfulOfflinePaymentPostCount = result.successfulOfflinePaymentPostCount;
     		 var failedOnlinePaymentPostCount = result.failedOnlinePaymentPostCount;
     		 var failedOfflinePaymentPostCount = result.failedOfflinePaymentPostCount;
             if(success){
            	 loadPostPaymentMismatchCount(false);
                 $('#successfulOnlinePaymentPostCountDiv').html(successfulOnlinePaymentPostCount);
                 $('#successfulOfflinePaymentPostCountDiv').html(successfulOfflinePaymentPostCount);
                 $('#failedOnlinePaymentPostCountDiv').html(failedOnlinePaymentPostCount);
                 $('#failedOfflinePaymentPostCountDiv').html(failedOfflinePaymentPostCount);
                 return false;
             } else {
                 commonObj.showAlert("There was some error while trying to fetch data.");
             }
         }
     });
 }
 
 function loadPostPaymentMismatchCount(isAutoLoad){
	 var fromDateForCount = $('#postPaymentCountFromdate').val();
	 var toDateForCount = $('#postPaymentCountToDate').val(); 
	 
	 if(isAutoLoad){
		 fromDateForCount ="";
		 toDateForCount = "";
	 }
	 
	 var url = "<c:url value='/challan?operation=showPostPaymentMismatchCount'/>";
     jQuery("#postPaymentMismatchCountDiv").load(url, { fromDateForCount : fromDateForCount, toDateForCount : toDateForCount}, function(){

     });
 }
    
</script>

<%-- <tags:app-message message="${ message }"/> --%>
<tags:app-error error="${ error }" />

<c:if test="${ errorMap ne null}">
	<div class="alert alert-success alert-dismissable">
		<!--<c:choose>
			<c:when test="${ errorMap['totalUploaded'] eq errorMap['totalRecordsFound'] }">
				<fmt:message key="challan.uploaded.message" ><fmt:param value="${ errorMap['totalRecordsFound'] }" /></fmt:message>
			</c:when>
			<c:otherwise>
				<c:if test="${ errorMap['alreadyUploadList'] ne null || errorMap['alreadyUploadList'] ne '' }">
					<fmt:message key="challan.uploaded.message.uploadedPreviously"><fmt:param value="${ errorMap['alreadyUploadList'] }" /><fmt:param value="${ errorMap['totalUploaded'] }" /><fmt:param value="${ errorMap['totalRecordsFound'] }" /></fmt:message>
					<br />
				</c:if>
				
				<c:if test="${ errorMap['notUploadedList'] ne null || errorMap['alreadyUploadList'] ne '' }">
					<fmt:message key="challan.uploaded.message.notFound"><fmt:param value="${ errorMap['notUploadedList'] }" /><fmt:param value="${ errorMap['totalUploaded'] }" /><fmt:param value="${ errorMap['totalRecordsFound'] }" /></fmt:message>
					<br />
				</c:if>
			  	<c:if test="${ errorMap['totalRecordsGiven'] ne errorMap['totalRecordsFound'] }">
			 		<fmt:message key="challan.uploaded.message.countError"><fmt:param value="${ errorMap['totalUploaded'] }" /><fmt:param value="${ errorMap['totalRecordsFound'] }" /></fmt:message>
			 	</c:if>
			</c:otherwise>
		</c:choose>-->
		
		<fmt:message key="challan.uploaded.message" ><fmt:param value="${ errorMap['totalUploaded'] }" /></fmt:message><br />
		<fmt:message key="challan.uploaded.message.found" ><fmt:param value="${ errorMap['totalRecordsGiven'] }" /></fmt:message>
	</div>
</c:if>


<form name="createChallanForm"
      id="createChallanForm"
      data-toggle="validator"
      class="form-horizontal"
      enctype="multipart/form-data"
      action="<c:url value='/challan?operation=saveChallan'/>" method="POST">

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${challan.id }"/>
    <input type="hidden" id="menu" name="menu" value="showUploadChallan" />

    <div class="form-group">
        <div class="col-sm-3">
            <label class="control-label">Total Amount Transacted : </label><br><br>
        </div>
        <div class="col-sm-6">
            ${ totalAmount }
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3">
            <label class="control-label">Online Amount : </label><br><br>
        </div>
        <div class="col-sm-3">
            ${ onlineTransactionsAmount }
        </div>
        <div class="col-sm-3">
            <label class="control-label">Online Transactions : </label><br><br>
        </div>
        <div class="col-sm-3">
            ${ countOfOnlineTransactions }
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3">
            <label class="control-label">Offline Amount : </label><br><br>
        </div>
        <div class="col-sm-3">
            ${ offlineTransactionsAmount }
        </div>
        <div class="col-sm-3">
            <label class="control-label">Offline Transactions : </label><br><br>
        </div>
        <div class="col-sm-3">
                ${ countOfOfflineTransactions }
        </div>
    </div>

	<div class="form-group">
		<label class="control-label col-sm-3" for="exportChallanExcel"><fmt:message key="export.challan.list.label"/>: <span class="red">*</span></label>
        <div class="col-sm-3">
        	<div class="input-group date">
	            <input type="datetime" class="form-control" id="exportChallanExcelFromdate" placeholder="<fmt:message key="export.challan.from.date"/>" readonly>
	            <div class="input-group-addon" id="exportChallanExcelCalendarIconFromdate">
					<i class="fa fa-calendar"></i>
				</div>
	            <div class="help-block with-errors"></div>
            </div>
        </div>
        <div class="col-sm-3">
        	<div class="input-group date">
	            <input type="datetime" class="form-control" id="exportChallanExcelToDate" placeholder="<fmt:message key="export.challan.to.date"/>" readonly >
	            <div class="input-group-addon" id="exportChallanExcelCalendarIconToDate">
					<i class="fa fa-calendar"></i>
				</div>
	            <div class="help-block with-errors"></div>
            </div>
        </div>
        <div class="col-sm-3">
        	<%-- <a class="btn btn-primary" href="<c:url value='/admin?operation=downloadChallanData'/>"><fmt:message key="export.challan.btn.label"/></a> --%>
        	<button type="button" class="btn btn-primary" onclick="exportChallanData();"><fmt:message key="export.challan.btn.label"/></button>
        </div>
	</div>

    <div class="form-group">
        <div class="col-sm-3">
            <label class="control-label">Upload Offline Payment Data: <span class="red">*</span></label><br><br>
        </div>
        <div class="col-sm-3">
            <input id="challanFile" name="challanFile" type="file" class="file" data-show-upload="false"
                   data-show-caption="false" data-show-preview="false"
                   data-allowed-file-extensions='["csv"]' required>
            <div id="challanFileMsg" class="help-block with-errors"></div>
            <a href="<c:url value='/static/app/csv/ChallanUploadFormat.csv' />" download target="_blank"><fmt:message key="challan.download.sample.file"/></a>
        </div>
        <div class="col-sm-3">
        	<tags:hasPermission moduleName="challan" operation="saveChallan">
                <button id="btnSubmit" type="button" class="btn btn-primary" onclick="javascript:saveCreateChallanForm()">Upload</button>
            </tags:hasPermission>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3">
        </div>
        <div class="col-sm-6">
            <div class="text-muted">
                <em>Click Browse to search and attach challan file</em><br>
                <em>(Permissible file types : csv )</em><br><br>
            </div>
        </div>
    </div>

    <%-- <div class="form-group">
        <div class="col-sm-3">
        </div>
        <div class="col-sm-6">
            <tags:hasPermission moduleName="challan" operation="saveChallan">
                <button type="submit" class="btn btn-primary">Upload</button>
            </tags:hasPermission>
        </div>
    </div> --%>

    <div class="form-group">
        <div class="col-sm-3">
        </div>
        <div class="col-sm-6">
            <a href="javascript:void(0);" onclick="javascript:commonObj.goToURL('<c:url value='/challan?operation=viewPreviousUploads&menu=showUploadChallan'/>')">View Previous Uploads</a>
        </div>
    </div>

</form>

<form id="downloadChallanForm" class="form-horizontal" action="<c:url value='/challan?operation=downloadChallanData'/>" method="POST">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="hidden" id="fromDate" name="fromDate">
	<input type="hidden" id="toDate" name="toDate">

</form>

<%--<form id="correctChallanOrderForm" class="form-horizontal" action="<c:url value='/challan?operation=correctChallanOrderNo'/>" method="POST">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="hidden" id="fromOrderDate" name="fromOrderDate">
	<input type="hidden" id="toOrderDate" name="toOrderDate">
	<div class="col-sm-3">
        	&lt;%&ndash; <a class="btn btn-primary" href="<c:url value='/admin?operation=downloadChallanData'/>"><fmt:message key="export.challan.btn.label"/></a> &ndash;%&gt;
        	<button type="button" class="btn btn-primary" onclick="correctChallanOrderNo();">Correct Order Nos.</button>
    </div>
</form>--%>
<form id="postPaymentCountForm" class="form-horizontal" action="<c:url value='/challan?operation=showPostPaymentCount'/>">
	<div class="form-group">
		<label class="control-label col-sm-3" for="exportChallanExcel"></label>
        <div class="col-sm-3">
        	<div class="input-group date">
	            <input type="datetime" class="form-control" id="postPaymentCountFromdate" placeholder="<fmt:message key="export.challan.from.date"/>" readonly>
	            <div class="input-group-addon" id="postPaymentCountCalendarIconFromdate">
					<i class="fa fa-calendar"></i>
				</div>
	            <div class="help-block with-errors"></div>
            </div>
        </div>
        <div class="col-sm-3">
        	<div class="input-group date">
	            <input type="datetime" class="form-control" id="postPaymentCountToDate" placeholder="<fmt:message key="export.challan.to.date"/>" readonly >
	            <div class="input-group-addon" id="postPaymentCountCalendarIconToDate">
					<i class="fa fa-calendar"></i>
				</div>
	            <div class="help-block with-errors"></div>
            </div>
        </div>
        <div class="col-sm-3">
        	<%-- <a class="btn btn-primary" href="<c:url value='/admin?operation=downloadChallanData'/>"><fmt:message key="export.challan.btn.label"/></a> --%>
        	<span class="processingRequest greenTxt" style="display: none" id="processingRequestSpan">
                 	<img src="<c:url value='static/app/images/smallLoader.gif'/>" class="smallLoader">
                <fmt:message key="processingrequest"/>
            </span>&nbsp;
        	<button type="button" class="btn btn-primary" onclick="countApplicantPostAssocByPaymentModePaymentStatusBetweenDates();"><fmt:message key="ok"/></button><br/><br/><br/><br/>
        	
        </div>
        
        <div class="form-group">
        <div class="col-sm-4">
            <label class="control-label">Successful Online Payment For Posts (Count) : </label><br><br>
        </div>
        <div id="successfulOnlinePaymentPostCountDiv" class="col-sm-2">
            ${ successfulOnlinePaymentPostCount }
        </div>
        <div class="col-sm-4">
            <label class="control-label">Successful Offline Payment For Posts (Count) : </label><br><br>
        </div>
        <div id="successfulOfflinePaymentPostCountDiv" class="col-sm-2">
            ${ successfulOfflinePaymentPostCount }
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-4">
            <label class="control-label">Failed Online Payment For Posts (Count) : </label><br><br>
        </div>
        <div id="failedOnlinePaymentPostCountDiv" class="col-sm-2">
            ${ failedOnlinePaymentPostCount }
        </div>
        <div class="col-sm-4">
            <label class="control-label">Failed Offline Payment For Posts (Count) : </label><br><br>
        </div>
        <div id="failedOfflinePaymentPostCountDiv" class="col-sm-2">
                ${ failedOfflinePaymentPostCount }
        </div>
    </div>
        <div id="postPaymentMismatchCountDiv">
        	
        </div>
	</div>
</form>