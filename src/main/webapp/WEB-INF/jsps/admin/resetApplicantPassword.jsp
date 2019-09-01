<%@ include file="../common/taglibs.jsp"%>
<%@ page pageEncoding="UTF-8"%>

<script>

    $(document).ready(function() {

        $("#resetApplicantPasswordForm").validate();

        jQuery("#resetApplicantPasswordForm").ajaxForm({
            dataType:  'json',
            beforeSubmit:  function(){
                return true;
            },
            success:  function(result){
                var status = result.status;
                if(status == 1 || status == '1' ){
                    commonObj.showAlert("Password has been successfully changed for the Application ID. New password is " + result.newPassword);
                    administrationObj.goToTab('4');
                }
                else if(status == 2 || status == '2' ){
                    commonObj.showAlert("There is no applicant with the given Application ID. Please enter a valid Application ID.");
                } else {
                    commonObj.showAlert("There was some error while trying to reset applicants password.");
                }
            }
        });
    });

</script>

<form name="resetApplicantPasswordForm" id="resetApplicantPasswordForm" class="form-horizontal"
      action="<c:url value='/admin?operation=resetApplicantPassword'/>" method="POST" >

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

    <div class="form-group">
        <label for="applicationId" class="col-sm-2 control-label">
            Application ID
        </label>
        <div class="col-sm-3">
            <input size="12" maxlength="12" minlength="12" type="text" class="form-control" id="applicationId" name="applicationId" value="" placeholder="Application ID" required>
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group">
        <label for="applicationID" class="col-sm-2 control-label"></label>
        <div class="col-sm-8">
            <tags:hasPermission moduleName="admin" operation="resetApplicantPassword">
                <button type="submit" class="btn btn-primary">
                    Reset Applicant Password
                </button>
            </tags:hasPermission>
        </div>
    </div>

</form>

