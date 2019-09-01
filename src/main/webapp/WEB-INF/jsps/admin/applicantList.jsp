<%@ include file="../common/taglibs.jsp"%>

<script>

    function Applicant() {

        var applicantObj = this;

        this.sortApplicants = function (obj, sortBy) {

            $("#sortBy").val(sortBy);

            if ($(obj).find("i").hasClass('fa-sort-asc')) {
                $("#sortOrder").val("DESC");
            } else {
                $("#sortOrder").val("ASC");
            }

            applicantObj.goToPage(1);
        };

        this.getPaginationData = function() {

            var searchType = $("#searchType").val();

            /*switch(searchType){
                case "1":
                    return {
                        size : $("#size").val(),
                        pageNumber : $("#pageNumber").val(),
                        sortBy : $("#sortBy").val(),
                        sortOrder : $("#sortOrder").val(),
                        newPage : $("#newPage").val(),
                        searchType : $("#searchType").val(),
                        searchText : $("#searchText").val()
                    };
                    break;
                default:
                    return {
                        size : $("#size").val(),
                        pageNumber : $("#pageNumber").val(),
                        sortBy : $("#sortBy").val(),
                        sortOrder : $("#sortOrder").val(),
                        newPage : $("#newPage").val(),
                        searchType : $("#searchType").val()
                    };
                    break;
            }*/
            
            return {
            	size : $("#size").val(),
                pageNumber : $("#pageNumber").val(),
                sortBy : $("#sortBy").val(),
                sortOrder : $("#sortOrder").val(),
                newPage : $("#newPage").val(),
                searchType : $("#searchType").val(),
            	
            	name: $('form#applicantsListSearchForm').find('#name').val(),
	            applicantId : $('form#applicantsListSearchForm').find('#applicantId').val(),
	            caste : $('form#applicantsListSearchForm').find('#caste').val(),
	            differentlyAbledSelect : $('form#applicantsListSearchForm').find('#differentlyAbledSelect').val(),
	            gender : $('form#applicantsListSearchForm').find('#gender').val(),
	            paidUnpaid : $('form#applicantsListSearchForm').find('#paidUnpaid').val(),
	            onlineOffline : $('form#applicantsListSearchForm').find('#onlineOffline').val(),
	            post : $('form#applicantsListSearchForm').find('#post').val(),
	            district : $('form#applicantsListSearchForm').find('#district').val(),
	            projectAffected : $('form#applicantsListSearchForm').find('#projectAffected').val(),
	            earthQuickAffected : $('form#applicantsListSearchForm').find('#earthQuickAffected').val(),
	            exServiceMan : $('form#applicantsListSearchForm').find('#exServiceMan').val(),
	            partTimeEmployee : $('form#applicantsListSearchForm').find('#partTimeEmployee').val(),
	            sportsPerson : $('form#applicantsListSearchForm').find('#sportsPerson').val(),
	            sTEmployee : $('form#applicantsListSearchForm').find('#sTEmployee').val(),
	            mobileNumber:$('form#applicantsListSearchForm').find('#mobileNumber').val(),
	            emailId:$('form#applicantsListSearchForm').find('#emailId').val()
            };
        };

        this.goToPage = function(pageNumber) {
        	$("#pageNumber").val(pageNumber);
            $("#newPage").val(true);
            
            var obj = applicantObj.getPaginationData();

            $("#applicantListResult").load('<c:url value="/admin?operation=applicantsPostAssocList"/>', obj, function(){
				
            });
        };


    }

    var applicantObj = new Applicant();

    $(document).ready(function() {

    });
    
    function downloadApplicantPostAssocCSV() {
    	$('form#downloadApplicantPostAssocCSVForm').find('#name').val($('form#applicantsListSearchForm').find('#name').val());
    	$('form#downloadApplicantPostAssocCSVForm').find('#applicantId').val($('form#applicantsListSearchForm').find('#applicantId').val());
    	$('form#downloadApplicantPostAssocCSVForm').find('#caste').val($('form#applicantsListSearchForm').find('#caste').val());
    	$('form#downloadApplicantPostAssocCSVForm').find('#differentlyAbledSelect').val($('form#applicantsListSearchForm').find('#differentlyAbledSelect').val());
    	$('form#downloadApplicantPostAssocCSVForm').find('#gender').val($('form#applicantsListSearchForm').find('#gender').val());
    	$('form#downloadApplicantPostAssocCSVForm').find('#paidUnpaid').val($('form#applicantsListSearchForm').find('#paidUnpaid').val());
    	$('form#downloadApplicantPostAssocCSVForm').find('#onlineOffline').val($('form#applicantsListSearchForm').find('#onlineOffline').val());
    	$('form#downloadApplicantPostAssocCSVForm').find('#post').val($('form#applicantsListSearchForm').find('#post').val());
    	$('form#downloadApplicantPostAssocCSVForm').find('#district').val($('form#applicantsListSearchForm').find('#district').val());
    	$('form#downloadApplicantPostAssocCSVForm').find('#projectAffected').val($('form#applicantsListSearchForm').find('#projectAffected').val());
    	$('form#downloadApplicantPostAssocCSVForm').find('#earthQuickAffected').val($('form#applicantsListSearchForm').find('#earthQuickAffected').val());
    	$('form#downloadApplicantPostAssocCSVForm').find('#exServiceMan').val($('form#applicantsListSearchForm').find('#exServiceMan').val());
    	$('form#downloadApplicantPostAssocCSVForm').find('#partTimeEmployee').val($('form#applicantsListSearchForm').find('#partTimeEmployee').val());
    	$('form#downloadApplicantPostAssocCSVForm').find('#sportsPerson').val($('form#applicantsListSearchForm').find('#sportsPerson').val());
    	$('form#downloadApplicantPostAssocCSVForm').find('#sTEmployee').val($('form#applicantsListSearchForm').find('#sTEmployee').val());
    	$('form#downloadApplicantPostAssocCSVForm').find('#mobileNumber').val($('form#applicantsListSearchForm').find('#mobileNumber').val());
    	$('form#downloadApplicantPostAssocCSVForm').find('#emailId').val($('form#applicantsListSearchForm').find('#emailId').val());
    	
    	$('form#downloadApplicantPostAssocCSVForm').submit();
    }

</script>
    <h4><fmt:message key="applicant.list.title"/></h4>
	<jsp:include page="applicantListSearch.jsp"/>
	<c:if test="${ !hideApplicantsList }">
		<div class="row">
	        <div class="col-lg-12">
	            <div id="applicantListResult">
	                <jsp:include page="applicantListResult.jsp"/>
	            </div>
	        </div>
	    </div>
		<c:if test="${ pageData.numberOfElements ne 0 }">
		    <div class="row">
		        <div class="pull-right">
		            <label class="control-labe">Also available in: </label>
		            <a href="javascript:void(0);" onclick="javascript:downloadApplicantPostAssocCSV();">CSV</a>
		        </div>
		    </div>
	    </c:if>
	</c:if>
	<form name="downloadApplicantPostAssocCSVForm" id="downloadApplicantPostAssocCSVForm"  action="<c:url value='/admin?operation=downloadApplicantPostAssocCSV'/>" method="POST" novalidate >
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<input id="pageNumber" type="hidden" name="pageNumber" value="1"/>
		<input id="searchType" type="hidden" name="searchType" value="${searchType}"/>
		<input id="menu" type="hidden" name="menu" value="applicantsList"/>
		
		<input value="${applicantSearchDTO.name}" type="hidden" id="name" name="name">
		<input value="${applicantSearchDTO.applicantId}" type="hidden" id="applicantId" name="applicantId">
		<input value="${applicantSearchDTO.caste}" type="hidden" id="caste" name="caste">
		<input value="${applicantSearchDTO.differentlyAbledSelect}" type="hidden" id="differentlyAbledSelect" name="differentlyAbledSelect">
		<input value="${applicantSearchDTO.gender}" type="hidden" id="gender" name="gender">
		<input value="${applicantSearchDTO.paidUnpaid}" type="hidden" id="paidUnpaid" name="paidUnpaid">
		<input value="${applicantSearchDTO.onlineOffline}" type="hidden" id="onlineOffline" name="onlineOffline">
		<input value="${applicantSearchDTO.post}" type="hidden" id="post" name="post">
		<input value="${applicantSearchDTO.district}" type="hidden" id="district" name="district">
		<input value="${applicantSearchDTO.projectAffected}" type="hidden" id="projectAffected" name="projectAffected">
		<input value="${applicantSearchDTO.earthQuickAffected}" type="hidden" id="earthQuickAffected" name="earthQuickAffected">
		<input value="${applicantSearchDTO.exServiceMan}" type="hidden" id="exServiceMan" name="exServiceMan">
		<input value="${applicantSearchDTO.partTimeEmployee}" type="hidden" id="partTimeEmployee" name="partTimeEmployee">
		<input value="${applicantSearchDTO.sportsPerson}" type="hidden" id="sportsPerson" name="sportsPerson">
		<input value="${applicantSearchDTO.sTEmployee}" type="hidden" id="sTEmployee" name="sTEmployee">
		<input value="${applicantSearchDTO.mobileNumber}" type="hidden" id="mobileNumber" name="mobileNumber">
		<input value="${applicantSearchDTO.emailId}" type="hidden" id="emailId" name="emailId">
	</form>