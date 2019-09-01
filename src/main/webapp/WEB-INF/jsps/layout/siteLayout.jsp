<!DOCTYPE html>
<%@page pageEncoding="UTF-8"%>

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

<%--
  <meta http-equiv="cache-control" content="no-store, must-revalidate, max-age=0" />
&lt;%&ndash;
  <meta http-equiv="cache-control" content="no-cache" />
  <meta http-equiv="cache-control" content="no-store" />
  <meta http-equiv="cache-control" content="must-revalidate" />
&ndash;%&gt;
  <meta http-equiv="expires" content="0" />
  <meta http-equiv="pragma" content="no-cache" />
--%>

  <title><fmt:message key="appName"/></title>

  <link rel="shortcut icon" href="<c:url value='/static/app/images/favicon.ico'/>" />

  <link rel="stylesheet" href="<c:url value='/static/libs/bootstrap/dist/css/bootstrap.min.css'/>" >
  <link rel="stylesheet" href="<c:url value='/static/libs/bootstrap-fileinput/css/fileinput.min.css'/>" >
  <link rel="stylesheet" href="<c:url value='/static/libs/eonasdan-bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.min.css'/>" >
  <link rel="stylesheet" href="<c:url value='/static/libs/bootstrap-select/dist/css/bootstrap-select.min.css'/>" />
  <link rel="stylesheet" href="<c:url value='/static/libs/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css'/>" />
  <link rel="stylesheet" href="<c:url value='/static/libs/components-font-awesome/css/font-awesome.min.css'/>" />
  <link rel="stylesheet" href="<c:url value='/static/app/css/layout.css'/>" />

  <!-- Javascript files go below  -->
  <script type="text/javascript" src="<c:url value='/static/libs/moment/min/moment.min.js'/>"></script>
  <script type="text/javascript" src="<c:url value='/static/libs/jquery/dist/jquery.min.js'/>"></script>
  <script type="text/javascript" src="<c:url value='/static/libs/jquery-validation/dist/jquery.validate.js'/>"></script>
  <script type="text/javascript" src="<c:url value='/static/libs/jquery-validation/dist/additional-methods.min.js'/>"></script>
  <script type="text/javascript" src="<c:url value='/static/libs/bootstrap-fileinput/js/fileinput.min.js'/>"></script>
  <script type="text/javascript" src="<c:url value='/static/libs/bootstrap/dist/js/bootstrap.min.js'/>"></script>
  <script type="text/javascript" src="<c:url value='/static/libs/eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js'/>"></script>
  <script type="text/javascript" src="<c:url value='/static/libs/bootstrap-validator/dist/validator.min.js'/>"></script>
  <script type="text/javascript" src="<c:url value='/static/libs/bootbox.js/bootbox.js'/>"></script>
  <script type="text/javascript" src="<c:url value='/static/libs/bootstrap-select/dist/js/bootstrap-select.min.js'/>"></script>
  <script type="text/javascript" src="<c:url value='/static/libs/jquery-i18n-properties/jquery.i18n.properties.min.js'/>"></script>
  <!-- <script type="text/javascript" src="https://gisttransserver.in/js/CDAC-Typing_en.min.js"></script> -->
  <script type="text/javascript" src="<c:url value='/static/app/js/common.js'/>"></script>

  <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->

  <script>
    var appBasePath = '<c:url value="/"/>';
    var commonObj = new Common(appBasePath);
    var i18n;

    function addCSRFTokenInEachAjaxRequest(){
      var token = $("meta[name='_csrf']").attr("content");
      var header = $("meta[name='_csrf_header']").attr("content");

      $(document).ajaxSend(function(e, xhr, options) {
        xhr.setRequestHeader(header, token);
      });
    }

  
    
    jQuery(document).ready(function(){
    	
//     	 $(document).keypress("y",function(e) {

//     	       if(e.ctrlKey) {
//     	         openKeyboard("mar");
//     	       }

//     	     });
	/* function KeyPress(e) 
	 {
	     var evtobj = window.event? event : e;
	     if (evtobj.keyCode == 89 && evtobj.ctrlKey) 
	     {
	   	  openKeyboard("mar");  
	     }
	}

document.onkeydown = KeyPress; */

      //addCSRFTokenInEachAjaxRequest();

      // create your custom rule
      jQuery.validator.addMethod("myEmail", function(value, element) {
        return this.optional( element ) || ( /^[a-z0-9]+([-._][a-z0-9]+)*@([a-z0-9]+(-[a-z0-9]+)*\.)+[a-z]{2,4}$/.test( value ) && /^(?=.{1,64}@.{4,64}$)(?=.{6,100}$).*/.test( value ) );
      }, "<fmt:message key="validation.emailfield"/>");
	
      $.validator.addMethod("noSpace", function(value, element) {
   		  var trimvalue=value.trim();
     	    return trimvalue.length==value.length; 
     	  }, "<fmt:message key="validation.noSpace"/>");
     
      
      jQuery.validator.addMethod("lettersonly", function(value, element) {
//		  return this.optional(element) || /^[a-z]+$/i.test(value);
		return this.optional( element ) || /^[^0-9.,\/#!$%@&*;:{}()~`_]+$/i.test( value );
		}, "<fmt:message key="validation.lettersOnly"/>");
      
      jQuery.validator.addMethod("englishlettersonly", function(value, element) {
		  return this.optional(element) || /^[a-z ]+$/i.test(value);
		}, "<fmt:message key="validation.lettersOnly"/>");
      
	jQuery.validator.addMethod("numbersonly", function(value, element) {
// 		  return this.optional(element) || /^[0-9]+$/i.test(value);
			  return this.optional(element) || /^[0-9]*$/i.test(value) || /^[\u0967-\u096F][\u0966-\u096F]*$/i.test(value);
		}, "<fmt:message key="validation.numberfield"/>"); 
	
	jQuery.validator.addMethod("trimSpacesFrontAndEnd", function(value, element) {
		return this.optional( element ) || /^[^\s]+(\s+[^\s]+)*$/i.test( value );
		}, "<fmt:message key="validation.trimSpacesFrontAndEnd"/>");

	jQuery.validator.addMethod("marathilettersonly", function(value, element) {
		
		return this.optional( element ) || isValid(value); // /^[^0-9.,\/#!$%@&*;:{}()~`_]+$/i.test( value );
		}, "<fmt:message key="validation.marathi.charactersonly"/>");
    
      jQuery.i18n.properties({
        name:['messages'],
        path:'<c:url value="/i18n/"/>',
        language:'${ pageContext.response.locale }',
        mode:'map',
        callback: function() {
          i18n = jQuery.i18n.prop;

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
            max: jQuery.validator.format(i18n("validate.max")),
            min: jQuery.validator.format(i18n("validate.min")),
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
	    	
	    	if(str.charCodeAt(i) == '32') // to allow spaces
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
<body onunload="">

<!-- START PAGE SOURCE -->
<div id="container">
  <!-- Header Start -->
  <div id="header" class="clearfix">
    <tiles:insertAttribute name="header" />
  </div>
  <%--<tiles:insertAttribute name="menu" />--%>
  <!-- Header End -->
  <tiles:insertAttribute name="body" />
</div>
<div id="footer">
  <tiles:insertAttribute name="footer" />
  <!-- <div id="thawteseal" class="text-left" title="Click to Verify - This site chose Thawte SSL for secure e-commerce and confidential communications.">
	  <div><script type="text/javascript" src="https://seal.thawte.com/getthawteseal?host_name=*.msrtcexam.in&amp;size=L&amp;lang=en"></script></div>
	  <div><a href="http://www.thawte.com/ssl-certificates/" target="_blank" style="color:#000000; text-decoration:none; font:bold 10px arial,sans-serif; margin:0px; padding:0px;">ABOUT SSL CERTIFICATES</a></div>
  </div> -->
</div>
<!-- END PAGE SOURCE -->

<jsp:include page="../popup/termsAndCondition.jsp"/>
<jsp:include page="../popup/disclaimer.jsp"/>
<jsp:include page="../popup/hyperlinkingPolicy.jsp"/>
<jsp:include page="../popup/privacyPolicy.jsp"/>
<jsp:include page="../popup/copyrightPolicy.jsp"/>





</body>
</html>

<input type="hidden" id="refreshed" value="no">

<script type="text/javascript">

    $(window).load(function(){
        var e = document.getElementById("refreshed");
        if(e.value=="no"){
            e.value="yes";
        } else {
            e.value="no";
            location.reload();
        }
    });

</script>