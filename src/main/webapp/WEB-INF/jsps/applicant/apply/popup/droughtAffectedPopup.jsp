<%@ include file="../../../common/taglibs.jsp"%>

<div class="modal fade" id="droughtAffectedModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel"><fmt:message key="divisionController.note"/></h4>
            </div>
            <div class="modal-body container-fluid">
            	<div class="row">
            		<div class="col-sm-12">
						<fmt:message key="applicant.droughtAffected.note"/>
					</div>
            	</div>
            	<br>
            </div>
          
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><fmt:message key="ok"/></button>
            </div>
        </div>
	</div>
</div>