<!doctype html>
<html lang="en">
<head>
<cfparam name="rc.title" default="Raps">
<title><cfoutput>#rc.title#</cfoutput></title>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<!--JQuery -->
<script src="/jscripts/jquery-1.7.1.min.js" type="text/javascript"></script>
<script src="/jscripts/jquery-ui-1.8.18.custom.min.js" type="text/javascript"></script>
<script src="/jscripts/jquery.formdefaults.js" type="text/javascript"></script>
<script src="/jscripts/jquery.formobserver.js" type="text/javascript"></script>
<script src="/jscripts/jquery.validate.min.js" type="text/javascript"></script>
<script src="/jscripts/jquery.metadata.js" type="text/javascript"></script>
<script src="/jscripts/autoNumeric-1.7.5.js" type="text/javascript"></script>
<script src="/jscripts/inputmask/jquery.inputmask.js" type="text/javascript"></script>
<!--Theme-->
<link href="/themes/rocket/jquery-wijmo.css" rel="stylesheet" type="text/css" title="rocket-jqueryui" />
<!--Wijmo Widgets CSS-->
<link href="/css/jquery.wijmo-complete.all.2.1.4.min.css" rel="stylesheet" type="text/css" />
<!--Application CSS-->
<link href="/css/style.css" rel="stylesheet" type="text/css" />
<link href="/css/wijmo-override.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="/css/print.css" type="text/css" media="print" />
  <!--[if IE 9]>
<link rel="stylesheet" type="text/css" href="/css/ie9.css" />
<![endif]--> 
<!--Wijmo Widgets JavaScript-->
<script src="/jscripts/jquery.wijmo-open.all.2.1.4.min.js" type="text/javascript"></script>
<script src="/jscripts/jquery.wijmo-complete.all.2.1.4.min.js" type="text/javascript"></script>
<!--Application JS -->
<script src="/jscripts/raps.js" type="text/javascript"></script>

</head>
<body style="background-image:none;">
<cfparam name="pagetitle" default="Insurance Application">
<div id="appcontainer">
  <div id="appheader">
	
    <img class="applogo" src="/images/Fitness-Insurance-logo-long.gif" />
    <h1><cfoutput>#pagetitle#</cfoutput></h1>
  </div>
 
<cfoutput>#body#</cfoutput>

</div><!---End Container--->


</body>
</html>