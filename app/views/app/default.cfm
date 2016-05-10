<cfparam name="viewhistory" default="0">
<cfparam name="ratingid" default="0">
<cfif structkeyexists(rc,"app")>
	<cfparam name="application_id" default="#rc.application_id#">
	<cfparam name='client_id' default='#rc.app.client_id#'>
	<cfparam name='location_id' default='#rc.app.location_id#'>
	<cfparam name='gross_receipts' default='$#numberformat(rc.app.gross_receipts)#'>
	<cfparam name='number_members' default='#rc.app.number_members#'>
	<cfparam name='number_employees_ft' default='#rc.app.number_employees_ft#'>
	<cfparam name='club_hours' default='#rc.app.club_hours#'>
	<cfparam name='number_employees_pt' default='#rc.app.number_employees_pt#'>
	<cfparam name='key_club_24' default='#rc.app.key_club_24#'>
	<cfparam name='sel_requested_limits_id' default='#rc.app.requested_limits_id#'>
	<cfparam name='requested_limits_other' default='#rc.app.requested_limits_other#'>
	<cfparam name='sel_additional_limits_id' default='#rc.app.additional_limits_id#'>
	<cfparam name='additional_limits_other' default='#rc.app.additional_limits_other#'>
	<cfparam name='court_total' default='#rc.app.court_total#'>
	<cfparam name='court_basketball' default='#rc.app.court_basketball#'>
	<cfparam name='court_racquetball' default='#rc.app.court_racquetball#'>
	<cfparam name='court_tennis' default='#rc.app.court_tennis#'>
	<cfparam name='sauna' default='#rc.app.sauna#'>
	<cfparam name='steam_room' default='#rc.app.steam_room#'>
	<cfparam name='whirlpool' default='#rc.app.whirlpool#'>
	<cfparam name='pool_total' default='#rc.app.pool_total#'>
	<cfparam name='pool_indoor' default='#rc.app.pool_indoor#'>
	<cfparam name='pool_outdoor' default='#rc.app.pool_outdoor#'>
	<cfparam name='depth' default='#rc.app.depth#'>
	<cfparam name='pool_other' default='#rc.app.pool_other#'>
	<cfparam name='diving_board' default='#rc.app.diving_board#'>
	<cfparam name='slides' default='#rc.app.slides#'>
	<cfparam name='lifeguards' default='#rc.app.lifeguards#'>
	<cfparam name='swim_risk_signs' default='#rc.app.swim_risk_signs#'>
	<cfparam name='beds_total' default='#rc.app.beds_total#'>
	<cfparam name='beds_tanning' default='#rc.app.beds_tanning#'>
	<cfparam name='beds_spray' default='#rc.app.beds_spray#'>
	<cfparam name='tanning_goggles' default='#rc.app.tanning_goggles#'>
	<cfparam name='ul_approved' default='#rc.app.ul_approved#'>
	<cfparam name='front_desk_controls' default='#rc.app.front_desk_controls#'>
	<cfparam name='tanning_waiver_signed' default='#rc.app.tanning_waiver_signed#'>
	<cfparam name='uv_warnings' default='#rc.app.uv_warnings#'>
	<cfparam name='child_sitting' default='#rc.app.child_sitting#'>
	<cfparam name='number_children' default='#rc.app.number_children#'>
	<cfparam name='max_age' default='#rc.app.max_age#'>
	<cfparam name='ratio_less' default='#rc.app.ratio_less#'>
	<cfparam name='sign_in_out' default='#rc.app.sign_in_out#'>
	<cfparam name='outdoor_playground' default='#rc.app.outdoor_playground#'>
	<cfparam name='play_apparatus' default='#rc.app.play_apparatus#'>
	<cfparam name='play_desc' default='#rc.app.play_desc#'>
	<cfparam name='silver_sneakers' default='#rc.app.silver_sneakers#'>
	<cfparam name='massage' default='#rc.app.massage#'>
	<cfparam name='emp_cont' default='#rc.app.emp_cont#'>
	<cfparam name='personal_trainers' default='#rc.app.personal_trainers#'>
	<cfparam name='number_trainers' default='#rc.app.number_trainers#'>
	<cfparam name='leased_space' default='#rc.app.leased_space#'>
	<cfparam name='leased_square_ft' default='#rc.app.leased_square_ft#'>
	<cfparam name='leased_to' default='#rc.app.leased_to#'>
	<cfparam name='club_named_ai' default='#rc.app.club_named_ai#'>
	<cfparam name='employee_benefits' default='#rc.app.employee_benefits#'>
	<cfparam name='sel_employee_rec_benefits_id' default='#rc.app.employee_rec_benefits_id#'>
	<cfparam name='martial_arts' default='#rc.app.martial_arts#'>
	<cfparam name='climbing_wall' default='#rc.app.climbing_wall#'>
	<cfparam name='team_sports' default='#rc.app.team_sports#'>
	<cfparam name='childrens_programming' default='#rc.app.childrens_programming#'>
	<cfparam name='spa' default='#rc.app.spa#'>
	<cfparam name='physical_therapy' default='#rc.app.physical_therapy#'>
	<cfparam name='boxing' default='#rc.app.boxing#'>
	<cfparam name='off_premises' default='#rc.app.off_premises#'>
	<cfparam name='cooking_food' default='#rc.app.cooking_food#'>
	<cfparam name='transportation' default='#rc.app.transportation#'>
	<cfparam name='events_sponsored' default='#rc.app.events_sponsored#'>
	<cfparam name='sports_performance' default='#rc.app.sports_performance#'>
	<cfparam name='crossfit' default='#rc.app.crossfit#'>
	<cfparam name='notes' default='#rc.app.notes#'>
	<cfparam name='aed' default='#rc.app.aed#'>
	<cfparam name='cameras' default='#rc.app.cameras#'>
	<cfparam name='aerobics' default='#rc.app.aerobics#'>
	<cfparam name='aerobic_certs' default='#rc.app.aerobic_certs#'>
	<cfparam name='pt' default='#rc.app.pt#'>
	<cfparam name='pt_certs' default='#rc.app.pt_certs#'>
	<cfparam name='company_vehicles' default='#rc.app.company_vehicles#'>
	<cfparam name='coverage_declined' default='#rc.app.coverage_declined#'>
	<cfparam name='declined_reason' default='#rc.app.declined_reason#'>
	<cfparam name='cpr' default='#rc.app.cpr#'>
	<cfparam name='cpr_certs' default='#rc.app.cpr_certs#'>
	<cfparam name='losses' default='#rc.app.losses#'>
	<cfparam name='losses_reason' default='#rc.app.losses_reason#'>
	<cfparam name='sex_abuse_policy' default='#rc.app.sex_abuse_policy#'>
	<cfparam name='leased_employees' default='#rc.app.leased_employees#'>
	<cfparam name='contractor_certs' default='#rc.app.contractor_certs#'>
	<cfparam name='signed_employment' default='#rc.app.signed_employment#'>
	<cfparam name='references_checked' default='#rc.app.references_checked#'>
	<cfparam name='background_check' default='#rc.app.background_check#'>
	<cfparam name='rentown' default='#rc.app.rentown#'>
	<cfparam name='square_ft' default='#rc.app.square_ft#'>
	<cfparam name='stories' default='#rc.app.stories#'>
	<cfparam name='year_built' default='#rc.app.year_built#'>
	<cfparam name='update_electrical' default='#rc.app.update_electrical#'>
	<cfparam name='update_plumbing' default='#rc.app.update_plumbing#'>
	<cfparam name='update_roofing' default='#rc.app.update_roofing#'>
	<cfparam name='occupants_right' default='#rc.app.occupants_right#'>
	<cfparam name='occupants_left' default='#rc.app.occupants_left#'>
	<cfparam name='occupants_rear' default='#rc.app.occupants_rear#'>
	<cfparam name='burglar_alarm' default='#rc.app.burglar_alarm#'>
	<cfparam name='fire_alarm' default='#rc.app.fire_alarm#'>
	<cfparam name='sprinklered' default='#rc.app.sprinklered#'>
	<cfparam name='smoke_detectors' default='#rc.app.smoke_detectors#'>
	<cfparam name='miles_from_coast' default='#rc.app.miles_from_coast#'>
	<cfparam name='sel_club_located_id' default='#rc.app.club_located_id#'>
	<cfparam name='club_located_other' default='#rc.app.club_located_other#'>
	<cfparam name='sel_construction_type_id' default='#rc.app.construction_type_id#'>
	<cfparam name='construction_other' default='#rc.app.construction_other#'>
	<cfparam name='sel_roof_type_id' default='#rc.app.roof_type_id#'>
	<cfparam name='roof_other' default='#rc.app.roof_other#'>
	<cfparam name='air_structure' default='#rc.app.air_structure#'>
	<cfparam name='building_coverage' default='#rc.app.building_coverage#'>
	<cfparam name='building_coverage_amount' default='$#numberformat(rc.app.building_coverage_amount)#'>
	<cfparam name='business_prop' default='#rc.app.business_prop#'>
	<cfparam name='business_prop_amount' default='$#numberformat(rc.app.business_prop_amount)#'>
	<cfparam name='tenant_improvements' default='#rc.app.tenant_improvements#'>
	<cfparam name='tenant_improvements_amount' default='$#numberformat(rc.app.tenant_improvements_amount)#'>
	<cfparam name='business_income' default='#rc.app.business_income#'>
	<cfparam name='business_income_amount' default='$#numberformat(rc.app.business_income_amount)#'>
	<cfparam name='edp' default='#rc.app.edp#'>
	<cfparam name='edp_amount' default='$#numberformat(rc.app.edp_amount)#'>
	<cfparam name='employee_dishonesty' default='#rc.app.employee_dishonesty#'>
	<cfparam name='sel_employee_dishonesty_id' default='#rc.app.employee_dishonesty_id#'>
	<cfparam name='hvac' default='#rc.app.hvac#'>
	<cfparam name='hvac_amount' default='$#numberformat(rc.app.hvac_amount)#'>
	<cfparam name='signs_25' default='#rc.app.signs_25#'>
	<cfparam name='signs_25_amount' default='$#numberformat(rc.app.signs_25_amount)#'>
	<cfparam name='cyber_liability' default='#rc.app.cyber_liability#'>
	<cfparam name='sel_cyber_liability_amount_id' default='#rc.app.cyber_liability_amount_id#'>
	<cfparam name='additional_limit' default='#rc.app.additional_limit#'>
	<cfparam name='additional_limit_amount' default='#rc.app.additional_limit_amount#'>
	<cfparam name='additional_limit_reason' default='#rc.app.additional_limit_reason#'>
	<cfparam name='eap' default='$#numberformat(rc.app.eap)#'>
	<cfparam name='sel_epl_limits_id' default='#rc.app.epl_limits_id#'>
	<cfparam name='include_do' default='#rc.app.include_do#'>
	<cfparam name="named_insured" default="#rc.app.named_insured#">
    <cfparam name="current_effective_date" default="#rc.clientinfo.current_effective_date#">
	<cfparam name="dba" default="#rc.app.dba#">
	<cfparam name="address" default="#rc.app.address#">
	<cfparam name="address2" default="#rc.app.address2#">
	<cfparam name="city" default="#rc.app.city#">
	<cfparam name="state_id" default="#rc.app.state_id#">
	<cfparam name="zip" default="#rc.app.zip#">
	<cfparam name="location_number" default="#rc.app.location_number#">
	<cfparam name="fein" default="#rc.app.fein#">
	<cfparam name="year_business_started" default="#rc.app.year_business_started#">
	<cfparam name="description" default="#rc.app.description#">
	<cfparam name="beauty_angel" default="#rc.app.beauty_angel#">
<cfelse>
	<cfparam name="application_id" default="0">
	<cfparam name='client_id' default='#url.client_id#'>
	<cfparam name='location_id' default='0'>
	<cfparam name='gross_receipts' default=''>
	<cfparam name='number_members' default=''>
	<cfparam name='number_employees_ft' default=''>
	<cfparam name='club_hours' default=''>
	<cfparam name='number_employees_pt' default=''>
	<cfparam name='key_club_24' default=''>
	<cfparam name='sel_requested_limits_id' default=''>
	<cfparam name='requested_limits_other' default=''>
	<cfparam name='sel_additional_limits_id' default=''>
	<cfparam name='additional_limits_other' default=''>
	<cfparam name='court_total' default=''>
	<cfparam name='court_basketball' default=''>
	<cfparam name='court_racquetball' default=''>
	<cfparam name='court_tennis' default=''>
	<cfparam name='sauna' default=''>
	<cfparam name='steam_room' default=''>
	<cfparam name='whirlpool' default=''>
	<cfparam name='pool_total' default=''>
	<cfparam name='pool_indoor' default=''>
	<cfparam name='pool_outdoor' default=''>
	<cfparam name='depth' default=''>
	<cfparam name='pool_other' default=''>
	<cfparam name='diving_board' default=''>
	<cfparam name='slides' default=''>
	<cfparam name='lifeguards' default=''>
	<cfparam name='swim_risk_signs' default=''>
	<cfparam name='beds_total' default=''>
	<cfparam name='beds_tanning' default=''>
	<cfparam name='beds_spray' default=''>
	<cfparam name='tanning_goggles' default=''>
	<cfparam name='ul_approved' default=''>
	<cfparam name='front_desk_controls' default=''>
	<cfparam name='tanning_waiver_signed' default=''>
	<cfparam name='uv_warnings' default=''>
	<cfparam name='child_sitting' default=''>
	<cfparam name='number_children' default=''>
	<cfparam name='max_age' default=''>
	<cfparam name='ratio_less' default=''>
	<cfparam name='sign_in_out' default=''>
	<cfparam name='outdoor_playground' default=''>
	<cfparam name='play_apparatus' default=''>
	<cfparam name='play_desc' default=''>
	<cfparam name='silver_sneakers' default=''>
	<cfparam name='massage' default=''>
	<cfparam name='emp_cont' default=''>
	<cfparam name='personal_trainers' default=''>
	<cfparam name='number_trainers' default=''>
	<cfparam name='leased_space' default=''>
	<cfparam name='leased_square_ft' default=''>
	<cfparam name='leased_to' default=''>
	<cfparam name='club_named_ai' default=''>
	<cfparam name='employee_benefits' default=''>
	<cfparam name='sel_employee_rec_benefits_id' default=''>
	<cfparam name='martial_arts' default=''>
	<cfparam name='climbing_wall' default=''>
	<cfparam name='team_sports' default=''>
	<cfparam name='childrens_programming' default=''>
	<cfparam name='spa' default=''>
	<cfparam name='physical_therapy' default=''>
	<cfparam name='boxing' default=''>
	<cfparam name='off_premises' default=''>
	<cfparam name='cooking_food' default=''>
	<cfparam name='transportation' default=''>
	<cfparam name='events_sponsored' default=''>
	<cfparam name='sports_performance' default=''>
	<cfparam name='crossfit' default=''>
	<cfparam name='notes' default=''>
	<cfparam name='aed' default=''>
	<cfparam name='cameras' default=''>
	<cfparam name='aerobics' default=''>
	<cfparam name='aerobic_certs' default=''>
	<cfparam name='pt' default=''>
	<cfparam name='pt_certs' default=''>
	<cfparam name='company_vehicles' default=''>
	<cfparam name='coverage_declined' default=''>
	<cfparam name='declined_reason' default=''>
	<cfparam name='cpr' default=''>
	<cfparam name='cpr_certs' default=''>
	<cfparam name='losses' default=''>
	<cfparam name='losses_reason' default=''>
	<cfparam name='sex_abuse_policy' default=''>
	<cfparam name='leased_employees' default=''>
	<cfparam name='contractor_certs' default=''>
	<cfparam name='signed_employment' default=''>
	<cfparam name='references_checked' default=''>
	<cfparam name='background_check' default=''>
	<cfparam name='rentown' default=''>
	<cfparam name='square_ft' default=''>
	<cfparam name='stories' default=''>
	<cfparam name='year_built' default=''>
	<cfparam name='update_electrical' default=''>
	<cfparam name='update_plumbing' default=''>
	<cfparam name='update_roofing' default=''>
	<cfparam name='occupants_right' default=''>
	<cfparam name='occupants_left' default=''>
	<cfparam name='occupants_rear' default=''>
	<cfparam name='burglar_alarm' default=''>
	<cfparam name='fire_alarm' default=''>
	<cfparam name='sprinklered' default=''>
	<cfparam name='smoke_detectors' default=''>
	<cfparam name='miles_from_coast' default=''>
	<cfparam name='sel_club_located_id' default=''>
	<cfparam name='club_located_other' default=''>
	<cfparam name='sel_construction_type_id' default=''>
	<cfparam name='construction_other' default=''>
	<cfparam name='sel_roof_type_id' default=''>
	<cfparam name='roof_other' default=''>
	<cfparam name='air_structure' default=''>
	<cfparam name='building_coverage' default=''>
	<cfparam name='building_coverage_amount' default=''>
	<cfparam name='business_prop' default=''>
	<cfparam name='business_prop_amount' default=''>
	<cfparam name='tenant_improvements' default=''>
	<cfparam name='tenant_improvements_amount' default=''>
	<cfparam name='business_income' default=''>
	<cfparam name='business_income_amount' default=''>
	<cfparam name='edp' default=''>
	<cfparam name='edp_amount' default='0'>
	<cfparam name='employee_dishonesty' default=''>
	<cfparam name='sel_employee_dishonesty_id' default='0'>
	<cfparam name='hvac' default=''>
	<cfparam name='hvac_amount' default=''>
	<cfparam name='signs_25' default=''>
	<cfparam name='signs_25_amount' default=''>
	<cfparam name='cyber_liability' default=''>
	<cfparam name='sel_cyber_liability_amount_id' default=''>
	<cfparam name='additional_limit' default=''>
	<cfparam name='additional_limit_amount' default=''>
	<cfparam name='additional_limit_reason' default=''>
	<cfparam name='eap' default=''>
	<cfparam name='sel_epl_limits_id' default=''>
	<cfparam name='include_do' default=''>
	<cfparam name="named_insured" default="#rc.clientinfo.entity_name#">
    <cfparam name="current_effective_date" default="#rc.clientinfo.current_effective_date#">
	<cfparam name="dba" default="#rc.clientinfo.dba#">
	<cfparam name="address" default="">
	<cfparam name="address2" default="">
	<cfparam name="city" default="">
	<cfparam name="state_id" default="">
	<cfparam name="zip" default="">
	<cfparam name="location_number" default="#rc.newLocNum#">
	<cfparam name="fein" default="#rc.clientinfo.fein#">
	<cfparam name="year_business_started" default="#rc.clientinfo.year_business_started#">
	<cfparam name="description" default="">
	<cfparam name="beauty_angel" default="">
</cfif>

<cfinclude template="default.js.cfm">
<p class="message" style="padding-bottom:20px;"></p>

<form action="" id="appform" method="post" autocomplete="off">
		<cfoutput>
	<input type="hidden" name="client_id" value="#client_id#">
	<input type="hidden" name="location_id" value="#location_id#">
	<input type="hidden" name="application_id" value="#application_id#">
  <input type="hidden" name="ratingid" value="#ratingid#">  
    <cfif isDefined('print')>
	<ul class="formfields txtleft effdate">
    <li class="clear"><label class="bold">Effective Date</label></li>
    <li><input type="text" name="current_effective_date" id="current_effective_date" value="#dateFormat(current_effective_date, 'mm/dd/yyyy')#" style="width:116px;" /></li>
    </ul>
    <ul class="formfields txtleft appcontact1 clear" >
	<li class="clear"><label class="bold">Contact 1</label></li>
	<li class="clear"><label class="width-65">Name</label></li>
	<li><input type="text" name="name" class="width-125" value="#rc.contacts.name[1]#"></li>
	<li><label class="width-50" style="padding-left:20px;">Title</label></li>
	<li><input type="text" name="title" class="width-125" value="#rc.contacts.title[1]#"></li>
	<li class="clear"><label class="width-65">Phone</label></li>
	<li><input type="text" name="phone" class="width-125" value="#rc.contacts.phone[1]#"></li>
	<li><label class="width-50" style="padding-left:20px;">Cell</label></li>
	<li><input type="text" name="cell" class="width-125" value="#rc.contacts.cell[1]#"></li>
	<li class="clear"><label class="width-65">Fax</label></li>
	<li><input type="text" name="fax" class="width-125" value="#rc.contacts.fax[1]#"></li>
	<li><label class="width-50" style="padding-left:20px;">Email</label></li>
	<li><input type="text" name="email" class="width-125" value="#rc.contacts.email[1]#"></li>
    </ul>
    <ul class="formfields txtleft appcontact2" >
	<li class="clear"><label class="bold">Contact 2</label></li>
	<li class="clear"><label class="width-65">Name</label></li>
	<li><input type="text" name="name" class="width-125" value="#rc.contacts.name[2]#"></li>
	<li><label class="width-50" style="padding-left:20px;">Title</label></li>
	<li><input type="text" name="title" class="width-125" value="#rc.contacts.title[2]#"></li>
	<li class="clear"><label class="width-65">Phone</label></li>
	<li><input type="text" name="phone" class="width-125" value="#rc.contacts.phone[2]#"></li>
	<li><label class="width-50" style="padding-left:20px;">Cell</label></li>
	<li><input type="text" name="cell" class="width-125" value="#rc.contacts.cell[2]#"></li>
	<li class="clear"><label class="width-65">Fax</label></li>
	<li><input type="text" name="fax" class="width-125" value="#rc.contacts.fax[2]#"></li>
	<li><label class="width-50" style="padding-left:20px;">Email</label></li>
	<li><input type="text" name="email" class="width-125" value="#rc.contacts.email[2]#"></li>
    </ul>    

    </cfif>
<ul class="formfields txtleft appul1<cfif isDefined('print')>print</cfif>">
<li><label class="bold">Location Information</label></li>
<li class="clear"><label class="width-120">Named Insured</label></li>
<li><input type="text" id="named_insured" name="named_insured" value="#named_insured#" class="width-240" /></li>
<li class="clear"><label class="width-120">DBA</label></li>
<li><input type="text" id="dba" name="dba" class="width-240" value="#dba#" /></li>
<li class="clear"><label class="width-120">Location Address</label></li>
<li><input type="text" id="address" name="address" class="width-240" value="#address#" /></li>
<li class="clear"><label class="width-120">Address 2</label></li>
<li><input type="text" id="address2" name="address2" class="width-240" value="#address2#" /></li>
<li class="clear"><label class="width-120">City, State, Zip</label></li>
<li><input type="text" name="city" class="width-128" style="margin-right:2px;" value="#city#"></li>
<li class="selectli" style="padding-right:2px;"><select name="state_id" id="state_id" class="selectbox2" style="width:55px;">
<!---<option value="0">State</option>--->
<cfset state = state_id>
<cfloop query="rc.states">
<option value="#rc.states.state_id#" style="font-style:normal;" <cfif state eq rc.states.state_id>selected</cfif>>#rc.states.name#</option>
</cfloop></select></li>
<li><input type="text" name="zip" class="width-45" value="#zip#"></li>
<li class="clear"><label class="width-120">Location ##</label></li>
<li><input type="text" name="location_number" value="#location_number#"class="width-128 numbermask" style="margin-right:2px"></li>
<li class="clear"><label class="width-120">FEIN</label></li>
<li><input type="text" name="fein"  value="#fein#" class="width-128" style="margin-right:2px"></li>
<cfif isDefined("print")>
<li class="clear"><label class="width-120">Website</label></li>
<li><input type="text" name="website"  value="#rc.clientinfo.website#" class="width-128" style="margin-right:2px"></li>
</cfif>
<li class="clear"><label class="width-120">Year Business Started</label></li>
<li><input type="text" name="year_business_started" value="#year_business_started#" class="width-128 numbermask" style="margin-right:2px"></li>
<cfif isDefined("print")>
<li><label>## Years Exp</label></li>
<li><input type="text" name="years_experience" value="#rc.clientinfo.years_experience#" class="" style="width:34px;"></li>
</cfif>
<li class="clear"><label class="width-120">Description</label></li>
<li><textarea name="description" id="description" class="txtleft" style="width:240px; height:40px;">#description#</textarea></li>
</ul>
<cfif isDefined("print")>
<ul class="formfields txtleft mailingul">
<li><label class="bold">Mailing Address</label></li>
<li class="clear"><label class="width-100">Address</label></li>
<li><input type="text" id="address" name="address" class="width-240" value="#rc.clientinfo.mailing_address#" /></li>
<li class="clear"><label class="width-100">Address 2</label></li>
<li><input type="text" id="address2" name="address2" class="width-240" value="#rc.clientinfo.mailing_address2#" /></li>
<li class="clear"><label class="width-100">City, State, Zip</label></li>
<li><input type="text" name="city" class="txtdefault width-128" style="margin-right:2px;" value="#rc.clientinfo.mailing_city#"></li>
<li class="selectli" style="padding-right:2px;"><select name="state" id="state" class="selectbox2" style="width:55px;">
<option value="0">State</option>
<cfloop query="rc.states">
<option value="#rc.states.state_id#" style="font-style:normal;" <cfif rc.clientinfo.mailing_state eq rc.states.state_id>selected</cfif>>#rc.states.name#</option>
</cfloop></select></li>
<li><input type="text" name="zip" class="txtdefault width-45" value="#rc.clientinfo.mailing_zip#"></li>
</ul>
</cfif>

<ul class="formfields txtleft appul2<cfif isDefined('print')>print</cfif>">
<li><label class="bold">Club Information</label></li>
<li class="clear"><label class="width-100">Gross Receipts</label></li>
<li><input type="text" id="gross_receipts" name="gross_receipts" value="#gross_receipts#" class="width-100 dollarmasknd" /></li>
<li><label class="width-100" style="padding-left:30px">## Members</label></li>
<li><input type="text" id="number_members" name="number_members" value="#number_members#" class="width-100 numbermask" /></li>
<li class="clear"><label class="width-100">## Employees FT</label></li>
<li><input type="text" id="number_employees_ft" name="number_employees_ft" value="#number_employees_ft#" class="width-100 numbermask" /></li>
<li><label class="width-100 numbermask" style="padding-left:30px">## Employees PT</label></li>
<li><input type="text" id="number_employees_pt" name="number_employees_pt" value="#number_employees_pt#" class="width-100 numbermask" /></li>
<li class="clear"><label class="width-100">Club Hours</label></li>
<li><input type="text" id="club_hours" name="club_hours" value="#club_hours#"class="width-100" /></li>

<li style="padding-left:30px"><input type="checkbox" value="1"  name="key_club_24" id="key_club_24"<cfif key_club_24 eq 1>checked</cfif>/> </li>
<li><label>24 Hour Key Club</label></li>
</ul>
<ul class="formfields txtleft appul3<cfif isDefined('print')>print</cfif>">
<li><label class="bold">GL Limits</label></li>
<li class="clear"><label class="width-100">Requested Limits</label></li>
<li class="selectli"><select id="requested_limits_id" name="requested_limits_id" class="selectbox2" style="width:108px;">
<option value="0">Please Select</option>
<cfloop query="rc.requestedlimits">

		<option value="#requested_limits_id#" <cfif requested_limits_id eq #sel_requested_limits_id#> selected</cfif>>#requested_limit#</option>

</cfloop>
</select>
</li>
<li><label class="width-100" style="padding-left:30px">Other</label></li>
<li><input type="text" id="requested_limits_other" name="requested_limits_other" value="#requested_limits_other#" class="width-100" /></li>
<li class="clear"><label class="width-100">Additional Limits</label></li>
<li class="selectli"><select id="additional_limits_id" name="additional_limits_id" class="selectbox2" style="width:108px;">
<option value="0">Please Select</option>
<cfloop query="rc.additionallimits">

		<option value="#additional_limits_id#" <cfif additional_limits_id eq #sel_additional_limits_id#> selected</cfif>>#additional_limits#</option>

</cfloop>
</select></li>
<li><label class="width-100" style="padding-left:30px">Other</label></li>
<li><input type="text" id="additional_limits_other" name="additional_limits_other" value="#additional_limits_other#" class="width-100" /></li>
</ul>

<ul class="formfields txtleft appul4 clear">
<li><label class="bold">Amenities</label></li>
<li class="clear"><label class="width-100 bold">## Court(s)</label></li>
<li><input type="text" class="width-20 numbermask" name="court_total" id="court_total" value="#court_total#" /></li>
<li class="clear"><label class="width-100">Basketball Courts</label></li>
<li><input type="text" class="width-20 courts numbermask" name="court_basketball" id="court_basketball" value="#court_basketball#" /></li>
<li class="clear"><label class="width-100">Racquetball Courts</label></li>
<li><input type="text" class="width-20 courts numbermask" name="court_racquetball" id="court_racquetball" value="#court_racquetball#" /></li>
<li class="clear"><label class="width-100">Tennis Courts</label></li>
<li><input type="text" class="width-20 courts numbermask" name="court_tennis" id="court_tennis" value="#court_tennis#"/></li>
<li class="clear"><label class="bold">&nbsp;</label></li>
<li class="clear"><label class="width-100">Sauna</label></li>
<li><input type="text" class="width-20 numbermask" name="sauna" id="sauna" value="#sauna#"/></li>
<li class="clear"><label class="width-100">Steam Room</label></li>
<li><input type="text" class="width-20 numbermask" name="steam_room" id="steam_room" value="#steam_room#" /></li>
<li class="clear"><label class="width-100">Whirlpool/Hot Tub</label></li>
<li><input type="text" class="width-20 numbermask" name="whirlpool" id="whirlpool" value="#whirlpool#" /></li>
</ul>
<ul class="formfields txtleft appul5">
<li><label class="bold">&nbsp;</label></li>
<li class="clear"><label class="width-100 bold">## Pool(s)</label></li>
<li><input type="text" class="width-20 numbermask" name="pool_total" id="pool_total" value="#pool_total#"/></li>
<li class="clear"><label class="width-100">Indoor</label></li>
<li><input type="text" class="width-20 pools numbermask" name="pool_indoor" id="pool_indoor" value="#pool_indoor#" /></li>
<li class="clear"><label class="width-100">Outdoor</label></li>
<li><input type="text" class="width-20 pools numbermask" name="pool_outdoor" id="pool_outdoor" value="#pool_outdoor#" /></li>
<li class="clear"><label class="width-100 numbermask">Depth</label></li>
<li><input type="text" class="width-20" name="depth" id="depth" value="#depth#" /></li>
<li class="clear"><textarea name="pool_other" id="pool_other" class="txtdefault txtleft" style="width:128px; height:40px;">#pool_other#</textarea></li>
<li class="clear"><input type="checkbox" value="1"  name="diving_board" id="diving_board" value="1" <cfif diving_board eq 1>checked</cfif>/></li>
<li><label>Diving Board</label></li>
<li class="clear"><input type="checkbox" value="1"  name="slides" id="slides" <cfif slides eq 1>checked</cfif>/></li>
<li><label>Slides</label></li>
<li class="clear"><input type="checkbox" value="1"  name="lifeguards" id="lifeguards" <cfif lifeguards eq 1>checked</cfif>/></li>
<li><label>Lifeguards</label></li>
<li class="clear"><input type="checkbox" value="1"  name="swim_risk_signs" id="swim_risk_signs" <cfif swim_risk_signs eq 1>checked</cfif> /></li>
<li><label>Swim at Your Own<br />Risk Warning Signs</label></li>
</ul>
<ul class="formfields txtleft appul6">
<li><label class="bold">&nbsp;</label></li>
<li class="clear"><label class="width-100 bold">## Bed(s)</label></li>
<li><input type="text" class="width-20 numbermask" name="beds_total" id="beds_total" value="#beds_total#" /></li>
<li class="clear"><label class="width-100">Beauty Angels</label></li>
<li><input type="text" class="width-20 beds numbermask" name="beauty_angel" id="beauty_angel" value="#beauty_angel#" /></li>
<li class="clear"><label class="width-100">Tanning Beds</label></li>
<li><input type="text" class="width-20 beds numbermask" name="beds_tanning" id="beds_tanning" value="#beds_tanning#" /></li>
<li class="clear"><label class="width-100">Spray Tanning</label></li>
<li><input type="text" class="width-20 beds numbermask" name="beds_spray" id="beds_spray" value="#beds_spray#" /></li>
<li class="clear"><input type="checkbox" value="1"  name="tanning_goggles" id="tanning_goggles" <cfif tanning_goggles eq 1>checked</cfif>/></li>
<li><label>Tanning Goggles</label></li>
<li class="clear"><input type="checkbox" value="1"  name="ul_approved" id="ul_approved" <cfif ul_approved eq 1>checked</cfif>/></li>
<li><label>UL Approved Beds</label></li>
<li class="clear"><input type="checkbox" value="1"  name="front_desk_controls" id="front_desk_controls" <cfif front_desk_controls eq 1>checked</cfif> /></li>
<li><label>Front Desk Controls</label></li>
<li class="clear"><input type="checkbox" value="1"  name="tanning_waiver_signed" id="tanning_waiver_signed" <cfif tanning_waiver_signed eq 1>checked</cfif>/></li>
<li><label>Tanning Waiver Signed</label></li>
<li class="clear"><input type="checkbox" value="1"  name="uv_warnings" id="uv_warnings" <cfif uv_warnings eq 1>checked</cfif>/></li>
<li><label>UV Warnings Posted</label></li>
</ul>
<ul class="formfields txtleft appul7">
<li><label class="bold">&nbsp;</label></li>
<li class="clear"><input type="checkbox" value="1"  name="child_sitting" id="child_sitting" <cfif child_sitting eq 1>checked</cfif> /></li>
<li><label class="bold">Child Sitting</label></li>
<li class="clear"><label class="width-100">## Children</label></li>
<li><input type="text" class="width-20 numbermask" name="number_children" id="number_children" value="#number_children#"/></li>
<li class="clear"><label class="width-100">Max Age</label></li>
<li><input type="text" class="width-20 numbermask" name="max_age" id="max_age" value="#max_age#" /></li>
<li class="clear"><input type="checkbox" value="1"  name="ratio_less" id="ratio_less" <cfif ratio_less eq 1>checked</cfif>/></li>
<li><label>Ratio Less Than 10:1</label></li>
<li class="clear"><input type="checkbox" value="1"  name="sign_in_out" id="sign_in_out" <cfif sign_in_out eq 1>checked</cfif> /></li>
<li><label>Sign In/Out Procedures</label></li>
<li class="clear"><input type="checkbox" value="1"  name="outdoor_playground" id="outdoor_playground" <cfif outdoor_playground eq 1>checked</cfif>/></li>
<li><label>Outdoor Playground</label></li>
<li class="clear"><input type="checkbox" value="1"  name="play_apparatus" id="play_apparatus" <cfif play_apparatus eq 1>checked</cfif> /></li>
<li><label>Jungle Gym</label></li>
<li class="clear"><textarea name="play_desc" id="play_desc" class="txtdefault txtleft" style="width:128px; height:40px;">#play_desc#</textarea></li>
</ul>
<ul class="formfields txtleft appul8">
<li><label class="bold">&nbsp;</label></li>
<li class="clear"><label class="bold">Miscellaneous</label></li>
<li class="clear"><input type="checkbox" value="1"  name="silver_sneakers" id="silver_sneakers" <cfif silver_sneakers eq 1>checked</cfif>/></li>
<li><label>Silver Sneakers/Healthways</label></li>
<li class="clear"><input type="checkbox" value="1"  name="massage" id="massage" value="#massage#" <cfif massage eq 1>checked="checked"</cfif> /></li>
<li><label>Massage</label></li>
<li class="clear"><input type="radio" name="emp_cont" value="1" <cfif emp_cont is 1>checked</cfif> /></li>
<li><label class="radiohoriz">Employee</label></li>
<li><input type="radio" name="emp_cont" value="0" <cfif emp_cont is 0>checked</cfif> /></li>
<li><label class="radiohoriz">Contractor</label></li>
<li class="clear"><input type="checkbox" value="1"  name="personal_trainers" id="personal_trainers" <cfif personal_trainers eq 1>checked</cfif>/></li>
<li><label>Ind. Personal Trainers</label></li>
<li class="clear"><label class="width-100">## Trainers</label></li>
<li><input type="text" class="width-98 numbermask" name="number_trainers" id="number_trainers" value="#number_trainers#" /></li>
<li class="clear"><input type="checkbox" value="1"  name="leased_space" id="leased_space"<cfif leased_space eq 1>checked</cfif> /></li>
<li><label>Leased Space</label></li>
<li class="clear"><label class="width-100">Square Ft</label></li>
<li><input type="text" class="width-98 numbermask" name="leased_square_ft" id="leased_square_ft" value="#leased_square_ft#" /></li>
<li class="clear"><label class="width-100">Leased To</label></li>
<li><input type="text" class="width-98" name="leased_to" id="leased_to"  value="#leased_to#"/></li>
<li class="clear"><input type="checkbox" value="1"  name="club_named_ai" id="club_named_ai" <cfif club_named_ai eq 1>checked</cfif> /></li>
<li><label>Club Named AI</label></li>
<li class="clear"><input type="checkbox" value="1"  name="employee_benefits" id="employee_benefits" <cfif employee_benefits eq 1>checked</cfif>/></li>
<li><label>Employee Benefits Liability</label></li>
<li class="clear"><label class="width-100">## Emp Rec Benefits</label></li>
<li><select name="employee_rec_benefits_id" id="employee_rec_benefits_id" class="selectbox2" style="width:106px;">
<option value="0">Please Select</option>
	<cfloop query="rc.employeerec"><cfoutput><option value="#employee_rec_benefits_id#" <cfif employee_rec_benefits_id eq sel_employee_rec_benefits_id>selected</cfif>>#employee_rec_benefits#</option></cfoutput></cfloop>
</select></li></ul>
<ul class="formfields txtleft appul9">
<li><label class="bold">Other Exposures</label></li>
 <li class="clear"><input type="checkbox" value="1"  name="martial_arts" id="martial_arts" <cfif martial_arts eq 1>checked</cfif> /></li>
<li><label>Martial Arts</label></li>
<li class="clear"><input type="checkbox" value="1"  name="climbing_wall" id="climbing_wall" <cfif climbing_wall eq 1>checked</cfif>/></li>
<li><label>Climbing Wall</label></li>
<li class="clear"><input type="checkbox" value="1"  name="team_sports" id="team_sports" <cfif team_sports eq 1>checked</cfif> /></li>
<li><label>Team Sports</label></li>
<li class="clear"><input type="checkbox" value="1"  name="childrens_programming" id="childrens_programming" value="1" <cfif childrens_programming eq 1>checked</cfif> /></li>
<li><label>Children's Programming</label></li>
<li class="clear"><input type="checkbox" value="1"  name="spa" id="spa" <cfif spa eq 1>checked</cfif>/></li>
<li><label>Spa</label></li>
<li class="clear"><input type="checkbox" value="1"  name="physical_therapy" id="physical_therapy" <cfif physical_therapy eq 1>checked</cfif> /></li>
<li><label>Physical Therapy</label></li>
<li class="clear"><input type="checkbox" value="1"  name="boxing" id="boxing" <cfif boxing eq 1>checked</cfif>/></li>
<li><label>Boxing</label></li>
</ul>
<ul class="formfields txtleft appul9half">
<li><label class="bold">&nbsp;</label></li>
<li class="clear"><input type="checkbox" value="1"  name="off_premises" id="off_premises" <cfif off_premises eq 1>checked</cfif> /></li>

<li><label>Off Premises</label></li>
<li class="clear"><input type="checkbox" value="1"  name="cooking_food" id="cooking_food" <cfif cooking_food eq 1>checked</cfif> /></li>
<li><label>Cooking/Food/Liquor</label></li>
<li class="clear"><input type="checkbox" value="1"  name="transportation" id="transportation" <cfif transportation eq 1>checked</cfif> /></li>
<li><label>Transportation</label></li>
<li class="clear"><input type="checkbox" value="1"  name="events_sponsored" id="events_sponsored" <cfif events_sponsored eq 1>checked</cfif> /></li>
<li><label>Events Sponsored</label></li>
<li class="clear"><input type="checkbox" value="1"  name="sports_performance" id="sports_performance"  <cfif sports_performance eq 1>checked</cfif>/></li>
<li><label>Sports Performance</label></li>
<li class="clear"><input type="checkbox" value="1"  name="crossfit" id="crossfit" <cfif crossfit eq 1>checked</cfif>/></li>
<li><label>Crossfit</label></li>
</ul>
<ul class="formfields txtleft appul10" style="width:541px !important; overflow:hidden !important; height:175px !important">
<li class="clear"><label class="bold">Notes</label></li>
<li class="clear"><textarea name="notes" id="notes" class="txtleft" style="width:520px; height:135px;">#notes#</textarea></li>
</ul>
<cfif isDefined('print')>
<div class="divFooter" style="clear:both;">
<cfset pagenum = 1>

</div>
<div class="pagebreak"></div>
  <div id="appheader" class="clear">
	
    <img class="applogo" src="/images/Fitness-Insurance-logo-long.gif" />
    <h1 style="z-index:1000;">Insurance Application</h1>
  </div>
</cfif>

<ul class="formfields txtleft appul11">
<li><label class="bold">Underwriting Information</label></li>
<li class="clear"><input type="checkbox" value="1"  name="aed" id="aed" <cfif aed eq 1>checked</cfif> /></li>
<li><label>AED/Defibrillator (trained staff on premises at all times)</label></li>
<li class="clear"><input type="checkbox" value="1"  name="cameras" id="cameras" <cfif cameras eq 1>checked</cfif>/></li>
<li><label>Cameras w/Digital Recording System (## of hrs)</label></li>
<li class="clear"><input type="checkbox" value="1"  name="aerobics" id="aerobics" <cfif aerobics eq 1>checked</cfif> /></li>
<li><label class="width-163">Aerobics instructors certified</label></li>
<li><input type="checkbox" value="1"  name="aerobic_certs" id="aerobics_certs" <cfif aerobic_certs eq 1>checked</cfif> /></li>
<li><label>Certs on file</label></li>
<li class="clear"><input type="checkbox" value="1"  name="pt" id="pt" <cfif pt eq 1>checked</cfif>/></li>
<li><label class="width-163">Personal Trainers certified</label></li>
<li><input type="checkbox" value="1"  name="pt_certs" id="pt_certs" <cfif pt_certs eq 1>checked</cfif>/></li>
<li><label>Certs on file</label></li>
<li class="clear"><input type="checkbox" value="1"  name="company_vehicles" id="company_vehicles" <cfif company_vehicles eq 1>checked</cfif>/></li>
<li><label>Company Owned Vehicles</label></li>
<li class="clear"><input type="checkbox" value="1"  name="coverage_declined" id="coverage_declined" <cfif coverage_declined eq 1>checked</cfif> /></li>
<li><label>Coverage Declined, Canceled or Non-Renewed</label></li>
<li class="clear"><label style="padding-left:25px;">If yes, explain</label></li>
<li><input type="text" name="declined_reason" id="declined_reason" class="width-240" value="#declined_reason#" /></li>
<li class="clear"><input type="checkbox" value="1"  name="cpr" id="cpr" <cfif cpr eq 1>checked</cfif>/></li>
<li><label class="width-163">Staff trained in CPR</label></li>
<li><input type="checkbox" value="1"  name="cpr_certs" id="cpr_certs"  <cfif cpr_certs eq 1>checked</cfif>/></li>
<li><label>Certs on file</label></li>
<li class="clear"><input type="checkbox" value="1"  name="losses" id="losses" <cfif losses eq 1>checked</cfif>/></li>
<li><label>Losses relating to sexual abuse, molestation, discrimination, negligent hiring?</label></li>
<li class="clear"><label style="padding-left:25px;">If yes, explain</label></li>
<li><input type="text" name="losses_reason" id="losses_reason" class="width-240"  value="#losses_reason#"/></li>
<li class="clear"><input type="checkbox" value="1"  name="sex_abuse_policy" id="sex_abuse_policy" <cfif sex_abuse_policy eq 1>checked</cfif> /></li>
<li><label>Do you have a written "Sexual Abuse Prevention" Policy?</label></li>
<li class="clear"><input type="checkbox" value="1"  name="leased_employees" id="leased_employees" <cfif leased_employees eq 1>checked</cfif>/></li>
<li><label>Leased employees to or from other employers?</label></li>
<li class="clear"><input type="checkbox" value="1"  name="contractor_certs" id="contractor_certs" <cfif contractor_certs eq 1>checked</cfif>/></li>
<li><label>If Contractors Used, are certs obtained?</label></li>
<li class="clear"><label style="padding-left:25px;">Please indicate the following Hiring Practices you have in place</label></li>
<li class="clear"><input type="checkbox" value="1"  name="signed_employment" id="signed_employment" <cfif signed_employment eq 1>checked</cfif>/></li>
<li><label>Signed employment applications</label></li>
<li style="padding-left:10px;"><input type="checkbox" value="1"  name="references_checked" id="references_checked" <cfif references_checked eq 1>checked</cfif> /></li>
<li><label>Personal References Checked</label></li>
<li style="padding-left:10px;"><input type="checkbox" value="1"  name="background_check" id="background_check" <cfif background_check eq 1>checked</cfif>/></li>
<li><label>Criminal background checks conducted</label></li>
</ul>

<div class="grayborder clear" style="border-top:none;">
<ul class="formfields txtleft clear appul12">
<li><label class="bold">Property Information</label></li>
<li class="clear"><input type="radio" name="rentown" value="0" <cfif rentown eq 0>checked</cfif> /></li>
<li><label class="rent">Rent</label></li>
<li style="padding-left:10px;"><input type="radio" name="rentown" value="1" <cfif rentown eq 1>checked</cfif>/></li>
<li><label class="radiohoriz">Own</label></li>
<li class="clear"><label class="width-120">Square Feet</label></li>
<li><input type="text" id="square_ft" name="square_ft" class="width-80 numbermask" value="#square_ft#" /></li>
<li class="clear"><label class="width-120">Number of Stories</label></li>
<li><input type="text" id="stories" name="stories" class="width-80 numbermask" value="#stories#" /></li>
<li class="clear"><label class="width-120">Year Built</label></li>
<li><input type="text" id="year_built" name="year_built" class="width-80 numbermask" value="#year_built#"/></li>
<li class="clear"><label class="bold">Year of Updates</label></li>
<li class="clear"><label class="width-120">Electrical</label></li>
<li><input type="text" id="update_electrical" name="update_electrical" class="width-80 numbermask" value="#update_electrical#" /></li>
<li class="clear"><label class="width-120">Plumbing</label></li>
<li><input type="text" id="update_plumbing" name="update_plumbing" class="width-80 numbermask" value="#update_plumbing#" /></li>
<li class="clear"><label class="width-120">Roofing</label></li>
<li><input type="text" id="update_roofing" name="update_roofing" class="width-80 numbermask" value="#update_roofing#" /></li>
<li class="clear"><label class="bold">Occupants</label></li>
<li class="clear"><label class="width-120">Right</label></li>
<li><input type="text" id="occupants_right" name="occupants_right" class="width-80" value="#occupants_right#" /></li>
<li class="clear"><label class="width-120">Left</label></li>
<li><input type="text" id="occupants_left" name="occupants_left" class="width-80" value="#occupants_left#"/></li>
<li class="clear"><label class="width-120">Rear</label></li>
<li><input type="text" id="occupants_rear" name="occupants_rear" class="width-80" value="#occupants_rear#"/></li>
<li class="clear"><input type="checkbox" value="1"  name="burglar_alarm" id="burglar_alarm" <cfif burglar_alarm eq 1>checked</cfif>/></li>
<li><label>Central Burglar Alarm</label></li>
<li class="clear"><input type="checkbox" value="1"  name="fire_alarm" id="fire_alarm" <cfif fire_alarm eq 1>checked</cfif>/></li>
<li><label>Central Fire Alarm</label></li>
<li class="clear"><input type="checkbox" value="1"  name="sprinklered" id="sprinklered" <cfif sprinklered eq 1>checked</cfif> /></li>
<li><label>Sprinklered</label></li>
<li class="clear"><input type="checkbox" value="1"  name="smoke_detectors" id="smoke_detectors" <cfif smoke_detectors eq 1>checked</cfif>/></li>
<li><label>Smoke Detectors</label></li>
<li class="clear"><label class="width-120">## of Miles from Coast</label></li>
<li><input type="text" id="miles_from_coast" name="miles_from_coast" class="width-80 numbermask" value="#miles_from_coast#"/></li>
</ul>

<ul class="formfields txtleft appul13">
<li><label>&nbsp;</label></li>
<li class="clear"><label class="bold width-90">Club Located In</label></li>
<li><select name="club_located_id" id="club_located_id" class="selectbox2" style="width:155px;">
<option value="0">Please Select</option>
	<cfloop query="rc.clublocated">
	<option value="#club_located_id#" <cfif club_located_id eq sel_club_located_id>selected</cfif>>#club_located#</option>
	</cfloop>
</select></li>
<li class="clear"><label class="width-90">Other</label></li>
<li><input type="text" name="club_located_other" id="club_located_other" value="#club_located_other#"class="width-147" /></li>
<li class="clear"><label>&nbsp;</label></li>
<li class="clear"><label class="bold width-90">Construction</label></li>
<li><select name="construction_type_id" id="construction_type_id" class="selectbox2" style="width:155px;">
<option value="0">Please Select</option>
	<cfloop query="rc.constructiontypes">
<option value="#construction_type_id#" <cfif construction_type_id eq sel_construction_type_id>selected</cfif>>#construction_type#</option>
</cfloop>
</select></li>
<li class="clear"><label class="width-90">Other</label></li>
<li><input type="text" name="construction_other" id="construction_other" value="#construction_other#" class="width-147" /></li>
<li class="clear"><label>&nbsp;</label></li>
<li class="clear"><label class="bold width-90">Roof</label></li>
<li><select name="roof_type_id" id="roof_type_id" class="selectbox2" style="width:155px;">
<option value="0">Please Select</option>
	<cfloop query="rc.rooftypes">
<option value="#roof_type_id#" <cfif roof_type_id eq sel_roof_type_id>selected</cfif>>#roof_type#</option>
</cfloop>
</select></li>
<li class="clear"><label class="width-90">Other</label></li>
<li><input type="text" name="roof_other" id="roof_other" class="width-147" value="#roof_other#" /></li>
<li class="clear"><label>&nbsp;</label></li>
<li class="clear"><label class="bold">Other Exposures</label></li>
<li class="clear"><input type="checkbox" value="1"  name="air_structure" id="air_structure" <cfif air_structure eq 1>checked</cfif> /></li>
<li><label>Air Structure</label></li>
</ul>
<ul class="formfields txtleft appul14">
<li><label>&nbsp;</label></li>
<li class="clear"><label class="bold">Property Limits Requested</label></li>
<li class="clear"><input type="checkbox" value="1"  name="building_coverage" id="building_coverage" <cfif building_coverage eq 1>checked</cfif> /></li>
<li><label class="width-218">Building Coverage</label></li>
<li><input type="text" id="building_coverage_amount" name="building_coverage_amount" class="width-80 dollarmasknd" value="#building_coverage_amount#" /></li>
<li class="clear"><input type="checkbox" value="1"  name="business_prop" id="business_prop" <cfif business_prop eq 1>checked</cfif> /></li>
<li><label class="width-218">Business Personal Property</label></li>
<li><input type="text" id="business_prop_amount" name="business_prop_amount" class="width-80 dollarmasknd" value="#business_prop_amount#"/></li>
<li class="clear"><input type="checkbox" value="1"  name="tenant_improvements" id="tenant_improvements" <cfif tenant_improvements eq 1>checked</cfif>/></li>
<li><label class="width-218">Tenant Finish/Improvements</label></li>
<li><input type="text" id="tenant_improvements_amount" name="tenant_improvements_amount" class="width-80 dollarmasknd" value="#tenant_improvements_amount#"/></li>
<li class="clear"><input type="checkbox" value="1"  name="business_income" id="business_income"<cfif business_income eq 1>checked</cfif> /></li>
<li><label class="width-218">Business Income</label></li>
<li><input type="text" id="business_income_amount" name="business_income_amount" class="width-80 dollarmasknd" value="#business_income_amount#"/></li>
<li class="clear"><input type="checkbox" value="1"  name="edp" id="edp" <cfif edp eq 1>checked</cfif> /></li>
<li><label class="width-218">EDP Equip</label></li>

<li><input type="text" id="edp_amount" name="edp_amount" class="width-80 dollarmasknd" value="#edp_amount#"/></li>
<li class="clear"><input type="checkbox" value="1"  name="employee_dishonesty" id="employee_dishonesty" <cfif employee_dishonesty eq 1>checked</cfif> /></li>
<li><label class="width-218">Employee Dishonesty</label></li>
<li>
<select name="employee_dishonesty_id" id="employee_dishonesty_id" class="selectbox2" style="width:88px;">
<option value="0">Please Select</option>
    <cfloop query="rc.employee_dishonesty">
<option value="#employee_dishonesty_id#" <cfif employee_dishonesty_id eq sel_employee_dishonesty_id>selected</cfif>>#employee_dishonesty_amount#</option>
</cfloop>
</select></li>

<li class="clear"><input type="checkbox" value="1"  name="hvac" id="hvac" <cfif hvac eq 1>checked</cfif> /></li>
<li><label class="width-218">HVAC</label></li>
<li><input type="text" id="hvac_amount" name="hvac_amount" class="width-80 dollarmasknd" value="#hvac_amount#"/></li>
<li class="clear"><input type="checkbox" value="1"  name="signs_25" id="signs_25" <cfif signs_25 eq 1>checked</cfif>/></li>
<li><label class="width-218">Signs over $25,000</label></li>
<li><input type="text" id="signs_25_amount" name="signs_25_amount" class="width-80 dollarmasknd" value="#signs_25_amount#" /></li>
<li class="clear"><input type="checkbox" value="1"  name="cyber_liability" id="cyber_liability" <cfif cyber_liability eq 1>checked</cfif> /></li>
<li><label class="width-218">Data Breach/Cyber Liability</label></li>
<li><select name="cyber_liability_amount_id" id="cyber_liability_amount_id" class="selectbox2" style="width:88px;">
<option value="0">Please Select</option>
	<cfloop query="rc.cyberliability">
<option value="#cyber_liability_amount_id#" <cfif cyber_liability_amount_Id eq sel_cyber_liability_amount_Id> selected</cfif>>#cyber_liability_amount#</option>
</cfloop>
</select></li>
<li class="clear"><label class="bold">Excess Liability/Umbrella</label></li>
<li class="clear"><input type="checkbox" value="1"  name="additional_limit" id="additional_limit" <cfif additional_limit eq 1>checked</cfif>/></li>
<li><label class="width-218">Additional Limit</label></li>
<li><input type="text" id="additional_limit_amount" name="additional_limit_amount" class="width-80 dollarmasknd" value="#additional_limit_amount#"/></li>
<li class="clear"><label class="width-218" style="padding-left:25px;">Reason</label></li>
<li><input type="text" id="additional_limit_reason" name="additional_limit_reason" class="width-80"  value="#additional_limit_reason#"/></li>
</ul>
<div class="clear"></div>
</div>
<ul class="formfields txtleft appul15" id="wc">
<li><label class="bold" style="width:273px;">Workers Compensation</label></li>
<li><label style="margin-right:2px;">Employee Annual Payroll</label></li>
<li><input type="text" name="eap" class="width-80 dollarmasknd" value="#eap#"/></li>
<li class="clear"><label class="width-134 bold" style="margin-right:2px;">Name</label></li>
<li><label class="width-134 bold" style="margin-right:2px;">Title</label></li>
<li><label class="width-40 bold" style="margin-right:2px; padding-left:0;">%Owner</label></li>
<li><label class="width-60 bold" style="margin-right:2px;">Salary</label></li>
<li><label class="bold">Include</label></li>
<li><label class="bold">Exclude</label></li>
<cfif structkeyexists(rc,"wc") and rc.wc.recordcount gt 0>
<cfloop query="rc.wc">
<li class="clear"><input type="hidden" name="workcompid" value="#workcompid#"><input name="wc_name" value="#name#"id="wc_name1" type="text" class="width-134" style="margin-right:2px;" /></li>
<li><input name="title" value="#title#" id="wc_title1" type="text" class="width-134" style="margin-right:2px;" /></li>
<li><input name="percentown" value="#percentown#" id="wc_percent_owner1" type="text" class="width-40" style="margin-right:2px;" /></li>
<li><input name="salary" value="$#numberformat(salary)#" id="wc_salary1" type="text" class="width-65" style="margin-right:2px;" /></li>
<li style="padding-left:10px;"><input type="checkbox" value="1" <cfif include eq 1>checked</cfif>  name="include" id="wc_include1" /></li>
<li style="padding-left:25px;"><input type="checkbox" value="1" <cfif exclude eq 1>checked</cfif>  name="exclude" id="wc_exclude1" /></li>
</cfloop>
<cfelse>
<cfloop from='1' to="2" index="i">
<li class="clear"><input type="hidden" name="workcompid" value=""><input name="wc_name" id="wc_name1" type="text" class="width-134" style="margin-right:2px;" /></li>
<li><input name="title" id="wc_title1" type="text" class="width-134" style="margin-right:2px;" /></li>
<li><input name="percentown" id="wc_percent_owner1" type="text" class="width-40" style="margin-right:2px;" /></li>
<li><input name="salary" id="wc_salary1" type="text" class="width-65" style="margin-right:2px;" /></li>
<li style="padding-left:10px;"><input type="checkbox" value="1"  name="include" id="wc_include1" /></li>
<li style="padding-left:25px;"><input type="checkbox" value="1"  name="exclude" id="wc_exclude1" /></li>
</cfloop>
</cfif>
<li class="clear" id="addWC">
 <label style="padding-left:0;"><img id="addEmp" src="/images/plus.png" class="plus"></label>
</li>
</ul>
<ul class="formfields txtleft appul16">
<li><label class="bold">Employment Practices Liabilty (EPL)</label></li>
<li class="clear"><label class="width-198">Requested Limits</label></li>
<li><select name="epl_limits_id" id="epl_limits_id" class="selectbox2" style="width:133px;">
<option value="0">Please Select</option>
	<cfloop query="rc.epl">
	<option value="#epl_limits_id#" <cfif epl_limits_id eq sel_epl_limits_id>selected</cfif>>#epl_limit#</option>
	</cfloop>
</select></li>
<li class="clear"><input type="checkbox" value="1"  name="include_do" id="include_do" <cfif include_do eq 1>checked</cfif> /></li>
<li><label>Include D&amp;O</label></li>
</ul>
<div class="clear" style="padding:10px 0;">
<cfif viewhistory neq 1>
<button class="buttons" id="save">SAVE</button>
<button class="buttons" id="savehistory">SAVE HISTORY</button>
</cfif>
<!---<cfif isDefined("rc.rating")>
<button class="buttons" id="ratebutton">RATE</button>
</cfif>--->
<button class="buttons" id="printapp">PRINT</button>
<!---
<button class="buttons">EMAIL</button>
--->
<button class="buttons" id="ViewNI">VIEW NAMED INSUREDS</button>
<button class="buttons" id="closebutton">CLOSE</button>
</cfoutput>
</form>
<cfif isDefined('print')>
<cfset pagenum = 2>
<div class="divFooter">
<p style="text-align:center; font-family:Arial, Helvetica, sans-serif; font-size:14px; line-height:18px;">2170 S. Parker Rd, Suite 251<span style="color:white" class="footerspacer">W</span>|<span style="color:white" class="footerspacer">W</span>Aurora, CO  80231<span style="color:white" class="footerspacer">W</span>|<span style="color:white" class="footerspacer">W</span>800.881.7130<span style="color:white" class="footerspacer">W</span>|<span style="color:white" class="footerspacer">W</span>Fax 720.279.8321<span style="color:white" class="footerspacer">W</span>|<span style="color:white" class="footerspacer">W</span>www.fitnessinsurance.com<cfoutput><br /><span style="font-size:xx-small; font-style:italic;">Doing Business As Fitness Insurance Agency in MI, TX, NC, NY, and CA. CA License Number 0G00756</span><br /><span style="color:white" class="footerspacer">WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW</span> #dateFormat(now(),"mm/dd/yyyy")#</cfoutput></p>
</div>
</cfif>
</div>