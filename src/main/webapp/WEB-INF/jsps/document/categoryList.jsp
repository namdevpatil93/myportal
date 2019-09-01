<%@ include file="../common/taglibs.jsp" %>
<%@page pageEncoding="UTF-8"%>
<script>

function DocumentCategory() {

    var categoryObj = this;

    this.addNewCategory= function () {
        var categorytype = $("#categorytype").val();
        var url = "<c:url value='/documents?operation=newCategory'/>" ;
        jQuery(".tab-content").load(url, function(){

        });
    };

    
    this.editCategory= function (documentId) {
      //  var categorytype = $("#categorytype").val();
        var url = "<c:url value='/documents?operation=editCategory'/>" + "&id="+ documentId ;
        jQuery(".tab-content").load(url, function(){

        });
    };

    this.deleteDocumentCategory= function (documentCategoryId,documentType) {
    	time = new Date().getTime();
        commonObj.showConfirmation('Are you sure you want to Delete the Category?', function (result) {
            if (result) {
            	var url = "<c:url value='/documents?operation=deleteDocumentCategory'/>"+"&id="+documentCategoryId+"&documentType=" + documentType ;
                url = url+"&time="+time;
                $.post(url, function (result) {
                    var success = result.success;
                    var categoryExists=result.categoryExists;
                    var documentExists=result.documentExists;
                    if(categoryExists==false ){
                   	 commonObj.showAlert("Cant delete Category as subCategory exist for this Category");
                   }
                    else if(documentExists==false){
                    	commonObj.showAlert("Cant delete Category as Document exists for this Category");
                    }
                    else  if (success) {
                        administrationObj.goToTab("5");
                    } else {
                        commonObj.showAlert("There was some error while trying to delete the category.");
                    }
                });
            }
        } , '<fmt:message key="yes"/>', '<fmt:message key="no"/>','<fmt:message key="confirmationMessage.title"/>');
        
    };

    this.sortDocuments= function (obj, sortBy) {

        $("#sortBy").val(sortBy);

        if ($(obj).find("i").hasClass('fa-sort-asc')) {
            $("#sortOrder").val("DESC");
        } else {
            $("#sortOrder").val("ASC");
        }

        categoryObj.goToPage(1);
    };

    this.getPaginationData = function() {

        var categorytype = $("#categorytype").val();

        switch(categorytype){
            case "1":
                return {
                    size : $("#size").val(),
                    pageNumber : $("#pageNumber").val(),
                    sortBy : $("#sortBy").val(),
                    sortOrder : $("#sortOrder").val(),
                    newPage : $("#newPage").val(),
                   
                    
                };
                break;
            default:
                return {
                    size : $("#size").val(),
                    pageNumber : $("#pageNumber").val(),
                    sortBy : $("#sortBy").val(),
                    sortOrder : $("#sortOrder").val(),
                    newPage : $("#newPage").val(),
                   
                };
                break;
        }
    };

    this.goToPage = function(pageNumber) {
        $("#pageNumber").val(pageNumber);
        $("#newPage").val(true);
        var categorytype = $("#categorytype").val();
        var url = '<c:url value="/documents?operation=categoryList"/>&categorytype=' + categorytype;
        jQuery("#categoryListResult").load(url , categoryObj.getPaginationData(), function(){

        });
    };
    
}
 var categoryObj = new DocumentCategory();
 </script>


<%--<tags:pagination-header page="${ page }" searchText="${documentSearchDTO.searchText}"/>--%>
<div class="row">
    <div class="col-sm-12 text-right">
        <tags:hasPermission moduleName="documents" operation="newCategory">
            <input class="btn btn-primary" type="button" value="<fmt:message key='add'/>"
                   onclick="javascript:categoryObj.addNewCategory();">
        </tags:hasPermission>
    </div>
</div>
<br>
 <c:choose>
            <c:when test="${ fn:length(page.content)  gt 0}">
                <div id="categoryListResult">
                    <jsp:include page="categoryListResult.jsp"/>
                </div>
            </c:when>
            <c:otherwise>
                <em>There are no records to display.</em>
            </c:otherwise>
        </c:choose>

