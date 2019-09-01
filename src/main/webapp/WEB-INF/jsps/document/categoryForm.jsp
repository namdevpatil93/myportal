<%@ include file="../common/taglibs.jsp"%>
<%@ page pageEncoding="UTF-8"%>
<%@page import="com.sts.springbootsecurity.document.domain.DocumentEnum"%>

<script type="text/javascript">

    jQuery(document).ready(function () {

        $("#createCategoryForm").validate({
            rules: {
                
            	categoryTitle : {
                    required: true,
                    noSpace: true
                },
                categoryTitleMarathi : {
                    required: true,
                    noSpace: true
                }
       
            }
       });
       

        jQuery("#createCategoryForm").ajaxForm({
            dataType:  'json',
            beforeSubmit:  function(){
                return true;
            },
            success:  function(result){
                var success = result.success;
                var exist=result.documentCategoryexists;
                if(exist==true){
                	 commonObj.showAlert("Cant save!!Category Title/Category Title In Marathi exist .");
                }
                else if(success){
                    administrationObj.goToTab('5');
                    return false;
                } else {
                	administrationObj.goToTab('5');
                    commonObj.showAlert("There was some error while trying to save the category.");
                }
            }
        });
    });
    /* if(createCategoryForm.document_type!=""){
    	advanceHide();
    	
    }
    function advanceHide() {
		
	   
	    $('form').find('.selectpicker').val('').selectpicker('refresh');
	} */
    
    function formSubmit() {
		$('form#createCategoryForm').submit();
	}
	
	function formReset() {
		//advanceHide();
		$('form').find('input[type=text], select').val('');
		$('form').find('.selectpicker').val('').selectpicker('refresh');
		//$('form#applicantsListSearchForm').find('input[type=radio]').attr('checked', false);
	}
	
</script>


<form name="createCategoryForm" id="createCategoryForm" class="form-horizontal"
      action="<c:url value='/documents?operation=saveCategory'/>" method="POST" >

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${DocumentCategory.id }"/>
    <input type="hidden" id="categorytype" name="categorytype" value="${ categorytype }" />
 <div class="form-group row">
  <label for="categoryType" class="col-sm-3 control-label">
            <fmt:message key="category.categoryType"/>
        </label>
	  <div class="col-sm-3">
	  	<select id="categorytype" name="documentType" class="form-control"  required >
            <option value="">-- <fmt:message key="please.select"/> --</option>
           
             <c:forEach items="${document}" var="document">
                <option value="${document.documentId}" ${ document.documentId eq DocumentCategory.documentType? 'selected=selected':'' }>${document.getDocumentTypeById(document.documentId) } </option>
            </c:forEach> 
        </select>
	  </div>
</div>
    <div class="form-group row">
     <label for="categoryTitle" class="col-sm-3 control-label">
            <fmt:message key="category.categoryTitle"/>
        </label>
	 	
	  	<div class="col-sm-3">
	  	<input value="${DocumentCategory.categoryTitle}" type="text" class="form-control" id="categoryTitle" placeholder="" name="categoryTitle"  required noSpace maxlength="200">
	  	</div>
	 </div>
	  
	  <div class="form-group row">
	  	 <label for="categoryTitleMarathi" class="col-sm-3 control-label">
            <fmt:message key="category.categoryTitleMarathi"/>
        </label>
  		<div class="col-sm-3">
	  	<input value="${DocumentCategory.categoryTitleMarathi}" type="text" class="form-control" id="categoryTitleMarathi" placeholder="" name="categoryTitleMarathi"  required noSpace maxlength="200">
	  	</div>
	  </div>
	  
	  <div class="form-group">
        <label for="active" class="col-sm-3 control-label">
            <fmt:message key="document.active"/>
        </label>
        <!--  Change Code -->
        <div>
            <div style="margin-left:26.7%" class="checkbox">
                <input type="checkbox" id="active" name="active" ${ DocumentCategory.active ? 'checked=checked':'' }>
                <label for="active"></label>
                <div class="help-block with-errors"></div>
            </div>
        </div>
    </div>
    <div class="pull-right">
        <tags:hasPermission moduleName="documents" operation="saveCategory">
            <button type="submit" class="btn btn-primary">
                <fmt:message key="save"/>
            </button>
        </tags:hasPermission>
        <button type="button" class="btn btn-default"onclick="javascript:administrationObj.goToTab('5');">
            <fmt:message key="cancel"/>
        </button>
    </div>

</form>

