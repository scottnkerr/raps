
  <div id="statusbar">
  <div id="pagename"><cfoutput>#rc.title#</cfoutput></div>
  <div id="statusstuff">  
  </div><!---End Statusstuff--->
  </div><!---End statusbar---> 
<cfset reporturl = 'index.cfm?event=reports.glSummary2&client_id='>
<cfinclude template="../common/reportsearch.cfm">