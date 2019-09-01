<!DOCTYPE html>
<%@ page pageEncoding="UTF-8"%>

<%@ include file="../common/taglibs.jsp"%>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <!-- The above 2 meta tags are for sending the _csrf token with the Ajax requests -->

    <title><fmt:message key="appName"/></title>

    <link rel="shortcut icon" href="<c:url value='/static/app/images/favicon.ico'/>" />

    <link rel="stylesheet" href="<c:url value='/static/libs/bootstrap/dist/css/bootstrap.min.css'/>" >
    <link rel="stylesheet" href="<c:url value='/static/libs/eonasdan-bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.min.css'/>" >
    <link rel="stylesheet" href="<c:url value='/static/libs/bootstrap-fileinput/css/fileinput.min.css'/>" >
    <link rel="stylesheet" href="<c:url value='/static/libs/bootstrap-select/dist/css/bootstrap-select.min.css'/>" />
    <link rel="stylesheet" href="<c:url value='/static/libs/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css'/>" />
    <link rel="stylesheet" href="<c:url value='/static/libs/components-font-awesome/css/font-awesome.min.css'/>" />
    <link rel="stylesheet" href="<c:url value='/static/libs/bootstrap-toggle/css/bootstrap-toggle.min.css'/>" />
    <link rel="stylesheet" href="<c:url value='/static/app/css/style.css'/>" />
    <link rel="stylesheet" href="<c:url value='/static/app/css/pagination.css'/>" />
    

    <!-- Javascript files go below  -->
    
    <script type="text/javascript" src="<c:url value='/static/libs/moment/min/moment.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/static/libs/jquery/dist/jquery.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/static/libs/jquery-validation/dist/jquery.validate.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/static/libs/jquery-validation/dist/additional-methods.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/static/libs/bootstrap/dist/js/bootstrap.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/static/libs/eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/static/libs/bootstrap-fileinput/js/fileinput.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/static/libs/bootstrap-validator/dist/validator.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/static/libs/bootbox.js/bootbox.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/static/libs/bootstrap-select/dist/js/bootstrap-select.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/static/libs/jquery-form/jquery.form.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/static/libs/jquery-idle-timeout/src/jquery.idletimer.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/static/libs/jquery-idle-timeout/src/jquery.idletimeout.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/static/libs/jquery-i18n-properties/jquery.i18n.properties.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/static/libs/bootstrap-toggle/js/bootstrap-toggle.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/static/libs/ckeditor/ckeditor.js'/>"></script>
	<!-- <script type="text/javascript" src="https://gisttransserver.in/js/CDAC-Typing_en.min.js"></script> -->
    <script type="text/javascript" src="<c:url value='/static/app/js/common.js'/>"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <spring:eval var="applicationSessionTimeout" expression="@applicationSessionTimeout" scope="page" />

    <script>
    	var isPersonalInfoPage = false;
        var appBasePath = '<c:url value="/"/>';
        var commonObj = new Common(appBasePath);
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        var idleTimeout = false;
        var i18n;

        function startIdleTimerPlugin(){
            // cache a reference to the countdown element so we don't have to query the DOM for it on each ping.
            var $countdown = $("#dialog-countdown");
            var applicationSessionTimeout = '${ applicationSessionTimeout }';

            // start the idle timer plugin
            $.idleTimeout('#sessionTimeoutPopup', '#keepAliveSesssion', {
                idleAfter: applicationSessionTimeout  * 60 - 60,
                pollingInterval: 60,
                keepAliveURL: '<c:url value="/keepAlive"/>',
                serverResponseEquals: 'OK',
                warningLength: 60,
                onTimeout: function () {
                    idleTimeout = true;
                    commonObj.logout();
                },
                onIdle: function () {
                    commonObj.showSessionTimeoutPopup();
                },
                onCountdown: function (counter) {
                    $countdown.html(counter); // update the counter
                }
            });
        }

        function addCSRFTokenInEachAjaxRequest(){
            $(document).ajaxSend(function(e, xhr, options) {
                if(isPersonalInfoPage == null || isPersonalInfoPage == 'undefined' || !isPersonalInfoPage){
                	xhr.setRequestHeader(header, token);
            	}
            });
        }

        jQuery.validator.addMethod("lettersonly", function(value, element) {
        	return this.optional( element ) || /^[^0-9.,\/#!$%@&*;:{}()~`_]+$/i.test( value );
			}, "<fmt:message key="validation.lettersOnly"/>"); 
        
        $.validator.addMethod("noSpace", function(value, element) {
  		  var trimvalue=value.trim();
  	    return trimvalue.length==value.length; 
  	  }, "<fmt:message key="validation.noSpace"/>");
		
        jQuery.validator.addMethod("englishlettersonly", function(value, element) {
        	 return this.optional(element) || /^[a-z ]+$/i.test(value);
  		}, "<fmt:message key="validation.lettersOnly"/>");
        
        jQuery.validator.addMethod("numbersonly", function(value, element) {
        	 return this.optional(element) || /^[0-9]*$/i.test(value) || /^[\u0967-\u096F][\u0966-\u096F]*$/i.test(value);
			}, "<fmt:message key="validation.numberfield"/>"); 
		
        jQuery.validator.addMethod("lettersandspaceonly", function(value, element) {
        	return this.optional( element ) || /^[^0-9.,\/#!$%@&*;:{}()~`_]+$/i.test( value );
			}, "<fmt:message key="validation.lettersOnly"/>");
        
        jQuery.validator.addMethod("trimSpacesFrontAndEnd", function(value, element) {
    		return this.optional( element ) || /^[^\s]+(\s+[^\s]+)*$/i.test( value );
    		}, "<fmt:message key="validation.trimSpacesFrontAndEnd"/>");
        
        jQuery.validator.addMethod('filesize', function (value, element, param) {
    	    return this.optional(element) || (element.files[0].size <= (param * 1000));
        }, "<fmt:message key="validation.fileImageSize"/>");

        jQuery.validator.addMethod("marathilettersonly", function(value, element) {
    		
    		return this.optional( element ) || isValid(value); // /^[^0-9.,\/#!$%@&*;:{}()~`_]+$/i.test( value );
    		}, "<fmt:message key="validation.marathi.charactersonly"/>");
		 
        jQuery(document).ready(function(){
        	
//         	$(document).keypress("y",function(e) {
//       	       if(e.ctrlKey) {
//       	         openKeyboard("mar");
//       	       }

//       	     });
        	/* function KeyPress(e) 
        	{
		      var evtobj = window.event? event : e;
		      if (evtobj.keyCode == 89 && evtobj.ctrlKey) 
		      {
		    	  openKeyboard("mar");  
		      }
			}

			document.onkeydown = KeyPress; */
            startIdleTimerPlugin();
            addCSRFTokenInEachAjaxRequest();

            jQuery.i18n.properties({
                name:['messages'],
                path:'<c:url value="/i18n/"/>',
                language:'${ pageContext.response.locale }',
                mode:'map',
                callback: function() {
                    i18n = 	jQuery.i18n.prop;

                    jQuery.extend(jQuery.validator.messages, {
                        required: i18n("validate.required"),
                        remote: i18n("validate.remote"),
                        email: i18n("validate.email"),
                        url: i18n("validate.url"),
                        date: i18n("validate.date"),
                        dateISO:i18n("validate.dateISO:i18n") ,
                        number: i18n("validate.number"),
                        digits: i18n("validate.digits"),
                        equalTo: i18n("validate.equalTo"),
                        accept: i18n("validate.accept"),
                        maxlength: jQuery.validator.format(i18n("validate.maxlength")),
                        minlength: jQuery.validator.format(i18n("validate.minlength")),
                        rangelength: jQuery.validator.format(i18n("validate.rangelength")),
                        range: jQuery.validator.format(i18n("validate.range")),
                        max: jQuery.validator.format("<fmt:message key="validate.max"><fmt:param value="{0}"/></fmt:message>"),
                        min: jQuery.validator.format("<fmt:message key="validate.min"><fmt:param value="{0}"/></fmt:message>"),
                        extension: i18n("validate.validExtension")
                    });
                }
            });
        });
        
        function isValid(str){
    	    if(typeof(str)!=='string'){
    	        return false;
    	    }
    	  
    	    for(var i=0;i<str.length;i++){
   	    	    if(str.charCodeAt(i) == '32')	// to allow spaces
   		    	{
   		    		return true;
   		    	}
    	        if(str.charCodeAt(i) <= 127){
    	            return false;
    	        }
    	    }
    	    return true;
    	}
    </script>

</head>
<body>

<div id="container">
    <sec:authorize access="isAuthenticated()">
        <div id="header">
            <tiles:insertAttribute name="header"/>
        </div>
        <c:if test="${ !isFirstLogin }">
            <div id="topmenu">
                <tiles:insertAttribute name="menu"/>
            </div>
        </c:if>
        <div id="content">
            <tiles:insertAttribute name="body"/>
        </div>
    </sec:authorize>
</div>

<div id="footer">
    <tiles:insertAttribute name="footer"/>
    <!-- <div id="thawteseal" class="text-left" title="Click to Verify - This site chose Thawte SSL for secure e-commerce and confidential communications.">
	  <div><script type="text/javascript" src="https://seal.thawte.com/getthawteseal?host_name=*.msrtcexam.in&amp;size=L&amp;lang=en"></script></div>
	  <div><a href="http://www.thawte.com/ssl-certificates/" target="_blank" style="color:#000000; text-decoration:none; font:bold 10px arial,sans-serif; margin:0px; padding:0px;">ABOUT SSL CERTIFICATES</a></div>
   </div> -->
</div>

<jsp:include page="../popup/sessionTimeoutPopup.jsp"/>

</body>
</html>