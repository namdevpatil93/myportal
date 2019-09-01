<%@ include file="../../../common/taglibs.jsp"%>

<div class="modal fade" id="projectAffectedModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> -->
                <h4 class="modal-title" id="myModalLabel"><fmt:message key="parallelReservation.title"/></h4>
            </div>
            <div class="modal-body container-fluid">
            	<%-- <div class="row">
            		<div class="col-sm-12">
            			<fmt:message key="parallelReservation.forWomen"/>
            		</div>
            	</div> --%>
            	<div class="row">
            		<div class="col-sm-12">
						<fmt:message key="parallelReservation.projectAffected"/>
					</div>
            	</div>
            	<br>
            	 <%-- <div class="row">
            		<div class="col-sm-12">
						<fmt:message key="parallelReservation.note"/>
					</div>
            	</div> --%>
            </div>
          
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><fmt:message key="popup.agree"/></button>
                <button type="button" class="btn btn-default" data-dismiss="modal" onclick="selectNoAsOption('1')"><fmt:message key="popup.disagree"/></button>
            </div>
        </div>
	</div>
</div>
