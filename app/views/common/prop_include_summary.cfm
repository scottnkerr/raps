<style>
body, p {font-size:12px !important;}
h2 {margin-top:15px;}
.tbl {background-color:#000; margin:15px 15px 0 0}
.tbl td,th,caption{background-color:#fff;}
td, th {font-size:12px; text-align:left;}
.tblcontainer td { vertical-align:top;}
.fullwidth { width:100%; }
table.fullwidth tr td:nth-child(2) {
	width:150px;
}
</style>
<cfoutput>
<h2>PREMIUM SUMMARY FOR ALL LOCATIONS AND COVERAGES</h2>
<b><p>INSURED: #client.entity_name#, #client.dba#</p></b>

<cfif rc.glpropchecked eq true>
    <!--- Liability Premium Summary --->
<table border="0" cellspacing="1" cellpadding="3" class="tbl fullwidth">
  <tr>
    <td style="font-weight:bold;" colspan="2">Liability Premium Summary</td>

  </tr>
  <cfif totals.totalglpremium gt 0>
  <tr>
    <td>Liability Premium</td>
    <td style="text-align:right; width:150px;">$#decimalFormat(totals.totalglpremium)#</td>
  </tr>
  </cfif>
  <cfif totals.totalglbroker gt 0>
  <tr>
    <td>Broker Fee</td>
    <td style="text-align:right;">$#decimalFormat(totals.totalglbroker)#</td>
  </tr>
  </cfif>
  <cfif totals.totalglinspection gt 0>
  <tr>
    <td>Inspection Fee</td>
    <td style="text-align:right;">$#decimalFormat(totals.totalglinspection)#</td>
  </tr>
  </cfif>
  <cfif totals.totalglsurplus gt 0>
  <tr>
    <td>Surplus Tax</td>
    <td style="text-align:right;">$#decimalFormat(totals.totalglsurplus)#</td>
  </tr>
  </cfif>
  <cfif totals.totalglstamping gt 0>
  <tr>
    <td>Stamping Fee</td>
    <td style="text-align:right;">$#decimalFormat(totals.totalglstamping)#</td>
  </tr>
  </cfif>
  <cfif totals.totalglfiling gt 0>
  <tr>
    <td>Filing Fee</td>
    <td style="text-align:right;">$#decimalFormat(totals.totalglfiling)#</td>
  </tr>  
  </cfif>
  <cfif totals.totalglrpg gt 0>
  <tr>
    <td>*RPG Fee</td>
    <td style="text-align:right;">$#decimalFormat(totals.totalglrpg)#</td>
  </tr>  
  </cfif>  
  <tr>
    <td>Terrorism Coverage</td>
    <td style="text-align:right"><cfif totals.totalglterrorism gt 0>$#decimalFormat(totals.totalglterrorism)#<cfelse>Not Included</cfif></td>
  </tr>
  <cfif totals.totalglstate gt 0>
  <tr>
    <td>State/Muni Surcharge</td>
    <td style="text-align:right;">$#decimalFormat(totals.totalglstate)#</td>
  </tr>
</cfif>
  <tr>
    <td >Liability Total</td>
    <td style="font-weight:bold; text-align:right;">$#decimalFormat(totals.totalgl)#</td>
  </tr>

</table>    

<!--- Property Premium Summary --->
<table border="0" cellspacing="1" cellpadding="3" class="tbl fullwidth">
  <tr>
    <td style="font-weight:bold;" colspan="2">Property Premium Summary</td>
  </tr>
  <tr>
    <td>Property Premium</td>
    <td style="text-align:right;">$#decimalFormat(totals.totalproppremium)#</td>
  </tr>
  <cfif totals.totalpropagencyfee gt 0>
  <tr>
    <td>Agency Fee</td>
    <td style="text-align:right; width:150px;">$#decimalFormat(totals.totalpropagencyfee)#</td>
  </tr>
  </cfif>
  <!---
  <cfif totals.totalpropempdis gt 0>
  <tr>
    <td>Employee Dishonesty</td>
    <td style="text-align:right;">$#decimalFormat(totals.totalpropempdis)#</td>
  </tr>
</cfif>--->
  <tr>
    <td>Terrorism Coverage</td>
    <td style="text-align:right">
<cfif totals.totalpropterrorism gt 0>$#decimalFormat(totals.totalpropterrorism)#<cfelse>Not Included</cfif></td>
  </tr>
  <cfif totals.totalproptaxes gt 0>
  <tr>
    <td>State Taxes</td>
    <td style="text-align:right;">$#decimalFormat(totals.totalproptaxes)#</td>
  </tr>
  </cfif>
  <tr>
    <td style="font-weight:bold;">Property Total</td>
    <td style="text-align:right; font-weight:bold;">$#decimalFormat(totals.totalprop)#</td>
  </tr>  

</table>
<!---
<table style="margin:5px 0 0 0;" class="fullwidth">
    <tr>
        <td style="font-weight:bold; font-size:14px;">TOTAL LIABILITY AND PROPERTY</td>
        <td style="text-align:right; font-weight:bold; font-size:14px; width:150px;">$#decimalFormat(grandtotal)#</td>
    </tr>

</table>
<table style="margin:5px 0;">
<tr><td colspan="2" style="font-weight:bold;">Optional Coverage: Terrorism</td></tr>
    <tr>
        <td>Liability Terrorism Premium</td>
        <td style="text-align:right;">$#decimalFormat(totalglterrorism)#</td>
    </tr>  
    <tr>
        <td>Property Terrorism Premium</td>
        <td style="text-align:right;">$#decimalFormat(totalpropterrorism)#</td>
    </tr>  
</table>--->
</cfif>
<cfif rc.wcchecked eq true>
<cfset totals.grandtotal = totals.grandtotal + val(client.wc_totalpremium)>

<table border="0" cellspacing="1" cellpadding="3" class="tbl fullwidth">
<tr><td colspan="2" style="font-weight:bold;">Workers Compensation Premium Summary</td></tr>
<cfif val(client.wc_premium) gt 0>
  <tr>
    <td align="left">Estimated Premium</td>
    <td style="text-align:right; width:150px">#dollarFormat(client.wc_premium)#</td>
  </tr>
</cfif>  
<cfif val(client.wc_agencyfee) gt 0>
  <tr>
    <td align="left">Agency Fee</td>
    <td style="text-align:right;">#dollarFormat(client.wc_agencyfee)#</td>
  </tr>
  </cfif>

  <tr>
    <td align="left" style="font-weight:bold;">Workers Compensation Total</td>
    <td style="text-align:right; font-weight:bold;">#dollarFormat(client.wc_totalpremium)#</td>
  </tr>
</table>
</cfif>
<cfif rc.uechecked eq true>
<cfset totals.grandtotal = totals.grandtotal + val(client.ue_totalpremium)>
<table class="tbl fullwidth" border="0" cellspacing="1" cellpadding="3">
<tr><td colspan="2" style="font-weight:bold;">Excess Liability Premium Summary</td></tr>
<cfif val(client.ue_premium) gt 0>
<tr>
<td>Premium</td>
<td style="text-align:right; width:150px">#dollarFormat(client.ue_premium)#</td>
</tr>
</cfif>
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
<td><b>Excess Liability Total</b></td>
<td style="text-align:right;"><b>#dollarFormat(client.ue_totalpremium)#</b></td>
</tr>
</table>
</cfif>
<cfif rc.eplichecked eq true>
<cfset totals.grandtotal = totals.grandtotal + val(client.epli_totalpremium)>

<table class="tbl fullwidth" border="0" cellspacing="1" cellpadding="3">
<tr><td colspan="2" style="font-weight:bold;">Employment Practices Liability Premium Summary</td></tr>
<cfif val(client.epli_premium) gt 0>
<tr>
<td>Premium</td>
<td style="text-align:right; width:150px;">#dollarFormat(client.epli_premium)#</td>
</tr>
</cfif>
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
<td><b>Employment Practices Liability Total</b></td>
<td style="text-align:right;"><b>#dollarFormat(client.epli_totalpremium)#</b></td>
</tr>
</table>
</cfif>
<!---Other 1 --->
<cfif rc.otherchecked eq true>
<cfset totals.grandtotal = totals.grandtotal + val(client.other_totalpremium)>

<table class="tbl fullwidth" border="0" cellspacing="1" cellpadding="3">
<tr><td colspan="2" style="font-weight:bold;">#client.other_policy# Premium Summary</td></tr>
  <tr>
    <th scope="row" align="left">Estimated Premium</th>
    <td style="text-align:right;">#dollarFormat(client.other_premium)#</td>
  </tr>
<cfif val(client.other_brokerfee) gt 0>  
  <tr>
    <th scope="row" align="left">Broker Fee</th>
    <td style="text-align:right;">#dollarFormat(client.other_brokerfee)#</td>
  </tr>
</cfif>  
<cfif val(client.other_agencyfee) gt 0>  
  <tr>
    <th scope="row" align="left">Agency Fee</th>
    <td style="text-align:right;">#dollarFormat(client.other_agencyfee)#</td>
  </tr>
</cfif>
<cfif val(client.other_tax) gt 0>  
  <tr>
    <th scope="row" align="left">Tax/Surcharge</th>
    <td style="text-align:right;">#dollarFormat(client.other_tax)#</td>
  </tr>
</cfif>
<cfif val(client.other_filingfee) gt 0>  
  <tr>
    <th scope="row" align="left">Filing Fee</th>
    <td style="text-align:right;">#dollarFormat(client.other_filingfee)#</td>
  </tr>
</cfif> 
<cfif val(client.other_rpgfee) gt 0>  
  <tr>
    <th scope="row" align="left">RPG Fee</th>
    <td style="text-align:right;">#dollarFormat(client.other_rpgfee)#</td>
  </tr>
</cfif>
  <tr>
    <th scope="row" align="left">Total Premium and Fees</th>
    <td style="text-align:right; font-weight:bold;">#dollarFormat(client.other_totalpremium)#</td>
  </tr>
</table>
</cfif>
<!---Other 2 --->
<cfif rc.otherchecked2 eq true>
<cfset totals.grandtotal = totals.grandtotal + val(client.other2_totalpremium)>

<table class="tbl fullwidth" border="0" cellspacing="1" cellpadding="3">
<tr><td colspan="2" style="font-weight:bold;">#client.other2_policy# Premium Summary</td></tr>
  <tr>
    <th scope="row" align="left">Estimated Premium</th>
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
</cfif>
<!---Other 3 --->
<cfif rc.otherchecked3 eq true>
<cfset totals.grandtotal = totals.grandtotal + val(client.other3_totalpremium)>

<table class="tbl fullwidth" border="0" cellspacing="1" cellpadding="3">
<tr><td colspan="2" style="font-weight:bold;">#client.other3_policy# Premium Summary</td></tr>
  <tr>
    <th scope="row" align="left">Estimated Premium</th>
    <td style="text-align:right;">#dollarFormat(client.other3_premium)#</td>
  </tr>
<cfif val(client.other3_brokerfee) gt 0>  
  <tr>
    <th scope="row" align="left">Broker Fee</th>
    <td style="text-align:right;">#dollarFormat(client.other3_brokerfee)#</td>
  </tr>
</cfif>  
<cfif val(client.other3_agencyfee) gt 0>  
  <tr>
    <th scope="row" align="left">Agency Fee</th>
    <td style="text-align:right;">#dollarFormat(client.other3_agencyfee)#</td>
  </tr>
</cfif>
<cfif val(client.other3_tax) gt 0>  
  <tr>
    <th scope="row" align="left">Tax/Surcharge</th>
    <td style="text-align:right;">#dollarFormat(client.other3_tax)#</td>
  </tr>
</cfif>
<cfif val(client.other3_filingfee) gt 0>  
  <tr>
    <th scope="row" align="left">Filing Fee</th>
    <td style="text-align:right;">#dollarFormat(client.other3_filingfee)#</td>
  </tr>
</cfif> 
<cfif val(client.other3_rpgfee) gt 0>  
  <tr>
    <th scope="row" align="left">RPG Fee</th>
    <td style="text-align:right;">#dollarFormat(client.other3_rpgfee)#</td>
  </tr>
</cfif>
  <tr>
    <th scope="row" align="left">Total Premium and Fees</th>
    <td style="text-align:right; font-weight:bold;">#dollarFormat(client.other3_totalpremium)#</td>
  </tr>
</table>
</cfif>
<table class="fullwidth" style="margin-top:15px;">
<tr><td><h3>GRAND TOTAL</h3></td><td style="width:150px; text-align:right; font-weight:bold;">#dollarformat(totals.grandtotal)#</td></tr>
</table>

<cfset pagebreak = '<p style="page-break-after: always !important; padding:0, margin:0; line-height:0; height:0; overflow:hidden;">&nbsp;</p>'>
#replacenocase(replacenocase(rc.thiscontent,"[PAGE_BREAK]", pagebreak, "ALL"),'[RANDY_SIG]','<img src="/images/testsig2.gif" height="75" width="200">','ALL')#


</cfoutput>

