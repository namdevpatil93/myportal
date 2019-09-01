<%@ include file="../common/taglibs.jsp"%>
<%@ page pageEncoding="UTF-8"%>

<script>

    function DocumentSubCategory() {

        var subCategoryObj = this;
     
        this.addNewDocument= function () {
            var url = "<c:url value='/documents?operation=newSubCategory'/>" ;
            jQuery(".tab-content").load(url, function(){

            });
        };
        
        this.editDocument= function (documentId) {
            var url = "<c:url value='/documents?operation=editSubCategory'/>" + "&id="+ documentId;
            jQuery(".tab-content").load(url, function(){

            });
        };
        
        this.deletesubCategory= function (documentSubCategoryId) {
        	time = new Date().getTime();
            commonObj.showConfirmation('Are you sure you want to Delete the Category?', function (result) {
                if (result) {
                	var url = "<c:url value='/documents?operation=deleteDocumentSubCategory'/>"+"&id="+documentSubCategoryId ;
                    url = url+"&time="+time;
                    $.post(url, function (result) {
                        var success = result.success;
                        var documentExists=result.documentExists;
                        if(documentExists==false){
                        	 commonObj.showAlert("Cant delete SubCategory !! Document Exists for this SubCategory.");
                        }
                        else if (success) {
                            administrationObj.goToTab("6");
                        } else {
                            commonObj.showAlert("There was some error while trying to delete the category.");
                        }
                    });
                }
            } , '<fmt:message key="yes"/>', '<fmt:message key="no"/>','<fmt:message key="confirmationMessage.title"/>');
            
        };
        
        this.changeStatus= function (subCategoryId, active) {
            var url = "<c:url value='/documents?operation=changeSubCategoryStatus'/>";

            if(active == true || active == 'true'){
                active = false
            } else {
                active = true;
            }

            $.ajax({
                type: "POST",
                url: url,
                data: { subCategoryId: subCategoryId, active : active },
                success: function(){
                	 url = '<c:url value="/documents?operation=subCategoryList"/>';
                	 jQuery(".tab-content").load(url, function() {
                	 });
                	 
                },
                dataType: 'json'
            });
        };
        
       /*  this.fetchCategoryType=function(){
       	 var documentType = $("#documentType").val();
       	 alert("this is document type"+documentType);
       	 var url = "<c:url value='/documents?operation=newSubCategory'/>";
            jQuery(".tab-content").load(url, function(){

            });
       }; */ 

        this.sortDocuments= function (obj, sortBy) {
    	  
            $("#sortBy").val(sortBy);
         
          if ($(obj).find("i").hasClass('fa-sort-asc')) {
                $("#sortOrder").val("DESC");
            } else {
                $("#sortOrder").val("ASC");
            }

          subCategoryObj.goToPage(1);
        };

        this.getPaginationData = function() {

            var searchType = $("#searchType").val();

            switch(searchType){
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
            var documentType = $("#documentType").val();
            var url = '<c:url value="/documents?operation=subCategoryList"/>' ;
            jQuery("#subCategoryListResult").load(url , subCategoryObj.getPaginationData(), function(){

            });
        };
        
    }

    var subCategoryObj = new DocumentSubCategory();

</script>

<div class="row">
    <div class="col-sm-12 text-right">
        <tags:hasPermission moduleName="documents" operation="newSubCategory">
            <input class="btn btn-primary" type="button" value="<fmt:message key='add'/>"
                   onclick="javascript:subCategoryObj.addNewDocument();">
        </tags:hasPermission>
    </div>
</div>
<br>

<%--
<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title"><fmt:message key="document.list"/></h3>
    </div>
    <div class="panel-body">
--%>
        <c:choose>
            <c:when test="${ fn:length(page.content)  gt 0}">
                <div id="subCategoryListResult">
                    <jsp:include page="subCategoryListResult.jsp"/>
                </div>
            </c:when>
            <c:otherwise>
                <em>There are no records to display.</em>
            </c:otherwise>
        </c:choose>
<%--
    </div>
</div>
--%>




