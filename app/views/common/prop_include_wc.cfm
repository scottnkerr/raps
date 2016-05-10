
<style>
body, p {font-size:12px !important;}
h2 {margin-top:15px;}
.tbl {background-color:#000;}
.tbl td,th,caption{background-color:#fff;}
td, th {font-size:12px;}
</style>

<cfoutput>
<h2>WORKERS' COMPENSATION COVERAGE PROPOSAL</h2>
<b><p>INSURED: #client.entity_name#&nbsp;&nbsp;&nbsp;DBA: #client.dba#</p>
<p>UNDERWRITTEN BY: #wcissuing.name#</p>
<cfif not dateFormat(client.wc_effectivedate,'mm/dd/yyyy') eq "1/1/1900">
<cfset wceffdate = dateFormat(client.wc_effectivedate,'mm/dd/yyyy')>
<cfelse>
<cfset wceffdate = "">
</cfif>
<cfif not dateFormat(client.wc_expiredate,'mm/dd/yyyy') eq "1/1/1900">
<cfset wcexpdate = dateFormat(client.wc_expiredate,'mm/dd/yyyy')>
<cfelse>
<cfset wcexpdate = "">
</cfif>
<p>Effective Date: #wceffdate#&nbsp;&nbsp;&nbsp;&nbsp; Expiration Date: #wcexpdate#</p></b>

<p style="font-size:16px; font-weight:bold;">
EIN: <cfif trim(client.wc_fein) neq ''>#client.wc_fein#<cfelse><span style="text-decoration:underline;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></cfif>
</p>
</span>
<table border="0" width="300" cellspacing="2" cellpadding="0" style="margin-bottom:15px;">
	<tr>
  <th style="text-align:left;">Class Code</th>
  <th style="text-align:left;">Description</th>
  <th style="text-align:left;">Rate</th>
  <th style="text-align:left;">Payroll</th>
  </tr>
  <tr>
  <td style="text-align:left;">#client.wc_classcode#</td>
  <td style="text-align:left;">#client.wc_classcode_desc#</td>
  <td style="text-align:left;">#client.wc_rate#</td>
  <td style="text-align:left;">$#numberFormat(client.wc_paybasis,',')#</td>
  </tr>
  <tr>
  <td style="text-align:left;">#client.wc_classcode2#</td>
  <td style="text-align:left;">#client.wc_classcode_desc2#</td>
  <td style="text-align:left;">#client.wc_rate2#</td>
  <td style="text-align:left;">$#numberFormat(client.wc_paybasis2,',')#</td>
  </tr>  
  <tr>
  <td style="text-align:left;" colspan="2">Based on Total Payroll of:</td>
  <td style="text-align:left;">$#numberFormat(client.wc_payroll,',')#</td>
  </tr>  
  </table>
<table width="400" border="0" cellspacing="1" cellpadding="5" class="tbl">
  <tr>
    <th scope="row" align="left">Estimated Premium</th>
    <td style="text-align:right;">#dollarFormat(client.wc_premium)#</td>
  </tr>
<cfif val(client.wc_agencyfee) gt 0>  
  <tr>
    <th scope="row" align="left">Agency Fee</th>
    <td style="text-align:right;">#dollarFormat(client.wc_agencyfee)#</td>
  </tr>
</cfif>
  
  <tr>
    <th scope="row" align="left">Total Premium and Fees</th>
    <td style="text-align:right;">#dollarFormat(client.wc_totalpremium)#</td>
  </tr>
</table>
<p>&nbsp;</p>
<p><b>Employer's Liability Policy Limits (Higher Limits May Be Available)</b></p>
<table width="400" border="0" cellspacing="0" cellpadding="5">
  <tr>
    <td>Each Accident</td>
    <td style="text-align:right;">$1,000,000</td>
  </tr>
  <tr>
    <td>Disease Per Employee</td>
    <td style="text-align:right;">$1,000,000</td>
  </tr>
  <tr>
    <td>Disease Policy Limit</td>
    <td style="text-align:right;">$1,000,000</td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="1" cellpadding="4" class="tbl" style="margin:20px 0">
  <tr>
    <td style="font-size:10px">Owner/Partner/Officer Name</td>
    <td style="font-size:10px">Title</td>
    <td style="font-size:10px">% Ownership</td>
    <td style="font-size:10px">Include</td>
    <td style="font-size:10px">Exclude</td>
    <td style="font-size:10px">Salary if Coverage Included</td>
  </tr>
  <cfset totalpercent = 0>
  <cfloop query="wc">
  <cfset totalpercent = totalpercent + owner_percent>
  <tr>
    <td>#owner_name#</td>
    <td>#owner_title#</td>
    <td>#numberFormat(owner_percent,',')#%</td>
    <td style="text-align:center; padding:0px;"><input type="checkbox"<cfif owner_include is 1> checked="checked"</cfif>></td>
    <td style="text-align:center; padding:0px;"><input type="checkbox"<cfif owner_exclude is 1> checked="checked"</cfif>></td>
    <td style="text-align:right; padding:0px;"><cfif val(owner_salary) neq 0>#dollarformat(val(owner_salary))#</cfif></td>
  </tr>
  </cfloop>
  <tr>
  <td colspan="2" style="text-align:right;">TOTAL:</td>
  <td colspan="4">#numberFormat(totalpercent,',')#%</td>
  </tr>
</table>
<cfif wcconsolidated.recordcount>
<cfset consolidatedlist = valuelist(wcconsolidated.entity_name)>
<p>
<b>This quote includes the following entities: #ucase(consolidatedlist)#</b>
</p>
</cfif>
<cfif trim(client.wc_proposalnotes) neq ''>
<p>#paragraphFormat(client.wc_proposalnotes)#</p>
</cfif>
<!---
<p><b>Your state will exclude owners and officers unless they are specifically included by name, title, salary and % ownership and listed on the policy. Whether or not you elect coverage for owners/officers (as allowed by your state), we must have complete information regarding all qualifying individuals. If information above is incomplete or incorrect, please update and return to this office prior to binding coverage.</b></p>
<p>Optional Coverage: Voluntary Compensation can be included for approximately five percent of premium where allowed by state statute. Please let your Account Manager know if you'd like to include this coverage.</p>
<p>Note: Workers' Compensation coverage may be subject to state specific laws which may supersede policy forms.</p>
<p>Workers' Compensation policies are subject to audit. Should your audit result in additional premium premium is due upon receipt of audit billing.</p>--->
<cfset pagebreak = '<p style="page-break-after: always !important; padding:0, margin:0; line-height:0; height:0; overflow:hidden;">&nbsp;</p>'>
#replacenocase(replacenocase(rc.thiscontent,"[PAGE_BREAK]", pagebreak, "ALL"),'[RANDY_SIG]','<img src="/images/testsig2.gif" height="75" width="200">','ALL')#


</cfoutput>