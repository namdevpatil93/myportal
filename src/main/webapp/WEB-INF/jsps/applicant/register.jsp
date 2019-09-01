<%@ include file="../common/taglibs.jsp"%>
<script type="text/javascript" src="<c:url value='/static/libs/jquery-validation/dist/jquery.validate.js'/>"></script>
<script src="https://www.google.com/recaptcha/api.js?hl=${pageContext.response.locale}" async defer></script>

<script>

	jQuery(document).ready(function() {
		var useremailexists = ${emailExists};
		
		 
		if(useremailexists){
			$('#emailExistErrorDiv').show();	
		}else{
			$('#emailExistErrorDiv').hide();
		}

		var now=new Date();

		now.setFullYear(now.getFullYear() - 18);
		$('#birthDate').datetimepicker({
			
			format: 'DD/MM/YYYY',
			ignoreReadonly: true,
			showTodayButton: true,
			maxDate: now,
			//defaultDate: now,
			date : '<tags:localDate pattern="MM/dd/yyyy" date="${applicant.birthDate}" />'
		});

		$('#birthDateCalendarIcon').click(function() {
			$('#birthDate').data("DateTimePicker").show();
		});

		/* $('#address').on('change', function () {
			alert("hi");
		    var hasNumber = this.value.match(/\d/);
		    var isAlfa    = this.value.match(/^[0-9a-zA-Z]+$/);

		    if ( isAlfa && hasNumber ) {
		    	$('#addressTextArea').removeClass('has-error').removeClass('has-danger');
		    	$('#addressError').html(''); 
		        return true;
		    } else {
		    	alert("hello");
		    	$('#addressTextArea').addClass('has-error has-danger');
		        $('#addressError').html('<ul class="list-unstyled"><li>Special Characters not allowed.</li></ul>');  
		        return false; 
		    }
		}); */
				
	});
	
</script>
<style>
form .error {
  color: #a94442;
}
</style>
<div class="registermain">
	<div class="registrationnote">
		<ul>
			<li><fmt:message key="HeaderNote1"/></li>
			<li><fmt:message key="HeaderNote2"/></li>
			<li><fmt:message key="HeaderNote3"/></li>
			<li><fmt:message key="HeaderNote4"/></li>
		</ul>
	</div>
	<h4 class="text-center heading"><fmt:message key="mainHeader"/></h4>
	<div class="registerwrap">

		<c:forEach items="${errors}" var="error">
			<span class="error"><c:out value="${error.defaultMessage}" /></span>
		</c:forEach>


		<form class="form-horizontal" name="registerNewUserForm" id="registerNewUserForm" action="<c:url value='/applicant/register'/>" method="POST">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			<div class="form-group required">
				<label class="control-label col-xs-4" for="firstName"><fmt:message key="applicant.firstName"/>: <span class="red">*</span></label>
				<div class="col-xs-4">
					<input type="text" class="form-control" id="firstName" placeholder="<fmt:message key="firstname.field.placeholder.english"/>" name="firstName" value="${applicant.firstName }" maxlength="100">
					<div class="help-block with-errors"></div>
				</div>
				<div class="col-xs-4">
					<input type="text" class="form-control" id="firstName_marathi" placeholder="<fmt:message key="firstname.field.placeholder.marathi"/>" name="firstNameMarathi" value="${applicant.firstNameMarathi }" maxlength="100">
					<div class="help-block with-errors"></div>
				</div>
			</div>

			<div class="form-group required">
				<label class="control-label col-xs-4" for="middleName"><fmt:message key="applicant.middleName"/>: <span class="red">*</span></label>
				<div class="col-xs-4">
					<input type="text" class="form-control" id="middleName" placeholder="<fmt:message key="middlename.field.placeholder.english"/>" name="middleName" value="${applicant.middleName }" oninvalid="this.setCustomValidity('<fmt:message key="validation.requiredfield"/>')" maxlength="100">
					<div class="help-block with-errors"></div>
				</div>
				<div class="col-xs-4">
					<input type="text" class="form-control" id="middleName_marathi" placeholder="<fmt:message key="middlename.field.placeholder.marathi"/>" name="middleNameMarathi" value="${applicant.middleNameMarathi }" oninvalid="this.setCustomValidity('<fmt:message key="validation.requiredfield"/>')" maxlength="100">
					<div class="help-block with-errors"></div>
				</div>
			</div>

			<div class="form-group required">
				<label class="control-label col-xs-4" for="lastName"><fmt:message key="applicant.lastName" />: <span class="red">*</span></label>
				<div class="col-xs-4">
					<input type="text" class="form-control" id="lastName" placeholder="<fmt:message key="lastname.field.placeholder.english" />" name="lastName" value="${applicant.lastName }" maxlength="100" >
					<div class="help-block with-errors"></div>
				</div>
				<div class="col-xs-4">
					<input type="text" class="form-control" id="lastName_marathi" placeholder="<fmt:message key="lastname.field.placeholder.marathi" />" name="lastNameMarathi" value="${applicant.lastNameMarathi }" maxlength="100" >
					<div class="help-block with-errors"></div>
				</div>
			</div>

			<div class="form-group required">
				<label class="control-label col-xs-4" for="birthDate"><fmt:message key="applicant.birthDate"/>: <span class="red">*</span></label>
				<div class="col-xs-8">
					<div class="input-group date">
						<input type="datetime" class="form-control" id="birthDate" placeholder="<fmt:message key="applicant.birthDate"/>" name="birthDate" readonly
							   required>
						<div class="input-group-addon" id="birthDateCalendarIcon">
							<i class="fa fa-calendar"></i>
						</div>
						<div class="help-block with-errors"></div>
					</div>
				</div>
			</div>

			  <div class="form-group required">
				<label class="control-label col-xs-4" for="input-gender-male"><fmt:message key="applicant.gender"/>: <span class="red">*</span></label>
				<div class="col-xs-8">
					<label class="radio-inline">
						<input name="gender" ${ applicant.gender eq 1 ? 'checked="checked"':''} id="input-gender-male" value="1" type="radio" /><span><fmt:message key="applicant.gender.male"/></span>
					</label>
					<label class="radio-inline">
						<input name="gender" ${ applicant.gender eq 0 ? 'checked="checked"':''} id="input-gender-female" value="0" type="radio" /><span><fmt:message key="applicant.gender.female"/></span>
					</label>
					<div class="help-block with-errors"></div>
					<div id="radioerr"></div>
				</div>
			</div>
			<div id="addressTextArea" class="form-group required">
				<label class="control-label col-xs-4" for="address"><fmt:message key="applicant.address"/>: <span class="red">*</span></label>
				<div class="col-xs-8">
					<textarea class="form-control" rows="5" id="address" name="address" maxlength="1000" placeholder="<fmt:message key="applicant.address"/>">${applicant.address }</textarea>
					<div id="addressError" class="help-block with-errors"></div>
				</div>
			</div>

			<div class="form-group required">
				<label class="control-label col-xs-4" for="pinCode"><fmt:message key="applicant.pinCode"/>: <span class="red">*</span></label>
				<div class="col-xs-8">
					<input name="pinCode" value="${applicant.pinCode }" class="form-control" id="pinCode" type="tel" maxlength="6" placeholder="<fmt:message key="applicant.pinCode"/>" />
					<div class="help-block with-errors"></div>
				</div>
			</div>

			<div class="form-group required">
				<label class="control-label col-xs-4" for="emailAddress"><fmt:message key="applicant.emailAddress"/>: <span class="red">*</span></label>
				<div class="col-xs-8">
					<input name="emailAddress" value="${applicant.emailAddress }" class="form-control" onchange="hideEmailExistError()" id="emailAddress" maxlength="30" placeholder="<fmt:message key="applicant.emailAddress"/>" />
					<div class="help-block with-errors"></div>
					<div id="emailExistErrorDiv" class="error" style="color: #B94A48"><fmt:message key="registration.email.address.already.exists" /></div>
				</div>
			</div>

			<div class="form-group required">
				<label class="control-label col-xs-4" for="mobileNumber"><fmt:message key="applicant.mobileNumber"/>: <span class="red">*</span></label>
				<div class="col-xs-8">
					<input name="mobileNumber" value="${applicant.mobileNumber }" class="form-control" id="mobileNumber" maxlength="10"  placeholder="<fmt:message key="applicant.mobileNumber"/>"/>
					<div class="help-block with-errors"></div>
				</div>
			</div>

			<div class="form-group required">
				<label class="control-label col-xs-4"></label>
				<div class="col-xs-8">
					<img id="captcha_image" src="<c:url value='/captcha'/>" />
					<a style="cursor: pointer;"><i  class="fa fa-refresh" onclick="reloadCaptcha()" aria-hidden="true"></i></a>

				</div>
			</div>

			<div class="form-group required">
				<label class="control-label col-xs-4"><fmt:message key="applicant.captchacode"/>: <span class="red">*</span></label>
				<div class="col-xs-4">
					<input type="text" name="answer" onchange="hideCaptchaErrorDiv()" class="form-control" size="20"/>
                    <div id="captchaErrorDiv" class="help-block with-errors">
                        <c:if test="${ invalidCaptcha }">
                            <fmt:message key="invalidCaptcha"/>
                        </c:if>
                    </div>
				</div>
			</div>

			<div class="form-group required">
				<label class="control-label col-xs-4"></label>
				<div class="col-xs-8">
					<input class="btn btn-success" id="btnSubmit" onclick="saveRegistrationForm()" value="<fmt:message key="submit"/>" type="button" />
					<input class="btn btn-default" id="btnCancel" value="<fmt:message key="cancel"/>" type="button" onclick="javascript:commonObj.goToURL('<c:url value='/'/>');"/>
				</div>
			</div>

		</form>
	</div>
</div>

<script type="text/javascript">
	function reloadCaptcha(){
		var d = new Date();
		$("#captcha_image").attr("src", "<c:url value='/captcha'/>?"+d.getTime());
	}
</script>

<script>
	$(document).ready(function(){
		
		$("form[name='registerNewUserForm']").validate({
		    // Specify validation rules
		    rules: {
		      // The key name on the left side is the name attribute
		      // of an input field. Validation rules are defined
		      // on the right side
		      firstName: { 
		    	  required: true,
		    	  englishlettersonly: true,
		    	  noSpace: true
		      },
		      middleName: { 
		    	  required: true,
		    	  englishlettersonly: true,
		    	  noSpace: true
		      },
		      lastName: { 
		    	  required: true,
		    	  englishlettersonly: true,
		    	  noSpace: true
		      },
		      firstNameMarathi:{
		    	  required: true,
		    	  marathilettersonly: true,
		    	  noSpace: true
			  },
		      middleNameMarathi:{
		    	  required: true,
		    	  marathilettersonly: true,
		    	  noSpace: true
			  },
		      lastNameMarathi:{
		    	  required: true,
		    	  marathilettersonly: true,
		    	  noSpace: true
			  },
		      address:{
		    	 required: true,
		    	 noSpace: true
		      },
		      gender:{
			    	 required: true,
			      },
		      pinCode:{
		    	  required: true,
		    	  numbersonly: true,
			      minlength: 6,
			      maxlength: 6,
			      noSpace: true
		      },
		      emailAddress: {
		        required: true,
				  myEmail: true,
				  noSpace: true
		      },
		      mobileNumber:{
		    	  required: true,
		    	  numbersonly: true,
			      minlength: 10,
			      maxlength: 10,
			      noSpace: true
		    },
		    answer : "required"
		    },
		    messages:
		    {
		    	pinCode : {minlength : "<fmt:message key="number.six" var="key" /><fmt:message key="validate.minlength"><fmt:param value="${key}" /></fmt:message>"},
		   		mobileNumber : {minlength : "<fmt:message key="number.ten" var="key" /><fmt:message key="validate.minlength"><fmt:param value="${key}" /></fmt:message>"}
		    },
		    errorPlacement: function (error, element) {
		    	if ( element.is(":radio") ) 
	            {
	                error.appendTo($('#radioerr') );
	            }
		    	else
		    	{
		    		error.insertAfter( element );
		    	}
		    }
		  });
	});
</script>
<script>
	$(document).ready(function () {

		//openKeyboard("mar");

		jQuery("#btnSubmit").attr("disabled",false);
        jQuery("#btnCancel").attr("disabled",false);
		/* enableTyping(
				new Array('firstName','middleName','lastName'),
				new Array('firstName_marathi','middleName_marathi','lastName_marathi'),
				'NAME',
				'mr_in'); */
	});

	function saveRegistrationForm(){
		if ($("#registerNewUserForm").valid()) {
				jQuery("#btnSubmit").attr("disabled",true);
		        jQuery("#btnCancel").attr("disabled",true);
        }
        $("#registerNewUserForm").submit();
	}
	
	function hideEmailExistError(){
		$('#emailExistErrorDiv').hide();
	}
	
	function hideCaptchaErrorDiv(){
		$('#captchaErrorDiv').hide();
	}
</script>