<%@ include file="common/taglibs.jsp" %>
<script type="text/javascript" src="<c:url value='/static/libs/jQuery-bootstrap/scripts/jquery.bootstrap.newsbox.min.js'/>"></script>
<script>

	$(document).ready(function() {

		$("#password").keyup(function(event){
			if(event.keyCode == 13){
				checkLogin();
			}
		});

	});

	function checkLogin(){
        $("#checkLoginForm").validate();

        /*if (!$('#checkLoginForm').validator('validate').has('.has-error').length) {
        */    $("#username").val( commonObj.USER_TYPE_APPLICANT +  commonObj.SEPARATOR  + $("#j_username").val());
            $("#checkLoginForm").submit();
        /*}*/
    }
	
    function showPdfInNewTab( documentId, locale ) {
		var url = "<c:url value='/file/viewPdf'/>?documentId="+documentId+"&locale="+locale;
		window.open(url,'_blank');
	}
    
	function showPdfInNewTabAdd( advertisementId, locale ) {
		var url = "<c:url value='/file/viewAdvertisement'/>?advertisementId="+advertisementId+"&locale="+locale;
		window.open(url,'_blank');
	}
	if (${ fn:length(announcementList) gt 3}) {
		$(function () {
	        $(".announcementList").bootstrapNews({
	            newsPerPage: 3,
	            autoplay: true,
	            navigation : false,
				pauseOnHover:true,
	            direction: 'up',
	            newsTickerInterval: 1000,
	            onToDo: function () {
	                //console.log(this);
	            }
	        });
		});
		
		$("#viewAll").click(function(){
			
			 $(".announcementList").bootstrapNews({
		           
		        });
			
		})
	}
	
	

	$(document).ready(function(e) {

		$('form.no_autofill').attr('autocomplete','off');
		//$('.no_autofill input').attr('autocomplete','off');
		
	    if ($.browser.webkit) {
	        $('#password').val(' ').val('');
	        $('#j_username').val(' ').val('');
	    }
	});
	
</script>

<div id="topbox">
<fmt:message key="login.login" var="loginBtnTxt"/>
<fmt:message key="login.registration" var="registrationBtnTxt"/>
    <!-- Register Start -->

	<div id="tbleft">

		<%-- <c:choose> --%>
			<%-- <c:when test="${ disableNewRegistration eq 1 or disableNewRegistration eq '1'}"> --%>
				<left>
					<br/>
					<c:forEach items="${ activeMessages }" var="activeMessage">
						<c:choose>
							<c:when test="${pageContext.response.locale eq 'en'}">
								<c:out value="${ activeMessage.messageText }"/>
							</c:when>
							<c:otherwise>
								<c:out value="${ activeMessage.messageInMarathi }"/>
							</c:otherwise>
						</c:choose>
						<br/><br/>
					</c:forEach>
				</left>
			<%-- </c:when> --%>
			<%-- <c:otherwise>
				<center>
					<h4>
						<fmt:message key="landingPage.createNewAccount"/></h4>
					<a href="javascript:void(0);" onclick="javascript:commonObj.goToURL('<c:url value='/applicant/showRegistrationPage'/>');">
						<input name="search" type="submit" class="btn" value="${registrationBtnTxt }" style="margin-left: -60px;width: 120px;height: 30px;">
					</a>
				</center>
			</c:otherwise> --%>
		<%-- </c:choose> --%>
	</div>
    <!-- Register End -->

    <div id="tbright">
        <h4><fmt:message key="landingpage.logIn"/></h4>
        <form class="no_autofill" name="checkLoginForm" id="checkLoginForm" action="<c:url value='/checkLogin'/>" method="POST" >
            <input path="" type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <input path="" type="hidden" id="username" name="username"  value=""/>
            <div id="boxleft">
                <table>
                    <tbody><tr>
                        <td width="80"><label for="username"><fmt:message key="login.applicationId" />:</label></td>
                        <td><input type="text" placeholder="<fmt:message key="login.applicationId" />" name="j_username" id="j_username" class="form-control" required readonly onfocus="this.removeAttribute('readonly');" /></td>
                    </tr>
                    <tr>
                        <td><label for="password"><fmt:message key="login.password" /> :</label></td>
                        <td><input type="password" placeholder="<fmt:message key="login.password" />" name="password" id="password" class="form-control" required readonly onfocus="this.removeAttribute('readonly');" /></td>
                    </tr>
                    </tbody></table>
                <p>
               </p><p class="link"><a href="javascript:void(0)" onclick="javascript:commonObj.goToURL('<c:url value="/applicant/forgotPasswordForm"/>')">
                <fmt:message key="login.forgot.your.password"/>
            </a></p>
            <div align="center">
                <input id="loginBtn" type="button" class="btn" value="${loginBtnTxt }" style="position: relative;width: 80px;margin-left: 20px;height: 23px;" onclick="javascript:checkLogin();" />
                <p></p>
                <c:if test="${ disableNewRegistration eq 0 or disableNewRegistration eq '0'}">
                <a href="javascript:void(0);" onclick="javascript:commonObj.goToURL('<c:url value='/applicant/showRegistrationPage'/>');">
						<input name="search" type="button" class="btn" value="${registrationBtnTxt }" style="position: relative;margin-left: 60px;width: 80px;height: 23px;">
					</a>
				</c:if>
			</div>
                <c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION and param.login_error eq 1}">
                   <span class="red bold"><b><fmt:message key="login.error"/></b></span>
                </c:if>
            </div>
        </form>
    </div>
</div>

<c:if test="${ fn:length(announcementList)  gt 0}">
	<div class="headerbar"><fmt:message key="announcement.header" /></div>
	<div class="panel panel-default">
		<div class="panel-body">
			<div class="row">
				<div class="col-xs-12">
					<div class="adversetable">
						<table class="table table-bordered">
								<tr>
						            <th width="20%"><fmt:message key="document.title" /></th>
						            <th width="73%"><fmt:message key="document.description" /></th>
						            <th width="7%"><fmt:message key="document.file" /></th>
						        </tr>
							</table>
						<div class="announcementList">
							<c:forEach var="announcement" items="${announcementList}">
								<div class="news-item">
									<table class="table table-bordered">
										<tr>
											<td width="20%">${announcement[1]}</td>
								            <td width="73%">${announcement[2]}</td>
								            <td width="7%" class="text-center">
								            	<a href="javascript:void(0)" onclick="javascript:showPdfInNewTab('${announcement[0]}', '${ pageContext.response.locale }')" title="<fmt:message key="document.viewPdf"/>">
													<i class="fa fa-file-pdf-o fa-4" aria-hidden="true"></i>
								            	</a>
								            </td>
										</tr>
									</table>
								</div>
							</c:forEach>
							
             
              
              
						</div>	
						<a style="float:right" href="javascript:void(0)" onclick="javascript:commonObj.goToURL('<c:url value="/documents/viewAnnouncementList?&menu=announcements"/>')">
                <fmt:message key="announcement.viewMore"/></a>					
					</div>
				</div>
			</div>
		</div>
	</div>
</c:if>
 <c:if test="${ fn:length(advertisementList)  gt 0}">
 	<div class="headerbar"><fmt:message key="advertisement" /></div>
	<div class="adversetable">
	    <table class="table table-bordered">
	        <tr>
	            <th><fmt:message key="advertisement.advertisementNo" /></th>
	<!--             <th>Name of the post</th> -->
		<th><fmt:message key="advertisement.title" /></th>
		<th width="35%"><fmt:message key="advertisement.description" /></th>
	          <th><fmt:message key="advertisement.startDate" /></th>
	          <th><fmt:message key="advertisement.closingDate" /></th>
	          <th><fmt:message key="advertisement.file" /></th>
	      </tr>
	      
	      <c:forEach var="advertisement" items="${advertisementList}">
	     		<tr>
	     			<td>${advertisement[1]}</td>
	           <td>${advertisement[2]}</td>
	           <td>${advertisement[3]}</td>
	           <td>
	           		<fmt:parseDate value="${advertisement[4]}" pattern="yyyy-MM-dd" var="startDate" type="date"/>
	           		<fmt:formatDate type="date" pattern="dd/MM/yyyy" value="${startDate}" />
	           </td>
	           <td>
					<fmt:parseDate value="${advertisement[5]}" pattern="yyyy-MM-dd" var="closingDate" type="date"/>
	            	<fmt:formatDate type="date" pattern="dd/MM/yyyy" value="${closingDate}" />
			   </td>
	           <td width="7%" class="text-center">
	           	<a href="javascript:void(0)" onclick="javascript:showPdfInNewTabAdd('${advertisement[0]}', '${ pageContext.response.locale }')" title="<fmt:message key="advertisement.viewPfd" />">
	           		<i class="fa fa-file-pdf-o fa-4" aria-hidden="true"></i>
	           	</a>
	           </td>
	       </tr>
	      </c:forEach>
	    </table>
	</div>
</c:if>



<%--

<div id="promobox">
    <div class="section">
        <h3>News</h3>
        <div class="pricebox"> </div>
        <div class="vertical-marquee-news" style="overflow: hidden; position: relative; height: 160px;">
            <ul style="position: absolute; margin: 0px; padding: 0px; top: -8.16629px;">
                <li><font>Unlike Woman</font></li>
                <li><font>Tax Auditor - 50 posts</font></li>
                <li><font>
                    Assistant Professor 13 Posts</font></li>
                <li><font>Results Announced</font></li><li><font>Results 2017</font></li><li><font>Jr.Research Blog</font></li><li><font>Qaeda official</font></li><li><font>General Sergon - 30 Posts</font></li><li><font>Unlike Woman</font></li></ul>
        </div>
        <p><a href="#">More</a></p>
    </div>
    <div class="section">
        <h3>Result</h3>
        <div class="pricebox"> </div>
        <div class="vertical-marquee-results" style="overflow: hidden; position: relative; height: 160px;">
            <ul style="position: absolute; margin: 0px; padding: 0px; top: 0px;">
                <li><font>
                    Five per cent of government jobs to go to sports</font></li>
                <li><font> Govt officials recruited through the dissatisfaction </font></li>
                <li><font>
                    Register to farmers in drought</font></li><li><font>
                2000 trees plantation</font></li><li><font> 17% of government jobs market hots</font></li><li><font>
                Government Medical College and Hospital, Department of OTPT get 20 teaching posts</font></li><li><font>District Health Officer post was vacant for 20%</font></li><li><font> 2000, 774 youths run fireman post</font></li></ul>
        </div>
        <p><a href="#">More</a></p>
    </div>
    <div class="section">
        <h3>Advertisement</h3>
        <div class="pricebox"> </div>
        <div class="vertical-marquee-ad" style="overflow: hidden; position: relative; height: 160px;">
            <ul style="position: absolute; margin: 0px; padding: 0px; top: 0px;">
                <li><font>Clerk, Jammu - 2016</font></li>
                <li><font>Professor, Pune - 2016</font></li>
                <li><font>Assistant professor of College of Engineering, Pune - 2016</font></li><li><font>
                Fire Vijvnara Man Mumbai - 2016 </font></li><li><font>Constable Nagpur - 2016</font></li><li><font>Mumbai, assistant professor of medicine - 2016</font></li><li><font>
                Assistant Professor, Pune - 2016</font></li><li><font> Junior Clerk, Jammu - 2016</font></li></ul>
        </div>
        <p><a href="#">More</a></p>
    </div>
</div>--%>
