<%@ include file="../common/taglibs.jsp"%>
<%@ page pageEncoding="UTF-8"%>

<script>

    function Administration(){

        this.goToTab = function(tabNo){
            time = new Date().getTime();
            var url = '<c:url value="/qualifications?operation=qualificationList"/>';

            switch(tabNo){
                case "1":
                    url = '<c:url value="/qualifications?operation=qualificationList"/>';
                    break;
                case "2":
                    url = '<c:url value="/systemSettings?operation=viewSystemSettings"/>';
                    break;
                case "3":
                    url = '<c:url value="/messages?operation=messageList"/>';
                    break;
                case "4":
                    url = '<c:url value="/admin?operation=showResetApplicantPassword"/>';
                    break;
                case "5":
                    url = '<c:url value="/documents?operation=categoryList"/>';
                    break;
                case "6":
                    url = '<c:url value="/documents?operation=subCategoryList"/>';
                    break;
                case "7":
                    url = '<c:url value="/admin?operation=showPostSettings"/>';
                    break;
                default:
                    url = '<c:url value="/qualifications?operation=qualificationList"/>';
            }

            url = url+"&time="+time;

            jQuery(".tab-content").load(url, function(){
                for(var i = 1; i <= 7; i++){
                    if(i !== tabNo){
                        $("#tabLi" + i).removeClass("active");
                        $("#tab" + i).removeClass("active");
                    }
                }
                $("#tabLi" + tabNo).addClass("active");
                $("#tab" + tabNo).addClass("active");
            });
        }
    }

    var administrationObj = new Administration();

    $(document).ready(function() {
        administrationObj.goToTab('1');
    });

</script>

<div class="container">
    <div class="custom-panel">
        <ul class="nav nav-pills nav-stacked">
            <tags:hasPermission moduleName="qualifications" operation="qualificationList">
                <li id="tabLi1"><a href="javascript:void(0);" onclick="javascript:administrationObj.goToTab('1');">Qualifications</a></li>
            </tags:hasPermission>
            <tags:hasPermission moduleName="systemSettings" operation="viewSystemSettings">
                <li id="tabLi2"><a href="javascript:void(0);" onclick="javascript:administrationObj.goToTab('2');">System Settings</a></li>
            </tags:hasPermission>
            <tags:hasPermission moduleName="messages" operation="messageList">
                <li id="tabLi3"><a href="javascript:void(0);" onclick="javascript:administrationObj.goToTab('3');">Messages</a></li>
            </tags:hasPermission>
            <tags:hasPermission moduleName="admin" operation="showResetApplicantPassword">
                <li id="tabLi4"><a href="javascript:void(0);" onclick="javascript:administrationObj.goToTab('4');">Reset Applicant Password</a></li>
            </tags:hasPermission>
             <tags:hasPermission moduleName="documents" operation="categoryList">
                <li id="tabLi5"><a href="javascript:void(0);" onclick="javascript:administrationObj.goToTab('5');">Category</a></li>
            </tags:hasPermission>
            <tags:hasPermission moduleName="documents" operation="subCategoryList">
                <li id="tabLi6"><a href="javascript:void(0);" onclick="javascript:administrationObj.goToTab('6');">Sub Category</a></li>
            </tags:hasPermission>
            <tags:hasPermission moduleName="admin" operation="showPostSettings">
                <li id="tabLi7"><a href="javascript:void(0);" onclick="javascript:administrationObj.goToTab('7');">Post Settings</a></li>
            </tags:hasPermission>
        </ul>
        <div class="tab-content">
            <tags:hasPermission moduleName="qualifications" operation="qualificationList">
                <div class="tab-pane active" id="tab1"></div>
            </tags:hasPermission>
            <tags:hasPermission moduleName="systemSettings" operation="viewSystemSettings">
                <div class="tab-pane" id="tab2"></div>
            </tags:hasPermission>
            <tags:hasPermission moduleName="messages" operation="messageList">
                <div class="tab-pane" id="tab3"></div>
            </tags:hasPermission>
            <tags:hasPermission moduleName="admin" operation="showResetApplicantPassword">
                <div class="tab-pane" id="tab4"></div>
            </tags:hasPermission>
            <tags:hasPermission moduleName="documents" operation="categoryList">
                <div class="tab-pane" id="tab5"></div>
            </tags:hasPermission>
             <tags:hasPermission moduleName="documents" operation="subCategoryList">
                <div class="tab-pane" id="tab6"></div>
            </tags:hasPermission>
            <tags:hasPermission moduleName="admin" operation="showPostSettings">
                <div class="tab-pane" id="tab7"></div>
            </tags:hasPermission>
        </div>
    </div>
</div>
<br>
