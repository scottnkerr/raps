<style>
body, p {
	font-size:12px !important;
}
h2 {
	margin-top:15px;
}
.tbl {
	background-color:#000;
	margin:15px 15px 0 0
}
.tbl td, th, caption {
	background-color:#fff;
}
td, th {
	font-size:12px;
	text-align:left;
}

.tblcontainer td {
	vertical-align:top;
}
</style>
<cfoutput>
 
  <!--- grand total defaults --->    
        <cfset totalproppremium = 0>
        <cfset totalpropterrorism = 0>
        <cfset totalpropagencyfee = 0>
        <cfset totalpropempdis = 0>
        <cfset totalproptaxes = 0>
        <cfset totalprop = 0>


<!--- state total defaults--->
        <cfset statetotalproppremium = 0>
        <cfset statetotalpropterrorism = 0>
        <cfset statetotalpropagencyfee = 0>
        <cfset statetotalpropempdis = 0>
        <cfset statetotalproptaxes = 0>
        <cfset statetotalprop = 0>
    <!---set state to blank--->
  <cfset thisstate = ''>        

    <cfloop query="rc.locations">
    <cfif rc.locations.statename neq thisstate>
  <h2>#rc.report_title#</h2>
  <b>
  <p>INSURED: #rc.client.entity_name# DBA #rc.client.dba#</p>
  </b>    
  <h3>#rc.locations.statename#</h3>
  <table border="0" cellspacing="0" cellpadding="5" width="100%">
    <tr>
      <th>Loc ##</th>
      <th>Location Address</th>
      <th style="text-align:right;">Premium</th>
      <th style="text-align:right;">Agency</th> 
      <!---<th style="text-align:right;">Employee Dishonesty</th>     --->
      <th style="text-align:right;">State/Muni</th>
      <th style="text-align:right;">Total</th>
    </tr>    
	</cfif>    
      <cfset rating = mainGW.getLocationRating(rc.locations.location_id)>
      <cfset totalproppremium = val(totalproppremium) + val(rating.prop_subtotal)>
      <cfset totalpropagencyfee = val(totalpropagencyfee) + val(rating.prop_agencyamount)>
      <cfset totalpropempdis = val(totalpropempdis) + val(rating.property_emp_amount)>
      <cfset totalproptaxes = val(totalproptaxes) + val(rating.prop_taxes)>
      <cfset totalprop = val(totalprop) + val(rating.prop_grandtotal)>

      <cfset statetotalproppremium = val(statetotalproppremium) + val(rating.prop_subtotal)>
      <cfset statetotalpropagencyfee = val(statetotalpropagencyfee) + val(rating.prop_agencyamount)>
      <cfset statetotalpropempdis = val(statetotalpropempdis) + val(rating.property_emp_amount)>
      <cfset statetotalproptaxes = val(statetotalproptaxes) + val(rating.prop_taxes)>
      <cfset statetotalprop = val(statetotalprop) + val(rating.prop_grandtotal)>
      <tr>
        <td style="border-top:1px solid black;">#rc.locations.location_number#</td>
        <td style="border-top:1px solid black;">#rc.locations.address#, #rc.locations.address2#<br />
          #rc.locations.city#, #rc.locations.statename#, #rc.locations.zip#</td>
        <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(rating.prop_subtotal)#</td>
        <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(rating.prop_agencyamount)#</td>
       <!--- <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(rating.property_emp_amount)#</td>     ---> 
        <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(rating.prop_taxes)#</td>
        <td style="font-weight:bold; text-align:right; border-top:1px solid black;">$#decimalFormat(rating.prop_grandtotal)#</td>
      </tr>
<!---determine whether or not to insert state totals and page break--->
      <cfset thisstate = rc.locations.statename>      
      <cfset nextstate = rc.locations.statename[currentrow+1]>
		<cfif thisstate neq nextstate>
      <tr>
        <td style="border-top:1px solid black;">&nbsp;</td>
        <td style="border-top:1px solid black; font-weight:bold;">#thisstate# State Total</td>
        <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(statetotalproppremium)#</td>
        <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(statetotalpropagencyfee)#</td>
        <!---<td style="text-align:right; border-top:1px solid black;">$#decimalFormat(statetotalpropempdis)#</td>     ---> 
        <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(statetotalproptaxes)#</td>
        <td style="font-weight:bold; text-align:right; border-top:1px solid black;">$#decimalFormat(statetotalprop)#</td>
      </tr>           
        </table>
	<!--- reset state total defaults--->
        <cfset statetotalproppremium = 0>
        <cfset statetotalpropterrorism = 0>
        <cfset statetotalpropagencyfee = 0>
        <cfset statetotalpropempdis = 0>
        <cfset statetotalproptaxes = 0>
        <cfset statetotalprop = 0>    
        <!---page break if multiple state report--->   
        <cfif rc.state_id eq 0>
        <cfdocumentitem type="pagebreak"></cfdocumentitem>
        </cfif>
        </cfif>      
    </cfloop>
    <cfif rc.state_id eq 0>
  <h2>#rc.report_title#</h2>
  <b>
  <p>INSURED: #rc.client.entity_name# DBA #rc.client.dba#</p>
  </b>    
  <table border="0" cellspacing="0" cellpadding="5" width="100%">
    <tr>
      <th>&nbsp;</th>
      <th>&nbsp;</th>
      <th style="text-align:right;">Premium</th>
      <th style="text-align:right;">Agency</th>
     <!--- <th style="text-align:right;">Employee Dishonesty</th>--->
      <th style="text-align:right;">State/Muni</th>
      <th style="text-align:right;">Total</th>
    </tr>     
      <tr>
        <td style="border-top:1px solid black;">&nbsp;</td>
        <td style="border-top:1px solid black; font-weight:bold;">Grand Total</td>
        <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(totalproppremium)#</td>
        <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(totalpropagencyfee)#</td>
        <!---<td style="text-align:right; border-top:1px solid black;">$#decimalFormat(totalpropempdis)#</td>   --->   
        <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(totalproptaxes)#</td>
        <td style="font-weight:bold; text-align:right; border-top:1px solid black;">$#decimalFormat(totalprop)#</td>
      </tr>    
  </table>
  </cfif>

</cfoutput>