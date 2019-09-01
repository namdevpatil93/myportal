<%@ include file="../common/taglibs.jsp"%>


<script>
	//Advance Filter
	$( document ).ready(function() {
		/*if ( ${searchType eq '1'} ) {
			advanceShow();
		} else {
			advanceHide();
		}*/
		
	});
	
	function advanceOrBasicFunc() {
		if ( $('#advanceOrBasic').text() == 'Advance Search' ) {
			advanceShow();
		} else {
			advanceHide();
		}
	}
	
	function advanceHide() {
		$( '.advanceFilter' ).hide();
	    $( '#advanceOrBasic' ).text( 'Advance Search' );
	    $( '#searchType' ).val( '0' );
	    //$('form#applicantsListSearchForm .advanceFilter').find('select').val('');
	    $('form').find('.advanceFilter').find('.selectpicker').val('').selectpicker('refresh');
	}
	
	function advanceShow() {
		$( '.advanceFilter' ).show();
		$( '#advanceOrBasic' ).text( 'Basic Search' );
		$( '#searchType' ).val( '1' );
	}
	
	function formSubmit() {
		$('form#applicantsListSearchForm').submit();
	}
	
	function formReset() {
		//advanceHide();
		$('form').find('input[type=text], select').val('');
		$('form').find('.selectpicker').val('').selectpicker('refresh');
		//$('form#applicantsListSearchForm').find('input[type=radio]').attr('checked', false);
	}
	
</script>

	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input id="pageNumber" type="hidden" name="pageNumber" value="1"/>
<%-- 	<input id="searchType" type="hidden" name="searchType" value="${searchType}"/> --%>
	<div class="form-group row">
	  <div class="col-md-1">
	  	Name
	  </div>
	  <div class="col-md-3">
	  	<input value="${applicantSearchDTO.name}" type="text" class="form-control" id="name" placeholder="" name="name" maxlength="100">
	  </div>
	  <!-- <div class="col-md-1"></div> -->
	  <div class="col-md-1">
	  	Applicant Id
	  </div>
	  <div class="col-md-3">
	  	<input value="${applicantSearchDTO.applicantId}" type="text" class="form-control" id="applicantId" placeholder="" name="applicantId" maxlength="100">
	  </div>
	  <!-- <div class="col-md-1"></div> -->
	  <div class="col-md-1">
	  	Caste
	  </div>
	  <div class="col-md-3">
	  	<select id="caste" name="caste" class="selectpicker">
            <option value="">-- <fmt:message key="please.select"/> --</option>
            <c:forEach items="${castes}" var="caste">
                <option value="${caste.id}" ${ caste.id eq applicantSearchDTO.caste? 'selected=selected':'' }><fmt:message key="${ caste.messageKey }" /> </option>
            </c:forEach>
        </select>
	  </div>
	  <!-- <div class="col-md-1"></div> -->
	</div>
	
	<div class="form-group row">
	  <div class="col-md-1">
	  	Differently Abled
	  </div>
	  <div class="col-md-3">
	    <select id="differentlyAbledSelect" name="differentlyAbledSelect" class="selectpicker" multiple data-actions-box="true">
		  <option value="1" ${ fn:contains(applicantSearchDTO.differentlyAbledSelect, '1') ? 'selected=selected':'' }><fmt:message key="applicant.differentlyAbled.blindnessandlowvision"/></option>
		  <option  value="2" ${ fn:contains(applicantSearchDTO.differentlyAbledSelect, '2') ? 'selected=selected':'' }><fmt:message key="applicant.differentlyAbled.deafandmute"/></option>
		  <option  value="3" ${ fn:contains(applicantSearchDTO.differentlyAbledSelect, '3') ? 'selected=selected':'' }><fmt:message key="applicant.differentlyAbled.locomotororcerebralpalsy"/></option>
		</select>
	  </div>
	  <!-- <div class="col-md-1"></div> -->
	  <div class="col-md-1">
	  	Gender
	  </div>
	  <div class="col-md-3">
	    <select id="gender" name="gender" class="selectpicker">
            <option value="">-- <fmt:message key="please.select"/> --</option>
            <option value="1" ${ applicantSearchDTO.gender eq 1 ? 'selected=selected':'' }><fmt:message key="applicant.gender.male" /> </option>
            <option value="0" ${ applicantSearchDTO.gender eq 0 ? 'selected=selected':'' }><fmt:message key="applicant.gender.female" /> </option>
        </select>
	  </div>
	  <!-- <div class="col-md-1"></div> -->
	  <div class="col-md-1">
	  	Payment Status
	  </div>
	  <div class="col-md-3">
	    <select id="paidUnpaid" name="paidUnpaid" class="selectpicker">
            <option value="">-- <fmt:message key="please.select"/> --</option>
            <option value="0" ${  applicantSearchDTO.paidUnpaid eq 0 ? 'selected=selected':'' }><fmt:message key="status.pending" /> </option>
            <option value="1" ${ applicantSearchDTO.paidUnpaid eq 1 ? 'selected=selected':'' }><fmt:message key="status.success" /> </option>
            <option value="2" ${ applicantSearchDTO.paidUnpaid eq 2 ? 'selected=selected':'' }><fmt:message key="status.failed" /> </option>
        </select>
	  </div>
	  <!-- <div class="col-md-1"></div> -->
	</div>
	
	<div class="form-group row">
	  <div class="col-md-1">
	  	Payment Mode
	  </div>
	  <div class="col-md-3">
	    <select id="onlineOffline" name="onlineOffline" class="selectpicker">
            <option value="">-- <fmt:message key="please.select"/> --</option>
            <option value="1" ${  applicantSearchDTO.onlineOffline eq 1 ? 'selected=selected':'' }><fmt:message key="payment.online" /> </option>
            <option value="2" ${ applicantSearchDTO.onlineOffline eq 2 ? 'selected=selected':'' }><fmt:message key="payment.offline" /> </option>
        </select>
	  </div>
	  <!-- <div class="col-md-1"></div> -->
	  <div class="col-md-1">
	  	Post
	  </div>
	  <div class="col-md-3">
	  	<select id="post" name="post" class="selectpicker">
            <option value="">-- <fmt:message key="please.select"/> --</option>
            <c:forEach items="${posts}" var="post">
				<option value="${post.postId}" ${ post.postId eq applicantSearchDTO.post? 'selected':'' }>${ post.postTitle }</option>
			</c:forEach>
		</select>
	  </div>
	  <!-- <div class="col-md-1"></div> -->
	  <div class="col-md-1">
	  	District
	  </div>
	  <div class="col-md-3">
	  	<select id="district" name="district" class="selectpicker">
            <option value="">-- <fmt:message key="please.select"/> --</option>
            <c:forEach items="${districts}" var="district">
				<option value="${district.id}" ${ district.id eq applicantSearchDTO.district? 'selected':'' }><fmt:message key="${ district.messageKey }" /></option>
			</c:forEach>
		</select>
	  </div>
	  <!-- <div class="col-md-1"></div> -->
	</div>
	
	
	
	<div class="form-group row advanceFilter">
	  <div class="col-md-1">
	  	Project Affected
	  </div>
	  <div class="col-md-3">
	    <select id="projectAffected" name="projectAffected" class="selectpicker">
            <option value="">-- <fmt:message key="please.select"/> --</option>
            <option value="1" ${ applicantSearchDTO.projectAffected ? 'selected=selected':'' }><fmt:message key="yes" /> </option>
            <option value="0" ${ applicantSearchDTO.projectAffected eq false ? 'selected=selected':'' }><fmt:message key="no" /> </option>
        </select>
	  </div>
	  <!-- <div class="col-md-1"></div> -->
	  <div class="col-md-1">
	  	Earthquake Affected
	  </div>
	  <div class="col-md-3">
	    <select id="earthQuickAffected" name="earthQuickAffected" class="selectpicker">
            <option value="">-- <fmt:message key="please.select"/> --</option>
            <option value="1" ${ applicantSearchDTO.earthQuickAffected ? 'selected=selected':'' }><fmt:message key="yes" /> </option>
            <option value="0" ${ applicantSearchDTO.earthQuickAffected eq false ? 'selected=selected':'' }><fmt:message key="no" /> </option>
        </select>
	  </div>
	  <!-- <div class="col-md-1"></div> -->
	  <div class="col-md-1">
	  	Ex-Service Man
	  </div>
	  <div class="col-md-3">
	    <select id="exServiceMan" name="exServiceMan" class="selectpicker">
            <option value="">-- <fmt:message key="please.select"/> --</option>
            <option value="1" ${ applicantSearchDTO.exServiceMan ? 'selected=selected':'' }><fmt:message key="yes" /> </option>
            <option value="0" ${ applicantSearchDTO.exServiceMan eq false ? 'selected=selected':'' }><fmt:message key="no" /> </option>
        </select>
	  </div>
	  <!-- <div class="col-md-1"></div> -->
	</div>
	
	<div class="form-group row advanceFilter">
	  <div class="col-md-1">
	  	Part Time Employee
	  </div>
	  <div class="col-md-3">
	    <select id="partTimeEmployee" name="partTimeEmployee" class="selectpicker">
            <option value="">-- <fmt:message key="please.select"/> --</option>
            <option value="1" ${ applicantSearchDTO.partTimeEmployee ? 'selected=selected':'' }><fmt:message key="yes" /> </option>
            <option value="0" ${ applicantSearchDTO.partTimeEmployee eq false ? 'selected=selected':'' }><fmt:message key="no" /> </option>
        </select>
	  </div>
	  <!-- <div class="col-md-1"></div> -->
	  <div class="col-md-1">
	  	Sports Person
	  </div>
	  <div class="col-md-3">
	    <select id="sportsPerson" name="sportsPerson" class="selectpicker">
            <option value="">-- <fmt:message key="please.select"/> --</option>
            <option value="1" ${ applicantSearchDTO.sportsPerson ? 'selected=selected':'' }><fmt:message key="yes" /> </option>
            <option value="0" ${ applicantSearchDTO.sportsPerson eq false ? 'selected=selected':'' }><fmt:message key="no" /> </option>
        </select>
	  </div>
	  <!-- <div class="col-md-1"></div> -->
	  <div class="col-md-1">
	  	S.T. Employee
	  </div>
	  <div class="col-md-3">
	    <select id="sTEmployee" name="sTEmployee" class="selectpicker">
            <option value="">-- <fmt:message key="please.select"/> --</option>
            <option value="1" ${ applicantSearchDTO.sTEmployee ? 'selected=selected':'' }><fmt:message key="yes" /> </option>
            <option value="0" ${ applicantSearchDTO.sTEmployee eq false ? 'selected=selected':'' }><fmt:message key="no" /> </option>
        </select>
	  </div>
	  <!-- <div class="col-md-1"></div> -->
	</div>
	<div class="form-group row">
	  <div class="col-md-1">
	  	Mobile Number
	  </div>
	  <div class="col-md-3">
	  	<input value="${applicantSearchDTO.mobileNumber}" type="text" class="form-control" id="mobileNumber" placeholder="" name="mobileNumber"  maxlength="10">
	  </div>
	   <div class="col-md-1">
	  	Email ID
	  </div>
	  <div class="col-md-3">
	  	<input value="${applicantSearchDTO.emailId}" type="text" class="form-control" id="emailId" placeholder="" name="emailId" maxlength="100">
	  </div>
	  </div>
	<!--<div class="form-group">
		<div class="col-md-12">
			<a id="advanceOrBasic" href="javascript:void(0);" onclick="javascript:advanceOrBasicFunc()"></a>
		</div>
	</div>-->
	<c:if test="${ !isNotifications }">
		<input id="search" type="button" class="btn btn-primary" value="Search" onclick="javascript:formSubmit();"/>
	</c:if>
	<input id="search" type="button" class="btn btn-default" value="Reset" onclick="javascript:formReset();"/>