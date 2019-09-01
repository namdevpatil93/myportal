<%@ include file="../../common/taglibs.jsp"%>
<!-- Session Timeout Popup -->
<div class="modal fade" id="otpModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
   <div class="modal-dialog modal-lg" role="document">
       <div class="modal-content" align="center">
           <div class="modal-header">
               <h4 class="modal-title" id="myModalLabel"><fmt:message key="applicant.offline.payment.process"/></h4>
           </div>
           <div class="modal-body">
           	<form class="form-horizontal" data-toggle="validator" role="form">
           		<div id="errorClassDiv" class="row form-group required">
				  <div class="col-sm-12">
				  	<input type="number" class="form-control" class="form-control" id="otp" placeholder="" maxlength="6" onfocus="clearModal()" required/>
				  	<div id="errorText" class="help-block with-errors"></div>
				  </div>
				</div>
				<div class="row">
				  <div class="col-sm-12" align="center">
				  	<%-- <a href="#" onclick="resendOTP()"><fmt:message key="verifyotp.resend"/></a> --%>
				  </div>
				</div>
             </form>
           </div>
           <div class="modal-footer">
               <%-- <button id="cancel" type="button" class="btn btn-default btn-sm" data-dismiss="modal"><fmt:message key="verifyotp.cancel"/></button> --%>
               <button id="ok" type="button" class="btn btn-primary btn-sm" data-dismiss="modal"><fmt:message key="verifyotp.ok"/></button>
               <!-- <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> -->
           </div>
       </div>
   </div>
</div>


<script>
	function openModal() {
		clearModal();
		$('#otpModal').modal({
	           backdrop: 'static',
	           keyboard: false
	       });
	}
	
	function clearModal() {
		$( '#errorClassDiv' ).removeClass( 'has-error has-danger' );
		$( '#errorText' ).text('');
	}
	
</script>