<%@ include file="../common/taglibs.jsp"%>
<%@ page pageEncoding="UTF-8"%>

<link rel="stylesheet" href="<c:url value='/static/libs/bootstrap-fileinput/css/fileinput.min.css'/>" >
<script type="text/javascript" src="<c:url value='/static/libs/bootstrap-fileinput/js/fileinput.min.js'/>"></script>

<script type="text/javascript">

    jQuery(document).ready(function () {

        CKEDITOR.replace( 'description' );
        CKEDITOR.replace('descriptionMarathi');

    	$("#createAdvertisementForm").validate({
            errorPlacement: function(error, element) {
                if (element.attr("name") == "pdfUpload" ) {
                    error.appendTo($('#pdfErrorMsg'));
                } else if (element.attr("name") == "pdfUploadMarathi" ){
                    error.appendTo($('#mr_pdfErrorMsg'));
                } else {
                    error.appendTo($(element).parent().find('.help-block'));
                }
            },
            ignore: [],
            rules: {
                description: {
                    required: function() {
                        CKEDITOR.instances.description.updateElement();
                    },
                    minlength:1
                },
                descriptionMarathi: {
                    required: function() {
                        CKEDITOR.instances.descriptionMarathi.updateElement();
                    },
                    minlength:1
                },
                pdfUploadMarathi: {
                	extension: "pdf",
                	filesize: 10240
                },
                pdfUpload: {
                	extension: "pdf",
                	filesize: 10240
                }
            },
            messages: {
                description: {
                    required:"Please enter description"
                },
                descriptionMarathi: {
                    required:"Please enter marathi description"
                }
            }
        });    
    	
    	jQuery("#createAdvertisementForm").ajaxForm({
            dataType:  'json',
            beforeSubmit:  function(){
                return true;
            },
            success: function(result) {
                var success = result.success;
                if(success){
                    documentsObj.viewAdvertisement('${ documentType }');
                    return false;
                } else {
                    commonObj.showAlert("There was some error while trying to save the Document.");
                }
            }
        });
    	
        $('#startDate').datetimepicker({
            format: 'DD/MM/YYYY',
            ignoreReadonly: true,
            showTodayButton: true
//             ,
//             defaultDate: moment(),
//             date : '<tags:localDate pattern="dd/MM/yyyy" date="${advertisement.startDate}" />'
        });

        $('#startDateCalendarIcon').click(function () {
            $('#startDate').data("DateTimePicker").show();
        });

            
    
        $('#closingDate').datetimepicker({
            format: 'DD/MM/YYYY',
            ignoreReadonly: true,
            showTodayButton: true
//             ,
//             defaultDate: moment(),
//             date : '<tags:localDate pattern="dd/MM/yyyy" date="${advertisement.closingDate}" />'
        });

        $('#closingDateCalendarIcon').click(function () {
            $('#closingDate').data("DateTimePicker").show();
        });
        
        var startDate = '${advertisement.startDate}';
		if(startDate != 'undefined' || startDate != null || startDate !='' )
			$('#startDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${advertisement.startDate}" />');
		
		var closingDate = '${advertisement.closingDate}';
		if(closingDate != 'undefined' || closingDate != null || closingDate !='' )
			$('#closingDate').val('<tags:localDate pattern="dd/MM/yyyy" date="${advertisement.closingDate}" />');
		
   });
    
    function showPdfInNewTab( advertisementId, locale ) {
		var url = "<c:url value='/file/viewAdvertisement'/>?advertisementId="+advertisementId+"&locale="+locale;
		window.open(url,'_blank');
	}

</script>
<%--
<h3 class="panel-title">
    <c:choose>
        <c:when test="${advertisement eq null or advertisement.id eq null or advertisement.id == ''}">
            <fmt:message key="advertisement.add"/>
        </c:when>
        <c:otherwise>
            <fmt:message key="advertisement.edit"/>
        </c:otherwise>
    </c:choose>
</h3>
--%>
<form name="createAdvertisementForm" id="createAdvertisementForm" data-toggle="validator" class="form-horizontal" action="<c:url value='/advertisement?operation=saveAdvertisement'/>" method="POST" enctype="multipart/form-data">

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${advertisement.id }"/>
    <input type="hidden" id="menu" name="menu" value="advertisementListMenuOption" />
    <input type="hidden" id="documentType" name="documentType" value="${ documentType }" />

   <div class="clearfix">
        <!-- Nav tabs -->
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" class="active"><a href="#engTab" aria-controls="engTab" role="tab" data-toggle="tab">English</a></li>
            <li role="presentation"><a href="#marathiTab" aria-controls="marathiTab" role="tab" data-toggle="tab">Marathi</a></li>
        </ul>

        <!-- Tab panes -->
        <div class="tab-content">
            <div role="tabpanel" class="tab-pane active" id="engTab">

                <br>
                                                
                        <div class="form-group">

                            <label for="title" class="col-sm-2 control-label">
                                <fmt:message key="advertisement.title"/>
                            </label>

                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="title" name="title" value="${ advertisement.title }" placeholder="<fmt:message key="advertisement.title"/>" required maxlength="200">
                                <div class="help-block with-errors"></div>
                            </div>
                        </div>
                    
                                                
                        <div class="form-group">

                            <label for="description" class="col-sm-2 control-label">
                                <fmt:message key="advertisement.description"/>
                            </label>

                            <div class="col-sm-10">
                                <textarea rows="10" cols="20" id="description" name="description" placeholder="<fmt:message key="advertisement.description"/>" required maxlength="4000">${ advertisement.description }</textarea>
                                <div class="help-block with-errors"></div>
                            </div>
                        </div>
                    
                                                
                        <div class="form-group">
                            <label for="documentName" class="col-sm-2 control-label">
                                <fmt:message key="advertisement.advertisementNo"/>
                            </label>

                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="advertisementNo" name="advertisementNo" value="${ advertisement.advertisementNo }" placeholder="<fmt:message key="advertisement.advertisementNo"/>" required maxlength="50">
                                <div class="help-block with-errors"></div>
                            </div>
                        </div>
                    
                                                
                        <div id="en_pdfDiv" class="form-group">
                        	<label class="col-sm-2 control-label">Upload File</label>
							<div class="col-sm-6">
								<div class="row">
									<div class="col-sm-10">
										<input id="pdfUpload" name="pdfUpload" type="file" class="file" data-show-upload="false"
									   data-show-caption="true" data-show-preview="false"
									   ${(advertisement.documentName ne null && advertisement.documentName ne '') ? '' : 'required' }>
									</div>
									<c:if test="${advertisement.documentName ne null && advertisement.documentName ne ''}">
										<div class="col-sm-2">
											<a href="javascript:void(0)" onclick="javascript:showPdfInNewTab('${advertisement.id}', 'en')" title="<fmt:message key="advertisement.viewPdf"/>">
							            		<i class="fa fa-file-pdf-o fa-2x" aria-hidden="true"></i>
							            	</a>
										</div>
									</c:if>
								</div>								
								<div id="pdfErrorMsg" class="help-block with-errors"></div>
								<br>							
								<div class="text-muted">
									<em><fmt:message key="document.instructions"/></em><br>
									<em><fmt:message key="document.supportedFiles"/></em><br>
									<em><fmt:message key="validation.fileImageSize"><fmt:param value="10240"/></fmt:message></em><br><br>
									<!--<c:if test="${applicantFiles.photoFileName ne null}">
										<img src="<c:url value='/file?operation=viewPhoto'/>&applicationId=${applicationId}&photo=${applicantFiles.photoFileName}" class="img-thumbnail" alt="<fmt:message key="applicantFiles.photo"/>" width="304" height="236">
									</c:if>-->
								</div>
							</div>							
						</div>
						
						</div>

				            <div role="tabpanel" class="tab-pane" id="marathiTab">
				
				                <br>
				
				                <div class="form-group">
				                    <label for="title" class="col-sm-2 control-label">
				                        <fmt:message key="document.title"/>
				                    </label>
				                    <div class="col-sm-10">
				                        <input type="text" class="form-control" id="titleMarathi" name="titleMarathi" value="${ advertisement.titleMarathi }" placeholder="<fmt:message key="document.title"/>" required maxlength="200">
				                        <div class="help-block with-errors"></div>
				                    </div>
				                </div>
				
				                <div class="form-group">
				                    <label for="description" class="col-sm-2 control-label">
				                        <fmt:message key="document.description"/>
				                    </label>
				                    <div class="col-sm-10">
				                        <textarea rows="10" cols="20" id="descriptionMarathi" name="descriptionMarathi" placeholder="<fmt:message key="document.description"/>" required maxlength="4000">${ advertisement.descriptionMarathi }</textarea>
				                        <div class="help-block with-errors"></div>
				                    </div>
				                </div>
				                
				                <div class="form-group">
		                            <label for="documentName" class="col-sm-2 control-label">
		                                <fmt:message key="advertisement.advertisementNo"/>
		                            </label>
		
		                            <div class="col-sm-4">
		                                <input type="text" class="form-control" id="advertisementNoMarathi" name="advertisementNoMarathi" value="${ advertisement.advertisementNoMarathi }" placeholder="<fmt:message key="advertisement.advertisementNo"/>" required maxlength="50">
		                                <div class="help-block with-errors"></div>
		                            </div>
		                        </div>
		                    
				                <div id="mr_pdfDiv" class="form-group">
				                    <label class="col-sm-2 control-label">Upload File</label>
				                    <div class="col-sm-5">
				                        <input id="pdfUploadMarathi" name="pdfUploadMarathi" type="file" class="file" data-show-upload="false"
				                               data-show-caption="true" data-show-preview="false"
				                               ${(advertisement.documentNameMarathi ne null && advertisement.documentNameMarathi ne '') ? '' : 'required' }>
				                        <div id="mr_pdfErrorMsg" class="help-block with-errors"></div>
				                        <br>
				
				                        <div class="text-muted">
				                            <em><fmt:message key="document.instructions"/></em><br>
				                            <em><fmt:message key="document.supportedFiles"/></em><br>
											<em><fmt:message key="validation.fileImageSize"><fmt:param value="10240"/></fmt:message></em><br><br>
				                            <!--<c:if test="${applicantFiles.photoFileName ne null}">
				                                <img src="<c:url value='/file?operation=viewPhoto'/>&applicationId=${applicationId}&photo=${applicantFiles.photoFileName}" class="img-thumbnail" alt="<fmt:message key="applicantFiles.photo"/>" width="304" height="236">
				                            </c:if>-->
				                        </div>
				                    </div>
				                    <c:if test="${advertisement.documentNameMarathi ne null && advertisement.documentNameMarathi ne ''}">
				                        <div class="col-sm-4">
				                            <a href="javascript:void(0)" onclick="javascript:showPdfInNewTab('${advertisement.id}', 'mr')" title="<fmt:message key="document.viewPdf"/>">
				                                <i class="fa fa-file-pdf-o fa-2x" aria-hidden="true"></i>
				                            </a>
				                        </div>
				                    </c:if>
				                </div>
				
				            </div>
				
				        </div>
				    </div>
				    <div class="tab-content">
					    <div class="form-group">
	
	                        <label for="startDate" class="col-sm-2 control-label">
	                            <fmt:message key="advertisement.startDate"/>
	                        </label>
	
	                        <div class="col-sm-3">
	                            <div class="input-group date">
	                                <input type="datetime" class="form-control" id="startDate" name="startDate" value="${ advertisement.startDate }" readonly required>
	                                <div class="input-group-addon" id="startDateCalendarIcon">
	                                    <i class="fa fa-calendar"></i>
	                                </div>
	                            </div>
	                            <div class="help-block with-errors"></div>
	                        </div>
	                    </div>
	                
	                                            
	                    <div class="form-group">
	
	                        <label for="closingDate" class="col-sm-2 control-label">
	                            <fmt:message key="advertisement.closingDate"/>
	                        </label>
	
	                        <div class="col-sm-3">
	                             <div class="input-group date">
	                                <input type="datetime" class="form-control" id="closingDate" name="closingDate" value="${ advertisement.closingDate }" readonly required>
	                                <div class="input-group-addon" id="closingDateCalendarIcon">
	                                    <i class="fa fa-calendar"></i>
	                                </div>
	                            </div>
	                            <div class="help-block with-errors"></div>
	                        </div>
	                    </div>
					
					    <div class="form-group">
	                            <label for="active" class="col-sm-2 control-label">
	                                <fmt:message key="advertisement.active"/>
	                            </label>
	                            <div class="col-sm-2">
	                            	<div class="checkbox">
	                            		<input type="checkbox" id="active" name="active" ${ advertisement.active ? 'checked=checked':'' }>
		                                <label for="active"></label>
		                                <div class="help-block with-errors"></div>
	                            	</div>
	                            </div>
	                        </div>
	                    
	<!--                 </div> -->
	                   <div class="pull-right">
	                       <tags:hasPermission moduleName="advertisement" operation="saveAdvertisement">
	                           <button type="submit" class="btn btn-primary">
	                               <fmt:message key="save"/>
	                           </button>
	                       </tags:hasPermission>
	<%--                         <button type="button" class="btn btn-default"onclick="javascript:commonObj.goToURL('<c:url value='/advertisement?operation=advertisementList&menu=advertisementListMenuOption'/>');"> --%>
						<button type="button" class="btn btn-default"onclick="javascript:documentsObj.viewAdvertisement('${ documentType }');">
	                           <fmt:message key="cancel"/>
	                       </button>	
	                   </div>
                   </div>
<!--             </div> -->
<!--         </div> -->
<!--     </div> -->
</form>
