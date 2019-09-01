<%@ include file="../../common/taglibs.jsp"%>

<script type="text/javascript">
	$(document).ready(function() {

	});

	function selectCategory(selectedCategory) {
        time = new Date().getTime();
        var url = applyObj.appBasePath + 'applicant?operation=showSelectedPosts&time='+time;
        jQuery("#applySteps").load(url, function(){
            applyObj.markTabAsActive("postSelectionTab");
        });
    }

</script>

<style>
	.cat-selection {
		font-size: 14px;
		font-weight: bolder;
	}
</style>

<div style="text-align: center; vertical-align: middle;margin-top: 20px;">

	<a class="cat-selection" href="javascript:void(0);" onclick="javascript:selectCategory(1);"> Draught Affected Apply Here </a> OR <a class="cat-selection" href="javascript:void(0);" onclick="javascript:selectCategory(2);"> Not Draught Affected Apply Here </a>

</div>
