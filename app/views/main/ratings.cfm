
<cfparam name="location_id" default="#url.location_id#">
<cfparam name="gldate1" default="#now()#">
<cfparam name="propdate1" default="#now()#">
<cfparam name="viewhistory" default="0">
<cfparam name="endorse" default="0">
<cfparam name="pagename" default="Ratings">
<cfparam name="default_credit" default="0">
<cfparam name="default_credit_label" default="">
<cfparam name="oldratingid" default="0">
<cfparam name="rc.YESNO.NOTES" default="">
<cfif endorse eq 1>
	<cfset pagename = "Endorsements">
	<!---<cfparam name="rating_property_id" default="#rc.eform.rating_property_id#">--->
	<cfparam name="liability_plan_id" default="#rc.eform.liability_plan_id#">
    <!---needed to circumvent scoping problem--->
    <cfparam name="liability_plan_select" default="#rc.eform.liability_plan_id#">
	<cfparam name="property_plan_id" default="#rc.eform.property_plan_id#">
    <cfparam name="property_plan_select" default="#rc.eform.property_plan_id#">
	<cfparam name="gl_issuing_company_id" default="#rc.eform.gl_issuing_company_id#">
	<cfparam name="property_issuing_company_id" default="#rc.eform.property_issuing_company_id#">    
	<cfset gldate1 = rc.eform.gldate1>
	<cfset gldate2 = rc.eform.gldate2> 
	<cfset propdate1 = rc.eform.propdate1>
	<cfset propdate2 = rc.eform.propdate2>       
</cfif>



<cfset yearAhead = DateAdd( "yyyy", 1, Now() ) />
<cfparam name="gldate2" default="#yearAhead#">
<cfparam name="propdate2" default="#yearAhead#">

<cfif structkeyexists(rc,'rform')>
	<cfset viewhistory = val(rc.rform.history)>
	<cfparam name="rating_liability_id" default="#rc.rform.rating_liability_id#">
	<cfparam name="rating_property_id" default="#rc.rform.rating_property_id#">
	<cfparam name="liability_plan_id" default="#rc.rform.liability_plan_id#">
    <!---needed to circumvent scoping problem--->
    <cfparam name="liability_plan_select" default="#rc.rform.liability_plan_id#">
	<cfparam name="property_plan_id" default="#rc.rform.property_plan_id#">
    <cfparam name="property_plan_select" default="#rc.rform.property_plan_id#">
	<cfparam name="gl_issuing_company_id" default="#rc.rform.gl_issuing_company_id#">
	<cfparam name="property_issuing_company_id" default="#rc.rform.property_issuing_company_id#">
	<cfparam name="square_footage" default="#rc.rform.square_footage#">
	<cfparam name="gross_receipts" default="$#numberformat(val(rc.rform.gross_receipts))#">
	<cfparam name="excl_proposal" default="#rc.rform.excl_proposal#">
	<cfparam name="gl_deductable" default="#dollarformat(rc.rform.gl_deductable)#">
	<cfparam name="base_rate_annual" default="#rc.rform.base_rate_annual#">
	<cfparam name="instructors_expo" default="#val(rc.rform.instructors_expo)#">
	<cfparam name="instructors_base" default="#dollarformat(rc.rform.instructors_base)#">
	<cfparam name="instructors_annual" default="#dollarformat(rc.rform.instructors_annual)#">
	<cfparam name="basketball_expo" default="#val(rc.rform.basketball_expo)#">
	<cfparam name="basketball_base" default="#dollarformat(rc.rform.basketball_base)#">
	<cfparam name="basketball_annual" default="#dollarformat(rc.rform.basketball_annual)#">
	<cfparam name="rt_courts_expo" default="#val(rc.rform.rt_courts_expo)#">
	<cfparam name="rt_courts_base" default="#dollarformat(rc.rform.rt_courts_base)#">
	<cfparam name="rt_courts_annual" default="#dollarformat(rc.rform.rt_courts_annual)#">
	<cfparam name="tennis_courts_expo" default="#val(rc.rform.tennis_courts_expo)#">
	<cfparam name="tennis_courts_base" default="#dollarformat(rc.rform.tennis_courts_base)#">
	<cfparam name="tennis_courts_annual" default="#dollarformat(rc.rform.tennis_courts_annual)#">
	<cfparam name="sauna_expo" default="#val(rc.rform.sauna_expo)#">
	<cfparam name="sauna_base" default="#dollarformat(rc.rform.sauna_base)#">
	<cfparam name="sauna_annual" default="#dollarformat(rc.rform.sauna_annual)#">
	<cfparam name="steamroom_expo" default="#val(rc.rform.steamroom_expo)#">
	<cfparam name="steamroom_base" default="#dollarformat(rc.rform.steamroom_base)#">
	<cfparam name="steamroom_annual" default="#dollarformat(rc.rform.steamroom_annual)#">
	<cfparam name="whirlpool_expo" default="#val(rc.rform.whirlpool_expo)#">
	<cfparam name="whirlpool_base" default="#dollarformat(rc.rform.whirlpool_base)#">
	<cfparam name="whirlpool_annual" default="#dollarformat(rc.rform.whirlpool_annual)#">
	<cfparam name="pools_expo" default="#val(rc.rform.pools_expo)#">
	<cfparam name="pools_base" default="#dollarformat(rc.rform.pools_base)#">
	<cfparam name="pools_annual" default="#dollarformat(rc.rform.pools_annual)#">
	<cfparam name="poolsoutdoor_expo" default="#val(rc.rform.poolsoutdoor_expo)#">
	<cfparam name="poolsoutdoor_base" default="#dollarformat(rc.rform.poolsoutdoor_base)#">
	<cfparam name="poolsoutdoor_annual" default="#dollarformat(rc.rform.poolsoutdoor_annual)#">
	<cfparam name="tanning_expo" default="#val(rc.rform.tanning_expo)#">
	<cfparam name="tanning_base" default="#dollarformat(rc.rform.tanning_base)#">
	<cfparam name="tanning_annual" default="#dollarformat(rc.rform.tanning_annual)#">
	<cfparam name="spraytanning_expo" default="#val(rc.rform.spraytanning_expo)#">
	<cfparam name="spraytanning_base" default="#dollarformat(rc.rform.spraytanning_base)#">
	<cfparam name="spraytanning_annual" default="#dollarformat(rc.rform.spraytanning_annual)#">
	<cfparam name="beautyangels_expo" default="#val(rc.rform.beautyangels_expo)#">
	<cfparam name="beautyangels_base" default="#dollarformat(rc.rform.beautyangels_base)#">
	<cfparam name="beautyangels_annual" default="#dollarformat(rc.rform.beautyangels_annual)#">
	<cfparam name="silversneakers_expo" default="#val(rc.rform.silversneakers_expo)#">
	<cfparam name="silversneakers_base" default="#dollarformat(rc.rform.silversneakers_base)#">
	<cfparam name="silversneakers_annual" default="#dollarformat(rc.rform.silversneakers_annual)#">
	<cfparam name="massage_expo" default="#val(rc.rform.massage_expo)#">
	<cfparam name="massage_base" default="#dollarformat(rc.rform.massage_base)#">
	<cfparam name="massage_annual" default="#dollarformat(rc.rform.massage_annual)#">
	<cfparam name="pt_expo" default="#val(rc.rform.pt_expo)#">
	<cfparam name="pt_base" default="#dollarformat(rc.rform.pt_base)#">
	<cfparam name="pt_annual" default="#dollarformat(rc.rform.pt_annual)#">
	<cfparam name="childsitting_expo" default="#val(rc.rform.childsitting_expo)#">
	<cfparam name="childsitting_base" default="#dollarformat(rc.rform.childsitting_base)#">
	<cfparam name="childsitting_annual" default="#dollarformat(rc.rform.childsitting_annual)#">
	<cfparam name="junglegym_expo" default="#val(rc.rform.junglegym_expo)#">
	<cfparam name="junglegym_base" default="#dollarformat(rc.rform.junglegym_base)#">
	<cfparam name="junglegym_annual" default="#dollarformat(rc.rform.junglegym_annual)#">
	<cfparam name="leasedspace_expo" default="#val(rc.rform.leasedspace_expo)#">
	<cfparam name="leasedspace_base" default="#dollarformat(rc.rform.leasedspace_base)#">
	<cfparam name="leasedspace_annual" default="#dollarformat(rc.rform.leasedspace_annual)#">
	<cfparam name="employeebenefits_expo" default="#val(rc.rform.employeebenefits_expo)#">
	<cfparam name="employeebenefits_base" default="#dollarformat(rc.rform.employeebenefits_base)#">
	<cfparam name="employeebenefits_annual" default="#dollarformat(rc.rform.employeebenefits_annual)#">  
  <cfparam name="silversneakers_override" default="#val(rc.rform.silversneakers_override)#">
  <cfparam name="pt_override" default="#val(rc.rform.pt_override)#">
  <cfparam name="junglegym_override" default="#val(rc.rform.junglegym_override)#">
  <cfparam name="leasedspace_override" default="#val(rc.rform.leasedspace_override)#">
  <cfparam name="employeebenefits_override" default="#val(rc.rform.employeebenefits_override)#">
  <cfparam name="massage_override" default="#val(rc.rform.massage_override)#">
	<cfparam name="total_annual" default="#dollarformat(rc.rform.total_annual)#">
	<cfparam name="total_debits" default="#dollarformat(rc.rform.total_debits)#">
	<cfparam name="total_mod" default="#val(rc.rform.total_mod)#">
	<cfparam name="loc_annual_premium" default="#dollarformat(rc.rform.loc_annual_premium)#">
	<cfparam name="pro_rata_gl" default="#dollarFormat(rc.rform.pro_rata_gl)#">
	<cfparam name="use_prorata" default="#rc.rform.use_prorata#">
	<cfparam name="broker_override" default="#rc.rform.broker_override#">
	<cfparam name="brokerfee" default="#dollarformat(rc.rform.brokerfee)#">
	<cfparam name="broker_flatpercent" default="#rc.rform.broker_flatpercent#">
	<cfparam name="broker_percentoverride" default="#rc.rform.broker_percentoverride#">
	<cfparam name="surplustax" default="#dollarformat(rc.rform.surplustax)#">
	<cfparam name="inspectionfee" default="#dollarformat(rc.rform.inspectionfee)#">
	<cfparam name="terrorism_rejected" default="#rc.rform.terrorism_rejected#">
	<cfparam name="terrorism_fee" default="#dollarformat(rc.rform.terrorism_fee)#">
	<cfparam name="stampingfee" default="#dollarformat(rc.rform.stampingfee)#">
	<cfparam name="filingfee" default="#dollarformat(rc.rform.filingfee)#">
	<cfparam name="statecharge" default="#dollarformat(rc.rform.statecharge)#">
	<cfparam name="rpgfee" default="#dollarformat(rc.rform.rpgfee)#">
	<cfparam name="rpgall" default="#dollarformat(rc.totalrpg)#">
	<cfparam name="grandtotal" default="#dollarformat(rc.rform.grandtotal)#">
	<cfset gldate1 = rc.rform.gldate1>
	<cfset gldate2 = rc.rform.gldate2>
	<cfparam name="gl_prorate" default="#rc.rform.gl_prorate#">
  <cfif rc.rform.endorse neq 1>
	<cfparam name="underwriting_notes" default="#rc.rform.underwriting_notes#">
  <cfelse>
  <cfparam name="underwriting_notes" default="#rc.rform.historynotes#">
  </cfif>
	<cfparam name="yesnoquestions" default="#rc.yesno.notes#">
  <cfparam name="liability_propnotes" default="#rc.rform.liability_propnotes#">
  <cfparam name="property_propnotes" default="#rc.rform.property_propnotes#">
	<cfparam name="prop_deductible" default="#rc.rform.prop_deductible#">
	<cfparam name="prop_exclwind" default="#rc.rform.prop_exclwind#">
	<cfparam name="prop_winddeductable" default="#rc.rform.prop_winddeductable#">
	<cfparam name="prop_buildingrate" default="#rc.rform.prop_buildingrate#">
	<cfparam name="prop_buildinglimit" default="#rc.rform.prop_buildinglimit#">
	<cfparam name="prop_buildingpremium" default="#rc.rform.prop_buildingpremium#">
	<cfparam name="prop_bpprate" default="#rc.rform.prop_bpprate#">
	<cfparam name="prop_bpplimit" default="#rc.rform.prop_bpplimit#">
	<cfparam name="prop_bpppremium" default="#rc.rform.prop_bpppremium#">
	<cfparam name="prop_tirate" default="#rc.rform.prop_tirate#">
	<cfparam name="prop_tilimit" default="#rc.rform.prop_tilimit#">
	<cfparam name="prop_tipremium" default="#rc.rform.prop_tipremium#">
	<cfparam name="prop_90" default="#rc.rform.prop_90#">
  <cfparam name="prop_coinsurancelabel" default="#rc.rform.prop_coinsurancelabel#">
	<cfparam name="prop_bieerate" default="#rc.rform.prop_bieerate#">
	<cfparam name="prop_bieelimit" default="#rc.rform.prop_bieelimit#">
	<cfparam name="prop_bieepremium" default="#rc.rform.prop_bieepremium#">
	<cfparam name="prop_daysdeductible" default="#rc.rform.prop_daysdeductible#">
	<cfparam name="prop_edprate" default="#rc.rform.prop_edprate#">
	<cfparam name="prop_edplimit" default="#rc.rform.prop_edplimit#">
	<cfparam name="prop_edppremium" default="#rc.rform.prop_edppremium#">
	<cfparam name="prop_hvacrate" default="#rc.rform.prop_hvacrate#">
	<cfparam name="prop_hvaclimit" default="#rc.rform.prop_hvaclimit#">
	<cfparam name="prop_hvacpremium" default="#rc.rform.prop_hvacpremium#">
	<cfparam name="prop_signrate" default="#rc.rform.prop_signrate#">
	<cfparam name="prop_signlimit" default="#rc.rform.prop_signlimit#">
	<cfparam name="prop_signpremium" default="#rc.rform.prop_signpremium#">
	<cfparam name="prop_equipbreakrate" default="#rc.rform.prop_equipbreakrate#">
	<cfparam name="prop_equipbreaktotal" default="#rc.rform.prop_equipbreaktotal#">
	<cfparam name="prop_equipbreakpremium" default="#rc.rform.prop_equipbreakpremium#">
	<cfparam name="employee_dishonesty_id" default="#rc.rform.employee_dishonesty_id#">
  <cfparam name="employee_dishonesty_select" default="#rc.rform.employee_dishonesty_id#">
	<cfparam name="property_emp_amount" default="#val(rc.rform.property_emp_amount)#">
	<cfparam name="cyber_liability_amount_id" default="#rc.rform.cyber_liability_amount_id#">
    <!---needed to circumvent scoping problem--->
    <cfparam name="cyber_liability_select" default="#rc.rform.cyber_liability_amount_id#">    
	<cfparam name="property_cyber_amount" default="#rc.rform.property_cyber_amount#">
	<cfparam name="prop_floodrate" default="#rc.rform.prop_floodrate#">
	<cfparam name="prop_floodlimit" default="#rc.rform.prop_floodlimit#">
	<cfparam name="prop_floodpremium" default="#rc.rform.prop_floodpremium#">
	<cfparam name="prop_flooddeduct" default="#rc.rform.prop_flooddeduct#">
	<cfparam name="prop_quakerate" default="#rc.rform.prop_quakerate#">
	<cfparam name="prop_quakelimit" default="#rc.rform.prop_quakelimit#">
	<cfparam name="prop_quakepremium" default="#rc.rform.prop_quakepremium#">
	<cfparam name="prop_quakededuct" default="#rc.rform.prop_quakededuct#">
	<cfparam name="premium_override" default="#rc.rform.premium_override#">
	<cfparam name="prop_ratedpremium" default="#rc.rform.prop_ratedpremium#">
	<cfparam name="prop_chargedpremium" default="#rc.rform.prop_chargedpremium#">
	<cfparam name="prop_proratapremium" default="#rc.rform.prop_proratapremium#">
	<cfparam name="prop_use_prorata" default="#rc.rform.prop_use_prorata#">
	<cfparam name="prop_agencyfee" default="#rc.rform.prop_agencyfee#">
  <cfparam name="prop_agencyfeeoverride" default="#rc.rform.prop_agencyfeeoverride#">
	<cfparam name="prop_agencyamount" default="#rc.rform.prop_agencyamount#">
  <cfparam name="prop_brokerfee" default="#rc.rform.prop_brokerfee#">
	<cfparam name="prop_terrorism_rejected" default="#rc.rform.prop_terrorism_rejected#">
	<cfparam name="prop_terrorism" default="#rc.rform.prop_terrorism#">
  <cfparam name="prop_taxoverride" default="#rc.rform.prop_taxoverride#">
	<cfparam name="prop_taxes" default="#rc.rform.prop_taxes#">
	<cfparam name="prop_grandtotal" default="#rc.rform.prop_grandtotal#">
	<cfset propdate1 = rc.rform.propdate1>
	<cfset propdate2 = rc.rform.propdate2>
	<cfparam name="prop_prorate" default="#rc.rform.prop_prorate#">
	<cfparam name="prop_underwritingnotes" default="#rc.rform.prop_underwritingnotes#">
	<cfparam name="prop_yesnoquestions" default="#rc.yesno.notes#">
  
	<cfparam name="gldate3" default="#now()#">
	<cfparam name="gldate4" default="#yearahead#">
    <cfparam name="total_debitspercent" default="#rc.rform.total_debitspercent#">
    <cfparam name="premium_mod" default="#rc.rform.premium_mod#">
    <cfparam name="final_mod" default="#rc.rform.final_mod#">
    <cfparam name="premium_mod_label" default="#rc.rform.premium_mod_label#">
    <cfparam name="base_override" default="#val(rc.rform.base_override)#">
    <cfparam name="surplustax_override" default="#val(rc.rform.surplustax_override)#">
    <cfparam name="inspection_override" default="#val(rc.rform.inspection_override)#">
    <cfparam name="rpg_override" default="#val(rc.rform.rpg_override)#">
    <cfparam name="filing_override" default="#val(rc.rform.filing_override)#">
    <cfparam name="statemuni_override" default="#val(rc.rform.statemuni_override)#">
    <cfparam name="prop_subtotal" default="#val(rc.rform.prop_subtotal)#">
<cfelse>
	<cfparam name="rating_liability_id" default="0">
	<cfparam name="rating_property_id" default="0">
	<cfparam name="liability_plan_id" default="">
	<cfparam name="liability_plan_select" default="">    
	<cfparam name="property_plan_id" default="">
	<cfparam name="property_plan_select" default="">    
	<cfparam name="gl_issuing_company_id" default="">
	<cfparam name="property_issuing_company_id" default="">
	<cfparam name="square_footage" default="#rc.liability_expos.square_ft#">
	<cfparam name="gross_receipts" default="#rc.liability_expos.gross_receipts#">
	<cfparam name="excl_proposal" default="0">
	<cfparam name="gl_deductable" default="">
	<cfparam name="base_rate_annual" default="">
	<cfparam name="instructors_expo" default="#rc.liability_expos.instructors_expo#">
	<cfparam name="instructors_base" default="">
	<cfparam name="instructors_annual" default="">
	<cfparam name="basketball_expo" default="#rc.liability_expos.basketball_expo#">
	<cfparam name="basketball_base" default="">
	<cfparam name="basketball_annual" default="">
	<cfparam name="rt_courts_expo" default="#rc.liability_expos.rt_courts_expo#">
	<cfparam name="rt_courts_base" default="">
	<cfparam name="rt_courts_annual" default="">
	<cfparam name="tennis_courts_expo" default="#rc.liability_expos.rt_courts_expo#">
	<cfparam name="tennis_courts_base" default="">
	<cfparam name="tennis_courts_annual" default="">
	<cfparam name="sauna_expo" default="#rc.liability_expos.sauna_expo#">
	<cfparam name="sauna_base" default="">
	<cfparam name="sauna_annual" default="">
	<cfparam name="steamroom_expo" default="#rc.liability_expos.steamroom_expo#">
	<cfparam name="steamroom_base" default="">
	<cfparam name="steamroom_annual" default="">
	<cfparam name="whirlpool_expo" default="#rc.liability_expos.whirlpool_expo#">
	<cfparam name="whirlpool_base" default="">
	<cfparam name="whirlpool_annual" default="">
	<cfparam name="pools_expo" default="#rc.liability_expos.pools_expo#">
	<cfparam name="pools_base" default="">
	<cfparam name="pools_annual" default="">
	<cfparam name="poolsoutdoor_expo" default="#rc.liability_expos.poolsoutdoor_expo#">
	<cfparam name="poolsoutdoor_base" default="">
	<cfparam name="poolsoutdoor_annual" default="">
	<cfparam name="tanning_expo" default="#rc.liability_expos.tanning_expo#">
	<cfparam name="tanning_base" default="">
	<cfparam name="tanning_annual" default="">
	<cfparam name="spraytanning_expo" default="#rc.liability_expos.spraytanning_expo#">
	<cfparam name="spraytanning_base" default="">
	<cfparam name="spraytanning_annual" default="">
	<cfparam name="beautyangels_expo" default="#rc.liability_expos.beautyangels_expo#">
	<cfparam name="beautyangels_base" default="">
	<cfparam name="beautyangels_annual" default="">
	<cfparam name="silversneakers_expo" default="#rc.liability_expos.silversneakers_expo#">
	<cfparam name="silversneakers_base" default="">
	<cfparam name="silversneakers_annual" default="">
	<cfparam name="massage_expo" default="#rc.liability_expos.massage_expo#">
	<cfparam name="massage_base" default="">
	<cfparam name="massage_annual" default="">
	<cfparam name="pt_expo" default="#rc.liability_expos.pt_expo#">
	<cfparam name="pt_base" default="">
	<cfparam name="pt_annual" default="">
	<cfparam name="childsitting_expo" default="#rc.liability_expos.childsitting_expo#">
	<cfparam name="childsitting_base" default="">
	<cfparam name="childsitting_annual" default="">
	<cfparam name="junglegym_expo" default="#rc.liability_expos.junglegym_expo#">
	<cfparam name="junglegym_base" default="">
	<cfparam name="junglegym_annual" default="">
	<cfparam name="leasedspace_expo" default="#rc.liability_expos.leasedspace_expo#">
	<cfparam name="leasedspace_base" default="">
	<cfparam name="leasedspace_annual" default="">
	<cfparam name="employeebenefits_expo" default="#rc.liability_expos.employeebenefits_expo#">
	<cfparam name="employeebenefits_base" default="">
	<cfparam name="employeebenefits_annual" default="">  
  <cfparam name="silversneakers_override" default="0">
  <cfparam name="pt_override" default="0">
  <cfparam name="junglegym_override" default="0">
  <cfparam name="leasedspace_override" default="0">
  <cfparam name="massage_override" default="0">
  <cfparam name="employeebenefits_override" default="0">
	<cfparam name="total_annual" default="">
	<cfparam name="total_debits" default="0">
	<cfparam name="total_mod" default="1">
	<cfparam name="loc_annual_premium" default="">
	<cfparam name="pro_rata_gl" default="">
	<cfparam name="use_prorata" default="">
	<cfparam name="broker_override" default="">
	<cfparam name="brokerfee" default="">
	<cfparam name="broker_flatpercent" default="">
	<cfparam name="broker_percentoverride" default="">
	<cfparam name="broker_flatpercent" default="">
	<cfparam name="surplustax" default="">
	<cfparam name="inspectionfee" default="">
	<cfparam name="terrorism_rejected" default="1">
	<cfparam name="terrorism_fee" default="">
	<cfparam name="stampingfee" default="">
	<cfparam name="filingfee" default="">
	<cfparam name="statecharge" default="">
	<cfparam name="rpgfee" default="">
	<cfparam name="rpgall" default="">
	<cfparam name="grandtotal" default="">
	<cfparam name="gldate1" default="">
	<cfparam name="gldate2" default="">
	<cfparam name="gl_prorate" default="">
	<cfparam name="underwriting_notes" default="">
	<cfparam name="yesnoquestions" default="">
	<cfparam name="prop_deductible" default="0">
	<cfparam name="prop_exclwind" default="0">
	<cfparam name="prop_winddeductable" default="">
	<cfparam name="prop_buildingrate" default="0">
	<cfparam name="prop_buildinglimit" default="#rc.property_limits.prop_buildinglimit#">
	<cfparam name="prop_buildingpremium" default="0">
	<cfparam name="prop_bpprate" default="0">
	<cfparam name="prop_bpplimit" default="#rc.property_limits.prop_bpplimit#">
	<cfparam name="prop_bpppremium" default="0">
	<cfparam name="prop_tirate" default="0">
	<cfparam name="prop_tilimit" default="#rc.property_limits.prop_tilimit#">
	<cfparam name="prop_tipremium" default="0">
	<cfparam name="prop_90" default="0">
  <cfparam name="prop_coinsurancelabel" default="90%">
	<cfparam name="prop_bieerate" default="0">
	<cfparam name="prop_bieelimit" default="#rc.property_limits.prop_bieelimit#">
	<cfparam name="prop_bieepremium" default="0">
	<cfparam name="prop_daysdeductible" default="0">
	<cfparam name="prop_edprate" default="0">
	<cfparam name="prop_edplimit" default="#rc.property_limits.prop_edplimit#">
	<cfparam name="prop_edppremium" default="0">
	<cfparam name="prop_hvacrate" default="0">
	<cfparam name="prop_hvaclimit" default="#rc.property_limits.prop_hvaclimit#">
	<cfparam name="prop_hvacpremium" default="0">
	<cfparam name="prop_signrate" default="0">
	<cfparam name="prop_signlimit" default="#rc.property_limits.prop_signlimit#">
	<cfparam name="prop_signpremium" default="0">
	<cfparam name="prop_equipbreakrate" default="0">
	<cfparam name="prop_equipbreaktotal" default="0">
	<cfparam name="prop_equipbreakpremium" default="0">
	<cfparam name="employee_dishonesty_id" default="#rc.property_limits.employee_dishonesty_id#">
  <cfparam name="employee_dishonesty_select" default="#rc.property_limits.employee_dishonesty_id#">
	<cfparam name="property_emp_amount" default="0">
	<cfparam name="cyber_liability_amount_id" default="#rc.property_limits.cyber_liability_amount_id#">
  <cfparam name="cyber_liability_select" default="#rc.property_limits.cyber_liability_amount_id#">
	<cfparam name="property_cyber_amount" default="0">
	<cfparam name="prop_floodrate" default="0">
	<cfparam name="prop_floodlimit" default="0">
	<cfparam name="prop_floodpremium" default="0">
	<cfparam name="prop_flooddeduct" default="0">
	<cfparam name="prop_quakerate" default="0">
	<cfparam name="prop_quakelimit" default="0">
	<cfparam name="prop_quakepremium" default="0">
	<cfparam name="prop_quakededuct" default="0">
	<cfparam name="premium_override" default="0">
	<cfparam name="prop_ratedpremium" default="0">
	<cfparam name="prop_chargedpremium" default="0">
	<cfparam name="prop_proratapremium" default="0">
	<cfparam name="prop_use_prorata" default="0">
	<cfparam name="prop_agencyfee" default="0">
  <cfparam name="prop_agencyfeeoverride" default="0">
	<cfparam name="prop_agencyamount" default="0">
  <cfparam name="prop_brokerfee" default="0">
	<cfparam name="prop_terrorism_rejected" default="0">
	<cfparam name="prop_terrorism" default="0">
  <cfparam name="prop_taxoverride" default="0">
	<cfparam name="prop_taxes" default="0">
	<cfparam name="prop_grandtotal" default="0">
	<cfparam name="propdate1" default="">
	<cfparam name="propdate2" default="">
	<cfparam name="prop_prorate" default="0">
	<cfparam name="prop_underwritingnotes" default="">
	<cfparam name="prop_yesnoquestions" default="">
  <cfparam name="liability_propnotes" default="">
	<cfparam name="gldate3" default="#now()#">
	<cfparam name="gldate4" default="#yearahead#">
    <cfparam name="total_debitspercent" default="">
    <cfparam name="premium_mod" default="">
    <cfparam name="final_mod" default="">
    <cfparam name="premium_mod_label" default="">    
    <cfparam name="base_override" default="0">
    <cfparam name="surplustax_override" default="0">
    <cfparam name="inspection_override" default="0">
    <cfparam name="rpg_override" default="0"> 
    <cfparam name="filing_override" default="0"> 
    <cfparam name="statemuni_override" default="0">    
    <cfparam name="prop_subtotal" default="0">
    <cfparam name="property_propnotes" default="">
</cfif>

<cfif isDefined('printtab')>
<style>
.blackborder { border:1px solid #000000 !important;
}
.noborder {border:none !important;
}

.ui-state-default a {
  color:black !important;
  font-weight:bold;
}
#tabs *, #abovetabs *, .summaryinfo, #csummarymove2 {
font-size:13px !important;
line-height:17px;
color:black !important;
}
#tabs {
clear:both;
}
#container {
width:900px;
}
.planboxes {
width:510px;
}
.pblast {
width:370px;
}
#prop1col {
width:370px !important;	
}
#prop1col .width-30 {
	width:45px;
}
#prop1col .width-226 {
	width:241px;
}
#prop1col .width-142 {
	/* width:153px; */
}
#prop1col .width-118 {
	width:133px;
}
</style>

</cfif>

<cfinclude template="ratings.js.cfm">
<div class="summarybuttons csummaryshow asummaryshow">
<button class="buttons printpage">PRINT</button>
</div>
  <div id="statusbar">
	<cfoutput>
    <div id="pagename">#pagename#</div>

    <div id="statusstuff"><b>Named Insured:</b> <a href="/index.cfm?event=main.client&client_id=#rc.cinfo.client_id#" class="statuslink">#rc.cinfo.named_insured#</a> &nbsp;&nbsp;&nbsp;&nbsp;<b>Address:</b> #rc.cinfo.address# #rc.cinfo.address2#, #rc.cinfo.city# #rc.cinfo.state#&nbsp;&nbsp;&nbsp;&nbsp;<b>Location ##:</b> #rc.cinfo.location_number#           &nbsp;&nbsp;&nbsp;&nbsp;<b>Conglom:</b> #rc.cinfo.code#&nbsp;&nbsp;&nbsp;&nbsp;<b>AMS:</b> #rc.cinfo.ams# &nbsp;&nbsp;&nbsp;&nbsp;Desc: #rc.cinfo.description#</div>
    </cfoutput>
	<!---End Statusstuff--->
  </div>
  <div class="msgcontainer">
<div class="message"></div>
</div>
<cfoutput>
<div class="csummaryshow preparedby">Prepared By: Fitness Insurance, LLC</div>
    <div class="summaryinfo"><b>Named Insured:</b> #rc.cinfo.client_ni# 
    <br />
    <b>DBA:</b> #rc.cinfo.cdba#
    <br />
    <b>Mailing Address:</b> #rc.cinfo.mailing_address#<cfif trim(rc.cinfo.mailing_address2) neq ''> #rc.cinfo.mailing_address2#</cfif>, #rc.cinfo.mailing_city#, #rc.cinfo.mailing_statename#&nbsp;&nbsp;#rc.cinfo.mailing_zip#<br><br>
    <b>Location ##:</b> #rc.cinfo.location_number#<br>
    <b>Location Entity Name:</b> <cfif trim(rc.cinfo.named_insured) neq ''>#rc.cinfo.named_insured#<cfelse>#rc.cinfo.client_ni#</cfif><br>
    <b>Location DBA:</b> <cfif trim(rc.cinfo.dba) neq ''>#rc.cinfo.dba#<cfelse>#rc.cinfo.cdba#</cfif><br>
    <div style="width:590px; float:left; overflow:hidden;"><b>Location Address:</b> #rc.cinfo.address#<cfif trim(rc.cinfo.address2) neq ''> #rc.cinfo.address2#</cfif>, #rc.cinfo.city#, #rc.cinfo.state# #rc.cinfo.zip#</div>
    <div style="float:left;">Desc: #rc.cinfo.description#</div>
    <div style="clear:both;"></div>
    </div>
    </cfoutput>
  <!---End statusbar--->
  <form id="ratingform" action="" method="post" autocomplete="off">

	<input type="hidden" id="ratingid" name="ratingid" value="<cfoutput>#url.ratingid#</cfoutput>">
	<input type="hidden" name="location_id" value="<cfoutput>#url.location_id#</cfoutput>">
	<input type="hidden" name="application_id" id="application_id" value="<cfoutput>#url.application_id#</cfoutput>">
	<input type="hidden" name="client_id" value="<cfoutput>#url.client_id#</cfoutput>">
	<input type="hidden" id="rating_liability_id" name="rating_liability_id" value="<cfoutput>#rating_liability_id#</cfoutput>">
	<input type="hidden" id="rating_property_id" name="rating_property_id" value="<cfoutput>#rating_property_id#</cfoutput>">
  <input type="hidden" id="oldratingid" name="oldratingid" value="<cfoutput>#oldratingid#</cfoutput>">
    <div id="abovetabs">
      <ul class="planboxes">
      <li class="planboxli width-250" style="margin-bottom:0"><label class="planlabel planlabel1">Liability Rating Plan</label></li>
      <li class="planboxli" style="margin-bottom:0;"><label class="planlabel planlabel2">Property Rating Plan</label></li>
        <li class="planboxli glplanli">
          <select id="liability_plan_id" name="liability_plan_id" class="selectbox2" style="width:250px;" tabindex="1">
            <option value="0">Select Liability Plan</option>
<cfloop query="rc.glplans">
<cfoutput><option value="#rc.glplans.liability_plan_id#" <cfif rc.glplans.liability_plan_id eq liability_plan_select>selected="selected"</cfif>>#rc.glplans.name#</option></cfoutput></cfloop>
          </select>
        </li>
        <li class="planboxli propplanli">
          <select id="property_plan_id" name="property_plan_id" class="selectbox2" style="width:250px;" tabindex="3">
            <option value="0">Select Property Plan</option>
<cfoutput query="rc.propplans">
<option value="#rc.propplans.property_plan_id#" <cfif rc.propplans.property_plan_id eq property_plan_select>selected="selected"</cfif>>#rc.propplans.property_plan_name#</option></cfoutput>
          </select>
        </li>
        <li class="planboxli glplanli">
          <select name="gl_issuing_company_id" id="gl_issuing_company_id" class="selectbox2" style="width:250px;" tabindex="2">
            <option value="0">Select Liability Plan Issuing Company</option>
            <cfset parentname = "">
            <cfoutput query="rc.issuing">
            <cfif parentname neq rc.issuing.parent_company_name>
            <cfif parentname neq "">
            </optgroup>
            </cfif>
            <optgroup label="#rc.issuing.parent_company_name#">
            <cfif rc.issuing.name neq ''>
            <option value="#rc.issuing.issuing_company_id#" <cfif rc.issuing.issuing_company_id eq gl_issuing_company_id>selected</cfif>>#rc.issuing.name#</option>            
			</cfif>
            <cfelse>
            <cfif rc.issuing.name neq ''>
            <option value="#rc.issuing.issuing_company_id#" <cfif rc.issuing.issuing_company_id eq gl_issuing_company_id>selected</cfif>>#rc.issuing.name#</option>            
			</cfif>
            
            </cfif>
            <cfset parentname = rc.issuing.parent_company_name>
            </cfoutput>
          </select>
        </li>
        <li class="planboxli propplanli">
          <select name="property_issuing_company_id" id="property_issuing_company_id" class="selectbox2" style="width:250px;" tabindex="4">
            <option value="0">Select Property Plan Issuing Company</option>
            <cfset parentname = "">
            <cfoutput query="rc.issuing">
            <cfif parentname neq rc.issuing.parent_company_name>
            <cfif parentname neq "">
            </optgroup>
            </cfif>
            <optgroup label="#rc.issuing.parent_company_name#">
            <cfif rc.issuing.name neq ''>
            <option value="#rc.issuing.issuing_company_id#" <cfif rc.issuing.issuing_company_id eq property_issuing_company_id>selected</cfif>>#rc.issuing.name#</option>            
			</cfif>
            <cfelse>
            <cfif rc.issuing.name neq ''>
            <option value="#rc.issuing.issuing_company_id#" <cfif rc.issuing.issuing_company_id eq property_issuing_company_id>selected</cfif>>#rc.issuing.name#</option>            
			</cfif>
            
            </cfif>
            <cfset parentname = rc.issuing.parent_company_name>
            </cfoutput>
          </select>
        </li>
      </ul>
      <ul class="planboxes pblast">

		  <li class="planboxli">
          <label class="ratingslabel" for="square_footage">Square Footage</label>
          <input type="text" name="square_footage"  id="square_footage" value="<cfoutput>#square_footage#</cfoutput>" class="width-40">
        </li>
        <li class="planboxli">
          <label class="ratingslabel" for="gross_receipts">Gross Receipts</label>
          <input type="text" name="gross_receipts" id="gross_receipts" class="dollarmask width-100" value="<cfoutput>#gross_receipts#</cfoutput>">
        </li>

        <li class="planboxli excli csummaryhide">
          <input type="checkbox" name="excl_proposal" value="1" id="excl_proposal" <cfif excl_proposal eq 1>checked="checked"</cfif>>
          <label class="ratingslabel" for="excl_proposal">Exclude from proposal</label>
        </li>
      </ul>
      <div style="clear:both;"></div>
    </div>
    <div id="csummarymove1dest"></div>
    <div id="tabs">
      <ul>
        <li><a href="#tabs-1" id="gltab">Liability</a></li>
        <li><a href="#tabs-2" id="proptab">Property</a></li>
        <!---<li><a href="#tabs-3">Endorsements</a></li>--->
		<cfif endorse neq 1>
        <li><a href="#tabs-4" id="historytab">History</a></li>
		</cfif>
		
      </ul>
      <div id="tabs-1">
<cfoutput>
        <ul class="formfields width-302">
          <li class="clear">
            <label class="width-218 dollarmask">GL Deductible</label>
          </li>
          <li>
            <input type="text" name="gl_deductable" value="#gl_deductable#" class="width-80 dollarmask">
          </li>
          <li class="clear txtright bold">
            <label class="width-122"><span class="csummaryhide">Override</span></label>
          </li>
          <li>
            <label class="width-30 center bold">Expo</label>
          </li>
          <li>
            <label class="width-50 center bold">Base</label>
          </li>
          <li>
            <label class="width-80 center bold">Annual</label>
          </li>
          <li class="clear">
            <label class="width-102 bratelabel">Base Rate</label>
          </li>
          <li class="width-116 csummaryhide">
<input type="checkbox" name="base_override" value="1" class="plaincheck overridefield" id="base_override" overridefield="base_rate_annual" <cfif base_override eq 1>checked</cfif>>
          </li> 
	          
          <li>
            <input type="text" name="base_rate_annual" value="#dollarFormat(base_rate_annual)#" originalval="#base_rate_annual#" id="base_rate_annual" class="width-80 baserate dollarmask readonlyLive">
          </li>
		
              <li class="clear">
                <label class="width-122">Instructors</label>
                </li><li>
                <input type="text" name="instructors_expo"  id="instructors_expo" class="width-30 expo numbermask" value="#instructors_expo#">
                <input type="text" name="instructors_base" value="#instructors_base#" id="instructors_base" class="width-50 base dollarmask readonly">
                <input type="text" name="instructors_annual" value="#instructors_annual#" id="instructors_annual" class="width-80 annual dollarmask readonly">
              </li>
            
              <li class="clear">
                <label class="width-122">Basketball</label>
                </li><li>
                <input type="text" name="basketball_expo"  id="basketball_expo" class="width-30 expo numbermask" value="#basketball_expo#">
                <input type="text" name="basketball_base" value="#basketball_base#" id="basketball_base" class="width-50 base dollarmask readonly">
                <input type="text" name="basketball_annual" value="#basketball_annual#" id="basketball_annual" class="width-80 annual dollarmask readonly">
              </li>
            
              <li class="clear">
                <label class="width-122">Racquetball</label>
                </li><li>
                <input type="text" name="rt_courts_expo"  id="rt_courts_expo" class="width-30 expo numbermask" value="#rt_courts_expo#">
                <input type="text" name="rt_courts_base" value="#rt_courts_base#" id="rt_courts_base" class="width-50 base dollarmask readonly">
                <input type="text" name="rt_courts_annual" value="#rt_courts_annual#" id="rt_courts_annual" class="width-80 annual dollarmask readonly">
              </li>
			<li class="clear">
                <label class="width-122">Tennis</label>
                </li><li>
                <input type="text" name="tennis_courts_expo"  id="tennis_courts_expo" class="width-30 expo numbermask" value="#tennis_courts_expo#">
                <input type="text" name="tennis_courts_base" value="#tennis_courts_base#" id="tennis_courts_base" class="width-50 base dollarmask readonly">
                <input type="text" name="tennis_courts_annual" value="#tennis_courts_annual#" id="tennis_courts_annual" class="width-80 annual dollarmask readonly">
              </li>
            
              <li class="clear">
                <label class="width-122">Sauna</label>
                </li><li>
                <input type="text" name="sauna_expo" id="sauna_expo" class="width-30 expo numbermask" value="#sauna_expo#">
                <input type="text" name="sauna_base" value="#sauna_base#" id="sauna_base" class="width-50 base dollarmask readonly">
                <input type="text" name="sauna_annual" value="#sauna_annual#" id="sauna_annual" class="width-80 annual dollarmask readonly">
              </li>
            
              <li class="clear">
                <label class="width-122">Steam Room</label>
                </li><li>
                <input type="text" name="steamroom_expo"  id="steamroom_expo" class="width-30 expo numbermask" value="#steamroom_expo#">
                <input type="text" name="steamroom_base" value="#steamroom_base#" id="steamroom_base" class="width-50 base dollarmask readonly">
                <input type="text" name="steamroom_annual" value="#steamroom_annual#" id="steamroom_annual" class="width-80 annual dollarmask readonly">
              </li>
            
              <li class="clear">
                <label class="width-122">Whirlpool/Hot Tub</label>
                </li><li>
                <input type="text" name="whirlpool_expo"  id="whirlpool_expo" class="width-30 expo numbermask"  value="#whirlpool_expo#">
                <input type="text" name="whirlpool_base" value="#whirlpool_base#" id="whirlpool_base" class="width-50 base dollarmask readonly">
                <input type="text" name="whirlpool_annual" value="#whirlpool_annual#" id="whirlpool_annual" class="width-80 annual dollarmask readonly">
              </li>
            
              <li class="clear">
                <label class="width-122">Indoor Pools</label>
                </li><li>
                <input type="text" name="pools_expo"  id="pools_expo" class="width-30 expo numbermask" value="#pools_expo#">
                <input type="text" name="pools_base" value="#pools_base#" id="pools_base" class="width-50 base dollarmask readonly">
                <input type="text" name="pools_annual" value="#pools_annual#" id="pools_annual" class="width-80 annual dollarmask readonly">
              </li>
			  <li class="clear">
                <label class="width-122">Outdoor Pools</label>
                </li><li>
                <input type="text" name="poolsoutdoor_expo"  id="poolsoutdoor_expo" class="width-30 expo numbermask" value="#poolsoutdoor_expo#">
                <input type="text" name="poolsoutdoor_base" value="#poolsoutdoor_base#" id="poolsoutdoor_base" class="width-50 base dollarmask readonly">
                <input type="text" name="poolsoutdoor_annual" value="#poolsoutdoor_annual#" id="poolsoutdoor_annual" class="width-80 annual dollarmask readonly">
              </li>
            
              <li class="clear">
                <label class="width-122">Tanning</label>
                </li><li>
                <input type="text" name="tanning_expo"  id="tanning_expo" class="width-30 expo numbermask" value="#tanning_expo#">
                <input type="text" name="tanning_base" value="#tanning_base#" id="tanning_base" class="width-50 base dollarmask readonly">
                <input type="text" name="tanning_annual" value="#tanning_annual#" id="tanning_annual" class="width-80 annual dollarmask readonly">
              </li>
            
              <li class="clear">
                <label class="width-122">Spray Tanning</label>
                </li><li>
                <input type="text" name="spraytanning_expo"  id="spraytanning_expo" class="width-30 expo numbermask" value="#val(spraytanning_expo)#">
                <input type="text" name="spraytanning_base" value="#spraytanning_base#" id="spraytanning_base" class="width-50 base dollarmask readonly">
                <input type="text" name="spraytanning_annual" value="#spraytanning_annual#" id="spraytanning_annual" class="width-80 annual dollarmask readonly">
              </li>
            
              <li class="clear">
                <label class="width-122">Beauty Angels</label>
                </li><li>
                <input type="text" name="beautyangels_expo"  id="beautyangels_expo" class="width-30 expo numbermask" value="#val(beautyangels_expo)#">
                <input type="text" name="beautyangels_base" value="#beautyangels_base#" id="beautyangels_base" class="width-50 base dollarmask readonly">
                <input type="text" name="beautyangels_annual" value="#beautyangels_annual#" id="beautyangels_annual" class="width-80 annual dollarmask readonly">
              </li>
            
              <li class="clear">
                <label class="width-102">Silver Sneakers</label>
                </li>
                <li class="csummaryhide"><input type="checkbox" name="silversneakers_override" id="silversneakers_override" value="1" <cfif silversneakers_override eq 1> checked</cfif>></li>
                <li>
                <input type="text" name="silversneakers_expo"  id="silversneakers_expo" class="width-30 expo numbermask" value="#val(silversneakers_expo)#">
                <input type="text" name="silversneakers_base" value="#silversneakers_base#" id="silversneakers_base" class="width-50 base dollarmask">
                <input type="text" name="silversneakers_annual" value="#silversneakers_annual#" id="silversneakers_annual" class="width-80 annual dollarmask readonly">
              </li>
            
              <li class="clear">
                <label class="width-102">Massage</label>
                </li>
                 <li class="csummaryhide"><input type="checkbox" name="massage_override" id="massage_override" value="1" <cfif massage_override eq 1> checked</cfif>></li>               
                <li>
                <input type="text" name="massage_expo"  id="massage_expo" class="width-30 expo numbermask" value="#val(massage_expo)#">
                <input type="text" name="massage_base" value="#massage_base#" id="massage_base" class="width-50 base dollarmask">
                <input type="text" name="massage_annual" value="#massage_annual#" id="massage_annual" class="width-80 annual dollarmask readonly">
              </li>
            
              <li class="clear">
                <label class="width-102">Ind Personal Trainers</label>
                </li>
                <li class="csummaryhide"><input type="checkbox" name="pt_override" id="pt_override" value="1" <cfif pt_override eq 1> checked</cfif>></li>
                <li>
                <input type="text" name="pt_expo"  id="pt_expo" class="width-30 expo numbermask" value="#val(pt_expo)#">
                <input type="text" name="pt_base" value="#pt_base#" id="pt_base" class="width-50 base dollarmask">
                <input type="text" name="pt_annual" value="#pt_annual#" id="pt_annual" class="width-80 annual dollarmask readonly">
              </li>
            
              <li class="clear">
                <label class="width-122">Child Sitting</label>
                </li><li>
                <input type="text" name="childsitting_expo"  id="childsitting_expo" class="width-30 expo numbermask" value="#val(childsitting_expo)#">
                <input type="text" name="childsitting_base" value="#childsitting_base#" id="childsitting_base" class="width-50 base dollarmask readonly">
                <input type="text" name="childsitting_annual" value="#childsitting_annual#" id="childsitting_annual" class="width-80 annual dollarmask readonly">
              </li>
            
              <li class="clear">
                <label class="width-102">Jungle Gym</label>
                </li>
                <li class="csummaryhide"><input type="checkbox" name="junglegym_override" id="junglegym_override" value="1" <cfif junglegym_override eq 1> checked</cfif>></li>
                <li>
                <input type="text" name="junglegym_expo"  id="junglegym_expo" class="width-30 expo numbermask" value="#junglegym_expo#">
                <input type="text" name="junglegym_base" value="#junglegym_base#" id="junglegym_base" class="width-50 base dollarmask">
                <input type="text" name="junglegym_annual" value="#junglegym_annual#" id="junglegym_annual" class="width-80 annual dollarmask readonly">
              </li>
            
              <li class="clear">
                <label class="width-102">Leased Space</label>
                </li>
                <li class="csummaryhide"><input type="checkbox" name="leasedspace_override" id="leasedspace_override" value="1" <cfif leasedspace_override eq 1> checked</cfif>></li>
                <li>     
                <input type="text" name="leasedspace_expo"  id="leasedspace_expo" class="width-30 expo numbermask" value="#val(leasedspace_expo)#">
                <input type="text" name="leasedspace_base" value="#leasedspace_base#" id="leasedspace_base" class="width-50 base dollarmask">
                <input type="text" name="leasedspace_annual" value="#leasedspace_annual#" id="leasedspace_annual" class="width-80 annual dollarmask readonly">
              </li>
              <li class="clear">
                <label class="width-102">Employee Benefits</label>
                </li>
                <li class="csummaryhide"><input type="checkbox" name="employeebenefits_override" id="employeebenefits_override" value="1" <cfif employeebenefits_override eq 1> checked</cfif>></li>
                <li>     
                <input type="text" name="employeebenefits_expo"  id="employeebenefits_expo" class="width-30 expo numbermask" value="#val(employeebenefits_expo)#">
                <input type="text" name="employeebenefits_base" value="#employeebenefits_base#" id="employeebenefits_base" class="width-50 base dollarmask">
                <input type="text" name="employeebenefits_annual" value="#employeebenefits_annual#" id="employeebenefits_annual" class="width-80 annual dollarmask readonly">
              </li>               
              <section id="otherexpsec">
              <!---
			<cfif structkeyexists(rc,"expother")>         
				<cfloop query="rc.expother">
					<li class="expli clear"><input type="text" name="otherexp_id" value="#otherexp_id#"><input type="text" name="del_exp" value="0"><input type="text" name="new_expo" value="#expname#" class="width-122 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all txtleft newexpo"><input type="text" value="#dollarFormat(other_annual)#"name="new_annual" class="width-80 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all newannual dollarmask"><img class="imagebuttons deleteexp" src="/images/deletebutton.png"></li>
		         </cfloop>
			</cfif>--->
            </section>
			<li id="addglExp">
              <label class="width-302"><img src="/images/plus.png" class="plus"></label>
            </li>
            <li>
              <label class="width-218">Total</label>
            </li>
            <li>
              <input type="text" name="total_annual" value="#total_annual#" id="total_annual" class="width-80 dollarmask readonly">
            </li>
          
        </ul>
        <ul class="formfields width-302 col2">
          <li>
            <label class="bold width-302">Debits</label>
          </li>
          
          <li class="clear defaultcredit"<cfif not len(default_credit) OR default_credit eq 0> style="display:none;"</cfif>>
<input class="width-200 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all txtleft newdebitname" name="default_credit_label" id="default_credit_label" value="#default_credit_label#"><input class="width-80 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all newdebitamount percentmask2" type="text" name="default_credit" id="default_credit" value="#default_credit#%"></li>  

<section id="otherdebitsec">
</section>
<!---
		<cfif structkeyexists(rc,"debitcredit")>
			<cfloop query="rc.debitcredit">
				<li class="firstdebitfield clear"><input type="hidden" name="debtcredit_id" value="#debtcredit_id#"><input class="width-200 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all txtleft newdebitname" name="new_debitname" value="#debtcredit_name#"><input class="width-80 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all newdebitamount" type="text" name="new_debitamount" value="#debtcredit_value#"></li>
        	</cfloop>
		</cfif> --->
		 <li id="addglDebit">
            <label class="width-302"><img src="/images/plus.png" class="plus"></label>
          </li>
          <li class="clear">
            <label class="bold width-302">Credits</label>
          </li>         
<section id="othercreditsec">
</section>   
		 <li id="addglCredit" class="clear">
            <label class="width-302"><img src="/images/plus.png" class="plus"></label>
          </li>  
          <li>
            <label class="width-200 bold">Total Debits/Credits</label>
          </li>
          <li>
            <input type="hidden" name="total_debits" value="#total_debits#" id="total_debits">
            <input type="text" name="total_debitspercent" value="#total_debitspercent#%" id="total_debitspercent" class="width-80 percentmask readonly">
          </li>        
          <li>
            <label class="width-200 bold">Total Rating Mod Factor</label>
          </li>
          <li>
            <input type="text" name="total_mod" value="#numberFormat(total_mod, '_.__')#" id="total_mod" class="width-80 readonly">
          </li>	                             
          <li>
            <input type="text" class="width-200 txtleft" name="premium_mod_label" id="premium_mod_label" value="<cfif trim(premium_mod_label) eq ''>Premium Mod Factor<cfelse>#premium_mod_label#</cfif>">
<input type="text" name="premium_mod" value="#numberFormat(premium_mod, '_.__')#%" id="premium_mod" class="width-80 percentmask">
          </li>	
       	
          <li>
            <label class="width-200 bold">Final Mod Factor</label>
          </li>
          <li>
            <input type="text" name="final_mod" value="#numberFormat(final_mod, '_.__')#" id="final_mod" class="width-80 readonly">
          </li>	
          <li <cfif isdefined("summary") and use_prorata eq 1> style="display:none;"</cfif>>
            <label class="width-200">Loc Annual Premium</label>
          </li>
          <li<cfif isdefined("summary") and use_prorata eq 1> style="display:none;"</cfif>>
            <input type="text" name="loc_annual_premium" value="#loc_annual_premium#" class="width-80 dollarmask locannualprem readonly">
          </li>
          
          <li <cfif isdefined("summary") and use_prorata neq 1> style="display:none;"</cfif>>
            <label class="width-200">Pro Rata Liability Premium</label>
          </li>
          <li <cfif isdefined("summary") and use_prorata neq 1> style="display:none;"</cfif>>
            <input type="text" name="pro_rata_gl" value="#pro_rata_gl#" id="pro_rata_gl" class="width-80 dollarmask readonly">
          </li>

          <li>
            <label class="bold width-302">&nbsp;</label>
          </li>
          <li>
            <label class="bold width-302">Taxes/Fees</label>
          </li>
          <li>
            <label class="width-129 bfeelabel csummaryspecial">Broker Fee</label>
          </li>
          <li class="bo csummaryhide width-21">
            <input type="checkbox" name="broker_override" value="1" class="plaincheck" id="broker_override" <cfif broker_override eq 1>checked</cfif>>
          </li> 
          <li class="csummaryhide">
            <label for="broker_override" class="overridelabel">Override</label>
          </li>			
          </li>         
          <li>
            <input type="text" name="brokerfee" value="#brokerfee#" id="brokerfee" class="width-80 dollarmaskdec">
          </li>
          <li class="brokeroverride clear">
          <input type="radio" name="broker_flatpercent" value="#broker_flatpercent#" id="broker_percent" />
          </li>
          <li class="brokeroverride">
          <label>Percent</label>
          </li>
          <li class="brokeroverride">
          <input type="text" name="broker_percentoverride" value="#broker_percentoverride#" id="broker_percentoverride" class="width-35 percentmask" />
          </li>
          <li class="brokeroverride" style="padding-left:26px;">
          <input type="radio" name="broker_flatpercent" value="#broker_flatpercent#" id="broker_flat" />
          </li>
          <li class="brokeroverride">
          <label class="overridelabel">Flat</label>
          </li>          
          <li class="clear">
            <label class="width-129 csummaryspecial">Surplus Tax</label>
          </li>
          <li class="width-21 csummaryhide">
            <input type="checkbox" name="surplustax_override" value="1" class="plaincheck overridefield" overridefield="surplustax" id="surplustax_override" <cfif surplustax_override eq 1>checked</cfif>>
          </li>   
          <li class="csummaryhide">
            <label for="surplustax_override" class="overridelabel">Override</label>
          </li>	                  
          <li>
            <input type="text" name="surplustax" value="#surplustax#" id="surplustax" originalval="#ReReplace(surplustax, '[^\d.]', '','all')#" class="width-80 dollarmaskdec taxes">
          </li>
          <li>
            <label class="width-129 csummaryspecial">Inspection Fee</label>
          </li>
          <li class="width-21 csummaryhide">
            <input type="checkbox" name="inspection_override" value="1" class="plaincheck overridefield" overridefield="inspectionfee" id="inspection_override" <cfif inspection_override eq 1>checked</cfif>>
          </li> 
          <li class="csummaryhide">
            <label for="inspection_override" class="overridelabel">Override</label>
          </li>			
               
          <li>
            <input type="text" name="inspectionfee" value="#inspectionfee#" id="inspectionfee" originalval="#ReReplace(inspectionfee, '[^\d.]', '','all')#" class="width-80 dollarmaskdec fees">
          </li>
          <li class="clear">
            <label class="width-129 tfeelabel">Terrorism Fee</label>
          </li>
          <li class="width-21">
          <input type="hidden" name="terrorism_minimum" id="terrorism_minimum" value="0">
            <input type="checkbox" name="terrorism_rejected" value="1" id="terrorism_rejected" class="plaincheck" <cfif terrorism_rejected is 1>checked="checked"</cfif>>
          </li>
          <li>
            <label for="terrorism_rejected" class="overridelabel">Rejected</label>
          </li>
          <li>
            <input type="hidden" name="terrorism_fee" value="#terrorism_fee#" id="terrorism_fee">
            <input type="text" name="terrorism_fee_field" value="<cfif terrorism_rejected is 1>$0.00<cfelse>#terrorism_fee#</cfif>" id="terrorism_fee_field" class="width-80 dollarmask readonly">
          </li>
          <li>
            <label class="bold width-302">&nbsp;</label>
          </li>
          <li>
            <label class="bold width-302">Other Taxes/Fees</label>
          </li>
          <li>
            <label class="width-200">Stamping Fee</label>
          </li>
          <li>
            <input type="text" name="stampingfee" value="#stampingfee#" id="stampingfee" class="width-80 dollarmaskdec taxes readonly">
          </li>
          <li>
            <label class="width-129 csummaryspecial">Filing Fee</label>
          </li>
          <li class="width-21 csummaryhide">
            <input type="checkbox" name="filing_override" value="1" class="plaincheck overridefield" overridefield="filingfee" id="filing_override" <cfif filing_override eq 1>checked</cfif>>
          </li> 
          <li class="csummaryhide">
            <label for="filing_override" class="overridelabel">Override</label>
          </li>	
          <li>
            <input type="text" name="filingfee" value="#filingfee#" id="filingfee" class="width-80 dollarmask fees" originalval="#ReReplace(filingfee, '[^\d.]', '','all')#">
          </li>          
          <li class="clear">
            <label class="width-129 csummaryspecial">State/Muni Surcharge</label>
          </li>
          <li class="width-21 csummaryhide">
            <input type="checkbox" name="statemuni_override" value="1" class="plaincheck overridefield" overridefield="statecharge" id="statemuni_override" <cfif statemuni_override eq 1>checked</cfif>>
          </li> 
          <li class="csummaryhide">
            <label for="statemuni_override" class="overridelabel">Override</label>
          </li>	
          <li>
            <input type="text" name="statecharge" value="#statecharge#" id="statecharge" class="width-80 dollarmaskdec taxes" originalval="#ReReplace(statecharge, '[^\d.]', '','all')#">
          </li>
          <li class="clear">
            <label class="width-129 csummaryspecial">RPG Fee</label>
          </li>
          <li class="width-21 csummaryhide">
            <input type="checkbox" name="rpg_override" value="1" class="plaincheck overridefield" overridefield="rpgfee" id="rpg_override" <cfif rpg_override eq 1>checked</cfif>>
          </li> 
          <li class="csummaryhide">
            <label for="rpg_override" class="overridelabel">Override</label>
          </li>	
          <li>
            <input type="text" name="rpgfee" value="#rpgfee#" id="rpgfee" class="width-80 dollarmask fees">
          </li>
     
          <li class="csummaryhide">
            <label class="width-200">RPG All Locations</label>
          </li>
          <li class="csummaryhide">
            <input type="text" name="rpgall" value="#rpgall#" id="rpgall" class="width-80 dollarmask readonly">
          </li>
          <li>
            <label class="width-200 bold">GRAND TOTAL</label>
          </li>
          <li>
            <input type="text" name="grandtotal" value="#grandtotal#" class="width-80 dollarmaskdec grandtotal readonly">
          </li>
        </ul>
        <ul id="csummarymove1" class="formfields width-365 col3">
          <li>
            <label class="bold width-163">Policy Effective Date</label>
          </li>
          <li>
            <label class="width-80"><cfoutput>#dateFormat(rc.cinfo.current_effective_date,'mm/dd/yyyy')#</cfoutput></label>
          </li>
          <li>
            <label class="width-80">&nbsp;</label>
          </li>
          <li>
            <label class="width-30">ProRata</label>
          </li>
          <li class="clear">
            <label class="bold width-163 glfromto">Liability Effective From/To</label>
          </li>
          <li>
            <input type="text" name="gldate1"  id="gldate1" class="width-80 txtleft datebox" value="<cfoutput>#dateFormat(gldate1, 'mm/dd/yyyy')#</cfoutput>">
          </li>
          <li>
            <input type="text" name="gldate2" id="gldate2" class="width-80 txtleft datebox" value="<cfoutput>#dateFormat(gldate2, 'mm/dd/yyyy')#</cfoutput>">
          </li>
          <li>
            <input type="text" name="gl_prorate" value="#numberFormat(gl_prorate, '_.___')#" id="gl_prorate" class="width-30 readonly">
          </li>
          <li class="clear" style="padding-left:3px;">
          <input type="checkbox" name="use_prorata"  value="1" id="use_prorata" <cfif use_prorata eq 1>checked</cfif> />
          </li>
          <li><label for="use_prorata">Apply Pro Rata</label></li>          
          <li class="csummaryhide clear">
            <label class="bold width-365">&nbsp;</label>
          </li>
          <section id="csummarymove2">
          <li class="csummaryhide clear">
            <label class="bold width-365">Underwriting Notes</label>
          </li>
          <li>
          	<cfif endorse eq 1>
							<cfset underwriting_notes = "Endorsement Added.">
             <cfset inputname = "historynotes"> 
           <cfelse>
           	<cfset inputname = "underwriting_notes">
           </cfif> 
            <textarea name="#inputname#" class="ratingtextareas">#underwriting_notes#</textarea>
            <div class="hidden asummarygl">#underwriting_notes#</div>
            <div class="hidden asummaryprop">#prop_underwritingnotes#</div>
          </li>
          <li>
            <label class="bold width-365">&nbsp;</label>
          </li>
          
          <li>
            <label class="bold width-365">Answers to yes/no questions</label>
          </li>
          <li>
            <textarea name="yesnoquestions" id="yesnoquestions" class="ratingtextareas">#yesnoquestions#</textarea>
            <div class="hidenotes csummaryshow">#yesnoquestions#</div>
          </li>
          <li class="csummaryhide asummaryhide">
            <label class="bold width-365">Proposal Notes</label>
          </li>          
          <li class="csummaryhide asummaryhide">
            <textarea name="liability_propnotes" id="liability_propnotes" class="ratingtextareas" style="height:50px;">#liability_propnotes#</textarea>
            <div class="hidden asummaryprop">#liability_propnotes#</div>
          </li>          
          </section>
        </ul>
        <div style="clear:both"></div>
        <div class="buttoncontainer">
		
		
		<cfif endorse eq 1>
			<button class="buttons" id="glratebutton">RATE</button>
            <button id="saveendorsementbutton" class="saveendorsebutton buttons">SAVE HISTORY</button>
	    <cfelse>
	    <!---<button class="buttons backbutton">BACK</button>--->
	    <button class="buttons" id="glratebutton">RATE</button>
			<cfif viewhistory neq 1> <button id="saveratingbutton" class="saveratingbutton buttons">SAVE</button></cfif>
			<cfif viewhistory neq 1> <button class="savehistorybutton buttons">SAVE TO HISTORY</button></cfif>
	    </cfif>      
	          <button class="buttons csummarybutton">CARRIER SUMMARY</button>
	          <button class="buttons asummarybutton">AGENCY SUMMARY</button>
		
        
       
       
        </div>
      </div>
<!--- Property Tab  --->      
      <div id="tabs-2">
        <ul id="prop1col" class="formfields" style="width:326px;">
          <li>
            <label class="width-230">Prop All Other Deductible</label>
          </li>
          <li>
            <input type="text" name="prop_deductible" value="#dollarformat(prop_deductible)#" class="width-80 dollarmask">
          </li>
          <li class="clear">
            <label class="width-138">Wind/Hail Deductible</label>
          </li>
          <li>
            <input type="checkbox" name="prop_exclwind" value="1" id="prop_exclwind" prop_exclwind="#prop_exclwind#" class="propchecks"<cfif val(prop_exclwind) is 1> checked</cfif>>
          </li>
          <li><label class="width-64" for="prop_exclwind">Exclude</label></li>
          <li>
            <input type="text" name="prop_winddeductable" id="prop_winddeductable" value="<cfif prop_winddeductable neq 0>#prop_winddeductable#</cfif>" class="width-80<cfif val(prop_exclwind) is 1> readonlyLive</cfif>">
          </li>
          <li class="clear">
            <label class="width-100">&nbsp;</label>
          </li>
          <li>
            <label class="width-34 bold center">Rate</label>
          </li>
          <li>
            <label class="width-80 dollarmask bold center">Limit</label>
          </li> 
          <li>
            <label class="width-80 dollarmask bold center">Premium</label>
          </li>                    
          <li class="clear">
            <label class="width-100">Building</label>
          </li>
          <li>
            <input type="text" name="prop_buildingrate" value="#prop_buildingrate#" class="width-34 numberdecmask prate">

            <input type="text" name="prop_buildinglimit"  value="#dollarformat(prop_buildinglimit)#" class="width-80 dollarmask plimit">

            <input type="text" name="prop_buildingpremium" value="#dollarformat(prop_buildingpremium)#" class="width-80 dollarmask ppremium eqpbrk">
          </li>
          <li class="clear">
            <label class="width-100">BPP</label>
          </li>
          <li>
            <input type="text" name="prop_bpprate" value="#prop_bpprate#" class="width-34 numberdecmask prate">

            <input type="text" name="prop_bpplimit" value="#dollarformat(prop_bpplimit)#" class="width-80 dollarmask plimit">

            <input type="text" name="prop_bpppremium" value="#dollarformat(prop_bpppremium)#" class="width-80 dollarmask ppremium eqpbrk">
          </li>
          <li class="clear">
            <label class="width-100">TI</label>
          </li>
          <li>
            <input type="text" name="prop_tirate" value="#prop_tirate#" class="width-34 numberdecmask prate">

            <input type="text" name="prop_tilimit" value="#dollarformat(prop_tilimit)#" class="width-80 dollarmask plimit">

            <input type="text" name="prop_tipremium" value="#dollarformat(prop_tipremium)#" class="width-80 dollarmask ppremium eqpbrk">
          </li>
          <li class="clear">
              <input type="checkbox" name="prop_90" value="1" id="prop_90" class="propchecks" <cfif prop_90 eq 1>checked</cfif>>
              </li>
              <li><input type="text" class="width-34" value="#prop_coinsurancelabel#" name="prop_coinsurancelabel" id="prop_coinsurancelabel"></li>
              <li><label>
              Coinsurance</label>
          </li>
          <li class="clear">
            <label class="width-100">BI/EE</label>
          </li>
          <li>
            <input type="text" name="prop_bieerate" value="#prop_bieerate#" class="width-34 numberdecmask prate">

            <input type="text" name="prop_bieelimit" value="#dollarformat(prop_bieelimit)#" class="width-80 dollarmask plimit">

            <input type="text" name="prop_bieepremium" value="#dollarformat(prop_bieepremium)#" class="width-80 dollarmask ppremium">
          </li>
          <li class="clear">
            <label class="width-230">##Hours Deductible</label>
          </li>
          <li>
            <input type="text" name="prop_daysdeductible" value="#numberFormat(prop_daysdeductible)#" class="width-80 numbermask">
          </li>
          <li>
            <label class="width-302 bold">Other Property Coverage</label>
          </li>


          <li class="clear">
            <label class="width-100">EDP Equipment</label>
          </li>
          <li>
            <input type="text" name="prop_edprate" value="#prop_edprate#" class="width-34 numberdecmask prate">

            <input type="text" name="prop_edplimit" value="#dollarformat(prop_edplimit)#" class="width-80 dollarmask plimit">

            <input type="text" name="prop_edppremium" value="#dollarformat(prop_edppremium)#" class="width-80 dollarmask ppremium eqpbrk">
          </li>          
          <li class="clear">
            <label class="width-100">HVAC</label>
          </li>
          <li>
            <input type="text" name="prop_hvacrate" value="#prop_hvacrate#" class="width-34 numberdecmask prate">

            <input type="text" name="prop_hvaclimit" value="#dollarformat(prop_hvaclimit)#" class="width-80 dollarmask plimit">

            <input type="text" name="prop_hvacpremium" value="#dollarformat(prop_hvacpremium)#" class="width-80 dollarmask ppremium eqpbrk">
          </li>
          <li class="clear">
            <label class="width-100">Sign over $25k</label>
          </li>
          <li>
            <input type="text" name="prop_signrate" value="#prop_signrate#" class="width-34 numberdecmask prate">

            <input type="text" name="prop_signlimit" value="#dollarformat(prop_signlimit)#" class="width-80 dollarmask plimit">

            <input type="text" name="prop_signpremium" value="#dollarformat(prop_signpremium)#" class="width-80 dollarmask ppremium eqpbrk">
          </li>
		<cfif structkeyexists(rc,"otherprop")>
			<cfloop query="rc.otherprop">
			<li class="firstpropfield"><input type="hidden" name="other_property_id" value="#other_property_id#"><input name="newpropfield1" value="#other_title#" class="width-100 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all txtleft"><input type="text" name="newpropfield2" value="#other_rate#" class="width-34 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all prate"><input type="text" name="newpropfield3" value="#dollarformat(other_limit)#" class="width-80 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all plimit"><input type="text" name="newpropfield4" value="#dollarformat(other_premium)#" class="width-80 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all ppremium eqpbrk"></li>
        	</cfloop>
		</cfif>  
		<li id="addProp1" class="clear">
            <label class="width-302"><img src="/images/plus.png" class="plus"></label>
          </li>
          <li class="clear">
            <label class="width-100">&nbsp;</label>
          </li>
          <li>
            <label class="width-34 bold center">&nbsp;</label>
          </li>
          <li>
            <label class="width-80 dollarmask bold center">E.B. Premium</label>
          </li> 
          <li>
            <label class="width-80 dollarmask bold center">&nbsp;</label>
          </li>                    
          <li class="clear">
            <label class="width-100">Equip Breakdown</label>
          </li>
          <li>
            <input type="text" name="prop_equipbreakrate" value="#prop_equipbreakrate#" id="prop_equipbreakrate" class="width-34 percentdecmask">

            <input type="text" name="prop_equipbreaktotal" value="#dollarformat(prop_equipbreaktotal)#" id="prop_equipbreaktotal" class="width-80 dollarmask">

            <input type="text" name="prop_equipbreakpremium" value="#dollarformat(prop_equipbreakpremium)#" id="prop_equipbreakpremium" class="width-80 dollarmask">
          </li>          
          <li class="clear">
</cfoutput>
<label class="width-142">Employee Dishonesty</label></li>
          <li>
            <select id="employee_dishonesty_id" name="employee_dishonesty_id" class="selectbox2" style="width:86px;padding:1px; margin-right:2px;">

<cfoutput query="rc.empdis">
<option value="#rc.empdis.employee_dishonesty_id#"<cfif employee_dishonesty_select eq rc.empdis.employee_dishonesty_id> selected</cfif>>#rc.empdis.employee_dishonesty_amount#</option></cfoutput>
            </select>
          </li>
          <li>
            <input type="text" name="property_emp_amount" value="<cfoutput>#dollarFormat(property_emp_amount)#</cfoutput>" id="property_emp_amount" class="width-80 dollarmask ppremium">
          </li>          
          <li class="clear">
<label class="width-142">Data Breach/Cyber Liability</label>
          </li>
          <li>
            <select id="cyber_liability_amount_id" name="cyber_liability_amount_id" class="selectbox2" style="width:86px;padding:1px; margin-right:2px;">
            <option value="0">Select</option>
<cfoutput query="rc.cyber">
<option value="#rc.cyber.cyber_liability_amount_id#"<cfif rc.cyber.cyber_liability_amount_id eq cyber_liability_select> selected="selected"</cfif>>#rc.cyber.cyber_liability_amount#</option></cfoutput>
            </select>
          </li>
		<cfoutput>
          <li>
            <input type="text" name="property_cyber_amount" value="#dollarFormat(property_cyber_amount)#" id="property_cyber_amount" class="width-80 dollarmask ppremium">
          </li>                     
          <li class="clear">
            <label class="width-100 bold">Other Perils</label>
          </li>
          <li>
            <label class="width-34 bold center">Rate</label>
          </li>
          <li>
            <label class="width-80 dollarmask bold center">Limit</label>
          </li> 
          <li>
            <label class="width-80 dollarmask bold center">Premium</label>
          </li>   
          <li class="clear">
            <label class="width-100">Flood</label>
          </li>
          <li>
            <input type="text" name="prop_floodrate" value="#prop_floodrate#" class="width-34 numberdecmask prate">

            <input type="text" name="prop_floodlimit" value="#dollarformat(prop_floodlimit)#" class="width-80 dollarmask">

            <input type="text" name="prop_floodpremium" value="#dollarformat(prop_floodpremium)#" class="width-80 dollarmask ppremium eqpbrk">
          </li>
          <li class="clear">
          	<label class="width-230">Flood Deductible</label>
          </li>
          <li>
          	<input type="text" name="prop_flooddeduct" value="#dollarformat(prop_flooddeduct)#" class="width-80 dollarmask" />
          </li>
          <li class="clear">
            <label class="width-100">Earthquake</label>
          </li>
          <li>
            <input type="text" name="prop_quakerate" value="#prop_quakerate#" class="width-34 numberdecmask prate">

            <input type="text" name="prop_quakelimit" value="#dollarformat(prop_quakelimit)#" class="width-80 dollarmask">

            <input type="text" name="prop_quakepremium" value="#dollarformat(prop_quakepremium)#" class="width-80 dollarmask ppremium eqpbrk">
          </li>
          <li class="clear">
          	<label class="width-230">Earthquake Deductible</label>
          </li>
          <li>
          	<input type="text" name="prop_quakededuct" value="#dollarformat(prop_quakededuct)#" class="width-80 dollarmask" />
          </li>
		<cfif structkeyexists(rc,"eb")>
			<cfloop query="rc.eb">
			<li><input type="hidden" name="eb_id" value="#eb_id#"><input name="newperil_name" value="#eb_title#" class="width-100 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all txtleft"><input type="text" name="newperil_rate" value="#eb_rate#" class="width-34 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all prate"><input type="text" name="newperil_limit" value="#dollarformat(eb_limit)#" class="width-80 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all"><input type="text" name="newperil_premium" value="#dollarformat(eb_premium)#" class="width-80 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all ppremium eqpbrk"><li class="clear newdeduct"><label class="width-230 newdeductlabel">Deductible</label></li><li><input type="text" name="eb_deduct" value="#dollarformat(eb_deductible)#" class="width-80 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all" /></li>          
        	</cfloop>
		</cfif> 
		 <li id="addProp2">
            <label class="width-302"><img src="/images/plus.png" class="plus"></label>
          </li>
 <!---           <li>
            <label class="width-142">Total Insured Value</label>
          </li>
        <li>
            <input type="text" name="prop_totalvalue" value="##" id="prop_totalvalue" class="width-80 dollarmask">
          </li>
          <li class="clear"><label>Equipment Breakdown</label></li>--->
        </ul>
        <ul class="formfields col2" style="margin-left:20px; width:320px;">
        <li><label class="width-302 bold">Summary</label></li>
          <li>
            <label class="width-130">&nbsp;</label>
          </li>
          <li>
            <label class="width-80 bold center">Rated Premium</label>
          </li>
          <li>
            <label class="width-80 bold center">Charged Premium</label>
          </li>
          <li>          
              <label class="width-60">Property</label>              
          </li>
          <li>
              <input type="checkbox" name="premium_override" value="1" id="premium_override" class="propchecks" <cfif premium_override eq 1>checked</cfif>>
              </li>
              <li><label class="width-45" for="premium_override">Override</label>
          </li>                    
          <li>
            <input type="text" class="width-80 dollarmask" name="prop_ratedpremium" value="#dollarformat(prop_ratedpremium)#" id="prop_ratedpremium">
          </li>
          <li>
            <input type="text" class="width-80 dollarmask" name="prop_chargedpremium" value="#dollarformat(prop_chargedpremium)#" id="prop_chargedpremium">
          </li> 
          <li class="clear">
            <label class="width-221">Pro Rata Premium</label>
          </li>
          <li>
            <input type="text" name="prop_proratapremium" value="#dollarformat(prop_proratapremium)#" id="prop_proratapremium" class="width-80 dollarmask readonly">
          </li>          
          <li class="clear">          
              <label class="width-60">Terrorism</label>              
          </li>
          <li>
              <input type="checkbox" name="prop_terrorism_rejected" value="1" id="prop_terrorism_rejected"  class="propchecks" <cfif prop_terrorism_rejected eq 1>checked</cfif>>
              </li>
              <li><label class="width-133">Rejected</label>
          </li>                    
          <li>
            <input type="text" class="width-80 dollarmask readonly" name="prop_terrorism" value="#dollarformat(prop_terrorism)#" id="prop_terrorism">
          </li> 
          <li class="clear">
            <label class="width-221">Subtotal</label>
          </li>
          <li>
            <input type="text" name="prop_subtotal" value="#dollarformat(prop_subtotal)#" id="prop_subtotal" class="width-80 dollarmask readonly">
          </li>  

        <li class="clear"><label class="width-302 bold">&nbsp;</label></li>
        <li class="clear"><label class="width-302 bold">Taxes/Fees</label></li> 
          <li class="clear">
           
              <label class="width-60">Agency Fee</label>
              
          </li>
          <li>
              <input type="checkbox" name="prop_agencyfeeoverride" overridefield="prop_agencyfee" value="1" id="prop_agencyfeeoverride" class="propchecks overridefield" <cfif prop_agencyfeeoverride eq 1>checked</cfif>>
              </li>
              <li><label class="width-45" for="prop_agencyfeeoverride">Override</label>
          </li>           
                   
          <li>
            <input type="text" class="width-80 percentmask2 readonlyLive" name="prop_agencyfee" value="#numberFormat(prop_agencyfee)#%" id="prop_agencyfee" originalval="#prop_agencyfee#">
          </li>
                      
          <li>
            <input type="text" class="width-80 dollarmask readonly" name="prop_agencyamount" value="$#numberformat(prop_agencyamount)#" id="prop_agencyamount">
          </li> 
          <li class="clear">
            <label class="width-221">Broker Fee</label>
          </li>
          <li>
            <input type="text" name="prop_brokerfee" value="#dollarformat(prop_brokerfee)#" id="prop_brokerfee" class="width-80 dollarmask">
          </li>  
          <li class="clear">
            <label class="width-132">State/Muni Surcharge</label>
          </li>
          <li class="width-21 csummaryhide">
            <input type="checkbox" name="prop_taxoverride" value="1" class="plaincheck overridefield" overridefield="prop_taxes" id="prop_taxoverride" <cfif prop_taxoverride eq 1>checked</cfif>>
          </li>  
          <li class="csummaryhide">
            <label for="prop_taxoverride" class="overridelabel width-60">Override</label>
          </li>	                   
          <li>
            <input type="text" name="prop_taxes" value="#dollarformat(prop_taxes)#" id="prop_taxes" class="width-80 dollarmaskdec readonlyLive" originalval="#prop_taxes#">
          </li>
          <li class="clear">
            <label class="width-221 bold">GRAND TOTAL</label>
          </li>
          <li>
            <input type="text" name="prop_grandtotal" value="#dollarformat(prop_grandtotal)#" id="prop_grandtotal" class="width-80 dollarmaskdec readonly">
          </li>                                                                                    
        </ul>
        <ul id="cpropsummarymove1" class="formfields width-365 col3">
          <li>
            <label class="bold width-163">Policy Effective Date</label>
          </li>
          <li>
            <label class="width-80">#dateFormat(rc.cinfo.current_effective_date,'mm/dd/yyyy')#</label>
          </li>
          <li>
            <label class="width-80">&nbsp;</label>
          </li>
          <li>
            <label class="width-30">ProRata</label>
          </li>
          <li>
            <label class="bold width-163">Property Effective From/To</label>
          </li>
          <li>
            <input type="text" name="propdate1"  id="propdate1" class="width-80 txtleft datebox" value="<cfoutput>#dateFormat(propdate1, 'mm/dd/yyyy')#</cfoutput>">
          </li>
          <li>
            <input type="text" name="propdate2" id="propdate2" class="width-80 txtleft datebox" value="<cfoutput>#dateFormat(propdate2, 'mm/dd/yyyy')#</cfoutput>">
          </li>
          <li>
            <input type="text" name="prop_prorate" value="#numberFormat(prop_prorate, '_.___')#" id="prop_prorate" class="width-30 readonly">
          </li>
          <li class="clear"><input type="checkbox" name="prop_use_prorata" value="1" id="prop_use_prorata" class="propchecks" <cfif prop_use_prorata eq 1>checked="checked"</cfif> /></li>
          <li><label for="prop_use_prorata">Apply Pro Rata</label></li>          
          <li class="csummaryhide">
            <label class="bold width-365">&nbsp;</label>
          </li>
          <li class="csummaryhide">
            <label class="bold width-365">Underwriting Notes</label>
          </li>
          <li>
            <textarea name="prop_underwritingnotes" id="prop_underwritingnotes" class="ratingtextareas">#prop_underwritingnotes#</textarea>
            <div class="hidenotes">#prop_underwritingnotes#</div>
          </li>

          <li class="csummaryhide asummaryhide">
            <label class="bold width-365">Answers to yes/no questions</label>
            
          </li>
          <li class="csummaryhide asummaryhide">
            <textarea name="prop_yesnoquestions" id="prop_yesnoquestions" class="ratingtextareas">#prop_yesnoquestions#</textarea>
            <div class="hidenotes csummaryshow">#prop_yesnoquestions#</div>
          </li>
          <li class="csummaryhide asummaryhide">
            <label class="bold width-365">Proposal Notes</label>
            
          </li>          
          <li class="csummaryhide asummaryhide">
            <textarea name="property_propnotes" id="property_propnotes" class="ratingtextareas" style="height:50px;">#property_propnotes#</textarea>
            <div class="hidden asummaryprop">#property_propnotes#</div>
          </li>          
        </ul>
        <div style="clear:both"></div>
        <div class="buttoncontainer">
           
        <cfif endorse eq 1>
			<button class="buttons" value="##" id="rateprop">RATE</button>
            <button id="savepropendorsementbutton" class="saveendorsebutton buttons">SAVE</button>
	    <cfelse>   
	    
	    	<button class="buttons" value="##" id="rateprop">RATE</button>
			<cfif viewhistory neq 1> <button id="saveratingbutton" class="saveratingbutton buttons">SAVE</button></cfif>
			<cfif viewhistory neq 1> <button class="savehistorybutton buttons">SAVE TO HISTORY</button></cfif>
	        
	          <button class="buttons csummarybutton">CARRIER SUMMARY</button>
	          <button class="buttons asummarybutton">AGENCY SUMMARY</button>
		</cfif>
        </div>        
      </div>
      <!---
      <div id="tabs-3">

      </div>--->
    <cfif endorse neq 1>
	  <div id="tabs-4">
   <div class="bold">Date Range</div>
      <ul class="formfields" style="margin:15px 0; width:auto;">
      <li><input type="radio" name="historyradio" id="historyall" value="all" checked></li>
      <li><label for="historyall">All</label></li>
      <li style="margin-left:10px;"><input type="radio" name="historyradio" id="historyrange" value="all" ></li>
      <li><label for="historyrange">Date Range</label></li>
      
      <li><label>From</label></li>
                <li>
            <input type="text" name="historyStartDate" id="historyStartDate" value="<cfoutput>#dateformat(dateAdd('yyyy',-1,now()),'mm/dd/yyyy')#</cfoutput>" class="width-80 txtleft datebox">
          </li>
          <li><label>To</label></li>
          <li>
            <input type="text" name="historyEndDate" id="historyEndDate" value="<cfoutput>#dateformat(now(),'mm/dd/yyyy')#</cfoutput>" class="width-80 txtleft datebox">
          </li>
          <li><input type="image" src="/images/quickpickbutton.png" name="historyfilter" id="historyfilter"></li>
          </ul>
  
          <div style="clear:both;"></div>
        <table id="historygrid">
        </table>
      </div>
	</cfif>
	  <div class="msgcontainer">
		<div class="message"></div>
	  </div>
    </div>
     <ul id="csummarymove2dest" class="formfields"></ul>
	   </cfoutput> 
    <div class="footerdate"><cfoutput>#dateFormat(now(),'mm/dd/yyyy')#, #timeFormat(now())#</cfoutput></div>
    <!---end tabs--->
  </form>

<cfinclude template="/app/views/common/notes.cfm">
  <div id="dialog-modal" title="Manually Rated Exposure">
    <form autocomplete="off">
      <select id="modalselect" class="selectbox2">
        <option>Select Exposure Type</option>
        <option>Option A</option>
        <option>Option B</option>
      </select>
      <label class="ratingslabel" for="square_footage">Some Option</label>
      <input type="text" name="some_option" value="##" id="some_option">
    </form>
  </div>
    <div id="dialog-modal2" title="Alert">
	<div id="windowmsg"></div>
  </div>
