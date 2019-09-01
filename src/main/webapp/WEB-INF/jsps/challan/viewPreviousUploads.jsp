<%@ include file="../common/taglibs.jsp"%>

<script>

    $(document).ready(function() {
        viewRecords();
    });

    function viewRecords(){
        var url = '<c:url value="/challan?operation=challanList"/>';
        jQuery("#recordsTab").load(url, function(){
            $("#recordsTabLi").addClass("active");
            $("#uploadedFilesTabLi").removeClass("active");
        });
    }

    function challanFileList(){
        var url = '<c:url value="/challan?operation=challanFileList"/>';
        jQuery("#recordsTab").load(url, function(){
            $("#recordsTabLi").removeClass("active");
            $("#uploadedFilesTabLi").addClass("active");
        });
    }
</script>

<div class="container">
    <div class="custom-panel">
        <ul class="nav nav-pills nav-stacked">
            <li id="recordsTabLi"><a href="javascript:void(0);" onclick="javascript:viewRecords();">Records</a></li>
            <li id="uploadedFilesTabLi"><a href="javascript:void(0);" onclick="javascript:challanFileList();">Uploaded Files</a></li>
        </ul>
        <div class="tab-content">
            <div class="tab-pane active" id="recordsTab"></div>
            <div class="tab-pane" id="uploadedFilesTab"></div>
        </div>
    </div>
</div>
<br>
<br>
<br>
