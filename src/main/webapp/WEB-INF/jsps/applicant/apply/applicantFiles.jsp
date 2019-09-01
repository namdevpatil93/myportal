<%@ page contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1" %>

<%@ include file="../../common/taglibs.jsp"%>

<link rel="stylesheet" href="<c:url value='/static/libs/bootstrap-fileinput/css/fileinput.min.css'/>" >
<script type="text/javascript" src="<c:url value='/static/libs/bootstrap-fileinput/js/fileinput.min.js'/>"></script>

<script>

    var MAX_PHOTO_SIZE = 256; // in kbs
    var MAX_SIGNATURE_SIZE = 256; // in kbs
    var ALLOWED_FILE_EXTENSIONS = 'jpg|jpeg|png';

    jQuery(document).ready(function() {

        jQuery("#applicantFilesForm").ajaxForm({
            dataType:  'json',
            beforeSubmit:  function(){
//                 if (!$('#applicantFilesForm').validator('validate').has('.has-error').length) {
                	 jQuery("#processingRequestSpan").show();
                     jQuery("#saveBtn").attr("disabled",true);
                     jQuery("#saveAsDraftBtn").attr("disabled",true);
                     /* jQuery("#delBtn").attr("disabled",true);
                     jQuery("#cancelBtn").attr("disabled",true); */
                     
                     return true;
//                 } else {
//                      return false;
//                 }
            },
            success:  function(result){
            	jQuery("#processingRequestSpan").hide();
                jQuery("#saveBtn").attr("disabled",false);
                jQuery("#saveAsDraftBtn").attr("disabled",false);
                /* jQuery("#delBtn").attr("disabled",false);
                jQuery("#cancelBtn").attr("disabled",false); */
            	
                var success = result.success;
                if(success){
                    applyObj.showConfirmation();
                    return false;
                } else {
                    commonObj.showAlert("There was some error while trying to save the Applicant's Photo and Signature.");
                }
            }

        });
        var lastDateOver = commonObj.isValidate(${disableFormAfterLastDateOver});
        commonObj.disableFormFields("applicantFilesForm",lastDateOver);
    });

    function saveFormAsDraft(formID) {
        //undoValidations();
        var shouldSubmit = true;
        shouldSubmit = validateFileSize(shouldSubmit);

        if (shouldSubmit) {
            shouldSubmit = validateFileExtension(true);
            if(shouldSubmit) {
                undoValidations();
                jQuery('#' + formID).find("#status").val(0);
                jQuery('#' + formID).submit();
            }
        }

    }

	function saveForm(formID) {
		//undoValidations();
    	var shouldSubmit = true;
    	jQuery('#' + formID).find( '#status' ).val(1);
        var photoVal = jQuery( '#photo' ).val();
        var photoValDb = '${applicantFiles.photoFileName}';
        
        var signatureVal = jQuery('#signature').val();
        var signatureValDb = '${applicantFiles.signatureFileName}';
        var selectAFile = '<fmt:message key='selectAFile'/>';
        
        if (photoVal.trim().length == 0 && photoValDb.trim().length == 0) {
        	$( '#photoDiv' ).addClass( 'has-error has-danger' );
        	$( '#photoMsg' ).html( '<ul class="list-unstyled"><li>'+ selectAFile +'</li></ul>' );  
        	shouldSubmit = false;
        }
        
        if (signatureVal.trim().length == 0 && signatureValDb.trim().length == 0) {
        	$( '#signatureDiv' ).addClass( 'has-error has-danger');
        	$( '#signatureMsg' ).html( '<ul class="list-unstyled"><li>'+ selectAFile +'</li></ul>' );
        	shouldSubmit = false;
        }
        
        shouldSubmit = validateFileSize(shouldSubmit);
        
        shouldSubmit = validateFileExtension(shouldSubmit);
        
        if (shouldSubmit) {
        	undoValidations();
        	jQuery('#' + formID).submit();
        }
    }
	
   function validateFileSize(shouldSubmit) {
	   var photoFile = $( 'form#applicantFilesForm' ).find('input#photo');
	   var signatureFile = $( 'form#applicantFilesForm' ).find('input#signature');
       
	   if (photoFile.val() != '' && ((photoFile)[0].files[0].size > (MAX_PHOTO_SIZE * 1000))) {
      		shouldSubmit = false;
      		return shouldSubmit;
       }
	
	   if (signatureFile.val() != '' && ((signatureFile)[0].files[0].size > (MAX_SIGNATURE_SIZE  * 1000))) {
      		shouldSubmit = false;
      		return shouldSubmit;
       }
	
       return shouldSubmit;
   }
   
   function validateFileExtension(shouldSubmit) {
	   var photoFile = $( 'form#applicantFilesForm' ).find('input#photo').val();
	   var signatureFile = $( 'form#applicantFilesForm' ).find('input#signature').val();
	   if ( photoFile ) {
		    var photoFileExt = photoFile.substr(photoFile.lastIndexOf('.') + 1);
		    var photoFileExtInLowerCase = photoFileExt.toLowerCase();
		    
	    	if( ALLOWED_FILE_EXTENSIONS.indexOf(photoFileExtInLowerCase) < 0 ) {
		        //varError = varError + FieldName + "Invalid text file type.\n"; jpg|jpeg|png
		        shouldSubmit = false;
		  		return shouldSubmit;
	        }
	   }
	   
	   if ( signatureFile ) {
		   var signatureFileExt = signatureFile.substr(signatureFile.lastIndexOf('.') + 1);
		   var signatureFileExtInLowerCase = signatureFileExt.toLowerCase();
		   
	   		if( ALLOWED_FILE_EXTENSIONS.indexOf(signatureFileExtInLowerCase) < 0 ) {
		        shouldSubmit = false;
		  		return shouldSubmit;
	        }
	   }
     	return shouldSubmit;
    }
   
   function undoValidations() {
	   $( '#photoMsg' ).html( '' );
	   $( '#signatureMsg' ).html( '' );
	   $( '#photoMsg' ).removeClass( 'has-error has-danger' );
	   $( '#signatureMsg' ).removeClass( 'has-error has-danger' );
   }
	   
   
    $('#applicantFilesForm').validate({
    	//File size will always be in kbs
    	errorPlacement: function(error, element) {
            if (element.attr("name") == "photo" ){
                error.appendTo($('#photoMsg'));
            } else if (element.attr("name") == "signature" ){
                error.appendTo($('#signatureMsg'));
            } else {
                error.appendTo($(element).parent().find('.help-block'));
            }
        },
        ignore: [],
        rules: {
            photo: {
                //required: true,
                extension: ALLOWED_FILE_EXTENSIONS,
                filesize: MAX_PHOTO_SIZE
            },
            signature: {
                //required: true,
                extension: ALLOWED_FILE_EXTENSIONS,
                filesize: MAX_SIGNATURE_SIZE
            }
        }
    });
	
	
</script>

<br>
<br>

<form class="form-horizontal col-md-12"
      name="applicantFilesForm"
      id="applicantFilesForm"
      action="<c:url value='/applicant?operation=saveApplicantFiles'/>"
      method="POST">

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${applicantFiles.id}"/>
    <input type="hidden" name="status" id="status"  value="${ applicantPostAssoc.status }"/>

    <div class="form-group">
        <div class="col-sm-6">
            <label class="control-label" for="photo"><fmt:message key="applicantFiles.photoUpload"/>: <span class="red">*</span></label><br><br>
        </div>
        <div class="col-sm-6">
            <label class="control-label" for="signature"><fmt:message key="applicantFiles.signatureUpload"/>: <span class="red">*</span></label><br><br>
        </div>
    </div>

    <div id="photoDiv" class="form-group">
        <div class="col-sm-6">
            <input id="photo" name="photo" type="file" class="file" data-show-upload="false"
                   data-show-caption="false" data-show-preview="true"
                   ${(applicantFiles.photoFileName ne null && applicantFiles.photoFileName ne '') ? '' : 'required' }>
            <div id="photoMsg" class="help-block with-errors"></div>
            <br>
        </div>
        <div id="signatureDiv" class="col-sm-6">
            <input id="signature" name="signature" type="file" class="file" data-show-upload="false"
                   data-show-caption="false" data-show-preview="true"
                   ${(applicantFiles.signatureFileName ne null && applicantFiles.signatureFileName ne '') ? '' : 'required' }>
            <div id="signatureMsg" class="help-block with-errors"></div>
            <br>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-6">
            <div class="text-muted">
                <em><fmt:message key="applicantFiles.instructions"/></em><br>
                <em><fmt:message key="applicantFiles.supportedFiles"/></em><br>
                <em><fmt:message key="validation.fileImageSize"><fmt:param value="256"/></fmt:message></em><br><br>
                <c:if test="${applicantFiles.photoFileName ne null}">
                	<img src="<c:url value='/file?operation=viewPhoto'/>&applicationId=${applicationId}&photo=${applicantFiles.photoFileName}" class="img-thumbnail" alt="<fmt:message key="applicantFiles.photo"/>" width="304" height="236">
                </c:if>
            </div>
        </div>
        <div class="col-sm-6">
            <div class="text-muted">
                <em><fmt:message key="applicantFiles.instructions"/></em><br>
                <em><fmt:message key="applicantFiles.supportedFiles"/></em><br>
                <em><fmt:message key="validation.fileImageSize"><fmt:param value="256"/></fmt:message></em><br><br>
                <c:if test="${applicantFiles.signatureFileName ne null}">
                	<img src="<c:url value='/file?operation=viewSignature'/>&applicationId=${applicationId}&signature=${applicantFiles.signatureFileName}" class="img-thumbnail" alt="<fmt:message key="applicantFiles.signature"/>" width="304" height="236">
                </c:if>
            </div>
        </div>
    </div>

    <nav class="navbar btn-toolbar sw-toolbar sw-toolbar-bottom">
        <div class="btn-group navbar-btn sw-btn-group pull-right" role="group">
            <c:if test="${!disableFormAfterLastDateOver}">
                <button id="saveBtn" onclick="javascript:saveForm('applicantFilesForm')" class="btn btn-default sw-btn-next" type="button">
                    <fmt:message key="save" />
                </button>
                <c:if test="${ disableSaveAsDraft ne 1 and disableSaveAsDraft ne '1' }">
                	<c:if test="${!disableApplicantFilesFormFieldsOnPayment }">
	                    <button id="saveAsDraftBtn" onclick="javascript:saveFormAsDraft('applicantFilesForm')" class="btn btn-default sw-btn-next" type="button">
	                        <fmt:message key="saveAsDraft" />
	                    </button>
                    </c:if>
                </c:if>
            </c:if>
            <button onclick="javascript:applyObj.gotoTab('5')" class="btn btn-default sw-btn-next skipDisabling" type="button">
                <fmt:message key="next" />
            </button>
        </div>
    </nav>
<br>
<br>
</form>