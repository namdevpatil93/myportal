<!DOCTYPE html>

<%@ include file="../common/taglibs.jsp"%>

<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title><fmt:message key="appName"/></title>

    <link rel="shortcut icon" href="<c:url value='/static/app/images/favicon.png'/>" type="image/x-icon" />

    <link rel="stylesheet" href="<c:url value='/static/libs/bootstrap/dist/css/bootstrap.min.css'/>" >
    <link rel="stylesheet" href="<c:url value='/static/app/css/style.css'/>" />

	<!-- Javascript files goes below  -->
    <script type="text/javascript" src="<c:url value='/static/libs/jquery/dist/jquery.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/static/libs/bootstrap/dist/js/bootstrap.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/static/libs/bootstrap-validator/dist/validator.min.js'/>"></script>

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

          jQuery(document).ready(function(){
          });
      </script>

  </head>
  <body>

  <div id="containerlogin">
      <div id="content">
          <tiles:insertAttribute name="body" />
      </div>
  </div>

  </body>
</html>