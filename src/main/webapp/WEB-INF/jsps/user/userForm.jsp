<%@ include file="../common/taglibs.jsp" %>

<script type="text/javascript">

    function saveUser(){
        if (!$('#createUserForm').validator('validate').has('.has-error').length) {
            $('#createUserForm').submit();
            commonObj.showInProgressIndicator();
        }
    }

</script>

<div>
    <h4>
        <c:choose>
            <c:when test="${ isUserProfile }">
                <fmt:message key="user.profile"/>
            </c:when>
            <c:otherwise>
                <c:choose>
                    <c:when test="${ user eq null or user.id eq null or user.id =='' }">
                        <fmt:message key="user.add"/>
                    </c:when>
                    <c:otherwise>
                        <fmt:message key="user.edit"/>
                    </c:otherwise>
                </c:choose>
            </c:otherwise>
        </c:choose>
    </h4>

    <tags:app-message message="${ message }"/>

    <div class="row">
        <div class="col-lg-12">

            <c:choose>
                <c:when test="${ isUserProfile }">
                    <c:url value='/user?operation=saveUserProfile' var="createUserFormAction"/>
                </c:when>
                <c:otherwise>
                    <c:url value='/user?operation=saveUser' var="createUserFormAction"/>
                </c:otherwise>
            </c:choose>

            <form name="createUserForm" id="createUserForm" data-toggle="validator" class="form-horizontal"
                  action="${ createUserFormAction }" method="POST">

                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" id="id" name="id" value="${ user.id }"/>

                <c:choose>
                    <c:when test="${ isUserProfile }">
                        <input type="hidden" id="menu" name="menu" value="userProfileMenuOption"/>
                        <input type="hidden" name="role.id" value="${user.role.id}"/>
                    </c:when>
                    <c:otherwise>
                        <input type="hidden" id="menu" name="menu" value="adminMenuOption"/>
                    </c:otherwise>
                </c:choose>

                <div class="form-group">
                    <label for="firstname" class="col-sm-2 control-label"><fmt:message key="user.firstname"/></label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="firstname" name="firstname"
                               value="${ user.firstname }" placeholder="<fmt:message key="user.firstname"/>" maxlength="50" required>
                        <div class="help-block with-errors"></div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="lastname" class="col-sm-2 control-label"><fmt:message key="user.lastname"/></label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="lastname" name="lastname" value="${ user.lastname }"
                               placeholder="<fmt:message key="user.lastname"/>" maxlength="50" required>
                        <div class="help-block with-errors"></div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="email" class="col-sm-2 control-label"><fmt:message key="user.email"/></label>
                    <div class="col-sm-4">
                        <input type="email" class="form-control" id="email" name="email" value="${ user.email }"
                               placeholder="<fmt:message key="user.email"/>" maxlength="100" required>
                        <div class="help-block with-errors"></div>
                    </div>
                </div>

                <c:set var="passwordRequired"
                       value="${ (user eq null or user.id eq null or user.id =='' ) ? 'required' : ''}"/>

                <div class="form-group">
                    <label for="password" class="col-sm-2 control-label"><fmt:message key="user.password"/></label>
                    <div class="col-sm-4">
                        <input type="password" class="form-control" id="password" name="password" maxlength="20"
                               placeholder="<fmt:message key="user.password"/>" ${passwordRequired}>
                        <div class="help-block with-errors"></div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="confirmPassword" class="col-sm-2 control-label"><fmt:message
                            key="user.confirmPassword"/></label>
                    <div class="col-sm-4">
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" maxlength="20"
                               data-match="#password" data-match-error="<fmt:message key="user.password.mismatch"/>"
                               placeholder="<fmt:message key="user.confirmPassword"/>" ${passwordRequired}>
                        <div class="help-block with-errors"></div>
                    </div>
                </div>

                <c:if test="${ !isUserProfile }">
                    <div class="form-group">
                        <label for="roleId" class="col-sm-2 control-label"><fmt:message key="user.role"/></label>
                        <div class="col-sm-4">
                            <select id="roleId" name="role.id" class="selectpicker" required>
                                <option value="">-- Please select --</option>
                                <c:forEach items="${roleList}" var="role">
                                    <option value="${role.id}" ${ role.id eq user.role.id? 'selected=selected':'' }>${role.title}</option>
                                </c:forEach>
                            </select>
                            <div class="help-block with-errors"></div>
                        </div>
                    </div>
                </c:if>

                <div class="form-group">
                    <div class="col-sm-2 control-label"></div>
                    <div class="col-sm-4">
                        <tags:hasPermission moduleName="user" operation="saveUser">
                            <button id="saveBtn" type="button" class="btn btn-primary" onclick="javascript:saveUser();"><fmt:message
                                    key="save"/></button>
                        </tags:hasPermission>
                        <c:if test="${ !isUserProfile }">
                            <button id="cancelBtn" type="button" class="btn btn-default"
                                    onclick="javascript:commonObj.goToURL('<c:url
                                            value='/user?operation=userList&menu=adminMenuOption'/>');"><fmt:message
                                    key="cancel"/></button>
                        </c:if>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
