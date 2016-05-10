<!doctype html>
<html lang="en">
<head>
<cfparam name="rc.title" default="Raps">
<title><cfoutput>#rc.title#</cfoutput></title>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta http-equiv="expires" content="Mon, 06 Jan 1990 00:00:01 GMT"> 
<!--JQuery -->
<script src="/jscripts/jquery-1.7.1.min.js" type="text/javascript"></script>
<!--Jquery UI--->
<script src="/jscripts/jquery-ui-1.8.18.custom.min.js" type="text/javascript"></script>
<script src="/jscripts/jquery.formdefaults.js" type="text/javascript"></script>
<script src="/jscripts/jquery.formobserver.js" type="text/javascript"></script>
<script src="/jscripts/jquery.validate.min.js" type="text/javascript"></script>
<script src="/jscripts/jquery.metadata.js" type="text/javascript"></script>
<script src="/jscripts/autoNumeric-1.7.5.js" type="text/javascript"></script>
<script src="/jscripts/jquery.uploadify.min.js" type="text/javascript"></script>
<script src="/jscripts/pdfobject.js" type="text/javascript"></script>
<script src="/jscripts/inputmask/jquery.inputmask.js" type="text/javascript"></script>
<script src="/jscripts/inputmask/jquery.inputmask.date.extensions.js" type="text/javascript"></script>

<!--Theme-->
<link href="/themes/rocket/jquery-wijmo.css" rel="stylesheet" type="text/css" title="rocket-jqueryui" />
<!--Wijmo Widgets CSS-->
<link href="/css/jquery.wijmo-complete.all.2.1.4.min.css" rel="stylesheet" type="text/css" />
<!--Application CSS-->
<link href="/css/style.css" rel="stylesheet" type="text/css" />
<link href="/css/wijmo-override.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="/css/uploadify.css">
  <!--[if IE 9]>
<link rel="stylesheet" type="text/css" href="/css/ie9.css" />
<![endif]--> 
<!--Wijmo Widgets JavaScript-->
<script src="/jscripts/jquery.wijmo-open.all.2.1.4.min.js" type="text/javascript"></script>
<script src="/jscripts/jquery.wijmo-complete.all.2.1.4.min.js" type="text/javascript"></script>
<!--Application JS -->
<script src="/jscripts/raps.js" type="text/javascript"></script>


</head>

<body>

<div id="container">
  <div id="header">
    <div id="logo"> <img src="/images/logo.png"></div>
    <div id="menucontainer">
    <cfoutput>
      <ul id="mainmenu">
        <li><a href="##">Clients</a>
          <ul>
            <li><a href="#buildUrl('main.search')#">Client Search</a></li>
            <li><a href="#buildUrl('main.client')#">New Client</a></li>
          </ul>
        </li>
        <li><a href="##">Documents</a>
          <ul>
          <cfloop query="rc.docs"><li><a href="/docs/#rc.docs.document_file#" target="_blank">#rc.docs.document_name#</a></li></cfloop>
          </ul>
        </li>
       
        <li><a href="##">Reports</a>
          <ul><li><a href="#buildUrl('reports.glSummary')#">General Liability Summary</a></li>
          <li><a href="#buildUrl('reports.propSummary')#">Property Summary</a></li>
          <li><a href="#buildUrl('reports.policyLabels')#">Policy Labels</a></li>
          <li><a href="#buildUrl('reports.mailingLabels&reportLayout=print')#" target="_blank">Client Mailing Labels</a></li>
          </ul>
        </li>
<cfif SESSION.auth.role is 1>         
        <li><a href="##">Admin</a>
          <ul>
          <li><a href="##">General System Admin</a>
          <ul>
            <li><a href="#buildUrl('main.users')#">RAPS Users</a></li>
            <li><a href="#buildUrl('main.documentAdmin')#">Document Admin</a></li>
            <li><a href="#buildUrl('main.proposalAdmin')#">Printing &amp; Proposals</a></li>
            <li><a href="#buildUrl('main.proposalAdminOrder')#">Proposal Order</a></li>
            <li><a href="#buildUrl('main.proposalListAdmin')#">Proposal Lists</a></li>
            </ul>
            </li>
            <li><a href="##">Client Admin</a>
            <ul>
            <li><a href="#buildUrl('main.conglomCodes')#">Conglom Codes</a></li>	
            <li><a href="#buildUrl('main.clientTypes')#">Entity Types</a></li>
            <li><a href="#buildUrl('main.requestedLimits')#">Requested Limits</a></li>
            <li><a href="#buildUrl('main.additionalLimits')#">Additional Limits</a></li>
            <li><a href="#buildUrl('main.employeeBenefits')#">Employee Rec Benefits</a></li>
            <li><a href="#buildUrl('main.clubLocated')#">Club Located In</a></li>
            <li><a href="#buildUrl('main.constructionTypes')#">Construction Types</a></li>
            <li><a href="#buildUrl('main.roofTypes')#">Roof Types</a></li>
            <li><a href="#buildUrl('main.policyTypes')#">Policy Types</a></li>
            <li><a href="#buildUrl('main.policyStatus')#">Policy Status</a></li>
            <li><a href="#buildUrl('main.terminationReasons')#">Termination Reasons</a></li>
            <li><a href="#buildUrl('main.niRelationships')#">NI Relationships</a></li>                        
            <li><a href="#buildUrl('main.epli')#">EPLI</a></li>
            </ul>
            </li>
            <li><a href="##">Rating</a>
            <ul>
            <li><a href="#buildUrl('main.liabilityPlans')#">Liability Plans</a></li>
            <li><a href="#buildUrl('main.propertyPlans')#">Property Plans</a></li>           
            <li><a href="#buildUrl('main.stateTaxes')#">State Taxes &amp; Surcharges</a></li>     
            <li><a href="#buildUrl('main.issuingCompanies')#">Parent/Issuing Companies</a></li>
            <li><a href="#buildUrl('main.cyberLiability')#">Cyber Liability</a></li>
            <li><a href="#buildUrl('main.employeeDishonesty')#">Employee Dishonesty</a></li>
            <li><a href="#buildUrl('main.glCredits')#">GL Credits/Debits</a></li>   
            </ul>
            </li>   
          </ul>
        </li>
</cfif>        
        <li><a href="##" style="cursor:text;">Welcome, #SESSION.auth.name#</a></li>
		<li><a id="logoutbutton" href="#buildUrl('login.logout')#">Logout</a>
          
        </li>
      </ul>
      </cfoutput>
    </div><!---End Menu Container--->
    <div style="clear:both"></div>
    <!---<div id="topsearch"><form action="#" id="cse-search-box">
    <input class="rounded" type="text" name="q" value="Search" onFocus="this.value==this.defaultValue?this.value='':null">
    <input type="image" src="/images/searchbutton.png" name="sa" style="height:30px; width:30px; margin:0; padding:0; float:left;" /></form>
    <img src="images/searchsettings.png" style="float:left;" class="togglesearch">
    </div>
  <div id="advancedsearch">Some stuff for advanced search</div>  --->   
  </div><!---End Header--->