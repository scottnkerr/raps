
<style>
body, p {font-size:12px !important;}
h2 {margin-top:15px;}
.tbl {background-color:#000;}
.tbl td,th,caption{background-color:#fff;}
td, th {font-size:12px;}
</style>

<cfoutput>
<h2>#ucase(client.other2_policy)# COVERAGE PROPOSAL</h2>
<b><p>INSURED: #client.entity_name#&nbsp;&nbsp;&nbsp;DBA: #client.dba#</p>
<p>UNDERWRITTEN BY: #other2issuing.name#</p>
<cfif not dateFormat(client.other2_effectivedate,'mm/dd/yyyy') eq "1/1/1900">
<cfset othereffdate = dateFormat(client.other2_effectivedate,'mm/dd/yyyy')>
<cfelse>
<cfset othereffdate = "">
</cfif>
<cfif not dateFormat(client.other2_expiredate,'mm/dd/yyyy') eq "1/1/1900">
<cfset otherexpdate = dateFormat(client.other2_expiredate,'mm/dd/yyyy')>
<cfelse>
<cfset otherexpdate = "">
</cfif>
<p>Effective Date: #othereffdate#&nbsp;&nbsp;&nbsp;&nbsp; Expiration Date: #otherexpdate#</p></b>


<table width="400" border="0" cellspacing="1" cellpadding="5" class="tbl">
  <tr>
    <th scope="row" align="left">Premium</th>
    <td style="text-align:right;">#dollarFormat(client.other2_premium)#</td>
  </tr>
<cfif val(client.other2_brokerfee) gt 0>  
  <tr>
    <th scope="row" align="left">Broker Fee</th>
    <td style="text-align:right;">#dollarFormat(client.other2_brokerfee)#</td>
  </tr>
</cfif>  
<cfif val(client.other2_agencyfee) gt 0>  
  <tr>
    <th scope="row" align="left">Agency Fee</th>
    <td style="text-align:right;">#dollarFormat(client.other2_agencyfee)#</td>
  </tr>
</cfif>
<cfif val(client.other2_tax) gt 0>  
  <tr>
    <th scope="row" align="left">Tax/Surcharge</th>
    <td style="text-align:right;">#dollarFormat(client.other2_tax)#</td>
  </tr>
</cfif>
<cfif val(client.other2_filingfee) gt 0>  
  <tr>
    <th scope="row" align="left">Filing Fee</th>
    <td style="text-align:right;">#dollarFormat(client.other2_filingfee)#</td>
  </tr>
</cfif>  
<cfif val(client.other2_rpgfee) gt 0>  
  <tr>
    <th scope="row" align="left">RPG Fee</th>
    <td style="text-align:right;">#dollarFormat(client.other2_rpgfee)#</td>
  </tr>
</cfif> 
  <tr>
    <th scope="row" align="left">Total Premium and Fees</th>
    <td style="text-align:right; font-weight:bold;">#dollarFormat(client.other2_totalpremium)#</td>
  </tr>
</table>
<p>&nbsp;</p>
<p><b>#client.other2_policy# Limits (Higher Limits May Be Available)</b></p>
<table width="400" border="0" cellspacing="0" cellpadding="5">
<cfloop query="other2coverages">
  <tr>
    <td>#other2coverages.loc_desc#</td>
    <td style="text-align:right;">#other2coverages.loc_amount#</td>
  </tr>
</cfloop>
  <tr>
    <td>#client.other2_dedret#</td>
    <td style="text-align:right;">#dollarFormat(client.other2_dedretamount)#</td>
  </tr>  
</table>

<cfif trim(client.other2_proposalnotes) neq ''>
<p>#paragraphFormat(client.other2_proposalnotes)#</p>
</cfif>

<cfset pagebreak = '<p style="page-break-after: always !important; padding:0, margin:0; line-height:0; height:0; overflow:hidden;">&nbsp;</p>'>
#replacenocase(replacenocase(rc.thiscontent,"[PAGE_BREAK]", pagebreak, "ALL"),'[RANDY_SIG]','<img src="/images/testsig2.gif" height="75" width="200">','ALL')#


</cfoutput>