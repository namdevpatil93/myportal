<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Session Timeout Popup -->
<div class="modal fade" id="otpModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
   <div class="modal-dialog modal-sm" role="document">
       <div class="modal-content" align="center">
           <div class="modal-header">
               <fmt:message key="verifyotp.title"/>
           </div>
           <div class="modal-body">
           	<form class="form-horizontal" data-toggle="validator" role="form">
           		<div id="errorClassDiv" class="row form-group required">
           		  <div class="col-sm-1">
<%-- 				  	<fmt:message key="verifyotp.enterOTP"/>: --%>
						&nbsp;
				  </div>
				  <div class="col-sm-11">
				  	<input type="number" class="form-control" class="form-control" id="otp" placeholder="<fmt:message key="verifyotp.enterOTP"/>" min="0" max="999999" onfocus="clearModal()" required/>
				  	<div id="errorText" class="help-block with-errors"></div>
				  </div>
				</div>
				<div class="row">
				  <div class="col-sm-12" align="center">
				  	<a href="#" onclick="resendOTP()"><fmt:message key="verifyotp.resend"/></a>
				  </div>
				</div>
             </form>
           </div>
           <div class="modal-footer">
               <button id="cancel" type="button" class="btn btn-default btn-sm" data-dismiss="modal"><fmt:message key="verifyotp.cancel"/></button>
               <button id="ok" type="button" class="btn btn-primary btn-sm" onclick="verifyOTP()"><fmt:message key="verifyotp.ok"/></button>
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
	
	function verifyOTP() {
		var result = $('#otp').val();
		
		var errMsg = '';
		$( '#errorClassDiv' ).addClass( 'has-error has-danger' );
		
        if (result != null && result.length != 0) {
        	$.ajax({
                url: "<c:url value='/applicant?operation=verifyOTP'/>",
                type: "POST",
                data: {otp:result},
                dataType: "text",
                async: false,
                success: function(data) { 
                    //alert(data);
                    if (data=='fail') {
                    	errMsg = '<fmt:message key="wrong.otp"/>';
                    } else {
                    	$("#verifiedLabel").empty();
                        $("#verifiedLabel").append('<fmt:message key="verified"/>').css({'color':'green'}); //rgb(15,99,30)
                        //$("#verifiedButton").prop("disabled", true);
                        $("#verifiedButton").hide();
                    	$('#otpModal').modal('toggle');
                    }
                },
                error: function(err) {
                    
                }
              
            });
        } else {
        	errMsg = '<fmt:message key="enter.otp"/>';
        }
        
        $( '#errorText' ).text(errMsg);
	}
	
	function resendOTP() {
		$.ajax({
            url: "<c:url value='/applicant?operation=resendOTP'/>",
            type: "POST",
            dataType: "text",
            async: false,
            success: function(data) {
            	$('#otpModal').modal('toggle'); 
                //alert(data);
//                 if (data=='fail') {
//                 	errMsg = 'Wrong OTP.';
//                 } else {
//                 	$('#otpModal').modal('toggle');
//                 }
            },
            error: function(err) {
                
            }
          
        });
	}
</script>