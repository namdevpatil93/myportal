<%@ include file="../common/taglibs.jsp"%>

<script>
	 $(document).ready(function(){
		 $("form#applicantAttachmentDownloadForm").validate({
		 	errorPlacement: function(error, element) {
	            if (element.attr("name") == "file" ){
	                error.appendTo($('#fileMsg'));
	            } else if(element.attr("name") == "name" ){
                    error.appendTo($('#nameMsg'));
				} else if(element.attr("name") == "postId" ){
                    error.appendTo($('#postMsg'));
                }
	        },
		 	rules: {
                name : {
                    required: true
                },
		 	    postId : {
		 			required: true
		 		},
		 		file : {
		 			required: true,
	                extension: "xls|xlsx"
		 		}
		 	}
		 });
	 });
</script>

<form class="form-horizontal" id="applicantAttachmentDownloadForm" name="applicantAttachmentDownloadForm"
	  action="<c:url value='/admin?operation=downloadApplicantAttachment'/>" method="POST" enctype="multipart/form-data">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<div class="form-group">
		<label for="file" class="col-sm-2 control-label">Name</label>
		<div class="col-sm-4">
			<input id="name" name="name" type="text" size="59" maxlength="255">
			<div id="nameMsg" class="help-block with-errors"></div>
		</div>
	</div>
	<div class="form-group">
		<label for="postId" class="col-sm-2 control-label">Post</label>
		<div class="col-sm-4">
			<select id="postId" name="postId" class="form-control" data-size="5">
				<option value="">-- Select Post --</option>
				<c:forEach items="${posts}" var="post">
					<option value="${post.postId}" ${ post.postId eq applicantPostAssoc.divisionId? 'selected':'' }><fmt:message key="${ post.messageKey }" /></option>
				</c:forEach>
			</select>
			<div id="postMsg" class="help-block with-errors"></div>
		</div>
	</div>
	<div class="form-group">
		<label for="file" class="col-sm-2 control-label">File</label>
		<div class="col-sm-4">
			<input id="file" name="file" type="file" class="file" data-show-upload="false"
				   data-show-caption="true" data-show-preview="false"><a href="<c:url value='/static/app/excel/ApplicantFormsUploadFormat.xls' />" download target="_blank">
			<fmt:message key="qualification.download.sample.file"/>
		</a>
			<div id="fileMsg" class="help-block with-errors"></div>
		</div>
	</div>

	<div class="form-group">
		<div class="col-sm-offset-2 col-sm-10">
			<button id="saveBtn" class="btn btn-primary sw-btn-next" type="submit">
				Generate
			</button>
		</div>
	</div>
</form>

<div style="overflow-y:scroll; height: 300px;" >
	<table id="applicant-form-grid" class="table table-condensed table-hover table-striped table-bordered">
		<thead>
		<tr>
			<th>
				Name
			</th>
			<th>
				Post
			</th>
			<th>
				Created By
			</th>
			<th>
				Created Date
			</th>
			<th>
			</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach var="applicantForm" items="${allApplicantFormList}">
			<tr>
				<td class="col-md-3">
					<c:out value="${applicantForm.name}"/>
				</td>
				<td class="col-md-3">
					<c:out value="${applicantForm.post.postTitle}"/>
				</td>
				<td class="col-md-3">
					<c:out value="${applicantForm.user.firstname } "/>&nbsp;<c:out value="${applicantForm.user.lastname} "/>
				</td>
				<td class="col-md-3">
					<tags:localDateTime datetime="${applicantForm.createdDate}" pattern="dd, MMM yyyy hh:mm aa"/>
				</td>
				<td>
					<a href="javascript:void(0)" onclick="javascript:commonObj.goToURL('<c:url value='/admin?operation=downloadApplicantFormsZip'/>&applicantFormId=${ applicantForm.id}')">
                        <i>download</i>
                    </a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>

</div>
