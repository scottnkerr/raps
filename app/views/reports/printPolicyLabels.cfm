<!---<cfloop query="rc.reportQuery" startrow="16" endrow="50">
<cfset fieldlist = "GLRENEWAL,PROPRENEWAL,EPLRENEWAL,UMBRENEWAL,EXCESSRENEWAL,WCRENEWAL,BONDRENEWAL,QUAKERENEWAL,FLOODRENEWAL">
<cfoutput>Row: #rc.reportQuery.currentrow#, Client ID: #client_id#<br></cfoutput>
	<cfset origdate = "">
    <cfset duplist = "">
    <cfloop from="1" to="#listlen(fieldlist)#" index="i">
    	<cfset thisfield = listgetat(fieldlist,i)>
     	<cfset thisdate = rc.reportQuery["#thisfield#"][rc.reportQuery.currentrow]>
        <cfif thisdate neq '' and thisdate neq origdate>

        <cfoutput>#thisfield# - #thisdate#<br></cfoutput>
    </cfloop>
    <hr>
</cfloop>--->
<cfreport template="RapsPolicyLabels.cfr" format="PDF" query="#rc.reportQuery#"> 
</cfreport>
<!---<cfoutput>
<!---<cfdump var="#rc.data#">--->
<cfloop from="1" to="#arrayLen(rc.data)#" index="i">
<ul class="printPolicyLabels">
<cfset ams = rc.data[i][3]>
<cfset code = rc.data[i][2]>
<cfif trim(rc.data[i][4]) neq ''>
<cfset am = rc.data[i][4]>
<cfelse>
<cfset am = "SK">
</cfif>
<cfset en = rc.data[i][1]>
<cfset qdata = rc.data[i][5]>
<cfif qdata.recordcount>
<li>
<ul class="companyinfo">
	<li class="ppcol1">#ams#</li>
    <li class="ppcol2">#code#</li>
    <li class="ppcol3">#am#</li>
    <li class="clear plain">#en#</li>
</ul>
<ul class="policies">
<cfloop query="qdata">
<li class="ppcol1">#qdata.policy_expiredate#</li>
<li class="ppcol2">#qdata.policy_type#</li>
<li class="ppcol3">#qdata.policy_number#</li>
</cfloop>
<div class="clear"></div>
</ul>
</li>
<div class="clear"></div>
</cfif>
</ul>  
</cfloop>
  
<div class="clear"></div>    
</cfoutput>--->