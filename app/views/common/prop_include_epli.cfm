
<style>
body, p {font-size:12px !important;}
h2 {margin-top:15px;}
.tbl {background-color:#000;}
.tbl td,th,caption{background-color:#fff;}
td, th {font-size:12px; text-align:left;}

</style>
<cfoutput>
<h2>EMPLOYMENT PRACTICES LIABILITY PROPOSAL</h2>
<b><p>INSURED: #client.entity_name#&nbsp;&nbsp;&nbsp;DBA: #client.dba#</p>
<p>UNDERWRITTEN BY: #epliissuing.name#</p>

<cfif not dateFormat(client.epli_date1,'mm/dd/yyyy') eq "1/1/1900">
<cfset eplieffdate = dateFormat(client.epli_date1,'mm/dd/yyyy')>
<cfelse>
<cfset eplieffdate = "">
</cfif>
<cfif not dateFormat(client.epli_date2,'mm/dd/yyyy') eq "1/1/1900">
<cfset epliexpdate = dateFormat(client.epli_date2,'mm/dd/yyyy')>
<cfelse>
<cfset epliexpdate = "">
</cfif>
<cfif not dateFormat(client.epli_retrodate,'mm/dd/yyyy') eq "1/1/1900">
<cfset epliretrodate = dateFormat(client.epli_retrodate,'mm/dd/yyyy')>
<cfelse>
<cfset epliretrodate = "">
</cfif>
<p>Effective Date #eplieffdate#&nbsp;&nbsp;&nbsp;&nbsp; Expiration Date: #epliexpdate#</p>
<cfif client.epli_prioracts neq 1><p>Retro Date: #epliretrodate#</p></cfif>

</b>
<table style="width:100%; margin-top:15px;" border="0" cellpadding="0" cellspacing="0">
<tr>
<th style="padding-left:0;">COVERAGE</th>
<th>LIMIT</th>

</tr>
<tr>
<td colspan="2" style="height:1px; background-color:black; overflow:hidden;">&nbsp;</td>
</tr>
<tr>
<td colspan="2" style="height:6px; overflow:hidden;">&nbsp;</td>
</tr>
<tr>
<td>Retention</td>
<td>$#numberFormat(client.epli_retention,',')#</td>
</tr>
<tr>
<td>Coverage Limit</td>
<td>$#numberFormat(client.epli_aggregate,',')# Annual Aggregate</td>
</tr>


<tr>
<td colspan="2" style="height:15px; overflow:hidden;">&nbsp;</td>
</tr>
<tr>
<td colspan="2"><input type="checkbox" <cfif client.epli_doincluded is 1>checked="checked"</cfif>> Directors and Officers Coverage Provided (if checked)</td>
</tr>
<tr>
<td>Coverage Limit</td>
<td>$#numberFormat(client.epli_aggregate2,',')# Annual Aggregate</td>
</tr>
<tr>
<td>Retention</td>
<td>$#numberFormat(client.epli_retention2,',')#</td>
</tr>
</table>
<br /><br />
<table class="tbl" border="0" cellspacing="1" cellpadding="5">

<tr>
<td>Premium</td>
<td style="text-align:right;">#dollarFormat(client.epli_premium)#</td>
</tr>
<cfif val(client.epli_sltax) gt 0>
<tr>
<td>Surplus Tax/Surcharge</td>
<td style="text-align:right;">#dollarFormat(client.epli_sltax)#</td>
</tr>
</cfif>
<cfif val(client.epli_filingfee) gt 0>
<tr>
<td>Filing Fee</td>
<td style="text-align:right;">#dollarFormat(client.epli_filingfee)#</td>
</tr>
</cfif>
<cfif val(client.epli_brokerfee) gt 0>
<tr>
<td>Broker Fee</td>
<td style="text-align:right;">#dollarFormat(client.epli_brokerfee)#</td>
</tr>
</cfif>
<cfif val(client.epli_agencyfee) gt 0>
<tr>
<td>Agency/RPG Fee</td>
<td style="text-align:right;">#dollarFormat(client.epli_agencyfee)#</td>
</tr>
</cfif>

<tr>
<td><b>Total</b></td>
<td style="text-align:right;"><b>#dollarFormat(client.epli_totalpremium)#</b></td>
</tr>
</table>
<br /><br />
<cfif epliconsolidated.recordcount>
<cfset consolidatedlist = valuelist(epliconsolidated.entity_name)>
<b>This quote includes the following entities: #ucase(consolidatedlist)#</b>
<br /><br />
</cfif>
<cfif trim(client.epli_proposalnotes) neq ''>
Notes: #paragraphFormat(client.epli_proposalnotes)#
<br /><br />
</cfif>

<cfset pagebreak = '<p style="page-break-after: always !important; padding:0, margin:0; line-height:0; height:0; overflow:hidden;">&nbsp;</p>'>
#replacenocase(replacenocase(rc.thiscontent,"[PAGE_BREAK]", pagebreak, "ALL"),'[RANDY_SIG]','<img src="/images/testsig2.gif" height="75" width="200">','ALL')#
<cfif client.epli_prioracts eq 1><p><p>Coverage includes Full Prior Acts</p></p></cfif>

</cfoutput>