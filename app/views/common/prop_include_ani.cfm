
<style>
body, p {font-size:12px !important;}
h2 {margin-top:15px;}
.tbl {background-color:#000;}
.tbl td,th,caption{background-color:#fff;}
td, th {font-size:12px;}
</style>

<cfoutput>
<h2>COMPLETE NAMED INSURED</h2>
<p><b>FIRST NAMED INSURED</b></p>
<p>#client.entity_name#</p>
<p>dba #client.dba#</p>
<br>
<p><b>ADDITIONAL NAMED INSUREDS</b></p>
<cfloop query="ani">
<p>#ani.named_insured#</p>
</cfloop>
<br />
<cfset pagebreak = '<p style="page-break-after: always !important; padding:0, margin:0; line-height:0; height:0; overflow:hidden;">&nbsp;</p>'>
#replacenocase(replacenocase(rc.thiscontent,"[PAGE_BREAK]", pagebreak, "ALL"),'[RANDY_SIG]','<img src="/images/testsig2.gif" height="75" width="200">','ALL')#


</cfoutput>