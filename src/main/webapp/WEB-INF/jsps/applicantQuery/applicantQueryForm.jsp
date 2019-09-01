<%@ include file="../common/taglibs.jsp"%>

<%-- <link rel="stylesheet" href="<c:url value='/static/libs/bootstrap-fileinput/css/fileinput.min.css'/>" > --%>
<%-- <script type="text/javascript" src="<c:url value='/static/libs/bootstrap-fileinput/js/fileinput.min.js'/>"></script> --%>

<link rel="stylesheet" href="<c:url value='/static/libs/imageviewer/dist/viewer.min.css'/>" >
<script type="text/javascript" src="<c:url value='/static/libs/imageviewer/dist/viewer.min.js'/>"></script>

<script type="text/javascript">

jQuery(document).ready(function () {

    CKEDITOR.replace('description');

//     $("#createApplicantQueryForm").validate({
//     	  errorPlacement: function(error, element) {
//     		  error.appendTo($(element).parent().find('.help-block'));
//     	  },
//         rules: {
//             description: {
//                 required:true
//             }
//         },
//         messages: {
//             description: {
//                 required:"Please enter description"
//             }
//         }
//     });

//     jQuery("#createApplicantQueryForm").ajaxForm({
//         dataType:  'json',
//         beforeSubmit:  function(){
//             return true;
//         },
//         success:  function(result){
//             var success = result.success;
//             if(success){
//                 documentsObj.viewDocuments('${ documentType }');
//                 return false;
//             } else {
//                 commonObj.showAlert("There was some error while trying to save the Document.");
//             }
//         }
//     });

    $("form[name='createApplicantQueryForm']").validate({
    	 errorPlacement: function(error, element) {
            if ( element.attr("name") == "attachment" ){
                error.appendTo($('#attachmentMsg'));
            } else {
                error.appendTo($(element).parent().find('.help-block'));
            }
         },
    	 ignore: [],
		 rules: {
			 type: { 
		    	  required: true
		      },
		      title: { 
		    	  required: true
		      },
		      description: {
                  required: function() {
                      CKEDITOR.instances.description.updateElement();
                  },
                  minlength: 1
              },
		      attachment: {
		    	  extension: "jpg|jpeg|png",
	              filesize: 512
	          }
	 	},
       messages: {
    	   description: {
               required: '<fmt:message key="validate.required" />'
           }
       }
	 });
});

function addedAttachmentFunc() {
	$('#addedAttachment').viewer();
}

</script>


<form name="createApplicantQueryForm" id="createApplicantQueryForm" data-toggle="validator" class="form-horizontal" action="<c:url value='/applicantQuery?operation=saveApplicantQuery'/>" method="POST" enctype="multipart/form-data">

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${applicantQuery.id }"/>
    <input type="hidden" id="menu" name="menu" value="applicantQueryListMenuOption" />

    <div class="row">
        <div class="">
<!--             <div class="panel panel-default"> -->

                <div class="panel-heading">
                    <h3 class="panel-title">
                        <c:choose>
                            <c:when test="${applicantQuery eq null or applicantQuery.id eq null or applicantQuery.id == ''}">
                                <fmt:message key="applicantQuery.add"/>
                            </c:when>
                            <c:otherwise>
                                <fmt:message key="applicantQuery.edit"/>
                            </c:otherwise>
                        </c:choose>
                    </h3>
                </div>

                <div class="panel-body">

                    
                                                
                        <div class="form-group">

                            <label for="type" class="col-sm-2 control-label">
                                <fmt:message key="applicantQuery.type"/>
                            </label>

                            <div class="col-sm-6">
<%--                                       <input type="number" class="form-control" id="type" name="type" value="${ applicantQuery.type }" placeholder="<fmt:message key="applicantQuery.type"/>" > --%>
                               		 <select class="queryType" name="type">
										<option value="">-- <fmt:message key="please.select"/> --</option>
				                		
				                    		<option value="1" ${ applicantQuery.type eq 1?'selected':''} ><fmt:message key="applicantQuery.type.registration"/>${queryType.queryType}</option>
				                    		<option value="2" ${ applicantQuery.type eq 2?'selected':''} ><fmt:message key="applicantQuery.type.application"/>${queryType.queryType}</option>
				                    		<option value="3" ${ applicantQuery.type eq 3?'selected':''} ><fmt:message key="applicantQuery.type.post"/></option>
				                    		<option value="4" ${ applicantQuery.type eq 4?'selected':''} ><fmt:message key="applicantQuery.type.offlinePayment"/>${queryType.queryType}</option>
				                    		<option value="5" ${ applicantQuery.type eq 5?'selected':''} ><fmt:message key="applicantQuery.type.onlinePayment"/>${queryType.queryType}</option>
				                    		<option value="6" ${ applicantQuery.type eq 6?'selected':''} ><fmt:message key="applicantQuery.type.admitCard"/>${queryType.queryType}</option>
				                    		<option value="7" ${ applicantQuery.type eq 7?'selected':''} ><fmt:message key="applicantQuery.type.result"/>${queryType.queryType}</option>
				                    		<option value="8" ${ applicantQuery.type eq 8?'selected':''} ><fmt:message key="applicantQuery.type.others"/>${queryType.queryType}</option>
				                		
									</select>
                                <div class="help-block with-errors"></div>
                            </div>
                        </div>
                    
                                                
<!--                         <div class="form-group typeOther" style="display: none"> -->
<!--                             <label for="typeOther" class="col-sm-2 control-label"> -->
<%--                                 <fmt:message key="applicantQuery.typeOther"/> --%>
<!--                             </label> -->

<!--                             <div class="col-sm-4"> -->
<%--                                 <input type="text" class="form-control" id="typeOther" name="typeOther" value="${ applicantQuery.typeOther }" placeholder="<fmt:message key="applicantQuery.typeOther"/>" > --%>
<!--                                 <div class="help-block with-errors"></div> -->
<!--                             </div> -->
<!--                         </div> -->
                    
                                                
                        <div class="form-group">

                            <label for="title" class="col-sm-2 control-label">
                                <fmt:message key="applicantQuery.title"/>
                            </label>

                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="title" name="title" value="${ applicantQuery.title }" placeholder="<fmt:message key="applicantQuery.title"/>" >
                                <div class="help-block with-errors"></div>
                            </div>
                        </div>
                    
                                                
                        <div class="form-group">

                            <label for="description" class="col-sm-2 control-label">
                                <fmt:message key="applicantQuery.description"/>
                            </label>

                            <div class="col-sm-6">
                                <textarea class="form-control" id="description" name="description" placeholder="<fmt:message key="applicantQuery.description"/>">${ applicantQuery.description }</textarea>
                                <div class="help-block with-errors"></div>
                            </div>
                        </div>
                        
                        <div class="form-group">
                        	<label for="description" class="col-sm-2 control-label">
                                <fmt:message key="applicantFiles.addAttachment"/>
                            </label>
                        	
                        	<div id="attachmentDiv" class="col-sm-6">
					            <input id="attachment" name="attachment" type="file" class="file" data-show-upload="false"
					                   data-show-caption="false" data-show-preview="true">
					            <div id="attachmentMsg" class="help-block with-errors"></div>
				            </div>
				        </div>
                        
                        <div class="form-group">
                        	<label for="description" class="col-sm-2 control-label">
<%--                                 <fmt:message key="applicantFiles.addAttachment"/> --%>
                            </label>
                        	<div class="col-sm-6 text-muted">
				                <em><fmt:message key="applicantFiles.instructions"/></em><br>
				                <em><fmt:message key="applicantFiles.supportedFiles"/></em><br>
				                <em><fmt:message key="validation.fileImageSize"><fmt:param value="512"/></fmt:message></em><br><br>
				                <c:if test="${ applicantQuery.addAttachment ne null }">
				                	<img id="addedAttachment" src="<c:url value='/file?operation=viewAddedAttachment'/>&applicantQueryId=${ applicantQuery.id }" class="img-thumbnail" alt="<fmt:message key="applicantFiles.signature"/>" width="304" height="236" onclick="addedAttachmentFunc()">
				                	<a href="<c:url value='/file?operation=downloadAddedAttachment'/>&applicantQueryId=${ applicantQuery.id }"><fmt:message key="download"/></a>
				                </c:if>
				            </div>
                        </div>
                    
                </div>
<!--                 <div class="panel-footer clearfix"> -->
                    <div class="pull-right">
                        <tags:hasPermission moduleName="applicantQuery" operation="saveApplicantQuery">
                            <button type="submit" class="btn btn-primary">
                                <fmt:message key="save"/>
                            </button>
                        </tags:hasPermission>
                        <button type="button" class="btn btn-default" onclick="window.history.back();">
                            <fmt:message key="cancel"/>
                        </button>
                    </div>
<!--                 </div> -->
<!--             </div> -->
        </div>
    </div>
</form>

