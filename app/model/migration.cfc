<cfcomponent output="false">
	<cffunction name="init" returntype="any" output="false">
		<cfreturn this />
	</cffunction>
	<cffunction name="clientUpdate" returntype="any" output="false">
	<cfargument name="clientid" default="0">
	<cfparam name="result" default="success" />
    <cfset ClientAccess = getClients(arguments.clientid)>	

	<cftry>
		<cfloop query="ClientAccess">
		    <cfset ao = CreateAccessObject() />
		    <cfset ao.num.gym_id = ClientID />
		<!--- flip flopped stripping semicolons per tabatha --->
			<cfset ao.str.entity_name = ClientAccess["Insd Name"][currentrow] />
			<cfset ao.str.dba = replacenocase(ClientAccess["Insd DBA"][currentrow],";","","ALL") />
			<cfset ao.str.mailing_address = ClientAccess["Insd Mailing Address"][currentrow] />
			<cfset ao.str.mailing_city = ClientAccess["Insd Mailing City"][currentrow] />
			<cfset ao.num.mailing_state = getState(ClientAccess["Insd Mailing State"][currentrow]) />
			<cfset ao.str.mailing_zip = ClientAccess["Insd Mailing Zip"][currentrow] />                       
			<cfset ao.str.business_phone = formatPhone(ClientAccess["Insd Phone"][currentrow]) />          
			<cfset ao.str.business_email = ClientAccess["Insd Email"][currentrow] />
			<cfset ao.str.website = Rereplace( Rereplace( ClientAccess["Insd WebSite"][currentrow], "^[A-Za-z\d\/\.\@\?:=&\-_]{0,}##" , ""), "##$", "" ) />
			<cfset ao.str.fein = ClientAccess["Insd FEIN"][currentrow] />	
			<cfset ao.str.x_reference = ClientAccess["Cross Ref ID"][currentrow] /> 		
			<cfset ao.str.client_code = ClientAccess["Tam Client##"][currentrow] />		
		    <cfset ao.str.client_notes = ClientAccess["Insd Memo"][currentrow] />
		    <cfset ao.num.affiliation_id = getAffiliation(ClientAccess["Conglom Code"][currentrow]) />
			<cfset ao.str.ams = ClientAccess["AG2 REC"][currentrow]>
			<cfset ao.str.year_business_started = ClientAccess["Year Bus Started"][currentrow]>
			<cfset ao.str.years_experience = ClientAccess["##Years Experience"][currentrow]>
			<cfset ao.num.client_status_id = ClientAccess["Client Status 1 2 3"][currentrow]>
			<cfset ao.num.client_type_id = val(ClientAccess["INSD TYPE OWNERSHIP"][currentrow])>	
			<cfset ao.str.current_effective_date = ClientAccess["PROPOSED EFF DATE"][currentrow]>	
            <cfset ao.num.am = convertUser(ClientAccess["CSR"][currentrow])>
                                   		
		    <cfset result = MigrateToRaps( "clients", ao ) />
		</cfloop>
		<cfcatch type="any">
			<cfset result = "#cfcatch.Message# - #cfcatch.Detail#" />
		</cfcatch>
	</cftry>
	<cfreturn result />
	</cffunction>
	<cffunction name="contactUpdate" returntype="any" output="false">
        <cfargument name="client_id" default="0" required="no">
        <cfargument name="clientid" default="0">
        <cfparam name="result" default="success" />
        <cfset ClientAccess = getClients(clientid=arguments.clientid)>   
        <cfloop query="ClientAccess">
        <cfset ClientInfo = getClientInfo(ClientID)>
        <cfif ClientInfo.recordcount>
            <!---1st contact--->
            <cfif trim(ClientAccess["Insd Contact Name"][currentrow]) neq ''>
            
            <cfset addClientContact(client_id=ClientInfo.client_id,
									name=ClientAccess["Insd Contact Name"][currentrow],
									title=ClientAccess["Pref Cont Title"][currentrow],
									phone=formatPhone(ClientAccess["Insd Phone"][currentrow]),
									cell=formatPhone(ClientAccess["Insd Cell"][currentrow]),
									fax=formatPhone(ClientAccess["Insd Fax"][currentrow]),
									email=ClientAccess["Insd Email"][currentrow])>
            </cfif>                        
            <!---2nd contact--->
            <cfif trim(ClientAccess["Contact2Name"][currentrow]) neq ''>
            <cfset addClientContact(client_id=ClientInfo.client_id,
									name=ClientAccess["Contact2Name"][currentrow],
									title=ClientAccess["Contact2Title"][currentrow],
									phone=formatPhone(ClientAccess["Contact2Phone"][currentrow]),
									cell=formatPhone(ClientAccess["Contact2Cell"][currentrow]),
									fax=formatPhone(ClientAccess["Contact2Fax"][currentrow]),
									email=ClientAccess["Contact2Email"][currentrow])>	
         </cfif> 
            </cfif>        
        </cfloop> 
        <cfreturn result />
    </cffunction>
	<cffunction name="locationUpdate" returntype="any" output="false">
  <cfargument name="clientid" default="0"> 
	<cfparam name="result" default="success" />
   
	<cfset getLocations = Locations(clientid=arguments.clientid)>

	<cftry>
		<cfloop query="getLocations">
		    <cfset ao = CreateAccessObject() />
		<cfset ClientInfo = getClientInfo(ClientID)>
		<cfif ClientInfo.recordcount>
		    <cfset ao.num.gym_id = locid />
			<cfset ao.num.client_id = ClientInfo.client_id />
			<cfset ao.num.location_status_id = convertLocationStatus(getLocations["Loc Status 1 2 3"][currentrow]) />
			<cfset ao.num.exclude_prop = getLocations["Exclude from Proposal"][currentrow] />
			<!---Labeled wrong in gym as dba, actually is entity name--->
			<cfset ao.str.named_insured = getLocations["DBA Loc"][currentrow] />
			<cfset ao.str.location_number = getLocations["Loc##"][currentrow] />
			<cfset ao.str.address = getLocations["Loc Street"][currentrow] />
			<cfset ao.str.city = getLocations["Loc City"][currentrow] />
			<cfset ao.str.state_id = getState(getLocations["Loc State"][currentrow])>
			<cfset ao.str.zip = getLocations["Loc Zip"][currentrow] />
			<cfset ao.str.entered_date = getLocations["Entered Date"][currentrow] />
			<!---<cfset ao.str.description = getLocations["Notes"][currentrow] />--->				
		    <cfset result = MigrateToRaps( "locations", ao ) />
		</cfif>
		</cfloop>
		
		<cfcatch type="any">
			<cfset result = "#cfcatch.Message# - #cfcatch.Detail#" />
		</cfcatch>
	</cftry>
	<cfreturn result />
	</cffunction>
	<cffunction name="applicationUpdate" returntype="any" output="true">
    <cfargument name="history" default="0">
    <cfargument name="clientid" default="0">
	<cfparam name="URL.LocID" default="0">
  
	<cfparam name="result" default="success" />
    
		<cfset getLocations = locations(LocID=URL.LocID,clientid=arguments.clientid)>
        <cffile action="append" file="#expandPath('.')#\migration.txt" output="#DateFormat(now(), 'mm/dd/yyyy')# #timeFormat(now())# -Locations query has #getLocations.recordcount# records"> 
	<cftry>
    <cfset failedlocations = 0>
		<cfloop query="getLocations">
    <cfset id = getLocations.locid>
        	<cfif ARGUMENTS.history eq 0>
          <cfset forceinsert = 0>
       	    <!---<cfset id = getLocations.locid>   --->
            <cfelse>
            <cfset forceinsert = 1>
           <!--- <cfset id = 0>--->
            </cfif> 
		    <cfset ao = CreateAccessObject() />
		<cfset ClientInfo = getClientInfo(ClientID)>
		<cfif not ClientInfo.recordcount>
		<cfset failedlocations = failedlocations +1> 
        <cfelse>
		<cfset LocationInfo = getLocationInfo(locid)>
		    <cfset ao.num.gym_id = id />
    <cfset ao.num.history = ARGUMENTS.history />
     <cfset ao.savedatetime = now()>
			<cfset ao.num.client_id = ClientInfo.client_id />
			<cfset ao.num.location_id = LocationInfo.location_id />
      <!---
			<cfset ao.num.number_trainers = val(getLocations["## Instructors"][currentrow]) />--->
			<cfset ao.str.gross_receipts = getLocations["GROSS RECPTS"][currentrow]>
			<cfset ao.str.number_members = getLocations["## MEMBERS"][currentrow]>
			<cfset ao.str.number_employees_ft = getLocations["## EMPL FULL"][currentrow]>
			<cfset ao.str.number_employees_pt = getLocations["## EMPL PART"][currentrow]>
			<cfset ao.str.club_hours = getLocations["HOURS OF OPS"][currentrow]>
			<cfset ao.num.key_club_24 = convertYN(getLocations["24 HOUR KEY YN"][currentrow])>
			<cfset ao.str.additional_limit_amount = getLocations["ADDL LIMIT LIAB AMT"][currentrow]>
			<cfset ao.num.court_total = val(getLocations["## COURTS"][currentrow])>
			<cfset ao.num.court_basketball = getLocations["## BASKETBALL COURTS"][currentrow]>
			<cfset ao.num.court_racquetball = getLocations["## RACQUETBALL COURTS"][currentrow]>
			<cfset ao.num.court_tennis = getLocations["## TENNIS COURTS"][currentrow]>
			<cfset ao.num.steam_room = getLocations["## STEAM"][currentrow]>
			<cfset ao.num.sauna = 0>
      <cfset ao.num.additional_limit = val(getLocations["Addl Limits Liab YN"][currentrow])>
			<cfset ao.num.whirlpool = getLocations["## JACUZZI"][currentrow]>
			<cfset ao.num.pool_total = getLocations["## LAPPOOLS"][currentrow]>
			<cfset ao.num.pool_indoor = getLocations["POOL INDOOR YN"][currentrow]>
			<cfset ao.num.pool_outdoor = getLocations["POOL OUTDOOR YN"][currentrow]>
			<cfset ao.str.depth = getLocations["DEPTH"][currentrow]>
			<cfset ao.str.diving_board = getLocations["DIVING BOARD Y/N"][currentrow]>
			<cfset ao.str.slides = convertYN(getLocations["POOL SLIDES YN"][currentrow])>
			<cfset ao.str.lifeguards = convertYN(getLocations["LIFEGUARDS Y/N"][currentrow])>
			<cfset ao.str.swim_risk_signs = convertYN(getLocations["SWIM AT YOUR OWN RISK SIGNS YN"][currentrow])>
			<cfset ao.str.beds_total = getLocations["## TANNING"][currentrow]>
			<cfset ao.str.beds_tanning = getLocations["## TANNING"][currentrow]>
			<cfset ao.str.tanning_goggles = convertYN(getLocations["TANNING GOGGLES YN"][currentrow])>
			<cfset ao.str.ul_approved = convertYN(getLocations["TANNING BEDS UL APPROVED YN"][currentrow])>
			<cfset ao.str.tanning_waiver_signed = convertYN(getLocations["TANNING WAIVER SIGNED YN"][currentrow])>
			<cfset ao.str.uv_warnings = convertYN(getLocations["UW WARNING SIGNS POSTED YN"][currentrow])>
			<cfset ao.str.front_desk_controls = convertYN(getLocations["FRONT DESK CONTROLS YN"][currentrow])>
			<cfset ao.num.child_sitting = convertYN(getLocations["DAY CARE YN"][currentrow])>
			<cfset ao.str.childrens_programming = convertYN(getLocations["CHILDREN PROGRAMS YN"][currentrow])>
			<cfset ao.str.max_age = getLocations["MAX AGE DAY CARE"][currentrow]>
			<cfset ao.str.number_children = getLocations["## CHILDREN DAY CARE"][currentrow]>
			<cfset ao.str.outdoor_playground = convertYN(getLocations["OUTDOOR PLAYGROUND YN"][currentrow])>
			<cfset ao.str.play_desc = getLocations["ACTITIVIES DAY CARE"][currentrow]>
			<cfset ao.str.silver_sneakers = convertYN(getLocations["SENIOR PROGRAMS YN"][currentrow])>
			<cfset ao.str.massage = convertYN(getLocations["MASSAGETHERAPY Y/N"][currentrow])>
			<cfset ao.str.leased_space = convertYN(getLocations["LEASE SPACE TO OTHERS YN"][currentrow])>
			<cfset ao.str.martial_arts = convertYN(getLocations["MARTIAL ARTS Y/N"][currentrow])>
			<cfset ao.str.climbing_wall = convertYN(getLocations["CLIMBING WALL YN"][currentrow])>
			<cfset ao.str.spa = convertYN(getLocations["DAY SPA YN"][currentrow])>
			<cfset ao.str.physical_therapy = convertYN(getLocations["PHYS THERAPY Y/N"][currentrow])>
			<cfset ao.str.boxing = convertYN(getLocations["BOXING YN"][currentrow])>
			<cfset ao.str.notes = '#getLocations["NOTES"][currentrow]# &##013;&##010;#getLocations["Other Amenities"][currentrow]#'>
			<cfset ao.str.aed = convertYN(getLocations["AED DIFRIBULATOR ON PREMISES YN"][currentrow])>
			<cfset ao.str.cameras = convertYN(getLocations["DIGITIAL RECORDING SYSTEM YN"][currentrow])>
			<cfset ao.str.aerobics = convertYN(getLocations["AEROBIC INSTRUTORS CERTIFIED YN"][currentrow])>
			<cfset ao.str.aerobic_certs = convertYN(getLocations["AEROBIC CERTS YN"][currentrow])>
			<cfset ao.str.pt = convertYN(getLocations["PERSONAL TRAINERS CERTIFIED YN"][currentrow])>
			<cfset ao.str.pt_certs = getLocations["TRAINER CERTS YN"][currentrow]>
			<cfset ao.str.company_vehicles = convertYN(getLocations["COMPANY OWNED VEHICLES YN"][currentrow])>
			<cfset ao.str.coverage_declined = convertYN(getLocations["COVERAGE DECLINED, CANCELED, NON RENEWED YN"][currentrow])>
			<cfset ao.str.cpr = getLocations["STAFF TRAINED IN CPR YN"][currentrow]>
			<cfset ao.str.cpr_certs = getLocations["CPR CERTS YN"][currentrow]>
			<cfset ao.str.losses = convertYN(getLocations["LOSSES SEXUAL ABUSE, MOLESTATION, DISCRIMINATION, NEGL HIRE YN"][currentrow])>
			<cfset ao.str.leased_employees = convertYN(getLocations["LEASED EMPLOYEES"][currentrow])>
			<cfset ao.str.contractor_certs = getLocations["CONTRACTOR CERTS Y/N"][currentrow]>
			<cfset ao.str.rentown = getLocations["OWN YN"][currentrow]>
			<cfset ao.str.square_ft = getLocations["SQ FOOTAGE"][currentrow]>
			<cfset ao.str.stories = getLocations["## STORIES"][currentrow]>
			<cfset ao.str.year_built = getLocations["YR BLT"][currentrow]>
			<cfset ao.str.update_electrical = getLocations["ELECTRIAL UPDATE YEAR"][currentrow]>
			<cfset ao.str.update_plumbing = getLocations["PLUMBING UPDATE YEAR"][currentrow]>
			<cfset ao.str.update_roofing = getLocations["ROOFING UPDATE YEAR"][currentrow]>
			<cfset ao.str.occupants_right = getLocations["OTHER OCCUPANT RIGHT"][currentrow]>
			<cfset ao.str.occupants_left = getLocations["OTHER OCCUPANT LEFT"][currentrow]>
			<cfset ao.str.occupants_rear = getLocations["OTHER OCCUPANT REAR"][currentrow]>
			<cfset ao.str.burglar_alarm = getLocations["CENTRAL STATION ALARM YN"][currentrow]>
			<cfset ao.str.fire_alarm = getLocations["FIRE ALARM YN"][currentrow]>
			<cfset ao.str.sprinklered = getLocations["SPRINKLER SYSTEM YN"][currentrow]>
			<cfset ao.str.smoke_detectors = convertYN(getLocations["SMOKE DETECTORS YN"][currentrow])>
			<cfset ao.str.miles_from_coast = round(val(getLocations["## MILES FROM COAST"][currentrow]))>
			<cfset ao.str.club_located_other = getLocations["CLUB LOCATED IN"][currentrow]>
			<cfset ao.str.construction_type_id = getConstructionType(getLocations["WALL CONSTR"][currentrow])>
			<cfif ao.str.construction_type_id eq 0>
			<cfset ao.str.construction_other = getLocations["WALL CONSTR"][currentrow]>
			<cfelse>
			<cfset ao.str.construction_other = "">
			</cfif>
			<cfset ao.str.roof_type_id = getroofType(getLocations["ROOF CONST"][currentrow])>
			<cfif ao.str.roof_type_id eq 0>
			<cfset ao.str.roof_other = getLocations["ROOF CONST"][currentrow]>
			<cfelse>
			<cfset ao.str.roof_other = "">
			</cfif>			
			<cfset ao.str.air_structure = convertYN(getLocations["AIR STRUCTURES (BUBBLES, DOMES) YN"][currentrow])>
			<cfset ao.num.building_coverage_amount = val(getLocations["BLDG LIMIT"][currentrow])>
			<cfif getLocations["BLDG LIMIT"][currentrow] gt 0>
			<cfset ao.num.building_coverage = 1>
			</cfif>	
			<cfset ao.num.business_prop_amount = val(getLocations["BPP LIMIT"][currentrow])>
			<cfif getLocations["BPP LIMIT"][currentrow] gt 0>
			<cfset ao.num.business_prop = 1>
			</cfif>				
			<cfset ao.num.business_income_amount = val(getLocations["BI/EE LIMIT"][currentrow])>
			<cfif getLocations["BI/EE LIMIT"][currentrow] gt 0>
			<cfset ao.num.business_income = 1>
			</cfif>	
			<cfset ao.num.signs_25_amount = val(getLocations["SIGN 25K+"][currentrow])>
			<cfif getLocations["SIGN 25K+"][currentrow] gt 0>
			<cfset ao.num.signs_25 = 1>
			</cfif>							
			<cfset ao.str.employee_dishonesty = getLocations["EMPLOYEE DISHONESTY YN"][currentrow]>
			<!--- calculate employee dishonsty amount and covert to raps dropdown value --->
			<cfset ed1 = getLocations["ED 10000"][currentrow]>
			<cfset ed2 = getLocations["ED 20000"][currentrow]>
			<cfset ed3 = getLocations["ED 25000"][currentrow]>
			<cfset ao.str.employee_dishonesty_id = convertED(ed1,ed2,ed3)>
			<!---Workers Comp stuff--->
			<cfset wcfield1 = getLocations["OWNER/OFFICER NAME OWNERSHIP"][currentrow]>
			<cfset wcfield2 = getLocations["OWNER OFFICER ANN PAYROLL"][currentrow]>
			<cfset wcfield3 = getLocations["WC ANNPAYROLL"][currentrow]>
			<cfif trim(wcfield1) neq ''>
				<cfset ao.str.notes = "#ao.str.notes# &##013;&##010;WC OWNER/OFFICER NAME OWNERSHIP: #wcfield1#, OWNER OFFICER ANN PAYROLL: #wcfield2#, WC ANNPAYROLL: #wcfield3#">
			</cfif>	

			
		    <cfset result = MigrateToRaps( "applications", ao, forceinsert ) />
		</cfif>
		</cfloop>
            <cfset migratedlocations = getlocations.recordcount - failedlocations>
			        <cffile action="append" file="#expandPath('.')#\migration.txt" output="#DateFormat(now(), 'mm/dd/yyyy')# #timeFormat(now())# - Client info was not found for #failedlocations# locations. #migratedlocations# applications should have been migrated.">		
		<cfcatch type="any">
			<cfset result = "#cfcatch.Message# - #cfcatch.Detail#" />
			<cffile action="append" file="#expandPath('.')#\migration.txt" output="#result#">            
		</cfcatch>
	</cftry>
	<cfreturn result />
	</cffunction>		
	<cffunction name="ratingUpdate" returntype="any" output="true">
    <cfargument name="history" default="0">
    <cfargument name="clientid" default="0">
	<cfparam name="result" default="success" />

	<cfset getLocations = Locations(clientid=arguments.clientid)>


	<cftry>
		<cfloop query="getLocations">
			<cfif ARGUMENTS.history eq 0>
       	    <cfset forceinsert = 0>   
            <cfelse>
            <cfset forceinsert = 1>
            </cfif> 
		<cfset ao = CreateAccessObject() />
		<cfset ClientInfo = getClientInfo(ClientID)>
		<cfset AppInfo = getAppInfo(locid,arguments.history)>
		<cfset LocInfo = getLocationInfo(locid)>
		<cfif ClientInfo.recordcount>
		    <cfset ao.num.gym_id = getLocations.locid />
        	<cfset ao.num.history = ARGUMENTS.history />
			<cfset ao.num.application_id = AppInfo.application_id />
			<cfset ao.num.location_id = LocInfo.location_id />
			<cfset ao.num.liability_plan_id = getLiabilityPlan(getLocations["PLAN##"][currentrow]) />
			<cfset ao.num.property_plan_id = getPropertyPlan(getLocations["BCO"][currentrow]) />
			<cfset ao.num.state_id = LocInfo.state_id />
			<cfset ao.str.square_footage = getLocations["SQ FOOTAGE"][currentrow]>
			<cfset ao.str.gross_receipts = getLocations["GROSS RECPTS"][currentrow]>
			<cfset ao.num.excl_proposal = getLocations["Exclude from Proposal"][currentrow] />
			<!---gl_issuing_company_id--->
			<!---property_issuing_company_id--->
			<!---rating_liability_id--->
			<!---rating_property_id--->
			<!---endorsement_id--->
			<cfset ao.savedatetime = getLocations["Entered Date"][currentrow] >
			<!---user_id--->
			<cfif ARGUMENTS.history eq 1>
			<cfset ao.str.historynotes = "GYM rating migration">
            </cfif>
			<!---endorse--->
			
		    <cfset result = MigrateToRaps( "rating", ao, forceinsert ) />
		</cfif>
		</cfloop>
		
		<cfcatch type="any">
			<cfset result = "#cfcatch.Message# - #cfcatch.Detail#" />
		</cfcatch>
	</cftry>
	<cfreturn result />
	</cffunction>
	<cffunction name="ratingGLUpdate" returntype="any" output="true">
    <cfargument name="history" default="0">
    <cfargument name="clientid" default="0">
	<cfparam name="URL.LocID" default="0">
	<cfparam name="result" default="success" />
    

	<cfset getLocations = Locations(LocID=URL.LocID,clientid=arguments.clientid)>


	<cftry>
		<cfloop query="getLocations">
        <cfif ARGUMENTS.history eq 0>
            <cfset forceinsert = 0>
        <cfelse>
            <cfset forceinsert = 1>
        </cfif>      
            
		<cfset ao = CreateAccessObject() />
		<cfset ClientInfo = getClientInfo(ClientID)>
		<cfset RatingInfo = getRatingInfo(gym_id=getLocations.locid,history=arguments.history)>
		
		<cfif ClientInfo.recordcount AND RatingInfo.recordcount>
		    <cfset ao.num.gym_id = getLocations.locid />
			<cfset ao.num.ratingid = RatingInfo.ratingid />
			<cfset ao.num.gl_deductable = val(getLocations["GL Deductible"][currentrow])>
			<cfset ao.num.base_rate_annual = val(getLocations["Loc Base"][currentrow])>
			<cfset ao.num.instructors_expo = val(getLocations["## Instructors"][currentrow])>
			<cfset ao.num.instructors_base = val(getLocations["Prem-Instructor Base"][currentrow])>
			<cfset ao.num.instructors_annual = ao.num.instructors_expo * ao.num.instructors_base>
			<cfset ao.num.basketball_expo = val(getLocations["## BASKETBALL COURTS"][currentrow])>
			<cfset ao.num.basketball_base = val(getLocations["Prem-Courts Base"][currentrow])>
			<cfset ao.num.basketball_annual = ao.num.basketball_expo * ao.num.basketball_base>
			<cfset ao.num.rt_courts_expo = val(getLocations["## RACQUETBALL COURTS"][currentrow])>
			<cfset ao.num.rt_courts_base = val(getLocations["Prem-Courts Base"][currentrow])>
			<cfset ao.num.rt_courts_annual = ao.num.rt_courts_expo * ao.num.rt_courts_base>
			<cfset ao.num.tennis_courts_expo = val(getLocations["## TENNIS COURTS"][currentrow])>
			<cfset ao.num.tennis_courts_base = val(getLocations["Prem-Courts Base"][currentrow])>
			<cfset ao.num.tennis_courts_annual = ao.num.tennis_courts_expo * ao.num.tennis_courts_base>
			<cfset ao.num.sauna_expo = 0>
			<cfset ao.num.sauna_base = val(getLocations["Prem-Steam Base"][currentrow])>
			<cfset ao.num.sauna_annual = ao.num.sauna_expo * ao.num.sauna_base>
			<cfset ao.num.steamroom_expo = val(getLocations["## STEAM"][currentrow])>
			<cfset ao.num.steamroom_base = val(getLocations["Prem-Steam Base"][currentrow])>
			<cfset ao.num.steamroom_annual = ao.num.steamroom_expo * ao.num.steamroom_base>			
			<cfset ao.num.whirlpool_expo = val(getLocations["## LAPPOOLS"][currentrow])>
			<cfset ao.num.whirlpool_base = val(getLocations["Prem-Jacuzzi Base"][currentrow])>
			<cfset ao.num.whirlpool_annual = ao.num.whirlpool_expo * ao.num.whirlpool_base>
			<cfset ao.num.pools_expo = val(getLocations["## LAPPOOLS"][currentrow])>
			<cfset ao.num.pools_base = val(getLocations["Prem-Pool Base"][currentrow])>
			<cfset ao.num.pools_annual = ao.num.pools_base * ao.num.pools_expo>
			<cfset ao.num.tanning_expo = val(getLocations["## TANNING"][currentrow])>
			<cfset ao.num.tanning_base = val(getLocations["Prem-Tanning Base"][currentrow])>
			<cfset ao.num.tanning_annual =  ao.num.tanning_expo *  ao.num.tanning_base>
			<cfset ao.num.childsitting_expo = val(getLocations["## Day Care"][currentrow])>
			<cfset ao.num.childsitting_base = val(getLocations["Prem-Day Care Base"][currentrow])>
			<cfset ao.num.childsitting_annual = ao.num.childsitting_expo * ao.num.childsitting_base>
			<!---how to handle phys therapy, martial arts, massage, misc?--->
			<cfset ao.num.total_mod = (val(getLocations["LIAB MOD 2"][currentrow])+val(getLocations["AFF/NON DEBIT"][currentrow]))+(val(getLocations["LIABILITY MOD FACTOR"][currentrow]))>
			<cfset ao.num.total_annual = val(getLocations["Total Prem $"][currentrow])>
			<cfset ao.num.rpgfee = val(getLocations["Fee Agency $"][currentrow])>
			<cfset ao.num.rpgall = totalRPG(ClientID)>
			<cfset ao.num.loc_annual_premium = val(getLocations["Liability Prem This Loc"][currentrow])>
			<cfset ao.num.broker_percentoverride = val(getLocations["Broker%"][currentrow])>
			<cfset ao.num.brokerfee = val(getLocations["Fee Broker $"][currentrow])>
			<cfset ao.num.surplustax = val(getLocations["Tax $"][currentrow])>
			<cfset ao.num.inspectionfee = val(getLocations["Insepection Charge $"][currentrow])>
			<cfset ao.num.terrorism_fee = val(getLocations["Terrorism Fee"][currentrow])>
			<cfset ao.num.terrorism_rejected = val(getLocations["Terrorism Rejected"][currentrow])>			
			<cfset ao.num.stampingfee = val(getLocations["Stamping Fee"][currentrow])>
			<cfset ao.num.filingfee = val(getLocations["Fee Filing $"][currentrow])>
			<cfset ao.num.statecharge = val(getLocations["State Surcharge $"][currentrow]) + val(getLocations["Muni Surcharge $"][currentrow])>
			<cfset ao.num.grandtotal = val(getLocations["Grand Total"][currentrow])>
            <cfif trim(getLocations["Liab Add Eff"][currentrow]) neq '' AND trim(getLocations["Liab Can Eff"][currentrow]) neq ''>
				<cfset ao.str.gldate1 = dateFormat(getLocations["Liab Add Eff"][currentrow]) >
				<cfset ao.str.gldate2 = dateFormat(getLocations["Liab Can Eff"][currentrow]) >
            <cfelse>
				<cfif trim(ClientInfo.current_effective_date) neq''>
                	<cfset ao.str.gldate1 = dateFormat(ClientInfo.current_effective_date) >
                	<cfset ao.str.gldate2 =  dateFormat(dateAdd("d",365,ao.str.gldate1))>  
                </cfif>          
            </cfif>
            <cfif isDefined("ao.str.gldate1")>
            <cfset days = dateDiff("d",ao.str.gldate1,ao.str.gldate2)>
			<cfset ao.num.gl_prorate = numberFormat(days / 365,"0.000")>
            <cfset ao.num.pro_rata_gl = ao.num.loc_annual_premium * ao.num.gl_prorate> 
            </cfif>
			<!---<cfset ao.num.gl_prorate = val(getLocations["PR Liab"][currentrow])>--->
			          
			<cfset ao.str.yesnoquestions = '#getLocations["NOTES"][currentrow]# &##013;&##010;#getLocations["Other Amenities"][currentrow]#' >
			<cfset ao.str.underwriting_notes = getLocations["OTHER EXPOSURE"][currentrow]>
            <cfif trim(getLocations["Misc 1 Desc"][currentrow]) neq ''>
            <cfset ao.str.underwriting_notes = '#ao.str.underwriting_notes# &##013;&##010;#getLocations["Misc 1 Desc"][currentrow]# - #dollarFormat(getLocations["m1"][currentrow])#'>
			</cfif>
            <cfif trim(getLocations["Misc 2 Desc"][currentrow]) neq ''>
            <cfset ao.str.underwriting_notes = '#ao.str.underwriting_notes# &##013;&##010;#getLocations["Misc 2 Desc"][currentrow]# - #dollarFormat(getLocations["m2"][currentrow])#'>
			</cfif> 
            <cfif trim(getLocations["Liab Misc 4 Desc"][currentrow]) neq ''>
            <cfset ao.str.underwriting_notes = '#ao.str.underwriting_notes# &##013;&##010;#getLocations["Liab Misc 4 Desc"][currentrow]# - #dollarFormat(getLocations["m4"][currentrow])#'>
			</cfif> 
            <cfif trim(getLocations["Liab Misc 5 Desc"][currentrow]) neq ''>
            <cfset ao.str.underwriting_notes = '#ao.str.underwriting_notes# &##013;&##010;#getLocations["Liab Misc 5 Desc"][currentrow]# - #dollarFormat(getLocations["m5"][currentrow])#'>
			</cfif>  
            <cfif trim(getLocations["Liab Misc 6 Desc"][currentrow]) neq ''>
            <cfset ao.str.underwriting_notes = '#ao.str.underwriting_notes# &##013;&##010;#getLocations["Liab Misc 6 Desc"][currentrow]# - #dollarFormat(getLocations["m6"][currentrow])#'>
			</cfif>                                              
		    <cfset result = MigrateToRaps( "rating_liability", ao, forceinsert ) />
		</cfif>
		</cfloop>
		
		<cfcatch type="any">
			<cfset result = "#cfcatch.Message# - #cfcatch.Detail#" />
		</cfcatch>
	</cftry>
	<cfreturn result />
	</cffunction>	
	<cffunction name="ratingPropUpdate" returntype="any" output="true">
    <cfargument name="history" default="0">
    <cfargument name="clientid" default="0">
	<cfparam name="URL.LocID" default="0">
	<cfparam name="result" default="success" />
    

	<cfset getLocations = Locations(LocID=URL.LocID,clientid=arguments.clientid)>


	<cftry>
		<cfloop query="getLocations">
        <cfif ARGUMENTS.history eq 0>
            <cfset forceinsert = 0>
        <cfelse>
        	<cfset forceinsert = 1>
        </cfif>          
		<cfset ao = CreateAccessObject() />
		<cfset ClientInfo = getClientInfo(ClientID)>
		<cfset RatingInfo = getRatingInfo(gym_id=getLocations.locid,history=arguments.history)>
		<cfset LocOtherInfo = getLocationsOther(locid)>
		<cfif ClientInfo.recordcount>
		    <cfset ao.num.gym_id = getLocations.locid />
			<cfset ao.num.ratingid = RatingInfo.ratingid />
			<cfset ao.str.prop_underwritingnotes = getLocations["Manual Property Details"][currentrow]>
			<cfset ao.num.prop_deductible = val(getLocations["Prop All Other Ded"][currentrow])>
			<cfset ao.num.prop_agencyfee = val(getLocations["Agency Fee"][currentrow])>
			<cfset ao.str.prop_winddeductable = getLocations["Prop Wind Ded"][currentrow]>
			<cfset ao.num.prop_exclwind = val(getLocations["Wind Excluded YN"][currentrow])>
			<cfset ao.num.prop_buildingrate = val(getLocations["Bldg Rate"][currentrow])>
			<cfset ao.num.prop_buildinglimit = val(getLocations["Bldg Limit"][currentrow])>
			<cfset ao.num.prop_buildingpremium = val(getLocations["Bldg Prem"][currentrow])>
			<cfset ao.num.prop_bpprate = val(getLocations["BPP Rate"][currentrow])>
			<cfset ao.num.prop_bpplimit = val(getLocations["BPP Limit"][currentrow])>
			<cfset ao.num.prop_bpppremium = val(getLocations["BPP Prem"][currentrow])>
			<cfset ao.num.prop_bieerate = val(getLocations["BI/EE Rate"][currentrow])>
			<cfset ao.num.prop_bieelimit = val(getLocations["BI/EE Limit"][currentrow])>
			<cfset ao.num.prop_bieepremium = val(getLocations["BI/EE Prem"][currentrow])>			
			<cfset ao.num.prop_90 = val(getLocations["Work Comp YN"][currentrow])>	
			<cfset ao.num.prop_signrate = val(getLocations["Sign Rate"][currentrow])>
			<cfset ao.num.prop_signlimit = val(getLocations["Sign 25k+"][currentrow])>
			<cfset ao.num.prop_signpremium = val(getLocations["Sign Prem"][currentrow])>						
		    <cfset ao.num.prop_daysdeductible = val(getLocations["Prop Assessment"][currentrow]) * 24>
			<cfif LocOtherInfo.recordcount>
			<cfset ao.num.prop_edplimit = val(LocOtherInfo["EDP Limit"][1])>
			<cfset ao.num.prop_edppremium = val(LocOtherInfo["EDP Prem"][1])>
				<cfif ao.num.prop_edppremium neq 0 AND ao.num.prop_edplimit neq 0>
				<cfset ao.num.prop_edprate = ao.num.prop_edppremium / ao.num.prop_edplimit * 100>
				</cfif>
			<cfset ao.num.prop_floodlimit = val(LocOtherInfo["Flood Limit"][1])>
			<cfset ao.num.prop_floodpremium = val(LocOtherInfo["Flood Prem"][1])>
			<cfset ao.num.prop_flooddeduct = val(LocOtherInfo["Flood Deductible"][1])>
				<cfif ao.num.prop_floodpremium neq 0 AND ao.num.prop_floodlimit neq 0>
				<cfset ao.num.prop_floodrate = ao.num.prop_floodpremium / ao.num.prop_floodlimit * 100>
				</cfif>
			<cfset ao.num.prop_quakelimit = val(LocOtherInfo["Quake Limit"][1])>
			<cfset ao.num.prop_quakepremium = val(LocOtherInfo["Quake Prem"][1])>
			<cfset ao.num.prop_quakededuct = val(LocOtherInfo["Quake Ded"][1])>
				<cfif ao.num.prop_quakepremium neq 0 AND ao.num.prop_quakelimit neq 0>
				<cfset ao.num.prop_quakerate = ao.num.prop_quakepremium / ao.num.prop_quakelimit * 100>
				</cfif>	

			<!---Other Coverages covert to raps--->		
				<cfif trim(LocOtherInfo["OTHER 1 DESC"][1]) neq ''>

					<cfset OtherDesc = trim(LocOtherInfo["OTHER 1 DESC"][1])>
					<cfset OtherLimit = val(LocOtherInfo["OTHER 1 Limit"][1])>
					<cfset OtherPrem = val(LocOtherInfo["OTHER 1 Prem"][1])>
					<cfset OtherDed = val(LocOtherInfo["OTHER 1 Ded"][1])>
					<cfset fields = convertField(OtherDesc=OtherDesc,OtherLimit=OtherLimit,OtherPrem=OtherPrem,OtherDed=OtherDed)>
					
					<cfif structKeyExists(fields,'num')>
					<cfset structAppend(ao.num,fields.num)>
					</cfif>
					<cfif structKeyExists(fields,'str')>
					<cfset structAppend(ao.str,fields.str)>
					</cfif>
					<cfif structKeyExists(fields,'notes')>
					<cfset ao.str.prop_underwritingnotes = "#ao.str.prop_underwritingnotes# &##013;&##010;#fields.notes#">
					</cfif>					
				</cfif>	
				<cfif trim(LocOtherInfo["OTHER 2 DESC"][1]) neq ''>

					<cfset OtherDesc = trim(LocOtherInfo["OTHER 2 DESC"][1])>
					<cfset OtherLimit = val(LocOtherInfo["OTHER 2 Limit"][1])>
					<cfset OtherPrem = val(LocOtherInfo["OTHER 2 Prem"][1])>
					<cfset OtherDed = val(LocOtherInfo["OTHER 2 Ded"][1])>
					<cfset fields = convertField(OtherDesc=OtherDesc,OtherLimit=OtherLimit,OtherPrem=OtherPrem,OtherDed=OtherDed)>
				
					<cfif structKeyExists(fields,'num')>
					<cfset structAppend(ao.num,fields.num)>
					</cfif>
					<cfif structKeyExists(fields,'str')>
					<cfset structAppend(ao.str,fields.str)>
					</cfif>
					<cfif structKeyExists(fields,'notes')>
					<cfset ao.str.prop_underwritingnotes = "#ao.str.prop_underwritingnotes# &##013;&##010;#fields.notes#">
					</cfif>					
				</cfif>	
				<cfif trim(LocOtherInfo["OTHER 3 DESC"][1]) neq ''>

					<cfset OtherDesc = trim(LocOtherInfo["OTHER 3 DESC"][1])>
					<cfset OtherLimit = val(LocOtherInfo["OTHER 3 Limit"][1])>
					<cfset OtherPrem = val(LocOtherInfo["OTHER 3 Prem"][1])>
					<cfset OtherDed = val(LocOtherInfo["OTHER 3 Ded"][1])>
					<cfset fields = convertField(OtherDesc=OtherDesc,OtherLimit=OtherLimit,OtherPrem=OtherPrem,OtherDed=OtherDed)>
				
					<cfif structKeyExists(fields,'num')>
					<cfset structAppend(ao.num,fields.num)>
					</cfif>
					<cfif structKeyExists(fields,'str')>
					<cfset structAppend(ao.str,fields.str)>
					</cfif>
					<cfif structKeyExists(fields,'notes')>
					<cfset ao.str.prop_underwritingnotes = "#ao.str.prop_underwritingnotes# &##013;&##010;#fields.notes#">
					</cfif>					
				</cfif>															
			</cfif>
			<cfset ao.num.prop_equipbreakrate = val(getLocations["Breakdown %"][currentrow])>
			<cfset ao.num.prop_equipbreakpremium = val(getLocations["Chg Prop EB"][currentrow])>
			<cfif getLocations["Employee Dishonesty YN"][currentrow] eq 1>
			<cfset ed1 = getLocations["ED 10000"][currentrow]>
			<cfset ed2 = getLocations["ED 20000"][currentrow]>
			<cfset ed3 = getLocations["ED 25000"][currentrow]>
			<cfset ao.num.employee_dishonesty_id = convertED(ed1,ed2,ed3)>
			</cfif>
			<cfset ao.num.prop_terrorism_rejected = val(getLocations["Terrorism rejected YN"][currentrow])>
			<cfset ao.num.prop_terrorism = val(getLocations["Terr Prem"][currentrow])>
			<cfset ao.num.prop_ratedpremium = val(getLocations["Chg Prop Prem"][currentrow])>
			<cfset ao.num.prop_chargedpremium = val(getLocations["Mod Prem"][currentrow])>
            <cfset ao.num.prop_agencyamount = (ao.num.prop_agencyfee / 100) * ao.num.prop_chargedpremium>
			<cfset ao.num.premium_override = val(getLocations["Manual Property YN"][currentrow])>
			
            <cfif trim(getLocations["Prop Add Date"][currentrow]) neq '' AND trim(getLocations["Prop Can Date"][currentrow]) neq ''>
				<cfset ao.str.propdate1 = getLocations["Prop Add Date"][currentrow]>
				<cfset ao.str.propdate2 = getLocations["Prop Can Date"][currentrow]>
            <cfelse>
				<cfif trim(ClientInfo.current_effective_date) neq''>
                <cfset ao.str.propdate1 = dateFormat(ClientInfo.current_effective_date) >
                <cfset ao.str.propdate2 =  dateFormat(dateAdd("d",365,ao.str.propdate1))>  
                </cfif>          
            </cfif>     
            <cfif isDefined("ao.str.propdate1")>
            <cfset days = dateDiff("d",ao.str.propdate1,ao.str.propdate2)>
			<cfset ao.num.prop_prorate = numberFormat(days / 365,"0.000")>   
            </cfif>  
              
			<cfset ao.num.prop_taxes = val(getLocations["Prop State Surch"][currentrow]) +
									   val(getLocations["Prop Muni Surch"][currentrow]) +
									   val(getLocations["FL SL Tax"][currentrow]) +
									   val(getLocations["FL Stamp"][currentrow]) +
									   val(getLocations["FL Asmt"][currentrow])>

            
			<cfset ao.str.prop_grandtotal = val(getLocations["MOD PREM"][currentrow])+val(getLocations["MOD FEE"][currentrow])+val(getLocations["Equip Break Prem Unmod"][currentrow])+val(getLocations["ED PREM"][currentrow])+val(getLocations["prop state surch"][currentrow])+val(getLocations["prop muni surch"][currentrow])+val(getLocations["fl sl tax"][currentrow])+val(getLocations["fl stamp"][currentrow])+val(getLocations["fl asmt"][currentrow])>
			<cfif getLocations["bco"][currentrow] eq "ONE">
            <cfset extraamount = (val(getLocations["mod prem"][currentrow]) + val(getLocations["equip break prem unmod"][currentrow]))*0.03 >
            <cfset ao.str.prop_grandtotal = ao.str.prop_grandtotal + extraamount>
            </cfif>


			<cfset result = MigrateToRaps( "rating_property", ao, forceinsert ) />
		</cfif>
		</cfloop>
		
		<cfcatch type="any">
			<cfset result = "#cfcatch.Message# - #cfcatch.Detail#" />
		</cfcatch>
	</cftry>
	<cfreturn result />
	</cffunction>	
  <cffunction name="policyIssuingCheck" output="true" returntype="array">
  	<cfquery datasource="Gym" name="getGymPolicies">
    select * 
    from "0-POL INFO"
    </cfquery>
    <cfset notfoundarray = arrayNew(1)>
    <cfloop query="getGymPolicies">
    	<cfset ClientInfo = getClientInfo(ClientID)>
			<cfif ClientInfo.recordcount>
      	<cfset issuing_company_id = getIssuing(getGymPolicies["ISSUING CO NAME"][currentrow])>
        	<cfif issuing_company_id eq 0>
          <cfset arrayAppend(notfoundarray,getGymPolicies["ISSUING CO NAME"][currentrow])>
      </cfif>
      </cfif>
    </cfloop>
    <cfreturn notfoundarray />
  </cffunction>
	<cffunction name="policyUpdate" returntype="any" output="yes">
  <cfargument name="startrow" default="1">
  <cfargument name="endrow" default="0">
	<cfargument name="ClientID" default="0">
	
	<cfparam name="result" default="success" />
    
	<cfquery datasource="Gym" name="getGymPolicies">
    select * 
    from "0-POL INFO"
    where 1=1
    <cfif arguments.ClientID neq 0>
    AND ClientID = #arguments.ClientID#
    </cfif>
    </cfquery>
    <cfif arguments.endrow eq 0>
    <cfset end = getGymPolicies.recordcount>
    <cfelse>
    <cfset end = arguments.endrow>
    </cfif>
<!---END: #end# TOTAL POLICIES: #getGymPolicies.recordcount#--->
	<cftry>
  
		<cfloop query="getGymPolicies" startrow="#arguments.startrow#" endrow="#end#">

		    <cfset ao = CreateAccessObject() />
		<cfset ClientInfo = getClientInfo(getGymPolicies.ClientID)>

		<cfif ClientInfo.recordcount>
    client found<br><br>
		    <cfset ao.num.gym_id = polid />
			<cfset ao.num.client_id = ClientInfo.client_id />
			<cfset ao.str.policy_effectivedate = getGymPolicies["EFF"][currentrow]>
            <cfset ao.str.policy_expiredate = getGymPolicies["EXP"][currentrow]>
            <cfset ao.str.policy_canceldate = getGymPolicies["CAN"][currentrow]>
            <cfset ao.num.policy_status_id = convertPolicyStatus(getGymPolicies["POL STATUS 1 2 3"][currentrow])>
            <cfset ao.num.issuing_company_id = getIssuing(getGymPolicies["ISSUING CO NAME"][currentrow])>
            <cfset ao.num.policy_type_id = getPolicyType(getGymPolicies["TYPE"][currentrow])>
            <cfset ao.str.policy_number = getGymPolicies["POL##"][currentrow]>
         


			<cfset result = MigrateToRaps( "policy_info", ao ) />
      <cfelse>
      Client not found <br>
		</cfif>
		</cfloop>
		
		<cfcatch type="any">
			<cfset result = "#cfcatch.Message# - #cfcatch.Detail#" />
		</cfcatch>
	</cftry>
	<cfreturn result />
	</cffunction>	    
	<cffunction name="otherLOCUpdate" returntype="any" output="true">
	<cfargument name="ClientID" default="0">
	
	<cfparam name="result" default="success" />
    
	<cfquery datasource="Gym" name="getOtherLOC">
    select * 
    from "0-Other Lines of Business"
    where 1=1
    <cfif arguments..ClientID neq 0>
    AND ClientID = #arguments..ClientID#
    </cfif>
    </cfquery>

	<cftry>
		<cfloop query="getOtherLOC">
		    <cfset ao = CreateAccessObject() />
		<cfset ClientInfo = getClientInfo(ClientID)>

		<cfif ClientInfo.recordcount>
    <cfset ao.str.ue_notes = "">
		    <cfset ao.num.gym_id = ClientID />
        <!---UE and Excess are combined in Raps but not in GYM. Need to eval effective dates to see which to use--->
        <cfset date1 = trim(getOtherLOC["UMB EFF"][currentrow])>
        <cfset date2 = trim(getOtherLOC["XS EFF"][currentrow])>
        <cfif date1 neq '' and date2 neq ''>
        <cfset whichone = dateCompare(getOtherLOC["UMB EFF"][currentrow],getOtherLOC["XS EFF"][currentrow])>
        <cfelseif date1 neq ''>
        <cfset whichone = 1>
        <cfelseif date2 neq ''>
        <cfset whichone = -1>
        <cfelse>
        <cfset whichone = -1>
        </cfif>
        <!---if whichone is 1 use UMB, otherwise Excess--->
        <cfif whichone eq 1>
       		<cfset ao.str.ue_type = "umbrella">
            <!---get gym state abbreviation from slid--->
            <cfset stateabbr = getGymState(slid=val(getOtherLOC["slid"][currentrow]))>
            <!---convert to raps state_id--->
            <cfset ao.num.ue_rate_state = getState(stateabbr)>
			<cfset ao.str.ue_date1 = getOtherLOC["UMB EFF"][currentrow]>
            <cfset ao.str.ue_date2 = getOtherLOC["UMB EXP"][currentrow]>  
            <cfset ao.num.ue_issuing_company = getIssuing(getOtherLOC["UMB ICO"][currentrow])> 
            <cfif ao.num.ue_issuing_company eq 0>
            <cfset ao.str.ue_notes = 'Issuing Company: #getOtherLOC["UMB ICO"][currentrow]#'>
            </cfif>
            <cfset ao.num.ue_occurrence = val(getOtherLOC["UMB OCC"][currentrow])> 
            <cfset ao.num.ue_aggregate = val(getOtherLOC["UMB AGG"][currentrow])>
            <cfset ao.num.ue_retention = val(getOtherLOC["UMB DED"][currentrow])>
            <cfset ao.num.ue_rate_sltax = val(getOtherLOC["Umb Rate SL Tax"][currentrow])>
            <cfset ao.num.ue_sltax = val(getOtherLOC["UMB SL TAX"][currentrow])>
            <cfset ao.num.ue_rate_filingfee = val(getOtherLOC["UMB Rate SL Filing Fee"][currentrow])>
            <cfset ao.num.ue_filingfee = val(getOtherLOC["UMB SL FILING FEE"][currentrow])>
            <cfset ao.num.ue_premium = val(getOtherLOC["UMB PREM"][currentrow])>
            <cfset ao.num.ue_agencyfee = val(getOtherLOC["UMB AGENCY FEE"][currentrow])>
            <cfset ao.num.ue_brokerfee = val(getOtherLOC["Umb Co Fee"][currentrow])>
            <cfset ao.num.ue_rate_stampingfee = val(getOtherLOC["UMB Rate SL Stamping Fee"][currentrow])>
            <cfset ao.num.ue_rate_statesurcharge = val(getOtherLOC["UMB Rate State Surcharge"][currentrow])>
            <cfset ao.num.ue_rate_munisurcharge = val(getOtherLOC["UMB Rate MUNI SURCHARGE"][currentrow])>
            <cfset ao.str.ue_proposalnotes = getOtherLOC["UMB COMMENT"][currentrow]>
            <cfset ao.str.ue_notes = '#ao.str.ue_notes# #getOtherLOC["UMB SL COMMENT"][currentrow]#'>
 
            <!---([umb prem]+[umb co fee]+[umb agency fee]+[UMB SL STAMPING FEE]+[umb sl tax]+[umb sl filing fee]+[umb state surcharge]+[umb muni surcharge])--->  
        <cfelse>
       		<cfset ao.str.ue_type = "excess">
            <!---get gym state abbreviation from slid--->

            <cfset stateabbr = getGymState(slid=val(getOtherLOC["slid"][currentrow]))>
            <!---convert to raps state_id--->
            <cfset ao.num.ue_rate_state = getState(stateabbr)>
			<cfset ao.str.ue_date1 = getOtherLOC["XS EFF"][currentrow]>
            <cfset ao.str.ue_date2 = getOtherLOC["XS EXP"][currentrow]>  
            <cfset ao.num.ue_issuing_company = getIssuing(getOtherLOC["XS ICO"][currentrow])> 
            <cfif ao.num.ue_issuing_company eq 0>
			<cfset ao.str.ue_notes = 'Issuing Company: #getOtherLOC["XS ICO"][currentrow]#'>
            </cfif>
            <cfset ao.num.ue_occurrence = val(getOtherLOC["XS OCC"][currentrow])> 
            <cfset ao.num.ue_aggregate = val(getOtherLOC["XS AGG"][currentrow])>
            <cfset ao.num.ue_retention = val(getOtherLOC["XS DED"][currentrow])>
            <cfset ao.num.ue_rate_sltax = val(getOtherLOC["XS Rate SL Tax"][currentrow])>
            <cfset ao.num.ue_sltax = val(getOtherLOC["XS SL TAX"][currentrow])>
            <cfset ao.num.ue_rate_filingfee = val(getOtherLOC["XS Rate SL Filing Fee"][currentrow])>
            <cfset ao.num.ue_filingfee = val(getOtherLOC["XS SL FILING FEE"][currentrow])>
            <cfset ao.num.ue_premium = val(getOtherLOC["XS PREM"][currentrow])>
            <cfset ao.num.ue_agencyfee = val(getOtherLOC["XS AGENCY FEE"][currentrow])>
            <cfset ao.num.ue_brokerfee = val(getOtherLOC["XS Co Fee"][currentrow])>
            <cfset ao.num.ue_rate_stampingfee = val(getOtherLOC["XS Rate SL Stamping Fee"][currentrow])>
            <cfset ao.num.ue_rate_statesurcharge = val(getOtherLOC["XS Rate State Surcharge"][currentrow])>
            <cfset ao.num.ue_rate_munisurcharge = val(getOtherLOC["XS Rate MUNI SURCHARGE"][currentrow])>
            <cfset ao.str.ue_proposalnotes = getOtherLOC["XS COMMENT"][currentrow]>
            <cfset ao.str.ue_notes = '#ao.str.ue_notes# #getOtherLOC["XS SL COMMENT"][currentrow]#'>                     
        </cfif>
           <cfset ao.num.ue_totalpremium = val(ao.num.ue_premium) + val(ao.num.ue_brokerfee) + val(ao.num.ue_agencyfee) + val(ao.num.ue_sltax) + val(ao.num.ue_filingfee)>
			<!---
			ue_declined
			ue_declinedreason
			--->  clientid = #clientid#<br>
			<!---UE Account consolidation--->
            <cfloop from="1" to="10" index="i">
            <cfset client2 = trim(getOtherLOC["tam0#i#"][currentrow])>
            <cfif client2 neq 0 and client2 neq ''>
            	<cfset client2rapsid = getClientInfo(client2)>
           		<cfif client2rapsid.recordcount>
            		<cfset addC = addConsolidate(table="ue_consolidation",client_id1 = ClientInfo.client_id,client_id2 = client2rapsid.client_id)>
            	</cfif>
            </cfif>
            <cfset client2a = trim(getOtherLOC["tam0#i#a"][currentrow])>
            <cfif client2a neq 0 and client2a neq ''>
            <cfset client2rapsida = getClientInfo(client2a)>
           		<cfif client2rapsida.recordcount>
           			<cfset addCa = addConsolidate(table="ue_consolidation",client_id1 = ClientInfo.client_id,client_id2 = client2rapsida.client_id)>
            	</cfif>
            </cfif>            
            </cfloop>
            
            <!---WC

			wc_totalpremium
			wc_declined
			wc_declinedreason
                   --->
                   <cfset ao.str.wc_notes = "">
            <cfset ao.str.wc_states = getOtherLOC["WC STATE"][currentrow]>
            <cfset ao.str.wc_classcode = getOtherLOC["WC Code"][currentrow]>
			<cfset ao.str.wc_effectivedate = getOtherLOC["WC EFF"][currentrow]>
            <cfset ao.str.wc_expiredate = getOtherLOC["WC EXP"][currentrow]>
            <cfset ao.str.wc_fein = getOtherLOC["FEIN"][currentrow]>
            <cfset ao.num.wc_issuing_company = getIssuing(getOtherLOC["WC ICO"][currentrow])>  
			<cfif ao.num.wc_issuing_company eq 0>
            <cfset ao.str.wc_notes = 'Issuing Company: #getOtherLOC["WC ICO"][currentrow]#'>
            </cfif>            
            <cfset ao.num.wc_rate = val(getOtherLOC["WC Rate Per $100 Payroll"][currentrow])>
            <cfset ao.num.wc_eachaccident = val(getOtherLOC["WC EA ACCIDENT"][currentrow])>
            <cfset ao.num.wc_diseaseeach = val(getOtherLOC["WC DISEASE EMPL"][currentrow])>
            <cfset ao.num.wc_diseaselimit = val(getOtherLOC["WC DISEASE POL LIM"][currentrow])>
            <cfset ao.num.wc_premium = val(getOtherLOC["WC PREM"][currentrow])>
            <cfset ao.num.wc_payroll = val(getOtherLOC["TOTAL EMPLOYEE PAYROLL"][currentrow])>
            <cfset ao.num.wc_fulltime = val(getOtherLOC["## EMPL FULL"][currentrow])>
            <cfset ao.num.wc_partime = val(getOtherLOC["## EMPL PART"][currentrow])>
            <cfset ao.num.wc_totalemployees = ao.num.wc_fulltime + ao.num.wc_partime>
            <cfset ao.num.wc_agencyfee = val(getOtherLOC["WC Agency Fee"][currentrow])>
            <cfset ao.str.wc_proposalnotes = getOtherLOC["WC COMMENT"][currentrow]>
            <cfset ao.str.wc_notes = '#ao.str.wc_notes# #getOtherLOC["WC Claims Describe"][currentrow]#'>
            <!---wc owner info--->
            <cfloop from="1" to="5" index="i">
            <cfset wc.owner_name = trim(getOtherLOC["OWNER #i# NAME"][currentrow])>
            <cfif wc.owner_name neq "">
				<cfset wc.owner_title = trim(getOtherLOC["OWNER #i# TITLE"][currentrow])>
                <cfset wc.owner_percent = val(getOtherLOC["OWNER #i# %"][currentrow])>
                <cfset wc.owner_salary = val(getOtherLOC["OWNER #i# SALARY"][currentrow])>
                <cfset wc.owner_include = getOtherLOC["OWNER #i# INCLUDE"][currentrow]>
                <cfset wc.owner_exclude = getOtherLOC["OWNER #i# EXCLUDE"][currentrow]>  
                <cfset addWCOwners(client_id=ClientInfo.client_id,
                                   owner_name=wc.owner_name,
                                   owner_title=wc.owner_title,
                                   owner_percent=wc.owner_percent,
                                   owner_salary=wc.owner_salary,
                                   owner_include=wc.owner_include,
                                   owner_exclude=wc.owner_exclude)>
            </cfif>
            
            </cfloop>                   
            
            
            <!---EPL

			epli_fulltime
			epli_partime
			epli_totalemployees
			epli_declined
			epli_declinedreason
			epli_notes
			--->
      <cfset ao.str.epli_notes = "">
			<cfset ao.str.epli_date1 = getOtherLOC["EPL EFF"][currentrow]>
            <cfset ao.str.epli_date2 = getOtherLOC["EPL EXP"][currentrow]>
            <cfset ao.str.epli_retrodate = getOtherLOC["EPL RETRO DATE"][currentrow]>  
            <cfset ao.num.epli_issuing_company = getIssuing(getOtherLOC["EPL Issuing Co"][currentrow])>
			<cfif ao.num.epli_issuing_company eq 0>
            <cfset ao.str.epli_notes = 'Issuing Company: #getOtherLOC["EPL Issuing Co"][currentrow]#'>
            </cfif>            
            <cfset ao.num.epli_aggregate = val(getOtherLOC["EPL AGGREGATE"][currentrow])>
            <cfset ao.num.epli_retention = val(getOtherLOC["EPL DED"][currentrow])>
            <cfset ao.num.epli_aggregate2 = val(getOtherLOC["D&O AGGREGATE"][currentrow])>
            <cfset ao.num.epli_retention2 = val(getOtherLOC["D&O DED"][currentrow])>
            <cfset ao.num.epli_brokerfee = val(getOtherLOC["EPL CO FEE"][currentrow])>
            <cfset ao.num.epli_agencyfee = val(getOtherLOC["EPL AGENCY FEE"][currentrow])>
            <cfset ao.num.epli_sltax = val(getOtherLOC["EPL SL TAX"][currentrow])>
            <cfset ao.num.epli_filingfee = val(getOtherLOC["EPL SL FILING FEE"][currentrow])>
            <cfset ao.num.epli_doincluded = val(getOtherLOC["D&O YN"][currentrow])>
            <cfset ao.num.epli_premium = val(getOtherLOC["EPL PREM"][currentrow])>
            <cfset ao.str.epli_notes = '#ao.str.epli_notes# #getOtherLOC["EPL DO COMMENT"][currentrow]#'>  
            <!--- stamping, state, muni don't exist anymore in raps, but for initial migration we need to include them in the total premium calculation because that's what gym did --->
            <cfset ao.num.epli_totalpremium  = ao.num.epli_premium + ao.num.epli_agencyfee + ao.num.epli_sltax + ao.num.epli_filingfee + ao.num.epli_brokerfee + val(getOtherLOC["epl SL STAMPING FEE"][currentrow]) + val(getOtherLOC["epl state surcharge"][currentrow]) + val(getOtherLOC["epl muni surcharge"][currentrow])>
            
            <!---=([epl prem]+[epl co fee]+[epl agency fee]+[epl SL STAMPING FEE]+[epl sl tax]+[epl sl filing fee]+[epl state surcharge]+[epl muni surcharge])--->       
			<!---EPLI Account consolidation--->
            <cfloop from="1" to="10" index="i">
            <cfset client2 = trim(getOtherLOC["tame#i#"][currentrow])>
            <cfif client2 neq 0 and client2 neq ''>
            	<cfset client2rapsid = getClientInfo(client2)>
           		<cfif client2rapsid.recordcount>
            		<cfset addC = addConsolidate(table="epli_consolidation",client_id1 = ClientInfo.client_id,client_id2 = client2rapsid.client_id)>
            	</cfif>
            </cfif>           
            </cfloop>
            
			<cfset result = MigrateToRaps( "clients", ao ) />
		</cfif>
		</cfloop>
		
		<cfcatch type="any">
			<cfset result = "#cfcatch.Message# - #cfcatch.Detail#" />
		</cfcatch>
	</cftry>
	<cfreturn result />
	</cffunction>	        
	<cffunction name="CreateAccessObject">
		<cfset ao = structNew() />
		<cfset ao["str"] = structNew() />
		<cfset ao["num"] = structNew() />
		<cfreturn ao />
	</cffunction>
    <cffunction name="formatPhone" returntype="string">
    <cfargument name="phone" required="yes">
    <cfset CleanPhoneNumber = REReplace(ARGUMENTS.phone, "[^0-9]", "", "ALL") />
		<cfif len(CleanPhoneNumber) EQ 10>
        	<cfset result = "(#left(CleanPhoneNumber,3)#) #mid(CleanPhoneNumber,4,3)#-#right(CleanPhoneNumber,4)#" />  
        <cfelse>
        	<cfset result = ARGUMENTS.phone>  
        </cfif>
        <cfreturn result />
    </cffunction>
	<cffunction name="getState" returntype="numeric">
		<cfargument name="StateAbbr" type="string" required="yes">
		<cfquery name="data">
		select state_id
		from states
		where name = '#trim(ARGUMENTS.StateAbbr)#'
		</cfquery>
		<cfif data.recordcount>
		<cfset result = data.state_id>
		<cfelse>
		<cfset result = 0>
		</cfif>
		<cfreturn result />
	</cffunction>
    <cffunction name="getGymState" returntype="string">
    <cfargument name="slid" required="yes">
    <cfquery datasource="gym" name="data">
    select state
    from "LU State Tier Factors1"
    where slid = #arguments.slid#
    </cfquery>
    <cfif data.recordcount>
    <cfset result = data.state>
    <cfelse>
    <cfset result = "unknown">
	</cfif>
    <cfreturn result />
    </cffunction>
	<cffunction name="getClients" returntype="query">
		<cfargument name="ClientID" default="0">
    <cfargument name="orderBy" default="">
    <cfargument name="limitByStatus" default="true">

        <cfset newdate = dateAdd("m", -12, now())>
        <cfquery name="data" datasource="Gym">
            select * from "0-MAIN CLIENT SCREEN"
            where 1=1 
            <cfif ARGUMENTS.ClientID neq 0>
            and ClientID = #ARGUMENTS.ClientID#
			<cfelse>
      <cfif arguments.limitByStatus eq true>
            and "Client Status 1 2 3" = 2
            OR ("Client Status 1 2 3" = 1
            	AND "Proposed Eff Date" > <cfqueryparam cfsqltype="cf_sql_date" value="#newdate#">)
       </cfif>
       AND "TAM CLIENT##" <> ''
			</cfif>
      <cfif arguments.orderBy neq ''>
      ORDER BY #arguments.orderBy# asc
      </cfif>
        </cfquery> 
		<cfreturn data />
	</cffunction>    
	<cffunction name="Locations" returntype="query">
		<cfargument name="LocID" default="0">
    <cfargument name="clientid" default="0">
		<cfquery name="data" datasource="Gym">
		select * from "0-LOC INFO"
    where 1=1
		<cfif ARGUMENTS.LocID neq 0>
		and LocID = #ARGUMENTS.LocID#
		</cfif>
		<cfif ARGUMENTS.CLIENTID neq 0>
		and CLIENTID = #ARGUMENTS.CLIENTID#
		</cfif>    
		</cfquery>
		<cfreturn data />
	</cffunction>
	<cffunction name="GymHistory" returntype="query">
		<cfargument name="LocID" default="0">
		<cfquery name="data" datasource="Gym">
		select * from "0-loc info history"
		<cfif ARGUMENTS.LocID neq 0>
		where LocID = #ARGUMENTS.LocID#
		</cfif>
		</cfquery>
		<cfreturn data />
	</cffunction>    
	<cffunction name="addWCOwners" returntype="void">
		<cfargument name="client_id" required="yes">
        <cfargument name="owner_name" required="yes">
        <cfargument name="owner_title" required="yes">
        <cfargument name="owner_percent" required="yes">
        <cfargument name="owner_salary" required="yes">
        <cfargument name="owner_include" required="yes">
        <cfargument name="owner_exclude" required="yes">
		<cfquery name="data" datasource="raps">
		select client_wc_id
		from client_wc
        where client_id = #arguments.client_id#
        and owner_name = '#arguments.owner_name#'
		</cfquery>
        <cfif not data.recordcount>
        <cfquery datasource="raps">
        insert into client_wc (client_id,owner_name,owner_title,owner_percent,owner_salary,owner_include,owner_exclude)
        VALUES (#arguments.client_id#,
                '#arguments.owner_name#',
                '#arguments.owner_title#',
                #arguments.owner_percent#,
                #arguments.owner_salary#,
                #arguments.owner_include#,
                #arguments.owner_exclude#)
        </cfquery>
        <cfelse>
        <cfquery datasource="raps">
        update client_wc
        set client_id = #arguments.client_id#,
        	owner_name = '#arguments.owner_name#',
            owner_title = '#arguments.owner_title#',
            owner_percent = #arguments.owner_percent#,
            owner_salary = #arguments.owner_salary#,
            owner_include = #arguments.owner_include#,
            owner_exclude = #arguments.owner_exclude#
        where client_wc_id = #data.client_wc_id#
        </cfquery>
		</cfif>
        
	</cffunction>  
    <cffunction name="addConsolidate" output="false">
    <cfargument name="table" required="yes">
		<cfargument name="client_id1" required="true">
        <cfargument name="client_id2" required="true">
        <cfparam name="result" default="success">
        <cfquery datasource="Raps" name="checkDup">
        SELECT *
        FROM #ARGUMENTS.table#
        WHERE client_id1 = #ARGUMENTS.client_id1#
        AND client_id2 = #ARGUMENTS.client_id2#
        </cfquery>
        <cfif not checkDup.recordcount>
        <cftry>
        <cfquery datasource="Raps">
        INSERT INTO #ARGUMENTS.table# (client_id1,client_id2)
        VALUES (#ARGUMENTS.client_id1#,#ARGUMENTS.client_id2#)
		</cfquery>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        </cfif>
        <cfreturn result />
	</cffunction>      	
	<cffunction name="addClientContact" returntype="void">
		<cfargument name="client_id" required="yes">
        <cfargument name="name" required="yes">
        <cfargument name="title" required="yes">
        <cfargument name="phone" required="yes">
        <cfargument name="cell" required="yes">
        <cfargument name="fax" required="yes">
        <cfargument name="email" required="yes">
		<cfquery name="data" datasource="raps">
		select contactid
		from client_contacts
        where client_id = #arguments.client_id#
        and name = '#arguments.name#'
		</cfquery>
        <cfif not data.recordcount>
        <cfquery datasource="raps">
        insert into client_contacts (client_id,name,title,phone,cell,fax,email)
        VALUES (#arguments.client_id#,
                '#arguments.name#',
                '#arguments.title#',
                '#arguments.phone#',
                '#arguments.cell#',
                '#arguments.fax#',
                '#arguments.email#')
        </cfquery>
        <cfelse>
        <cfquery datasource="raps">
        update client_contacts
        set client_id = #arguments.client_id#,
        	name = '#arguments.name#',
            title = '#arguments.title#',
            phone = '#arguments.phone#',
            cell = '#arguments.cell#',
            fax = '#arguments.fax#',
            email = '#arguments.email#'
        where contactid = #data.contactid#
        </cfquery>
		</cfif>
        
	</cffunction>    
	<cffunction name="getLocationsOther" returntype="query">
		<cfargument name="LocID" default="0">
		<cfquery name="data" datasource="Gym">
		select * from "0-MISC SPECIFIC"
		WHERE "LocID" =  #ARGUMENTS.LocID#
		</cfquery>
		<cfreturn data />
	</cffunction>		
	<cffunction name="getLiabilityPlan">
		<cfargument name="GymPlanID" type="string" required="yes">
		<cfparam name="result" default="0">
		<cfquery datasource="Gym" name="gymdata">
		select "CONGLOM CODE" as ccode, "DESCRIPTION" as plandesc
		from "LU Plan Premiums by Conglom"	
		WHERE "PLAN##" = #ARGUMENTS.GymPlanID#	
		</cfquery>
		<cfif gymdata.recordcount>
			<cfquery name="data">
			select TOP 1 l.liability_plan_id as planid, l.name, a.code 
			from liability_plans l
			inner join conglom_liability c
			on l.liability_plan_id = c.liability_plan_id
			inner join client_affiliations a
			on c.conglom_id = a.affiliation_id
			where l.name = '#gymdata.plandesc#'
			<!---and a.code = '#gymdata.ccode#'--->
			</cfquery>
			<cfif data.recordcount>
				<cfset result = data.planid>
			<cfelse>
				<cfset result = 0>
			</cfif>
		</cfif>
		<cfreturn result />
	</cffunction>	
	<cffunction name="getPropertyPlan">
		<cfargument name="GymData" type="string" required="yes">
		<cfparam name="result" default="0">
		<cfquery datasource="Gym" name="gymdata">
		select "BCO NAME" as propplan
		from "LU Billing Co Info"	
		WHERE "BCO CODE" = '#ARGUMENTS.GymData#'
		</cfquery>
		<cfif gymdata.recordcount>
			<cfquery name="data">
			select TOP 1 property_plan_id as planid
			from property_plans
			where property_plan_name = '#gymdata.propplan#'
			<!---and a.code = '#gymdata.ccode#'--->
			</cfquery>
			<cfif data.recordcount>
				<cfset result = data.planid>
			<cfelse>
				<cfset result = 0>
			</cfif>
		</cfif>
		<cfreturn result />
	</cffunction>		
	<cffunction name="getConstructionType" returntype="numeric">
		<cfargument name="GymValue" type="string" required="yes">
		<cfquery name="data">
		select construction_type_id
		from app_constructiontypes
		where construction_type = '#trim(ARGUMENTS.GymValue)#'
		</cfquery>
		<cfif data.recordcount>
		<cfset result = data.construction_type_id>
		<cfelse>
		<cfset result = 0>
		</cfif>
		<cfreturn result />
	</cffunction>
	<cffunction name="getIssuing" returntype="numeric">
		<cfargument name="GymValue" type="string" required="yes">
		<cfquery name="data">
		select issuing_company_id
		from issuing_companies
		where name = '#trim(ARGUMENTS.GymValue)#'
		</cfquery>
		<cfif data.recordcount>
		<cfset result = data.issuing_company_id>
		<cfelse>
		<cfset result = 0>
		</cfif>

		<cfreturn result />
	</cffunction>
	<cffunction name="getPolicyType" returntype="numeric">
		<cfargument name="GymValue" type="string" required="yes">
		<cfquery name="data">
		select policy_type_id
		from policy_types
		where policy_code = '#trim(ARGUMENTS.GymValue)#'
		</cfquery>
		<cfif data.recordcount>
		<cfset result = data.policy_type_id>
		<cfelse>
		<cfset result = 0>
		</cfif>
		<cfreturn result />
	</cffunction>        
	<cffunction name="getRoofType" returntype="numeric">
		<cfargument name="GymValue" type="string" required="yes">
		<cfquery name="data">
		select roof_type_id
		from app_rooftypes
		where roof_type = '#trim(ARGUMENTS.GymValue)#'
		</cfquery>
		<cfif data.recordcount>
		<cfset result = data.roof_type_id>
		<cfelse>
		<cfset result = 0>
		</cfif>
		<cfreturn result />
	</cffunction>
	<cffunction name="checkPriorUpdate" returntype="numeric">
		<cfargument name="gym_id" type="numeric" required="yes">
		<cfargument name="notes" type="string" required="yes">
		<cfquery name="data">
		select notes
		from applications
		where gym_id = #ARGUMENTS.gym_id#
		</cfquery>
		<cfif data.recordcount>
			<cfset test = FindNoCase(ARGUMENTS.notes, data.notes, 1)>
			<cfif test gt 0>
				<cfset result = 0>
			<cfelse>
				<cfset result = 1>
			</cfif>	
		<cfelse>
		<cfset result = 1>
		</cfif>
		<cfreturn result />
	</cffunction>			
	<cffunction name="getClientInfo" returntype="query" output="yes">
		<cfargument name="gym_id" required="yes">
  
		<cfquery name="data">
		select entity_name, client_id, current_effective_date
		from clients
		where gym_id = #trim(ARGUMENTS.gym_id)#
		</cfquery>
		<cfreturn data />
	</cffunction>
	<cffunction name="getAppInfo" returntype="query">
		<cfargument name="gym_id" required="yes">
    <cfargument name="history" default="0">
		<cfquery name="data">
		select application_id
		from applications
		where gym_id = #trim(ARGUMENTS.gym_id)#
    <cfif arguments.history eq 1>
    AND history = 1
    </cfif>
		</cfquery>
		<cfreturn data />
	</cffunction>	
	<cffunction name="getLocationInfo" returntype="query">
		<cfargument name="gym_id" required="yes">
		<cfquery name="data">
		select location_id, state_id
		from locations
		where gym_id = #trim(ARGUMENTS.gym_id)#
		</cfquery>
		<cfreturn data />
	</cffunction>
	<cffunction name="getRatingInfo" returntype="query">
		<cfargument name="gym_id" required="yes">
        <cfargument name="history" default="0">
		<cfquery name="data">
		select top 1 ratingid
		from rating
		where gym_id = #trim(ARGUMENTS.gym_id)#
        <cfif arguments.history neq 0>
        and history = 1
        </cfif>
		</cfquery>
		<cfreturn data />
	</cffunction>			
	<cffunction name="getAffiliation" returntype="string">
		<cfargument name="code" required="yes">
		<cfquery name="data">
		select affiliation_id
		from client_affiliations
		where code = '#trim(ARGUMENTS.code)#'
		</cfquery>
		<cfif data.recordcount>
		<cfset result = data.affiliation_id>
		<cfelse>
		<cfset result = "0">
		</cfif>
		<cfreturn result />
	</cffunction>
	<cffunction name="convertLocationStatus" returntype="numeric">
		<cfargument name="gymLocStatus" required="yes">
		<cfset gymQuote = 3>
		<cfset gymActive = 1>
		<cfset gymCancel = 2>
		<cfswitch expression="#ARGUMENTS.gymLocStatus#">
		<cfcase value="1">
		<cfset result = 1>
		</cfcase>
		<cfcase value="2">
		<cfset result = 3>
		</cfcase>
		<cfcase value="3">
		<cfset result = 2>
		</cfcase>				
		</cfswitch>
		<cfreturn result />
	</cffunction>
	<cffunction name="convertUser" returntype="numeric">
		<cfargument name="initials" required="yes">
        <cfparam name="user_id" default="0">
		<cfif trim(arguments.initials) neq ''>
			<cfset firstinit = left(arguments.initials,1)>
            <cfset lastinit = mid(arguments.initials,2,1)>
            <cfquery name="getuser">
            select user_id
            from users
            where LEFT(user_firstname,1) = '#firstinit#'
            and  LEFT(user_lastname,1) = '#lastinit#'
            </cfquery>
            <cfif getuser.recordcount>
            <cfset user_id = getuser.user_id>
            </cfif>
        </cfif>
        <cfreturn user_id>
	</cffunction>    
	<cffunction name="convertPolicyStatus" returntype="numeric">
		<cfargument name="gymPolicyStatus" required="yes">
		<cfset gymActive = 1>
		<cfset gymRenewed = 2>
        <cfset gymCancel = 3>
        <cfset gymNone = 4>
        <cfset gymExDateOnly = 5>
		<cfswitch expression="#ARGUMENTS.gymPolicyStatus#">
		<cfcase value="1">
		<cfset result = 1>
		</cfcase>
		<cfcase value="2">
		<cfset result = 3>
		</cfcase>
		<cfcase value="3">
		<cfset result = 2>
		</cfcase>
        <cfdefaultcase>
        <cfset result = 0>
        </cfdefaultcase>				
		</cfswitch>
		<cfreturn result />
	</cffunction>    
	<cffunction name="convertYN" returntype="numeric">
		<cfargument name="gymVal" required="yes">

		<cfswitch expression="#val(ARGUMENTS.gymVal)#">
		<cfcase value="1">
		<cfset result = 1>
		</cfcase>
		<cfcase value="2">
		<cfset result = 0>
		</cfcase>
		<cfcase value="0">
		<cfset result = 0>
		</cfcase>		
        <cfdefaultcase>
        <cfset result = 0>
        </cfdefaultcase>		
		</cfswitch>
		<cfreturn result />
	</cffunction>
	<cffunction name="convertField" returntype="struct">
		<cfargument name="OtherDesc" required="yes">
		<cfargument name="OtherLimit" required="yes">
		<cfargument name="OtherPrem" required="yes">
		<cfargument name="OtherDed" required="yes">
		<cfset fields = structNew()>
		<cfif findnocase('Data Breach',ARGUMENTS.OtherDesc) gt 0>
			<cfif val(ARGUMENTS.OtherLimit) eq 1000000>	
			<cfset cyberid = 1>
			<cfelseif val(ARGUMENTS.OtherLimit) eq 100000>
			<cfset cyberid = 3>
      <cfelse>
      <cfset cyberid = 0>
			</cfif>
		<cfset fields.num.cyber_liability_amount_id = cyberid>
		<cfset fields.num.property_cyber_amount = val(ARGUMENTS.OtherPrem)>
		<cfelseif findnocase('HVAC',ARGUMENTS.OtherDesc) gt 0>
		
		<cfset fields.num.prop_hvaclimit = val(ARGUMENTS.OtherLimit)>
		<cfset fields.num.prop_hvacpremium = val(ARGUMENTS.OtherPrem)>
			<cfif fields.num.prop_hvaclimit neq 0 AND fields.num.prop_hvacpremium neq 0>
			<cfset fields.num.prop_hvacrate = fields.num.prop_hvacpremium / fields.num.prop_hvaclimit * 100>
			</cfif>		
		<cfelse>
		<cfset fields.notes = "OTHER COVERAGE - #ARGUMENTS.OtherDesc# Limit: #val(ARGUMENTS.OtherLimit)# Premium: #val(ARGUMENTS.OtherPrem)# Deductible: #val(ARGUMENTS.OtherDed)#">
		</cfif>

		<cfreturn fields />
	</cffunction>	
	<cffunction name="totalRPG" returntype="numeric">
		<cfargument name="ClientID" required="yes">
		<cfquery name="data" datasource="Gym">
		SELECT [0-loc info].ClientID, Sum([0-loc info].[Fee Agency $]) AS [SumOfFee Agency $]
		FROM [0-loc info]
		GROUP BY [0-loc info].ClientID
		HAVING ((([0-loc info].ClientID)=#ARGUMENTS.ClientID#));
		</cfquery>
		<cfif data.recordcount>
		<cfset result = data["SUMOFFEE AGENCY $"][1]>
		<cfelse>
		<cfset result = 0>
		</cfif>
		<cfreturn result />
	</cffunction>						
	<cffunction name="convertED" returntype="numeric">
		<cfargument name="ed1" required="yes">
		<cfargument name="ed2" required="yes">
		<cfargument name="ed3" required="yes">
		<cfif val(ed3) gt 0>
		<cfset result = 3>
		<cfelseif val(ed2) gt 0>
		<cfset result = 2>
		<cfelseif val(ed1) gt 0>
		<cfset result = 1>
		<cfelse>
		<cfset result = 0>				
		</cfif>
		<cfreturn result />
	</cffunction>	
	<!--- Checks a table in raps and updates or inserts an object. --->
	<cffunction name="MigrateToRaps">
		<cfargument name="rapsTable" />
		<cfargument name="gymObject" />
        <cfargument name="forceInsert" default="0">
        <cfparam name="TableQuery" default="">
		<cfparam name="result" default="success" />
		<cftry>

			<cfquery name="CheckTable" datasource="raps">select * from dbo.#rapsTable# where gym_id = #gymObject.num.gym_id#</cfquery>
			
		  	<cfif CheckTable.recordcount AND ARGUMENTS.forceInsert neq 1>
		        <cfset TableQuery = "update #ARGUMENTS.rapsTable# set #GetMigrationUpdateObject( gymObject )# where gym_id = #gymObject.num.gym_id#;" />
		    <cfelse>
		        <cfset TableQuery = "insert into #ARGUMENTS.rapsTable# #GetMigrationInsertObject( gymObject )#;" />
		    </cfif>
			<cfquery name="TableUpdate" datasource="raps">#preserveSingleQuotes(TableQuery)#</cfquery>
			<cfcatch type="any">
				<cfset result = "#cfcatch.Message# - #cfcatch.Detail# --- Query: #TableQuery#" />
                <cffile action="append" file="#expandPath('.')#\migration.txt" output="#DateFormat(now(), 'mm/dd/yyyy')# #timeFormat(now())# - ERROR in MigrateToRaps Function - Gym_id: #gymObject.num.gym_id# - #result#"> 
			</cfcatch>
		</cftry>
		<cfreturn result />
	</cffunction>
	
	<!--- Preps a object from gym to be updated in raps. --->
	<cffunction name="GetMigrationUpdateObject">
		<cfargument name="Object" />
		<cfset returnStringArray = ArrayNew( 1 ) />
		<cfset quoteAtb = StructKeyArray( Object["str"] ) />
		<cfset numberAtb = StructKeyArray( Object["num"] ) />
		<cfloop index="i" from="1" to=#ArrayLen( quoteAtb )#>
			<cfif Object["str"][quoteAtb[i]] neq "">
				<!---<cfset temp = ArrayAppend( returnStringArray, LCase( quoteAtb[i] ) & " = '" & REReplace( Object["str"][quoteAtb[i]], "'", "&apos;", "ALL" ) & "'" ) />--->
                 <!---escape for single quotes--->
                <cfset temp = ArrayAppend( returnStringArray, LCase( quoteAtb[i] ) & " = '" & REReplace( Object["str"][quoteAtb[i]], "'", "''", "ALL" ) & "'" ) />
			<cfelse>
				<cfset temp = ArrayAppend( returnStringArray, LCase( quoteAtb[i] ) & " = null" ) />
			</cfif>
		</cfloop>
		<cfloop index="i" from="1" to=#ArrayLen( numberAtb )#>
			<cfset temp = ArrayAppend( returnStringArray, LCase( numberAtb[i] ) & ' = ' & Object["num"][numberAtb[i]] ) />
		</cfloop>
		<cfset returnString = ArrayTolist( returnStringArray, ", " ) />
		<cfreturn returnString />
	</cffunction>
	
	<!--- Inserts a new object from gym into raps. --->
	<cffunction name="GetMigrationInsertObject">
		<cfargument name="Object" />
		<cfset returnStringArray = ArrayNew( 1 ) />
		<cfset returnStringArgs = ArrayNew( 1 ) />
		<cfset quoteAtb = StructKeyArray( Object["str"] ) />
		<cfset numberAtb = StructKeyArray( Object["num"] ) />
		<cfloop index="i" from="1" to=#ArrayLen( quoteAtb )#>
			<cfset temp = ArrayAppend( returnStringArgs, LCase( quoteAtb[i] ) ) />
			<cfif Object["str"][quoteAtb[i]] neq "">
            <!---escape for single quotes--->
				<cfset temp = ArrayAppend( returnStringArray, "'" & REReplace( Object["str"][quoteAtb[i]], "'", "''", "ALL" ) & "'" ) />
			<cfelse>
				<cfset temp = ArrayAppend( returnStringArray, "null" ) />
			</cfif>
		</cfloop>
		<cfloop index="i" from="1" to=#ArrayLen( numberAtb )#>
			<cfset temp = ArrayAppend( returnStringArgs, LCase( numberAtb[i] ) ) />
			<cfset temp = ArrayAppend( returnStringArray, Object["num"][numberAtb[i]] ) />
		</cfloop>
		<cfset returnString = "( " & ArrayToList( returnStringArgs ) & " ) " />
		<cfset returnString = returnString & " values( " & ArrayTolist( returnStringArray, ", " ) & " )" />
		<cfreturn returnString />
	</cffunction>
<cffunction name="formatNum" returntype="numeric">
	<cfargument name="num" required="yes">
  <cfset formattedNum = val(REReplace(ARGUMENTS.num,"[^\d.]", "","ALL"))>
  <cfreturn formattedNum />
</cffunction> 
  <cffunction name="checkDup" returntype="query" output="yes">
  <cfargument name="clientid" required="yes">
  <cfquery datasource="raps" name="qdata">
  select client_id, entity_name, client_code, dba, ams, gym_id
  from clients
  where gym_id = #arguments.clientid#
  </cfquery>

  <cfreturn qdata />
  </cffunction>
</cfcomponent>