<%@ include file="../../common/taglibs.jsp"%>

<c:if test="${ !formReadOnly }">
    <nav class="navbar btn-toolbar sw-toolbar sw-toolbar-bottom">
        <div class="btn-group navbar-btn sw-btn-group pull-right" role="group">
            <%-- <button onclick="javascript:postSelectionObj.showPostSelection();" class="btn btn-default sw-btn-next" type="button" id="cancelBtn">
                <fmt:message key="cancel" />
            </button> --%>
            <c:if test="${ param.isPostSubmitted }">
	            <button onclick="javascript:postSelectionObj.moveNext('${ param.formId }')" class="btn btn-default sw-btn-next skipDisabling" type="button" id="nextBtn">
	                <fmt:message key="ok" />
	            </button>
            </c:if>
            <c:if test="${ !param.isPostSubmitted}">
	            <button onclick="javascript:postSelectionObj.showPostSelection();" class="btn btn-default sw-btn-next skipDisabling" type="button" id="cancelBtn">
	                <fmt:message key="cancel" />
	            </button>
                <button onclick="javascript:deletePost('${ param.postId }');" class="btn btn-danger sw-btn-next skipDisabling" type="button" id="delBtn">
                    <fmt:message key="delete" />
                </button>
                <c:choose>
                	<c:when test="${ !param.disableFormAfterLastDateOver}">
                		<button onclick="javascript:postSelectionObj.saveForm('${ param.formId }');" class="btn btn-default sw-btn-next" type="button" id="saveBtn">
	                    	<fmt:message key="save" />
	                	</button>
	                	<button onclick="javascript:postSelectionObj.saveFormAsDraft('${ param.formId }');" class="cancel btn btn-default sw-btn-next" type="button" id="saveAsDraftBtn">
	                    	<fmt:message key="saveAsDraft" />
	                	</button>
                	</c:when>
                	<c:otherwise>
                		<button onclick="javascript:postSelectionObj.moveNext('${ param.formId }')" class="btn btn-default sw-btn-next skipDisabling" type="button" id="nextBtn">
	                		<fmt:message key="next" />
	            		</button>
                	</c:otherwise>
                </c:choose>
                <%-- <c:if test="${ !param.disableFormAfterLastDateOver}">
	                <button onclick="javascript:postSelectionObj.saveForm('${ param.formId }');" class="btn btn-default sw-btn-next" type="button" id="saveBtn">
	                    <fmt:message key="save" />
	                </button>
	                <button onclick="javascript:postSelectionObj.saveFormAsDraft('${ param.formId }');" class="cancel btn btn-default sw-btn-next" type="button" id="saveAsDraftBtn">
	                    <fmt:message key="saveAsDraft" />
	                </button>
                </c:if> --%>
            </c:if>
        </div>
    </nav>
</c:if>
