<%@ include file="../common/taglibs.jsp"%>
<%@ page pageEncoding="UTF-8"%>

<link rel="stylesheet" href="<c:url value='/static/libs/bootstrap-fileinput/css/fileinput.min.css'/>" >
<script type="text/javascript" src="<c:url value='/static/libs/bootstrap-fileinput/js/fileinput.min.js'/>"></script>

<script type="text/javascript">

	  

 
$(document).ready(function(){
	 $("form#bulkQualificationUpload").validate({
	 	errorPlacement: function(error, element) {
           if (element.attr("name") == "bulkQualificationUploadfile" ){
               error.appendTo($('#fileMsg'));
           } 
       },
	 	rules: {
           
	 		bulkQualificationUploadfile : {
	 			required: true,
               extension: "xls|xlsx"
	 		}
	 	}
	 });
	 
	 
	 jQuery("#bulkQualificationUpload").ajaxForm({
         dataType:  'json',
         beforeSubmit:  function(){
             return true;
         },
         success:  function(result){
             var success = result.success;
             var exist =result.exist;
             var fileIsEmpty=result.fileIsEmpty;
             var duplicateEntry=result.duplicateEntry;
             if(exist==false){
             	commonObj.showAlert("Can't save Qualification!! This Qualification already exists!!");
             }
             else if(fileIsEmpty==true){
            	 commonObj.showAlert("Uploaded File Is Empty or some field Is Empty.");
             } 
             else if(duplicateEntry==true){
            	 commonObj.showAlert("Uploaded File having duplicate entry.");
             }
             else if(success){
                 administrationObj.goToTab('1');
                 return false;
             } 
             else {
                 commonObj.showAlert("There was some error while trying to save the Qualification.");
             }
         }
     });
	 
});

    jQuery(document).ready(function () {
    	  
        $("#createQualificationForm").validate( {
        	rules: {
                
    	 		title : {
    	 			required: true,
    	 			noSpace: true
    	 		},
    	 		titleInMarathi : {
    	 			required: true,
    	 			noSpace: true
    	 		}
        
    	 	}
        });
        
        
        jQuery("#createQualificationForm").ajaxForm({
            dataType:  'json',
            beforeSubmit:  function(){
                return true;
            },
            
            success:  function(result){
                var success = result.success;
                var exist =result.exist;
                
                if(exist==false){
                	commonObj.showAlert("Can't save Qualification !! This Qualification is already exist..!!");
                }
                
                else if(success){
                    administrationObj.goToTab('1');
                    return false;
                } else {
                    commonObj.showAlert("There was some error while trying to save the Qualification.");
                }
            }
            
            
        });
       
       
    });
    
  
    
</script>

<form name="createQualificationForm" id="createQualificationForm" class="form-horizontal"
      action="<c:url value='/qualifications?operation=saveQualification'/>" method="POST" >

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${qualification.id }"/>

    <div class="form-group">
        <label for="title" class="col-sm-2 control-label">
            Title
        </label>
        <div class="col-sm-10">
            <input type="text" class="form-control" id="title" name="title" value="${ qualification.title }" placeholder="Title" minlength="1" required>
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group">
        <label for="titleInMarathi" class="col-sm-2 control-label">
            Title (Marathi)
        </label>
        <div class="col-sm-10">
            <input type="text" class="form-control" id="titleInMarathi" name="titleInMarathi" value="${ qualification.titleInMarathi }" placeholder="Title (Marathi)" minlength="1" required>
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group">
        <label for="priority" class="col-sm-2 control-label">
            Priority
        </label>
        <div class="col-sm-10">
            <input type="number" class="form-control" id="priority" name="priority" value="${ qualification.priority }" placeholder="Priority" required min="1">
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
   

	<div class="form-group">
        <label for="active" class="col-sm-2 control-label">
            <fmt:message key="qualification.active"/>
        </label>
        <div class="col-sm-10">
            <div class="checkbox">
                <input type="checkbox" id="active" name="active" ${ qualification.active ? 'checked=checked':'' } >
                <label for="active"></label>
                <div class="help-block with-errors"></div>
            </div>
        </div>
    </div>
	<div>
		<a href="<c:url value='/static/app/excel/QualificationUploadFormat.xls' />" download target="_blank"><fmt:message key="qualification.download.sample.file"/></a>
        
	</div>
	
    <div class="pull-right">
        <tags:hasPermission moduleName="qualifications" operation="saveQualification">
            <button type="submit" class="btn btn-primary">
                <fmt:message key="save"/>
            </button>
        </tags:hasPermission>
        <button type="button" class="btn btn-default"onclick="javascript:administrationObj.goToTab('1');">
            <fmt:message key="cancel"/>
        </button>
    </div>
    

</form>

<form class="form-horizontal" id="bulkQualificationUpload" name="bulkQualificationUpload"
	  action="<c:url value='/qualifications?operation=uploadQualificationExcel'/>" method="POST" enctype="multipart/form-data">
	  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<div class="form-group">
		<label for="file" class="col-sm-2 control-label">Upload</label>
		<div class="col-sm-10">
		<div class="col-sm-5">
			<input id="bulkQualificationUploadfile" name="bulkQualificationUploadfile" type="file" class="file" data-show-upload="false"
				   data-show-caption="true" data-show-preview="false" required>
				   <div id="fileMsg" class="help-block with-errors"></div>
			
		</div>
		
		 <tags:hasPermission moduleName="qualifications" operation="uploadQualificationExcel">
            <button type="submit" class="btn btn-primary">
                <fmt:message key="qualification.upload"/>
            </button>
        </tags:hasPermission>
        </div>
	</div>
</form>


<!-- ===============================================xxxxxxxxxxxxx======================================= -->




