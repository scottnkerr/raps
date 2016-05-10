
<style>
body, p {font-size:12px !important;}
h2 {margin-top:15px;}
.tbl {background-color:#000;}
.tbl td,th,caption{background-color:#fff;}
td, th {font-size:12px; text-align:left;}

</style>
<cfoutput>
<h2><cfif client.ue_type eq 'excess'>EXCESS LIABILITY<cfelse>UMBRELLA</cfif> PROPOSAL</h2>
<b><p>INSURED: #client.entity_name#&nbsp;&nbsp;&nbsp;DBA: #client.dba#</p>
<p>UNDERWRITTEN BY: #ueissuing.name#</p>
<cfif not dateFormat(client.ue_date1,'mm/dd/yyyy') eq "1/1/1900">
<cfset ueeffdate = dateFormat(client.ue_date1,'mm/dd/yyyy')>
<cfelse>
<cfset ueeffdate = "">
</cfif>
<cfif not dateFormat(client.ue_date2,'mm/dd/yyyy') eq "1/1/1900">
<cfset ueexpdate = dateFormat(client.ue_date2,'mm/dd/yyyy')>
<cfelse>
<cfset ueexpdate = "">
</cfif>
<p>Effective Date #ueeffdate#&nbsp;&nbsp;&nbsp;&nbsp; Expiration Date: #ueexpdate#</p>
</b>
<table style="width:100%" border="0" cellpadding="0" cellspacing="0">
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
<td>$#numberFormat(client.ue_retention,',')#</td>
</tr>
<tr>
<td><cfif client.ue_type eq 'excess'>Excess Liability<cfelse>Umbrella</cfif></td>
<td>$#numberFormat(client.ue_occurrence,',')# Each Occurrence</td>
</tr>

<tr>
<td>&nbsp;</td>
<td>$#numberFormat(client.ue_aggregate,',')# Annual Aggregate</td>
</tr>

</table>
<br /><br />
<table class="tbl" border="0" cellspacing="1" cellpadding="5">
<!---
<tr>
<td>Rate SL Tax</td>
<td>#client.ue_rate_sltax#</td>
</tr>
<tr>
<td>Filing Fee</td>
<td>#client.ue_rate_filingfee#</td>
</tr>
<tr>
<td>Stamping Fee</td>
<td>#client.ue_rate_stampingfee#</td>
</tr>
<tr>
<td>State Surcharge</td>
<td>#client.ue_rate_statesurcharge#</td>
</tr>
<tr>
<td>Muni Surcharge</td>
<td>#client.ue_rate_munisurcharge#</td>
</tr>--->
<tr>
<td>Premium</td>
<td style="text-align:right;">#dollarFormat(client.ue_premium)#</td>
</tr>
<cfif val(client.ue_terrorism_rejected) eq 0 and val(client.ue_terrorism_fee) gt 0>
<tr>
<td>Terrorism Fee</td>
<td style="text-align:right;">#dollarFormat(client.ue_terrorism_fee)#</td>
</tr>
</cfif>
<cfif val(client.ue_sltax) gt 0>
<tr>
<td>Surplus Tax/Surcharge</td>
<td style="text-align:right;">#dollarFormat(client.ue_sltax)#</td>
</tr>
</cfif>
<cfif val(client.ue_stampingfee) gt 0>
<tr>
<td>Stamping Fee</td>
<td style="text-align:right;">#dollarFormat(client.ue_stampingfee)#</td>
</tr>
</cfif>
<cfif val(client.ue_filingfee) gt 0>
<tr>
<td>Filing Fee</td>
<td style="text-align:right;">#dollarFormat(client.ue_filingfee)#</td>
</tr>
</cfif>
<cfif val(client.ue_brokerfee) gt 0>
<tr>
<td>Broker Fee</td>
<td style="text-align:right;">#dollarFormat(client.ue_brokerfee)#</td>
</tr>
</cfif>
<cfif val(client.ue_agencyfee) gt 0>
<tr>
<td>Agency/RPG Fee</td>
<td style="text-align:right;">#dollarFormat(client.ue_agencyfee)#</td>
</tr>
</cfif>
<tr>
<td><b>Total</b></td>
<td style="text-align:right;"><b>#dollarFormat(client.ue_totalpremium)#</b></td>
</tr>
</table>
<br /><br />
<cfif excessconsolidated.recordcount>
<cfset consolidatedlist = valuelist(excessconsolidated.entity_name)>
<b>This quote includes the following entities: #ucase(consolidatedlist)#</b>
<br /><br />
</cfif>

<cfif trim(client.ue_proposalnotes) neq ''>
Notes: #paragraphFormat(client.ue_proposalnotes)#
<br /><br />
</cfif>
<cfset pagebreak = '<p style="page-break-after: always !important; padding:0, margin:0; line-height:0; height:0; overflow:hidden;">&nbsp;</p>'>
#replacenocase(replacenocase(rc.thiscontent,"[PAGE_BREAK]", pagebreak, "ALL"),'[RANDY_SIG]','<img src="/images/testsig2.gif" height="75" width="200">','ALL')#
</cfoutput>