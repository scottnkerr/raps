
<cfif isDefined("FORM.sort_serialized")>
<cfset IDList = ReReplaceNoCase(FORM.sort_serialized, "(&){0,1}section_id\[\]=", ",", "all") />

</cfif>
<script>
$(document).ready(function() {
	
});
//end document.ready

</script>
<cfdump var="#form#">
<div id="statusbar">
  <div id="pagename">Proposal Creation</div>
  <div id="statusstuff"> </div>
  <!---End Statusstuff--->
</div>
<!---End statusbar--->
<cfdocument format="pdf" unit="in" margintop=".25" name="proposalpdf" localurl="true" filename="c:\FitnessProposal.pdf" overwrite="yes">
<cfoutput>
<html>
<body style="position: relative; font-family:'Times New Roman', Times, serif; font-size:10px; line-height:13px;">
<!---
<cfloop from="1" to="#arraylen(rc.docarray)#" index="i">
<cfset id = rc.docarray[i][1]>
<cfset name = rc.docarray[i][2]>
<cfset content = rc.docarray[i][3]>
<cfset include = rc.docarray[i][4]>
<cfset docfile = rc.docarray[i][5]>



<ul>
<li>#id#</li>
<li>#name#</li>
<li>#content#</li>
<li>#include#</li>
<li>#docfile#</li>
</ul>
<cfif i lt arraylen(rc.docarray)>
<cfdocumentitem type="pagebreak" />
</cfif>
</cfloop>--->
</body>
</html>
</cfoutput>
</cfdocument>

