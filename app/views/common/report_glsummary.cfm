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
    <cfset totalall = 0>
    <cfset totalglpremium = 0>
    <cfset totalglbroker = 0>
    <cfset totalglinspection = 0>
    <cfset totalglsurplus = 0>
    <cfset totalglstamping = 0>
    <cfset totalglfiling = 0>
    <cfset totalglstate = 0>
    <cfset totalglrpg = 0>
    <cfset totalgl = 0>


<!--- state total defaults--->
    <cfset statetotalglpremium = 0>
    <cfset statetotalglbroker = 0>
    <cfset statetotalglinspection = 0>
    <cfset statetotalglsurplus = 0>
    <cfset statetotalglstamping = 0>
    <cfset statetotalglfiling = 0>
    <cfset statetotalglstate = 0>
    <cfset statetotalglrpg = 0>
    <cfset statetotalgl = 0>
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
      <th style="text-align:right;">Broker</th>
      <th style="text-align:right;">Tax</th>
      <th style="text-align:right;">Inspect</th>
      <th style="text-align:right;">Stamp</th>   
      <th style="text-align:right;">Filing</th>
      <th style="text-align:right;">State/Muni</th>
      <th style="text-align:right;">RPG</th>
      <th style="text-align:right;">Total</th>
    </tr>    
	</cfif>    
  <cfset rating = mainGW.getLocationRating(rc.locations.location_id)>
    <cfif rating.use_prorata eq 1>
    	<cfset glprem = rating.pro_rata_gl>
			<cfelse>
      <cfset glprem = rating.loc_annual_premium>
      </cfif>   
      
      <cfset totalglpremium = val(totalglpremium) + val(glprem)>
      <cfset totalglbroker = val(totalglbroker) + val(rating.brokerfee)>
      <cfset totalglinspection = val(totalglinspection) + val(rating.inspectionfee)>
      <cfset totalglsurplus = val(totalglsurplus) + val(rating.surplustax) + val(rating.custom_tax_1) + val(rating.custom_tax_2) + val(rating.custom_tax_3) + val(rating.custom_tax_4) + val(rating.custom_tax_5)>
      <cfset totalglstamping = val(totalglstamping) + val(rating.stampingfee)>
      <cfset totalglfiling = val(totalglfiling) + val(rating.filingfee)>
      <cfset totalglstate = val(totalglstate) + val(rating.statecharge)>
      <cfset totalglrpg = val(totalglrpg) + val(rating.rpgfee)>
      <cfset totalgl = val(totalgl) + val(rating.grandtotal)>

      <cfset statetotalglpremium = val(statetotalglpremium) + val(glprem)>
      <cfset statetotalglbroker = val(statetotalglbroker) + val(rating.brokerfee)>
      <cfset statetotalglinspection = val(statetotalglinspection) + val(rating.inspectionfee)>
      <cfset statetotalglsurplus = val(statetotalglsurplus) + val(rating.surplustax) + val(rating.custom_tax_1) + val(rating.custom_tax_2) + val(rating.custom_tax_3) + val(rating.custom_tax_4) + val(rating.custom_tax_5)>
      <cfset statetotalglstamping = val(statetotalglstamping) + val(rating.stampingfee)>
      <cfset statetotalglfiling = val(statetotalglfiling) + val(rating.filingfee)>
      <cfset statetotalglstate = val(statetotalglstate) + val(rating.statecharge)>
      <cfset statetotalglrpg = val(statetotalglrpg) + val(rating.rpgfee)>
      <cfset statetotalgl = val(statetotalgl) + val(rating.grandtotal)>
      <tr>
        <td style="border-top:1px solid black;">#rc.locations.location_number#</td>
        <td style="border-top:1px solid black;">#rc.locations.address#, #rc.locations.address2#<br />
          #rc.locations.city#, #rc.locations.statename#, #rc.locations.zip#</td>
        <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(glprem)#</td>
        <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(rating.brokerfee)#</td>
        <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(rating.surplustax)#</td>
        <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(rating.inspectionfee)#</td>      
        <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(rating.stampingfee)#</td>
        <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(rating.filingfee)#</td>
        <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(rating.statecharge)#</td>
        <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(rating.rpgfee)#</td>
        <td style="font-weight:bold; text-align:right; border-top:1px solid black;">$#decimalFormat(rating.grandtotal)#</td>
      </tr>
<!---determine whether or not to insert state totals and page break--->
      <cfset thisstate = rc.locations.statename>      
      <cfset nextstate = rc.locations.statename[currentrow+1]>
		<cfif thisstate neq nextstate>
      <tr>
        <td style="border-top:1px solid black;">&nbsp;</td>
        <td style="border-top:1px solid black; font-weight:bold;">#thisstate# State Total</td>
        <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(statetotalglpremium)#</td>
        <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(statetotalglbroker)#</td>
        <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(statetotalglsurplus)#</td>
        <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(statetotalglinspection)#</td>      
        <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(statetotalglstamping)#</td>
        <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(statetotalglfiling)#</td>
        <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(statetotalglstate)#</td>
        <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(statetotalglrpg)#</td>
        <td style="font-weight:bold; text-align:right; border-top:1px solid black;">$#decimalFormat(statetotalgl)#</td>
      </tr>           
        </table>
	<!--- reset state total defaults--->
        <cfset statetotalglpremium = 0>
        <cfset statetotalglbroker = 0>
        <cfset statetotalglinspection = 0>
        <cfset statetotalglsurplus = 0>
        <cfset statetotalglstamping = 0>
        <cfset statetotalglfiling = 0>
        <cfset statetotalglstate = 0>
        <cfset statetotalglrpg = 0>
        <cfset statetotalgl = 0>     
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
      <th style="text-align:right;">Broker</th>
      <th style="text-align:right;">Tax</th>
      <th style="text-align:right;">Inspect</th>
      <th style="text-align:right;">Stamp</th>   
      <th style="text-align:right;">Filing</th>
      <th style="text-align:right;">State/Muni</th>
      <th style="text-align:right;">RPG</th>
      <th style="text-align:right;">Total</th>
    </tr>     
      <tr>
        <td style="border-top:1px solid black;">&nbsp;</td>
        <td style="border-top:1px solid black; font-weight:bold;">Grand Total</td>
        <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(totalglpremium)#</td>
        <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(totalglbroker)#</td>
        <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(totalglsurplus)#</td>
        <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(totalglinspection)#</td>      
        <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(totalglstamping)#</td>
        <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(totalglfiling)#</td>
        <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(totalglstate)#</td>
        <td style="text-align:right; border-top:1px solid black;">$#decimalFormat(totalglrpg)#</td>
        <td style="font-weight:bold; text-align:right; border-top:1px solid black;">$#decimalFormat(totalgl)#</td>
      </tr>    
  </table>
  </cfif>

</cfoutput>