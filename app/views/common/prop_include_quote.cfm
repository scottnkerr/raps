<style>
body, p {font-size:12px !important;}
h2 {margin-top:10px;}
.tblcontainer td { vertical-align:top;}
.tbl {background-color:#000; margin:5px 15px 0 0 !important}
.tbl td,th,caption{background-color:#fff; vertical-align:middle; padding:3px 3px 1px;}
td, th {font-size:12px; text-align:left; line-height:12px;}

</style>

<cfoutput>
<h2>LIABILITY AND PROPERTY PROPOSAL - Loc## #locations.location_number#</h2>
<!---<h3>Rating ID: #rating.ratingid#</h3>--->
<b><p>INSURED: #client.entity_name#, DBA: #client.dba#</p></b>

<h><b>#locations.named_insured#&nbsp;&nbsp;&nbsp;#locations.address#, #locations.city#, #locations.statename# #locations.zip#<!---&nbsp;&nbsp;&nbsp;DBA Location: #locations.dba#---></b></p>




<table border="0" cellspacing="0" cellpadding="0" class="tblcontainer" style="width:700px; margin:10px 0 0 0">
<tr>
<td>Liability Effective #dateFormat(rating.gldate1,'mm/dd/yyyy')# - #dateFormat(rating.gldate2,'mm/dd/yyyy')#</td>
<td>Property Effective #dateFormat(rating.propdate1,'mm/dd/yyyy')# - #dateFormat(rating.propdate2,'mm/dd/yyyy')#</td>
</tr>
<cfif len(locations.description)><tr><td colspan="2">Description: #locations.description#</td></tr></cfif>
  <tr>
    <td>Liability Insurance Carrier: #rating.glissuing#</td>
    <td>Property Insurance Carrier: #rating.propissuing#</td>
  </tr>
<tr>
	<td>
    <!--- Liability Coverage Limits --->
<table border="0" cellspacing="1" cellpadding="0" class="tbl" width="350">
  <tr>
    <td style="font-weight:bold;" colspan="2">Liability Coverage and Limits</td>
  </tr>
  <tr>
    <td>Each Occurrence</td>
    <td style="text-align:right;">#rating.csl_each#</td>
  </tr>
  <tr>
    <td>General Aggregate</td>
    <td style="text-align:right;">#rating.csl_aggregate#</td>
  </tr>
  <tr>
    <td>Products/Completed Operations Aggregate</td>
    <td style="text-align:right;">#rating.csl_products#</td>
  </tr>  
  <tr>
    <td>Personal and Advertising Injury</td>
    <td style="text-align:right;">#rating.personal_advertising_injury#</td>
  </tr>
  <cfif rating.hide_gl neq 1>
  <tr>
    <td>Fire Damage Liability</td>
    <td style="text-align:right;">#rating.fire_damage_legal#</td>
  </tr>
  <tr>
    <td>Medical Expense Liability</td>
    <td style="text-align:right;">#rating.med_pay_per_person#</td>
  </tr>

  <tr>
    <td>Professional Liability</td>
    <td style="text-align:right;">#rating.professional_liability#</td>
  </tr>  
  <tr>
    <td>Tanning Liability</td>
    <td style="text-align:right;">#rating.tanning_bed_liability#</td>
  </tr>
  <tr>
    <td>Hired Auto Liability</td>
    <td style="text-align:right;">#rating.hired_auto_liability#</td>
  </tr>
  <tr>
    <td>Non-Owned Auto Liability</td>
    <td style="text-align:right;">#rating.non_owned_auto_liability#</td>
  </tr>
  <cfif val(rating.gl_deductable) gt 0>
  <cfset glded = "$#numberFormat(rating.gl_deductable,',')#">
  <cfelse>
  <cfset glded = rating.policy_deductible>
  </cfif>
  <tr>
    <td>Policy Deductible</td>
    <td style="text-align:right;">#glded#</td>
  </tr>
  <tr>
    <td>Sexual Abuse or Molestation Per Occurrence</td>
    <td style="text-align:right;">#rating.sex_abuse_occ#</td>
  </tr>
  <tr>
    <td>Sexual Abuse or Molestation Aggregate</td>
    <td style="text-align:right;">#rating.sex_abuse_agg#</td>
  </tr>  
</cfif>
</table>    
    </td>
<td>
<!--- Property Coverage Limits --->
<table border="0" cellspacing="1" cellpadding="0" class="tbl" width="350">
  <tr>
    <td colspan="2" style="font-weight:bold;">Property Coverage, Limits, Deductibles</td>

  </tr>
  <tr>
    <td>Building</td>
    <td style="text-align:right;"><cfif val(rating.prop_buildinglimit) neq 0>$#numberFormat(rating.prop_buildinglimit,',')#<cfelse>No Coverage</cfif></td>
  </tr>
  <cfset bpp = val(rating.prop_bpplimit) + val(rating.prop_tilimit)>
  <tr>
    <td>Business Personal Property</td>
    <td style="text-align:right;"><cfif bpp neq 0>$#numberFormat(bpp,',')#<cfelse>No Coverage</cfif></td>
  </tr>
<!---
  <tr>
    <td>Tenant Improvements</td>
    <td style="text-align:right;"><cfif val(rating.prop_tilimit) neq 0>$#numberFormat(rating.prop_tilimit,',')#<cfelse>No Coverage</cfif></td>
  </tr>--->
  <tr>
    <td>Business Income</td>
    <td style="text-align:right;"><cfif val(rating.prop_bieelimit) neq 0>$#numberFormat(rating.prop_bieelimit,',')#<cfelse>No Coverage</cfif></td>
  </tr style="text-align:right;">  
  <cfif rating.hide_prop neq 1>
  <tr>
    <td>Sign Coverage</td>
    <td style="text-align:right;">$25,000 Included</td>
  </tr>

  <tr>
    <td>Glass Coverage</td>
    <td style="text-align:right;">Included</td>
  </tr>
  </cfif>
  <tr>
    <td>Property Deductible</td>
    <td style="text-align:right;">$#numberFormat(rating.prop_deductible,',')#</td>
  </tr>
  <cfif val(rating.prop_90) eq 1>    
  <tr>
    <td>#rating.prop_coinsurancelabel# Coinsurance</td>
    <td style="text-align:right;">Included</td>
  </tr> 
	</cfif>
  <cfif val(rating.prop_daysdeductible) eq 0>
  <cfset daysded = "See Below">
  <cfelse>
  <cfset daysded = numberFormat(rating.prop_daysdeductible)>
  </cfif>
  <tr>
    <td>Business Income Deductible (Hours)</td>
    <td style="text-align:right;">#daysded#</td>
  </tr> 
  <cfif val(rating.prop_exclwind) neq 1 AND rating.prop_winddeductable NEQ 0 AND len(rating.prop_winddeductable)>
  <tr>
    <td>Wind/Hail Deductible</td>
    <td style="text-align:right;"><cfif val(rating.prop_exclwind) neq 1>#rating.prop_winddeductable#<cfelse>No Coverage</cfif></td>
  </tr>  
  </cfif>
</table>
<cfif rating.hide_prop neq 1>
<table border="0" cellspacing="1" cellpadding="0" class="tbl" width="350">   
   <tr>
    <td colspan="2" style="font-weight:bold;">Other Coverages</td>

  </tr>
  <tr>
    <td>Additional EDP Equipment</td>
    <td style="text-align:right;"><cfif val(rating.prop_edplimit) neq 0>$#numberFormat(rating.prop_edplimit,',')#<cfelse>No Coverage</cfif></td>
  </tr> 

  <tr>
    <td>HVAC</td>
    <td style="text-align:right;"><cfif val(rating.prop_hvaclimit) neq 0>$#numberFormat(rating.prop_hvaclimit,',')#<cfelse>No Coverage</cfif></td>
  </tr> 
  <tr>
    <td>Sign Coverage over $25k</td>
    <td style="text-align:right;"><cfif val(rating.prop_signlimit) neq 0>$#numberFormat(rating.prop_signlimit,',')#<cfelse>No Coverage</cfif></td>
  </tr>     
  <tr>
    <td>Employee Dishonesty</td>
    <td style="text-align:right;"><cfif val(rating.employee_dishonesty_id) neq 0>#rating.employee_dishonesty_amount#<cfelse>No Coverage</cfif></td>
  </tr> 
  <cfif val(rating.cyber_liability_amount_id) neq 0>
  <tr>
    <td>Data Breach/Cyber Liability</td>
    <td style="text-align:right;">#rating.cyber_liability_amount#</td>
  </tr> 
  </cfif>
</table>
<table border="0" cellspacing="1" cellpadding="0" class="tbl" width="350">    
   <tr>
    <td colspan="2" style="font-weight:bold;">Other Perils</td>
  </tr>   
  <tr>
    <td>Flood</td>
    <td style="text-align:right;"><cfif val(rating.prop_floodlimit) neq 0>$#numberFormat(rating.prop_floodlimit,',')#<cfelse>No Coverage</cfif></td>
  </tr>   
  <tr>
    <td>Flood Deductible</td>
    <td style="text-align:right;"><cfif val(rating.prop_flooddeduct) neq 0>$#numberFormat(rating.prop_flooddeduct,',')#<cfelse>N/A</cfif></td>
  </tr> 
  <tr>
    <td>Flood Premium</td>
    <td style="text-align:right;"><cfif val(rating.prop_floodpremium) neq 0>$#numberFormat(rating.prop_floodpremium,',')#<cfelse>N/A</cfif></td>
  </tr>     
  <tr>
    <td>Earthquake</td>
    <td style="text-align:right;"><cfif val(rating.prop_quakelimit) neq 0>$#numberFormat(rating.prop_quakelimit,',')#<cfelse>No Coverage</cfif></td>
  </tr>   
  <tr>
    <td>Earthquake Deductible</td>
    <td style="text-align:right;"><cfif val(rating.prop_quakededuct) neq 0>$#numberFormat(rating.prop_quakededuct,',')#<cfelse>N/A</cfif></td>
  </tr> 
  <tr>
    <td>Earthquake Premium</td>
    <td style="text-align:right;"><cfif val(rating.prop_quakepremium) neq 0>$#numberFormat(rating.prop_quakepremium,',')#<cfelse>N/A</cfif></td>
  </tr>         
</table>
</cfif>
</td>
</tr>
<tr>
	<td>
    <!--- Liability Premium Summary --->
   
<table border="0" cellspacing="1" cellpadding="0" class="tbl" width="350">
  <tr>
    <td style="font-weight:bold;">Liability Premium Summary</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>Liability Premium</td>
    <cfif rating.use_prorata eq 1>
    	<cfset glprem = rating.pro_rata_gl>
			<cfelse>
      <cfset glprem = rating.loc_annual_premium>
      </cfif>
    <td style="text-align:right;">$#decimalFormat(glprem)#</td>
  </tr>
 <cfif rating.brokerfee gt 0> 
  <tr>
    <td>Broker Fee</td>
    <td style="text-align:right;">$#decimalFormat(rating.brokerfee)#</td>
  </tr>
  </cfif>
  <cfif rating.inspectionfee gt 0>
  <tr>
    <td>Inspection Fee</td>
    <td style="text-align:right;">$#decimalFormat(rating.inspectionfee)#</td>
  </tr>
  </cfif>
  <cfif rating.surplustax gt 0>
  <tr>
    <td>Surplus Tax</td>
    <td style="text-align:right;">$#decimalFormat(rating.surplustax)#</td>
  </tr>
  </cfif>
  <cfif rating.stampingfee gt 0>
  <tr>
    <td>Stamping Fee</td>
    <td style="text-align:right;">$#decimalFormat(rating.stampingfee)#</td>
  </tr>
  </cfif>
  <cfif rating.statecharge gt 0>
  <tr>
    <td>State/Muni Surcharge</td>
    <td style="text-align:right;">$#decimalFormat(rating.statecharge)#</td>
  </tr> 
  </cfif>
  <cfif rating.filingfee gt 0> 
  <tr>
    <td>Filing Fee</td>
    <td style="text-align:right;">$#decimalFormat(rating.filingfee)#</td>
  </tr> 
  </cfif> 
 <!--- 
  <cfif rating.rpgfee gt 0> 
  <tr>
    <td>RPG Fee</td>
    <td style="text-align:right;">$#decimalFormat(rating.rpgfee)#</td>
  </tr> 
  </cfif>  ---> 
  <tr>
    <td>Terrorism Coverage</td>
    <td style="text-align:right;">
<cfif rating.terrorism_rejected neq 1>
  $#decimalFormat(rating.terrorism_fee)#<cfelse>See Summary</cfif></td>
  </tr>

<cfset gltotal = rating.grandtotal - rating.rpgfee>
  <tr>
    <td style="font-weight:bold;">Liability Total</td>
    <td style="font-weight:bold; text-align:right;">$#decimalFormat(gltotal)#</td>
  </tr>

</table>    
    </td>
<td>
<!--- Property Premium Summary --->
<cfif rating.prop_use_prorata neq 1>
<cfset propprem = rating.prop_chargedpremium>
<cfelse>
<cfset propprem = rating.prop_proratapremium>
</cfif>
<table border="0" cellspacing="1" cellpadding="0" class="tbl" width="350">
  <tr>
    <td style="font-weight:bold;">Property Premium Summary</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>Property Premium</td>
    <td style="text-align:right;">$#decimalFormat(propprem)#</td>
  </tr>
  <cfif rating.prop_agencyamount gt 0>
  <tr>
    <td>Agency Fee</td>
    <td style="text-align:right;">$#decimalFormat(round(rating.prop_agencyamount))#</td>
  </tr>
  </cfif>
  <cfif rating.prop_brokerfee gt 0>
  <tr>
    <td>Broker Fee</td>
    <td style="text-align:right;">$#decimalFormat(round(rating.prop_brokerfee))#</td>
  </tr>
  </cfif>  
  <cfif rating.property_emp_amount gt 0>
  <tr>
    <td>Employee Dishonesty</td>
    <td style="text-align:right;">$#decimalFormat(rating.property_emp_amount)#</td>
  </tr>
</cfif>
  <tr>
    <td>Terrorism Coverage</td>
    <td style="text-align:right;"><cfif rating.prop_terrorism_rejected neq 1>$#decimalFormat(rating.propt)#<cfelse>See Summary</cfif></td>
  </tr>
  <cfif rating.prop_taxes gt 0>
  <tr>
    <td>State Taxes</td>
    <td style="text-align:right;">$#decimalFormat(rating.prop_taxes)#</td>
  </tr>
  </cfif>
  <tr>
    <td style="font-weight:bold;">Property Total</td>
    <td style="text-align:right; font-weight:bold;">$#decimalFormat(rating.prop_grandtotal)#</td>
  </tr>  

</table>


</td>
</tr>
</table>

<p style="font-weight:bold; padding-top:10px;">TOTAL PREMIUM THIS LOCATION: $#decimalFormat(totalpremium)#</p>
<p style="font-size:10px;"><strong>Special Conditions and Comments</strong></p>
<cfif rating.hide_prop neq 1>
<p style="font-size:10px;">If Building is covered, coverage is Special Form, Replacement Cost, No Coinsurance unless specified above. If Personal Property is covered, coverage is Special Form, Replacement Cost, No Coinsurance unless specified above. If Business Income is covered, coverage is Special Form, 1 Day Deductible, 1/3 Monthly Limitation, 90 Day Extended Period of Indemnity unless specified above.</p></cfif>
<cfif val(rating.prop_exclwind) eq 1><p style="font-size:10px;"><strong>WIND/HAIL IS EXCLUDED ENTIRELY.</strong></p></cfif>
<p style="font-size:10px; margin:0; padding:0;">#rating.liability_propnotes#<br>#rating.property_propnotes#</p>

</cfoutput>

