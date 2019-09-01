<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page pageEncoding="UTF-8"%>

<html>
<body>
<div class="modal fade admincardpop" id="admitCardPopup" tabindex="-1" role="dialog" aria-labelledby="MyModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" align="center" id="MyModalLabel">Admit Card</h4>
      </div>
      <div class="modal-body">
        <form>
          <div class="form-group">
           <center><iframe id="admitCardPicture" class="embed-responsive-item" src="" style="width:500px; height:500px;"></iframe></center>
          </div>
        </form>
      </div>
      <div class="modal-footer">
       <center> <button type="button" class="btn btn-default" data-dismiss="modal">OK</button></center>
	   	<div class="footerinfo">
	   		<div class="row">
	   			<div class="col-md-12 text-left">To Print Admit Card </div>
	   		</div>
	   		<div class="row">
	   			<div class="col-md-2">1. </div>
	   			<div class="col-md-10">Click on >> button</div>
	   		</div>
	   		<div class="row">
	   			<div class="col-md-2">2. </div>
	   			<div class="col-md-10">Click on print option</div>
	   		</div>
	   		<div class="row">
	   			<div class="col-md-12 text-left">प्रवेश पत्राची प्रत काढण्यासाठी</div>
	   		</div>
	   		<div class="row">
	   			<div class="col-md-2">१) </div>
	   			<div class="col-md-10">>> बटन वर क्लीक करा </div>
	   		</div>
	   		<div class="row">
	   			<div class="col-md-2">२) </div>
	   			<div class="col-md-10">प्रिंट ऑपशन वर क्लिक करा</div>
	   		</div>
	   		
	   		<!-- <p style="padding-left: 15px;"> To Print Admit Card <p>
			<p style="padding-left: 20px;"><br/>
			2. Click on print option</p> <br/>
			
			<p style="padding-left: 15px;"> प्रवेश पत्राची प्रत काढण्यासाठी</p> 
			<p style="padding-left: 20px;">१) >> बटन वर क्लीक करा <br/>
				२) प्रिंट ऑपशन वर क्लिक करा</p> -->
	   	</div>	
	   		
				
      </div>
	    
    </div>
  </div>
</div>
</html>
</body>