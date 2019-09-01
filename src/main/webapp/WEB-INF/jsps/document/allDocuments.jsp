<%@ include file="../common/taglibs.jsp"%>
<%@ page pageEncoding="UTF-8"%>

<script>

    function Documents(){

    	var time=0;
        this.viewDocuments = function(documentType){
        	time = new Date().getTime();
            var url = '<c:url value="/documents?operation=documentList&documentType="/>' + documentType;
            url = url+"&time="+time;
            $("#documentType").val(documentType);

            jQuery(".tab-content").load(url, function(){
                for(var i = 1; i <= 7; i++){
                    if(i !== documentType){
                        $("#tabLi" + i).removeClass("active");
                        $("#tab" + i).removeClass("active");
                    }
                }
                $("#tabLi" + documentType).addClass("active");
                $("#tab" + documentType).addClass("active");
                $("#documentType").val(documentType);
            });
        }
        
        this.viewAdvertisement = function(documentType){
        	time = new Date().getTime();
            var url = '<c:url value="/advertisement?operation=advertisementList"/>';
            url = url+"&time="+time;
            $("#documentType").val(documentType);

            jQuery(".tab-content").load(url, function() {
                for(var i = 1; i <= 7; i++) {
                    if(i !== documentType) {
                        $("#tabLi" + i).removeClass("active");
                        $("#tab" + i).removeClass("active");
                    }
                }
                $("#tabLi" + documentType).addClass("active");
                $("#tab" + documentType).addClass("active");
                $("#documentType").val(documentType);
            });
        }
        
        this.deleteAdvertisement = function(advertisementId, documentType) {
        	time = new Date().getTime();
        	commonObj.showConfirmation('<fmt:message key="advertisement.confirmDelete"/>', function (result) {
                if (result) {
                    var url = "<c:url value='/advertisement?operation=deleteAdvertisement&menu=advertisementListMenuOption'/>&id=" + advertisementId;
                    url = url+"&time="+time;
                    $.post(url, {id: advertisementId,documentType: documentType}, function (result) {
                        var success = result.success;
                        if (success) {
                        	documentsObj.viewAdvertisement(result.documentType);
                        } else {
                            commonObj.showAlert("There was some error while trying to delete the Advertisement.");
                        }
                    });
                }
            } , '<fmt:message key="yes"/>', '<fmt:message key="no"/>','<fmt:message key="confirmationMessage.title"/>');
        }
        
        this.deleteDocument = function(documentId, documentType) {
        	time = new Date().getTime();
        	commonObj.showConfirmation('<fmt:message key="confirmDeletePost"/>', function (result) {
                if (result) {
                    var url = "<c:url value='/documents?operation=deleteDocument'/>"+ "&id="+ documentId;
                    url = url+"&time="+time;
                    $.post(url, {documentId: documentId,documentType: documentType}, function (result) {
                        var success = result.success;
                        if (success) {
                        	documentsObj.viewDocuments(result.documentType);
                        } else {
                            commonObj.showAlert("There was some error while trying to delete the Applicant's Post.");
                        }
                    });
                }
            } , '<fmt:message key="yes"/>', '<fmt:message key="no"/>','<fmt:message key="confirmationMessage.title"/>');
        }
    }

    var documentsObj = new Documents();

    $(document).ready(function() {
        documentsObj.viewDocuments('1');
        $("#documentType").val(1);
    });

</script>

<input type="hidden" id="documentType" name="documentType" value=""/>

<div class="container">
    <div class="custom-panel">
        <ul class="nav nav-pills nav-stacked">
            <li id="tabLi1"><a href="javascript:void(0);" onclick="javascript:documentsObj.viewDocuments('1');">Recruitment Fee</a></li>
            <li id="tabLi2"><a href="javascript:void(0);" onclick="javascript:documentsObj.viewDocuments('2');">Information</a></li>
            <li id="tabLi3"><a href="javascript:void(0);" onclick="javascript:documentsObj.viewDocuments('3');">Instructions</a></li>
            <li id="tabLi4"><a href="javascript:void(0);" onclick="javascript:documentsObj.viewDocuments('4');">Timetable</a></li>
            <li id="tabLi5"><a href="javascript:void(0);" onclick="javascript:documentsObj.viewDocuments('5');">Result</a></li>
            <li id="tabLi6"><a href="javascript:void(0);" onclick="javascript:documentsObj.viewDocuments('6');">Announcements</a></li>
            <li id="tabLi7"><a href="javascript:void(0);" onclick="javascript:documentsObj.viewAdvertisement('7');">Advertisements</a></li>
        </ul>
        <div class="tab-content">
            <div class="tab-pane active" id="tab1"></div>
            <div class="tab-pane" id="tab2"></div>
            <div class="tab-pane" id="tab3"></div>
            <div class="tab-pane" id="tab4"></div>
            <div class="tab-pane" id="tab5"></div>
            <div class="tab-pane" id="tab6"></div>
            <div class="tab-pane" id="tab7"></div>
        </div>
    </div>
</div>
<br>
<br>
<br>
