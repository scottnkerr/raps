<cfcomponent output="false">
	<cffunction name="init" returntype="any" output="false">
		<cfreturn this />
	</cffunction>
	<cffunction name="getApplication" access="public">
		<cfargument name="application_id" default="0" required="yes">
		<cfquery name="qgetApp">
		select l.*,ap.*
		from applications ap
		inner join locations l on ap.location_id=l.location_id
		where ap.application_id=#arguments.application_id#
		</cfquery>
		<cfreturn qgetapp />
	</cffunction>
	<cffunction name="getClient" access="public">
		<cfargument name="client_id" default="0" required="yes">
		<cfquery name="qgetApp">
		select a.entity_name, a.dba, a.fein, a.year_business_started, a.current_effective_date, a.years_experience, a.website, a.mailing_address, a.mailing_address2, a.mailing_city, a.mailing_zip, a.mailing_state, b.name as mailing_statename
        from clients a
        LEFT JOIN states b
        ON a.mailing_state = b.state_id
		where client_id=#arguments.client_id#
		</cfquery>
		<cfreturn qgetapp />
	</cffunction>    
	<cffunction name="getAdditionalLimits" access="public">
		<cfquery name='qgetAdL'>
		select * from app_additionallimits
        where disabled = 0
or disabled is null
		</cfquery>
		<cfreturn qgetAdl />
	</cffunction>
	<cffunction name="getClubLocated" access="public">
		<cfquery name='qgetClubLocated'>
		select * from app_clublocated
        where disabled = 0
or disabled is null
		</cfquery>
		<cfreturn qgetClubLocated />
	</cffunction>
	<cffunction name="getConstructionTypes" access="public">
		<cfquery name="qgetconstructiontypes">
		select * from app_constructiontypes
        where disabled = 0
or disabled is null
		</cfquery>
		<cfreturn qgetconstructiontypes />
	</cffunction>
	<cffunction name="getCyberliability" access="public">
		<cfquery name="qgetcyberliability">
			select * from app_cyberliability
            where disabled = 0
or disabled is null
		</cfquery>
		<cfreturn qgetcyberliability/>
	</cffunction>
	<cffunction name="getedp" access="public">
		<cfquery name="qgetedp">
			select * from app_edp
            where disabled = 0
or disabled is null
		</cfquery>
		<cfreturn qgetedp />
	</cffunction>
	<cffunction name="getepl" access="public">
		<cfquery name="qgetepl">
			select * from app_epl
            where disabled = 0
or disabled is null
		</cfquery>
		<cfreturn qgetepl />
	</cffunction>
	<cffunction name="getEmployeeDishonesty" access="public">
		<cfquery name="data">
			select * from app_employeedishonesty
            where disabled = 0
or disabled is null
		</cfquery>
		<cfreturn data />
	</cffunction>    
	<cffunction name="getemployeerec" access="public">
		<cfquery name="qgetemployeerec">
			select * from app_employeerec
            where disabled = 0
            or disabled is null
		</cfquery>
		<cfreturn qgetemployeerec>
	</cffunction>
	<cffunction name="getrequestedlimits" access="public">
		<cfquery name="qrequestedlimits">
			select * from app_requestedlimits
            where disabled = 0
            or disabled is null
		</cfquery>
		<cfreturn qrequestedlimits />
	</cffunction>
	<cffunction name="getrooftypes" access="public">
		<cfquery name="qgetrooftypes">
		select * from app_rooftypes
            where disabled = 0
            or disabled is null
		</cfquery>
		<cfreturn qgetrooftypes>
	</cffunction>
	<cffunction name="getLocNum" access="public" returntype="numeric">
    <cfargument name="client_id" required="true">
		<cfquery name="getdata">
		select TOP 1 location_number
        from locations
        where client_id = #ARGUMENTS.client_id#
        order by location_number desc
		</cfquery>
        <cfif getdata.recordcount>
		<cfset newnum = val(getdata.location_number) + 1>
        <cfelse>
        <cfset newnum = 1>
        </cfif>
        <cfreturn newnum>
	</cffunction>    
	<cffunction name="addLocation" access="public">
		<cfargument name="client_id" required="true">
		<cfargument name="location_id" default="0">
		<cfargument name="named_insured">
		<cfargument name="dba">
		<cfargument name="address">
		<cfargument name="address2">
		<cfargument name="city">
		<cfargument name="state">
		<cfargument name="zip">
		<cfargument name="location_number">
		<cfargument name="fein">
		<cfargument name="year_business_started">
		<cfargument name="description" default="">
		<cfif location_id eq 0>
		<cfquery name="qaddLocation">
			insert into locations
			(client_id
			,named_insured
			,dba
			,address
			,address2
			,city
			,state_id
			,zip
			,location_number
			,fein
			,year_business_started
			,description)
			VALUES
			(#arguments.client_id#
			,'#arguments.named_insured#'
			,'#arguments.dba#'
			,'#arguments.address#'
			,'#arguments.address2#'
			,'#arguments.city#'
			,#arguments.state#
			,'#arguments.zip#'
			,'#arguments.location_number#'
			,'#arguments.fein#'
			,'#arguments.year_business_started#'
			,'#arguments.description#')
			
			SELECT @@IDENTITY AS 'location_id';
	
	
			
		</cfquery>
			<cfreturn qaddLocation.location_id />
		<cfelse>
			<cfquery name="qeditlocation">
			update locations
			set client_id= #arguments.client_id#
			,named_insured = '#arguments.named_insured#'
			,dba = '#arguments.dba#'
			,address ='#arguments.address#'
			,address2 ='#arguments.address2#'
			,city = '#arguments.city#'
			,state_id = #arguments.state#
			,zip= '#arguments.zip#'
			,location_number = '#arguments.location_number#'
			,fein = '#arguments.fein#'
			,year_business_started = '#arguments.year_business_started#'
			,description= '#arguments.description#'
			where location_id=#arguments.location_id#
			</cfquery>
			<cfreturn location_id />
		</cfif>
	</cffunction>
	<cffunction name="getLocation">
		<cfargument name="location_id" required="yes">
		<cfquery name="qgetloc">
			select * from locations
			where location_id = #arguments.location_id#
		</cfquery>
		<cfreturn qgetloc />
	</cffunction>
	
	<cffunction name="addApplication">
		<cfargument name="application_id" required="no">
		<cfargument name="client_id" required="yes">
		<cfargument name="location_id" required="yes">
		<cfargument name="gross_receipts" required="no">
		<cfargument name="number_members" required="no" default="0">
		<cfargument name="number_employees_ft" required="no" default="0">
		<cfargument name="club_hours" required="no" default="">
		<cfargument name="number_employees_pt" required="no" default="0">
		<cfargument name="key_club_24" required="no" default="0">
		<cfargument name="requested_limits_id" required="no" default="0">
		<cfargument name="requested_limits_other" required="no" default="0">
		<cfargument name="additional_limits_id" required="no" default="0">
		<cfargument name="additional_limits_other" required="no" default="">
		<cfargument name="court_total" required="no" default="0">
		<cfargument name="court_basketball" required="no" default="0">
		<cfargument name="court_racquetball" required="no" default="0">
		<cfargument name="court_tennis" required="no" default="0">
		<cfargument name="sauna" required="no" default="0">
		<cfargument name="steam_room" required="no" default="0">
		<cfargument name="whirlpool" required="no" default="0">
		<cfargument name="pool_total" required="no" default="0">
		<cfargument name="pool_indoor" required="no" default="0">
		<cfargument name="pool_outdoor" required="no" default="0">
		<cfargument name="depth" required="no" default="0">
		<cfargument name="pool_other" required="no" default="0">
		<cfargument name="diving_board" required="no" default="0">
		<cfargument name="slides" required="no" default="0">
		<cfargument name="lifeguards" required="no" default="0">
		<cfargument name="swim_risk_signs" required="no" default="0">
		<cfargument name="beds_total" required="no" default="0">
		<cfargument name="beauty_angel" required="no" default="0">
		<cfargument name="beds_tanning" required="no" default="0">
		<cfargument name="beds_spray" required="no" default="0">
		<cfargument name="tanning_goggles" required="no" default="0">
		<cfargument name="ul_approved" required="no" default="0">
		<cfargument name="front_desk_controls" required="no" default="0">
		<cfargument name="tanning_waiver_signed" required="no" default="0">
		<cfargument name="uv_warnings" required="no" default="0">
		<cfargument name="child_sitting" required="no" default="0">
		<cfargument name="number_children" required="no" default="0">
		<cfargument name="max_age" required="no" default="0">
		<cfargument name="ratio_less" required="no" default="0">
		<cfargument name="sign_in_out" required="no" default="0">
		<cfargument name="outdoor_playground" required="no" default="0">
		<cfargument name="play_apparatus" required="no" default="0">
		<cfargument name="play_desc" required="no" default="">
		<cfargument name="silver_sneakers" required="no" default="0">
		<cfargument name="massage" required="no" default="0">
		<cfargument name="emp_cont" required="no" default="">
		<cfargument name="personal_trainers" required="no" default="0">
		<cfargument name="number_trainers" required="no" default="0">
		<cfargument name="leased_space" required="no" default="0">
		<cfargument name="leased_square_ft" required="no" default="0">
		<cfargument name="leased_to" required="no" default="0">
		<cfargument name="club_named_ai" required="no" default="0">
		<cfargument name="employee_benefits" required="no" default="0">
		<cfargument name="employee_rec_benefits_id" required="no" default="0">
		<cfargument name="martial_arts" required="no" default="0">
		<cfargument name="climbing_wall" required="no" default="0">
		<cfargument name="team_sports" required="no" default="0">
		<cfargument name="childrens_programming" required="no" default="0">
		<cfargument name="spa" required="no" default="0">
		<cfargument name="physical_therapy" required="no" default="0">
		<cfargument name="boxing" required="no" default="0">
		<cfargument name="off_premises" required="no" default="0">
		<cfargument name="cooking_food" required="no" default="0">
		<cfargument name="transportation" required="no" default="0">
		<cfargument name="events_sponsored" required="no" default="0">
		<cfargument name="sports_performance" required="no" default="0">
		<cfargument name="crossfit" required="no" default="0">
		<cfargument name="notes" required="no">
		<cfargument name="aed" required="no" default="0">
		<cfargument name="cameras" required="no" default="0">
		<cfargument name="aerobics" required="no" default="0">
		<cfargument name="aerobic_certs" required="no" default="0">
		<cfargument name="pt" required="no" default="0">
		<cfargument name="pt_certs" required="no" default="0">
		<cfargument name="company_vehicles" required="no" default="0">
		<cfargument name="coverage_declined" required="no" default="0">
		<cfargument name="declined_reason" required="no" default="">
		<cfargument name="cpr" required="no" default="0">
		<cfargument name="cpr_certs" required="no" default="0">
		<cfargument name="losses" required="no" default="0">
		<cfargument name="losses_reason" required="no" default="">
		<cfargument name="sex_abuse_policy" required="no" default="0">
		<cfargument name="leased_employees" required="no" default="0">
		<cfargument name="contractor_certs" required="no" default="0">
		<cfargument name="signed_employment" required="no" default="0">
		<cfargument name="references_checked" required="no" default="0">
		<cfargument name="background_check" required="no" default="0">
		<cfargument name="rentown" required="no" default="">
		<cfargument name="square_ft" required="no" default="0">
		<cfargument name="stories" required="no" default="0">
		<cfargument name="year_built" required="no" default="">
		<cfargument name="update_electrical" required="no" default="0">
		<cfargument name="update_plumbing" required="no" default="0">
		<cfargument name="update_roofing" required="no" default="0">
		<cfargument name="occupants_right" required="no" default="">
		<cfargument name="occupants_left" required="no" default="">
		<cfargument name="occupants_rear" required="no" default="">
		<cfargument name="burglar_alarm" required="no" default="0">
		<cfargument name="fire_alarm" required="no" default="0">
		<cfargument name="sprinklered" required="no" default="0">
		<cfargument name="smoke_detectors" required="no" default="0">
		<cfargument name="miles_from_coast" required="no" default="0">
		<cfargument name="club_located_id" required="no" default="0">
		<cfargument name="club_located_other" required="no" default="0">
		<cfargument name="construction_type_id" required="no" default="0">
		<cfargument name="construction_other" required="no" default="0">
		<cfargument name="roof_type_id" required="no" default="0">
		<cfargument name="roof_other" required="no" default="0">
		<cfargument name="air_structure" required="no" default="0">
		<cfargument name="building_coverage" required="no" default="0">
		<cfargument name="building_coverage_amount" required="no" default="0">
		<cfargument name="business_prop" required="no" default="0">
		<cfargument name="business_prop_amount" required="no" default="0">
		<cfargument name="tenant_improvements" required="no" default="0">
		<cfargument name="tenant_improvements_amount" required="no" default="0">
		<cfargument name="business_income" required="no" default="0">
		<cfargument name="business_income_amount" required="no" default="0">
		<cfargument name="edp" required="no" default="0">
		<cfargument name="edp_amount" required="no" default="0">
		<cfargument name="employee_dishonesty" required="no" default="0">
		<cfargument name="employee_dishonesty_amount_id" required="no" default="0">
		<cfargument name="hvac" required="no" default="0">
		<cfargument name="hvac_amount" required="no" default="0">
		<cfargument name="signs_25" required="no"  default="0">
		<cfargument name="signs_25_amount" required="no" default="0">
		<cfargument name="cyber_liability" required="no" default="0">
		<cfargument name="cyber_liability_amount_id" required="no" default="0">
		<cfargument name="additional_limit" required="no" default="0">
		<cfargument name="additional_limit_amount" required="no" default="0">
		<cfargument name="additional_limit_reason" required="no" default="">
		<cfargument name="eap" required="no" default="0">
		<cfargument name="epl_limits_id" required="no" default="0">
		<cfargument name="include_do" required="no" default="0">
    <cfargument name="history" default="0">
		<cfif application_id eq "0">
		<cfquery name="qaddApplication">
			INSERT INTO [applications]
           ([client_id]
           ,[location_id]
           ,[gross_receipts]
           ,[number_members]
           ,[number_employees_ft]
           ,[club_hours]
           ,[number_employees_pt]
           ,[key_club_24]
           ,[requested_limits_id]
           ,[requested_limits_other]
           ,[additional_limits_id]
           ,[additional_limits_other]
           ,[court_total]
           ,[court_basketball]
           ,[court_racquetball]
           ,[court_tennis]
           ,[sauna]
           ,[steam_room]
           ,[whirlpool]
           ,[pool_total]
           ,[pool_indoor]
           ,[pool_outdoor]
           ,[depth]
           ,[pool_other]
           ,[diving_board]
           ,[slides]
           ,[lifeguards]
           ,[swim_risk_signs]
           ,[beds_total]
		   ,[beauty_angel]
           ,[beds_tanning]
           ,[beds_spray]
           ,[tanning_goggles]
           ,[ul_approved]
           ,[front_desk_controls]
           ,[tanning_waiver_signed]
           ,[uv_warnings]
           ,[child_sitting]
           ,[number_children]
           ,[max_age]
           ,[ratio_less]
           ,[sign_in_out]
           ,[outdoor_playground]
           ,[play_apparatus]
           ,[play_desc]
           ,[silver_sneakers]
           ,[massage]
           ,[emp_cont]
           ,[personal_trainers]
           ,[number_trainers]
           ,[leased_space]
           ,[leased_square_ft]
           ,[leased_to]
           ,[club_named_ai]
           ,[employee_benefits]
           ,[employee_rec_benefits_id]
           ,[martial_arts]
           ,[climbing_wall]
           ,[team_sports]
           ,[childrens_programming]
           ,[spa]
           ,[physical_therapy]
           ,[boxing]
           ,[off_premises]
           ,[cooking_food]
           ,[transportation]
           ,[events_sponsored]
           ,[sports_performance]
           ,[crossfit]
           ,[notes]
           ,[aed]
           ,[cameras]
           ,[aerobics]
           ,[aerobic_certs]
           ,[pt]
           ,[pt_certs]
           ,[company_vehicles]
           ,[coverage_declined]
           ,[declined_reason]
           ,[cpr]
           ,[cpr_certs]
           ,[losses]
           ,[losses_reason]
           ,[sex_abuse_policy]
           ,[leased_employees]
           ,[contractor_certs]
           ,[signed_employment]
           ,[references_checked]
           ,[background_check]
           ,[rentown]
           ,[square_ft]
           ,[stories]
           ,[year_built]
           ,[update_electrical]
           ,[update_plumbing]
           ,[update_roofing]
           ,[occupants_right]
           ,[occupants_left]
           ,[occupants_rear]
           ,[burglar_alarm]
           ,[fire_alarm]
           ,[sprinklered]
           ,[smoke_detectors]
           ,[miles_from_coast]
           ,[club_located_id]
           ,[club_located_other]
           ,[construction_type_id]
           ,[construction_other]
           ,[roof_type_id]
           ,[roof_other]
           ,[air_structure]
           ,[building_coverage]
           ,[building_coverage_amount]
           ,[business_prop]
           ,[business_prop_amount]
           ,[tenant_improvements]
           ,[tenant_improvements_amount]
           ,[business_income]
           ,[business_income_amount]
           ,[edp]
           ,[edp_amount]
      	   ,[employee_dishonesty]
           ,[employee_dishonesty_amount_id]
           ,[hvac]
           ,[hvac_amount]
           ,[signs_25]
           ,[signs_25_amount]
           ,[cyber_liability]
           ,[cyber_liability_amount_id]
           ,[additional_limit]
           ,[additional_limit_amount]
           ,[additional_limit_reason]
           ,[eap]
           ,[epl_limits_id]
           ,[include_do]
           ,[savedatetime]
           ,[history])
     VALUES
           (#arguments.client_id# 
           ,#arguments.location_id#
           ,'#arguments.gross_receipts#'
           ,#val(arguments.number_members)# 
           ,#val(arguments.number_employees_ft)#
           ,'#arguments.club_hours#'
           ,#val(arguments.number_employees_pt)# 
           ,#arguments.key_club_24#
           ,#arguments.requested_limits_id# 
           ,'#arguments.requested_limits_other#' 
           ,#arguments.additional_limits_id# 
           ,'#arguments.additional_limits_other#' 
           ,#val(arguments.court_total)# 
           ,#val(arguments.court_basketball)# 
           ,#val(arguments.court_racquetball)# 
           ,#val(arguments.court_tennis)# 
           ,#val(arguments.sauna)# 
           ,#val(arguments.steam_room)# 
           ,#val(arguments.whirlpool)# 
           ,#val(arguments.pool_total)# 
           ,#val(arguments.pool_indoor)# 
           ,#val(arguments.pool_outdoor)# 
           ,#val(arguments.depth)# 
           ,'#arguments.pool_other#' 
           ,#arguments.diving_board#
           ,#arguments.slides#
           ,#arguments.lifeguards#
           ,#arguments.swim_risk_signs#
           ,#val(arguments.beds_total)# 
			,#val(arguments.beauty_angel)# 
           ,#val(arguments.beds_tanning)# 
           ,#val(arguments.beds_spray)# 
           ,#arguments.tanning_goggles#
           ,#arguments.ul_approved#
           ,#arguments.front_desk_controls#
           ,#arguments.tanning_waiver_signed#
           ,#arguments.uv_warnings#
           ,#arguments.child_sitting#
           ,#val(arguments.number_children)# 
           ,#val(arguments.max_age)# 
           ,#arguments.ratio_less#
           ,#arguments.sign_in_out#
           ,#arguments.outdoor_playground#
           ,#arguments.play_apparatus#
           ,'#arguments.play_desc#'
           ,#arguments.silver_sneakers#
           ,#arguments.massage#
           ,<cfqueryparam cfsqltype="cf_sql_integer" value="#trim(arguments.emp_cont)#" null="#NOT len(trim(arguments.emp_cont))#" /> 
           ,#arguments.personal_trainers#
           ,#val(arguments.number_trainers)# 
           ,#arguments.leased_space#
           ,#val(arguments.leased_square_ft)#
           ,'#arguments.leased_to#' 
           ,#arguments.club_named_ai#
           ,#arguments.employee_benefits#
           ,#arguments.employee_rec_benefits_id# 
           ,#arguments.martial_arts#
           ,#arguments.climbing_wall#
           ,#arguments.team_sports#
           ,#arguments.childrens_programming#
           ,#arguments.spa#
           ,#arguments.physical_therapy#
           ,#arguments.boxing#
           ,#arguments.off_premises#
           ,#arguments.cooking_food#
           ,#arguments.transportation#
           ,#arguments.events_sponsored#
           ,#arguments.sports_performance#
           ,#arguments.crossfit#
           ,'#arguments.notes#'
           ,#arguments.aed#
           ,#arguments.cameras#
           ,#arguments.aerobics#
           ,#arguments.aerobic_certs#
           ,#arguments.pt#
           ,#arguments.pt_certs#
           ,#arguments.company_vehicles#
           ,#arguments.coverage_declined#
           ,'#arguments.declined_reason#' 
           ,#arguments.cpr#
           ,#arguments.cpr_certs#
           ,#arguments.losses#
           ,'#arguments.losses_reason#' 
           ,#arguments.sex_abuse_policy#
           ,#arguments.leased_employees#
           ,#arguments.contractor_certs#
           ,#arguments.signed_employment#
           ,#arguments.references_checked#
           ,#arguments.background_check#
           ,<cfqueryparam cfsqltype="cf_sql_integer" value="#trim(arguments.rentown)#" null="#NOT len(trim(arguments.rentown))#" />
           ,#val(arguments.square_ft)#
           ,#val(arguments.stories)# 
           ,#val(arguments.year_built)# 
           ,'#arguments.update_electrical#' 
           ,'#arguments.update_plumbing#' 
           ,'#arguments.update_roofing#' 
           ,'#arguments.occupants_right#' 
           ,'#arguments.occupants_left#' 
           ,'#arguments.occupants_rear#'
           ,#arguments.burglar_alarm#
           ,#arguments.fire_alarm#
           ,#arguments.sprinklered#
           ,#arguments.smoke_detectors#
           ,#val(arguments.miles_from_coast)# 
           ,#arguments.club_located_id# 
           ,'#arguments.club_located_other#' 
           ,#arguments.construction_type_id# 
           ,'#arguments.construction_other#' 
           ,#arguments.roof_type_id# 
           ,'#arguments.roof_other#' 
           ,#arguments.air_structure#
           ,#arguments.building_coverage#
           ,'#arguments.building_coverage_amount#' 
           ,#arguments.business_prop#
           ,'#arguments.business_prop_amount#' 
           ,#arguments.tenant_improvements#
           ,'#arguments.tenant_improvements_amount#' 
           ,#arguments.business_income#
           ,'#arguments.business_income_amount#' 
           ,#arguments.edp#
           ,#val(arguments.edp_amount)# 
        	,#arguments.employee_dishonesty#
           ,#arguments.employee_dishonesty_amount_id#  
           ,#arguments.hvac#
           ,'#arguments.hvac_amount#' 
           ,#arguments.signs_25#
           ,'#arguments.signs_25_amount#' 
           ,#arguments.cyber_liability#
           ,#arguments.cyber_liability_amount_id# 
           ,#arguments.additional_limit#
           ,'#arguments.additional_limit_amount#' 
           ,'#arguments.additional_limit_reason#' 
           ,'#arguments.eap#'
           ,#arguments.epl_limits_id#
           ,#arguments.include_do#
           ,#now()#,
           #arguments.history#)
		
		SELECT @@IDENTITY AS 'application_id';
		
		</cfquery>
		<cfreturn qaddApplication.application_id>
		<cfelse>
		<cfquery name="updateapp">
		UPDATE [applications]
		SET
		[client_id]= #val(arguments.client_id)#
		,[location_id]= #val(arguments.location_id)#
		,[gross_receipts]= '#arguments.gross_receipts#'
		,[number_members]= #val(arguments.number_members)# 
		,[number_employees_ft]= #val(arguments.number_employees_ft)# 
		,[club_hours]= '#arguments.club_hours#' 
		,[number_employees_pt]= #val(arguments.number_employees_pt)# 
		,[key_club_24]= #arguments.key_club_24#
		,[requested_limits_id]= #arguments.requested_limits_id# 
		,[requested_limits_other]= '#arguments.requested_limits_other#' 
		,[additional_limits_id]= #arguments.additional_limits_id# 
		,[additional_limits_other]= '#arguments.additional_limits_other#' 
		,[court_total]= #val(arguments.court_total)# 
		,[court_basketball]= #val(arguments.court_basketball)# 
		,[court_racquetball]= #val(arguments.court_racquetball)# 
		,[court_tennis]= #val(arguments.court_tennis)# 
		,[sauna]= #val(arguments.sauna)# 
		,[steam_room]= #val(arguments.steam_room)# 
		,[whirlpool]= #val(arguments.whirlpool)# 
		,[pool_total]= #val(arguments.pool_total)# 
		,[pool_indoor]= #val(arguments.pool_indoor)# 
		,[pool_outdoor]= #val(arguments.pool_outdoor)# 
		,[depth]= #val(arguments.depth)# 
		,[pool_other]= '#arguments.pool_other#' 
		,[diving_board]= #arguments.diving_board#
		,[slides]= #arguments.slides#
		,[lifeguards]= #arguments.lifeguards#
		,[swim_risk_signs]= #arguments.swim_risk_signs#
		,[beds_total]= #val(arguments.beds_total)# 
		,[beauty_angel]= #val(arguments.beauty_angel)# 
		,[beds_tanning]= #val(arguments.beds_tanning)# 
		,[beds_spray]= #val(arguments.beds_spray)# 
		,[tanning_goggles]= #arguments.tanning_goggles#
		,[ul_approved]= #arguments.ul_approved#
		,[front_desk_controls]= #arguments.front_desk_controls#
		,[tanning_waiver_signed]= #arguments.tanning_waiver_signed#
		,[uv_warnings]= #arguments.uv_warnings#
		,[child_sitting]= #arguments.child_sitting#
		,[number_children]= #val(arguments.number_children)# 
		,[max_age]= #val(arguments.max_age)# 
		,[ratio_less]= #arguments.ratio_less#
		,[sign_in_out]= #arguments.sign_in_out#
		,[outdoor_playground]= #arguments.outdoor_playground#
		,[play_apparatus]= #arguments.play_apparatus#
		,[play_desc]= '#arguments.play_desc#'
		,[silver_sneakers]= #arguments.silver_sneakers#
		,[massage]= #arguments.massage#
		,[emp_cont]= <cfqueryparam cfsqltype="cf_sql_integer" value="#trim(arguments.emp_cont)#" null="#NOT len(trim(arguments.emp_cont))#" />  
		,[personal_trainers]= #arguments.personal_trainers#
		,[number_trainers]= #val(arguments.number_trainers)# 
		,[leased_space]= #arguments.leased_space#
		,[leased_square_ft]= #val(arguments.leased_square_ft)#
		,[leased_to]= '#arguments.leased_to#' 
		,[club_named_ai]= #arguments.club_named_ai#
		,[employee_benefits]= #arguments.employee_benefits#
		,[employee_rec_benefits_id]= #arguments.employee_rec_benefits_id# 
		,[martial_arts]= #arguments.martial_arts#
		,[climbing_wall]= #arguments.climbing_wall#
		,[team_sports]= #arguments.team_sports#
		,[childrens_programming]= #arguments.childrens_programming#
		,[spa]= #arguments.spa#
		,[physical_therapy]= #arguments.physical_therapy#
		,[boxing]= #arguments.boxing#
		,[off_premises]= #arguments.off_premises#
		,[cooking_food]= #arguments.cooking_food#
		,[transportation]= #arguments.transportation#
		,[events_sponsored]= #arguments.events_sponsored#
		,[sports_performance]= #arguments.sports_performance#
		,[crossfit]= #arguments.crossfit#
		,[notes]= '#arguments.notes#'
		,[aed]= #arguments.aed#
		,[cameras]= #arguments.cameras#
		,[aerobics]= #arguments.aerobics#
		,[aerobic_certs]= #arguments.aerobic_certs#
		,[pt]= #arguments.pt#
		,[pt_certs]= #arguments.pt_certs#
		,[company_vehicles]= #arguments.company_vehicles#
		,[coverage_declined]= #arguments.coverage_declined#
		,[declined_reason]= '#arguments.declined_reason#' 
		,[cpr]= #arguments.cpr#
		,[cpr_certs]= #arguments.cpr_certs#
		,[losses]= #arguments.losses#
		,[losses_reason]= '#arguments.losses_reason#' 
		,[sex_abuse_policy]= #arguments.sex_abuse_policy#
		,[leased_employees]= #arguments.leased_employees#
		,[contractor_certs]= #arguments.contractor_certs#
		,[signed_employment]= #arguments.signed_employment#
		,[references_checked]= #arguments.references_checked#
		,[background_check]= #arguments.background_check#
		,[rentown]= <cfqueryparam cfsqltype="cf_sql_integer" value="#trim(arguments.rentown)#" null="#NOT len(trim(arguments.rentown))#" /> 
		,[square_ft]= #val(arguments.square_ft)#
		,[stories]= #val(arguments.stories)# 
		,[year_built]= #val(arguments.year_built)# 
		,[update_electrical]= '#arguments.update_electrical#' 
		,[update_plumbing]= '#arguments.update_plumbing#' 
		,[update_roofing]= '#arguments.update_roofing#' 
		,[occupants_right]= '#arguments.occupants_right#' 
		,[occupants_left]= '#arguments.occupants_left#'
		,[occupants_rear]= '#arguments.occupants_rear#'
		,[burglar_alarm]= #arguments.burglar_alarm#
		,[fire_alarm]= #arguments.fire_alarm#
		,[sprinklered]= #arguments.sprinklered#
		,[smoke_detectors]= #arguments.smoke_detectors#
		,[miles_from_coast]= #val(arguments.miles_from_coast)# 
		,[club_located_id]= #arguments.club_located_id# 
		,[club_located_other]= '#arguments.club_located_other#' 
		,[construction_type_id]= #arguments.construction_type_id# 
		,[construction_other]= '#arguments.construction_other#' 
		,[roof_type_id]= #arguments.roof_type_id# 
		,[roof_other]= '#arguments.roof_other#' 
		,[air_structure]= #arguments.air_structure#
		,[building_coverage]= #arguments.building_coverage#
		,[building_coverage_amount]= '#arguments.building_coverage_amount#' 
		,[business_prop]= #arguments.business_prop#
		,[business_prop_amount]= '#arguments.business_prop_amount#' 
		,[tenant_improvements]= #arguments.tenant_improvements#
		,[tenant_improvements_amount]= '#arguments.tenant_improvements_amount#' 
		,[business_income]= #arguments.business_income#
		,[business_income_amount]= '#arguments.business_income_amount#' 
		,[edp]= #val(arguments.edp)#
		,[edp_amount]= #val(arguments.edp_amount)# 
	    ,[employee_dishonesty]= #val(arguments.employee_dishonesty)#
		,[employee_dishonesty_amount_id]= #val(arguments.employee_dishonesty_amount_id)# 
		,[hvac]= #arguments.hvac#
		,[hvac_amount]= '#arguments.hvac_amount#' 
		,[signs_25]= #arguments.signs_25#
		,[signs_25_amount]= '#arguments.signs_25_amount#' 
		,[cyber_liability]= #arguments.cyber_liability#
		,[cyber_liability_amount_id]= #arguments.cyber_liability_amount_id# 
		,[additional_limit]= #arguments.additional_limit#
		,[additional_limit_amount]= '#arguments.additional_limit_amount#' 
		,[additional_limit_reason]= '#arguments.additional_limit_reason#' 
		,[eap]= #arguments.eap#
		,[epl_limits_id]= #arguments.epl_limits_id#
		,[include_do]= #arguments.include_do#
    ,[history]=#arguments.history#
        ,[savedatetime]= #now()#
		WHERE application_id=#arguments.application_id#
		
		
		</cfquery>
		<cfreturn arguments.application_id>
		</cfif>
	</cffunction>
	<cffunction name="getWc" access="public">
		<cfargument name="application_id" required="yes">
		<cfquery name="qgetwc">
			select * from app_workcomp
			where application_id= #arguments.application_id#
		</cfquery>
		<cfreturn qgetwc />
	</cffunction>
	<cffunction name="addWC" access="public">
		<cfargument name="application_id" required="yes">
		<cfargument name="name" required="no">
		<cfargument name="title" required="no">
		<cfargument name="percentown" required="no">
		<cfargument name="salary" required="no">
		<cfargument name="include" required="no" default="0">
		<cfargument name="exclude" required="no" default="0">
		<cfquery name="qaddWC">
			INSERT INTO [app_workcomp]
           ([application_id]
           ,[name]
           ,[title]
           ,[percentown]
           ,[salary]
           ,[include]
           ,[exclude])
     		VALUES
           (#arguments.application_id#
			,'#arguments.name#'
			,'#arguments.title#'
			,#val(arguments.percentown)#
			,'#arguments.salary#'
			,#arguments.include#
			,#arguments.exclude#)
		</cfquery>
	</cffunction>
	<cffunction name="editWC" access="public">
		<cfargument name="workcompid" required="yes">
		<cfargument name="application_id" required="yes">
		<cfargument name="name" required="no">
		<cfargument name="title" required="no">
		<cfargument name="percentown" required="no">
		<cfargument name="salary" required="no">
		<cfargument name="include" required="no" default="0">
		<cfargument name="exclude" required="no" default="0">
		<cfquery name="qeditWC">
			UPDATE [app_workcomp]
			   SET [application_id] = #arguments.application_id#
			      ,[name] = '#arguments.name#'
			      ,[title] = '#arguments.title#'
			      ,[percentown] = #val(arguments.percentown)#
			      ,[salary] = '#arguments.salary#'
			      ,[include] = #arguments.include#
			      ,[exclude] = #arguments.exclude#
			 WHERE workcompid = #arguments.workcompid#
		</cfquery>
	</cffunction>
<!---  
	<cffunction name="cloneapp" access="public">
		<cfargument name="application_id" required="yes">
		<cfquery name="qcloneapp">
			INSERT INTO [applications]
           ([client_id]
           ,[location_id]
           ,[gross_receipts]
           ,[number_members]
           ,[number_employees_ft]
           ,[club_hours]
           ,[number_employees_pt]
           ,[key_club_24]
           ,[requested_limits_id]
           ,[requested_limits_other]
           ,[additional_limits_id]
           ,[additional_limits_other]
           ,[court_total]
           ,[court_basketball]
           ,[court_racquetball]
           ,[court_tennis]
           ,[sauna]
           ,[steam_room]
           ,[whirlpool]
           ,[pool_total]
           ,[pool_indoor]
           ,[pool_outdoor]
           ,[depth]
           ,[pool_other]
           ,[diving_board]
           ,[slides]
           ,[lifeguards]
           ,[swim_risk_signs]
           ,[beds_total]
           ,[beds_tanning]
           ,[beds_spray]
           ,[tanning_goggles]
           ,[ul_approved]
           ,[front_desk_controls]
           ,[tanning_waiver_signed]
           ,[uv_warnings]
           ,[child_sitting]
           ,[number_children]
           ,[max_age]
           ,[ratio_less]
           ,[sign_in_out]
           ,[outdoor_playground]
           ,[play_apparatus]
           ,[play_desc]
           ,[silver_sneakers]
           ,[massage]
           ,[emp_cont]
           ,[personal_trainers]
           ,[number_trainers]
           ,[leased_space]
           ,[leased_square_ft]
           ,[leased_to]
           ,[club_named_ai]
           ,[employee_benefits]
           ,[employee_rec_benefits_id]
           ,[martial_arts]
           ,[climbing_wall]
           ,[team_sports]
           ,[childrens_programming]
           ,[spa]
           ,[physical_therapy]
           ,[boxing]
           ,[off_premises]
           ,[cooking_food]
           ,[transportation]
           ,[events_sponsored]
           ,[sports_performance]
           ,[crossfit]
           ,[notes]
           ,[aed]
           ,[cameras]
           ,[aerobics]
           ,[aerobic_certs]
           ,[pt]
           ,[pt_certs]
           ,[company_vehicles]
           ,[coverage_declined]
           ,[declined_reason]
           ,[cpr]
           ,[cpr_certs]
           ,[losses]
           ,[losses_reason]
           ,[sex_abuse_policy]
           ,[leased_employees]
           ,[contractor_certs]
           ,[signed_employment]
           ,[references_checked]
           ,[background_check]
           ,[rentown]
           ,[square_ft]
           ,[stories]
           ,[year_built]
           ,[update_electrical]
           ,[update_plumbing]
           ,[update_roofing]
           ,[occupants_right]
           ,[occupants_left]
           ,[occupants_rear]
           ,[burglar_alarm]
           ,[fire_alarm]
           ,[sprinklered]
           ,[smoke_detectors]
           ,[miles_from_coast]
           ,[club_located_id]
           ,[club_located_other]
           ,[construction_type_id]
           ,[construction_other]
           ,[roof_type_id]
           ,[roof_other]
           ,[air_structure]
           ,[building_coverage]
           ,[building_coverage_amount]
           ,[business_prop]
           ,[business_prop_amount]
           ,[tenant_improvements]
           ,[tenant_improvements_amount]
           ,[business_income]
           ,[business_income_amount]
           ,[edp]
           ,[edp_amount_id]
           ,[employee_dishonesty]
           ,[employee_dishonesty_amount_id]
           ,[hvac]
           ,[hvac_amount]
           ,[signs_25]
           ,[signs_25_amount]
           ,[cyber_liability]
           ,[cyber_liability_amount_id]
           ,[additional_limit]
           ,[additional_limit_amount]
           ,[additional_limit_reason]
           ,[eap]
           ,[epl_limits_id]
           ,[include_do]
           ,[exclude]
           ,[locations_statusid]
           ,[description]
           ,[edp_amount]
           ,[employee_dishonesty_id]
           ,[beauty_angel])
SELECT [client_id]
      ,[location_id]
      ,[gross_receipts]
      ,[number_members]
      ,[number_employees_ft]
      ,[club_hours]
      ,[number_employees_pt]
      ,[key_club_24]
      ,[requested_limits_id]
      ,[requested_limits_other]
      ,[additional_limits_id]
      ,[additional_limits_other]
      ,[court_total]
      ,[court_basketball]
      ,[court_racquetball]
      ,[court_tennis]
      ,[sauna]
      ,[steam_room]
      ,[whirlpool]
      ,[pool_total]
      ,[pool_indoor]
      ,[pool_outdoor]
      ,[depth]
      ,[pool_other]
      ,[diving_board]
      ,[slides]
      ,[lifeguards]
      ,[swim_risk_signs]
      ,[beds_total]
      ,[beds_tanning]
      ,[beds_spray]
      ,[tanning_goggles]
      ,[ul_approved]
      ,[front_desk_controls]
      ,[tanning_waiver_signed]
      ,[uv_warnings]
      ,[child_sitting]
      ,[number_children]
      ,[max_age]
      ,[ratio_less]
      ,[sign_in_out]
      ,[outdoor_playground]
      ,[play_apparatus]
      ,[play_desc]
      ,[silver_sneakers]
      ,[massage]
      ,[emp_cont]
      ,[personal_trainers]
      ,[number_trainers]
      ,[leased_space]
      ,[leased_square_ft]
      ,[leased_to]
      ,[club_named_ai]
      ,[employee_benefits]
      ,[employee_rec_benefits_id]
      ,[martial_arts]
      ,[climbing_wall]
      ,[team_sports]
      ,[childrens_programming]
      ,[spa]
      ,[physical_therapy]
      ,[boxing]
      ,[off_premises]
      ,[cooking_food]
      ,[transportation]
      ,[events_sponsored]
      ,[sports_performance]
      ,[crossfit]
      ,[notes]
      ,[aed]
      ,[cameras]
      ,[aerobics]
      ,[aerobic_certs]
      ,[pt]
      ,[pt_certs]
      ,[company_vehicles]
      ,[coverage_declined]
      ,[declined_reason]
      ,[cpr]
      ,[cpr_certs]
      ,[losses]
      ,[losses_reason]
      ,[sex_abuse_policy]
      ,[leased_employees]
      ,[contractor_certs]
      ,[signed_employment]
      ,[references_checked]
      ,[background_check]
      ,[rentown]
      ,[square_ft]
      ,[stories]
      ,[year_built]
      ,[update_electrical]
      ,[update_plumbing]
      ,[update_roofing]
      ,[occupants_right]
      ,[occupants_left]
      ,[occupants_rear]
      ,[burglar_alarm]
      ,[fire_alarm]
      ,[sprinklered]
      ,[smoke_detectors]
      ,[miles_from_coast]
      ,[club_located_id]
      ,[club_located_other]
      ,[construction_type_id]
      ,[construction_other]
      ,[roof_type_id]
      ,[roof_other]
      ,[air_structure]
      ,[building_coverage]
      ,[building_coverage_amount]
      ,[business_prop]
      ,[business_prop_amount]
      ,[tenant_improvements]
      ,[tenant_improvements_amount]
      ,[business_income]
      ,[business_income_amount]
      ,[edp]
      ,[edp_amount_id]
      ,[employee_dishonesty]
      ,[employee_dishonesty_amount_id]
      ,[hvac]
      ,[hvac_amount]
      ,[signs_25]
      ,[signs_25_amount]
      ,[cyber_liability]
      ,[cyber_liability_amount_id]
      ,[additional_limit]
      ,[additional_limit_amount]
      ,[additional_limit_reason]
      ,[eap]
      ,[epl_limits_id]
      ,[include_do]
      ,[exclude]
      ,[locations_statusid]
      ,[description]
      ,[edp_amount]
      ,[employee_dishonesty_id]
      ,[beauty_angel]
  FROM [applications]
  WHERE application_id = #arguments.application_id#

	SELECT SCOPE_IDENTITY() AS newappid

	</cfquery>
    <cfquery>
  update applications
  set history = 1
  where application_id = #qcloneapp.newappid#
  </cfquery>
	<cfquery name="qclonerating">
	INSERT INTO [rating]
           ([application_id]
           ,[location_id]
           ,[liability_plan_id]
           ,[property_plan_id]
           ,[state_id]
           ,[square_footage]
           ,[gross_receipts]
           ,[excl_proposal]
           ,[gl_issuing_company_id]
           ,[property_issuing_company_id]
           ,[rating_liability_id]
           ,[rating_property_id]
           ,[endorsement_id]
           ,[savedatetime]
           ,[user_id]
           ,[history]
           ,[historynotes])
	SELECT [application_id]
      ,[location_id]
      ,[liability_plan_id]
      ,[property_plan_id]
      ,[state_id]
      ,[square_footage]
      ,[gross_receipts]
      ,[excl_proposal]
      ,[gl_issuing_company_id]
      ,[property_issuing_company_id]
      ,[rating_liability_id]
      ,[rating_property_id]
      ,[endorsement_id]
      ,[savedatetime]
      ,[user_id]
      ,[history]
      ,[historynotes]
  FROM [rating]
  WHERE application_id=#arguments.application_id# and history != 1

	SELECT @@IDENTITY as newhistoryid
	</cfquery>
	<cfquery name="qupdrating">
	UPDATE rating
	set application_id = #qcloneapp.newappid#
	,history=1
	,historynotes='Application Saved as History'
	,[savedatetime] = #createodbcdatetime(now())#
	,[user_id] = #session.auth.id#
	where ratingid = #qclonerating.newhistoryid#
	</cfquery>
	</cffunction>--->
<cffunction name="cloneapp" access="public">
		<cfargument name="application_id" required="yes">
    <cfset newappid = copyRow('applications', arguments.application_id)>
    <cfquery>
    update applications
    set history = 1
    where application_id = #newappid#
  </cfquery>
  <cfquery name="getrating">
  select r.ratingid, rl.rating_liability_id, rp.rating_property_id from rating r
  inner join rating_liability rl
  on r.ratingid = rl.ratingid
  inner join rating_property rp
  on r.ratingid = rp.ratingid
  where r.application_id = #arguments.application_id#
  and r.history != 1
  </cfquery>
    <cfset newratingid = copyRow('rating', getrating.ratingid)>
    <cfset newratingglid = copyRow('rating_liability', getrating.rating_liability_id)>
    <cfset newratingpropid = copyRow('rating_property', getrating.rating_property_id)>
    <cfquery>
    update rating
    set application_id = #newappid#
    ,history=1
    ,historynotes='History Saved'
    ,savedatetime = #createodbcdatetime(now())#
    ,user_id = #session.auth.id#
    where ratingid = #newratingid#
  </cfquery>  
  <cfquery>
  update rating_liability
  set ratingid = #newratingid#
  where rating_liability_id = #newratingglid#
  </cfquery>
  <cfquery>
  update rating_property
  set ratingid = #newratingid#
  where rating_property_id = #newratingpropid#  
  </cfquery>

  <cfset saveDebitsCreditsExpos = copyDebitsCreditsExpos(getrating.rating_liability_id,newratingglid,getrating.rating_property_id,newratingpropid)>
 </cffunction>
<cffunction name="copyDebitsCreditsExpos" returntype="string" output="yes">
<cfargument name="old_rating_liability_id" required="yes" type="numeric">
<cfargument name="new_rating_liability_id" required="yes" type="numeric">
<cfargument name="old_rating_property_id" required="yes" type="numeric">
<cfargument name="new_rating_property_id" required="yes" type="numeric">
<cfparam name="result" default="success">
<!--- create array to hold table info for each related table--->
<cfset tableArray = arrayNew(2)>
<cfset tableArray[1][1] = "rating_liability_otherexp">
<cfset tableArray[1][2] = "otherexp_id">
<cfset tableArray[1][3] = "rating_liability_id">
<cfset tableArray[2][1] = "rating_liability_debtcredits">
<cfset tableArray[2][2] = "debtcredit_id">
<cfset tableArray[2][3] = "rating_liability_id">
<cfset tableArray[3][1] = "rating_property_eb">
<cfset tableArray[3][2] = "eb_id">
<cfset tableArray[3][3] = "rating_property_id">
<cfset tableArray[4][1] = "rating_property_other">
<cfset tableArray[4][2] = "other_property_id">
<cfset tableArray[4][3] = "rating_property_id">
<!---loop through array, getting appropriate table data, copying rows, etc--->
<cfloop from="1" to="#arrayLen(tableArray)#" index="i">
<cfset qTable = tableArray[i][1]>
<cfset qKey = tableArray[i][2]>
<cfset qPK = tableArray[i][3]>
<!---dynamically named qID variable--->
<cfset qID = evaluate("arguments.old_#qPK#")>
<cfset qID2 = evaluate("arguments.new_#qPK#")>

<cfquery name="qData">
select * from #qTable#
where #qPK# = #qID#
</cfquery>
<cfset copyid = qData[qKey]>
<cfloop query="qData">
<cfset newid = copyRow(qTable, val(copyid))>
<cftry>
<cfquery>
update #qTable#
set #qPK# = #qID2#
where #qKey# = #newid#
</cfquery>
<cfcatch type="any">
<cfset result = cfcatch.Message>
</cfcatch>
</cftry>
</cfloop>
</cfloop>
<cfreturn result />
</cffunction> 
<cffunction name="copyRow" access="public" returntype="numeric" hint="copies row in DB. Used for saving history">
	<cfargument name="table" required="yes" type="string">
  <cfargument name="id" required="yes" type="numeric">
  <cfargument name="morewhereclause" default="">
  <cfset tabledata = getSQLCols(arguments.table)>
  <cfset cols = tabledata.cols>
  <cfset pk = tabledata.pk>
		<cfquery name="cloneq">
			INSERT INTO #arguments.table# (#cols#)
			SELECT #cols# FROM #arguments.table# 
     	WHERE #pk# = #arguments.id#
			#arguments.morewhereclause#
			SELECT SCOPE_IDENTITY() AS newid
     </cfquery>  
     <cfreturn cloneq.newid>
</cffunction> 
<cffunction name="getSQLCols" access="public" output="yes" returntype="struct" hint="returns struct of table columns with primary key in separate struct key">  
	<cfargument name="table" required="yes">
  <cfset columndata = GetColMeta(arguments.table)>
  <cfset tablecolumnlist = "">
  <cfloop from="1" to="#arraylen(columndata)#" index="i">
  
  <cfset thiscol = columndata[i]["Name"]>
  <cfset thiscoltype = columndata[i]["TypeName"]>
  <cfif thiscoltype neq 'int identity'>
  <cfset tablecolumnlist = listappend(tablecolumnlist, thiscol, ",")>
  <cfelse>
  <cfset pk = thiscol>
  </cfif>
  </cfloop>
  <cfset tabledata.pk = pk>
  <cfset tabledata.cols = tablecolumnlist>
  
  <cfreturn tabledata>
</cffunction>
<cffunction name="getColMeta" access="public" returntype="any">
	<cfargument name="table" required="yes">
  <cfquery name="getcols">
  select TOP 1 * from #arguments.table#
  </cfquery>
  <cfset columndata = GetMetaData(getcols)>
  <cfreturn columndata>
</cffunction>
<cffunction name="convertSQLtypes" access="public" returntype="struct" hint="converts sql data types to cfsqlparam types">  
	<cfargument name="table" required="yes">
  <cfset columndata = GetColMeta(arguments.table)>
	
  <cfloop from="1" to="#arraylen(columndata)#" index="i">
      <cfset thiscol = columndata[i]["Name"]>
      <cfset thiscoltype = columndata[i]["TypeName"]>  
      <cfset stripchars = false>
      <cfset wrapval = false>

      <cfswitch expression="#thiscoltype#">
        <cfcase value="int identity">

        <cfset sqltype = 'cf_sql_integer'>
        <cfset wrapval = true>
        <cfset idpos = i>
        </cfcase>
        <cfcase value="datetime">
        <cfset sqltype = 'cf_sql_date'>
        </cfcase>
        <cfcase value="numeric">
        <cfset sqltype = 'cf_sql_numeric'>
        <cfset stripchars = true>
        <cfset wrapval = true>
        </cfcase>
        <cfcase value="int">
        <cfset sqltype = 'cf_sql_integer'>
        <cfset stripchars = true>
        <cfset wrapval = true>
        </cfcase>
        <cfcase value="money">
        <cfset sqltype = 'cf_sql_money'>
        <cfset stripchars = true>
        <cfset wrapval = true>
        </cfcase>
        <cfcase value="varchar">
        <cfset sqltype = 'cf_sql_varchar'>
        </cfcase>
        <cfcase value="bit">
        <cfset sqltype = 'cf_sql_bit'>
        <cfset stripchars = true>
        <cfset wrapval = true>
        </cfcase>
        <cfcase value="text">
        <cfset sqltype = 'cf_sql_longvarchar'>
        </cfcase>
        <cfdefaultcase>
        <cfset sqltype = 'cf_sql_varchar'>
        </cfdefaultcase>
      </cfswitch>
	<cfset columndata[i]["cfsqltype"] = sqltype>
	<cfset columndata[i]["wrapval"] = wrapval>
  <cfset columndata[i]["stripchars"] = stripchars>  
  
  </cfloop>
  <!---store id field in its own key and then delete the key from other columns--->
  <cfset idfield = columndata[idpos]["Name"]>
	<cfset arraydeleteat(columndata, idpos)>
  <cfset sqltable.id = idfield>
  
  <cfset sqltable.cols = columndata>
  <cfreturn sqltable>
</cffunction>
<cffunction name="SaveData" access="public" returntype="string" output="yes">
	<cfargument name="rc" required="yes">
  <cfargument name="table" required="yes">
  <cfargument name="id" default="0">
  <cfset rc.savedatetime = now()>
  <cfset rc.user_id = session.auth.id>
  <cfset rc.lastsavedby = session.auth.fullname>
  <cfif arguments.id eq 0>
  <cfset rc.createdby = session.auth.fullname>
  </cfif>
  
  
  <!---get column info--->
  <cfset sqltable = convertSQLtypes(arguments.table)>
  <cfset cols = sqltable.cols>
  <cfset idfield = sqltable.id>
  
  <!---loop through sql columns and find matches in rc--->
  <cfset insertList = "">
  <cfset insertArray = arrayNew(1)>
  <cfloop from="1" to="#arraylen(cols)#" index="i">
  <cfset colName = cols[i]['Name']>
  <cfif StructKeyExists(rc, "#colName#")>
  <cfset insertList = listAppend(insertList, colName)>
  <cfset arrayAppend(insertArray,cols[i])>
  </cfif>
  </cfloop>

  
	<!---INSERT QUERY--->
	<cfif arguments.id is 0>
  <cfquery name="dataupdate">
  INSERT INTO #arguments.table#
  (#insertList#)
  VALUES (
  <cfloop from="1" to="#arrayLen(insertArray)#" index="i">
  <cfset colName = insertArray[i]['Name']>
  <cfset wrapval = insertArray[i]['wrapval']>
  <cfset stripchars = insertArray[i]['stripchars']>
  <cfset cfsqltype = insertArray[i]['cfsqltype']>
  <cfset value = rc["#colName#"]>
  <cfif stripchars is true>
  	<cfset value = ReReplace(value, "[^\d.]", "","ALL")>
  </cfif>
  <cfif wrapval is true>
  	<cfset value = val(value)>
  </cfif>
  <cfif cfsqltype neq "cf_sql_date">
	<cfqueryparam cfsqltype="#cfsqltype#" value="#value#">
	<cfelse>
  #value#
  </cfif>
	<cfif i lt arraylen(insertArray)>,</cfif>
  </cfloop>)
  SELECT SCOPE_IDENTITY() AS newid
  </cfquery>
  <cfset result = dataupdate.newid>
  <cfelse>
  <!---UPDATE QUERY--->
  <cfquery>
  UPDATE #arguments.table#
  SET 
  <cfloop from="1" to="#arrayLen(insertArray)#" index="i">
  <cfset colName = insertArray[i]['Name']>
  <cfset wrapval = insertArray[i]['wrapval']>
  <cfset stripchars = insertArray[i]['stripchars']>
  <cfset cfsqltype = insertArray[i]['cfsqltype']>
  <cfset value = rc["#colName#"]>
  <cfif stripchars is true>
  	<cfset value = ReReplace(value, "[^\d.]", "","ALL")>
  </cfif>
  <cfif wrapval is true>
  	<cfset value = val(value)>
  </cfif>
	#colName# = <cfif cfsqltype neq "cf_sql_date"><cfqueryparam cfsqltype="#cfsqltype#" value="#value#"><cfelse>#value#</cfif><cfif i lt arraylen(insertArray)>,</cfif>
  </cfloop>  
  WHERE #idfield# = #arguments.id#
  </cfquery>
  <cfset result = arguments.id>
  </cfif>
  
  <cfreturn result>
</cffunction>
<cffunction name="appRatingSync" output="yes">  
	<cfargument name="rc" required="yes">
  <cfargument name="syncWith" default="applications">
  <!---get mapped fields for GL --->
  <cfset fieldMap = fieldMappings()>
  
  <cfif syncWith eq "applications">
  	<cfset arrayCol1 = 1>
    <cfset arrayCol2 = 2>
  <cfelse>
    <cfset arrayCol1 = 2>
    <cfset arrayCol2 = 1>
  </cfif>
  <cfset rcNew = structNew()>
  
  <cfloop from="1" to="#arrayLen(fieldMap)#" index="i">
    <cfset col1 = fieldMap[i][arrayCol1]>
    <cfset col2 = fieldMap[i][arrayCol2]>
    <cfparam name="rc.#col2#" default="">
    <cfset rcNew[col1] = rc[col2]>
  </cfloop>

  <cfreturn rcNew />
</cffunction>

<cffunction name="ratingLocSync" output="yes">  
	<cfargument name="excl" required="yes" type="boolean">
  <cfargument name="syncWith" default="locations">
  <cfargument name="id" required="yes">
  <cfset result = "success">
	<cfif syncWith eq 'locations'>
  <cfset fieldname = 'exclude_prop'>
  <cfelse>
  <cfset fieldname = 'excl_proposal'>
  </cfif>
  <cfset pk = getPK(arguments.syncWith)>

  <cfsavecontent variable="sql">
	update #arguments.syncWith#
  set #fieldname# = #arguments.excl#
  where #pk# =  #arguments.id#
  </cfsavecontent>
<cfquery>
  #sql#
 </cfquery>

  <cfreturn result />
</cffunction>
<cffunction name="getPK" returntype="string" output="yes">
<cfargument name="tableName" required="yes">
<cfdbinfo datasource="raps" type="foreignkeys" name="dbinfo" table="#arguments.tableName#">
<cfset pk = dbinfo.pkcolumn_name>
<cfif not len(pk)>
<!---cfdb didn't find it, use another method--->
  <cfset columndata = GetColMeta(arguments.tableName)>
	
  <cfloop from="1" to="#arraylen(columndata)#" index="i">
      <cfset thiscol = columndata[i]["Name"]>
      <cfset thiscoltype = columndata[i]["TypeName"]>  
      <cfswitch expression="#thiscoltype#">
        <cfcase value="int identity">
        <cfset pk = thiscol>
        <cfbreak>
        </cfcase>
       </cfswitch>
       </cfloop>
</cfif>
<cfreturn pk />
</cffunction>
	<cffunction name="fieldMappings" output="yes" returntype="array">

    <!---first column should be application column name, second column should be corresponding rating column--->
    <cfset fieldmap = arrayNew(2)>
    <!--- gl --->
    <cfset fieldmap[1][1] = "number_trainers"><cfset fieldmap[1][2] = "instructors_expo">
    <cfset fieldmap[2][1] = "court_basketball"><cfset fieldmap[2][2] = "basketball_expo">
    <cfset fieldmap[3][1] = "court_racquetball"><cfset fieldmap[3][2] = "rt_courts_expo">
    <cfset fieldmap[4][1] = "court_tennis"><cfset fieldmap[4][2] = "tennis_courts_expo">
    <cfset fieldmap[5][1] = "sauna"><cfset fieldmap[5][2] = "sauna_expo">
    <cfset fieldmap[6][1] = "steam_room"><cfset fieldmap[6][2] = "steamroom_expo">
    <cfset fieldmap[7][1] = "whirlpool"><cfset fieldmap[7][2] = "whirlpool_expo">
    <cfset fieldmap[8][1] = "pool_indoor"><cfset fieldmap[8][2] = "pools_expo">
    <cfset fieldmap[9][1] = "pool_outdoor"><cfset fieldmap[9][2] = "poolsoutdoor_expo">
    <cfset fieldmap[10][1] = "beds_tanning"><cfset fieldmap[10][2] = "tanning_expo">
    <cfset fieldmap[11][1] = "beds_spray"><cfset fieldmap[11][2] = "spraytanning_expo">
    <cfset fieldmap[12][1] = "beauty_angel"><cfset fieldmap[12][2] = "beautyangels_expo">
    <cfset fieldmap[13][1] = "silver_sneakers"><cfset fieldmap[13][2] = "silversneakers_expo">
    <cfset fieldmap[14][1] = "massage"><cfset fieldmap[14][2] = "massage_expo">
    <cfset fieldmap[15][1] = "personal_trainers"><cfset fieldmap[15][2] = "pt_expo">
    <cfset fieldmap[16][1] = "child_sitting"><cfset fieldmap[16][2] = "childsitting_expo">
    <cfset fieldmap[17][1] = "play_apparatus"><cfset fieldmap[17][2] = "junglegym_expo">
    <cfset fieldmap[18][1] = "employee_benefits"><cfset fieldmap[18][2] = "employeebenefits_expo">
    <cfset fieldmap[19][1] = "employee_rec_benefits_id"><cfset fieldmap[19][2] = "employee_rec_benefits_id">
    <cfset fieldmap[20][1] = "gross_receipts"><cfset fieldmap[20][2] = "gross_receipts">
    <cfset fieldmap[21][1] = "square_ft"><cfset fieldmap[21][2] = "square_footage">
    <cfset fieldmap[22][1] = "leased_space"><cfset fieldmap[22][2] = "leasedspace_expo">
		<!---property--->
    <cfset fieldmap[23][1] = "building_coverage_amount"><cfset fieldmap[23][2] = "prop_buildinglimit">
    <cfset fieldmap[24][1] = "business_prop_amount"><cfset fieldmap[24][2] = "prop_bpplimit">
    <cfset fieldmap[25][1] = "tenant_improvements_amount"><cfset fieldmap[25][2] = "prop_tilimit">
    <cfset fieldmap[26][1] = "business_income_amount"><cfset fieldmap[26][2] = "prop_bieelimit">
    <cfset fieldmap[27][1] = "edp_amount"><cfset fieldmap[27][2] = "prop_edplimit">
    <cfset fieldmap[28][1] = "employee_dishonesty_id"><cfset fieldmap[28][2] = "employee_dishonesty_id">
    <cfset fieldmap[29][1] = "hvac_amount"><cfset fieldmap[29][2] = "prop_hvaclimit">
    <cfset fieldmap[30][1] = "signs_25_amount"><cfset fieldmap[30][2] = "prop_signlimit">
    <cfset fieldmap[31][1] = "cyber_liability_amount_id"><cfset fieldmap[31][2] = "cyber_liability_amount_id">
    <!---yesnoquestions/notes--->
    <cfset fieldmap[32][1] = "notes"><cfset fieldmap[32][2] = "yesnoquestions">       
    <cfreturn fieldmap />
	</cffunction>  
  
	<cffunction name="fieldMappings2" output="yes" returntype="array">

    <!---first column should be application column name, second column should be corresponding rating column--->
    <cfset fieldmap = arrayNew(2)>
    <cfset fieldmap[1][1] = "building_coverage_amount"><cfset fieldmap[1][2] = "prop_buildinglimit">
    <cfset fieldmap[2][1] = "business_prop_amount"><cfset fieldmap[2][2] = "prop_bpplimit">
    <cfset fieldmap[3][1] = "tenant_improvements_amount"><cfset fieldmap[3][2] = "prop_tilimit">
    <cfset fieldmap[4][1] = "business_income_amount"><cfset fieldmap[4][2] = "prop_bieelimit">
    <cfset fieldmap[5][1] = "edp_amount"><cfset fieldmap[5][2] = "prop_edplimit">
    <cfset fieldmap[6][1] = "employee_dishonesty_id"><cfset fieldmap[6][2] = "employee_dishonesty_id">
    <cfset fieldmap[7][1] = "hvac_amount"><cfset fieldmap[7][2] = "prop_hvaclimit">
    <cfset fieldmap[8][1] = "signs_25_amount"><cfset fieldmap[8][2] = "prop_signlimit">
    <cfset fieldmap[9][1] = "cyber_liability_amount_id"><cfset fieldmap[9][2] = "cyber_liability_amount_id">
    
    <cfreturn fieldmap />
	</cffunction>   
  <!---
  <cffunction name="fieldMappings" output="yes" hint="Finds the associated db column in applications and ratings">
  <!---the field to find a corresponding field for--->
    <cfargument name="fieldName" required="yes">
    <!---the table fieldName is located in--->
    <cfargument name="matchTable" default="applications">
    <cfparam name="assocField" default="">
    <cfif arguments.matchTable eq "applications">
    	<cfset arrayCol1 = 1>
      <cfset arrayCol2 = 2>
    <cfelse>
      <cfset arrayCol1 = 2>
      <cfset arrayCol2 = 1>
    </cfif>
    <!---first column should be application column name, second column should be corresponding rating column--->
    <cfset fieldmap = arrayNew(2)>
    <cfset fieldmap[1][1] = "number_trainers"><cfset fieldmap[1][2] = "instructors_expo">
    <cfset fieldmap[2][1] = "court_basketball"><cfset fieldmap[2][2] = "basketball_expo">
    <cfset fieldmap[3][1] = "court_racquetball"><cfset fieldmap[3][2] = "rt_courts_expo">
    <cfset fieldmap[4][1] = "court_tennis"><cfset fieldmap[4][2] = "tennis_courts_expo">
    <cfset fieldmap[5][1] = "sauna"><cfset fieldmap[5][2] = "sauna_expo">
    <cfset fieldmap[6][1] = "steam_room"><cfset fieldmap[6][2] = "steamroom_expo">
    <cfset fieldmap[7][1] = "whirlpool"><cfset fieldmap[7][2] = "whirlpool_expo">
    <cfset fieldmap[8][1] = "pool_indoor"><cfset fieldmap[8][2] = "pools_expo">
    <cfset fieldmap[9][1] = "pool_outdoor"><cfset fieldmap[9][2] = "poolsoutdoor_expo">
    <cfset fieldmap[10][1] = "beds_tanning"><cfset fieldmap[10][2] = "tanning_expo">
    <cfset fieldmap[11][1] = "beds_spray"><cfset fieldmap[11][2] = "spraytanning_expo">
    <cfset fieldmap[12][1] = "beauty_angel"><cfset fieldmap[12][2] = "beautyangels_expo">
    <cfset fieldmap[13][1] = "silver_sneakers"><cfset fieldmap[13][2] = "silversneakers_expo">
    <cfset fieldmap[14][1] = "massage"><cfset fieldmap[14][2] = "massage_expo">
    <cfset fieldmap[15][1] = "personal_trainers"><cfset fieldmap[15][2] = "pt_expo">
    <cfset fieldmap[16][1] = "child_sitting"><cfset fieldmap[16][2] = "childsitting_expo">
    <cfset fieldmap[17][1] = "leased_square_ft"><cfset fieldmap[17][2] = "junglegym_expo">
    <cfset fieldmap[18][1] = "employee_benefits"><cfset fieldmap[18][2] = "employeebenefits_expo">
    <cfset fieldmap[19][1] = "court_basketball"><cfset fieldmap[19][2] = "spraytanning_expo">
    <cfset fieldmap[20][1] = "employee_rec_benefits_id"><cfset fieldmap[20][2] = "employee_rec_benefits_id">
    <cfset fieldmap[21][1] = "gross_receipts"><cfset fieldmap[21][2] = "gross_receipts">
    <cfset fieldmap[22][1] = "square_ft"><cfset fieldmap[22][2] = "square_ft">
 
    <cfloop from="1" to="#arrayLen(fieldmap)#" index="i">
    	<cfif fieldmap[i][arrayCol1] eq arguments.fieldName>
      	<cfset assocField = fieldmap[i][arrayCol2]>
        <cfbreak>
     </cfif> 
    </cfloop>
    
    <!---Using struct instead of array
    <cfset fieldmap = structnew()>
    
    <cfset fieldmap.rating_field_1 = "app_field_1">
    <cfset fieldmap.rating_field_2 = "app_field_2">
  
    <cfif structKeyExists(fieldmap,arguments.fieldName)>
    <cfset assocField = fieldmap[arguments.fieldName]>
    </cfif>--->
    
    <cfreturn assocField />
	</cffunction>    --->
</cfcomponent>