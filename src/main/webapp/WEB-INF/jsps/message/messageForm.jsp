<%@ include file="../common/taglibs.jsp"%>
<%@ page pageEncoding="UTF-8"%>

<script type="text/javascript">

    jQuery(document).ready(function () {

        $("#createMessageForm").validate({
        	rules: {
                
        		messageText : {
    	 			required: true,
    	 			noSpace: true
    	 		},
    	 		messageInMarathi : {
    	 			required: true,
    	 			noSpace: true
    	 		}
        
    	 	}
        });
        


        jQuery("#createMessageForm").ajaxForm({
            dataType:  'json',
            beforeSubmit:  function(){
                return true;
            },
            success:  function(result){
                var success = result.success;
                if(success){
                    administrationObj.goToTab('3');
                    return false;
                } else {
                    commonObj.showAlert("There was some error while trying to save the Message.");
                }
            }
        });
    });
    
</script>

<form name="createMessageForm" id="createMessageForm" class="form-horizontal"
      action="<c:url value='/messages?operation=saveMessage'/>" method="POST" >

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${message.id }"/>

    <div class="form-group">
        <label for="message" class="col-sm-2 control-label">
            Message
        </label>
        <div class="col-sm-10">
            <textarea rows="10" cols="20" class="form-control" id="message" name="messageText" placeholder="Title" required maxlength="1000">${ message.messageText}</textarea>
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group">
        <label for="messageInMarathi" class="col-sm-2 control-label">
            Message (Marathi)
        </label>
        <div class="col-sm-10">
            <textarea rows="10" cols="20" class="form-control" id="messageInMarathi" name="messageInMarathi" placeholder="Title (Marathi)" required maxlength="1000">${ message.messageInMarathi }</textarea>
            <div class="help-block with-errors"></div>
        </div>
    </div>

    <div class="form-group">
        <label for="active" class="col-sm-2 control-label">
            Active
        </label>
        <div>
            <div class="checkbox">
                <input type="checkbox" id="active" name="active" ${ message.active ? 'checked=checked':'' }>
                <label for="active"></label>
                <div class="help-block with-errors"></div>
            </div>
        </div>
    </div>

    <div class="pull-right">
        <tags:hasPermission moduleName="messages" operation="saveMessage">
            <button type="submit" class="btn btn-primary">
                <fmt:message key="save"/>
            </button>
        </tags:hasPermission>
        <button type="button" class="btn btn-default"onclick="javascript:administrationObj.goToTab('3');">
            <fmt:message key="cancel"/>
        </button>
    </div>

</form>

