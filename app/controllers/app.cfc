
<cfcomponent name="app" output="false">
	<cffunction name="init" output="false">
		<cfargument name="fw">
		<cfset variables.fw = arguments.fw> 
		<!--- Set up the gateway to the model.component to make it available to all functions in the controller --->
		<cfset mainGW = createObject('component','app.model.main').init()>
		<cfset appGW = createObject('component','app.model.app').init()>
		<cfset JSON = createObject('component','app.model.services.json').init() />
	</cffunction>
	<cffunction name="default" access="public">
		<cfargument name="rc" type="any">
        <cfset rc.clientinfo = appGW.getClient(rc.client_id)>
		<cfset rc.states = mainGW.getStates() />
		<cfset rc.AdditionalLimits = appGW.getAdditionalLimits() />
		<cfset rc.ClubLocated = appGW.getClubLocated()/>
		<cfset rc.ConstructionTypes = appGW.getConstructionTypes() />
		<cfset rc.Cyberliability = appGW.getCyberliability() />
        <cfset rc.employee_dishonesty = appGW.getEmployeeDishonesty() />
		<cfset rc.edp = appGW.getedp() />
		<cfset rc.epl = appGW.getepl() />
		<cfset rc.employeerec = appGW.getemployeerec() />
		<cfset rc.requestedlimits = appGW.getrequestedlimits() />
		<cfset rc.rooftypes = appGW.getrooftypes() />
        <cfset rc.contacts = mainGW.getClientContacts(rc.client_id)>
        <cfset rc.title = "Application - New">
        <cfset rc.newLocNum = appGW.getLocNum(rc.client_id)>
		<cfif structkeyexists(rc,"application_id")>
			<cfset rc.app = appGW.getApplication(application_id = rc.application_id)>
			<cfset rc.wc = appGW.getWc(application_id = rc.application_id)>
            <cfset rc.rating = mainGW.getLocationRating(rc.app.location_id)>
            <cfset rc.title = "Application - #rc.app.named_insured#">
		</cfif>
	</cffunction>
	<cffunction name="getLocationsGrid" access="public">
		<cfargument name="rc" type="any">
		<cfset locs = appGW.getLocations(client_id=rc.client_id)>
	</cffunction>
	<cffunction name="niList" access="public">
		<cfargument name="rc" type="any">
        <cfset rc.client = mainGW.getclient(client_id=rc.client_id)>
		<cfset rc.ni = mainGW.getNI(client_id=rc.client_id)>
	</cffunction>    
<!---
	<cffunction name="addEditApp">
		<cfargument name="rc" type="any">
		<cfparam name="rc.location_id" default="0">
		<cfparam name="rc.beauty_angel" default="0">
		<cfparam name="rc.key_club_24" default="0">
		<cfparam name="rc.diving_board" default="0">
		<cfparam name="rc.slides" default="0">
		<cfparam name="rc.lifeguards" default="0">
		<cfparam name="rc.swim_risk_signs" default="0">
		<cfparam name="rc.tanning_goggles" default="0">
		<cfparam name="rc.ul_approved" default="0">
		<cfparam name="rc.front_desk_controls" default="0">
		<cfparam name="rc.tanning_waiver_signed" default="0">
		<cfparam name="rc.uv_warnings" default="0">
		<cfparam name="rc.child_sitting" default="0">
		<cfparam name="rc.ratio_less" default="0">
		<cfparam name="rc.sign_in_out" default="0">
		<cfparam name="rc.outdoor_playground" default="0">
		<cfparam name="rc.play_apparatus" default="0">
		<cfparam name="rc.silver_sneakers" default="0">
		<cfparam name="rc.massage" default="0">
		<cfparam name="rc.personal_trainers" default="0">
		<cfparam name="rc.leased_space" default="0">
		<cfparam name="rc.club_named_ai" default="0">
		<cfparam name="rc.employee_benefits" default="0">
		<cfparam name="rc.martial_arts" default="0">
		<cfparam name="rc.climbing_wall" default="0">
		<cfparam name="rc.team_sports" default="0">
		<cfparam name="rc.childrens_programming" default="0">
		<cfparam name="rc.spa" default="0">
		<cfparam name="rc.physical_therapy" default="0">
		<cfparam name="rc.boxing" default="0">
		<cfparam name="rc.off_premises" default="0">
		<cfparam name="rc.cooking_food" default="0">
		<cfparam name="rc.transportation" default="0">
		<cfparam name="rc.events_sponsored" default="0">
		<cfparam name="rc.sports_performance" default="0">
		<cfparam name="rc.crossfit" default="0">
		<cfparam name="rc.aed" default="0">
		<cfparam name="rc.cameras" default="0">
		<cfparam name="rc.aerobics" default="0">
		<cfparam name="rc.aerobic_certs" default="0">
		<cfparam name="rc.pt" default="0">
		<cfparam name="rc.pt_certs" default="0">
		<cfparam name="rc.company_vehicles" default="0">
		<cfparam name="rc.coverage_declined" default="0">
		<cfparam name="rc.cpr" default="0">
		<cfparam name="rc.cpr_certs" default="0">
		<cfparam name="rc.losses" default="0">
		<cfparam name="rc.sex_abuse_policy" default="0">
		<cfparam name="rc.leased_employees" default="0">
		<cfparam name="rc.contractor_certs" default="0">
		<cfparam name="rc.signed_employment" default="0">
		<cfparam name="rc.references_checked" default="0">
		<cfparam name="rc.background_check" default="0">
		<cfparam name="rc.burglar_alarm" default="0">
		<cfparam name="rc.fire_alarm" default="0">
		<cfparam name="rc.sprinklered" default="0">
		<cfparam name="rc.smoke_detectors" default="0">
		<cfparam name="rc.air_structure" default="0">
		<cfparam name="rc.building_coverage" default="0">
		<cfparam name="rc.business_prop" default="0">
		<cfparam name="rc.tenant_improvements" default="0">
		<cfparam name="rc.business_income" default="0">
		<cfparam name="rc.edp" default="0">
        <cfparam name="rc.edp_amount" default="0">
		<cfparam name="rc.employee_dishonesty" default="0">
        <cfparam name="rc.employee_dishonesty_id" default="0">
		<cfparam name="rc.hvac" default="0">
		<cfparam name="rc.signs_25" default="0">
		<cfparam name="rc.cyber_liability" default="0">
		<cfparam name="rc.additional_limit" default="0">
        <cfparam name="rc.additional_limits_id" default="0">
        <cfparam name="rc.employee_rec_benefits_id" default="0">
		<cfparam name="rc.include_do" default="0">
		<cfparam name="rc.exclude" default="0">
        <cfparam name="rc.emp_cont" default="">
        <cfparam name="rc.rentown" default="">
		<cfset loc = appGW.addLocation(client_id=rc.client_id
			,location_id=rc.location_id
			,named_insured=rc.named_insured
			,dba=rc.dba
			,address=rc.address
			,address2=rc.address2
			,city=rc.city
			,state=rc.state
			,zip=rc.zip
			,location_number=rc.location_number
			,fein=rc.fein
			,year_business_started=rc.year_business_started
			,description=rc.description)>
		<cfset app = appGW.addApplication(application_id=rc.application_id,
				client_id=rc.client_id,
				location_id=loc,
				gross_receipts=ReReplace(rc.gross_receipts, "[^\d.]", "","ALL"),
				number_members=rc.number_members, 
				number_employees_ft=rc.number_employees_ft,
				club_hours=rc.club_hours,
				number_employees_pt=rc.number_employees_pt,
				key_club_24=rc.key_club_24,
				requested_limits_id=rc.requested_limits_id,
				requested_limits_other=rc.requested_limits_other,
				additional_limits_id=rc.additional_limits_id,
				additional_limits_other=rc.additional_limits_other,
				court_total=rc.court_total,
				court_basketball=rc.court_basketball,
				court_racquetball=rc.court_racquetball,
				court_tennis=rc.court_tennis,
				sauna=rc.sauna,
				steam_room=rc.steam_room,
				whirlpool=rc.whirlpool,
				pool_total=rc.pool_total,
				pool_indoor=rc.pool_indoor,
				pool_outdoor=rc.pool_outdoor,
				depth=rc.depth,
				pool_other=rc.pool_other,
				diving_board=rc.diving_board,
				slides=rc.slides,
				lifeguards=rc.lifeguards,
				swim_risk_signs=rc.swim_risk_signs,
				beds_total=rc.beds_total,
				beauty_angel=rc.beauty_angel,
				beds_tanning=rc.beds_tanning,
				beds_spray=rc.beds_spray,
				tanning_goggles=rc.tanning_goggles,
				ul_approved=rc.ul_approved,
				front_desk_controls=rc.front_desk_controls,
				tanning_waiver_signed=rc.tanning_waiver_signed,
				uv_warnings=rc.uv_warnings,
				child_sitting=rc.child_sitting,
				number_children=rc.number_children,
				max_age=rc.max_age,
				ratio_less=rc.ratio_less,
				sign_in_out=rc.sign_in_out,
				outdoor_playground=rc.outdoor_playground,
				play_apparatus=rc.play_apparatus,
				play_desc=rc.play_desc,
				silver_sneakers=rc.silver_sneakers,
				massage=rc.massage,
				emp_cont=rc.emp_cont,
				personal_trainers=rc.personal_trainers,
				number_trainers=rc.number_trainers,
				leased_space=rc.leased_space,
				leased_square_ft=rc.leased_square_ft,
				leased_to=rc.leased_to,
				club_named_ai=rc.club_named_ai,
				employee_benefits=rc.employee_benefits,
				employee_rec_benefits_id=rc.employee_rec_benefits_id,
				martial_arts=rc.martial_arts,
				climbing_wall=rc.climbing_wall,
				team_sports=rc.team_sports,
				childrens_programming=rc.childrens_programming,
				spa=rc.spa,
				physical_therapy=rc.physical_therapy,
				boxing=rc.boxing,
				off_premises=rc.off_premises,
				cooking_food=rc.cooking_food,
				transportation=rc.transportation,
				events_sponsored=rc.events_sponsored,
				sports_performance=rc.sports_performance,
				crossfit=rc.crossfit,
				notes=rc.notes,
				aed=rc.aed,
				cameras=rc.cameras,
				aerobics=rc.aerobics,
				aerobic_certs=rc.aerobic_certs,
				pt=rc.pt,
				pt_certs=rc.pt_certs,
				company_vehicles=rc.company_vehicles,
				coverage_declined=rc.coverage_declined,
				declined_reason=rc.declined_reason,
				cpr=rc.cpr,
				cpr_certs=rc.cpr_certs,
				losses=rc.losses,
				losses_reason=rc.losses_reason,
				sex_abuse_policy=rc.sex_abuse_policy,
				leased_employees=rc.leased_employees,
				contractor_certs=rc.contractor_certs,
				signed_employment=rc.signed_employment,
				references_checked=rc.references_checked,
				background_check=rc.background_check,
				rentown=rc.rentown,
				square_ft=rc.square_ft,
				stories=rc.stories,
				year_built=rc.year_built,
				update_electrical=rc.update_electrical,
				update_plumbing=rc.update_plumbing,
				update_roofing=rc.update_roofing,
				occupants_right=rc.occupants_right,
				occupants_left=rc.occupants_left,
				occupants_rear=rc.occupants_rear,
				burglar_alarm=rc.burglar_alarm,
				fire_alarm=rc.fire_alarm,
				sprinklered=rc.sprinklered,
				smoke_detectors=rc.smoke_detectors,
				miles_from_coast=rc.miles_from_coast,
				club_located_id=rc.club_located_id,
				club_located_other=rc.club_located_other,
				construction_type_id=rc.construction_type_id,
				construction_other=rc.construction_other,
				roof_type_id=rc.roof_type_id,
				roof_other=rc.roof_other,
				air_structure=rc.air_structure,
				building_coverage=rc.building_coverage,
				building_coverage_amount=ReReplace(rc.building_coverage_amount, "[^\d.]", "","ALL"),
				business_prop=rc.business_prop,
				business_prop_amount=ReReplace(rc.business_prop_amount, "[^\d.]", "","ALL"),
				tenant_improvements=rc.tenant_improvements,
				tenant_improvements_amount=ReReplace(rc.tenant_improvements_amount, "[^\d.]", "","ALL"),
				business_income=rc.business_income,
				business_income_amount=ReReplace(rc.business_income_amount, "[^\d.]", "","ALL"),
				edp=rc.edp,
				edp_amount=rc.edp_amount,
				employee_dishonesty=rc.employee_dishonesty,
				employee_dishonesty_amount_id=rc.employee_dishonesty_id, 
				hvac=rc.hvac,
				hvac_amount=ReReplace(rc.hvac_amount, "[^\d.]", "","ALL"),
				signs_25=rc.signs_25,
				signs_25_amount=ReReplace(rc.signs_25_amount, "[^\d.]", "","ALL"),
				cyber_liability=rc.cyber_liability,
				cyber_liability_amount_id=rc.cyber_liability_amount_id,
				additional_limit=rc.additional_limit,
				additional_limit_amount=ReReplace(rc.additional_limit_amount, "[^\d.]", "","ALL"),
				additional_limit_reason=rc.additional_limit_reason,
				eap=ReReplace(rc.eap, "[^\d.]", "","ALL"),
				epl_limits_id=rc.epl_limits_id,
				include_do=rc.include_do,
				history=0)>
				
		<cfset newappid = app>
		
		<cfset formStruct = getPageContext().getRequest().getParameterMap()>

			<!--- Get the Array length based on number of forms submitted --->
			<cfset count = arrayLen(formStruct['wc_name'])>
			<!--- do the columns --->
			<cfloop from="1" to="#count#" index="i">
				<!--- Horrible workaround, but arrays can't be detected in structures from parameter maps for nonexistent item like checkboxes <ihatecheckboxes> --->
						<cftry>
							<cfset include = formStruct['include'][i]>
							<cfcatch>
								<cfset include = 0>
							</cfcatch>
						</cftry>
						<cftry>
							<cfset exclude = formStruct['exclude'][i]>
							<cfcatch>
								<cfset exclude = 0>
							</cfcatch>
						</cftry>
						<cfset salary = ReReplace(formStruct['salary'][i], "[^\d.]", "","ALL")>
				<cfif formStruct['wc_name'][i] neq "">
				
					<cfif formStruct['workcompid'][i] neq "">
						<!--- Update Contact --->
						<cfset temp=appGW.editWc(workcompid=#formStruct['workcompid'][i]#,
								application_id=newappid,
								name=#formStruct['wc_name'][i]#,
								title=#formStruct['title'][i]#,
								percentown=#formStruct['percentown'][i]#,
								salary=#salary#,
								include=#include#,
								exclude=#exclude#) />
					<cfelse>
						<!--- New Contact --->
						<cfset temp=appGW.addWc(application_id=newappid,
								name=#formStruct['wc_name'][i]#,
								title=#formStruct['title'][i]#,
								percentown=#formStruct['percentown'][i]#,
								salary=#salary#,
								include=#include#,
								exclude=#exclude#) />
					</cfif>
				</cfif>
			</cfloop>
		<cfset result = newappid>
		<cfset rc.response = JSON.encode(result)>
        <cfset fw.setView('common.ajax')>
	</cffunction>--->
	<cffunction name="addEditApp">
		<cfargument name="rc" type="any">
    <cfparam name="rc.application_id" default="0">
		<cfparam name="rc.location_id" default="0">
		<cfparam name="rc.beauty_angel" default="0">
		<cfparam name="rc.key_club_24" default="0">
		<cfparam name="rc.diving_board" default="0">
		<cfparam name="rc.slides" default="0">
		<cfparam name="rc.lifeguards" default="0">
		<cfparam name="rc.swim_risk_signs" default="0">
		<cfparam name="rc.tanning_goggles" default="0">
		<cfparam name="rc.ul_approved" default="0">
		<cfparam name="rc.front_desk_controls" default="0">
		<cfparam name="rc.tanning_waiver_signed" default="0">
		<cfparam name="rc.uv_warnings" default="0">
		<cfparam name="rc.child_sitting" default="0">
		<cfparam name="rc.ratio_less" default="0">
		<cfparam name="rc.sign_in_out" default="0">
		<cfparam name="rc.outdoor_playground" default="0">
		<cfparam name="rc.play_apparatus" default="0">
		<cfparam name="rc.silver_sneakers" default="0">
		<cfparam name="rc.massage" default="0">
		<cfparam name="rc.personal_trainers" default="0">
		<cfparam name="rc.leased_space" default="0">
		<cfparam name="rc.club_named_ai" default="0">
		<cfparam name="rc.employee_benefits" default="0">
		<cfparam name="rc.martial_arts" default="0">
		<cfparam name="rc.climbing_wall" default="0">
		<cfparam name="rc.team_sports" default="0">
		<cfparam name="rc.childrens_programming" default="0">
		<cfparam name="rc.spa" default="0">
		<cfparam name="rc.physical_therapy" default="0">
		<cfparam name="rc.boxing" default="0">
		<cfparam name="rc.off_premises" default="0">
		<cfparam name="rc.cooking_food" default="0">
		<cfparam name="rc.transportation" default="0">
		<cfparam name="rc.events_sponsored" default="0">
		<cfparam name="rc.sports_performance" default="0">
		<cfparam name="rc.crossfit" default="0">
		<cfparam name="rc.aed" default="0">
		<cfparam name="rc.cameras" default="0">
		<cfparam name="rc.aerobics" default="0">
		<cfparam name="rc.aerobic_certs" default="0">
		<cfparam name="rc.pt" default="0">
		<cfparam name="rc.pt_certs" default="0">
		<cfparam name="rc.company_vehicles" default="0">
		<cfparam name="rc.coverage_declined" default="0">
		<cfparam name="rc.cpr" default="0">
		<cfparam name="rc.cpr_certs" default="0">
		<cfparam name="rc.losses" default="0">
		<cfparam name="rc.sex_abuse_policy" default="0">
		<cfparam name="rc.leased_employees" default="0">
		<cfparam name="rc.contractor_certs" default="0">
		<cfparam name="rc.signed_employment" default="0">
		<cfparam name="rc.references_checked" default="0">
		<cfparam name="rc.background_check" default="0">
		<cfparam name="rc.burglar_alarm" default="0">
		<cfparam name="rc.fire_alarm" default="0">
		<cfparam name="rc.sprinklered" default="0">
		<cfparam name="rc.smoke_detectors" default="0">
		<cfparam name="rc.air_structure" default="0">
		<cfparam name="rc.building_coverage" default="0">
		<cfparam name="rc.business_prop" default="0">
		<cfparam name="rc.tenant_improvements" default="0">
		<cfparam name="rc.business_income" default="0">
		<cfparam name="rc.edp" default="0">
    <cfparam name="rc.edp_amount" default="0">
    <cfparam name="rc.employee_dishonesty" default="0">
    <cfparam name="rc.employee_dishonesty_id" default="0">
    <cfparam name="rc.hvac" default="0">
    <cfparam name="rc.signs_25" default="0">
    <cfparam name="rc.cyber_liability" default="0">
    <cfparam name="rc.additional_limit" default="0">
    <cfparam name="rc.additional_limits_id" default="0">
    <cfparam name="rc.employee_rec_benefits_id" default="0">
    <cfparam name="rc.include_do" default="0">
    <cfparam name="rc.exclude" default="0">
    <cfparam name="rc.emp_cont" default="">
    <cfparam name="rc.rentown" default="">
    <cfparam name="rc.history" default="0">
    <cfparam name="rc.ratingid" default="0">
		<cfset rc.location_id = appGW.SaveData(rc,'locations',rc.location_id)>
    <!---save the app--->
		<cfset newappid = appGW.SaveData(rc,'applications',rc.application_id)>
    <!---sync with liability rating--->
    <cfif rc.ratingid neq 0>
			<cfset thisrating = mainGW.getRating(ratingid=rc.ratingid)>
      <cfset syncRC = appGW.appRatingSync(rc=rc,syncWith='rating')>
    
      <cfset ratingSync = appGW.SaveData(syncRc,'rating',rc.ratingid)>
      <cfset glSync = appGW.SaveData(syncRc,'rating_liability',thisrating.rating_liability_id)>
      <cfset propertySync = appGW.SaveData(syncRc,'rating_property',thisrating.rating_property_id)>
    </cfif>
		
		
		<cfset formStruct = getPageContext().getRequest().getParameterMap()>

			<!--- Get the Array length based on number of forms submitted --->
			<cfset count = arrayLen(formStruct['wc_name'])>
			<!--- do the columns --->
			<cfloop from="1" to="#count#" index="i">
				<!--- Horrible workaround, but arrays can't be detected in structures from parameter maps for nonexistent item like checkboxes <ihatecheckboxes> --->
						<cftry>
							<cfset include = formStruct['include'][i]>
							<cfcatch>
								<cfset include = 0>
							</cfcatch>
						</cftry>
						<cftry>
							<cfset exclude = formStruct['exclude'][i]>
							<cfcatch>
								<cfset exclude = 0>
							</cfcatch>
						</cftry>
						<cfset salary = ReReplace(formStruct['salary'][i], "[^\d.]", "","ALL")>
				<cfif formStruct['wc_name'][i] neq "">
				
					<cfif formStruct['workcompid'][i] neq "">
						<!--- Update Contact --->
						<cfset temp=appGW.editWc(workcompid=#formStruct['workcompid'][i]#,
								application_id=newappid,
								name=#formStruct['wc_name'][i]#,
								title=#formStruct['title'][i]#,
								percentown=#formStruct['percentown'][i]#,
								salary=#salary#,
								include=#include#,
								exclude=#exclude#) />
					<cfelse>
						<!--- New Contact --->
						<cfset temp=appGW.addWc(application_id=newappid,
								name=#formStruct['wc_name'][i]#,
								title=#formStruct['title'][i]#,
								percentown=#formStruct['percentown'][i]#,
								salary=#salary#,
								include=#include#,
								exclude=#exclude#) />
					</cfif>
				</cfif>
			</cfloop>
		<cfset result = newappid>
		<cfset rc.response = JSON.encode(result)>
        <cfset fw.setView('common.ajax')>
	</cffunction>  
	<cffunction name="saveapphistory">
		<cfargument name="rc" type="any">
		<cfset history = appGW.cloneapp(application_id=rc.application_id)>
		<cfset result = 'success'>
		<cfset rc.response = JSON.encode(result)>
        <cfset fw.setView('common.ajax')>
	</cffunction>

</cfcomponent>