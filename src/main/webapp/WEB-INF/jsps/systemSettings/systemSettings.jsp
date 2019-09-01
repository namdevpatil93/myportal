<%@ include file="../common/taglibs.jsp"%>
<%@ page pageEncoding="UTF-8"%>

<script>

    function saveSystemSetting(systemSettingId){
        var value = $("#systemSetting_" + systemSettingId).val();

        if(value == null || value.trim() == ''){
            commonObj.showAlert("Please enter system setting value.");
            administrationObj.goToTab("2");
            return;
        }

        time = new Date().getTime();
        commonObj.showConfirmation('Are you sure you want to update the System setting?', function (result) {
            if (result) {
                var url = "<c:url value='/systemSettings?operation=saveSystemSetting'/>";
                url = url+"&time="+time;

                $.post(url, {id : systemSettingId, value : value }, function (result) {
                    var success = result.success;
                    if (success) {
                        commonObj.showAlert("The system setting value has been updated successfully.");
                        administrationObj.goToTab("2");
                    } else {
                        commonObj.showAlert("There was some error while trying to save the system settings.");
                    }
                });
            } else {
                administrationObj.goToTab("2");
            }
        } , '<fmt:message key="yes"/>', '<fmt:message key="no"/>','<fmt:message key="confirmationMessage.title"/>');

    }

    jQuery(document).ready(function() {

    });

</script>

<c:forEach items="${ systemSettingList }" var="systemSetting">

    <div class="form-group">
        <label class="col-sm-6 control-label">
            ${ systemSetting.description }
        </label>
        <div class="col-sm-5">
            <input type="text" id="systemSetting_${ systemSetting.id }" class="form-control" value="${ systemSetting.value }" required>
            <div class="help-block with-errors"></div>
        </div>
        <div class="col-sm-1">
            <button type="button" class="btn btn-xs btn-default command-edit"
                    onclick="javascript:saveSystemSetting('${systemSetting.id}');">
                <span class="fa fa-save fa-2x"></span>
            </button>
        </div>
    </div>

</c:forEach>

