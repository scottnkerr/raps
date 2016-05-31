<cfif structkeyexists(rc,"client")>

	<cfparam name="client_id"  default="#rc.client.client_id#">
	<cfparam name="rcaffiliation_id"  default="#rc.client.affiliation_id#">
	<cfparam name="rcclient_type_id"  default="#rc.client.client_type_id#">
	<cfparam name="ams"  default="#rc.client.ams#">
	<cfparam name="am"  default="#rc.client.am#">
    <cfparam name="client_code"  default="#rc.client.client_code#">
	<cfparam name="entity_name"  default="#rc.client.entity_name#">
	<cfparam name="dba"  default="#rc.client.dba#">
	<cfparam name="mailing_address"  default="#rc.client.mailing_address#">
	<cfparam name="mailing_address2"  default="#rc.client.mailing_address2#">
	<cfparam name="mailing_city"  default="#rc.client.mailing_city#">
	<cfparam name="mailing_state"  default="#rc.client.mailing_state#">
	<cfparam name="mailing_zip"  default="#rc.client.mailing_zip#">
	<cfparam name="business_phone"  default="#rc.client.business_phone#">
	<cfparam name="business_email"  default="#rc.client.business_email#">
	<cfparam name="website"  default="#rc.client.website#">
	<cfparam name="fein"  default="#rc.client.fein#">
	<cfparam name="year_business_started"  default="#rc.client.year_business_started#">
	<cfparam name="years_experience"  default="#rc.client.years_experience#">
	<cfparam name="x_reference"  default="#rc.client.x_reference#">
	<cfparam name="client_status_id"  default="#rc.client.client_status_id#">
	<cfparam name="current_effective_date"  default="#rc.client.current_effective_date#">
    <cfparam name="ue_type"  default="#rc.client.ue_type#">
    <cfparam name="ue_date1"  default="#rc.client.ue_date1#">
    <cfparam name="ue_date2"  default="#rc.client.ue_date2#">
    <cfparam name="ue_issuing_company"  default="#rc.client.ue_issuing_company#">
    <cfparam name="ue_occurrence"  default="#rc.client.ue_occurrence#">
    <cfparam name="ue_aggregate"  default="#rc.client.ue_aggregate#">
    <cfparam name="ue_retention"  default="#rc.client.ue_retention#">
    <cfparam name="ue_premium"  default="#rc.client.ue_premium#">
    <cfparam name="ue_brokerfee"  default="#rc.client.ue_brokerfee#">
    <cfparam name="ue_agencyfee"  default="#rc.client.ue_agencyfee#">
    <cfparam name="ue_filingfee"  default="#rc.client.ue_filingfee#">
	<cfparam name="ue_terrorism_rejected" default="#rc.client.ue_terrorism_rejected#">
	<cfparam name="ue_terrorism_fee" default="#dollarformat(rc.client.ue_terrorism_fee)#">    
    <cfparam name="ue_stampingfee"  default="#rc.client.ue_stampingfee#">
    <cfparam name="ue_sltax"  default="#rc.client.ue_sltax#">
    <cfparam name="ue_totalpremium"  default="#rc.client.ue_totalpremium#">
    <cfparam name="ue_declined"  default="#rc.client.ue_declined#">
    <cfparam name="ue_declinedreason"  default="#rc.client.ue_declinedreason#">
    <cfparam name="ue_proposalnotes"  default="#rc.client.ue_proposalnotes#"> 
    <cfparam name="ue_notes"  default="#rc.client.ue_notes#"> 
    <cfparam name="ue_rate_state"  default="#rc.client.ue_rate_state#">
    <cfparam name="ue_rate_sltax"  default="#rc.client.ue_rate_sltax#">
    <cfparam name="ue_rate_filingfee"  default="#rc.client.ue_rate_filingfee#">
    <cfparam name="ue_rate_stampingfee"  default="#rc.client.ue_rate_stampingfee#">
    <cfparam name="ue_rate_statesurcharge"  default="#rc.client.ue_rate_statesurcharge#">
    <cfparam name="ue_rate_munisurcharge"  default="#rc.client.ue_rate_munisurcharge#">
    <cfparam name="epli_date1"  default="#rc.client.epli_date1#">
    <cfparam name="epli_date2"  default="#rc.client.epli_date2#">
    <cfparam name="epli_retrodate"  default="#dateFormat(rc.client.epli_retrodate, 'mm/dd/yyyy')#">
    <cfparam name="epli_prioracts"  default="#rc.client.epli_prioracts#">
    <cfparam name="epli_issuing_company"  default="#rc.client.epli_issuing_company#">
    <cfparam name="epli_aggregate"  default="#rc.client.epli_aggregate#">
    <cfparam name="epli_retention"  default="#rc.client.epli_retention#">
    <cfparam name="epli_doincluded"  default="#rc.client.epli_doincluded#">    
    <cfparam name="epli_aggregate2"  default="#rc.client.epli_aggregate2#">
    <cfparam name="epli_retention2"  default="#rc.client.epli_retention2#"> 
    <cfparam name="epli_fulltime"  default="#rc.client.epli_fulltime#"> 
    <cfparam name="epli_partime"  default="#rc.client.epli_partime#">
    <cfparam name="epli_totalemployees"  default="#rc.client.epli_totalemployees#">    
    <cfparam name="epli_premium"  default="#rc.client.epli_premium#">
    <cfparam name="epli_brokerfee"  default="#rc.client.epli_brokerfee#">
    <cfparam name="epli_agencyfee"  default="#rc.client.epli_agencyfee#">
    <cfparam name="epli_filingfee"  default="#rc.client.epli_filingfee#">
    <cfparam name="epli_sltax"  default="#rc.client.epli_sltax#">
    <cfparam name="epli_totalpremium"  default="#rc.client.epli_totalpremium#">
    <cfparam name="epli_declined"  default="#rc.client.epli_declined#">
    <cfparam name="epli_declinedreason"  default="#rc.client.epli_declinedreason#">
    <cfparam name="epli_proposalnotes"  default="#rc.client.epli_proposalnotes#"> 
    <cfparam name="epli_notes"  default="#rc.client.epli_notes#">  
    <cfparam name="wc_states"  default="#rc.client.wc_states#">
    <cfparam name="wc_effectivedate"  default="#rc.client.wc_effectivedate#">  
    <cfparam name="wc_expiredate"  default="#rc.client.wc_expiredate#">
    <cfparam name="wc_issuing_company"  default="#rc.client.wc_issuing_company#">
    <cfparam name="wc_classcode"  default="#rc.client.wc_classcode#">
    <cfparam name="wc_rate"  default="#rc.client.wc_rate#">
    <cfparam name="wc_classcode_desc"  default="#rc.client.wc_classcode_desc#">
    <cfparam name="wc_paybasis"  default="#rc.client.wc_paybasis#">   
    <cfparam name="wc_classcode2"  default="#rc.client.wc_classcode2#">
    <cfparam name="wc_rate2"  default="#rc.client.wc_rate2#">
    <cfparam name="wc_classcode_desc2"  default="#rc.client.wc_classcode_desc2#">
    <cfparam name="wc_paybasis2"  default="#rc.client.wc_paybasis2#">      
    <cfparam name="wc_premium"  default="#rc.client.wc_premium#">
    <cfparam name="wc_agencyfee"  default="#rc.client.wc_agencyfee#">
    <cfparam name="wc_totalpremium"  default="#rc.client.wc_totalpremium#">
    <cfparam name="wc_fein"  default="#rc.client.wc_fein#">
    <cfparam name="wc_additionalfeins"  default="#rc.client.wc_additionalfeins#">
    <cfparam name="wc_fulltime"  default="#rc.client.wc_fulltime#">
    <cfparam name="wc_partime"  default="#rc.client.wc_partime#">
    <cfparam name="wc_totalemployees"  default="#rc.client.wc_totalemployees#">
    <cfparam name="wc_payroll"  default="#rc.client.wc_payroll#">
    <cfparam name="wc_eachaccident"  default="#rc.client.wc_eachaccident#">
    <cfparam name="wc_diseaseeach"  default="#rc.client.wc_diseaseeach#">
    <cfparam name="wc_diseaselimit"  default="#rc.client.wc_diseaselimit#">
    <cfparam name="wc_declined"  default="#rc.client.wc_declined#">
    <cfparam name="wc_declinedreason"  default="#rc.client.wc_declinedreason#">
    <cfparam name="wc_proposalnotes"  default="#rc.client.wc_proposalnotes#">
    <cfparam name="wc_notes"  default="#rc.client.wc_notes#">
    <cfparam name="bond_type"  default="#rc.client.bond_type#"> 
    <cfparam name="bond_issuing_company"  default="#rc.client.bond_issuing_company#"> 
    <cfparam name="bond_amount"  default="#rc.client.bond_amount#"> 
    <cfparam name="bond_obligee"  default="#rc.client.bond_obligee#"> 
    <cfparam name="bond_premium"  default="#rc.client.bond_premium#"> 
    <cfparam name="bond_fees"  default="#rc.client.bond_fees#"> 
    <cfparam name="bond_deliveryfee"  default="#rc.client.bond_deliveryfee#"> 
    <cfparam name="bond_tax"  default="#rc.client.bond_tax#"> 
    <cfparam name="bond_totalpremium"  default="#rc.client.bond_totalpremium#"> 
    <cfparam name="bond_declined"  default="#rc.client.bond_declined#"> 
    <cfparam name="bond_declinedreason"  default="#rc.client.bond_declinedreason#">
    <cfparam name="bond_notes"  default="#rc.client.bond_notes#">  
    <!---other tab--->
    <cfparam name="other_loc"  default="#rc.client.other_loc#"> 
    <cfparam name="other_effectivedate"  default="#rc.client.other_effectivedate#"> 
    <cfparam name="other_expiredate"  default="#rc.client.other_expiredate#"> 
    <cfparam name="other_issuing_company"  default="#rc.client.other_issuing_company#"> 
    <cfparam name="other_dedret"  default="#rc.client.other_dedret#"> 
    <cfparam name="other_dedretamount"  default="#rc.client.other_dedretamount#"> 
    <cfparam name="other_premium"  default="#rc.client.other_premium#"> 
    <cfparam name="other_brokerfee"  default="#rc.client.other_brokerfee#"> 
    <cfparam name="other_agencyfee"  default="#rc.client.other_agencyfee#"> 
    <cfparam name="other_tax"  default="#rc.client.other_tax#"> 
    <cfparam name="other_filingfee"  default="#rc.client.other_filingfee#"> 
    <cfparam name="other_rpgfee"  default="#rc.client.other_rpgfee#"> 
    <cfparam name="other_totalpremium"  default="#rc.client.other_totalpremium#"> 
    <cfparam name="other_proposalnotes"  default="#rc.client.other_proposalnotes#"> 
    <cfparam name="other_notes"  default="#rc.client.other_notes#"> 
    <!---other 2 tab--->
    <cfparam name="other2_loc"  default="#rc.client.other2_loc#"> 
    <cfparam name="other2_effectivedate"  default="#rc.client.other2_effectivedate#"> 
    <cfparam name="other2_expiredate"  default="#rc.client.other2_expiredate#"> 
    <cfparam name="other2_issuing_company"  default="#rc.client.other2_issuing_company#"> 
    <cfparam name="other2_dedret"  default="#rc.client.other2_dedret#"> 
    <cfparam name="other2_dedretamount"  default="#rc.client.other2_dedretamount#"> 
    <cfparam name="other2_premium"  default="#rc.client.other2_premium#"> 
    <cfparam name="other2_brokerfee"  default="#rc.client.other2_brokerfee#"> 
    <cfparam name="other2_agencyfee"  default="#rc.client.other2_agencyfee#"> 
    <cfparam name="other2_tax"  default="#rc.client.other2_tax#"> 
    <cfparam name="other2_filingfee"  default="#rc.client.other2_filingfee#"> 
    <cfparam name="other2_rpgfee"  default="#rc.client.other2_rpgfee#"> 
    <cfparam name="other2_totalpremium"  default="#rc.client.other2_totalpremium#"> 
    <cfparam name="other2_proposalnotes"  default="#rc.client.other2_proposalnotes#"> 
    <cfparam name="other2_notes"  default="#rc.client.other2_notes#"> 
    <!---other 3 tab--->
    <cfparam name="other3_loc"  default="#rc.client.other3_loc#"> 
    <cfparam name="other3_effectivedate"  default="#rc.client.other3_effectivedate#"> 
    <cfparam name="other3_expiredate"  default="#rc.client.other3_expiredate#"> 
    <cfparam name="other3_issuing_company"  default="#rc.client.other3_issuing_company#"> 
    <cfparam name="other3_dedret"  default="#rc.client.other3_dedret#"> 
    <cfparam name="other3_dedretamount"  default="#rc.client.other3_dedretamount#"> 
    <cfparam name="other3_premium"  default="#rc.client.other3_premium#"> 
    <cfparam name="other3_brokerfee"  default="#rc.client.other3_brokerfee#"> 
    <cfparam name="other3_agencyfee"  default="#rc.client.other3_agencyfee#"> 
    <cfparam name="other3_tax"  default="#rc.client.other3_tax#"> 
    <cfparam name="other3_filingfee"  default="#rc.client.other3_filingfee#"> 
    <cfparam name="other3_rpgfee"  default="#rc.client.other3_rpgfee#"> 
    <cfparam name="other3_totalpremium"  default="#rc.client.other3_totalpremium#"> 
    <cfparam name="other3_proposalnotes"  default="#rc.client.other3_proposalnotes#"> 
    <cfparam name="other3_notes"  default="#rc.client.other3_notes#">         
    <cfparam name="label_needed"  default="#rc.client.label_needed#"> 
<cfelse>
	<cfparam name="client_id"  default="0">
	<cfparam name="rcaffiliation_id"  default="">
	<cfparam name="rcclient_type_id"  default="">
	<cfparam name="ams"  default="">
	<cfparam name="am"  default="0">
    <cfparam name="client_code" default="">
	<cfparam name="entity_name"  default="">
	<cfparam name="dba"  default="">
	<cfparam name="mailing_address"  default="">
	<cfparam name="mailing_address2"  default="">
	<cfparam name="mailing_city"  default="City">
	<cfparam name="mailing_state"  default="">
	<cfparam name="mailing_zip"  default="Zip">
	<cfparam name="business_phone"  default="">
	<cfparam name="business_email"  default="">
	<cfparam name="website"  default="">
	<cfparam name="fein"  default="">
	<cfparam name="year_business_started"  default="">
	<cfparam name="years_experience"  default="">
	<cfparam name="x_reference"  default="">
	<cfparam name="client_status_id"  default="1">
	<cfparam name="current_effective_date"  default="">
    <cfparam name="ue_type"  default="">
    <cfparam name="ue_date1"  default="">
    <cfparam name="ue_date2"  default="">
    <cfparam name="ue_issuing_company"  default="0">
    <cfparam name="ue_occurrence"  default="">
    <cfparam name="ue_aggregate"  default="">
    <cfparam name="ue_retention"  default="">
    <cfparam name="ue_premium"  default="">
    <cfparam name="ue_brokerfee"  default="">
    <cfparam name="ue_agencyfee"  default="">
    <cfparam name="ue_filingfee"  default="">
    <cfparam name="ue_stampingfee"  default="">
	<cfparam name="ue_terrorism_rejected" default="0">
	<cfparam name="ue_terrorism_fee" default="0">      
    <cfparam name="ue_sltax"  default="">
    <cfparam name="ue_totalpremium"  default="">
    <cfparam name="ue_declined"  default="0">
    <cfparam name="ue_declinedreason"  default="">
    <cfparam name="ue_proposalnotes"  default="">
    <cfparam name="ue_notes"  default=""> 
    <cfparam name="ue_rate_state"  default="">
    <cfparam name="ue_rate_sltax"  default="">
    <cfparam name="ue_rate_filingfee"  default="">
    <cfparam name="ue_rate_stampingfee"  default="">
    <cfparam name="ue_rate_statesurcharge"  default="">
    <cfparam name="ue_rate_munisurcharge"  default="">     
    <cfparam name="epli_date1"  default="">
    <cfparam name="epli_date2"  default="">
    <cfparam name="epli_retrodate"  default="">
    <cfparam name="epli_prioracts"  default="0">
    <cfparam name="epli_issuing_company"  default="0">
    <cfparam name="epli_doincluded"  default="">
    <cfparam name="epli_aggregate"  default="">
    <cfparam name="epli_retention"  default="">
    <cfparam name="epli_aggregate2"  default="">
    <cfparam name="epli_retention2"  default="">
    <cfparam name="epli_fulltime"  default="">
    <cfparam name="epli_partime"  default="">
    <cfparam name="epli_totalemployees"  default="">    
    <cfparam name="epli_premium"  default="">
    <cfparam name="epli_brokerfee"  default="">
    <cfparam name="epli_agencyfee"  default="">
    <cfparam name="epli_filingfee"  default="">
    <cfparam name="epli_sltax"  default="">
    <cfparam name="epli_totalpremium"  default="">
    <cfparam name="epli_declined"  default="0">
    <cfparam name="epli_declinedreason"  default="">
    <cfparam name="epli_proposalnotes"  default=""> 
    <cfparam name="epli_notes"  default=""> 
    <cfparam name="wc_states"  default="">
    <cfparam name="wc_effectivedate"  default="">  
    <cfparam name="wc_expiredate"  default="">
    <cfparam name="wc_issuing_company"  default="0">
    <cfparam name="wc_classcode"  default="">
    <cfparam name="wc_rate"  default="0">
    <cfparam name="wc_classcode_desc"  default="">
    <cfparam name="wc_paybasis"  default="0">   
    <cfparam name="wc_classcode2"  default="">
    <cfparam name="wc_rate2"  default="0">
    <cfparam name="wc_classcode_desc2"  default="">
    <cfparam name="wc_paybasis2"  default="0">       
    <cfparam name="wc_premium"  default="0">
    <cfparam name="wc_agencyfee"  default="0">
    <cfparam name="wc_totalpremium"  default="0">
    <cfparam name="wc_fein"  default="">
    <cfparam name="wc_additionalfeins"  default="0">
    <cfparam name="wc_fulltime"  default="">
    <cfparam name="wc_partime"  default="">
    <cfparam name="wc_totalemployees"  default="">
    <cfparam name="wc_payroll"  default="0">
    <cfparam name="wc_eachaccident"  default="1000000">
    <cfparam name="wc_diseaseeach"  default="1000000">
    <cfparam name="wc_diseaselimit"  default="1000000">
    <cfparam name="wc_declined"  default="0">
    <cfparam name="wc_declinedreason"  default="">
    <cfparam name="wc_proposalnotes"  default=""> 
    <cfparam name="wc_notes"  default="">  
    <cfparam name="bond_type"  default=""> 
    <cfparam name="bond_issuing_company"  default=""> 
    <cfparam name="bond_amount"  default=""> 
    <cfparam name="bond_obligee"  default=""> 
    <cfparam name="bond_premium"  default=""> 
    <cfparam name="bond_fees"  default=""> 
    <cfparam name="bond_deliveryfee"  default=""> 
    <cfparam name="bond_tax"  default=""> 
    <cfparam name="bond_totalpremium"  default=""> 
    <cfparam name="bond_declined"  default=""> 
    <cfparam name="bond_declinedreason"  default=""> 
    <cfparam name="bond_notes"  default=""> 
    <!---other tab ---> 
    <cfparam name="other_loc"  default=""> 
    <cfparam name="other_effectivedate"  default=""> 
    <cfparam name="other_expiredate"  default=""> 
    <cfparam name="other_issuing_company"  default=""> 
    <cfparam name="other_dedret"  default=""> 
    <cfparam name="other_dedretamount"  default=""> 
    <cfparam name="other_premium"  default=""> 
    <cfparam name="other_brokerfee"  default=""> 
    <cfparam name="other_agencyfee"  default=""> 
    <cfparam name="other_tax"  default=""> 
    <cfparam name="other_filingfee"  default=""> 
    <cfparam name="other_rpgfee"  default=""> 
    <cfparam name="other_totalpremium"  default=""> 
    <cfparam name="other_proposalnotes"  default=""> 
    <cfparam name="other_notes"  default=""> 
    <!---other 2 tab ---> 
    <cfparam name="other2_loc"  default=""> 
    <cfparam name="other2_effectivedate"  default=""> 
    <cfparam name="other2_expiredate"  default=""> 
    <cfparam name="other2_issuing_company"  default=""> 
    <cfparam name="other2_dedret"  default=""> 
    <cfparam name="other2_dedretamount"  default=""> 
    <cfparam name="other2_premium"  default=""> 
    <cfparam name="other2_brokerfee"  default=""> 
    <cfparam name="other2_agencyfee"  default=""> 
    <cfparam name="other2_tax"  default=""> 
    <cfparam name="other2_filingfee"  default=""> 
    <cfparam name="other2_rpgfee"  default=""> 
    <cfparam name="other2_totalpremium"  default=""> 
    <cfparam name="other2_proposalnotes"  default=""> 
    <cfparam name="other2_notes"  default=""> 
    <!---other 3 tab ---> 
    <cfparam name="other3_loc"  default=""> 
    <cfparam name="other3_effectivedate"  default=""> 
    <cfparam name="other3_expiredate"  default=""> 
    <cfparam name="other3_issuing_company"  default=""> 
    <cfparam name="other3_dedret"  default=""> 
    <cfparam name="other3_dedretamount"  default=""> 
    <cfparam name="other3_premium"  default=""> 
    <cfparam name="other3_brokerfee"  default=""> 
    <cfparam name="other3_agencyfee"  default=""> 
    <cfparam name="other3_tax"  default=""> 
    <cfparam name="other3_filingfee"  default=""> 
    <cfparam name="other3_rpgfee"  default=""> 
    <cfparam name="other3_totalpremium"  default=""> 
    <cfparam name="other3_proposalnotes"  default=""> 
    <cfparam name="other3_notes"  default="">            
    <cfparam name="label_needed"  default="0">             
</cfif>

<cfif mailing_city is "">
<cfset mailing_city = "City">
</cfif>
<cfif mailing_zip is "">
<cfset mailing_zip = "Zip">
</cfif>
<cfset website = replacenocase(website,"http://","","ALL")>

<cfinclude template="client.js.cfm">
  <div id="statusbar">
  <div id="pagename"><cfif val(client_id) eq 0>New </cfif>Client</div>
  <div id="statusstuff"> 
   
  </div><!---End Statusstuff--->
  </div><!---End statusbar---> 
  <div class="msgcontainer">
<div class="message"></div>
</div>
<div class="formcontainer">

<form id="clientform" action="/index.cfm?event=main.addEditClient" method="post" autocomplete="off">
	<input type="hidden" name="client_id" value="<cfoutput>#client_id#</cfoutput>">
    <input type="hidden" name="pageLoadTime" id="pageLoadTime" value="<cfoutput>#now()#</cfoutput>">
<ul class="formfields txtleft" style="width:380px;">
<li><label class="width-120">Affilation</label></li>
<li class="selectli2">
	<select class="selectbox2" id="affiliation_id" name="affiliation_id" style="width:110px; margin:0;">
	<cfloop query="rc.affiliations">
	<cfoutput><option value="#affiliation_id#" <cfif affiliation_id eq rcaffiliation_id>selected</cfif>>#code#</option></cfoutput>
	</cfloop>
	</select>
</li>
<li><label class="width-40 txtright">AMS #</label></li>
<li><input type="text" name="ams" class="width-72 txtleft" value="<cfoutput>#ams#</cfoutput>"></li>
<li><label class="width-120">Type</label></li>
<li class="selectli2">
	<select class="selectbox2" id="client_type_id" name="client_type_id" style="width:110px;">
		<cfloop query="rc.types">
		<cfoutput><option value="#client_type_id#" <cfif client_type_id eq rcclient_type_id>selected</cfif>>#type#</option></cfoutput>
		</cfloop>
	</select></li>
<li><label class="width-40 txtright">Code</label></li>
<li style="overflow:hidden; width:82px; height:22px;"><input type="text" name="client_code" class="width-72 txtleft" value="<cfoutput>#client_code#</cfoutput>"></li>
<li><label class="width-120">Entity Name</label></li>
<li><input type="text" name="entity_name" class="width-230" value="<cfoutput>#entity_name#</cfoutput>" maxlength="199"></li>
<li><label class="width-120">DBA</label></li>
<li><input type="text" name="dba" class="width-230" value="<cfoutput>#dba#</cfoutput>"></li>
<li><label class="width-120">Mailing Address</label></li>
<li><input type="text" name="mailing_address" class="width-230" value="<cfoutput>#mailing_address#</cfoutput>" ></li>
<li><label class="width-120">Address 2</label></li>
<li><input type="text" name="mailing_address2" class="width-230" value="<cfoutput>#mailing_address2#</cfoutput>"></li>
<li class="clear"><label class="width-120">City, State, Zip</label></li>
<li><input type="text" name="mailing_city" id="mailing_city" class="width-126" style="margin-right:2px;" value="<cfoutput>#mailing_city#</cfoutput>"></li>
<li class="selectli" style="padding-right:2px;">
<select id="mailing_state" name="mailing_state" class="selectbox2" style="width:50px;">
<option value="0">State</option>
	<cfloop query="rc.states">
	<cfoutput><option value="#state_id#" <cfif state_id eq mailing_state>selected</cfif>>#name#</option></cfoutput>
	</cfloop></select></li>
<li><input type="text" name="mailing_zip" id="mailing_zip" class="width-42" value="<cfoutput>#mailing_zip#</cfoutput>"></li>
<li class="clear"><label class="width-120">Business Phone</label></li>
<li class="bphoneli"><input type="text" name="business_phone" class="phonenumber" value="<cfoutput>#business_phone#</cfoutput>"></li>
<li class="clear"><label class="width-120">Business Email</label></li>
<li><input type="text" name="business_email" class="width-126" value="<cfoutput>#business_email#</cfoutput>"></li>
<li><a href="mailto:<cfoutput>#business_email#</cfoutput>" title="Send email"><img src="/images/emailbutton.png"></a></li>
<li class="clear"><label class="width-120">Website</label></li>
<li><input type="text" name="website" class="width-126" value="<cfoutput>#website#</cfoutput>"></li>
<li><a href="http://<cfoutput>#website#</cfoutput>" target="_blank" title="Visit Website"><img src="/images/quickpickbutton.png"></a></li>
<li class="clear"><label class="width-120">FEIN</label></li>
<li><input type="text" name="fein" class="width-126" value="<cfoutput>#fein#</cfoutput>"></li>
<li class="clear"><label class="width-120">Year Business Started</label></li>
<li><input type="text" name="year_business_started" class="width-72" value="<cfoutput>#year_business_started#</cfoutput>"></li>
<li><label class="width-97 txtright">Years Experience</label></li>
<li><input type="text" name="years_experience" class="width-45" value="<cfoutput>#years_experience#</cfoutput>"></li>
</ul>
<ul class="formfields width-500 col2 txtleft">

	<li class="clear"><label class="width-65">AM</label></li>
<li class="selectli2">
	<select class="selectbox2" id="am" name="am" style="width:171px;">
    <option value="0">Please Select</option>
		<cfloop query="rc.users">
		<cfoutput><option value="#user_id#" <cfif user_id eq am>selected</cfif>>#user_firstname# #user_lastname#</option></cfoutput>
		</cfloop>
	</select></li>    
	<!---<li><input type="text" name="am" class="width-163" value="<cfoutput>#am#</cfoutput>"></li>--->
	<li><label class="width-50" style="padding-left:20px;">X-ref</label></li>
	<li><input type="text" name="x_reference" id="x_reference" class="width-163 uppercase" value="<cfoutput>#x_reference#</cfoutput>"></li>
    <!---<li><a href="" alt="Lookup X-references" title="Look up X-references"><img src="/images/eyeball.png"></a></li>--->
</ul>
<div class="contactsdiv">
<cfif val(client_id) neq 0>
<cfif structkeyexists(rc,"contacts")>
	<cfoutput query="rc.contacts">
  <ul class="contactsection formfields width-500 col2 txtleft">
	<input type="hidden" name="contactid" value="#contactid#">
	<li class="blankli"><label>&nbsp;</label></li>
	<li class="clear"><label class="bold width-417">Contact</label></li>
  <li><label class="contactorderlabel">Order</label></li><li><input type="text" name="contactorder" class="contactorder" value="#contact_order#"></li>
	<li class="clear"><label class="width-65">Name</label></li>
	<li><input type="text" name="name" class="width-163" value="#name#"></li>
	<li><label class="width-50" style="padding-left:20px;">Title</label></li>
	<li><input type="text" name="title" class="width-163" value="#title#"></li>
	<li class="clear"><label class="width-65">Phone</label></li>
	<li class="contactphoneli"><input type="text" name="phone" class="width-163 phonenumber" value="#phone#"></li>
	<li><label class="width-50" style="padding-left:20px;">Cell</label></li>
	<li class="contactphoneli"><input type="text" name="cell" class="width-163 phonenumber" value="#cell#"></li>
	<li class="clear"><label class="width-65">Fax</label></li>
	<li class="contactphoneli"><input type="text" name="fax" class="width-163 phonenumber" value="#fax#"></li>
	<li><label class="width-50" style="padding-left:20px;">Email</label></li>
	<li><input type="text" name="email" class="width-140" value="#email#"></li>
	<li><a href="mailto:#email#" title="Send Email"><img src="/images/emailbutton.png"></a></li>
  <li class="clear"><img class="imagebuttons deletecontact" src="/images/deletebutton.png"><input type="hidden" name="deletecontact" value="0"></li>
  </ul>
	</cfoutput>
<cfelse>
	<cfloop from="1" to="2" index="i">
  <ul class="contactsection formfields width-500 col2 txtleft">
	<input type="hidden" name="contactid" value="0">
	<li class="blankli"><label>&nbsp;</label></li>
<li class="clear"><label class="bold width-417">Contact</label></li>
  <li><label class="contactorderlabel">Order</label></li><li><input type="text" name="contactorder" class="contactorder"></li>
	<li class="clear"><label class="width-65">Name</label></li>
	<li><input type="text" name="name" class="width-163"></li>
	<li><label class="width-50" style="padding-left:20px;">Title</label></li>
	<li><input type="text" name="title" class="width-163"></li>
	<li class="clear"><label class="width-65">Phone</label></li>
	<li><input type="text" name="phone" class="width-163"></li>
	<li><label class="width-50" style="padding-left:20px;">Cell</label></li>
	<li><input type="text" name="cell" class="width-163"></li>
	<li class="clear"><label class="width-65">Fax</label></li>
	<li><input type="text" name="fax" class="width-163"></li>
	<li><label class="width-50" style="padding-left:20px;">Email</label></li>
	<li><input type="text" name="email" class="width-140"></li>
	<li><a href=""><img src="/images/emailbutton.png"></a></li>
  </ul>
	</cfloop>
</cfif>

<ul class="contactsection formfields width-500 col2 txtleft">
<li class="clear" id="addContact"><label><img src="/images/plus.png" class="plus"> Add Contact</label></li>
</ul>
</cfif>
</div>
<ul class="formfields width-163 col3">
<li><input type="radio" name="client_status_id" value="1" <cfif client_status_id eq 1>checked</cfif>></li>
<li><label style="padding:5px 0 0 5px;">Prospect</label></li>
<li class="clear"><input type="radio" name="client_status_id" value="2" <cfif client_status_id eq 2>checked</cfif>></li>
<li><label style="padding:5px 0 0 5px;">Active</label></li>
<li class="clear"><input type="radio" name="client_status_id" value="3" <cfif client_status_id eq 3>checked</cfif>></li>
<li><label style="padding:5px 0 0 5px;">Terminated</label></li>
<li class="blankli"><label>&nbsp;</label></li>
<li class="clear"><label style="padding-left:0;">Current Effective Date</label></li>
<li class="clear"><input type="text" class="datebox txtleft width-80" name="current_effective_date" id="current_effective_date"  value="<cfoutput>#dateFormat(current_effective_date, 'mm/dd/yyyy')#</cfoutput>"></li>
<cfif val(client_id) neq 0>
<li><img id="renewdates" src="/images/renewdates.png" title="Renew effective dates"></li>
</cfif>
<cfif val(client_id) neq 0>
<li class="blankli"><label>&nbsp;</label></li>
<li class="clear"><input type="checkbox" name="label_needed" value="1" id="label_needed"<cfif label_needed is 1> checked="checked"</cfif>></li>

<li><label>Label Needed</label></li>
</cfif>
<!---<li class="clear"><button class="buttons">Add Client</button></li>--->
</ul>
<div style="clear:both;"></div>
 

</div>   
    <cfif val(client_id) neq 0>           
    <div id="tabs" style="clear:both; margin-top:15px;">
    
      <ul>
        <li><a href="#tabs-1" id="LocationsTab">Locations</a></li>
        <li><a href="#tabs-2" id="PolicyTab">Policy Info</a></li>
        <li><a href="#tabs-6" id="NITab">Add'l Named Insureds</a></li>
        <li><a href="#tabs-4" id="WCTab">Work Comp</a></li>
        <li><a href="#tabs-3" id="UETab">Umbrella/XS</a></li>    
        <li><a href="#tabs-5" id="EPLITab">EPL</a></li>
        <li><a href="#tabs-9" id="BondTab">Bonds</a></li> 
        <li><a href="#tabs-10" class="OtherTab" id="OtherTab1" othertab="1">Other 1</a></li>  
        <li><a href="#tabs-11" class="OtherTab" id="OtherTab2" othertab="2">Other 2</a></li> 
        <li><a href="#tabs-12" class="OtherTab" id="OtherTab3" othertab="3">Other 3</a></li>         
        <li><a href="#tabs-8" id="XREFTab">X-Ref</a></li> 
        <li><a href="#tabs-7" id="MarketingTab">Marketing</a></li>        
      </ul>
      <div id="tabs-1">
      <ul class="formfields">
      <li class="clear" id="addLocation"><label><a href="/index.cfm?event=app&ratingid=0&client_id=<cfoutput>#client_id#</cfoutput>" class="newWindow griddoc" name="AppWin" target="_blank"><img src="/images/plus.png" class="plus" border="0"></a></label></li>
      <li style="padding-top:2px;" class="addsomething"><label>Add Location</label></li>
      </ul>
        <div style="clear:both;"></div>
        <table id="locationgrid">
        </table>
      </div>
      <div id="tabs-2">
      <ul class="formfields fullwidth addPolicyul">
      <li class="clear addpolicyli1" id="addPolicy"><label><img src="/images/plus.png" class="plus"></label></li>
      <li style="padding-top:2px;" class="addpolicyli2"><label class="addpolicylabel">Add Policy</label></li>
      </ul>
      <ul class="formfields fullwidth policyformul">
      <li class="clear"><label class="width-180">Policy Type</label></li>
      <li><label class="width-80">Effective</label></li>
      <li><label class="width-85">Expiration</label></li>
      <li><label class="width-180">Issuing Company</label></li>
      <li><label class="width-180">Policy #</label></li>
      <li><label class="width-100">Status</label></li>
      <li><label class="width-85">Cancel Date</label></li>
      <input type="hidden" name="policy_id" id="policy_id" value="0" class="policyfield" />
      <input type="hidden" name="renewed_policy_id" id="renewed_policy_id" value="0" class="policyfield" />
      <li class="clear"><select name="policy_type_id" id="policy_type_id" class="selectbox3 policyfield" style="width:188px;">
      <cfoutput query="rc.policytypes"><option value="#rc.policytypes.policy_type_id#">#rc.policytypes.policy_type#</option></cfoutput></select></li>
      <li><input type="text" class="datebox policyfield width-80" name="policy_effectivedate" id="policy_effectivedate"  value="<cfoutput>#dateFormat(now(),'mm/dd/yyyy')#</cfoutput>"></li>
      <li><input type="text" class="datebox policyfield width-80" name="policy_expiredate" id="policy_expiredate"  value="<cfoutput>#dateFormat(dateAdd('yyyy',1,now()),'mm/dd/yyyy')#</cfoutput>"></li>
         <li><select name="policy_issuing_company" id="policy_issuing_company" style="width:188px;" class="selectbox3 policyfield">
         	<option value="0">Please Select</option>
            <cfset parentname = "">
            <cfoutput query="rc.issuing">
            <cfif parentname neq rc.issuing.parent_company_name>
            <cfif parentname neq "">
            </optgroup>
            </cfif>
            <optgroup label="#rc.issuing.parent_company_name#">
            <cfif rc.issuing.name neq ''>
            <option value="#rc.issuing.issuing_company_id#">#rc.issuing.name#</option>            
			</cfif>
            <cfelse>
            <cfif rc.issuing.name neq ''>
            <option value="#rc.issuing.issuing_company_id#">#rc.issuing.name#</option>            
			</cfif>
            
            </cfif>
            <cfset parentname = rc.issuing.parent_company_name>
            </cfoutput>
            </select>
         </li> 
         <li><input type="text" name="policy_number" id="policy_number" class="width-180 policyfield txtleft" /></li>
      <li><select name="policy_status_id" id="policy_status_id" class="selectbox3 policyfield" style="width:106px;">
      <cfoutput query="rc.policystatus"><option value="#rc.policystatus.policy_status_id#">#rc.policystatus.policy_status#</option>
	  </cfoutput>
      </select></li>
      <li><input type="text" class="datebox policyfield width-80" name="policy_canceldate" id="policy_canceldate"></li><li style="padding:4px 0 0 5px;"><a id="clearPolicyDate">Clear Cancel Date</a></li>  
      <li>  <button class="buttons" style="margin:15px 0;" id="policysave">SAVE</button>
<button class="buttons" style="margin:15px 0;" id="policycancel">CANCEL</button></li>
      </ul>    
<div class="clear"></div>

         <table id="policygrid" class="clear" style="width:100%;">
        </table>        
      </div>
      <div id="tabs-3">
      <ul class="formfields" style="width:336px;">
      <li><label class="bold">Coverage Type</label></li>
      <li class="clear"><input type="radio" name="ue_type" value="umbrella" <cfif ue_type is 'umbrella'>checked="checked" </cfif>/></li>
      <li><label>Umbrella&nbsp;&nbsp;&nbsp;</label></li>
      <li><input type="radio" name="ue_type" value="excess" <cfif ue_type is 'excess'>checked="checked" </cfif> /></li>
      <li><label>Excess</label></li>  
      <li class="clear"><label>&nbsp;</label></li>
          <li class="clear">
            <label class="bold width-120">Effective From/To</label>
          </li>
         
          <li>
           <input type="text" class="datebox width-80" name="ue_date1" id="ue_date1"  value="<cfoutput>#dateFormat(ue_date1,'mm/dd/yyyy')#</cfoutput>">
          </li>
          <li>
            <input type="text" class="datebox width-80" name="ue_date2" id="ue_date2"  value="<cfoutput>#dateFormat(ue_date2,'mm/dd/yyyy')#</cfoutput>">
          </li>   
         <li class="clear"><label>&nbsp;</label></li>
         <li class="clear"><label class="width-120">Issuing Company</label></li> 
         <li><select name="ue_issuing_company" id="ue_issuing_company" style="width:174px;" class="selectbox2" value="<cfoutput>#ue_issuing_company#</cfoutput>">
         	<option value="0">Please Select</option>
            <cfset parentname = "">
            <cfoutput query="rc.issuing">
            <cfif parentname neq rc.issuing.parent_company_name>
            <cfif parentname neq "">
            </optgroup>
            </cfif>
            <optgroup label="#rc.issuing.parent_company_name#">
            <cfif rc.issuing.name neq ''>
            <option value="#rc.issuing.issuing_company_id#"<cfif ue_issuing_company eq rc.issuing.issuing_company_id> selected="selected"</cfif>>#rc.issuing.name#</option>            
			</cfif>
            <cfelse>
            <cfif rc.issuing.name neq ''>
            <option value="#rc.issuing.issuing_company_id#"<cfif ue_issuing_company eq rc.issuing.issuing_company_id> selected="selected"</cfif>>#rc.issuing.name#</option>            
			</cfif>
            
            </cfif>
            <cfset parentname = rc.issuing.parent_company_name>
            </cfoutput>
            </select>
         </li> 
         <li class="clear"><label>&nbsp;</label></li>
         <li class="clear"><label class="width-120">Occurrence</label></li>     
         <li><input type="text" name="ue_occurrence" id="ue_occurrence" class="width-80 dollarmask" value="<cfoutput>#dollarFormat(ue_occurrence)#</cfoutput>" /></li>         
         <li class="clear"><label class="width-120">Aggregate</label></li>     
         <li><input type="text" name="ue_aggregate" id="ue_aggregate" class="width-80 dollarmask" value="<cfoutput>#dollarFormat(ue_aggregate)#</cfoutput>" /></li>
         <li class="clear"><label class="width-120">Retention</label></li>     
         <li><input type="text" name="ue_retention" id="ue_retention" class="width-80 dollarmask" value="<cfoutput>#dollarFormat(ue_retention)#</cfoutput>" /></li>         
      </ul>
<ul class="formfields" style="width:295px;">
<li><label class="bold">Premium Summary</label></li>
<li class="clear"><label class="width-150">State</label></li>  
<li style="padding-right:2px;">
<select id="ue_rate_state" name="ue_rate_state" class="selectbox2" style="width:54px; padding:5px 2px; font-style:italic;">
<option value="0">State</option>
	<cfloop query="rc.states">
	<cfoutput><option value="#state_id#" <cfif state_id eq ue_rate_state>selected</cfif>>#name#</option></cfoutput>
	</cfloop></select></li>
  <li><button id="ueratebutton" name="ueratebutton" class="buttons">RATE</button>
  <!---
         <li class="clear"><label class="width-150">Rate SL Tax</label></li>     
         <li><input type="text" name="ue_rate_sltax" id="ue_rate_sltax" class="width-80 percentmask" value="<cfoutput>#ue_rate_sltax#</cfoutput>" /></li> 
         <li class="clear"><label class="width-150">Filing Fee</label></li>     
         <li><input type="text" name="ue_rate_filingfee" id="ue_rate_filingfee" class="width-80 dollarmask" value="<cfoutput>#dollarFormat(ue_rate_filingfee)#</cfoutput>" /></li> 
                  <li class="clear"><label class="width-150">Stamping Fee</label></li>     
         <li><input type="text" name="ue_rate_stampingfee" id="ue_rate_stampingfee" class="width-80 percentmask" value="<cfoutput>#ue_rate_stampingfee#</cfoutput>" /></li> 
                  <li class="clear"><label class="width-150">State Surcharge</label></li>     
         <li><input type="text" name="ue_rate_statesurcharge" id="ue_rate_statesurcharge" class="width-80 percentmask" value="<cfoutput>#ue_rate_statesurcharge#</cfoutput>" /></li> 
                  <li class="clear"><label class="width-150">Muni Surcharge</label></li>     
         <li><input type="text" name="ue_rate_munisurcharge" id="ue_rate_munisurcharge" class="width-80 percentmask" value="<cfoutput>#ue_rate_munisurcharge#</cfoutput>" /></li>          
         <li class="clear"><label>&nbsp;</label></li>--->
         <li class="clear"><label class="width-150">Premium</label></li>  
            
         <li><input type="text" name="ue_premium" id="ue_premium" class="width-107 dollarmaskdec ueprem" value="<cfoutput>#dollarFormat(ue_premium)#</cfoutput>" /></li> 
          <li class="clear">
            <label class="width-79 tfeelabel">Terrorism Fee</label>
          </li>
          <li class="width-21">
          <input type="hidden" name="ue_terrorism_minimum" id="ue_terrorism_minimum" value="0">
            <input type="checkbox" name="ue_terrorism_rejected" value="1" id="ue_terrorism_rejected" class="plaincheck" <cfif ue_terrorism_rejected is 1>checked="checked"</cfif>>
          </li>
          <li>
            <label for="ue_terrorism_rejected" class="overridelabel">Rejected</label>
          </li>
          <li>
            <input type="hidden" name="ue_terrorism_fee" value="#ue_terrorism_fee#" id="ue_terrorism_fee">
            <input type="text" name="ue_terrorism_fee_field" value="<cfif ue_terrorism_rejected is 1>$0.00<cfelse><cfoutput>#ue_terrorism_fee#</cfoutput></cfif>" id="ue_terrorism_fee_field" class="width-107 dollarmaskdec readonly ueprem">
          </li>         
         <li class="clear"><label class="width-150">Surplus Tax/Surcharge</label></li>     
         <li><input type="text" name="ue_sltax" id="ue_sltax" class="width-107 dollarmaskdec ueprem" value="<cfoutput>#dollarFormat(ue_sltax)#</cfoutput>" /></li> 
         <li class="clear"><label class="width-150">Stamping Fee</label></li>     
         <li><input type="text" name="ue_stampingfee" id="ue_stampingfee" class="width-107 dollarmaskdec ueprem" value="<cfoutput>#dollarFormat(ue_stampingfee)#</cfoutput>" /></li>           
         <li class="clear"><label class="width-150">Filing Fee</label></li>     
         <li><input type="text" name="ue_filingfee" id="ue_filingfee" class="width-107 dollarmaskdec ueprem" value="<cfoutput>#dollarFormat(ue_filingfee)#</cfoutput>" /></li>                         
         <li class="clear"><label class="width-150">Broker Fee</label></li>     
         <li><input type="text" name="ue_brokerfee" id="ue_brokerfee" class="width-107 dollarmaskdec ueprem" value="<cfoutput>#dollarFormat(ue_brokerfee)#</cfoutput>" /></li>
         <li class="clear"><label class="width-150">Agency/RPG Fee</label></li> 
         <li><input type="text" name="ue_agencyfee" id="ue_agencyfee" class="width-107 dollarmaskdec ueprem" value="<cfoutput>#dollarFormat(ue_agencyfee)#</cfoutput>" /></li>              
         <li class="clear"><label class="bold width-150">Total Premium</label></li>     
         <li><input type="text" name="ue_totalpremium" id="ue_totalpremium" class="width-107 dollarmaskdec readonly" value="<cfoutput>#dollarFormat(ue_totalpremium)#</cfoutput>" /></li>           
</ul>   
<ul class="formfields">
<li class="clear"><label>&nbsp;</label></li>
<li class="clear"><input type="checkbox" name="ue_declined" id="ue_declined" value="1"<cfif ue_declined is 1> checked="checked"</cfif>></li>
<li><label>Umbrella/Excess Declined</label></li>
<li class="clear"><label>Reason</label></li>
<li class="clear"><textarea name="ue_declinedreason" id="ue_declinedreason" style="height:30px; width:425px;" class="txtleft"><cfoutput>#ue_declinedreason#</cfoutput></textarea></li>
<li class="clear"><label>Proposal Notes</label></li>
<li class="clear"><textarea name="ue_proposalnotes" id="ue_proposalnotes" style="height:70px; width:425px;" class="txtleft"><cfoutput>#ue_proposalnotes#</cfoutput></textarea></li>
<li class="clear"><label>Notes</label></li>
<li class="clear"><textarea name="ue_notes" id="ue_notes" style="height:70px; width:425px;" class="txtleft"><cfoutput>#ue_notes#</cfoutput></textarea></li>
</ul>
<ul class="formfields clear fullwidth" style="padding-top:20px;">
<cfif client_id neq 0><li><label class="bold">Account Consolidation</label></li>
<li class="clear"><select name="consolidate_id" id="consolidate_id" class="selectbox2"><option value="0">Select Account</option>
<cfoutput query="rc.getclients">
<option value="#client_id#">#ams# - #client_code# - #entity_name#</option>
</cfoutput>
</select></li>
<li><label><img src="/images/plus.png" class="plus" id="addconsolidate"></label></li>
</ul>
<div class="clear"></div>
         <table id="uegrid" class="clear" style="width:100%;">
        </table> 
</cfif>        
      </div>
      <div id="tabs-4">
      <ul class="formfields" style="width:355px;">
<li class="clear"><label>&nbsp;</label></li>
      <li class="clear"><label class="width-120">State(s)</label></li>  
<li><input type="text" name="wc_states" id="wc_states" class="width-80" value="<cfoutput>#wc_states#</cfoutput>" /></li>  
          <li class="clear">
            <label class="bold width-120">Effective From/To</label>
          </li>
         
          <li>
           <input type="text" class="datebox width-80" name="wc_effectivedate" id="wc_effectivedate"  value="<cfoutput>#dateFormat(wc_effectivedate,'mm/dd/yyyy')#</cfoutput>">
          </li>
          <li>
            <input type="text" class="datebox width-80" name="wc_expiredate" id="wc_expiredate"  value="<cfoutput>#dateFormat(wc_expiredate,'mm/dd/yyyy')#</cfoutput>">
          </li>   
         <li class="clear"><label class="width-120">Issuing Company</label></li> 
         <li><select name="wc_issuing_company" id="wc_issuing_company" style="width:174px;" class="selectbox2" value="<cfoutput>#wc_issuing_company#</cfoutput>">
         	<option value="0">Please Select</option>
            <cfset parentname = "">
            <cfoutput query="rc.issuing">
            <cfif parentname neq rc.issuing.parent_company_name>
            <cfif parentname neq "">
            </optgroup>
            </cfif>
            <optgroup label="#rc.issuing.parent_company_name#">
            <cfif rc.issuing.name neq ''>
            <option value="#rc.issuing.issuing_company_id#"<cfif wc_issuing_company eq rc.issuing.issuing_company_id> selected="selected"</cfif>>#rc.issuing.name#</option>            
			</cfif>
            <cfelse>
            <cfif rc.issuing.name neq ''>
            <option value="#rc.issuing.issuing_company_id#"<cfif wc_issuing_company eq rc.issuing.issuing_company_id> selected="selected"</cfif>>#rc.issuing.name#</option>            
			</cfif>
            
            </cfif>
            <cfset parentname = rc.issuing.parent_company_name>
            </cfoutput>
            </select>
         </li> 
         <li class="clear"><label>&nbsp;</label></li>

         <li class="clear"><label class="width-120">Premium</label></li>     
         <li><input type="text" name="wc_premium" id="wc_premium" class="width-80 dollarmaskdec wcprem" value="<cfoutput>#dollarFormat(wc_premium)#</cfoutput>" /></li>  
         <li class="clear"><label class="width-120">Agency Fee</label></li>     
         <li><input type="text" name="wc_agencyfee" id="wc_agencyfee" class="width-80 dollarmaskdec wcprem" value="<cfoutput>#dollarFormat(wc_agencyfee)#</cfoutput>" /></li>  
         <li class="clear"><label class="width-120">Total Premium</label></li>     
         <li><input type="text" name="wc_totalpremium" id="wc_totalpremium" class="width-80 dollarmaskdec" value="<cfoutput>#dollarFormat(wc_totalpremium)#</cfoutput>" /></li>                    
         <li class="clear"><label class="width-120">FEIN</label></li>     
         <li><input type="text" name="wc_fein" id="wc_fein" class="width-80" value="<cfoutput>#wc_fein#</cfoutput>" /></li>           
         <li class="clear"><label class="bold">Employee Count</label></li> 
         <li class="clear"><label class="width-120">Full Time</label></li>           
         <li><input type="text" name="wc_fulltime" id="wc_fulltime" class="width-80 numbermask wcemp" value="<cfoutput>#wc_fulltime#</cfoutput>" /></li>
         <li class="clear"><label class="width-120">Part Time</label></li>     
         <li><input type="text" name="wc_partime" id="wc_partime" class="width-80 numbermask wcemp" value="<cfoutput>#wc_partime#</cfoutput>" /></li>  
         <li class="clear"><label class="width-120">Total</label></li>     
         <li><input type="text" name="wc_totalemployees" id="wc_totalemployees" class="width-80 numbermask" value="<cfoutput>#wc_totalemployees#</cfoutput>" /></li>         <li class="clear"><label class="width-120">Total Payroll</label></li>     
         <li><input type="text" name="wc_payroll" id="wc_payroll" class="width-80 dollarmaskdec proll" value="<cfoutput>#dollarFormat(wc_payroll)#</cfoutput>" /></li>                  
      </ul>
<ul class="formfields" style="width:270px;">
<li class="clear"><label>&nbsp;</label></li>
<li class="clear"><label class="bold">Policy Limits</label></li>
<li class="clear"><label class="width-120">Each Accident</label></li>    
         <li><input type="text" name="wc_eachaccident" id="wc_eachaccident" class="width-80 dollarmask" value="<cfoutput>#dollarFormat(wc_eachaccident)#</cfoutput>" /></li> 
         <li class="clear"><label class="width-120">Disease Each Employee</label></li>     
         <li><input type="text" name="wc_diseaseeach" id="wc_diseaseeach" class="width-80 dollarmask" value="<cfoutput>#dollarFormat(wc_diseaseeach)#</cfoutput>" /></li> 
                  <li class="clear"><label class="width-120">Disease Policy Limit</label></li>     
         <li><input type="text" name="wc_diseaselimit" id="wc_diseaselimit" class="width-80 dollarmask" value="<cfoutput>#dollarFormat(wc_diseaselimit)#</cfoutput>" /></li> 
           
</ul>   
<ul class="formfields">
<li class="clear"><label>&nbsp;</label></li>
<li class="clear"><input type="checkbox" name="wc_declined" id="wc_declined" value="1"<cfif wc_declined is 1> checked="checked"</cfif>></li>
<li><label>Workers Compensation Declined</label></li>
<li class="clear"><label>Reason</label></li>
<li class="clear"><textarea name="wc_declinedreason" id="wc_declinedreason" style="height:36px; width:425px;" class="txtleft"><cfoutput>#wc_declinedreason#</cfoutput></textarea></li>
<!---
<li class="clear"><label>Proposal Notes</label></li>
<li class="clear"><textarea name="wc_proposalnotes" id="wc_proposalnotes" style="height:90px; width:425px;" class="txtleft"><cfoutput>#wc_proposalnotes#</cfoutput></textarea></li>--->
</ul>
<ul class="formfields" style="width:702px;">
<li class="clear"><label>&nbsp;</label></li>
         <li class="clear"><label class="width-195">Class Code</label></li>  
         <li><label class="width-195">Description</label></li>  
         <li><label class="width-50">Rate</label></li>   
         <li><label class="width-111">Payroll</label></li>      
         <li class="clear"><input type="text" name="wc_classcode" id="wc_classcode" class="width-195 txtleft" value="<cfoutput>#wc_classcode#</cfoutput>" /></li>  
         <li><input type="text" name="wc_classcode_desc" id="wc_classcode_desc" class="width-200 txtleft" value="<cfoutput>#wc_classcode_desc#</cfoutput>" /></li>           
         <li><input type="text" name="wc_rate" id="wc_rate" class="width-50 numberdecmask" value="<cfoutput>#numberFormat(wc_rate, '_.___')#</cfoutput>" /></li>
         <li><input type="text" name="wc_paybasis" id="wc_paybasis" class="width-111 dollarmaskdec proll payrollcalc" value="<cfoutput>#dollarFormat(wc_paybasis)#</cfoutput>" /></li>     
         <li class="clear"><input type="text" name="wc_classcode2" id="wc_classcode2" class="width-195 txtleft" value="<cfoutput>#wc_classcode2#</cfoutput>" /></li>  
         <li><input type="text" name="wc_classcode_desc2" id="wc_classcode_desc2" class="width-200 txtleft" value="<cfoutput>#wc_classcode_desc2#</cfoutput>" /></li>           
         <li><input type="text" name="wc_rate2" id="wc_rate2" class="width-50 numberdecmask" value="<cfoutput>#numberFormat(wc_rate2, '_.___')#</cfoutput>" /></li>
         <li><input type="text" name="wc_paybasis2" id="wc_paybasis2" class="width-111 dollarmaskdec proll payrollcalc" value="<cfoutput>#dollarFormat(wc_paybasis2)#</cfoutput>" /></li>         
</ul>         
<ul class="formfields" style="width:702px;">
<li class="clear"><label>&nbsp;</label></li>
<li class="clear"><label class="width-195">Owner/Partner Name</label></li>
<li><label class="width-195">Title</label></li>
<li><label class="width-50">% Owner</label></li>
<li><label class="width-111">Salary</label></li>
<li><label class="width-50">Included</label></li>
<li><label class="width-50">Excluded</label></li>
<!---
<li class="clear"><input type="text" name="owner_name" class="width-195 wcowners"></li>
<li><input type="text" name="owner_title" class="width-200 wcowners"></li>
<li><input type="text" name="owner_percent" class="width-50 wcowners"></li>
<li><input type="text" name="owner_salary" class="width-111 wcowners"></li>
<li style="width:58px; padding-left:10px;"><input type="checkbox" name="owner_include" value="1" /></li>
<li><input type="checkbox" name="owner_exclude" value="1" /></li>--->
<li class="clear" id="addwcowner"><label><img src="/images/plus.png" class="plus"></label></li>
<li class="clear"><label style="width:340px;">Proposal Notes</label></li>
<li><label>Notes</label></li>
<li class="clear"><textarea name="wc_proposalnotes" id="wc_proposalnotes" style="height:90px; width:340px;" class="txtleft"><cfoutput>#wc_proposalnotes#</cfoutput></textarea></li>
<li><textarea name="wc_notes" id="wc_notes" style="height:90px; width:345px;" class="txtleft"><cfoutput>#wc_notes#</cfoutput></textarea></li>
</ul>
<ul class="formfields clear fullwidth" style="padding-top:20px;">
<cfif client_id neq 0><li><label class="bold">Account Consolidation</label></li>
<li class="clear"><select name="wc_consolidate_id" id="wc_consolidate_id" class="selectbox2"><option value="0">Select Account</option>
<cfoutput query="rc.getclients">
<option value="#client_id#">#ams# - #client_code# - #entity_name#</option>
</cfoutput>
</select></li>
<li><label><img src="/images/plus.png" class="plus" id="addwcconsolidate"></label></li>
</ul>
<div class="clear"></div>
         <table id="wcgrid" class="clear" style="width:100%;">
        </table> 
</cfif>       
      </div>
      <div id="tabs-5">
 <ul class="formfields" style="width:355px;">
 <li class="clear"><label>&nbsp;</label></li>
          <li class="clear">
            <label class="width-120">Effective From/To</label>
          </li>
         
          <li>
           <input  type="text" class="datebox width-80" name="epli_date1" id="epli_date1"  value="<cfoutput>#dateFormat(epli_date1,'mm/dd/yyyy')#</cfoutput>">
          </li>
          <li>
            <input type="text" class="datebox width-80" name="epli_date2" id="epli_date2"  value="<cfoutput>#dateFormat(epli_date2,'mm/dd/yyyy')#</cfoutput>">
          </li>
          <li class="clear">
            <label class="width-120">Retro Date</label>
          </li>

          <li>
           <input type="text" class="datebox width-80" name="epli_retrodate" id="epli_retrodate"  value="<cfif epli_retrodate neq '01/01/1900'><cfoutput>#epli_retrodate#</cfoutput></cfif>"<cfif epli_prioracts eq 1> disabled="disabled"</cfif>>
          </li>  
         <li class="clear"><input type="checkbox" class="disablesomething" disablefield="epli_retrodate" name="epli_prioracts" id="epli_prioracts" value="1"<cfif epli_prioracts eq 1> checked</cfif>></li>
         <li><label for="epli_prioracts">Prior Acts</label></li>          
         <li class="clear"><label class="width-120">Issuing Company</label></li> 
         <li><select name="epli_issuing_company" id="epli_issuing_company" style="width:174px;" class="selectbox2" value="<cfoutput>#epli_issuing_company#</cfoutput>">
         	<option value="0">Please Select</option>
            <cfset parentname = "">
            <cfoutput query="rc.issuing">
            <cfif parentname neq rc.issuing.parent_company_name>
            <cfif parentname neq "">
            </optgroup>
            </cfif>
            <optgroup label="#rc.issuing.parent_company_name#">
            <cfif rc.issuing.name neq ''>
            <option value="#rc.issuing.issuing_company_id#"<cfif epli_issuing_company eq rc.issuing.issuing_company_id> selected="selected"</cfif>>#rc.issuing.name#</option>            
			</cfif>
            <cfelse>
            <cfif rc.issuing.name neq ''>
            <option value="#rc.issuing.issuing_company_id#"<cfif epli_issuing_company eq rc.issuing.issuing_company_id> selected="selected"</cfif>>#rc.issuing.name#</option>            
			</cfif>
            
            </cfif>
            <cfset parentname = rc.issuing.parent_company_name>
            </cfoutput>
            </select>
         </li>   
         <li class="clear"><label class="width-120">Aggregate</label></li>     
         <li><input type="text" name="epli_aggregate" id="epli_aggregate" class="width-80 dollarmask" value="<cfoutput>#dollarFormat(epli_aggregate)#</cfoutput>" /></li>
         <li class="clear"><label class="width-120">Retention</label></li>     
         <li><input type="text" name="epli_retention" id="epli_retention" class="width-80 dollarmask" value="<cfoutput>#dollarFormat(epli_retention)#</cfoutput>" /></li>
         <li class="clear"><label>&nbsp;</label></li>
         <li class="clear"><input type="checkbox" name="epli_doincluded" id="epli_doincluded" value="1"<cfif epli_doincluded is 1> checked="checked"</cfif> /></li>
         <li><label for="epli_doincluded">Directors &amp; Officers Included</label></li>
         <li class="clear"><label class="width-120">Aggregate</label></li>     
         <li><input type="text" name="epli_aggregate2" id="epli_aggregate2" class="width-80 dollarmask" value="<cfoutput>#dollarFormat(epli_aggregate2)#</cfoutput>" /></li>
         <li class="clear"><label class="width-120">Retention</label></li>     
         <li><input type="text" name="epli_retention2" id="epli_retention2" class="width-80 dollarmask" value="<cfoutput>#dollarFormat(epli_retention2)#</cfoutput>" /></li>         <li class="clear"><label class="bold">Employee Count</label></li> 
         <li class="clear"><label class="width-120">Full Time</label></li>           
         <li><input type="text" name="epli_fulltime" id="epli_fulltime" class="width-80 numbermask epliemp" value="<cfoutput>#epli_fulltime#</cfoutput>" /></li>
         <li class="clear"><label class="width-120">Part Time</label></li>     
         <li><input type="text" name="epli_partime" id="epli_partime" class="width-80 numbermask epliemp" value="<cfoutput>#epli_partime#</cfoutput>" /></li>  
         <li class="clear"><label class="width-120">Total</label></li>     
         <li><input type="text" name="epli_totalemployees" id="epli_totalemployees" class="width-80 numbermask" value="<cfoutput>#epli_totalemployees#</cfoutput>" /></li>         </ul> 
<ul class="formfields" style="width:270px;">
<li><label class="bold">Premium Summary</label></li>
         <li class="clear"><label class="width-120">Premium</label></li>     
         <li><input type="text" name="epli_premium" id="epli_premium" class="width-80 dollarmask epliprem" value="<cfoutput>#dollarFormat(epli_premium)#</cfoutput>" /></li> 
         
         <li class="clear"><label class="width-120">Surplus Tax/Surcharge</label></li>     
         <li><input type="text" name="epli_sltax" id="epli_sltax" class="width-80 dollarmaskdec epliprem" value="<cfoutput>#dollarFormat(epli_sltax)#</cfoutput>" /></li>  
         <li class="clear"><label class="width-120">Filing Fee</label></li>     
         <li><input type="text" name="epli_filingfee" id="epli_filingfee" class="width-80 dollarmask epliprem" value="<cfoutput>#dollarFormat(epli_filingfee)#</cfoutput>" /></li>                         
         <li class="clear"><label class="width-120">Broker Fee</label></li>     
         <li><input type="text" name="epli_brokerfee" id="epli_brokerfee" class="width-80 dollarmaskdec epliprem" value="<cfoutput>#dollarFormat(epli_brokerfee)#</cfoutput>" /></li>
         <li class="clear"><label class="width-120">Agency/RPG Fee</label></li> 
         <li><input type="text" name="epli_agencyfee" id="epli_agencyfee" class="width-80 dollarmask epliprem" value="<cfoutput>#dollarFormat(epli_agencyfee)#</cfoutput>" /></li>              
         <li class="clear"><label class="bold width-120">Total Premium</label></li>     
         <li><input type="text" name="epli_totalpremium" id="epli_totalpremium" class="width-80 dollarmaskdec readonly" value="<cfoutput>#dollarFormat(epli_totalpremium)#</cfoutput>" /></li>           
</ul> 
<ul class="formfields">
<li class="clear"><label>&nbsp;</label></li>
<li class="clear"><input type="checkbox" name="epli_declined" id="epli_declined" value="1"<cfif epli_declined is 1> checked="checked"</cfif>></li>
<li><label>EPLI Declined</label></li>
<li class="clear"><label>Reason</label></li>
<li class="clear"><textarea name="epli_declinedreason" id="epli_declinedreason" style="height:30px; width:425px;" class="txtleft"><cfoutput>#epli_declinedreason#</cfoutput></textarea></li>
<li class="clear"><label>Proposal Notes</label></li>
<li class="clear"><textarea name="epli_proposalnotes" id="epli_proposalnotes" style="height:70px; width:425px;" class="txtleft"><cfoutput>#epli_proposalnotes#</cfoutput></textarea></li>
<li class="clear"><label>Notes</label></li>
<li class="clear"><textarea name="epli_notes" id="epli_notes" style="height:70px; width:425px;" class="txtleft"><cfoutput>#epli_notes#</cfoutput></textarea></li>
</ul>
<ul class="formfields clear fullwidth" style="padding-top:20px;">
<cfif client_id neq 0><li><label class="bold">Account Consolidation</label></li>
<li class="clear"><select name="epli_consolidate_id" id="epli_consolidate_id" class="selectbox2"><option value="0">Select Account</option>
<cfoutput query="rc.getclients">
<option value="#client_id#">#ams# - #client_code# - #entity_name#</option>
</cfoutput>
</select></li>
<li><label><img src="/images/plus.png" class="plus" id="addepliconsolidate"></label></li>
</ul>
<div class="clear"></div>
         <table id="epligrid" class="clear" style="width:100%;">
        </table>   
</cfif>                   
      </div>
      <div id="tabs-6">
      <ul class="formfields fullwidth addNIul">
      <li class="clear addnili1" id="addNI"><label><img src="/images/plus.png" class="plus"></label></li>
      <li style="padding-top:2px;" class="addnili2"><label class="addnilabel">Add Named Insured</label></li>
      </ul>     
      <ul class="formfields niformul txtleft" style="width:340px;">
      <li class="clear"><label>&nbsp;</label><input type="hidden" name="named_insured_id" id="named_insured_id" value="0" class="nifields" /></li>
      <li class="clear"><label class="width-85">Entity Name</label></li> 
      <li><input type="text" name="named_insured" id="named_insured" class="nifields width-180" /></li>
      <li class="clear"><label class="width-85">FEIN</label></li> 
      <li><input type="text" name="ni_fein" id="ni_fein" class="nifields width-180" /></li>
      <li class="clear"><label class="width-85">Year Started</label></li> 
      <li><input type="text" name="yearstarted" id="yearstarted" class="nifields width-180" /></li>
      <li class="clear"><label class="width-85">Relationship</label></li> 
      <li>
<select name="relationship" id="relationship" style="width:186px;" class="selectbox2 nifields">
         	<option value="0">Please Select</option>   
 <cfoutput query="rc.nirelationships"><option value="#rc.nirelationships.ni_relationship_id#"<cfif other_loc eq rc.nirelationships.ni_relationship_id> selected="selected"</cfif>>#rc.nirelationships.ni_relationship#</option></cfoutput>              

</select> 
</li>        
      <!---
      <li><input type="text" name="relationship" id="relationship" class="nifields width-180" /></li>--->
      <li class="clear"><button class="buttons" style="margin:15px 0;" id="nisave">SAVE</button>
<button class="buttons" style="margin:15px 0;" id="nicancel">CANCEL</button></li>               
      </ul>
      <ul class="formfields niformul" style="width:200px;">
      <li class="clear"><label>Applicable Lines of Coverage</label></li>
      <li class="clear"><input type="checkbox" name="gl" id="gl" class="nichecks" /></li> 
      <li><label class="width-85">General Liability</label></li>
      <li class="clear"><input type="checkbox" name="property" id="property" class="nichecks" /></li> 
      <li><label class="width-85">Property</label></li>
      <li class="clear"><input type="checkbox" name="ue" id="ue" class="nichecks" /></li> 
      <li><label class="width-85">Umbrella/Excess</label></li>
      <li class="clear"><input type="checkbox" name="wc" id="wc" class="nichecks" /></li> 
      <li><label class="width-85">Workers' Comp</label></li>
      <li class="clear"><input type="checkbox" name="epli" id="epli" class="nichecks" /></li> 
      <li><label class="width-85">EPL</label></li>    
      <li class="clear"><input type="checkbox" name="cyber" id="cyber" class="nichecks" /></li> 
      <li><label class="width-85">Cyber</label></li>                            
      </ul>  
      <ul class="formfields niformul" style="width:521px;"> 
      <li class="clear"><label>Notes</label></li>
      <li class="clear"><textarea name="notes" id="notes" class="nifields txtleft" style="height:100px; width:516px;"></textarea></li>
      </ul>   
      <div class="clear"></div>
         <table id="nigrid">
        </table>        
      </div>
      <div id="tabs-7">
      </div>  
      <div id="tabs-8">
        <cfoutput>
  <div style="margin:5px 0 15px;">X-Reference ID: <span  class="uppercase">#x_reference#</span></div>
  <div style="width: 100%;" class="ui-widget wijmo-wijgrid ui-widget-content ui-corner-all">

    <table tabindex="0" id="xrefgrid" class="clear wijmo-wijgrid-root wijmo-wijgrid-table" style="border-collapse: separate; width: 100%; table-layout: fixed;" border="0" cellpadding="0" cellspacing="0">
      <thead>
        <tr class="wijmo-wijgrid-headerrow" role="row">
          <th  scope="col" role="columnheader" class="wijgridth ui-widget wijmo-c1basefield ui-state-default wijmo-c1field"><div class="wijmo-wijgrid-innercell xref1">Client Code</div></th>
          <th  scope="col" role="columnheader" class="wijgridth ui-widget wijmo-c1basefield ui-state-default wijmo-c1field"><div class="wijmo-wijgrid-innercell xref1">AMS</div></th>
          <th scope="col" role="columnheader" class="wijgridth ui-widget wijmo-c1basefield ui-state-default wijmo-c1field"><div class="wijmo-wijgrid-innercell xref1">Entity Name</div></th>
          <th scope="col" role="columnheader" class="wijgridth ui-widget wijmo-c1basefield ui-state-default wijmo-c1field"><div class="wijmo-wijgrid-innercell xref1">DBA</div></th>
          <th scope="col" role="columnheader" class="wijgridth ui-widget wijmo-c1basefield ui-state-default wijmo-c1field"><div class="wijmo-wijgrid-innercell xref1">Status</div></th>
          <th scope="col" role="columnheader" class="wijgridth ui-widget wijmo-c1basefield ui-state-default wijmo-c1field"><div class="wijmo-wijgrid-innercell xref1">Jump</div></th>
        </tr>
      </thead>

      <tbody class="ui-widget-content wijmo-wijgrid-data">
<cfset thisone = 0>     
<cfif client_id neq 0> 
<cfloop query="rc.xrefs">    

<cfif thisone neq rc.xrefs.client_id>
        <tr class="wijmo-wijgrid-row ui-widget-content wijmo-wijgrid-datarow" role="row">
          <td class="wijgridtd wijdata-type-string"><div class="wijmo-wijgrid-innercell">#rc.xrefs.client_code#</div></td>
          <td class="wijgridtd wijdata-type-string"><div class="wijmo-wijgrid-innercell">#rc.xrefs.ams#</div></td>
          <td class="wijgridtd wijdata-type-string"><div class="wijmo-wijgrid-innercell">#rc.xrefs.entity_name#</div></td>
          <td class="wijgridtd wijdata-type-string"><div class="wijmo-wijgrid-innercell">#rc.xrefs.dba#</div></td>
          <td class="wijgridtd wijdata-type-string"><div class="wijmo-wijgrid-innercell">#rc.xrefs.status#</div></td>
          <td class="wijgridtd wijdata-type-string"><div class="wijmo-wijgrid-innercell"><a href="/index.cfm?event=main.client&client_id=#rc.xrefs.client_id#" target="_blank"><img src="/images/quickpickbutton.png" class="imagebuttons" jump_id="23"></a></div></td>
        </tr>
       
        <tr class="wijmo-wijgrid-row ui-widget-content wijmo-wijgrid-datarow" role="row">
          <td colspan="6" aria-selected="true" headers="DELETE" role="gridcell" class="wijgridtd wijdata-type-string" style="background-color:##ccc"><div class="wijmo-wijgrid-innercell"><ul class="loclist"><li class="locli1">Location</li><li class="locli2">Location Address</li><li class="locli2">Status</li></ul></div></td>
        </tr> 
        
        <tr class="wijmo-wijgrid-row ui-widget-content wijmo-wijgrid-datarow" role="row">
          <td colspan="6" aria-selected="true" headers="DELETE" role="gridcell" class="wijgridtd wijdata-type-string loctd"><div class="wijmo-wijgrid-innercell"><ul class="loclist">
          </cfif><li class="locli1"><!---Location #rc.xrefs.client_id# Thisone: #thisone#</li>---><li class="locli2">#rc.xrefs.address#, #rc.xrefs.city#, #rc.xrefs.state#</li><li class="locli2">#rc.xrefs.location_status_id#</li>
<cfif thisone eq rc.xrefs.client_id>          
          </ul></div></td>
        </tr> 
</cfif>        
        <cfset thisone = rc.xrefs.client_id>               
</cfloop>    
</cfif>                    
      </tbody>
    </table>
    </cfoutput>
  </div>    
      </div>  
<div id="tabs-9">
 <ul class="formfields" style="width:355px;">
 <li class="clear"><label>&nbsp;</label></li>

          <li class="clear">
            <label class="width-120">Bond Type</label>
          </li>
         
          <li>
           <input type="text" class="width-172 txtleft" name="bond_type" id="bond_type"  value="<cfoutput>#bond_type#</cfoutput>">
          </li>  
         <li class="clear"><label class="width-120">Issuing Company</label></li> 
         <li><select name="bond_issuing_company" id="bond_issuing_company" style="width:178px;" class="selectbox2" value="<cfoutput>#bond_issuing_company#</cfoutput>">
         	<option value="0">Please Select</option>
            <cfset parentname = "">
            <cfoutput query="rc.issuing">
            <cfif parentname neq rc.issuing.parent_company_name>
            <cfif parentname neq "">
            </optgroup>
            </cfif>
            <optgroup label="#rc.issuing.parent_company_name#">
            <cfif rc.issuing.name neq ''>
            <option value="#rc.issuing.issuing_company_id#"<cfif bond_issuing_company eq rc.issuing.issuing_company_id> selected="selected"</cfif>>#rc.issuing.name#</option>            
			</cfif>
            <cfelse>
            <cfif rc.issuing.name neq ''>
            <option value="#rc.issuing.issuing_company_id#"<cfif bond_issuing_company eq rc.issuing.issuing_company_id> selected="selected"</cfif>>#rc.issuing.name#</option>            
			</cfif>
            
            </cfif>
            <cfset parentname = rc.issuing.parent_company_name>
            </cfoutput>
            </select>
         </li>   
         <li class="clear"><label>&nbsp;</label></li>
         <li class="clear"><label class="width-120">Bond Amount</label></li>     
         <li><input type="text" name="bond_amount" id="bond_amount" class="width-80 dollarmask" value="<cfoutput>#dollarFormat(bond_amount)#</cfoutput>" /></li>
         <li class="clear"><label class="width-120 txtleft">Obligee</label></li>     
         <li><input type="text" name="bond_obligee" id="bond_obligee" class="width-172 txtleft" value="<cfoutput>#bond_obligee#</cfoutput>" /></li>
         </ul> 
<ul class="formfields" style="width:270px;">
<li><label class="bold">Premium Summary</label></li>
         <li class="clear"><label class="width-120">Bond Premium</label></li>     
         <li><input type="text" name="bond_premium" id="bond_premium" class="width-80 dollarmask bondprem" value="<cfoutput>#dollarFormat(bond_premium)#</cfoutput>" /></li> 
         
         <li class="clear"><label class="width-120">Fees</label></li>     
         <li><input type="text" name="bond_fees" id="bond_fees" class="width-80 dollarmask bondprem" value="<cfoutput>#dollarFormat(bond_fees)#</cfoutput>" /></li>  
         <li class="clear"><label class="width-120">Delivery Fee</label></li>     
         <li><input type="text" name="bond_deliveryfee" id="bond_deliveryfee" class="width-80 dollarmask bondprem" value="<cfoutput>#dollarFormat(bond_deliveryfee)#</cfoutput>" /></li>                         
         <li class="clear"><label class="width-120">Tax/Surcharge</label></li>     
         <li><input type="text" name="bond_tax" id="bond_tax" class="width-80 dollarmask bondprem" value="<cfoutput>#dollarFormat(bond_tax)#</cfoutput>" /></li>

         <li class="clear"><label class="bold width-120">Total Premium</label></li>     
         <li><input type="text" name="bond_totalpremium" id="bond_totalpremium" class="width-80 dollarmask readonly" value="<cfoutput>#dollarFormat(bond_totalpremium)#</cfoutput>" /></li>           
</ul> 
<ul class="formfields">
<li class="clear"><label>&nbsp;</label></li>
<li class="clear"><input type="checkbox" name="bond_declined" id="bond_declined" value="1"<cfif bond_declined is 1> checked="checked"</cfif>></li>
<li><label>Bond Declined</label></li>
<li class="clear"><label>Reason</label></li>
<li class="clear"><textarea name="bond_declinedreason" id="bond_declinedreason" style="height:30px; width:425px;" class="txtleft"><cfoutput>#bond_declinedreason#</cfoutput></textarea></li>
<li class="clear"><label>Notes</label></li>
<li class="clear"><textarea name="bond_notes" id="bond_notes" style="height:70px; width:425px;" class="txtleft"><cfoutput>#bond_notes#</cfoutput></textarea></li>

</ul>

<div class="clear"></div>
</div> 
<!---OTHER 1--->
<div id="tabs-10" othertab="1">
 <ul class="formfields" style="width:370px;">
 <li class="clear"><label>&nbsp;</label></li>

          <li class="clear">
            <label class="width-153">Policy Type</label>
          </li>
         
          <li>
<select name="other_loc" id="other_loc" style="width:174px;" class="selectbox2">
         	<option value="0">Please Select</option>   
 <cfoutput query="rc.policytypes"><option value="#rc.policytypes.policy_type_id#"<cfif other_loc eq rc.policytypes.policy_type_id> selected="selected"</cfif>>#rc.policytypes.policy_type#</option></cfoutput>              
<!---            <cfoutput query="rc.loc">    
<option value="#rc.loc.other_loc_id#"<cfif other_loc eq rc.loc.other_loc_id> selected="selected"</cfif>>#rc.loc.loc_name#</option>
</cfoutput>--->
</select>              
          </li>  
          <li class="clear">
            <label class="width-153">Effective From/To</label>
          </li>
         
          <li>
           <input type="text" class="datebox width-80" name="other_effectivedate" id="other_effectivedate"  value="<cfoutput>#dateFormat(other_effectivedate,'mm/dd/yyyy')#</cfoutput>">
          </li>
          <li>
            <input type="text" class="datebox width-80" name="other_expiredate" id="other_expiredate"  value="<cfoutput>#dateFormat(other_expiredate,'mm/dd/yyyy')#</cfoutput>">
          </li>            
         <li class="clear"><label class="width-153">Issuing Company</label></li> 
         <li><select name="other_issuing_company" id="other_issuing_company" style="width:174px;" class="selectbox2" value="<cfoutput>#other_issuing_company#</cfoutput>">
         	<option value="0">Please Select</option>
            <cfset parentname = "">
            <cfoutput query="rc.issuing">
            <cfif parentname neq rc.issuing.parent_company_name>
            <cfif parentname neq "">
            </optgroup>
            </cfif>
            <optgroup label="#rc.issuing.parent_company_name#">
            <cfif rc.issuing.name neq ''>
            <option value="#rc.issuing.issuing_company_id#"<cfif other_issuing_company eq rc.issuing.issuing_company_id> selected="selected"</cfif>>#rc.issuing.name#</option>            
			</cfif>
            <cfelse>
            <cfif rc.issuing.name neq ''>
            <option value="#rc.issuing.issuing_company_id#"<cfif other_issuing_company eq rc.issuing.issuing_company_id> selected="selected"</cfif>>#rc.issuing.name#</option>            
			</cfif>
            
            </cfif>
            <cfset parentname = rc.issuing.parent_company_name>
            </cfoutput>
            </select>
         </li>   
         
         <li class="clear"><input type="radio" name="other_dedret" value="Deductible"<cfif other_dedret is 'Deductible'> checked="checked"</cfif> /></li>
         <li><label>Deductible</label></li>
         <li><input type="radio" name="other_dedret" value="Retention"<cfif other_dedret is 'Retention'> checked="checked"</cfif> /></li>
         <li><label style="width:53px;">Retention</label></li>
         <li><input type="text" name="other_dedretamount" id="other_dedretamount" class="width-80 dollarmask" value="<cfoutput>#dollarFormat(other_dedretamount)#</cfoutput>" /></li>
         <li class="clear"><label>&nbsp;</label></li>
         <li class="clear"><label class="txtleft" style="visibility:hidden">Coverage</label></li>
         <li><label class="width-190">Description</label></li>
         <li><label class="width-80">Limit</label></li>

    <li class="clear addloc" id="addloc1"><label><img src="/images/plus.png" class="plus"></label></li>     
         </ul> 
<ul class="formfields" style="width:260px;">
<li><label class="bold">Premium Summary</label></li>
         <li class="clear"><label class="width-120">Premium</label></li>     
         <li><input type="text" name="other_premium" id="other_premium" class="width-80 dollarmask otherprem" value="<cfoutput>#dollarFormat(other_premium)#</cfoutput>" /></li> 
         
         <li class="clear"><label class="width-120">Broker Fee</label></li>     
         <li><input type="text" name="other_brokerfee" id="other_brokerfee" class="width-80 dollarmask otherprem" value="<cfoutput>#dollarFormat(other_brokerfee)#</cfoutput>" /></li>  
         <li class="clear"><label class="width-120">Agency Fee</label></li>     
         <li><input type="text" name="other_agencyfee" id="other_agencyfee" class="width-80 dollarmask otherprem" value="<cfoutput>#dollarFormat(other_agencyfee)#</cfoutput>" /></li>                         
         <li class="clear"><label class="width-120">Tax/Surcharge</label></li>     
         <li><input type="text" name="other_tax" id="other_tax" class="width-80 dollarmask otherprem" value="<cfoutput>#dollarFormat(other_tax)#</cfoutput>" /></li>
         <li class="clear"><label class="width-120">Filing Fee</label></li>     
         <li><input type="text" name="other_filingfee" id="other_filingfee" class="width-80 dollarmask otherprem" value="<cfoutput>#dollarFormat(other_filingfee)#</cfoutput>" /></li>
         <li class="clear"><label class="width-120">RPG Fee</label></li>     
         <li><input type="text" name="other_rpgfee" id="other_rpgfee" class="width-80 dollarmask otherprem" value="<cfoutput>#dollarFormat(other_rpgfee)#</cfoutput>" /></li>         
         <li class="clear"><label class="bold width-120">Total Premium</label></li>     
         <li><input type="text" name="other_totalpremium" id="other_totalpremium" class="width-80 dollarmask readonly" value="<cfoutput>#dollarFormat(other_totalpremium)#</cfoutput>" /></li>           
</ul> 
<ul class="formfields">
<li class="clear"><label>&nbsp;</label></li>
<li class="clear"><label>Proposal Notes</label></li>
<li class="clear"><textarea name="other_proposalnotes" id="other_proposalnotes" style="height:90px; width:425px;" class="txtleft"><cfoutput>#other_proposalnotes#</cfoutput></textarea></li>
<li class="clear"><label>Notes</label></li>
<li class="clear"><textarea name="other_notes" id="other_notes" style="height:90px; width:425px;" class="txtleft"><cfoutput>#other_notes#</cfoutput></textarea></li>

</ul>

<div class="clear"></div>
</div>  
<!---OTHER 2--->
<div id="tabs-11" othertab="2">
 <ul class="formfields" style="width:370px;">
 <li class="clear"><label>&nbsp;</label></li>

          <li class="clear">
            <label class="width-153">Policy Type</label>
          </li>
         
          <li>
<select name="other2_loc" id="other2_loc" style="width:174px;" class="selectbox2">
         	<option value="0">Please Select</option>   
 <cfoutput query="rc.policytypes"><option value="#rc.policytypes.policy_type_id#"<cfif other2_loc eq rc.policytypes.policy_type_id> selected="selected"</cfif>>#rc.policytypes.policy_type#</option></cfoutput>              
<!---            <cfoutput query="rc.loc">    
<option value="#rc.loc.other2_loc_id#"<cfif other2_loc eq rc.loc.other2_loc_id> selected="selected"</cfif>>#rc.loc.loc_name#</option>
</cfoutput>--->
</select>              
          </li>  
          <li class="clear">
            <label class="width-153">Effective From/To</label>
          </li>
         
          <li>
           <input type="text" class="datebox width-80" name="other2_effectivedate" id="other2_effectivedate"  value="<cfoutput>#dateFormat(other2_effectivedate,'mm/dd/yyyy')#</cfoutput>">
          </li>
          <li>
            <input type="text" class="datebox width-80" name="other2_expiredate" id="other2_expiredate"  value="<cfoutput>#dateFormat(other2_expiredate,'mm/dd/yyyy')#</cfoutput>">
          </li>            
         <li class="clear"><label class="width-153">Issuing Company</label></li> 
         <li><select name="other2_issuing_company" id="other2_issuing_company" style="width:174px;" class="selectbox2" value="<cfoutput>#other2_issuing_company#</cfoutput>">
         	<option value="0">Please Select</option>
            <cfset parentname = "">
            <cfoutput query="rc.issuing">
            <cfif parentname neq rc.issuing.parent_company_name>
            <cfif parentname neq "">
            </optgroup>
            </cfif>
            <optgroup label="#rc.issuing.parent_company_name#">
            <cfif rc.issuing.name neq ''>
            <option value="#rc.issuing.issuing_company_id#"<cfif other2_issuing_company eq rc.issuing.issuing_company_id> selected="selected"</cfif>>#rc.issuing.name#</option>            
			</cfif>
            <cfelse>
            <cfif rc.issuing.name neq ''>
            <option value="#rc.issuing.issuing_company_id#"<cfif other2_issuing_company eq rc.issuing.issuing_company_id> selected="selected"</cfif>>#rc.issuing.name#</option>            
			</cfif>
            
            </cfif>
            <cfset parentname = rc.issuing.parent_company_name>
            </cfoutput>
            </select>
         </li>   
         
         <li class="clear"><input type="radio" name="other2_dedret" value="Deductible"<cfif other2_dedret is 'Deductible'> checked="checked"</cfif> /></li>
         <li><label>Deductible</label></li>
         <li><input type="radio" name="other2_dedret" value="Retention"<cfif other2_dedret is 'Retention'> checked="checked"</cfif> /></li>
         <li><label style="width:53px;">Retention</label></li>
         <li><input type="text" name="other2_dedretamount" id="other2_dedretamount" class="width-80 dollarmask" value="<cfoutput>#dollarFormat(other2_dedretamount)#</cfoutput>" /></li>
         <li class="clear"><label>&nbsp;</label></li>
         <li class="clear"><label class="txtleft" style="visibility:hidden">Coverage</label></li>
         <li><label class="width-190">Description</label></li>
         <li><label class="width-80">Limit</label></li>

    <li class="clear addloc" id="addloc2"><label><img src="/images/plus.png" class="plus"></label></li>     
         </ul> 
<ul class="formfields" style="width:260px;">
<li><label class="bold">Premium Summary</label></li>
         <li class="clear"><label class="width-120">Premium</label></li>     
         <li><input type="text" name="other2_premium" id="other2_premium" class="width-80 dollarmask other2prem" value="<cfoutput>#dollarFormat(other2_premium)#</cfoutput>" /></li> 
         
         <li class="clear"><label class="width-120">Broker Fee</label></li>     
         <li><input type="text" name="other2_brokerfee" id="other2_brokerfee" class="width-80 dollarmask other2prem" value="<cfoutput>#dollarFormat(other2_brokerfee)#</cfoutput>" /></li>  
         <li class="clear"><label class="width-120">Agency Fee</label></li>     
         <li><input type="text" name="other2_agencyfee" id="other2_agencyfee" class="width-80 dollarmask other2prem" value="<cfoutput>#dollarFormat(other2_agencyfee)#</cfoutput>" /></li>                         
         <li class="clear"><label class="width-120">Tax/Surcharge</label></li>     
         <li><input type="text" name="other2_tax" id="other2_tax" class="width-80 dollarmask other2prem" value="<cfoutput>#dollarFormat(other2_tax)#</cfoutput>" /></li>
         <li class="clear"><label class="width-120">Filing Fee</label></li>     
         <li><input type="text" name="other2_filingfee" id="other2_filingfee" class="width-80 dollarmask other2prem" value="<cfoutput>#dollarFormat(other2_filingfee)#</cfoutput>" /></li>
         <li class="clear"><label class="width-120">RPG Fee</label></li>     
         <li><input type="text" name="other2_rpgfee" id="other2_rpgfee" class="width-80 dollarmask other2prem" value="<cfoutput>#dollarFormat(other2_rpgfee)#</cfoutput>" /></li>         
         <li class="clear"><label class="bold width-120">Total Premium</label></li>     
         <li><input type="text" name="other2_totalpremium" id="other2_totalpremium" class="width-80 dollarmask readonly" value="<cfoutput>#dollarFormat(other2_totalpremium)#</cfoutput>" /></li>           
</ul> 
<ul class="formfields">
<li class="clear"><label>&nbsp;</label></li>
<li class="clear"><label>Proposal Notes</label></li>
<li class="clear"><textarea name="other2_proposalnotes" id="other2_proposalnotes" style="height:90px; width:425px;" class="txtleft"><cfoutput>#other2_proposalnotes#</cfoutput></textarea></li>
<li class="clear"><label>Notes</label></li>
<li class="clear"><textarea name="other2_notes" id="other2_notes" style="height:90px; width:425px;" class="txtleft"><cfoutput>#other2_notes#</cfoutput></textarea></li>

</ul>

<div class="clear"></div>
</div>  
<!---OTHER 3--->
<div id="tabs-12" othertab="3">
 <ul class="formfields" style="width:370px;">
 <li class="clear"><label>&nbsp;</label></li>

          <li class="clear">
            <label class="width-153">Policy Type</label>
          </li>
         
          <li>
<select name="other3_loc" id="other3_loc" style="width:174px;" class="selectbox2">
         	<option value="0">Please Select</option>   
 <cfoutput query="rc.policytypes"><option value="#rc.policytypes.policy_type_id#"<cfif other3_loc eq rc.policytypes.policy_type_id> selected="selected"</cfif>>#rc.policytypes.policy_type#</option></cfoutput>              
<!---            <cfoutput query="rc.loc">    
<option value="#rc.loc.other3_loc_id#"<cfif other3_loc eq rc.loc.other3_loc_id> selected="selected"</cfif>>#rc.loc.loc_name#</option>
</cfoutput>--->
</select>              
          </li>  
          <li class="clear">
            <label class="width-153">Effective From/To</label>
          </li>
         
          <li>
           <input type="text" class="datebox width-80" name="other3_effectivedate" id="other3_effectivedate"  value="<cfoutput>#dateFormat(other3_effectivedate,'mm/dd/yyyy')#</cfoutput>">
          </li>
          <li>
            <input type="text" class="datebox width-80" name="other3_expiredate" id="other3_expiredate"  value="<cfoutput>#dateFormat(other3_expiredate,'mm/dd/yyyy')#</cfoutput>">
          </li>            
         <li class="clear"><label class="width-153">Issuing Company</label></li> 
         <li><select name="other3_issuing_company" id="other3_issuing_company" style="width:174px;" class="selectbox2" value="<cfoutput>#other3_issuing_company#</cfoutput>">
         	<option value="0">Please Select</option>
            <cfset parentname = "">
            <cfoutput query="rc.issuing">
            <cfif parentname neq rc.issuing.parent_company_name>
            <cfif parentname neq "">
            </optgroup>
            </cfif>
            <optgroup label="#rc.issuing.parent_company_name#">
            <cfif rc.issuing.name neq ''>
            <option value="#rc.issuing.issuing_company_id#"<cfif other3_issuing_company eq rc.issuing.issuing_company_id> selected="selected"</cfif>>#rc.issuing.name#</option>            
			</cfif>
            <cfelse>
            <cfif rc.issuing.name neq ''>
            <option value="#rc.issuing.issuing_company_id#"<cfif other3_issuing_company eq rc.issuing.issuing_company_id> selected="selected"</cfif>>#rc.issuing.name#</option>            
			</cfif>
            
            </cfif>
            <cfset parentname = rc.issuing.parent_company_name>
            </cfoutput>
            </select>
         </li>   
         
         <li class="clear"><input type="radio" name="other3_dedret" value="Deductible"<cfif other3_dedret is 'Deductible'> checked="checked"</cfif> /></li>
         <li><label>Deductible</label></li>
         <li><input type="radio" name="other3_dedret" value="Retention"<cfif other3_dedret is 'Retention'> checked="checked"</cfif> /></li>
         <li><label style="width:53px;">Retention</label></li>
         <li><input type="text" name="other3_dedretamount" id="other3_dedretamount" class="width-80 dollarmask" value="<cfoutput>#dollarFormat(other3_dedretamount)#</cfoutput>" /></li>
         <li class="clear"><label>&nbsp;</label></li>
         <li class="clear"><label class="txtleft" style="visibility:hidden">Coverage</label></li>
         <li><label class="width-190">Description</label></li>
         <li><label class="width-80">Limit</label></li>

    <li class="clear addloc" id="addloc3"><label><img src="/images/plus.png" class="plus"></label></li>     
         </ul> 
<ul class="formfields" style="width:260px;">
<li><label class="bold">Premium Summary</label></li>
         <li class="clear"><label class="width-120">Premium</label></li>     
         <li><input type="text" name="other3_premium" id="other3_premium" class="width-80 dollarmask other3prem" value="<cfoutput>#dollarFormat(other3_premium)#</cfoutput>" /></li> 
         
         <li class="clear"><label class="width-120">Broker Fee</label></li>     
         <li><input type="text" name="other3_brokerfee" id="other3_brokerfee" class="width-80 dollarmask other3prem" value="<cfoutput>#dollarFormat(other3_brokerfee)#</cfoutput>" /></li>  
         <li class="clear"><label class="width-120">Agency Fee</label></li>     
         <li><input type="text" name="other3_agencyfee" id="other3_agencyfee" class="width-80 dollarmask other3prem" value="<cfoutput>#dollarFormat(other3_agencyfee)#</cfoutput>" /></li>                         
         <li class="clear"><label class="width-120">Tax/Surcharge</label></li>     
         <li><input type="text" name="other3_tax" id="other3_tax" class="width-80 dollarmask other3prem" value="<cfoutput>#dollarFormat(other3_tax)#</cfoutput>" /></li>
         <li class="clear"><label class="width-120">Filing Fee</label></li>     
         <li><input type="text" name="other3_filingfee" id="other3_filingfee" class="width-80 dollarmask other3prem" value="<cfoutput>#dollarFormat(other3_filingfee)#</cfoutput>" /></li>
         <li class="clear"><label class="width-120">RPG Fee</label></li>     
         <li><input type="text" name="other3_rpgfee" id="other3_rpgfee" class="width-80 dollarmask other3prem" value="<cfoutput>#dollarFormat(other3_rpgfee)#</cfoutput>" /></li>         
         <li class="clear"><label class="bold width-120">Total Premium</label></li>     
         <li><input type="text" name="other3_totalpremium" id="other3_totalpremium" class="width-80 dollarmask readonly" value="<cfoutput>#dollarFormat(other3_totalpremium)#</cfoutput>" /></li>           
</ul> 
<ul class="formfields">
<li class="clear"><label>&nbsp;</label></li>
<li class="clear"><label>Proposal Notes</label></li>
<li class="clear"><textarea name="other3_proposalnotes" id="other3_proposalnotes" style="height:90px; width:425px;" class="txtleft"><cfoutput>#other3_proposalnotes#</cfoutput></textarea></li>
<li class="clear"><label>Notes</label></li>
<li class="clear"><textarea name="other3_notes" id="other3_notes" style="height:90px; width:425px;" class="txtleft"><cfoutput>#other3_notes#</cfoutput></textarea></li>

</ul>

<div class="clear"></div>
</div>            
      </div></cfif> 
      <div class="buttoncontainer2"><button class="buttons" id="saveclient">SAVE</button><cfif val(client_id) neq 0><button class="buttons" id="proposalbutton">PRINTING &amp; PROPOSALS</button> <button id="saveAllLocHistory" class="buttons" name="saveAllLocHistory" style="text-transform:uppercase;">Save to History - Active Locations</button> <button id="printAll" name="printAll" class="buttons">PRINT ALL APPS</button></cfif>  </div>  
      </form>               
<div style="height:900px;"></div>
<div id="dialog-confirm" title="WARNING">
  <p> <span class="ui-icon ui-icon-alert"></span> Are you sure? This cannot be undone.</p>
</div>
<cfif client_id neq 0>
<cfinclude template="/app/views/common/notes.cfm">
</cfif>