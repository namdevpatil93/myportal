<%@ include file="../../../common/taglibs.jsp"%>
<!-- Security Inspector (Jr.) Eligibility Criteria Popup -->

<div class="modal fade" id="fireWardenJuniorPopup" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="skipDisabling close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel"><fmt:message key='fireWardenJuniorEligibility.modal.title' /></h4>
            </div>
            <div class="modal-body container-fluid">
            	<%-- <div class="row">
            		<div class="col-sm-12">
            			<fmt:message key='fireWardenJuniorEligibility.modal.noteText' />
            		</div>
            	</div> --%>
            	
            	<div class="row">
            		<div class="col-sm-1">&nbsp;</div>
            		<div class="col-sm-11">
            			<b><fmt:message key='fireWardenJuniorEligibility.modal.runningTest' /></b>
            		</div>
            	</div>
            	<div class="row">
            		<div class="col-sm-2">&nbsp;</div>
            		<div class="col-sm-2">
            			<fmt:message key='forMale' />
            		</div>
            		<div class="col-sm-1">:</div>
            		<div class="col-sm-7">
						<fmt:message key='fireWardenJuniorEligibility.modal.runningTest.male' />
					</div>
            	</div>
            	<div class="row">
            		<div class="col-sm-2">&nbsp;</div>
            		<div class="col-sm-2">
            			<fmt:message key='forFemale' />
            		</div>
            		<div class="col-sm-1">:</div>
            		<div class="col-sm-7">
						<fmt:message key='fireWardenJuniorEligibility.modal.runningTest.female' />
					</div>
            	</div>
            	
            	<div class="row">
            		<div class="col-sm-1">&nbsp;</div>
            		<div class="col-sm-11">
            			<b><fmt:message key='fireWardenJuniorEligibility.modal.pullUp' /></b>
            		</div>
            	</div>
            	<div class="row">
            		<div class="col-sm-2">&nbsp;</div>
            		<div class="col-sm-2">
            			<fmt:message key='forMale' />
            		</div>
            		<div class="col-sm-1">:</div>
            		<div class="col-sm-7">
						<fmt:message key='fireWardenJuniorEligibility.modal.pullUp.male' />
					</div>
            	</div>
            	
            	<div class="row">
            		<div class="col-sm-1">&nbsp;</div>
            		<div class="col-sm-11">
            			<b><fmt:message key='fireWardenJuniorEligibility.modal.jump' /></b>
            		</div>
            	</div>
            	<div class="row">
            		<div class="col-sm-2">&nbsp;</div>
            		<div class="col-sm-2">
            			<fmt:message key='forMale' />
            		</div>
            		<div class="col-sm-1">:</div>
            		<div class="col-sm-7">
						<fmt:message key='fireWardenJuniorEligibility.modal.jump.male' />
					</div>
            	</div>
            </div>
            <div class="modal-footer">
                <button type="button" class="skipDisabling btn btn-default" data-dismiss="modal"><fmt:message key='fireWardenJuniorEligibility.modal.close' /></button>
            </div>
        </div>
    </div>
</div>