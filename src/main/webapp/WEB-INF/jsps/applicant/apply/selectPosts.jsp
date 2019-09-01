<%@ include file="../../common/taglibs.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1" %>

<script>

    jQuery(document).ready(function() {

        var appliedPosts = ${appliedPosts};
		
		if(appliedPosts != null){
	        for(var i=0;i<appliedPosts.length;i++){
	            $('#checkBox_'+appliedPosts[i]).attr( 'checked', 'checked' );
	        }
		}	
        jQuery("#postSelectionForm").ajaxForm({
            dataType:  'json',
            beforeSubmit:  function(){
            	var selectedPosts = [];
                $(':checkbox:checked').each(function(i){
                	selectedPosts[i] = $(this).val();
                });
				
                
                if(selectedPosts.length>0){
                	jQuery("#saveBtn").attr("disabled",true);
                	jQuery("#nextBtn").attr("disabled",true);
                	return true;
                }else{
                	commonObj.showAlert("<fmt:message key="please.select.atleast.one.post" />");
                	return false;
                }
            },
            success:  function(result){
            	jQuery("#saveBtn").attr("disabled",false);
            	jQuery("#nextBtn").attr("disabled",false);
                var success = result.success;
                if(success){
                    applyObj.showSelectedPosts();
                    return false;
                } else {
                    commonObj.showAlert("There was some error while trying to save the Applicant's Posts.");
                }
            }

        });

        // Payment transaction success post are all disabled 
        var disablePosts = ${paymentTransactionSuccessPostsId};
        if(disablePosts != null)
        {    
        	 var js = "return false;";
        	    // create a function from the "js" string
        	    var common = new Function(js);

	        for(var i=0;i<disablePosts.length;i++){
	            $('#checkBox_'+disablePosts[i]).attr( 'readonly', true );
	            $('#checkBox_'+disablePosts[i]).attr( 'checked', true );
	         	// clears onclick then sets click using jQuery
	            $('#checkBox_'+disablePosts[i]).attr( 'onclick', '').click(common);
	        }
        } 

        var lastDateOver = commonObj.isValidate(${disableFormAfterLastDateOver});
        commonObj.disableFormFields("postSelectionForm",lastDateOver);
        
    });
</script>

<form  name="postSelectionForm" id="postSelectionForm" action="<c:url value='/applicant?operation=savePostSelection'/>"	method="POST">
    <div class="row">
        <div class="col-md-9">
        <c:forEach items="${postSuperCategoryList }" var="postSuperCategory">
        <h3 class="sectionhead"><fmt:message key="${postSuperCategory.messageKey }"/> </h3>
            <div class="subsection">
                <c:forEach items="${postSuperCategory.posCategorytList }" var="availablePost">
                    <h3><fmt:message key="${availablePost.messageKey }"/> </h3>

                    <c:forEach items="${availablePost.postList }" var="post">
                        <div class="checkbox">

                            <c:set var="disablePost" value="false"/>

                            <c:forEach items="${ paymentTransactionSuccessPostsId }" var="disabledPostId">
                                <c:if test="${ disabledPostId eq post.postId}">
                                    <c:if test="${ disablePost eq false }">
                                        <c:set var="disablePost" value="true"/>
                                    </c:if>
                                </c:if>
                            </c:forEach>
                            <c:choose>
                                <c:when test="${ disablePost eq true }">
                                    <input type="hidden" name="postList" value="${post.postId }"/>
                                    <label class="checkbox_disabled">
                                    	<fmt:message key="${post.messageKey }"/>
                                   	</label>
                                </c:when>
                                <c:otherwise>
                                    <input id="checkBox_${post.postId }" class="styled"  type="checkbox" name="postList" placeholder="" value="${post.postId }"/>
                                    <label for="checkBox_${post.postId }">
                                        <fmt:message key="${post.messageKey }"/>
                                    </label>
                                </c:otherwise>
                            </c:choose>

                        </div>
                    </c:forEach>
                </c:forEach>
            </div>
        </c:forEach>
        </div>
    </div>

    <nav class="navbar btn-toolbar sw-toolbar sw-toolbar-bottom">
        <div class="btn-group navbar-btn sw-btn-group pull-right" role="group">
        	<c:if test="${!disableFormAfterLastDateOver}">
	            <button id="saveBtn" onclick="" class="btn btn-default sw-btn-next" type="submit">
	                <fmt:message key="save" />
	            </button>
	       </c:if>
<%--
            <button onclick="" class="btn btn-default sw-btn-next" type="button">
                <fmt:message key="saveAsDraft" />
            </button>
--%>
            <button onclick="javascript:applyObj.gotoTab('4')" class="btn btn-default sw-btn-next skipDisabling" type="button">
                <fmt:message key="next" />
            </button>
        </div>
    </nav>
</form>