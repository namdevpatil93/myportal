<%@ include file="../common/taglibs.jsp"%>
<%@ page pageEncoding="UTF-8"%>


<script type="text/javascript">


    jQuery(document).ready(function () {

        $("#createSubCategoryForm").validate( {
           rules: {
               
        	   subCategoryTitle : {
                    required: true,
                    noSpace: true
                },
                subCategoryTitleMarathi : {
                    required: true,
                    noSpace: true
                }
       
            }
       } );

        jQuery("#createSubCategoryForm").ajaxForm({
        	
            dataType:  'json',
            beforeSubmit:  function(){
                return true;
            },
            success:  function(result){
                var success = result.success;
                var exist=result.documentSubCategoryexists;
                if(exist==true){
                	 commonObj.showAlert("Cant save sub category!! This sub category exists");
                }
                else if(success){
                    administrationObj.goToTab('6');
                    return false;
                } else {
                	administrationObj.goToTab('6');
                    commonObj.showAlert("There was some error while trying to save the category.");
                }
            }
        });
    });
    
    
    function formSubmit() {
		$('form#createSubCategoryForm').submit();
	}
	
	function formReset() {
		//advanceHide();
		$('form').find('input[type=text], select').val('');
		$('form').find('.selectpicker').val('0').selectpicker('refresh');
		//$('form#applicantsListSearchForm').find('input[type=radio]').attr('checked', false);
	}
	
	  function fetch(){
		var id=$("#documentType").val();
		 var url = "<c:url value='/documents?operation=documentSubCategoryfetch'/>" + "&id="+ id;
        $.ajax({
            type: "POST",
            url: url,
            data: { id: id },
            success: function(data){
                 $('#CategoryType').empty();
                 $('#CategoryType').append('<option value="0">-- <fmt:message key="please.select"/> --</option>');
                 for (i in data ) {
                     $('#CategoryType').append('<option value="'+ data[i].id + '">' + data[i].categoryTitle +'</option>');
                 }	
            },
            dataType: 'json'  
        }); 
			
	 } 
	
</script>


<form name="createSubCategoryForm" id="createSubCategoryForm" class="form-horizontal"
      action="<c:url value='/documents?operation=saveSubCategory'/>" method="POST" >

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="${DocumentSubCategory.id }"/>
    <input type="hidden" id="subCategorytype" name="subCategorytype" value="${ subCategorytype }" />
    
 <div class="form-group">
 <label for="documentType" class="col-sm-4 control-label">
            <fmt:message key="category.subcategoryDocumentType"/>
        </label>
	  <div class="col-md-3">
	  	<select id="documentType" name="documentType" class="form-control"  onchange="fetch();"  required >
            <option value="0">-- <fmt:message key="please.select"/> --</option>
           
             <c:forEach items="${document}" var="document">
                <option value="${document.documentId}" ${ document.documentId eq DocumentSubCategory.documentType? 'selected=selected':'' }>${document.getDocumentTypeById(document.documentId) } </option>
            </c:forEach> 
        </select>
	  </div>
</div>
<div class="form-group">
<label for="categoryType" class="col-sm-4 control-label">
            <fmt:message key="category.subcategoryType"/>
        </label>   
	  <div class="col-md-3">
	  	<select id="CategoryType" name="CategoryType" class="form-control"  required >
	  <%-- <c:if test="${empty categorytype }"> --%>
            <option value="0">-- <fmt:message key="please.select"/>--</option>
            <c:forEach var="categoryType" items="${categorytype }">
            <option value="${categoryType.id }" ${categoryType.id eq DocumentSubCategory.categoryType? 'selected=selected':''}>${categoryType.getCategoryTitle()}</option>
            </c:forEach> 
        </select>
	  </div>
</div>
	  <div class="form-group">
	  <label for="subcategoryTitle" class="col-sm-4 control-label">
            <fmt:message key="category.subcategoryTitle"/>
        </label>	  
		<div class="col-md-3">
	  	<input value="${DocumentSubCategory.subCategoryTitle}" type="text" class="form-control" id="subCategoryTitle" placeholder="" name="subCategoryTitle"  required maxlength="200">
	  	</div>
	  </div>	  
	  <div class="form-group">
	  <label for="subcategoryTitleMarathi" class="col-sm-4 control-label">
            <fmt:message key="category.subcategoryTitleMarathi"/>
        </label>	  
		<div class="col-md-3">
	  	<input value="${DocumentSubCategory.subCategoryTitleMarathi}" type="text" class="form-control" id="subCategoryTitleMarathi" placeholder="" name="subCategoryTitleMarathi"  required maxlength="200">
	  	</div>
	  </div>
	  	  <div class="form-group">
        <label for="active" class="col-sm-4 control-label">
            <fmt:message key="document.active"/>
        </label>
        <div>
            <div class="checkbox" style="margin-left:35%" >
                <input type="checkbox" id="active" name="active" ${ DocumentSubCategory.active ? 'checked=checked':'' }>
                <label for="active"></label>
                <div class="help-block with-errors"></div>
            </div>
        </div>
    </div>
    <div class="pull-right">
        <tags:hasPermission moduleName="documents" operation="saveSubCategory">
            <button type="submit" class="btn btn-primary">
                <fmt:message key="save"/>
            </button>
        </tags:hasPermission>
        <button type="button" class="btn btn-default"onclick="javascript:administrationObj.goToTab('6');">
            <fmt:message key="cancel"/>
        </button>
    </div>

</form>

