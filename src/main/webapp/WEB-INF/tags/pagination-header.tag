<%@ include file="../jsps/common/taglibs.jsp" %>

<%@ attribute name="page" type="org.springframework.data.domain.Page" required="true" rtexprvalue="true" description="The Current Page" %>
<%@ attribute name="searchText" required="false" rtexprvalue="true" %>

<script>

    $(document).ready(function() {
        $("#search_basic_search_text").keyup(function(event){
            if(event.keyCode == 13){
                $("#basicSearchBtn").click();
            }
        });
    });

    function basicSearch(searchText){
        $("#searchType").val(1);
        $("#searchText").val($("#search_basic_search_text").val());
        paginationObj.goToPage(1);
    }

    function changePageSize(newPageSize){
        $("#size").val(newPageSize);
        paginationObj.goToPage(1);
    }

    function refresh(){
        $("#searchType").val(0);
        $("#searchText").val("");
        paginationObj.goToPage(1);
    }

</script>

<div id="grid-command-buttons-header" class="pagination-header container-fluid">
    <div class="row">
        <div class="col-sm-12 actionBar">
            <div class="search form-group">
                <div class="input-group">
                    <input type="text" id="search_basic_search_text" value="${searchText}" class="search-field form-control" placeholder="Search" >
                    <span class="icon fa input-group-addon fa-search" data-toggle="tooltip" title="Search" onclick="javascript:basicSearch();" id="basicSearchBtn"></span>
                </div>
            </div>
            <%--<div class="actions btn-group">
                <div class="dropdown btn-group">
                    <button class="btn btn-default" type="button" title="Refresh" onclick="javascript:refresh();"><span class="icon fa fa-refresh"></span></button>
                    <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">
                        <span class="dropdown-text">

                            <c:choose>
                                <c:when test="${page.size eq '10'}">10</c:when>
                                <c:when test="${page.size eq '25'}">25</c:when>
                                <c:when test="${page.size eq '50'}">50</c:when>
                                <c:otherwise>All</c:otherwise>
                            </c:choose>

                        </span> <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu pull-right" role="menu">
                        <li class="${page.size eq '10' ? 'active':''}" aria-selected="${page.size eq '10'}">
                            <a data-action="10" class="dropdown-item dropdown-item-button" onclick="javascript:changePageSize(10);">10</a>
                        </li>
                        <li class="${page.size eq '25' ? 'active':''}" aria-selected="${page.size eq '25'}">
                            <a data-action="25" class="dropdown-item dropdown-item-button" onclick="javascript:changePageSize(25);">25</a>
                        </li>
                        <li class="${page.size eq '50' ? 'active':''}" aria-selected="${page.size eq '50'}">
                            <a data-action="50" class="dropdown-item dropdown-item-button" onclick="javascript:changePageSize(50);">50</a>
                        </li>
                        <li class="${page.size eq page.totalElements ? 'active':''}" aria-selected="${page.size eq page.totalElements}">
                            <a data-action="-1" class="dropdown-item dropdown-item-button" onclick="javascript:changePageSize(${page.totalElements});">All</a>
                        </li>
                    </ul>
                </div>
            </div>--%>
        </div>
    </div>
</div>
