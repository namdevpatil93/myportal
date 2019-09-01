<%@ include file="../common/taglibs.jsp"%>
<%@page pageEncoding="UTF-8"%>
 
<link rel="stylesheet" href="<c:url value='/static/libs/bootstrap-fileinput/css/fileinput.min.css'/>" >
<script type="text/javascript" src="<c:url value='/static/libs/bootstrap-fileinput/js/fileinput.min.js'/>"></script>

<link rel="stylesheet" href="<c:url value='/static/libs/imageviewer/dist/viewer.min.css'/>" >
<script type="text/javascript" src="<c:url value='/static/libs/imageviewer/dist/viewer.min.js'/>"></script>
 
 <style>
 	a:hover {
	    color: #fff;
	}
 </style>
 <script>
 $(document).ready(function(){
	 var userRole ='${userRole}';
	 if(userRole == 2)
	 {
	 	$(".chatAdmin").addClass('msgAdmin');	
	 	$(".chatClient").addClass('msg');
	 }
	 else
	 {
	 	$(".chatAdmin").addClass('msg');
	  	$(".chatClient").addClass('msgAdmin');
	 }
	 
	 $("form[name='applicantQueryReplyForm']").validate({
		 rules: {
			 reply: { 
		    	  required: true
		      },
		      attachment: {
		    	  extension: "jpg|jpeg|png",
	              filesize: 512
	          }
	 	},
	 	errorPlacement: function(error, element) {
            if (element.attr("name") == "attachment" ) {
                error.appendTo($('#attachmentMsg'));
            } else if (element.attr("name") == "reply" ) {
            	error.appendTo($('descriptionMsg'));
            }
        }
	 });
 });
 
 function imageViewer(id) {
	 $('#my_'+id).viewer();
 }
</script>

 <c:if test="${ userRole eq 2}">
 	<c:set var="formaction" value="applicantQuery?operation=saveApplicantQueryReply&queryId=${applicantQuery.id}"></c:set>
 </c:if>
 
 <c:if test="${ userRole eq 1}">
 	<c:set var="formaction" value="applicantQuery?operation=saveApplicantQueryReply&id=-1"></c:set>
 </c:if>

<form name="applicantQueryReplyForm" id="applicantQueryReplyForm" data-toggle="validator" class="form-horizontal" action="${formaction}" method="POST" enctype="multipart/form-data">

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<%--     <input type="hidden" name="id" value="${notification.id }"/> --%>
  	<input type="hidden" name="queryId" value="${applicantQuery.id }"/>
    <input type="hidden" name="userId" value="${applicantQuery.applicantId }"/>
    <input type="hidden" id="menu" name="menu" value="notificationListMenuOption" />

    <div class="row">
        <div class="col-sm-12">
<!--             <div class="panel panel-default"> -->

<!--                 <div class="panel-body"> -->

                        <div class="form-group">

                            <label for="title" class="col-sm-2 control-label">
                                <fmt:message key="notification.title"/>
                            </label>

                            <div class="col-sm-4">
                                 <label>${applicantQuery.title}</label>
                                <div class="help-block with-errors"></div>
                            </div>
                        </div>
                    
                                                
                        <div class="form-group">

                            <label for="description" class="col-sm-2 control-label">
                                <fmt:message key="notification.description"/>
                            </label>

                            <div class="col-sm-4">
								<label>${applicantQuery.description}</label>
                                <div id="descriptionMsg" class="help-block with-errors"></div>
                            </div>
                        </div>
                        
                        <c:if test="${ applicantQuery.addAttachment ne null }">
	                        <div class="form-group">
	                            <label for="description" class="col-sm-2 control-label">
	                                <fmt:message key="applicantFiles.addAttachment"/>
	                            </label>
	
	                            <div class="col-sm-4">
				                	<img id="addedAttachment" src="<c:url value='/file?operation=viewAddedAttachment'/>&applicantQueryId=${ applicantQuery.id }" class="img-thumbnail" alt="<fmt:message key="applicantFiles.signature"/>" width="304" height="236" onclick="addedAttachmentFunc()"><br />
				                	<a href="<c:url value='/file?operation=downloadAddedAttachment'/>&applicantQueryId=${ applicantQuery.id }"><fmt:message key="download"/></a>
	                            </div>
	                        </div>
                        </c:if>
                        <c:forEach var="qReply" items="${applicantQueryReply}">
	                        <c:choose>
	                        	<c:when test="${ qReply.userType eq 1}">
	                        		
				                        <div class="form-group chatAdmin">
				                            <div class="">
<%-- 				                                <textarea disabled style="background:green" class="form-control" id="reply" name="reply" >${qReply.reply}</textarea> --%>
				                               		<label>
				                               			${ qReply.reply } <br /><br />
				                                		<c:if test="${ qReply.addAttachment ne null }">
				                                			<img id="my_${ qReply.id }" src="<c:url value='/file?operation=viewReplyAttachment'/>&applicantQueryReplyId=${ qReply.id }" class="img-thumbnail" alt="<fmt:message key="applicantFiles.signature"/>" width="130" onclick="imageViewer(${ qReply.id })"><br />
				                                			<a href="<c:url value='/file?operation=downloadReplyAttachment'/>&applicantQueryReplyId=${ qReply.id }"><fmt:message key="download"/></a>
				                                		</c:if>
				                               		</label>
				                                <!-- <div class="help-block with-errors"></div> -->
				                            </div>
				                        </div>
				                        <div class="clearfix"></div>
	                        	</c:when>
	                        	<c:otherwise>
				                        <div class="form-group chatClient">
				                            <div class="">
<%-- 				                                <textarea disabled class="form-control" id="reply" name="reply" >${qReply.reply}</textarea> --%>
				                                	<label>
				                                		${ qReply.reply } <br /><br />
				                                		<c:if test="${ qReply.addAttachment ne null }">
				                                			<img id="my_${ qReply.id }" src="<c:url value='/file?operation=viewReplyAttachment'/>&applicantQueryReplyId=${ qReply.id }" class="img-thumbnail" alt="<fmt:message key="applicantFiles.signature"/>" width="130" onclick="imageViewer(${ qReply.id })"><br />
				                                			<a href="<c:url value='/file?operation=downloadReplyAttachment'/>&applicantQueryReplyId=${ qReply.id }"><fmt:message key="download"/></a>
				                                		</c:if>
				                                	</label>
				                                <!-- <div class="help-block with-errors"></div> -->
				                            </div>
				                        </div>
				                        <div class="clearfix"></div>
	                        	</c:otherwise>
	                        </c:choose>
                       </c:forEach>
                    	<div class="form-group">
	                            <div class="col-sm-4">
	                                <textarea class="form-control" id="newReply" name="reply" rows="5"></textarea>
	                                <div class="help-block with-errors"></div>
	                            </div>
	                    </div>
	                    
	                    <div class="form-group">
                            <div id="attachmentDiv" class="col-sm-4">
					            <input id="attachment" name="attachment" type="file" class="file" data-show-upload="false"
					                   data-show-caption="true" data-show-preview="false">
					            <div id="attachmentMsg" class="help-block with-errors"></div>
					            <em><fmt:message key="applicantFiles.instructions"/></em><br>
				                <em><fmt:message key="applicantFiles.supportedFiles"/></em><br>
				                <em><fmt:message key="validation.fileImageSize"><fmt:param value="512"/></fmt:message></em><br><br>
				            </div>
                        </div>
                    
<!--                 </div> -->
               <div class="form-group">
                    <div class="col-sm-4">
                        <tags:hasPermission moduleName="applicantQuery" operation="saveApplicantQueryReply">
                            <button type="submit" class="btn btn-primary">
                                <fmt:message key="msg.send"/>
                            </button>
                        </tags:hasPermission>
                        
                        <c:if test="${ userRole eq 1}">
	                        <button type="button" class="btn btn-default"onclick="javascript:commonObj.goToURL('<c:url value='/notification?operation=viewQueriesAndNotifications&menu=viewQueriesAndNotifications'/>');">
	                            <fmt:message key="cancel"/>
	                        </button>
                        </c:if>
                        <c:if test="${ userRole eq 2}">
                        	<button type="button" class="btn btn-default"onclick="javascript:commonObj.goToURL('<c:url value='/applicantQuery?operation=applicantQueryList&menu=applicantQueryListMenuOption'/>&id='+ ${applicantQuery.applicantId });">
	                            <fmt:message key="cancel"/>
	                        </button>
                        </c:if>
                    </div>
                </div>
<!--             </div> -->
        </div>
    </div>
</form>

