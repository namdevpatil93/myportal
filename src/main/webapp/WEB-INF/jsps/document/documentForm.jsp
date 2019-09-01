<%@ include file="../common/taglibs.jsp"%>
<%@ page pageEncoding="UTF-8"%>

<link rel="stylesheet" href="<c:url value='/static/libs/bootstrap-fileinput/css/fileinput.min.css'/>" >
<script type="text/javascript" src="<c:url value='/static/libs/bootstrap-fileinput/js/fileinput.min.js'/>"></script>

<script type="text/javascript">

    jQuery(document).ready(function () {
    	 $('#fill-both-tab-eng').hide();
    	 jQuery("#btnSubmit").attr("disabled",false);
         
         
		var documentType=${documentType};
		if(documentType==6){
			 $('#CategoryAndSubCategoryDropdown').hide();
		}
    	
        CKEDITOR.replace('description');
        CKEDITOR.replace('descriptionMarathi');

        $("#createDocumentForm").validate({
        	
            errorPlacement: function(error, element) {
                if (element.attr("name") == "pdfUpload" ){
                    error.appendTo($('#pdfErrorMsg'));
                } else if (element.attr("name") == "pdfUploadMarathi" ){
                    error.appendTo($('#mr_pdfErrorMsg'));
                } else {
                    error.appendTo($(element).parent().find('.help-block')); 
                    $('#fill-both-tab-eng').show();
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

        jQuery("#createDocumentForm").ajaxForm({
            dataType:  'json',
            beforeSubmit:  function(){
                return true;
            },
            success:  function(result){
                var success = result.success;
                if(success){
                    documentsObj.viewDocuments('${ documentType }');
                    return false;
                } else {
                    commonObj.showAlert("There was some error while trying to save the Document.");
                }
            }
        });
    });
    
    function saveDocumentForm(){
    	
		if ($("#createDocumentForm").valid()) {
				jQuery("#btnSubmit").attr("disabled",true);
		        
        }
        $("#createDocumentForm").submit();
	}
    
    function showPdfInNewTab( documentId, locale) {
		var url = "<c:url value='/file/viewPdf'/>?documentId="+documentId+"&locale="+locale;
		window.open(url,'_blank');
	}
    
    function fetchById(){
    	
		var id=$("#CategoryType").val();
		
		 var url = "<c:url value='/documents?operation=documentSubCategoryfetchById'/>" + "&id="+ id;
        $.ajax({
        	
            type: "POST",
            url: url,
            data: { id: id },
            success: function(data){
                 $('#subCategoryType').empty();
                /*  $('#subCategoryTypemr').empty(); */
                 $('#subCategoryType').append('<option value="0">-- <fmt:message key="please.select"/> --</option>');
               /*   $('#subCategoryTypemr').append('<option value="0">-- <fmt:message key="please.select"/> --</option>'); */
               
                 for (i in data ) {
                     $('#subCategoryType').append('<option value="'+ data[i].id + '">' + data[i].subCategoryTitle +'</option>');
                 }	
                 
                /*  for (i in data ) {
                     $('#subCategoryTypemr').append('<option value="'+ data[i].id + '">' + data[i].subCategoryTitleMarathi +'</option>');
                 } */	
                
            },
            dataType: 'json'  
        }); 
			
	 } 
	
</script>
<%--
<h3 class="panel-title">
    <c:choose>
        <c:when test="${document eq null or document.id eq null or document.id == ''}">
            <fmt:message key="document.add"/>
        </c:when>
        <c:otherwise>
            <fmt:message key="document.edit"/>
        </c:otherwise>
    </c:choose>
</h3>--%>

<form name="createDocumentForm" id="createDocumentForm" class="form-horizontal" action="<c:url value='/documents?operation=saveDocument'/>" method="POST" enctype="multipart/form-data">

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${document.id }"/>
    <input type="hidden" id="menu" name="menu" value="documentListMenuOption" />
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
                    <label for="title" class="col-sm-3 control-label">
                        <fmt:message key="document.title"/>
                    </label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="title" name="title" value="${ document.title }" placeholder="<fmt:message key="document.title"/>" required maxlength="200">
                        <div class="help-block with-errors"></div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="description" class="col-sm-3 control-label">
                        <fmt:message key="document.description"/>
                    </label>
                    <div class="col-sm-9">
                        <textarea rows="10" cols="20" id="description" name="description" placeholder="<fmt:message key="document.description"/>" required maxlength="4000">${ document.description }</textarea>
                        <div class="help-block with-errors"></div>
                    </div>
                </div>

                <div id="en_pdfDiv" class="form-group">
                    <label class="col-sm-3 control-label">Upload File</label>
                    <div class="col-sm-6">
                        <div class="row">
                        	<div class="col-sm-5">
	                        	<input id="pdfUpload" name="pdfUpload" type="file" class="file" data-show-upload="false"
	                               data-show-caption="true" data-show-preview="false"
	                               ${(document.documentName ne null && document.documentName ne '') ? '' : 'required' }>
                            </div>
	                        <c:if test="${document.documentName ne null && document.documentName ne ''}">
		                        <div class="col-sm-2">
		                            <a href="javascript:void(0)" onclick="javascript:showPdfInNewTab('${document.id}', 'en')" title="<fmt:message key="document.viewPdf"/>">
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
                    <label for="title" class="col-sm-3 control-label">
                        <fmt:message key="document.title"/>
                    </label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="titleMarathi" name="titleMarathi" value="${ document.titleMarathi }" placeholder="<fmt:message key="document.title"/>" required maxlength="200">
                        <div class="help-block with-errors"></div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="description" class="col-sm-3 control-label">
                        <fmt:message key="document.description"/>
                    </label>
                    <div class="col-sm-9">
                        <textarea rows="10" cols="20" id="descriptionMarathi" name="descriptionMarathi" placeholder="<fmt:message key="document.description"/>" required maxlength="4000">${ document.descriptionMarathi }</textarea>
                        <div class="help-block with-errors"></div>
                    </div>
                </div>

                <div id="mr_pdfDiv" class="form-group">
                    <label class="col-sm-3 control-label">Upload File</label>
                      <div class="col-sm-6"> 
                       <div class="row">
                    <div class="col-sm-5">
                        <input id="pdfUploadMarathi" name="pdfUploadMarathi" type="file" class="file" data-show-upload="false"
                               data-show-caption="true" data-show-preview="false"
                               ${(document.documentNameMarathi ne null && document.documentNameMarathi ne '') ? '' : 'required' }>
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
                    <c:if test="${document.documentNameMarathi ne null && document.documentNameMarathi ne ''}">
                        <div class="col-sm-2">
                            <a href="javascript:void(0)" onclick="javascript:showPdfInNewTab('${document.id}', 'mr')" title="<fmt:message key="document.viewPdf"/>">
                                <i class="fa fa-file-pdf-o fa-2x" aria-hidden="true"></i>
                            </a>
                        </div>
                    </c:if>
                    </div>
                    </div>
                </div>
     </div>

        </div>
    </div>
   <div id="CategoryAndSubCategoryDropdown">
    <div class="form-group row">
				<label for="categoryTitle" class="col-sm-2 control-label">
           			 <fmt:message key="document.category"/>
       			 </label>   
	 		 <div class="col-sm-3" style="margin-left:1.9%">
	  			<select id="CategoryType" name="CategoryType" class="form-control" onchange="fetchById();" >
            		 <option value="0"><fmt:message key="please.select"/></option>
            		<c:forEach var="categorytype" items="${categorytype }">
            		<option value="${categorytype.id }" ${categorytype.id eq document.categoryType? 'selected=selected':''}>${categorytype.getCategoryTitle()}</option>
            		</c:forEach> 
        		</select>
	 		 </div>

				<label for="subcategory" class="col-sm-2 control-label">
           			 <fmt:message key="document.subcategory"/>
       			 </label>   
	 		 <div class="col-sm-3" >
	  			<select id="subCategoryType" name="subCategoryType" class="form-control"   >
            	 <%-- <c:if test="${empty  subcategorytype }"> --%>
            <option value="0"><fmt:message key="please.select"/></option>
            <c:forEach var="subcategoryType" items="${subcategorytype }">
            		<option value="${subcategoryType.id }" ${subcategoryType.id eq document.subCategoryType? 'selected=selected':''}>${subcategoryType.getSubCategoryTitle()}</option>
            		</c:forEach>
            		
        		</select>
	 		 </div>
		</div>
</div>
    <div class="form-group ">
        <label for="active" class="col-sm-2 control-label">
            <fmt:message key="document.active"/>
        </label>
        
        <div>
            <div class="checkbox" style="margin-left:20.5%">
                <input type="checkbox" id="active" name="active"  ${ document.active ? 'checked=checked':'' }>
                <label for="active"></label>
                <div class="help-block with-errors"></div>
            </div>
        </div>
        
    </div>
   
     <div   id="fill-both-tab-eng" style="margin-left: 170px;"><label style="color: #a94442; font-size: 12px;"><fmt:message key="document.fillbothtab"/></label></div>
    <div class="pull-right">
        <tags:hasPermission moduleName="documents" operation="saveDocument">
        <input class="btn btn-primary" id="btnSubmit" onclick="javascript:saveDocumentForm()" value=" <fmt:message key="save"/>" type="button" />
           <%--  <button  id="btnSubmit" onclick="javascript:saveDocumentForm()" type="submit" class="btn btn-primary">
                <fmt:message key="save"/>
            </button> --%>
            
        </tags:hasPermission>
        <button type="button" class="btn btn-default"onclick="javascript:documentsObj.viewDocuments('${ documentType }');">
            <fmt:message key="cancel"/>
        </button>
    </div>

</form>

