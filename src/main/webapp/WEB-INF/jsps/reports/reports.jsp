<%@ include file="../common/taglibs.jsp"%>


<style>
.bordertable table, .bordertable th, .bordertable td {
    border: 1px solid black;
    border-collapse: collapse;
}
.bordertable th, .bordertable td {
    padding: 5px;
    text-align: left;    
}
</style>

<script type="text/javascript">

jQuery(document).ready(function () {
	var currentDate=new Date();
	//maxDate.setFullYear(maxDate.getFullYear() + 50);
	
	$('#exportReportExcelFromdate').datetimepicker({
        format: 'DD/MM/YYYY',
        ignoreReadonly: true,
        showTodayButton: true,
        defaultDate: currentDate
        //date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseIssueDate}" />'
    });
    
    $('#exportReportExcelCalendarIconFromdate').click(function() {
        $('#exportReportExcelFromdate').data("DateTimePicker").show();
    });
    /* $('#exportReportExcelFromdate').on("dp.change", function (e) {
		//var fromDate = moment($('#'+fromDateId).val()).format("DD/MM/YYYY");
    	//var toDate = moment($('#'+toDateId).val()).format("DD/MM/YYYY");
		//if(e.date != undefined || e.date != null) 		date.toLocaleDateString()
		//moment(new Date()).format("YYYY/MM/DD");
		
		var date = new Date(e.date);
		date.setDate(date.getDate());
		var toDate = $('#exportReportExcelToDate').val();
		if(date == toDate)
		{
			date.setDate(date.getDate());
		}
		if(date != undefined || date != null)
			$('#exportReportExcelToDate').data("DateTimePicker").minDate(date);
		
    }); */
    /* $('#exportReportExcelToDate').on("dp.change", function (e) {
    	var fromDate = new Date( moment($('#exportReportExcelFromdate').val()).format("DD/MM/YYYY"));
    	var toDate = new Date( moment($('#exportReportExcelToDate').val()).format("DD/MM/YYYY"));
    	if(fromDate == toDate)
    	{
    		toDate.setDate(toDate.getDate());
    		if(toDate != undefined || toDate != null)
    			$('#exportReportExcelToDate').data("DateTimePicker").minDate(toDate);
    	}
    	else
    	{
    		if(e.date != undefined || e.date != null)
    			$('#exportReportExcelFromdate').data("DateTimePicker").maxDate(e.date);
    	}
    	
    }); */
    
	   $('#exportReportExcelToDate').datetimepicker({
        format: 'DD/MM/YYYY',
        ignoreReadonly: true,
        showTodayButton: true,
        defaultDate: currentDate
        //maxDate: maxDate
       // date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseEndDate}" />'
    });
	  
	  $('#exportReportExcelCalendarIconToDate').click(function() {
      $('#exportReportExcelToDate').data("DateTimePicker").show();
  });
	  var reportsFromDate = '${reportsFromDate}';
  	if(reportsFromDate != 'undefined' && reportsFromDate != null && reportsFromDate !='' ){
  		$('#exportReportExcelFromdate').val('<tags:localDate pattern="dd/MM/yyyy" date="${reportsFromDate}" />');
  	}else{
  		$('#exportReportExcelFromdate').datetimepicker({
  	        format: 'DD/MM/YYYY',
  	        ignoreReadonly: true,
  	        showTodayButton: true,
  	        defaultDate: currentDate
  	        //date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicantPostAssoc.heavyDrivingLicenseIssueDate}" />'
  	    });
  	}
  	
  	var reportsToDate = '${reportsToDate}';
  	if(reportsToDate != 'undefined' && reportsToDate != null && reportsToDate !='' ){
  		$('#exportReportExcelToDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${reportsToDate}" />');
  	}else{
  		$('#exportReportExcelToDate').datetimepicker({
  	        format: 'DD/MM/YYYY',
  	        ignoreReadonly: true,
  	        showTodayButton: true,
  	        defaultDate: currentDate
  	        //maxDate: maxDate
  	    });
  	}
});

function exportReportData(){
	$("#downloadReportForm").submit();
	
}

</script>

<form name="reportsForm" id="reportsForm" data-toggle="validator" class="form-horizontal" action="<c:url value='/reports?operation=genearteReport'/>" method="POST">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" id="menu" name="menu" value="viewReports" />
    <div class="form-group">
		<label class="control-label col-sm-2" for="exportReportExcel"><fmt:message key="generate.report.list.label"/>:</label>
        <div class="col-sm-3">
        	<div class="input-group date">
	            <input name="fromDate" type="datetime" class="form-control" id="exportReportExcelFromdate" placeholder="<fmt:message key="export.challan.from.date"/>" readonly>
	            <div class="input-group-addon" id="exportReportExcelCalendarIconFromdate">
					<i class="fa fa-calendar"></i>
				</div>
	            <div class="help-block with-errors"></div>
            </div>
        </div>
        <div class="col-sm-1"><label>To</label></div>
        <div class="col-sm-3">
        	<div class="input-group date">
	            <input name="toDate" type="datetime" class="form-control" id="exportReportExcelToDate" placeholder="<fmt:message key="export.challan.to.date"/>" readonly >
	            <div class="input-group-addon" id="exportReportExcelCalendarIconToDate">
					<i class="fa fa-calendar"></i>
				</div>
	            <div class="help-block with-errors"></div>
            </div>
        </div>
        <div class="col-sm-3">
        	<%-- <a class="btn btn-primary" href="<c:url value='/admin?operation=downloadChallanData'/>"><fmt:message key="export.challan.btn.label"/></a> --%>
        	<button type="submit" class="btn btn-primary"><fmt:message key="generate.report.button.label"/></button>
        </div>
	</div>
</form>
<c:if test="${reportFileName ne null}">
<form id="downloadReportForm" class="form-horizontal" action="<c:url value='/reports?operation=downloadReport'/>" method="POST">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="hidden" id="reportFileName" name="reportFileName" value="${reportFileName }">

<div class="row bordertable">

	<div class="col-lg-6">
	
	<table>
		<tr>
			<td style="width: 50%; font-weight: bold;">Total Registration Count</td>
			<td style="width: 50%; text-align: center;">${rddto.totalRegistrationCount ne null ? rddto.totalRegistrationCount : 0}</td>
		</tr>
		<tr>
			<td style="width: 50%; font-weight: bold;">Total Male Registration</td>
			<td style="width: 50%; text-align: center;">${rddto.totalMaleRegistrationCount ne null ? rddto.totalMaleRegistrationCount : 0}</td>
		</tr>
		<tr>
			<td style="width: 50%; font-weight: bold;">Total Female Registration</td>
			<td style="width: 50%; text-align: center;">${rddto.totalFemaleRegistrationCount ne null ? rddto.totalFemaleRegistrationCount : 0}</td>
		</tr>
	</table>
	</div>
	<div class="col-lg-6">
	<table style="float: right;">
		<tr>
			<td style="width: 50%; font-weight: bold;">No of Challans Generated</td>
			<td style="width: 50%; text-align: center;">${rddto.numberOfChallangeneratedCount ne null ? rddto.numberOfChallangeneratedCount : 0}</td>
		</tr>
		<tr>
			<td style="width: 50%; font-weight: bold;">Online Amount</td>
			<td style="width: 50%; text-align: center;">${rddto.onlineAmount ne null ? rddto.onlineAmount : 0}</td>
		</tr>
		<tr>
			<td style="width: 50%; font-weight: bold;">Offline Amount</td>
			<td style="width: 50%; text-align: center;">${rddto.offlineAmount ne null ? rddto.offlineAmount : 0}</td>
		</tr>
		<tr>
			<td style="width: 50%; font-weight: bold;">Total Amount</td>
			<td style="width: 50%; text-align: center;">${rddto.totalAmount ne null ? rddto.totalAmount : 0}</td>
		</tr>	
	</table>
	</div>
</div>

<div id="postDataDiv" class="bordertable">
	<table style="width: 100%">
	<tr>
		<td style="text-align: center; font-weight: bold;" rowspan="3">Post</td>
		<td style="text-align: center; font-weight: bold;" rowspan="3">Application Count</td>
		<td style="text-align: center; font-weight: bold;" colspan="13">Application Confirmed Count (Payment Completed Successfully)</td>
	</tr>
	<tr>
		<td style="text-align: center; font-weight: bold; background-color: #ff99cc;" colspan="3">Online</td>
		<td style="text-align: center; font-weight: bold; background-color: #3366FF;" colspan="3">Offline</td>
		<td style="text-align: center; font-weight: bold; background-color: #FFCC00;" colspan="2">Open Category</td>
		<td style="text-align: center; font-weight: bold; background-color: #FFCC00;" colspan="2">Reserved Category</td>
		<td style="text-align: center; font-weight: bold; background-color: #FF9900;" colspan="3">Total</td>
	</tr>
	<tr>
		<td style="text-align: center; font-weight: bold; background-color: #ff99cc;">Male</td>
		<td style="text-align: center; font-weight: bold; background-color: #ff99cc;">Female</td>
		<td style="text-align: center; font-weight: bold; background-color: #ff99cc;">Total</td>
		<td style="text-align: center; font-weight: bold; background-color: #3366FF;">Male</td>
		<td style="text-align: center; font-weight: bold; background-color: #3366FF;">Female</td>
		<td style="text-align: center; font-weight: bold; background-color: #3366FF;">Total</td>
		<td style="text-align: center; font-weight: bold; background-color: #FFCC00;">Male</td>
		<td style="text-align: center; font-weight: bold; background-color: #FFCC00;">Female</td>
		<td style="text-align: center; font-weight: bold; background-color: #FFCC00;">Male</td>
		<td style="text-align: center; font-weight: bold; background-color: #FFCC00;">Female</td>
		<td style="text-align: center; font-weight: bold; background-color: #FF9900;">Male</td>
		<td style="text-align: center; font-weight: bold; background-color: #FF9900;">Female</td>
		<td style="text-align: left; font-weight: bold; background-color: #FF9900;">Total</td>
	</tr>
		<c:forEach items="${rddto.postReportDataDTOs}" var="prddto">
			<tr>
				<td style="width: 25%; text-align: left;" >${prddto.postTitle }</td>
				<td style="width: 10%; text-align: center;" >${prddto.totalApplicationCount ne null ? prddto.totalApplicationCount : 0}</td>
				<td style="width: 5%; text-align: center; background-color: #ff99cc;" >${prddto.totalOnlinePaidMaleApplicationCount ne null ?  prddto.totalOnlinePaidMaleApplicationCount : 0}</td>
				<td style="width: 5%; text-align: center; background-color: #ff99cc;" >${prddto.totalOnlinePaidFemaleApplicationCount ne null ? prddto.totalOnlinePaidFemaleApplicationCount : 0}</td>
				<td style="width: 5%; text-align: center; background-color: #ff99cc; font-weight: bold;" >${prddto.totalOnlinePaidApplicationCount ne null ? prddto.totalOnlinePaidApplicationCount : 0}</td>
				<td style="width: 5%; text-align: center; background-color: #3366FF;" >${prddto.totalOfflinePaidMaleApplivationCount ne null ? prddto.totalOfflinePaidMaleApplivationCount : 0}</td>
				<td style="width: 5%; text-align: center; background-color: #3366FF;" >${prddto.totalOfflinePaidFemaleApplivationCount ne null ? prddto.totalOfflinePaidFemaleApplivationCount : 0}</td>
				<td style="width: 5%; text-align: center; background-color: #3366FF; font-weight: bold;" >${prddto.totalOfflinePaidApplicationCount ne null ? prddto.totalOfflinePaidApplicationCount : 0}</td>
				<td style="width: 5%; text-align: center; background-color: #FFCC00;" >${prddto.totalOpenCategoryPaidMaleApplicationCount ne null ? prddto.totalOpenCategoryPaidMaleApplicationCount : 0}</td>
				<td style="width: 5%; text-align: center; background-color: #FFCC00;" >${prddto.totalOpenCategoryPaidFemaleApplicationCount ne null ? prddto.totalOpenCategoryPaidFemaleApplicationCount : 0}</td>
				<td style="width: 5%; text-align: center; background-color: #FFCC00;" >${prddto.totalReservedCategoryPaidMaleApplicationCount ne null ? prddto.totalReservedCategoryPaidMaleApplicationCount : 0}</td>
				<td style="width: 5%; text-align: center; background-color: #FFCC00;" >${prddto.totalReservedCategoryPaidFemaleApplicationCount ne null ? prddto.totalReservedCategoryPaidFemaleApplicationCount : 0}</td>
				<td style="width: 5%; text-align: center; background-color: #FF9900;" >${prddto.totalPaidMaleApplicationCount ne null ? prddto.totalPaidMaleApplicationCount : 0}</td>
				<td style="width: 5%; text-align: center; background-color: #FF9900;" >${prddto.totalPaidFealeApplicationCount ne null ? prddto.totalPaidFealeApplicationCount : 0}</td>
				<td style="width: 5%; text-align: center; background-color: #FF9900; font-weight: bold;" >${prddto.totalPaidApplicantCount ne null ? prddto.totalPaidApplicantCount : 0}</td>
			</tr>
		</c:forEach>
		<tr>
				<td style="width: 25%; text-align: left;" >Total</td>
				<td style="width: 10%; text-align: center; font-weight: bold;" >${rddto.totalPostApplicationCount ne null ? rddto.totalPostApplicationCount : 0}</td>
				<td style="width: 5%; text-align: center; background-color: #ff99cc; font-weight: bold;" >${rddto.totalOnlineMalePostApplicationCount ne null ? rddto.totalOnlineMalePostApplicationCount : 0}</td>
				<td style="width: 5%; text-align: center; background-color: #ff99cc; font-weight: bold;" >${rddto.totalOnlineFemalePostApplicationCount ne null ? rddto.totalOnlineFemalePostApplicationCount : 0}</td>
				<td style="width: 5%; text-align: center; background-color: #ff99cc; font-weight: bold;" >${rddto.totalOnlinePostApplicationCount ne null ? rddto.totalOnlinePostApplicationCount : 0}</td>
				<td style="width: 5%; text-align: center; background-color: #3366FF; font-weight: bold;" >${rddto.totalOfflineMalePostApplicationCount ne null ? rddto.totalOfflineMalePostApplicationCount : 0}</td>
				<td style="width: 5%; text-align: center; background-color: #3366FF; font-weight: bold;" >${rddto.totalOfflineFemalePostApplicationCount ne null ? rddto.totalOfflineFemalePostApplicationCount : 0}</td>
				<td style="width: 5%; text-align: center; background-color: #3366FF; font-weight: bold;" >${rddto.totalOfflinePostApplicationCount ne null ? rddto.totalOfflinePostApplicationCount : 0}</td>
				<td style="width: 5%; text-align: center; background-color: #FFCC00; font-weight: bold;" >${rddto.totalOpenCategoryMaleApplicationCount ne null ? rddto.totalOpenCategoryMaleApplicationCount : 0}</td>
				<td style="width: 5%; text-align: center; background-color: #FFCC00; font-weight: bold;" >${rddto.totalOpenCategoryFemaleApplicationCount ne null ? rddto.totalOpenCategoryFemaleApplicationCount : 0}</td>
				<td style="width: 5%; text-align: center; background-color: #FFCC00; font-weight: bold;" >${rddto.totalReservedCategoryMaleApplicationCount ne null ? rddto.totalReservedCategoryMaleApplicationCount : 0}</td>
				<td style="width: 5%; text-align: center; background-color: #FFCC00; font-weight: bold;" >${rddto.totalReservedCategoryFemaleApplicationCount ne null ? rddto.totalReservedCategoryFemaleApplicationCount : 0}</td>
				<td style="width: 5%; text-align: center; background-color: #FF9900; font-weight: bold;" >${rddto.totalMaleApplicationCount ne null ? rddto.totalMaleApplicationCount : 0}</td>
				<td style="width: 5%; text-align: center; background-color: #FF9900; font-weight: bold;" >${rddto.totalFemaleApplicationCount ne null ? rddto.totalFemaleApplicationCount : 0}</td>
				<td style="width: 5%; text-align: center; background-color: #FF9900; font-weight: bold;" >${rddto.totalMaleFemaleApplicationCount ne null ? rddto.totalMaleFemaleApplicationCount : 0}</td>
			</tr>
			</table>
			<button type="button" class="btn btn-primary" onclick="exportReportData();"><fmt:message key="export.challan.btn.label"/></button>
	</div>
	<%-- <div id="downloadReportDiv" class="col-sm-3">
        	<a class="btn btn-primary" href="<c:url value='/admin?operation=downloadChallanData'/>"><fmt:message key="export.challan.btn.label"/></a>
        	<button type="button" class="btn btn-primary" onclick="exportReportData();"><fmt:message key="export.challan.btn.label"/></button>
   </div> --%>
</form>
</c:if>