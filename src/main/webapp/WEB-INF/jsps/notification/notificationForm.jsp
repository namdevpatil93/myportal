<%@ include file="../common/taglibs.jsp"%>

<script type="text/javascript">

    jQuery(document).ready(function () {
    	$('.selectpicker').selectpicker();
      //  CKEDITOR.replace('description');

        $("#createNotificationForm").validate({
            rules: {
                title : {
                	required : true
                },
            	description: {
                    required: true,
                    minlength:1
                },
            },
            messages: {
                description: {
                    required:"Please enter description"
                }
            }
        });

    });

</script>

<form name="createNotificationForm" id="createNotificationForm"
	action="<c:url value='/notification?operation=saveNotification'/>"
	method="POST">
<%-- 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> --%>
	<input type="hidden" name="id" value="${notification.id }" />
	<input type="hidden" id="menu" name="menu" value="viewQueriesAndNotifications" />

	<div class="row">
		<div class="clearfix">
			

				<div class="panel-heading">
					<h3 class="panel-title">
						<fmt:message key="notification.add" />
					</h3>
				</div>
				
				<jsp:include page="../admin/applicantSearchFields.jsp"/>
				
				<div class="panel-body">

					<div class="form-group">
						<label for="title" class="col-sm-2 control-label"> <fmt:message
								key="notification.title" />
						</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="title" name="title"
								value="${ notification.title }"
								placeholder="<fmt:message key="notification.title"/>" 
								maxlength="200">
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label for="description" class="col-sm-2 control-label"> <fmt:message
								key="notification.description" />
						</label>
						<div class="col-sm-10">
							<textarea rows="10" cols="91" id="description" name="description"
								placeholder="<fmt:message key="notification.description"/>"
								 maxlength="4000" style="width:100%;">${ notification.description }</textarea>
							<div class="help-block with-errors"></div>
						</div>
					</div>


				</div>
				
				<!-- <div class="panel-footer clearfix"> -->
					
				<!-- </div> -->
			<!-- </div> -->
		</div>
		
		<div class="pull-right">
						<tags:hasPermission moduleName="notification"
							operation="saveNotification">
							<button type="submit" class="btn btn-primary">
								<fmt:message key="notification.save" />
							</button>
						</tags:hasPermission>
						<button type="button" class="btn btn-default"
							onclick="javascript:commonObj.goToURL('<c:url value='notification?operation=viewQueriesAndNotifications&viewNotificationsPage=true&menu=viewQueriesAndNotifications'/>');">
							<fmt:message key="cancel" />
						</button>
					</div>
	</div>
</form>

