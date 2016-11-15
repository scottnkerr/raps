<cfcomponent output="false">
	<cffunction name="init" returntype="any" output="false">
  <cfset loginGW = createObject('component','app.model.login').init()> 
  <cfset appGW = createObject('component','app.model.app').init()>
		<cfreturn this />
	</cffunction>
	<cffunction name="getRoles" returntype="query" output="false">
		<cfquery name="getUserRoles" datasource="raps">
			select *
            from user_roles
		</cfquery>
		<cfreturn getUserRoles />
	</cffunction>
	<cffunction name="getNotes" returntype="query" output="false">
    <cfargument name="client_id" required="yes">
		<cfquery name="getData" datasource="raps">
			select client_notes
            from clients
            where client_id = #ARGUMENTS.client_id#
		</cfquery>
		<cfreturn getData />
	</cffunction>    
	<cffunction name="getStates" returntype="query" output="false">
    <cfargument name="state_id" default="0">
		<cfquery name="data" datasource="raps">
			select *
            from states
            <cfif ARGUMENTS.state_id neq 0>
            WHERE state_id = #ARGUMENTS.state_id#
            </cfif>
            order by name
		</cfquery>
		<cfreturn data />
	</cffunction> 
  
	<cffunction name="getRatingState" returntype="query" output="false">
    <cfargument name="location_id" required="yes">
		<cfquery name="data" datasource="raps">
			select *
            from states
            WHERE state_id = (SELECT state_id from locations where location_id = #ARGUMENTS.location_id#)
		</cfquery>
		<cfreturn data />
	</cffunction>
<!---	<cffunction name="checkEndorsement" returntype="query" output="false">
    <cfargument name="location_id" required="yes">
		<cfquery name="data" datasource="raps">
        select r.ratingid, r.savedatetime, rl.gldate1, rl.gldate2, rp.propdate1, rp.propdate2, c.current_effective_date
        from rating r
        inner join rating_liability rl
        on r.ratingid = rl.ratingid
        inner join rating_property rp
        on r.ratingid = rp.ratingid
        inner join locations l
        on r.location_id = l.location_id
        inner join clients c
        on l.client_id = c.client_id
        where r.location_id = #arguments.location_id#
        and endorse = 1
		</cfquery>
		<cfreturn data />
	</cffunction> --->  
	<cffunction name="checkEndorsement" returntype="query" output="false">
    <cfargument name="ratingid" required="yes">
		<cfquery name="data" datasource="raps">
        select r.ratingid, r.savedatetime, rl.gldate1, rl.gldate2, rp.propdate1, rp.propdate2, c.current_effective_date
        from rating r
        inner join rating_liability rl
        on r.ratingid = rl.ratingid
        inner join rating_property rp
        on r.ratingid = rp.ratingid
        inner join locations l
        on r.location_id = l.location_id
        inner join clients c
        on l.client_id = c.client_id
        where r.endorsement_id = #arguments.ratingid#
        and endorse = 1
		</cfquery>
		<cfreturn data />
	</cffunction>           
	<cffunction name="saveUserAJAX" returntype="string" returnformat="plain" output="false" access="remote">
    	<cfargument name="user_id" required="yes" default="0">
        <cfargument name="user_firstname" required="yes">
        <cfargument name="user_lastname" required="yes">
        <cfargument name="user_name" required="yes">
        <cfargument name="user_pass" required="yes">
        <cfargument name="user_pass_confirm" required="yes">
        <cfargument name="user_role_id" required="yes">
        <cfargument name="user_sig" required="yes">
        <cfargument name="disabled" required="yes">
        <cfparam name="result" default="success">
        <cfset encrypted = loginGW.encryptPassword(ARGUMENTS.user_pass)>
        <cfif ARGUMENTS.user_id is 0>
        <cftry>
		<cfquery datasource="raps">
			insert into users (user_name, user_pass, user_role_id, user_firstname, user_lastname,user_sig,disabled)
            values ('#ARGUMENTS.user_name#','#encrypted#', #ARGUMENTS.user_role_id#,'#ARGUMENTS.user_firstname#','#ARGUMENTS.user_lastname#', '#ARGUMENTS.user_sig#',#ARGUMENTS.disabled#)
		</cfquery>
       <cfcatch type="any">
       <cfset result =  "#cfcatch.Message# - #cfcatch.Detail#">
       </cfcatch>
       </cftry>
       <cfelse>
        <cftry>
		<cfquery datasource="raps">
			update users
            set user_pass = '#encrypted#', 
            user_role_id = #ARGUMENTS.user_role_id#,
            user_firstname = '#ARGUMENTS.user_firstname#',
            user_lastname = '#ARGUMENTS.user_lastname#',
            user_sig = '#ARGUMENTS.user_sig#',
            disabled = #ARGUMENTS.disabled#
            where user_id = #ARGUMENTS.user_id#
		</cfquery>
       <cfcatch type="any">
       <cfset result =  "#cfcatch.Message# - #cfcatch.Detail#">
       </cfcatch>
       </cftry>       
       </cfif>
		<cfreturn result />
	</cffunction>        
	<cffunction name="deleteUserAJAX" returntype="string" returnformat="plain" output="false" access="remote">
        <cfargument name="user_id" required="no">
        <cfparam name="result" default="User Deleted Successfully">
        <cftry>
		<cfquery datasource="raps">
			delete from users
            where user_id = #ARGUMENTS.user_id#
		</cfquery>
       <cfcatch type="any">
       <cfset result =  "#cfcatch.Message# - #cfcatch.Detail#">
       </cfcatch>
       </cftry>
		<cfreturn result />
	</cffunction> 
	<cffunction name="deleteOtherExp" output="false">
    <cfargument name="otherexp_id" required="yes">
        <cfparam name="result" default="success">
        <cftry>
        <cfquery>
        delete from rating_liability_otherexp
        where otherexp_id = #arguments.otherexp_id#
        </cfquery>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />    
     </cffunction>
     <cffunction name="deleteOtherDebit" output="false">
    <cfargument name="debtcredit_id" required="yes">
        <cfparam name="result" default="success">
        <cftry>
        <cfquery>
        delete from rating_liability_debtcredits
        where debtcredit_id = #arguments.debtcredit_id#
        </cfquery>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />    
     </cffunction>     
	<cffunction name="deleteDebitCreit" output="false">
    <cfargument name="debtcredit_id" required="yes">
        <cfparam name="result" default="success">
        <cftry>
        <cfquery>
        delete from rating_liability_debtcredits
        where debtcredit_id = #arguments.debtcredit_id#
        </cfquery>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />    
     </cffunction>     
    <cffunction name="deleteLoc" returntype="string" returnformat="plain" output="false" access="remote">
   
        <cfargument name="location_id" required="yes">
        <cfparam name="result" default="Location Deleted Successfully">
        <cftry>
        <!--- find ratings associated with location--->
        <cfquery datasource="raps" name="getratings">
        	select ratingid
            from rating where location_id = #arguments.location_id#
        </cfquery>
		<cfquery datasource="raps">
			delete from locations where location_id = #arguments.location_id#
            delete from applications where location_id = #arguments.location_id#
            delete from rating where location_id = #arguments.location_id#
            <cfif getratings.recordcount>
            	<cfloop query="getratings">
                delete from rating_liability where ratingid = #getratings.ratingid#
                delete from rating_property where ratingid = #getratings.ratingid#
                </cfloop>
            </cfif>    
		</cfquery>
       <cfcatch type="any">
       <cfset result =  "#cfcatch.Message# - #cfcatch.Detail#">
       </cfcatch>
       </cftry>
		<cfreturn result />
	</cffunction>     
	<cffunction name="saveGLPlan" returntype="string" returnformat="plain" output="true" access="remote">
        <cfargument name="liability_plan_id" required="yes" default="0">
        <cfargument name="name" required="yes">
        <cfargument name="proposal_hide" required="yes">
        <cfargument name="disabled" required="yes">
        <cfargument name="base_rate" required="yes">
        <cfargument name="instructor_base" required="yes">
        <cfargument name="basketball_base" required="yes">
        <cfargument name="racquetball_base" required="yes">
        <cfargument name="tennis_base" required="yes">
        <cfargument name="sauna_base" required="yes">
        <cfargument name="steam_room_base" required="yes">
        <cfargument name="whirlpool_base" required="yes">
        <cfargument name="pools_base" required="yes">
        <cfargument name="poolsoutdoor_base" required="yes">
        <cfargument name="tanning_base" required="yes">
        <cfargument name="spray_tanning_base" required="yes">
        <cfargument name="beauty_angels_base" required="yes">
        <cfargument name="silver_sneakers_base" required="yes">
        <cfargument name="massage_base" required="yes">
        <cfargument name="personal_trainers_base" required="yes">
        <cfargument name="child_sitting_base" required="yes">
        <cfargument name="jungle_gym_base" required="yes">
        <cfargument name="leased_space_base" required="yes">
        <cfargument name="employeebenefits_base" required="yes">
        <cfargument name="terrorism_minimum" required="yes">
        <cfargument name="terrorism_fee" required="yes">
        <cfargument name="csl_each" required="yes">
        <cfargument name="csl_aggregate" required="yes">
        <cfargument name="csl_products" required="yes">
        <cfargument name="med_pay_per_person" required="yes">
        <cfargument name="fire_damage_legal" required="yes">
        <cfargument name="personal_advertising_injury" required="yes">
        <cfargument name="professional_liability" required="yes">
        <cfargument name="tanning_bed_liability" required="yes">
        <cfargument name="hired_auto_liability" required="yes">
        <cfargument name="non_owned_auto_liability" required="yes">
        <cfargument name="policy_deductible" required="yes">
        <cfargument name="sex_abuse_occ" required="yes">
        <cfargument name="sex_abuse_agg" required="yes">
        <cfargument name="default_credit" required="yes">
        <cfargument name="default_credit_label" required="yes">

        <cfparam name="planlist" default="">
    
        <cfif ARGUMENTS.liability_plan_id is 0>
        
		<cfquery datasource="raps" name="qData">
			insert into liability_plans (
                        name,
                        proposal_hide,
                        disabled,
                        base_rate,
                        instructor_base,
                        basketball_base,
                        racquetball_base,
                        tennis_base,
                        sauna_base,
                        steam_room_base,
                        whirlpool_base,
                        pools_base,
                        poolsoutdoor_base,
                        tanning_base,
                        spray_tanning_base,
                        beauty_angels_base,
                        silver_sneakers_base,
                        massage_base,
                        personal_trainers_base,
                        child_sitting_base,
                        jungle_gym_base,
                        leased_space_base,
                        employeebenefits_base,
                        terrorism_minimum,
                        terrorism_fee,
                        csl_each,
                        csl_aggregate,
                        csl_products,
                        med_pay_per_person,
                        fire_damage_legal,
                        personal_advertising_injury,
                        professional_liability,
                        tanning_bed_liability,
                        hired_auto_liability,
                        non_owned_auto_liability,
                        policy_deductible,
                        sex_abuse_occ,
                        sex_abuse_agg,
                        default_credit,
                        default_credit_label
                        )
            values (
                        '#ARGUMENTS.name#',
                        #ARGUMENTS.proposal_hide#,
                        #ARGUMENTS.disabled#,
                        <cfqueryparam cfsqltype="cf_sql_money" value="#val(ARGUMENTS.base_rate)#">,
                        <cfqueryparam cfsqltype="cf_sql_money" value="#val(ARGUMENTS.instructor_base)#">,
                        <cfqueryparam cfsqltype="cf_sql_money" value="#val(ARGUMENTS.basketball_base)#">,
                        <cfqueryparam cfsqltype="cf_sql_money" value="#val(ARGUMENTS.racquetball_base)#">,
                        <cfqueryparam cfsqltype="cf_sql_money" value="#val(ARGUMENTS.tennis_base)#">,
                        <cfqueryparam cfsqltype="cf_sql_money" value="#val(ARGUMENTS.sauna_base)#">,
                        <cfqueryparam cfsqltype="cf_sql_money" value="#val(ARGUMENTS.steam_room_base)#">,
                        <cfqueryparam cfsqltype="cf_sql_money" value="#val(ARGUMENTS.whirlpool_base)#">,
                        <cfqueryparam cfsqltype="cf_sql_money" value="#val(ARGUMENTS.pools_base)#">,
                        <cfqueryparam cfsqltype="cf_sql_money" value="#val(ARGUMENTS.poolsoutdoor_base)#">,
                        <cfqueryparam cfsqltype="cf_sql_money" value="#val(ARGUMENTS.tanning_base)#">,
                        <cfqueryparam cfsqltype="cf_sql_money" value="#val(ARGUMENTS.spray_tanning_base)#">,
                        <cfqueryparam cfsqltype="cf_sql_money" value="#val(ARGUMENTS.beauty_angels_base)#">,
                        <cfqueryparam cfsqltype="cf_sql_money" value="#val(ARGUMENTS.silver_sneakers_base)#">,
                        <cfqueryparam cfsqltype="cf_sql_money" value="#val(ARGUMENTS.massage_base)#">,
                        <cfqueryparam cfsqltype="cf_sql_money" value="#val(ARGUMENTS.personal_trainers_base)#">,
                        <cfqueryparam cfsqltype="cf_sql_money" value="#val(ARGUMENTS.child_sitting_base)#">,
                        <cfqueryparam cfsqltype="cf_sql_money" value="#val(ARGUMENTS.jungle_gym_base)#">,
                        <cfqueryparam cfsqltype="cf_sql_money" value="#val(ARGUMENTS.leased_space_base)#">,
                        <cfqueryparam cfsqltype="cf_sql_money" value="#val(ARGUMENTS.employeebenefits_base)#">,
                        <cfqueryparam cfsqltype="cf_sql_money" value="#val(ARGUMENTS.terrorism_minimum)#">,
                        <cfqueryparam cfsqltype="cf_sql_money" value="#val(ARGUMENTS.terrorism_fee)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(ARGUMENTS.csl_each)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(ARGUMENTS.csl_aggregate)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(ARGUMENTS.csl_products)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(ARGUMENTS.med_pay_per_person)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(ARGUMENTS.fire_damage_legal)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(ARGUMENTS.personal_advertising_injury)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(ARGUMENTS.professional_liability)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(ARGUMENTS.tanning_bed_liability)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(ARGUMENTS.hired_auto_liability)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(ARGUMENTS.non_owned_auto_liability)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(ARGUMENTS.policy_deductible)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(ARGUMENTS.sex_abuse_occ)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(ARGUMENTS.sex_abuse_agg)#">,
                        <cfqueryparam cfsqltype="cf_sql_money" value="#val(ARGUMENTS.default_credit)#">,
                        '#ARGUMENTS.default_credit_label#');
		</cfquery>
        <cfquery datasource="raps" name="getnew">
        select MAX(liability_plan_id) as newid
        from liability_plans
        </cfquery>
        <cfset result = getnew.newid>
		<cfif listlen(ARGUMENTS.planlist) gt 0>  
        <cfloop from="1" to="#listlen(ARGUMENTS.planlist)#" index="i">
           <cfquery datasource="raps">
           insert into conglom_liability (conglom_id, liability_plan_id)
           values (#listgetat(ARGUMENTS.planlist,i)#,#getnew.newid#)
           </cfquery>
        </cfloop>
         </cfif>
       <cfelse>

		<cfquery name="qData">
			update liability_plans
            set name = '#ARGUMENTS.name#',
            							proposal_hide = #val(arguments.proposal_hide)#,
                        disabled = #val(arguments.disabled)#,
                        base_rate = #val(arguments.base_rate)#,
                        instructor_base = #val(arguments.instructor_base)#,
                        basketball_base = #val(arguments.basketball_base)#,
                        racquetball_base = #val(arguments.racquetball_base)#,
                        tennis_base = #val(arguments.tennis_base)#,
                        sauna_base = #val(arguments.sauna_base)#,
                        steam_room_base = #val(arguments.steam_room_base)#,
                        whirlpool_base = #val(arguments.whirlpool_base)#,
                        pools_base = #val(arguments.pools_base)#,
                        poolsoutdoor_base = #val(arguments.poolsoutdoor_base)#,
                        tanning_base = #val(arguments.tanning_base)#,
                        spray_tanning_base = #val(arguments.spray_tanning_base)#,
                        beauty_angels_base = #val(arguments.beauty_angels_base)#,
                        silver_sneakers_base = #val(arguments.silver_sneakers_base)#,
                        massage_base = #val(arguments.massage_base)#,
                        personal_trainers_base = #val(arguments.personal_trainers_base)#,
                        child_sitting_base = #val(arguments.child_sitting_base)#,
                        jungle_gym_base = #val(arguments.jungle_gym_base)#,
                        leased_space_base = #val(arguments.leased_space_base)#,
                        employeebenefits_base = #val(arguments.employeebenefits_base)#,
                        terrorism_minimum = #val(ARGUMENTS.terrorism_minimum)#,
                        terrorism_fee = #val(ARGUMENTS.terrorism_fee)#,
                        csl_each = '#ARGUMENTS.csl_each#',
                        csl_aggregate = '#ARGUMENTS.csl_aggregate#',
                        csl_products = '#ARGUMENTS.csl_products#',
                        med_pay_per_person = '#ARGUMENTS.med_pay_per_person#',
                        fire_damage_legal = '#ARGUMENTS.fire_damage_legal#',
                        personal_advertising_injury = '#ARGUMENTS.personal_advertising_injury#',
                        professional_liability = '#ARGUMENTS.professional_liability#',
                        tanning_bed_liability = '#ARGUMENTS.tanning_bed_liability#',
                        hired_auto_liability = '#ARGUMENTS.hired_auto_liability#',
                        non_owned_auto_liability = '#ARGUMENTS.non_owned_auto_liability#',
                        policy_deductible = '#ARGUMENTS.policy_deductible#',
                        sex_abuse_occ = '#ARGUMENTS.sex_abuse_occ#',
                        sex_abuse_agg = '#ARGUMENTS.sex_abuse_agg#',
                        default_credit = #val(ARGUMENTS.default_credit)#,
                        default_credit_label = '#ARGUMENTS.default_credit_label#'
            where liability_plan_id = #ARGUMENTS.liability_plan_id#
		</cfquery>
    
    <cfset result = ARGUMENTS.liability_plan_id>
        <cfquery datasource="raps">
            delete from conglom_liability
            where liability_plan_id = #ARGUMENTS.liability_plan_id#
       	</cfquery> 
 
		<cfif listlen(ARGUMENTS.planlist) gt 0>  
        <cfloop from="1" to="#listlen(ARGUMENTS.planlist)#" index="i">
           <cfquery datasource="raps">
           insert into conglom_liability (conglom_id, liability_plan_id)
           values (#listgetat(ARGUMENTS.planlist,i)#,#ARGUMENTS.liability_plan_id#)
           </cfquery>
        </cfloop>
         </cfif>

         
       </cfif>  

   
		<cfreturn result />
	</cffunction>                 
	<cffunction name="checkDup" returntype="string" returnformat="plain" output="no" access="remote">
    <cfargument name="user_name" required="yes">
		<cfquery name="getUser" datasource="raps">
			select user_name
            from users
            where user_name = '#ARGUMENTS.user_name#'
		</cfquery>
        <cfparam name="result" default="true">
        <cfif getUser.recordcount>
        <cfset result = false>
        </cfif>
		<cfreturn result />
	</cffunction> 
	<cffunction name="checkDupContacts" output="yes" access="remote" returntype="boolean">
    <cfargument name="rc" required="yes" type="struct">
    <cfset result = false>
   
		<cfquery name="qData">
			select contactid
      from client_contacts
      where client_id = #arguments.rc.client_id#
      and name = '#arguments.rc.Name#'
      and contactid <> #arguments.rc.contactid#
		</cfquery>
		<cfif qData.recordcount>
    <cfset result = true>
    </cfif>
		<cfreturn result />
	</cffunction>   
	<cffunction name="checkClientCodeDup" returntype="string" returnformat="plain" output="no" access="remote">
    <cfargument name="client_code" required="yes">
    <cfargument name="client_id" required="yes">
		<cfquery name="getData" datasource="raps">
			select client_code
            from clients
            where client_code = '#ARGUMENTS.client_code#'
            AND client_id <> #ARGUMENTS.client_id#
		</cfquery>
        <cfparam name="result" default="true">
        <cfif getData.recordcount>
        <cfset result = false>
        </cfif>
		<cfreturn result />
	</cffunction>     
	<cffunction name="checkPlanDups" returntype="string" returnformat="plain" output="no" access="remote">
    <cfargument name="name" required="yes">
		<cfquery name="getData" datasource="raps">
			select name
            from liability_plans
            where name = '#ARGUMENTS.name#'
		</cfquery>
        <cfparam name="result" default="true">
        <cfif getData.recordcount>
        <cfset result = false>
        </cfif>
		<cfreturn result />
	</cffunction> 
    <cffunction name="clientSearchAutoComplete" access="public" output="false"> 
    <cfargument name="term" required="yes" type="string">
    <cfargument name="field" required="yes">
    <cfif arguments.field neq 'policy'>
      <cfquery datasource="raps" name="getData">
      select #arguments.field#
      from clients
      where #arguments.field# LIKE '%#ARGUMENTS.term#%'
      </cfquery>
    <cfelse>
      <cfquery datasource="raps" name="getData">
      select policy_number
      from policy_info
      where policy_number LIKE '%#ARGUMENTS.term#%'
      </cfquery>    	
    </cfif>
    <cfreturn getData>
    </cffunction>          
	<cffunction name="getUsers" access="remote" returnFormat="json" output="false">
    <cfargument name="user_id" default="0">
		<cfargument name="limit" default="500">
		<cfargument name="start" default="1">
		<cfargument name="sort" default="user_name">
		<cfargument name="dir" default="ASC">
		<cfargument name="filters" default="active" type="string">
		<cfset var items = ArrayNew(1)>
		<cfset var stcReturn = "">
		
        <cfif Arguments.start is 0>
		<cfset Arguments.start = 1>	
        </cfif>	
		
		<cfquery name="selItems" datasource="raps">
				SELECT u.*, r.*
				FROM Users u
                INNER JOIN user_roles r
                ON u.user_role_id = r.user_role_id
                <cfif ARGUMENTS.user_id neq 0>
                WHERE u.user_id = #ARGUMENTS.user_id#
                </cfif>
				ORDER BY #Arguments.sort# #Arguments.dir#
		</cfquery>
		
		<cfset items = convertQueryToExtJSGrid(selItems,Arguments.start,Arguments.limit)>
		
		<cfset stcReturn = {rows=items,dataset=#selItems.RecordCount#}>
		
		<cfreturn stcReturn>
	
	</cffunction> 
	<cffunction name="getUsersSimple" access="remote"  output="false">
    	<cfargument name="user_id" default="0">
		<cfargument name="limit" default="500">
		<cfargument name="start" default="1">
		<cfargument name="sort" default="user_name">
		<cfargument name="dir" default="ASC">
		<cfargument name="filters" default="active" type="string">
        <cfargument name="excldisabled" default="0">
		<cfset var items = ArrayNew(1)>
		<cfset var stcReturn = "">
		
        <cfif Arguments.start is 0>
		<cfset Arguments.start = 1>	
        </cfif>	
		
		<cfquery name="selItems" datasource="raps">
				SELECT u.*, u.user_name as username, r.*
				FROM Users u
                INNER JOIN user_roles r
                ON u.user_role_id = r.user_role_id
                WHERE 1=1
                <cfif ARGUMENTS.user_id neq 0>
                AND u.user_id = #ARGUMENTS.user_id#
                </cfif>
                <cfif ARGUMENTS.excldisabled neq 0>
                AND (u.disabled = 0 OR u.disabled is null)
                </cfif>
                
				ORDER BY #Arguments.sort# #Arguments.dir#
		</cfquery>
		
		<cfreturn selItems />
	
	</cffunction>
	<cffunction name="getNI" access="remote"  output="false">
    	<cfargument name="client_id" required="yes">
    	<cfargument name="named_insured_id" default="0">
		
		<cfquery name="selItems" datasource="raps">
				SELECT a.*, b.ni_relationship
                from named_insureds a
                LEFT JOIN ni_relationships b
                ON a.relationship = b.ni_relationship_id
                WHERE a.client_id = #ARGUMENTS.client_id#
                <cfif ARGUMENTS.named_insured_id neq 0>
                AND named_insured_id = #ARGUMENTS.named_insured_id#
                </cfif>
				ORDER BY named_insured asc
		</cfquery>
		
		<cfreturn selItems />
	
	</cffunction>    
	<cffunction name="getConsolidated"  output="false">
    	<cfargument name="client_id" required="yes">
		
		<cfquery name="selItems" datasource="raps">
				SELECT a.*, b.client_code, b.ams, b.entity_name, b.dba
                from ue_consolidation a 
                INNER JOIN clients b
                ON a.client_id2 = b.client_id
                WHERE a.client_id1 = #ARGUMENTS.client_id#
				ORDER BY b.client_code asc
		</cfquery>
		
		<cfreturn selItems />
	
	</cffunction> 
	<cffunction name="getEPLIConsolidated"  output="false">
    	<cfargument name="client_id" required="yes">
		
		<cfquery name="selItems" datasource="raps">
				SELECT a.*, b.client_code, b.ams, b.entity_name, b.dba
                from epli_consolidation a 
                INNER JOIN clients b
                ON a.client_id2 = b.client_id
                WHERE a.client_id1 = #ARGUMENTS.client_id#
				ORDER BY b.client_code asc
		</cfquery>
		
		<cfreturn selItems />
	
	</cffunction> 
	<cffunction name="getWCConsolidated"  output="false">
    	<cfargument name="client_id" required="yes">
		
		<cfquery name="selItems" datasource="raps">
				SELECT a.*, b.client_code, b.ams, b.entity_name, b.dba
                from wc_consolidation a 
                INNER JOIN clients b
                ON a.client_id2 = b.client_id
                WHERE a.client_id1 = #ARGUMENTS.client_id#
				ORDER BY b.client_code asc
		</cfquery>
		
		<cfreturn selItems />
	
	</cffunction>             
	<cffunction name="getClients" access="remote"  output="false">
		<cfquery name="selItems" datasource="raps">
				SELECT client_id, client_code, entity_name, ams
                from clients
                ORDER BY ams
		</cfquery>
		<cfreturn selItems />
	</cffunction>     
	<cffunction name="getGLPlans" access="remote" returnFormat="json" output="false">
    	<cfargument name="liability_plan_id" default="0">
		<cfargument name="disabled" default="0" type="any">
		<cfset var items = ArrayNew(1)>
		
		<cfquery name="selItems" datasource="raps">
		select *
        from liability_plans
        WHERE 1 = 1
        <cfif ARGUMENTS.disabled neq "ALL">
        AND disabled = #ARGUMENTS.disabled#
        </cfif>
        <cfif ARGUMENTS.liability_plan_id neq 0>
        AND liability_plan_id = #ARGUMENTS.liability_plan_id#
        </cfif>
        ORDER BY name
		</cfquery>		
		<cfreturn selItems />
	
	</cffunction>  
	<cffunction name="getGLPlansCodes" access="remote" returnFormat="json" output="false">
    	<cfargument name="liability_plan_id" default="0">
		<cfargument name="disabled" default="0" type="any">
		<cfset var items = ArrayNew(1)>
		
		<cfquery name="selItems" datasource="raps">
		select a.*, c.affiliation_id
        from liability_plans a
        FULL JOIN conglom_liability b
        ON a.liability_plan_id = b.liability_plan_id
        FULL JOIN client_affiliations c
        ON b.conglom_id = c.affiliation_id
        WHERE 1 = 1
        <cfif ARGUMENTS.disabled neq "ALL">
        AND a.disabled = #ARGUMENTS.disabled#
        </cfif>
        <cfif ARGUMENTS.liability_plan_id neq 0>
        AND a.liability_plan_id = #ARGUMENTS.liability_plan_id#
        </cfif>
        ORDER BY a.name
		</cfquery>		
		<cfreturn selItems />
	
	</cffunction>   
	<cffunction name="getClientGLPlans" access="remote" returnFormat="json" output="false">
    	<cfargument name="liability_plan_id" default="0">
        <cfargument name="client_id" default="0">
		<cfargument name="disabled" default="0" type="any">
		<cfset var items = ArrayNew(1)>
		
		<cfquery name="selItems" datasource="raps">
        select a.*, c.affiliation_id
        from liability_plans a
        FULL JOIN conglom_liability b
        ON a.liability_plan_id = b.liability_plan_id
        FULL JOIN client_affiliations c
        ON b.conglom_id = c.affiliation_id
        WHERE 1 = 1
        AND c.affiliation_id = (SELECT affiliation_id from clients where client_id = #ARGUMENTS.client_id#)
        <cfif ARGUMENTS.disabled neq "ALL">
        AND a.disabled <> 1
        </cfif>
        <cfif ARGUMENTS.liability_plan_id neq 0>
        AND a.liability_plan_id = #ARGUMENTS.liability_plan_id#
        </cfif>
        ORDER BY a.name
		</cfquery>		
		<cfreturn selItems />
	
	</cffunction>   
	<cffunction name="getPropCyber" access="remote" returnFormat="json" output="false">
    	<cfargument name="property_plan_id" default="0">
		<cfset var items = ArrayNew(1)>
		
		<cfquery name="selItems" datasource="raps">
            select a.*, b.*
            from
            app_cyberliability a
            FULL JOIN property_cyber b
            ON a.cyber_liability_amount_id = b.cyber_liability_amount_id
            WHERE 1=1
            AND b.property_plan_id = #ARGUMENTS.property_plan_id#
            AND disabled = 0
		</cfquery>		
		<cfreturn selItems />
	
	</cffunction> 
	<cffunction name="getPropEmp" access="remote" returnFormat="json" output="false">
    	<cfargument name="property_plan_id" default="0">
		<cfset var items = ArrayNew(1)>
		
		<cfquery name="selItems" datasource="raps">
            select a.*, b.*
            from
            app_employeedishonesty a
            FULL JOIN property_emp b
            ON a.employee_dishonesty_id = b.employee_dishonesty_id
            WHERE 1=1
            AND b.property_plan_id = #ARGUMENTS.property_plan_id#
            AND disabled = 0
		</cfquery>		
		<cfreturn selItems />
	
	</cffunction>                  
	<cffunction name="getConglom" access="remote" returnFormat="json" output="false">
    	<cfargument name="liability_plan_id" default="0">
		<cfargument name="disabled" default="0" type="any">
        <cfargument name="affiliation_id" default="0">
		<cfset var items = ArrayNew(1)>
		
		<cfquery name="selItems" datasource="raps">
		select *
        from client_affiliations
        WHERE 1 = 1
        <cfif ARGUMENTS.disabled neq "ALL">
        AND disabled = #ARGUMENTS.disabled#
        </cfif>
        <cfif ARGUMENTS.liability_plan_id neq 0>
        AND liability_plan_id = #ARGUMENTS.liability_plan_id#
        </cfif>
        <cfif ARGUMENTS.affiliation_id neq 0>
        AND affiliation_id = #ARGUMENTS.affiliation_id#
        </cfif>        
        ORDER BY code
		</cfquery>		
		<cfreturn selItems />
	
	</cffunction> 
	<cffunction name="getCyberValue" access="remote" returnFormat="json" output="false">
    	<cfargument name="cyber_liability_amount_id" default="0">
        <cfargument name="property_plan_id" default="0">
		<cfset var items = ArrayNew(1)>
		
		<cfquery name="selItems" datasource="raps">
		select property_cyber_amount
        from property_cyber
        where cyber_liability_amount_id = #ARGUMENTS.cyber_liability_amount_id#
        AND property_plan_id = #ARGUMENTS.property_plan_id#
		</cfquery>		
		<cfreturn selItems />
	
	</cffunction> 
	<cffunction name="getEmpDisValue" access="remote" returnFormat="json" output="false">
    	<cfargument name="employee_dishonesty_id" default="0">
        <cfargument name="property_plan_id" default="0">
		<cfset var items = ArrayNew(1)>
		
		<cfquery name="selItems" datasource="raps">
		select property_emp_amount
        from property_emp
        where employee_dishonesty_id = #ARGUMENTS.employee_dishonesty_id#
        AND property_plan_id = #ARGUMENTS.property_plan_id#
		</cfquery>		
		<cfreturn selItems />
	
	</cffunction>         
	<cffunction name="getClientTypes" output="false">
    	<cfargument name="client_type_id" default="0">
		<cfargument name="disabled" default="0" type="any">
		
		<cfquery name="selItems" datasource="raps">
		select *
        from client_types
        WHERE 1 = 1
        <cfif ARGUMENTS.disabled neq "ALL">
        AND disabled = #ARGUMENTS.disabled#
        </cfif>
        <cfif ARGUMENTS.client_type_id neq 0>
        AND client_type_id = #ARGUMENTS.client_type_id#
        </cfif>        
        ORDER BY type
		</cfquery>		
		<cfreturn selItems />
	
	</cffunction> 
	<cffunction name="getRequestedLimits" output="false">
    	<cfargument name="requested_limits_id" default="0">
		
		<cfquery name="selItems" datasource="raps">
		select *
        from app_requestedlimits
        WHERE 1 = 1
        <cfif ARGUMENTS.requested_limits_id neq 0>
        AND requested_limits_id = #ARGUMENTS.requested_limits_id#
        </cfif>        
        ORDER BY requested_limit
		</cfquery>		
		<cfreturn selItems />
	
	</cffunction>
	<cffunction name="getClientWC" output="false">
    	<cfargument name="client_id" default="0">
		
		<cfquery name="selItems" datasource="raps">
		select *
        from client_wc
        WHERE 1 = 1
        AND client_id = #ARGUMENTS.client_id#     
		</cfquery>		
		<cfreturn selItems />
	
	</cffunction>  
	<cffunction name="getClientLOC" output="false">
    	<cfargument name="client_id" default="0">
			<cfargument name="othertab" default="1">
		<cfquery name="selItems" datasource="raps">
		select *
        from client_loc
        WHERE 1 = 1
        AND client_id = #ARGUMENTS.client_id#  
        AND othertab = #arguments.othertab# 
		</cfquery>		
		<cfreturn selItems />
	
	</cffunction>        
	<cffunction name="getPolicyTypes" output="false">
    	<cfargument name="policy_type_id" default="0">
		
		<cfquery name="selItems" datasource="raps">
		select *
        from policy_types
        WHERE 1 = 1
        <cfif ARGUMENTS.policy_type_id neq 0>
        AND policy_type_id = #ARGUMENTS.policy_type_id#
        </cfif>        
        ORDER BY policy_type
		</cfquery>		
		<cfreturn selItems />
	
	</cffunction> 
	<cffunction name="getGLCredits" output="false">
    	<cfargument name="credit_id" default="0">
		
		<cfquery name="selItems" datasource="raps">
		select *
        from credits
        WHERE 1 = 1
        <cfif ARGUMENTS.credit_id neq 0>
        AND credit_id = #ARGUMENTS.credit_id#
        </cfif>        
        ORDER BY credit_name
		</cfquery>		
		<cfreturn selItems />
	
	</cffunction>     
	<cffunction name="getNIRelationships" output="false">
    	<cfargument name="ni_relationship_id" default="0">
		
		<cfquery name="selItems" datasource="raps">
		select *
        from ni_relationships
        WHERE 1 = 1
        <cfif ARGUMENTS.ni_relationship_id neq 0>
        AND ni_relationship_id = #ARGUMENTS.ni_relationship_id#
        </cfif>        
        ORDER BY ni_relationship
		</cfquery>		
		<cfreturn selItems />
	
	</cffunction>     
	<cffunction name="getLocations" output="false">
		<cfargument name="client_id" required="true">
		<cfquery name="getloc">
    <!---
		select * from (
			select ROW_NUMBER() Over(PARTITION BY l.location_id ORDER BY r.history ASC) as rank,isnull(r.history,0) as history,isnull(r.ratingid,0) as myratingid, l.client_id,l.location_id,l.named_insured as ni,l.address, l.city, l.zip, s.name as statename,  l.location_number,l.description,l.location_status_id,l.exclude_prop,ap.application_id, (SELECT TOP 1 savedatetime from applications where client_id = #arguments.client_id# and ap.history = 0 order by savedatetime desc) as mostrecentsavetime
			from locations l 
			inner join applications ap on ap.location_id=l.location_id
			left join rating  r on ap.application_id=r.application_id
      left join states s on l.state_id = s.state_id
			where l.client_id =#arguments.client_id#
			) as t
		where rank=1--->
    select l.client_id,l.location_id,l.named_insured as ni,l.address, l.city, l.zip, s.name as statename,  l.location_number,l.description,l.location_status_id,l.exclude_prop, isnull((select top 1 application_id from applications where (history = 0 or history is null) and location_id = l.location_id),0) as application_id, isnull((select TOP 1 ratingid from rating where (history = 0 or history is null) and location_id = l.location_id),0) as myratingid, (SELECT TOP 1 savedatetime from applications where client_id = #arguments.client_id# and applications.history = 0 order by savedatetime desc) as mostrecentsavetime
 			from locations l 
      left join states s on l.state_id = s.state_id
			where l.client_id = #arguments.client_id# 
      order by l.location_number asc
		</cfquery>
		<cfreturn getloc />
	</cffunction>
  
<cffunction name="specialReport" output="false" returntype="query">

<cfquery name="data">
select rl.pro_rata_gl, l.location_id, s.name as statename, isnull((select top 1 application_id from applications where (history = 0 or history is null) and location_id = l.location_id),0) as application_id, isnull((select TOP 1 ratingid from rating where (history = 0 or history is null) and location_id = l.location_id),0) as myratingid
from locations l 
inner join clients c on c.client_id = l.client_id
inner join rating r on r.ratingid = isnull((select TOP 1 ratingid from rating where (history = 0 or history is null) and location_id = l.location_id),0)
inner join rating_liability rl on rl.ratingid = r.ratingid
left join states s on l.state_id = s.state_id
where c.client_status_id = 2
and l.location_status_id = 1		
and rl.gldate2 > '2016-05-30'	
order by s.state_id
</cfquery>
<cfreturn data />
</cffunction>
<cffunction name="wcReport" output="false" returntype="query">

<cfquery name="data">
select c.wc_premium, c.client_id, s.name as statename
from clients c 
left join states s on c.mailing_state = s.state_id
where c.client_status_id = 2
and c.current_effective_date > '2015-08-15'	
order by s.state_id
</cfquery>
<cfreturn data />
</cffunction>
<cffunction name="checkactiveLocs" output="yes" returntype="boolean">
<cfargument name="client_id" required="yes" type="numeric">
<cfquery name="data">
SELECT location_id
from locations
where location_status_id = 1  
and client_id = #arguments.client_id#
</cfquery>

<cfif data.recordcount gt 0>
<cfset response = true>
<cfelse>
<cfset response = false>
</cfif>
<cfreturn response />
</cffunction>


  <cffunction name="updatesavetime" output="false">
  <cfargument name="client_id" required="yes">
  <cfargument name="savetime" required="yes">
  <cfquery>
  	Update applications
    set savedatetime = #arguments.savetime#
    where client_id = #arguments.client_id#
    and history= 0
  </cfquery>
  <cfset result = "success">
  <cfreturn result />
  </cffunction>
	<cffunction name="getPropLocations" output="false">
		<cfargument name="client_id" required="true">
        <cfargument name="onlyquote" required="false" default="0">
		<cfquery name="getloc">
		select a.*, b.name as statename
		from locations a
        inner join states b
        on a.state_id = b.state_id
        inner join applications ap 
        on ap.location_id=a.location_id
		where a.client_id = #arguments.client_id#
        <cfif ARGUMENTS.onlyquote is 1>
        AND a.location_status_id = 2
        </cfif>
        and (ap.history = 0 OR ap.history is null)
        and (a.exclude_prop = 0 OR exclude_prop is null)
        and a.location_status_id <> 3
        order by a.location_number asc
		</cfquery>
		<cfreturn getloc />
	</cffunction>  
	<cffunction name="getTerrorismPrem" output="true" returntype="numeric">
			<cfargument name="client_id" required="true">
    	<cfargument name="onlyquote" required="false" default="0">
			<cfset locations = getPropLocations(arguments.client_id,arguments.onlyquote)>
      <cfset totalterrorism = 0>
     
      <cfloop query="locations">
      <cfset rating = getLocationRating(locations.location_id)>
     
      <cfset thisterrorism = round(val(rating.terrorism_fee))>
      <cfset thistotal = calculateTerrorism(thisterrorism,locations.state_id)>
 
      <cfset totalterrorism = thistotal + totalterrorism>
      </cfloop>
		<cfreturn totalterrorism />
	</cffunction>  
<cffunction name="getTerrorismPremOLD" output="false" returntype="numeric">
			<cfargument name="client_id" required="true">
    	<cfargument name="onlyquote" required="false" default="0">
			<cfset locations = getPropLocations(arguments.client_id,arguments.onlyquote)>
      <cfset totalterrorism = 0>
      <cfloop query="locations">
      <cfset rating = getLocationRating(locations.location_id)>
      <cfset thisterrorism = round(val(rating.terrorism_fee))>
      <cfset thisstate = getstates(locations.state_id)>
      <cfset thistaxrate = 1 + thisstate.tax_rate / 100>
      <cfset thistotal = thisterrorism * thistaxrate>
      <cfset totalterrorism = totalterrorism + thistotal>
      </cfloop>
		<cfreturn totalterrorism />
	</cffunction>    
  <cffunction name="calculateTerrorism" output="false" returntype="numeric">
  <cfargument name="terrorism_amount" type="numeric" required="yes">
  <cfargument name="state_id" type="numeric" required="yes">
		<cfset thisstate = getstates(arguments.state_id)>
		<cfset thistaxrate = 1 + thisstate.tax_rate / 100>

		<cfset thisstamping = terrorism_amount * (val(thisstate.stamp_tax) / 100)>
		<cfset thistotal = terrorism_amount * thistaxrate + thisstamping>  
  <cfreturn thistotal />
  </cffunction>
	<cffunction name="getExTerrorismPrem" output="true" returntype="numeric">
			<cfargument name="ue_rate_state" required="true" default="0">
      <cfargument name="ue_premium" required="true" default="0">
      
			<cfset stateinfo = getStates(val(arguments.ue_rate_state))>
      <cfset terrorism = round(val(arguments.ue_premium) * (val(stateinfo.terrorism_fee) / 100))>
      <cfset tax = terrorism * (val(stateinfo.tax_rate) / 100)>
      <cfset stamping = terrorism * (val(stateinfo.stamp_tax) / 100)>
      <cfset totalterrorism = terrorism + tax + stamping>
		<cfreturn totalterrorism />
	</cffunction>    
	<cffunction name="getLocationRating" output="false">
		<cfargument name="location_id" required="true">
		<cfquery name="getloc">
        SELECT TOP 1 a.*, b.*, c.proposal_hide as hide_gl, c.*, d.proposal_hide as hide_prop, d.*, e.name as glissuing, f.name as propissuing, g.*, g.prop_terrorism as propt, h.cyber_liability_amount, i.employee_dishonesty_amount
        FROM rating a
        INNER JOIN rating_liability b
        ON a.ratingid = b.ratingid
        LEFT JOIN liability_plans c
        ON a.liability_plan_id = c.liability_plan_id
        LEFT JOIN property_plans d
        ON a.property_plan_id = d.property_plan_id
        LEFT JOIN issuing_companies e
        ON a.gl_issuing_company_id = e.issuing_company_id
        LEFT JOIN issuing_companies f
        ON a.property_issuing_company_id = f.issuing_company_id
        LEFT JOIN rating_property g
        ON a.ratingid = g.ratingid
        LEFT JOIN app_cyberliability h
        ON h.cyber_liability_amount_id = g.cyber_liability_amount_id
        LEFT JOIN app_employeedishonesty i
        ON i.employee_dishonesty_id = g.employee_dishonesty_id
        WHERE a.location_id = #ARGUMENTS.location_id#
        ORDER BY a.ratingid asc
		</cfquery>
		<cfreturn getloc />
	</cffunction>        
	<cffunction name="getPolicyStatus" output="false">
    	<cfargument name="policy_status_id" default="0">
		
		<cfquery name="selItems" datasource="raps">
		select *
        from policy_status
        WHERE 1 = 1
        <cfif ARGUMENTS.policy_status_id neq 0>
        AND policy_status_id = #ARGUMENTS.policy_status_id#
        </cfif>        
        ORDER BY policy_status
		</cfquery>		
		<cfreturn selItems />
	
	</cffunction> 
	<cffunction name="getOtherLoc" output="false">
    	<cfargument name="other_loc_id" default="0">
		
		<cfquery name="selItems" datasource="raps">
		select other_loc_id, other_loc as loc_name
        from other_loc
        WHERE 1 = 1
        <cfif ARGUMENTS.other_loc_id neq 0>
        AND other_loc_id = #ARGUMENTS.other_loc_id#
        </cfif>        
        ORDER BY other_loc
		</cfquery>		
		<cfreturn selItems />
	
	</cffunction>              
	<cffunction name="getClubLocated" output="false">
    	<cfargument name="club_located_id" default="0">
		
		<cfquery name="selItems" datasource="raps">
		select *
        from app_clublocated
        WHERE 1 = 1
        <cfif ARGUMENTS.club_located_id neq 0>
        AND club_located_id = #ARGUMENTS.club_located_id#
        </cfif>        
        ORDER BY club_located
		</cfquery>		
		<cfreturn selItems />
	
	</cffunction>   
	<cffunction name="getConstructionTypes" output="false">
    	<cfargument name="construction_type_id" default="0">
		
		<cfquery name="selItems" datasource="raps">
		select *
        from app_constructiontypes
        WHERE 1 = 1
        <cfif ARGUMENTS.construction_type_id neq 0>
        AND construction_type_id = #ARGUMENTS.construction_type_id#
        </cfif>        
        ORDER BY construction_type
		</cfquery>		
		<cfreturn selItems />
	
	</cffunction> 
	<cffunction name="getRoofTypes" output="false">
    	<cfargument name="roof_type_id" default="0">
		
		<cfquery name="selItems" datasource="raps">
		select *
        from app_RoofTypes
        WHERE 1 = 1
        <cfif ARGUMENTS.roof_type_id neq 0>
        AND roof_type_id = #ARGUMENTS.roof_type_id#
        </cfif>        
        ORDER BY roof_type
		</cfquery>		
		<cfreturn selItems />
	
	</cffunction>      
	<cffunction name="getCyberLiability" output="false">
    	<cfargument name="cyber_liability_amount_id" default="0">
		<cfargument name="disabled" default="ALL">
		<cfquery name="selItems" datasource="raps">
		select *
        from app_CyberLiability
        WHERE 1 = 1
        <cfif ARGUMENTS.cyber_liability_amount_id neq 0>
        AND cyber_liability_amount_id = #ARGUMENTS.cyber_liability_amount_id#
        </cfif>  
        <cfif ARGUMENTS.disabled neq "ALL">
        AND disabled <> 1
        </cfif>      
        ORDER BY cyber_liability_amount
		</cfquery>		
		<cfreturn selItems />
	
	</cffunction> 
	<cffunction name="getEmployeeDishonesty" output="false">
    	<cfargument name="employee_dishonesty_id" default="0">
		<cfargument name="disabled" default="ALL">
		<cfquery name="selItems" datasource="raps">
		select *
        from app_employeedishonesty
        WHERE 1 = 1
        <cfif ARGUMENTS.employee_dishonesty_id neq 0>
        AND employee_dishonesty_id = #ARGUMENTS.employee_dishonesty_id#
        </cfif>        
        <cfif ARGUMENTS.disabled neq "ALL">
        AND disabled <> 1
        </cfif>
        ORDER BY employee_dishonesty_amount
		</cfquery>		
		<cfreturn selItems />
	
	</cffunction> 
	<cffunction name="getPropertyPlans" output="false">
    	<cfargument name="property_plan_id" default="0">
        <cfargument name="disabled" default="ALL">
		
		<cfquery name="selItems" datasource="raps">
		select *
        from property_plans
        WHERE 1 = 1
        <cfif ARGUMENTS.property_plan_id neq 0>
        AND property_plan_id = #ARGUMENTS.property_plan_id#
        </cfif>   
        <cfif ARGUMENTS.disabled neq "ALL">
        AND disabled <> 1
        </cfif>             
        ORDER BY property_plan_name
		</cfquery>		
		<cfreturn selItems />
	
	</cffunction>     
	<cffunction name="getEPL" output="false">
    	<cfargument name="epl_limits_id" default="0">
		
		<cfquery name="selItems" datasource="raps">
		select *
        from app_epl
        WHERE 1 = 1
        <cfif ARGUMENTS.epl_limits_id neq 0>
        AND epl_limits_id = #ARGUMENTS.epl_limits_id#
        </cfif>        
        ORDER BY epl_limit
		</cfquery>		
		<cfreturn selItems />
	
	</cffunction>                       
	<cffunction name="getAdditionalLimits" output="false">
    	<cfargument name="additional_limits_id" default="0">
		
		
		<cfquery name="selItems" datasource="raps">
		select *
        from app_additionallimits
        WHERE 1 = 1
        <cfif ARGUMENTS.additional_limits_id neq 0>
        AND additional_limits_id = #ARGUMENTS.additional_limits_id#
        </cfif>        
        ORDER BY additional_limits
		</cfquery>		
		<cfreturn selItems />	
	</cffunction> 
	<cffunction name="getTerminationReasons" output="false">
    	<cfargument name="termination_reasons_id" default="0">		
		<cfquery name="selItems" datasource="raps">
		select *
        from client_terminationreasons
        WHERE 1 = 1
        <cfif ARGUMENTS.termination_reasons_id neq 0>
        AND termination_reasons_id = #ARGUMENTS.termination_reasons_id#
        </cfif>        
        ORDER BY termination_reasons
		</cfquery>		
		<cfreturn selItems />	
	</cffunction>     
	<cffunction name="getPolicies" output="false">
    	<cfargument name="client_id" required="yes">
        <cfargument name="policy_id" default="0">
		
		<cfquery name="selItems" datasource="raps">
            select a.policy_id, a.policy_type_id, a.policy_status_id, a.issuing_company_id, a.policy_number as policynumber, CONVERT(VARCHAR(10), 
            a.policy_effectivedate, 101) AS policyeffectivedate, CONVERT(VARCHAR(10), 
            a.policy_expiredate, 101) AS policyexpiredate, CONVERT(VARCHAR(10), a.policy_canceldate, 101) AS policycanceldate, 
            b.policy_type, c.name AS issuing_company, d.policy_status
            from policy_info a
            INNER JOIN policy_types b
            ON a.policy_type_id = b.policy_type_id
            LEFT JOIN issuing_companies c
            ON a.issuing_company_id = c.issuing_company_id
            INNER JOIN policy_status d
            ON a.policy_status_id = d.policy_status_id
            WHERE a.client_id = #ARGUMENTS.client_id#
            <cfif ARGUMENTS.policy_id neq 0>
            AND a.policy_id = #ARGUMENTS.policy_id#
            </cfif>
            ORDER BY a.policy_expiredate DESC
		</cfquery>		
		<cfreturn selItems />
	</cffunction> 
     
	<cffunction name="getEmployeeBenefits" output="false">
    	<cfargument name="employee_rec_benefits_id" default="0">	
		<cfquery name="selItems" datasource="raps">
		select *
        from app_employeerec
        WHERE 1 = 1
        <cfif ARGUMENTS.employee_rec_benefits_id neq 0>
        AND employee_rec_benefits_id = #ARGUMENTS.employee_rec_benefits_id#
        </cfif>        
        ORDER BY employee_rec_benefits
		</cfquery>		
		<cfreturn selItems />	
	</cffunction>  
	<cffunction name="getDocs" output="false">
    	<cfargument name="document_id" default="0">
		<cfquery name="selItems" datasource="raps">
		select *
        from documents
        WHERE 1 = 1
        <cfif ARGUMENTS.document_id neq 0>
        AND document_id = #ARGUMENTS.document_id#
        </cfif>        
        ORDER BY document_name
		</cfquery>		
		<cfreturn selItems />	
	</cffunction> 
                
	<cffunction name="getParentCompanies" output="false">
    	<cfargument name="parent_company_id" default="0">
		<cfargument name="disabled" default="0" type="any">
		
		<cfquery name="selItems" datasource="raps">
		select *
        from parent_companies
        WHERE 1 = 1
        <cfif ARGUMENTS.disabled eq "disabled">
        AND disabled = 1
        <cfelseif ARGUMENTS.disabled eq "active">
        AND (disabled is null OR disabled = 0)
        <cfelse>
        </cfif>
        <cfif ARGUMENTS.parent_company_id neq 0>
        AND parent_company_id = #ARGUMENTS.parent_company_id#
        </cfif>        
        ORDER BY parent_company_name
		</cfquery>		
		<cfreturn selItems />
	
	</cffunction>
	<cffunction name="getIssuingCompanies" output="false">
    	<cfargument name="issuing_company_id" default="0">
		<cfargument name="disabled" default="0" type="any">
		
		<cfquery name="selItems" datasource="raps">
		select *
        from issuing_companies
        WHERE 1 = 1
        <cfif ARGUMENTS.disabled eq "disabled">
        AND disabled = 1
        <cfelseif ARGUMENTS.disabled eq "active">
        AND (disabled is null OR disabled = 0)
        <cfelse>
        </cfif>
        <cfif ARGUMENTS.issuing_company_id neq 0 and trim(ARGUMENTS.issuing_company_id neq '')>
        AND issuing_company_id = #ARGUMENTS.issuing_company_id#
        </cfif>        
        ORDER BY name
		</cfquery>		
		<cfreturn selItems />
	
	</cffunction> 
    <cffunction name="addConsolidate" output="false">
		<cfargument name="client_id1" required="true">
        <cfargument name="client_id2" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfquery datasource="Raps">
        INSERT INTO ue_consolidation (client_id1,client_id2)
        VALUES (#ARGUMENTS.client_id1#,#ARGUMENTS.client_id2#)
		</cfquery>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction> 
    <cffunction name="addEPLIConsolidate" output="false">
		<cfargument name="client_id1" required="true">
        <cfargument name="client_id2" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfquery datasource="Raps">
        INSERT INTO epli_consolidation (client_id1,client_id2)
        VALUES (#ARGUMENTS.client_id1#,#ARGUMENTS.client_id2#)
		</cfquery>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>  
    <cffunction name="addWCConsolidate" output="false">
		<cfargument name="client_id1" required="true">
        <cfargument name="client_id2" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfquery datasource="Raps">
        INSERT INTO wc_consolidation (client_id1,client_id2)
        VALUES (#ARGUMENTS.client_id1#,#ARGUMENTS.client_id2#)
		</cfquery>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>         
    <cffunction name="deleteConsolidation" output="false">
		<cfargument name="ue_consolidation_id" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfquery datasource="Raps">
        DELETE FROM ue_consolidation 
        WHERE ue_consolidation_id = #ARGUMENTS.ue_consolidation_id#
		</cfquery>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction> 
    <cffunction name="deleteContact" output="false">
		<cfargument name="contactid" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfquery datasource="Raps">
        DELETE FROM client_contacts 
        WHERE contactid = #ARGUMENTS.contactid#
		</cfquery>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>   
    <cffunction name="deleteEPLIConsolidation" output="false">
		<cfargument name="epli_consolidation_id" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfquery datasource="Raps">
        DELETE FROM epli_consolidation 
        WHERE epli_consolidation_id = #ARGUMENTS.epli_consolidation_id#
		</cfquery>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>  
    <cffunction name="deleteWCConsolidation" output="false">
		<cfargument name="wc_consolidation_id" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfquery datasource="Raps">
        DELETE FROM wc_consolidation 
        WHERE wc_consolidation_id = #ARGUMENTS.wc_consolidation_id#
		</cfquery>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction> 
    <cffunction name="deletePolicy" output="false">
		<cfargument name="policy_id" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfquery datasource="Raps">
        DELETE FROM policy_info 
        WHERE policy_id = #ARGUMENTS.policy_id#
		</cfquery>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>  
    <cffunction name="deleteNI" output="false">
		<cfargument name="named_insured_id" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfquery datasource="Raps">
        DELETE FROM named_insureds 
        WHERE named_insured_id = #ARGUMENTS.named_insured_id#
		</cfquery>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>                           
	<cffunction name="getCompanyAccordion" output="false">
		<cfargument name="disabled" default="0">
		<cfquery name="selItems" datasource="raps">
        select a.parent_company_id, a.parent_company_name, b.issuing_company_id, b.name, b.code
        from parent_companies a
        left join issuing_companies b
        on a.parent_company_id = b.parent_company_id
        where 1=1
        <cfif ARGUMENTS.disabled eq "disabled">
        AND a.disabled = 1
        OR b.disabled = 1
        <cfelseif ARGUMENTS.disabled eq "active">
        AND (a.disabled is null OR a.disabled = 0)
        AND (b.disabled is null OR b.disabled = 0)
        <cfelse>
        </cfif>
        ORDER BY a.parent_company_name, b.name
		</cfquery>		
		<cfreturn selItems />
	
	</cffunction>                       
	<cffunction name="convertQueryToExtJSGrid" access="public" hint="Convert Query to JSON usable by ExtJS Grid" returntype="array">
		<cfargument name="qryData" type="query" required="true" hint="Query to convert">
		<cfargument name="intStart" type="numeric" required="true" hint="Start of Result Set">
		<cfargument name="intLimit" type="numeric" required="true" hint="How many records to return">
		
		<!--- For the Array --->	
		<cfset var i = 1>		
		<cfset var end = ((Arguments.intStart) + arguments.intLimit)-1>
		<cfset var selItems = "">
		<cfset var stcReturn = "">
		<cfset var items = ArrayNew(1)>

		<cfloop query="qryData" startrow="#Arguments.intStart#" endrow="#end#">		
			<cfset stcItems = StructNew()>
			<cfset stcItems.USER_ID = #qryData.USER_ID#>
            <cfset stcItems.USER_NAME = #qryData.USER_NAME#>
            <cfset stcItems.USER_FIRSTNAME = #qryData.USER_FIRSTNAME#>
            <cfset stcItems.USER_LASTNAME = #qryData.USER_LASTNAME#>
            <cfset stcItems.USER_PASS = #qryData.USER_PASS#>
			<cfset stcItems.USER_FULLNAME = "#qryData.USER_FIRSTNAME# #qryData.USER_LASTNAME#">
            <cfset stcItems.USER_ROLE_NAME = #qryData.USER_ROLE_NAME#>
            <cfset stcItems.USER_ROLE_ID = #qryData.USER_ROLE_ID#>
			<cfset items[i] = stcItems>
			<cfset i = i + 1>			
		</cfloop>
		
		
		<cfreturn items>
		
	</cffunction>   
	<!--- CLIENT FUNCTION --->  
	<cffunction name="getTypes" returntype="query">
		<cfquery name="getTypes">
			select * from client_types
			order by client_type_id DESC
		</cfquery>
		<cfreturn getTypes />
	</cffunction>  
	<cffunction name="getAffiliations" returntype="query">
    <cfargument name="disabled" default="0">
		<cfquery name="getAff">
			select * from client_affiliations
            <cfif ARGUMENTS.disabled neq "ALL">
            WHERE disabled = 0
            </cfif>
			order by code asc
		</cfquery>
		<cfreturn getAff />
	</cffunction>
	<cffunction name="getClientGrid" returntype="query">
        <cfargument name="searchby" required="yes">
        <cfargument name="searchbyother" required="yes">
        <cfargument name="clientsearch" required="yes">
        <cfargument name="search_en" required="yes">
        <cfargument name="search_dba" required="yes">
        <cfargument name="search_ni" required="yes">
        <cfargument name="search_cn" required="yes">
        <cfargument name="search_xref" required="yes">
        <cfargument name="search_status" required="yes">
				 <cfargument name="exact" required="yes">
        <cfif ARGUMENTS.exact neq 1>
        <cfset searchterm = "%#ARGUMENTS.clientsearch#%">
        <cfelse>
        <cfset searchterm = ARGUMENTS.clientsearch>
        </cfif>
        <cfswitch expression="#ARGUMENTS.searchby#">
        <cfcase value="entity_name">
			<cfif arguments.search_cn neq 0>
				<cfquery name="getcn" maxrows="100">
				select client_id from client_contacts
				where name like '#searchterm#'
				</cfquery>
			</cfif>
			
			<cfif arguments.search_ni neq 0>
				<cfquery name="getni" maxrows="100">
				select client_id from locations
				where named_insured like '#searchterm#'
				UNION
				select client_id from named_insureds
				where named_insured like '#searchterm#'
				</cfquery>
			</cfif>
			<cfquery name="namesearch" maxrows="100">
			select c.client_id,c.entity_name,c.dba,c.client_code,c.x_reference,con.name as cname, c.ams
			from clients c
			left join client_contacts con
			on c.client_id=con.client_id
			and con.name = (select top 1 con.name as name from client_contacts con where c.client_id=con.client_id)
            where 1 = 1
            <cfif search_status neq 0>
            and client_status_id = #ARGUMENTS.search_status#
            </cfif>
	                 
	        and entity_name LIKE '#searchterm#'
	 
	        <cfif ARGUMENTS.search_dba neq 0>
	            or dba LIKE '#searchterm#'
	        </cfif>
	        <cfif ARGUMENTS.search_xref neq 0>
	            or x_reference LIKE '#searchterm#'
	        </cfif>
	        
			<cfif arguments.search_cn neq 0 and getcn.recordcount>
				UNION
				select c.client_id,c.entity_name,c.dba,c.client_code,c.x_reference,con.name as cname, c.ams
				from clients c
				left join client_contacts con
				on c.client_id=con.client_id
				and con.name = (select top 1 con.name as name from client_contacts con where c.client_id=con.client_id)
	            where c.client_id in (#valuelist(getcn.client_id)#)
	            <cfif search_status neq 0>
	            and client_status_id = #ARGUMENTS.search_status#
	            </cfif>
	            
			</cfif>
			
			<cfif arguments.search_ni neq 0 and getni.recordcount>
				UNION
				select c.client_id,c.entity_name,c.dba,c.client_code,c.x_reference,con.name as cname, c.ams
				from clients c
				left join client_contacts con
				on c.client_id=con.client_id
				and con.name = (select top 1 con.name as name from client_contacts con where c.client_id=con.client_id)
	            where c.client_id in (#valuelist(getni.client_id)#)
	             <cfif search_status neq 0>
           		and client_status_id = #ARGUMENTS.search_status#
            	</cfif>
				
			</cfif>
      order by client_id desc
			</cfquery> 
			<cfquery dbtype="query" name="qgetClientGrid">
			select * from namesearch order by client_id desc
			</cfquery>
			
			
		</cfcase>
		<cfcase value="more">
			<cfif ARGUMENTS.searchbyother eq 'location_address'>
				<cfquery name="getaddr">
				 select client_id from locations
				 where address like '#searchterm#'
				</cfquery>
				
				<cfquery name="qgetClientGrid" maxrows="100">
				select c.client_id,c.entity_name,c.dba,c.client_code,c.x_reference,con.name as cname, c.ams
				from clients c
				left join client_contacts con
				on c.client_id=con.client_id
				and con.name = (select top 1 con.name as name from client_contacts con where c.client_id=con.client_id)
	            where c.client_id in (#valuelist(getaddr.client_id)#)
	             <cfif search_status neq 0>
            	and client_status_id = #ARGUMENTS.search_status#
            	</cfif>
	            order by c.client_id desc
	            </cfquery>
			<cfelse>
				<cfquery name="qgetClientGrid" maxrows="100">
				select c.client_id,c.entity_name,c.dba,c.client_code,c.x_reference,con.name as cname, c.ams
				from clients c
				left join client_contacts con
				on c.client_id=con.client_id
				and con.name = (select top 1 con.name as name from client_contacts con where c.client_id=con.client_id)
	            where #arguments.searchbyother# like '#searchterm#'
	            <cfif search_status neq 0>
            	and client_status_id = #ARGUMENTS.search_status#
            	</cfif>
	            order by c.client_id desc
	            </cfquery>
			</cfif>
		</cfcase>
		<cfcase value = "ams,client_code">
			
			<cfquery name="qgetClientGrid" maxrows="100">
				select c.client_id,c.entity_name,c.dba,c.client_code,c.x_reference,con.name as cname,c.ams
				from clients c
				left join client_contacts con
				on c.client_id=con.client_id
				and con.name = (select top 1 con.name as name from client_contacts con where c.client_id=con.client_id)
	            where #arguments.searchby# like '#searchterm#'
	             <cfif search_status neq 0>
	            and client_status_id = #ARGUMENTS.search_status#
	            </cfif>
	            order by c.client_id desc
	            </cfquery>
		</cfcase>
        </cfswitch>  

		<cfreturn qgetClientGrid>
	</cffunction>
	<cffunction name="getClient" returntype="query">
		<cfargument name="client_id" required="true">
		<cfquery name="qGetClient">
<!---			select a.*, b.name AS statename, p.policy_type as other_policy
            from clients a
            left join states b
            ON a.mailing_state = b.state_id
            left join policy_types p
            ON a.other_loc = p.policy_type_id--->
			select c.*, (select pl.policy_type from policy_types pl where pl.policy_type_id = c.other_loc) as other_policy,
			(select pl.policy_type from policy_types pl where pl.policy_type_id = c.other2_loc) as other2_policy,		
			(select pl.policy_type from policy_types pl where pl.policy_type_id = c.other3_loc) as other3_policy,
			(select s.name from states s where s.state_id = c.mailing_state) as statename
            from clients c            
			where c.client_id = #arguments.client_id#
            
		</cfquery>
		<cfreturn qGetClient />
	</cffunction>
    
	<cffunction name="creditSearch" returntype="query">
		<cfargument name="term" required="true">
		<cfquery name="getstuff">
			select * from credits
			where credit_name LIKE '%#arguments.term#%'
		</cfquery>
		<cfreturn getstuff />
	</cffunction>    
	<cffunction name="getLocationStatus" returntype="query">
		<cfquery name="locstatus">
			select * from locations_status
		</cfquery>
		<cfreturn locstatus />
	</cffunction>
	<cffunction name="getUserSearchOptions" returntype="query">
		<cfquery name="getData">
			select  *
             from users
            where user_id = #session.auth.id#
		</cfquery>
		<cfreturn getData />
	</cffunction>        
	<cffunction name="getClientContacts" returntype="query">
		<cfargument name="client_id" required="true">
		<cfquery name="qGetClientContacts">
			select * from client_contacts
			where client_id=#arguments.client_id#
      order by contact_order
		</cfquery>
		<cfreturn qGetClientContacts />
	</cffunction>
	<cffunction name="getXrefs" returntype="query">
    <cfargument name="client_id" required="true">
		<cfargument name="x_reference" required="true">
		<cfquery name="items" datasource="Raps">
            select a.x_reference, a.ams, a.client_code, a.client_id, a.entity_name, a.dba, b.name as status, c.address, c.city, c.location_status_id, d.name as state
            from clients a INNER JOIN client_status b
            ON a.client_status_id = b.client_status_id
            LEFT JOIN locations c
            ON a.client_id = c.client_id
            LEFT JOIN states d
            ON c.state_id = d.state_id
            WHERE a.x_reference = '#ARGUMENTS.x_reference#'
            AND a.client_id <> #ARGUMENTS.client_id#
		</cfquery>
		<cfreturn items />
	</cffunction>
    <cffunction name="saveUserSearchOptions" output="false">
		<cfargument name="search_en" required="true">
        <cfargument name="search_dba" required="true">
        <cfargument name="search_ni" required="true">
        <cfargument name="search_cn" required="true">
        <cfargument name="search_xref" required="true">
        <cfargument name="search_status" required="true">
        <cfargument name="searchby" required="true">
        <cfargument name="searchbyother" required="true">
        <cfargument name="exact" required="true">
        <cfparam name="result" default="success">
        <cftry>
		<cfquery>
			update users
            set search_options_en = #ARGUMENTS.search_en#,
            	search_options_dba = #ARGUMENTS.search_dba#,
                search_options_ni = #ARGUMENTS.search_ni#,
                search_options_cn = #ARGUMENTS.search_cn#,
                search_options_xref = #ARGUMENTS.search_xref#,
                search_options_status = #ARGUMENTS.search_status#,
                search_options_searchby = '#ARGUMENTS.searchby#',
                search_options_other = '#ARGUMENTS.searchbyother#',
                search_options_exact = #val(ARGUMENTS.exact)#
            where user_id = #session.auth.id#
		</cfquery>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>
    <cffunction name="saveNotes" output="false">
		<cfargument name="client_id" required="true">
        <cfargument name="client_notes" required="true">
        <cfparam name="result" default="success">
        <cftry>
		<cfquery>
			update clients
            set client_notes = '#ARGUMENTS.client_notes#'
            where client_id = #ARGUMENTS.client_id#
		</cfquery>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction> 
    <cffunction name="saveSticky" output="false">
		<cfargument name="user_id" required="true">
        <cfargument name="pinsticky" required="true">
        <cfparam name="result" default="success">
        <cftry>
		<cfquery>
			update users
            set pinsticky = #ARGUMENTS.pinsticky#
            where user_id = #ARGUMENTS.user_id#
		</cfquery>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>        
    <cffunction name="saveConglom" output="false">
		<cfargument name="affiliation_id" required="true">
        <cfargument name="name" required="true">
        <cfargument name="code" required="true">
        <cfargument name="disabled" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfif ARGUMENTS.affiliation_id is 0>
        <cfquery datasource="Raps">
        INSERT INTO client_affiliations (name,code,disabled)
        VALUES ('#ARGUMENTS.name#','#ARGUMENTS.code#',#ARGUMENTS.disabled#)
		</cfquery>
        <cfelse>
        <cfquery datasource="Raps">
        UPDATE client_affiliations
        SET name = '#ARGUMENTS.name#',
        	 code = '#ARGUMENTS.code#',
             disabled = #ARGUMENTS.disabled#
        WHERE affiliation_id = #ARGUMENTS.affiliation_id#
        </cfquery>
		</cfif>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction> 
    <cffunction name="saveDoc" output="false">
		<cfargument name="document_id" required="true">
        <cfargument name="document_name" required="true">
        <cfargument name="document_file" required="true">
        <cfargument name="delete" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfif ARGUMENTS.document_id is 0 AND ARGUMENTS.delete neq true>
        <cfquery datasource="Raps">
        INSERT INTO documents (document_name,document_file)
        VALUES ('#ARGUMENTS.document_name#','#ARGUMENTS.document_file#')
		</cfquery>
        <cfelseif ARGUMENTS.document_id neq 0 AND ARGUMENTS.delete neq true>
        <cfquery datasource="Raps">
        UPDATE documents
        SET document_name = '#ARGUMENTS.document_name#'<cfif ARGUMENTS.document_file neq ''>,
        	 document_file = '#ARGUMENTS.document_file#'</cfif>
        WHERE document_id = #ARGUMENTS.document_id#
        </cfquery>
        <cfelse>

        <cfquery datasource="Raps">
		delete from documents
        WHERE document_id = #ARGUMENTS.document_id#
        </cfquery>        
		</cfif>
        
        
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>      
    <cffunction name="saveClientType" output="false">
		<cfargument name="client_type_id" required="true">
        <cfargument name="type" required="true">
        <cfargument name="disabled" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfif ARGUMENTS.client_type_id is 0>
        <cfquery datasource="Raps">
        INSERT INTO client_types (type,disabled)
        VALUES ('#ARGUMENTS.type#',#ARGUMENTS.disabled#)
		</cfquery>
        <cfelse>
        <cfquery datasource="Raps">
        UPDATE client_types
        SET type = '#ARGUMENTS.type#',
        disabled = #ARGUMENTS.disabled#
        WHERE client_type_id = #ARGUMENTS.client_type_id#
        </cfquery>
		</cfif>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>  
    <cffunction name="saveRequestedLimits" output="false">
		<cfargument name="requested_limits_id" required="true">
        <cfargument name="requested_limit" required="true">
        <cfargument name="disabled" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfif ARGUMENTS.requested_limits_id is 0>
        <cfquery datasource="Raps">
        INSERT INTO app_requestedlimits (requested_limit,disabled)
        VALUES ('#ARGUMENTS.requested_limit#',#ARGUMENTS.disabled#)
		</cfquery>
        <cfelse>
        <cfquery datasource="Raps">
        UPDATE app_requestedlimits
        SET requested_limit = '#ARGUMENTS.requested_limit#',
        disabled = #ARGUMENTS.disabled#
        WHERE requested_limits_id = #ARGUMENTS.requested_limits_id#
        </cfquery>
		</cfif>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>
    <cffunction name="saveWCOwner" output="false">
		<cfargument name="owner_name" required="true">
        <cfargument name="owner_title" required="true">
        <cfargument name="owner_percent" required="true">
        <cfargument name="owner_salary" required="true">
        <cfargument name="client_id" required="true">
        <cfargument name="client_wc_id" required="true">
        <cfargument name="owner_include" required="true">
        <cfargument name="owner_exclude" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfif ARGUMENTS.client_wc_id is 0>
        <cfquery datasource="Raps">
        INSERT INTO client_wc (owner_name,owner_title,owner_percent,owner_salary,client_id,owner_include,owner_exclude)
        VALUES ('#ARGUMENTS.owner_name#','#ARGUMENTS.owner_title#',#val(ARGUMENTS.owner_percent)#,'#ARGUMENTS.owner_salary#',#ARGUMENTS.client_id#,#ARGUMENTS.owner_include#,#ARGUMENTS.owner_exclude#)
		</cfquery>
        <cfelse>
        <cfquery datasource="Raps">
        UPDATE client_wc
        SET owner_name = '#ARGUMENTS.owner_name#',
        owner_title = '#ARGUMENTS.owner_title#',
        owner_percent = #val(ARGUMENTS.owner_percent)#,
        owner_salary = '#ARGUMENTS.owner_salary#',
        client_id = #ARGUMENTS.client_id#,
        owner_include = #ARGUMENTS.owner_include#,
        owner_exclude = #ARGUMENTS.owner_exclude#
        WHERE client_wc_id = #ARGUMENTS.client_wc_id#
        </cfquery>
		</cfif>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>  
    <cffunction name="deleteWCOwner" >
    <cfargument name="client_wc_id" required="true">
    <cfparam name="result" default="success">
    <cftry>
    <cfquery>
    delete from client_wc
    where client_wc_id = #arguments.client_wc_id#
    </cfquery>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
    </cffunction>   
    <cffunction name="saveLOC" output="true">
		<cfargument name="loc_desc" required="true">
        <cfargument name="loc_amount" required="true">
        <cfargument name="client_loc_id" required="true">
        <cfargument name="client_id" required="true">
        <cfargument name="othertab" required="true">
        <cfparam name="result" default="success">

        <cftry>
        <cfif ARGUMENTS.client_loc_id is 0 and trim(ARGUMENTS.loc_desc) neq '' and trim(ARGUMENTS.loc_amount) neq ''>
    
        <cfquery datasource="Raps">
        INSERT INTO client_loc (loc_desc,loc_amount,client_id,othertab)
        VALUES ('#ARGUMENTS.loc_desc#','#ARGUMENTS.loc_amount#', #val(ARGUMENTS.client_id)#, #val(ARGUMENTS.othertab)#)
		</cfquery>
        <cfelseif ARGUMENTS.client_loc_id neq 0 and trim(ARGUMENTS.loc_desc) neq '' and trim(ARGUMENTS.loc_amount) neq ''>
     
        <cfquery datasource="Raps">
        UPDATE client_loc
        SET loc_desc = '#ARGUMENTS.loc_desc#',
        loc_amount = '#ARGUMENTS.loc_amount#',
        client_id = #ARGUMENTS.client_id#,
        othertab = #val(ARGUMENTS.othertab)#
        WHERE client_loc_id = #ARGUMENTS.client_loc_id#
        </cfquery>
        <cfelse>
  
        <cfquery>
        delete from client_loc
        where client_loc_id = #ARGUMENTS.client_loc_id#
        </cfquery>
		</cfif>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>      
    <cffunction name="savePolicyTypes" output="false">
		<cfargument name="policy_type_id" required="true">
        <cfargument name="policy_type" required="true">
        <cfargument name="disabled" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfif ARGUMENTS.policy_type_id is 0>
        <cfquery datasource="Raps">
        INSERT INTO policy_types (policy_type,disabled)
        VALUES ('#ARGUMENTS.policy_type#',#ARGUMENTS.disabled#)
		</cfquery>
        <cfelse>
        <cfquery datasource="Raps">
        UPDATE policy_types
        SET policy_type = '#ARGUMENTS.policy_type#',
        disabled = #ARGUMENTS.disabled#
        WHERE policy_type_id = #ARGUMENTS.policy_type_id#
        </cfquery>
		</cfif>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>
    <cffunction name="saveGLCredits" output="false">
		<cfargument name="credit_id" required="true">
        <cfargument name="credit_name" required="true">
        <cfargument name="disabled" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfif ARGUMENTS.credit_id is 0>
        <cfquery datasource="Raps">
        INSERT INTO credits (credit_name,disabled)
        VALUES ('#ARGUMENTS.credit_name#',#ARGUMENTS.disabled#)
		</cfquery>
        <cfelse>
        <cfquery datasource="Raps">
        UPDATE credits
        SET credit_name = '#ARGUMENTS.credit_name#',
        disabled = #ARGUMENTS.disabled#
        WHERE credit_id = #ARGUMENTS.credit_id#
        </cfquery>
		</cfif>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>    
    <cffunction name="saveNIRelationships" output="false">
		<cfargument name="ni_relationship_id" required="true">
        <cfargument name="ni_relationship" required="true">
        <cfargument name="disabled" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfif ARGUMENTS.ni_relationship_id is 0>
        <cfquery datasource="Raps">
        INSERT INTO ni_relationships (ni_relationship,disabled)
        VALUES ('#ARGUMENTS.ni_relationship#',#ARGUMENTS.disabled#)
		</cfquery>
        <cfelse>
        <cfquery datasource="Raps">
        UPDATE ni_relationships
        SET ni_relationship = '#ARGUMENTS.ni_relationship#',
        disabled = #ARGUMENTS.disabled#
        WHERE ni_relationship_id = #ARGUMENTS.ni_relationship_id#
        </cfquery>
		</cfif>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>    
    <cffunction name="savePolicyStatus" output="false">
		<cfargument name="policy_status_id" required="true">
        <cfargument name="policy_status" required="true">
        <cfargument name="disabled" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfif ARGUMENTS.policy_status_id is 0>
        <cfquery datasource="Raps">
        INSERT INTO policy_status (policy_status,disabled)
        VALUES ('#ARGUMENTS.policy_status#',#ARGUMENTS.disabled#)
		</cfquery>
        <cfelse>
        <cfquery datasource="Raps">
        UPDATE policy_status
        SET policy_status = '#ARGUMENTS.policy_status#',
        disabled = #ARGUMENTS.disabled#
        WHERE policy_status_id = #ARGUMENTS.policy_status_id#
        </cfquery>
		</cfif>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction> 
    <cffunction name="saveOtherLoc" output="false">
		<cfargument name="other_loc_id" required="true">
        <cfargument name="other_loc" required="true">
        <cfargument name="disabled" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfif ARGUMENTS.other_loc_id is 0>
        <cfquery datasource="Raps">
        INSERT INTO other_loc (other_loc,disabled)
        VALUES ('#ARGUMENTS.other_loc#',#ARGUMENTS.disabled#)
		</cfquery>
        <cfelse>
        <cfquery datasource="Raps">
        UPDATE other_loc
        SET other_loc = '#ARGUMENTS.other_loc#',
        disabled = #ARGUMENTS.disabled#
        WHERE other_loc_id = #ARGUMENTS.other_loc_id#
        </cfquery>
		</cfif>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>            
    <cffunction name="saveClubLocated" output="false">
		<cfargument name="club_located_id" required="true">
        <cfargument name="club_located" required="true">
        <cfargument name="disabled" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfif ARGUMENTS.club_located_id is 0>
        <cfquery datasource="Raps">
        INSERT INTO app_clublocated (club_located,disabled)
        VALUES ('#ARGUMENTS.club_located#',#ARGUMENTS.disabled#)
		</cfquery>
        <cfelse>
        <cfquery datasource="Raps">
        UPDATE app_clublocated
        SET club_located = '#ARGUMENTS.club_located#',
        disabled = #ARGUMENTS.disabled#
        WHERE club_located_id = #ARGUMENTS.club_located_id#
        </cfquery>
		</cfif>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>  
    <cffunction name="saveConstructionTypes" output="false">
		<cfargument name="construction_type_id" required="true">
        <cfargument name="construction_type" required="true">
        <cfargument name="disabled" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfif ARGUMENTS.construction_type_id is 0>
        <cfquery datasource="Raps">
        INSERT INTO app_constructiontypes (construction_type,disabled)
        VALUES ('#ARGUMENTS.construction_type#',#ARGUMENTS.disabled#)
		</cfquery>
        <cfelse>
        <cfquery datasource="Raps">
        UPDATE app_constructiontypes
        SET construction_type = '#ARGUMENTS.construction_type#',
        disabled = #ARGUMENTS.disabled#
        WHERE construction_type_id = #ARGUMENTS.construction_type_id#
        </cfquery>
		</cfif>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>  
    <cffunction name="saveRoofTypes" output="false">
		<cfargument name="roof_type_id" required="true">
        <cfargument name="roof_type" required="true">
        <cfargument name="disabled" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfif ARGUMENTS.roof_type_id is 0>
        <cfquery datasource="Raps">
        INSERT INTO app_RoofTypes (roof_type,disabled)
        VALUES ('#ARGUMENTS.roof_type#',#ARGUMENTS.disabled#)
		</cfquery>
        <cfelse>
        <cfquery datasource="Raps">
        UPDATE app_RoofTypes
        SET roof_type = '#ARGUMENTS.roof_type#',
        disabled = #ARGUMENTS.disabled#
        WHERE roof_type_id = #ARGUMENTS.roof_type_id#
        </cfquery>
		</cfif>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>      
    <cffunction name="saveCyberLiability" output="false">
		<cfargument name="cyber_liability_amount_id" required="true">
        <cfargument name="cyber_liability_amount" required="true">
        <cfargument name="disabled" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfif ARGUMENTS.cyber_liability_amount_id is 0>
        <cfquery datasource="Raps">
        INSERT INTO app_CyberLiability (cyber_liability_amount,disabled)
        VALUES ('#ARGUMENTS.cyber_liability_amount#',#ARGUMENTS.disabled#)
		</cfquery>
        <cfelse>
        <cfquery datasource="Raps">
        UPDATE app_CyberLiability
        SET cyber_liability_amount = '#ARGUMENTS.cyber_liability_amount#',
        disabled = #ARGUMENTS.disabled#
        WHERE cyber_liability_amount_id = #ARGUMENTS.cyber_liability_amount_id#
        </cfquery>
		</cfif>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction> 
    <cffunction name="saveProposalDocs" output="false">
		<cfargument name="proposal_doc_id" required="true">
        <cfargument name="proposal_doc_name" required="true">
        <cfargument name="proposal_doc_content" required="true">
        <cfargument name="editable" required="true">
        <cfargument name="defaultcheck" required="true">
        <cfargument name="disabled" required="true">
        <cfargument name="includes_list" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfif ARGUMENTS.proposal_doc_id is 0>
        <cfquery datasource="Raps">
        INSERT INTO proposal_docs (proposal_doc_name,proposal_doc_content,editable,defaultcheck,disabled,includes_list)
        VALUES ('#ARGUMENTS.proposal_doc_name#','#ARGUMENTS.proposal_doc_content#',#ARGUMENTS.editable#,#ARGUMENTS.defaultcheck#,#ARGUMENTS.disabled#,#ARGUMENTS.includes_list#)
		</cfquery>
        <cfelse>
        <cfquery datasource="Raps">
        UPDATE proposal_docs
        SET proposal_doc_name = '#ARGUMENTS.proposal_doc_name#',
        proposal_doc_content = '#ARGUMENTS.proposal_doc_content#',
        editable = #ARGUMENTS.editable#,
        defaultcheck = #ARGUMENTS.defaultcheck#,
        disabled = #ARGUMENTS.disabled#,
        includes_list = #ARGUMENTS.includes_list#
        WHERE proposal_doc_id = #ARGUMENTS.proposal_doc_id#
        </cfquery>
		</cfif>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction> 
    <cffunction name="saveProposalOrder" output="false">
		<cfargument name="proposal_doc_id" required="true">
        <cfargument name="proposal_doc_order" required="true">
 
        <cfparam name="result" default="success">
        <cftry>
        <cfquery datasource="Raps">
        UPDATE proposal_docs
        SET proposal_doc_order = #ARGUMENTS.proposal_doc_order#
        WHERE proposal_doc_id = #ARGUMENTS.proposal_doc_id#
        </cfquery>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>         
    <cffunction name="saveEDP" output="false">
		<cfargument name="edp_amount_id" required="true">
        <cfargument name="edp_amount" required="true">
        <cfargument name="disabled" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfif ARGUMENTS.edp_amount_id is 0>
        <cfquery datasource="Raps">
        INSERT INTO app_EDP (edp_amount,disabled)
        VALUES ('#ARGUMENTS.edp_amount#',#ARGUMENTS.disabled#)
		</cfquery>
        <cfelse>
        <cfquery datasource="Raps">
        UPDATE app_EDP
        SET edp_amount = '#ARGUMENTS.edp_amount#',
        disabled = #ARGUMENTS.disabled#
        WHERE edp_amount_id = #ARGUMENTS.edp_amount_id#
        </cfquery>
		</cfif>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction> 
    <cffunction name="saveEmployeeDishonesty" output="false">
		<cfargument name="employee_dishonesty_id" required="true">
        <cfargument name="employee_dishonesty_amount" required="true">
        <cfargument name="disabled" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfif ARGUMENTS.employee_dishonesty_id is 0>
        <cfquery datasource="Raps">
        INSERT INTO app_employeedishonesty (employee_dishonesty_amount,disabled)
        VALUES ('#ARGUMENTS.employee_dishonesty_amount#',#ARGUMENTS.disabled#)
		</cfquery>
        <cfelse>
        <cfquery datasource="Raps">
        UPDATE app_employeedishonesty
        SET employee_dishonesty_amount = '#ARGUMENTS.employee_dishonesty_amount#',
        disabled = #ARGUMENTS.disabled#
        WHERE employee_dishonesty_id = #ARGUMENTS.employee_dishonesty_id#
        </cfquery>
		</cfif>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction> 
    <cffunction name="getProposalDocs" output="false">
		<cfargument name="proposal_doc_id" default="0">
        <cfargument name="disabled" default="ALL">

        <cfquery datasource="Raps" name="data">
        SELECT *
        FROM proposal_docs
        WHERE 1=1
        <cfif ARGUMENTS.proposal_doc_id neq 0>
        AND proposal_doc_id = #ARGUMENTS.proposal_doc_id#
        </cfif>
        <cfif ARGUMENTS.disabled neq "ALL">
        and disabled <> 1
        </cfif>
        order by proposal_doc_order asc
        </cfquery>

        <cfreturn data />
	</cffunction>      
    <cffunction name="savePropertyPlans" output="false">
		<cfargument name="property_plan_id" required="true">
        <cfargument name="property_plan_name" required="true">
        <!---<cfargument name="prop_premium" required="true">--->
        <cfargument name="prop_agencyfee" required="true">
        <cfargument name="prop_terrorism" required="true">
        <cfargument name="prop_eqpbrkrate" required="true">
        <cfargument name="disabled" required="true">
        <cfargument name="proposal_hide" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfif ARGUMENTS.property_plan_id is 0>
        <cfquery datasource="Raps" name="query">
        INSERT INTO property_plans (property_plan_name,prop_agencyfee,prop_terrorism,prop_eqpbrkrate,disabled,proposal_hide)
        VALUES ('#ARGUMENTS.property_plan_name#',#val(ARGUMENTS.prop_agencyfee)#,#val(ARGUMENTS.prop_terrorism)#,#val(ARGUMENTS.prop_eqpbrkrate)#,#ARGUMENTS.disabled#,#ARGUMENTS.proposal_hide#)
        SELECT @@IDENTITY AS 'newid';
		</cfquery>
        <cfset result = query.newid>
        <cfelse>
        <cfquery datasource="Raps">
        UPDATE property_plans
        SET property_plan_name = '#ARGUMENTS.property_plan_name#',
            prop_agencyfee = #val(ARGUMENTS.prop_agencyfee)#,
            prop_terrorism = #val(ARGUMENTS.prop_terrorism)#,
            prop_eqpbrkrate = #val(ARGUMENTS.prop_eqpbrkrate)#,
        	disabled = #ARGUMENTS.disabled#,
          proposal_hide = #ARGUMENTS.proposal_hide#
        WHERE property_plan_id = #ARGUMENTS.property_plan_id#
        </cfquery>
		</cfif>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>    
    <cffunction name="savePropertyCyber" output="false">
		<cfargument name="property_plan_id" required="true">
        <cfargument name="cyber_liability_amount_id" required="true">
        <cfargument name="property_cyber_amount" required="true">
        <cfargument name="property_cyber_id" required="true">
        <cfparam name="result" default="success">
        <cftry>
		<cfif ARGUMENTS.property_cyber_id is 0>
        <cfquery datasource="raps">
        INSERT INTO property_cyber (property_plan_id,cyber_liability_amount_id,property_cyber_amount)
        VALUES (#val(ARGUMENTS.property_plan_id)#,#val(ARGUMENTS.cyber_liability_amount_id)#,#val(ARGUMENTS.property_cyber_amount)#)
        </cfquery>	
        <cfelse>
        <cfquery datasource="raps">
        UPDATE property_cyber
        SET property_plan_id = #val(ARGUMENTS.property_plan_id)#,
        cyber_liability_amount_id = #val(ARGUMENTS.cyber_liability_amount_id)#,
        property_cyber_amount = #val(ARGUMENTS.property_cyber_amount)#
        WHERE property_cyber_id = #val(ARGUMENTS.property_cyber_id)#
        </cfquery>
        </cfif>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>  
    <cffunction name="savePropertyEmp" output="false">
		<cfargument name="property_plan_id" required="true">
        <cfargument name="employee_dishonesty_id" required="true">
        <cfargument name="property_emp_amount" required="true">
        <cfargument name="property_emp_id" required="true">
        <cfparam name="result" default="success">
        <cftry>
		<cfif ARGUMENTS.property_emp_id is 0>
        <cfquery datasource="raps">
        INSERT INTO property_emp (property_plan_id,employee_dishonesty_id,property_emp_amount)
        VALUES (#val(ARGUMENTS.property_plan_id)#,#val(ARGUMENTS.employee_dishonesty_id)#,#val(ARGUMENTS.property_emp_amount)#)
        </cfquery>	
        <cfelse>
        <cfquery datasource="raps">
        UPDATE property_emp
        SET property_plan_id = #val(ARGUMENTS.property_plan_id)#,
        employee_dishonesty_id = #val(ARGUMENTS.employee_dishonesty_id)#,
        property_emp_amount = #val(ARGUMENTS.property_emp_amount)#
        WHERE property_emp_id = #val(ARGUMENTS.property_emp_id)#
        </cfquery>
        </cfif>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>                 
    <cffunction name="saveEPL" output="false">
		<cfargument name="epl_limits_id" required="true">
        <cfargument name="epl_limit" required="true">
        <cfargument name="disabled" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfif ARGUMENTS.epl_limits_id is 0>
        <cfquery datasource="Raps">
        INSERT INTO app_epl (epl_limit,disabled)
        VALUES ('#ARGUMENTS.epl_limit#',#ARGUMENTS.disabled#)
		</cfquery>
        <cfelse>
        <cfquery datasource="Raps">
        UPDATE app_epl
        SET epl_limit = '#ARGUMENTS.epl_limit#',
        disabled = #ARGUMENTS.disabled#
        WHERE epl_limits_id = #ARGUMENTS.epl_limits_id#
        </cfquery>
		</cfif>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>                       
    <cffunction name="saveAdditionalLimits" output="false">
		<cfargument name="additional_limits_id" required="true">
        <cfargument name="additional_limits" required="true">
        <cfargument name="disabled" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfif ARGUMENTS.additional_limits_id is 0>
        <cfquery datasource="Raps">
        INSERT INTO app_additionallimits (additional_limits,disabled)
        VALUES ('#ARGUMENTS.additional_limits#',#ARGUMENTS.disabled#)
		</cfquery>
        <cfelse>
        <cfquery datasource="Raps">
        UPDATE app_additionallimits
        SET additional_limits = '#ARGUMENTS.additional_limits#',
        disabled = #ARGUMENTS.disabled#
        WHERE additional_limits_id = #ARGUMENTS.additional_limits_id#
        </cfquery>
		</cfif>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>
    <cffunction name="saveTerminationReasons" output="false">
		<cfargument name="termination_reasons_id" required="true">
        <cfargument name="termination_reasons" required="true">
        <cfargument name="disabled" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfif ARGUMENTS.termination_reasons_id is 0>
        <cfquery datasource="Raps">
        INSERT INTO client_terminationreasons (termination_reasons,disabled)
        VALUES ('#ARGUMENTS.termination_reasons#',#ARGUMENTS.disabled#)
		</cfquery>
        <cfelse>
        <cfquery datasource="Raps">
        UPDATE client_terminationreasons
        SET termination_reasons = '#ARGUMENTS.termination_reasons#',
        disabled = #ARGUMENTS.disabled#
        WHERE termination_reasons_id = #ARGUMENTS.termination_reasons_id#
        </cfquery>
		</cfif>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>    
    <cffunction name="savePolicy" output="false">
        <cfargument name="client_id" required="true">
		<cfargument name="policy_id" required="true">
        <cfargument name="policy_type_id" required="true">
        <cfargument name="policy_effectivedate" required="true">
        <cfargument name="policy_expiredate" required="true">
        <cfargument name="policy_number" required="true">
        <cfargument name="issuing_company_id" required="true">
        <cfargument name="policy_status_id" required="true">
        <cfargument name="policy_canceldate" required="true">
        <cfargument name="result" default="success">
        <cftry>
        <cfif ARGUMENTS.policy_id is 0>
        <cfquery datasource="Raps">
        INSERT INTO policy_info (client_id,policy_type_id,policy_effectivedate,policy_expiredate,policy_number,issuing_company_id,policy_status_id<cfif trim(ARGUMENTS.policy_canceldate) neq ''>,policy_canceldate</cfif>)
        VALUES 		
        (#ARGUMENTS.client_id#,
        #ARGUMENTS.policy_type_id#,
        '#ARGUMENTS.policy_effectivedate#',
        '#ARGUMENTS.policy_expiredate#',
        '#ARGUMENTS.policy_number#',
        #ARGUMENTS.issuing_company_id#,
        #ARGUMENTS.policy_status_id#
        <cfif trim(ARGUMENTS.policy_canceldate) neq ''>,'#ARGUMENTS.policy_canceldate#'</cfif>)
		</cfquery>
        <cfelse>
        <cfquery datasource="Raps">
        UPDATE policy_info
        SET client_id = #ARGUMENTS.client_id#,
        policy_type_id = #ARGUMENTS.policy_type_id#,
        policy_effectivedate = '#ARGUMENTS.policy_effectivedate#',
        policy_expiredate = '#ARGUMENTS.policy_expiredate#',
        policy_number = '#ARGUMENTS.policy_number#',
        issuing_company_id = #ARGUMENTS.issuing_company_id#,
        policy_status_id = #ARGUMENTS.policy_status_id#,
        policy_canceldate = <cfif trim(ARGUMENTS.policy_canceldate) neq ''>'#ARGUMENTS.policy_canceldate#'<cfelse>null</cfif>
        WHERE policy_id = #ARGUMENTS.policy_id#
        </cfquery>
		</cfif>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>     
    <cffunction name="changePolicyStatus" output="false">
        <cfargument name="renewed_policy_id" required="true">
        <cfargument name="result" default="success">
        <cftry>

        <cfquery datasource="Raps">
        UPDATE policy_info
        SET policy_status_id = 3
        WHERE policy_id = #ARGUMENTS.renewed_policy_id#
        </cfquery>

        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>     
    <cffunction name="saveNI" output="false">
        <cfargument name="client_id" required="true">
		<cfargument name="named_insured_id" required="true">
        <cfargument name="named_insured" required="true">
        <cfargument name="relationship" required="true">
        <cfargument name="notes" required="true">
        <cfargument name="ni_fein" required="true">
        <cfargument name="yearstarted" required="true">
        <cfargument name="gl" required="true">
        <cfargument name="property" required="true">
        <cfargument name="ue" required="true">
        <cfargument name="wc" required="true">
        <cfargument name="epli" required="true">
        <cfargument name="cyber" required="true">
        <cfargument name="result" default="success">
        <cftry>
        <cfif ARGUMENTS.named_insured_id is 0>
        <cfquery datasource="Raps">
        INSERT INTO named_insureds (client_id,named_insured,relationship,notes,ni_fein,yearstarted,gl,property,ue,wc,epli,cyber)
        VALUES 		
        (#ARGUMENTS.client_id#,
        '#ARGUMENTS.named_insured#',
        #val(ARGUMENTS.relationship)#,
        '#ARGUMENTS.notes#',
        '#ARGUMENTS.ni_fein#',
        '#ARGUMENTS.yearstarted#',
        #val(ARGUMENTS.gl)#,
        #val(ARGUMENTS.property)#,
        #val(ARGUMENTS.ue)#,
        #val(ARGUMENTS.wc)#,
        #val(ARGUMENTS.epli)#,
        #val(ARGUMENTS.cyber)#
        )
		</cfquery>
        <cfelse>
        <cfquery datasource="Raps">
        UPDATE named_insureds
        SET client_id = #ARGUMENTS.client_id#,
        named_insured = '#ARGUMENTS.named_insured#',
        relationship = #val(ARGUMENTS.relationship)#,
        notes = '#ARGUMENTS.notes#',
        ni_fein = '#ARGUMENTS.ni_fein#',
        yearstarted = '#ARGUMENTS.yearstarted#',
        gl = #val(ARGUMENTS.gl)#,
        property = #val(ARGUMENTS.property)#,
        ue = #val(ARGUMENTS.ue)#,
        wc = #val(ARGUMENTS.wc)#,
        epli = #val(ARGUMENTS.epli)#,
        cyber = #val(ARGUMENTS.cyber)#
        WHERE named_insured_id = #ARGUMENTS.named_insured_id#
        </cfquery>
		</cfif>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>         
    <cffunction name="saveEmployeeBenefits" output="false">
		<cfargument name="employee_rec_benefits_id" required="true">
        <cfargument name="employee_rec_benefits" required="true">
        <cfargument name="disabled" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfif ARGUMENTS.employee_rec_benefits_id is 0>
        <cfquery datasource="Raps">
        INSERT INTO app_employeerec (employee_rec_benefits,disabled)
        VALUES ('#ARGUMENTS.employee_rec_benefits#',#ARGUMENTS.disabled#)
		</cfquery>
        <cfelse>
        <cfquery datasource="Raps">
        UPDATE app_employeerec
        SET employee_rec_benefits = '#ARGUMENTS.employee_rec_benefits#',
        disabled = #ARGUMENTS.disabled#
        WHERE employee_rec_benefits_id = #ARGUMENTS.employee_rec_benefits_id#
        </cfquery>
		</cfif>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>          
    <cffunction name="saveParentCompany" output="false">
		<cfargument name="parent_company_id" required="true">
        <cfargument name="parent_company_name" required="true"> 
        <cfargument name="disabled" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfif ARGUMENTS.parent_company_id is 0>
        <cfquery datasource="Raps">
        INSERT INTO parent_companies (parent_company_name,disabled)
        VALUES ('#ARGUMENTS.parent_company_name#',#ARGUMENTS.disabled#)
		</cfquery>
        <cfelse>
        <cfquery datasource="Raps">
        UPDATE parent_companies
        SET parent_company_name = '#ARGUMENTS.parent_company_name#',
        disabled = #ARGUMENTS.disabled#
        WHERE parent_company_id = #ARGUMENTS.parent_company_id#
        </cfquery>
		</cfif>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction> 
    <cffunction name="saveIssuingCompany" output="false">
    	<cfargument name="issuing_company_id" required="true">
		<cfargument name="parent_company_id" required="true">
        <cfargument name="name" required="true">
        <cfargument name="code" required="true"> 
        <cfargument name="disabled" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfif ARGUMENTS.issuing_company_id is 0>
        <cfquery datasource="Raps">
        INSERT INTO issuing_companies (parent_company_id,name,code,disabled)
        VALUES (#ARGUMENTS.parent_company_id#,'#ARGUMENTS.name#','#ARGUMENTS.code#',#ARGUMENTS.disabled#)
		</cfquery>
        <cfelse>
        <cfquery datasource="Raps">
        UPDATE issuing_companies
        SET parent_company_id = #ARGUMENTS.parent_company_id#,
        name = '#ARGUMENTS.name#',
        code = '#ARGUMENTS.code#',
        disabled = #ARGUMENTS.disabled#
        WHERE issuing_company_id = #ARGUMENTS.issuing_company_id#
        </cfquery>
		</cfif>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction> 
    <cffunction name="saveLocationStatus" output="false">
    	<cfargument name="location_id" required="true">
		<cfargument name="location_status_id" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfquery datasource="Raps">
		UPDATE locations
        SET location_status_id = #ARGUMENTS.location_status_id#
        WHERE location_id = #ARGUMENTS.location_id#
		</cfquery>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>
    <cffunction name="saveLocationExclude" output="false">
    	<cfargument name="location_id" required="true">
		<cfargument name="exclude_prop" required="true">
        <cfparam name="result" default="success">
        <cftry>
        <cfquery datasource="Raps">
		UPDATE locations
        SET exclude_prop = #ARGUMENTS.exclude_prop#
        WHERE location_id = #ARGUMENTS.location_id#
		</cfquery>
        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>                     
    <cffunction name="saveState" output="false">
		<cfargument name="state_id" required="true">
        <cfargument name="tax_rate" required="true">
        <cfargument name="stamp_tax" required="true">
        <cfargument name="filing_fee" required="true">
        <cfargument name="broker_policy_fee" required="true">
        <cfargument name="inspection_fee" required="true">
        <cfargument name="rpg_fee" required="true">
        <cfargument name="custom_tax_1_label" required="true">
        <cfargument name="custom_tax_1" required="true">
        <cfargument name="custom_tax_1_type" required="true">
        <cfargument name="custom_tax_2_label" required="true">
        <cfargument name="custom_tax_2" required="true">
        <cfargument name="custom_tax_2_type" required="true">
        <cfargument name="custom_tax_3_label" required="true">
        <cfargument name="custom_tax_3" required="true">
        <cfargument name="custom_tax_3_type" required="true">
        <cfargument name="custom_tax_4_label" required="true">
        <cfargument name="custom_tax_4" required="true">
        <cfargument name="custom_tax_4_type" required="true">
        <cfargument name="custom_tax_5_label" required="true">
        <cfargument name="custom_tax_5" required="true">
        <cfargument name="custom_tax_5_type" required="true">
       <!--- <cfargument name="terrorism_fee" required="true">--->
        <cfargument name="calculation" required="true">
        <cfargument name="notes" required="true">
        <cfargument name="prop_tax" required="true">
        <!---<cfargument name="prop_fees" required="true">--->
        <cfargument name="prop_notes" required="true">
        <cfargument name="prop_min_premium" required="true">
        
        <cfparam name="result" default="success">
        
        <cftry>

        <cfquery datasource="Raps">
        UPDATE states
        SET tax_rate = #val(ARGUMENTS.tax_rate)#,
        	 stamp_tax = #val(ARGUMENTS.stamp_tax)#,
             filing_fee = #val(ARGUMENTS.filing_fee)#,
             broker_policy_fee = #val(ARGUMENTS.broker_policy_fee)#,
             inspection_fee = #val(ARGUMENTS.inspection_fee)#,
             rpg_fee = #val(ARGUMENTS.rpg_fee)#,
             custom_tax_1_label = '#ARGUMENTS.custom_tax_1_label#',
             custom_tax_1 = #val(ARGUMENTS.custom_tax_1)#,
             custom_tax_1_type = '#ARGUMENTS.custom_tax_1_type#',
             custom_tax_2_label = '#ARGUMENTS.custom_tax_2_label#',
             custom_tax_2 = #val(ARGUMENTS.custom_tax_2)#,
             custom_tax_2_type = '#ARGUMENTS.custom_tax_2_type#',
             custom_tax_3_label = '#ARGUMENTS.custom_tax_3_label#',
             custom_tax_3 = #val(ARGUMENTS.custom_tax_3)#,
             custom_tax_3_type = '#ARGUMENTS.custom_tax_3_type#',
             custom_tax_4_label = '#ARGUMENTS.custom_tax_4_label#',
             custom_tax_4 = #val(ARGUMENTS.custom_tax_4)#,
             custom_tax_4_type = '#ARGUMENTS.custom_tax_4_type#',
             custom_tax_5_label = '#ARGUMENTS.custom_tax_5_label#',
             custom_tax_5 = #val(ARGUMENTS.custom_tax_5)#,
             custom_tax_5_type = '#ARGUMENTS.custom_tax_5_type#',
             <!---terrorism_fee = #val(ARGUMENTS.terrorism_fee)#,--->
             calculation = '#ARGUMENTS.calculation#',
             notes = '#ARGUMENTS.notes#',
             prop_tax = #val(ARGUMENTS.prop_tax)#,
            <!--- prop_fees = #val(ARGUMENTS.prop_fees)#,--->
             prop_notes = '#ARGUMENTS.prop_notes#',
             prop_min_premium = #val(ARGUMENTS.prop_min_premium)#
        WHERE state_id = #ARGUMENTS.state_id#
        </cfquery>

        <cfcatch type="any"><cfset result="#cfcatch.Message# - #cfcatch.Detail#"></cfcatch>
        </cftry>
        <cfreturn result />
	</cffunction>             
	<cffunction name ="addClient" output="false" access="remote">
		<cfargument name="affiliation_id" required="yes" default="">
		<cfargument name="client_type_id" required="yes" default="">
		<cfargument name="ams" required="no" default="">
		<cfargument name="am" required="no" default="0">
        <cfargument name="client_code" required="no" default="">
		<cfargument name="entity_name" required="no" default="">
		<cfargument name="dba" required="no" default="">
		<cfargument name="mailing_address" required="no" default="">
		<cfargument name="mailing_address2" required="no" default="">
		<cfargument name="mailing_city" required="no" default="">
		<cfargument name="mailing_state" required="no" default="">
		<cfargument name="mailing_zip" required="no" default="">
		<cfargument name="business_phone" required="no" default="">
		<cfargument name="business_email" required="no" default="">
		<cfargument name="website" required="no" default="">
		<cfargument name="fein" required="no" default="">
		<cfargument name="year_business_started" required="no" default="">
		<cfargument name="years_experience" required="no" default="">
		<cfargument name="x_reference" required="no" default="">
		<cfargument name="client_status_id" required="no" default="">
		<cfargument name="current_effective_date" required="no" default="">
        <cfargument name="ue_type" required="no" default="">
        <cfargument name="ue_date1" required="no" default="">
        <cfargument name="ue_date2" required="no" default="">
        <cfargument name="ue_issuing_company" required="no" default="0">
        <cfargument name="ue_occurrence" required="no" default="">
        <cfargument name="ue_aggregate" required="no" default="">
        <cfargument name="ue_retention" required="no" default="">
        <cfargument name="ue_premium" required="no" default="0">
        <cfargument name="ue_brokerfee" required="no" default="0">
        <cfargument name="ue_agencyfee" required="no" default="0">
        <cfargument name="ue_filingfee" required="no" default="0">
        <cfargument name="ue_stampingfee" required="no" default="0">
        <cfargument name="ue_sltax" required="no" default="0">
        <cfargument name="ue_totalpremium" required="no" default="0">
        <cfargument name="ue_declined" required="no" default="0">
        <cfargument name="ue_declinedreason" required="no" default="">
        <cfargument name="ue_proposalnotes" required="no" default=""> 
        <cfargument name="ue_rate_state" required="no" default="0">
        <!---
        <cfargument name="ue_rate_sltax" required="no" default="0">
        <cfargument name="ue_rate_filingfee" required="no" default="0">
        <cfargument name="ue_rate_stampingfee" required="no" default="0">
        <cfargument name="ue_rate_statesurcharge" required="no" default="0">
        <cfargument name="ue_rate_munisurcharge" required="no" default="0">  
				--->
        <cfargument name="epli_date1" required="no" default="">
        <cfargument name="epli_date2" required="no" default="">
        <cfargument name="epli_retrodate" required="no" default="">
        <cfargument name="epli_prioracts" required="no" default="0">
        <cfargument name="epli_issuing_company" required="no" default="0">        
        <cfargument name="epli_aggregate" required="no" default="">
        <cfargument name="epli_retention" required="no" default="">
        <cfargument name="epli_doincluded" required="no" default="0">
        <cfargument name="epli_aggregate2" required="no" default="">
        <cfargument name="epli_retention2" required="no" default="0"> 
        <cfargument name="epli_fulltime" required="no" default="0">
        <cfargument name="epli_partime" required="no" default="0">
        <cfargument name="epli_totalemployees" required="no" default="0">                
        <cfargument name="epli_premium" required="no" default="0">
        <cfargument name="epli_brokerfee" required="no" default="0">
        <cfargument name="epli_agencyfee" required="no" default="0">
        <cfargument name="epli_filingfee" required="no" default="0">
        <cfargument name="epli_sltax" required="no" default="0">
        <cfargument name="epli_totalpremium" required="no" default="0">
        <cfargument name="epli_declined" required="no" default="0">
        <cfargument name="epli_declinedreason" required="no" default="">
        <cfargument name="epli_proposalnotes" required="no" default="">
        <cfargument name="wc_states" required="no" default=""> 
        <cfargument name="wc_effectivedate" required="no" default=""> 
        <cfargument name="wc_expiredate" required="no" default=""> 
        <cfargument name="wc_issuing_company" required="no" default="0"> 
        <cfargument name="wc_classcode" required="no" default=""> 
        <cfargument name="wc_rate" required="no" default="0"> 
        <cfargument name="wc_premium" required="no" default="0"> 
        <cfargument name="wc_agencyfee" required="no" default="0"> 
        <cfargument name="wc_totalpremium" required="no" default="0"> 
        <cfargument name="wc_fein" required="no" default=""> 
        <cfargument name="wc_additionalfeins" required="no" default="0"> 
        <cfargument name="wc_fulltime" required="no" default="0"> 
        <cfargument name="wc_partime" required="no" default="0"> 
        <cfargument name="wc_totalemployees" required="no" default="0"> 
        <cfargument name="wc_payroll" required="no" default="0"> 
        <cfargument name="wc_eachaccident" required="no" default="0"> 
        <cfargument name="wc_diseaseeach" required="no" default="0"> 
        <cfargument name="wc_diseaselimit" required="no" default="0"> 
        <cfargument name="wc_declined" required="no" default="0"> 
        <cfargument name="wc_declinedreason" required="no" default=""> 
        <cfargument name="wc_proposalnotes" required="no" default="">
        <cfargument name="bond_type" required="no" default="">
        <cfargument name="bond_issuing_company" required="no" default="0">
        <cfargument name="bond_amount" required="no" default="0">
        <cfargument name="bond_obligee" required="no" default="">
        <cfargument name="bond_premium" required="no" default="0">
        <cfargument name="bond_fees" required="no" default="0">
        <cfargument name="bond_deliveryfee" required="no" default="0">
        <cfargument name="bond_tax" required="no" default="0">
        <cfargument name="bond_totalpremium" required="no" default="0">
        <cfargument name="bond_declined" required="no" default="0">
        <cfargument name="bond_declinedreason" required="no" default=""> 
        <cfargument name="other_loc" required="no" default="0">
        <cfargument name="other_effectivedate" required="no" default="">   
        <cfargument name="other_expiredate" required="no" default="">   
        <cfargument name="other_issuing_company" required="no" default="0">   
        <cfargument name="other_dedret" required="no" default="">   
        <cfargument name="other_dedretamount" required="no" default="0">   
        <cfargument name="other_premium" required="no" default="0">   
        <cfargument name="other_brokerfee" required="no" default="0">   
        <cfargument name="other_agencyfee" required="no" default="0">   
        <cfargument name="other_tax" required="no" default="0">   
        <cfargument name="other_filingfee" required="no" default="0">   
        <cfargument name="other_totalpremium" required="no" default="0">   
        <cfargument name="other_proposalnotes" required="no" default=""> 
        <cfargument name="wc_notes" required="no" default=""> 
        <cfargument name="ue_notes" required="no" default=""> 
        <cfargument name="epli_notes" required="no" default=""> 
        <cfargument name="bond_notes" required="no" default=""> 
        <cfargument name="other_notes" required="no" default="">  
        <cfargument name="label_needed" required="no" default="0">  

		<cfquery name="addClient">
		INSERT INTO clients
           (affiliation_id
           ,client_type_id
           ,ams
           ,am
           ,client_code
           ,entity_name
           ,dba
           ,mailing_address
           ,mailing_address2
           ,mailing_city
           ,mailing_state
           ,mailing_zip
           ,business_phone
           ,business_email
           ,website
           ,fein
           ,year_business_started
           ,years_experience
           ,x_reference
           ,client_status_id
           ,current_effective_date,
           ue_type,
           ue_date1,
           ue_date2,
           ue_issuing_company,
           ue_occurrence,
           ue_aggregate,
           ue_retention,
           ue_premium,
           ue_brokerfee,
           ue_agencyfee,
           ue_filingfee,
           ue_stampingfee,
           ue_sltax,
           ue_totalpremium,
           ue_declined,
           ue_declinedreason,
           ue_proposalnotes,
           ue_rate_state,
           <!---
           ue_rate_sltax,
           ue_rate_filingfee,
           ue_rate_stampingfee,
           ue_rate_statesurcharge,
           ue_rate_munisurcharge,
					 --->
           epli_date1,
           epli_date2,
           epli_retrodate,
           epli_prioracts,
           epli_issuing_company,
           epli_aggregate,
           epli_retention,
           epli_doincluded,
           epli_aggregate2,
           epli_retention2,
           epli_fulltime,
           epli_partime,
           epli_totalemployees,                      
           epli_premium,
           epli_brokerfee,
           epli_agencyfee,
           epli_filingfee,
           epli_sltax,
           epli_totalpremium,
           epli_declined,
           epli_declinedreason,
           epli_proposalnotes,
           wc_states,
           wc_effectivedate,
           wc_expiredate,
           wc_issuing_company,
           wc_classcode,
           wc_rate,
           wc_premium,
           wc_agencyfee,
           wc_totalpremium,
           wc_fein,
           wc_additionalfeins,
           wc_fulltime,
           wc_partime,
           wc_totalemployees,
           wc_payroll,
           wc_eachaccident,
           wc_diseaseeach,
           wc_diseaselimit,
           wc_declined,
           wc_declinedreason,
           wc_proposalnotes,
           bond_type,
           bond_issuing_company,
           bond_amount,
           bond_obligee,
           bond_premium,
           bond_fees,
           bond_deliveryfee,
           bond_tax,
           bond_totalpremium,
           bond_declined,
           bond_declinedreason,
           other_loc,
           other_effectivedate,
           other_expiredate,
           other_issuing_company,
           other_dedret,
           other_dedretamount,
           other_premium,
           other_brokerfee,
           other_agencyfee,
           other_tax,
           other_filingfee,
           other_totalpremium,
           other_proposalnotes,
           wc_notes,
           ue_notes,
           epli_notes,
           bond_notes,
           other_notes,
           label_needed)
     VALUES
           ( #arguments.affiliation_id#
           ,#arguments.client_type_id#
           ,'#arguments.ams#'
           ,#val(arguments.am)#
           ,'#client_code#'
           ,'#arguments.entity_name#'
           ,'#arguments.dba#'
           ,'#arguments.mailing_address#'
           ,'#arguments.mailing_address2#'
           ,'#arguments.mailing_city#'
           ,#arguments.mailing_state#
           ,'#arguments.mailing_zip#'
           ,'#arguments.business_phone#'
           ,'#arguments.business_email#'
           ,'#arguments.website#'
           ,'#arguments.fein#'
           ,'#arguments.year_business_started#'
           ,'#arguments.years_experience#'
           ,'#arguments.x_reference#'
           ,#arguments.client_status_id#
           ,'#arguments.current_effective_date#'
           ,'#arguments.ue_type#'
           ,'#arguments.ue_date1#'
           ,'#arguments.ue_date2#'
           ,#val(arguments.ue_issuing_company)#
           ,#val(arguments.ue_occurrence)#
           ,#val(arguments.ue_aggregate)#
           ,#val(arguments.ue_retention)#
           ,#val(arguments.ue_premium)#
           ,#val(arguments.ue_brokerfee)#
           ,#val(arguments.ue_agencyfee)#
           ,#val(arguments.ue_filingfee)#
           ,#val(arguments.ue_stampingfee)#
           ,#val(arguments.ue_sltax)#
           ,#val(arguments.ue_totalpremium)#
           ,#val(arguments.ue_declined)#
           ,'#arguments.ue_declinedreason#'
           ,'#arguments.ue_proposalnotes#'
           ,#val(arguments.ue_rate_state)#
           <!---
           ,#val(arguments.ue_rate_sltax)#
           ,#val(arguments.ue_rate_filingfee)#
           ,#val(arguments.ue_rate_stampingfee)#
           ,#val(arguments.ue_rate_statesurcharge)#
           ,#val(arguments.ue_rate_munisurcharge)#
					 --->
           ,'#arguments.epli_date1#'
           ,'#arguments.epli_date2#'
           ,'#arguments.epli_retrodate#'
           ,#val(arguments.epli_prioracts)#
           ,#val(arguments.epli_issuing_company)#
           ,#val(arguments.epli_aggregate)#
           ,#val(arguments.epli_retention)#
           ,#val(arguments.epli_doincluded)#
           ,#val(arguments.epli_aggregate2)#
           ,#val(arguments.epli_retention2)#  
           ,#val(arguments.epli_fulltime)#
           ,#val(arguments.epli_partime)#
           ,#val(arguments.epli_totalemployees)#         
           ,#val(arguments.epli_premium)#
           ,#val(arguments.epli_brokerfee)#
           ,#val(arguments.epli_agencyfee)#
           ,#val(arguments.epli_filingfee)#
           ,#val(arguments.epli_sltax)#
           ,#val(arguments.epli_totalpremium)#
           ,#val(arguments.epli_declined)#
           ,'#arguments.epli_declinedreason#'
           ,'#arguments.epli_proposalnotes#'
           ,'#arguments.wc_states#'
           ,'#arguments.wc_effectivedate#'
           ,'#arguments.wc_expiredate#'
           ,#val(arguments.wc_issuing_company)#
           ,'#arguments.wc_classcode#'
           ,#val(arguments.wc_rate)#
           ,#val(arguments.wc_premium)#
           ,#val(arguments.wc_agencyfee)#
           ,#val(arguments.wc_totalpremium)#
           ,'#arguments.wc_fein#'
           ,#val(arguments.wc_additionalfeins)#
           ,#val(arguments.wc_fulltime)#
           ,#val(arguments.wc_partime)#
           ,#val(arguments.wc_totalemployees)#
           ,#val(arguments.wc_payroll)#
           ,#val(arguments.wc_eachaccident)#
           ,#val(arguments.wc_diseaseeach)#
           ,#val(arguments.wc_diseaselimit)#
           ,#val(arguments.wc_declined)#
           ,'#arguments.wc_declinedreason#'
           ,'#arguments.wc_proposalnotes#'
           ,'#arguments.bond_type#'
           ,#val(arguments.bond_issuing_company)#
           ,#val(arguments.bond_amount)#
           ,'#arguments.bond_obligee#'
           ,#val(arguments.bond_premium)#
           ,#val(arguments.bond_fees)#
           ,#val(arguments.bond_deliveryfee)#
           ,#val(arguments.bond_tax)#
           ,#val(arguments.bond_totalpremium)#
           ,#val(arguments.bond_declined)#
           ,'#arguments.bond_declinedreason#'
           ,#val(arguments.other_loc)#
           ,'#arguments.other_effectivedate#'
           ,'#arguments.other_expiredate#'
           ,#val(arguments.other_issuing_company)#
           ,'#arguments.other_dedret#'
           ,#val(arguments.other_dedretamount)#
           ,#val(arguments.other_premium)#
           ,#val(arguments.other_brokerfee)#
           ,#val(arguments.other_agencyfee)#
           ,#val(arguments.other_tax)#
           ,#val(arguments.other_filingfee)#
           ,#val(arguments.other_totalpremium)#
           ,'#arguments.other_proposalnotes#'
           ,'#arguments.wc_notes#'
           ,'#arguments.ue_notes#'
           ,'#arguments.epli_notes#'
           ,'#arguments.bond_notes#'
           ,'#arguments.other_notes#'
           ,#val(arguments.label_needed)#
           )
		
		SELECT @@IDENTITY AS 'client_id';
	
		</cfquery>
		<cfreturn addclient.client_id />
	</cffunction>
	<cffunction name ="editClient" output="false" access="remote">
		<cfargument name="client_id" required="yes">
		<cfargument name="affiliation_id" required="no" default="">
		<cfargument name="client_type_id" required="no" default="">
		<cfargument name="ams" required="no" default="">
		<cfargument name="am" required="no" default="0">
        <cfargument name="client_code" required="no" default="">
		<cfargument name="entity_name" required="no" default="">
		<cfargument name="dba" required="no" default="">
		<cfargument name="mailing_address" required="no" default="">
		<cfargument name="mailing_address2" required="no" default="">
		<cfargument name="mailing_city" required="no" default="">
		<cfargument name="mailing_state" required="no" default="">
		<cfargument name="mailing_zip" required="no" default="">
		<cfargument name="business_phone" required="no" default="">
		<cfargument name="business_email" required="no" default="">
		<cfargument name="website" required="no" default="">
		<cfargument name="fein" required="no" default="">
		<cfargument name="year_business_started" required="no" default="">
		<cfargument name="years_experience" required="no" default="">
		<cfargument name="x_reference" required="no" default="">
		<cfargument name="client_status_id" required="no" default="">
		<cfargument name="current_effective_date" required="no" default="">
        <cfargument name="ue_type" required="no" default="">
        <cfargument name="ue_date1" required="no" default="">
        <cfargument name="ue_date2" required="no" default="">
        <cfargument name="ue_issuing_company" required="no" default="0">
        <cfargument name="ue_occurrence" required="no" default="0">
        <cfargument name="ue_aggregate" required="no" default="0">
        <cfargument name="ue_retention" required="no" default="0">
        <cfargument name="ue_premium" required="no" default="0">
        <cfargument name="ue_brokerfee" required="no" default="0">
        <cfargument name="ue_agencyfee" required="no" default="0">
        <cfargument name="ue_filingfee" required="no" default="0">
        <cfargument name="ue_stampingfee" required="no" default="0">
        <cfargument name="ue_sltax" required="no" default="0">
        <cfargument name="ue_totalpremium" required="no" default="0">
        <cfargument name="ue_declined" required="no" default="0">
        <cfargument name="ue_declinedreason" required="no" default="">
        <cfargument name="ue_proposalnotes" required="no" default="">
        <cfargument name="ue_rate_state" required="no" default="0">
        <!---
        <cfargument name="ue_rate_sltax" required="no" default="0">
        <cfargument name="ue_rate_filingfee" required="no" default="0">
        <cfargument name="ue_rate_stampingfee" required="no" default="0">
        <cfargument name="ue_rate_statesurcharge" required="no" default="0">
        <cfargument name="ue_rate_munisurcharge" required="no" default="0">      
				--->   
        <cfargument name="epli_date1" required="no" default="">
        <cfargument name="epli_date2" required="no" default="">
        <cfargument name="epli_retrodate" required="no" default="">
        <cfargument name="epli_prioracts" required="no" default="0">
        <cfargument name="epli_issuing_company" required="no" default="0">        
        <cfargument name="epli_aggregate" required="no" default="0">
        <cfargument name="epli_retention" required="no" default="0">
        <cfargument name="epli_doincluded" required="no" default="0">
        <cfargument name="epli_aggregate2" required="no" default="0">
        <cfargument name="epli_retention2" required="no" default="0"> 
        <cfargument name="epli_fulltime" required="no" default="0">
        <cfargument name="epli_partime" required="no" default="0">
        <cfargument name="epli_totalemployees" required="no" default="0">                
        <cfargument name="epli_premium" required="no" default="0">
        <cfargument name="epli_brokerfee" required="no" default="0">
        <cfargument name="epli_agencyfee" required="no" default="0">
        <cfargument name="epli_filingfee" required="no" default="0">
        <cfargument name="epli_sltax" required="no" default="0">
        <cfargument name="epli_totalpremium" required="no" default="0">
        <cfargument name="epli_declined" required="no" default="0">
        <cfargument name="epli_declinedreason" required="no" default="">
        <cfargument name="epli_proposalnotes" required="no" default="">  
        <cfargument name="wc_states" required="no" default=""> 
        <cfargument name="wc_effectivedate" required="no" default=""> 
        <cfargument name="wc_expiredate" required="no" default=""> 
        <cfargument name="wc_issuing_company" required="no" default="0"> 
        <cfargument name="wc_classcode" required="no" default=""> 
        <cfargument name="wc_rate" required="no" default="0"> 
        <cfargument name="wc_premium" required="no" default="0"> 
        <cfargument name="wc_agencyfee" required="no" default="0"> 
        <cfargument name="wc_totalpremium" required="no" default="0">         
        <cfargument name="wc_fein" required="no" default=""> 
        <cfargument name="wc_additionalfeins" required="no" default="0"> 
        <cfargument name="wc_fulltime" required="no" default="0"> 
        <cfargument name="wc_partime" required="no" default="0"> 
        <cfargument name="wc_totalemployees" required="no" default="0"> 
        <cfargument name="wc_payroll" required="no" default="0"> 
        <cfargument name="wc_eachaccident" required="no" default="0"> 
        <cfargument name="wc_diseaseeach" required="no" default="0"> 
        <cfargument name="wc_diseaselimit" required="no" default="0"> 
        <cfargument name="wc_declined" required="no" default="0"> 
        <cfargument name="wc_declinedreason" required="no" default=""> 
        <cfargument name="wc_proposalnotes" required="no" default=""> 
        <cfargument name="bond_type" required="no" default="">
        <cfargument name="bond_issuing_company" required="no" default="0">
        <cfargument name="bond_amount" required="no" default="0">
        <cfargument name="bond_obligee" required="no" default="">
        <cfargument name="bond_premium" required="no" default="0">
        <cfargument name="bond_fees" required="no" default="0">
        <cfargument name="bond_deliveryfee" required="no" default="0">
        <cfargument name="bond_tax" required="no" default="0">
        <cfargument name="bond_totalpremium" required="no" default="0">
        <cfargument name="bond_declined" required="no" default="0">
        <cfargument name="bond_declinedreason" required="no" default="">           
        <cfargument name="other_loc" required="no" default="0">
        <cfargument name="other_effectivedate" required="no" default="">   
        <cfargument name="other_expiredate" required="no" default="">   
        <cfargument name="other_issuing_company" required="no" default="0">   
        <cfargument name="other_dedret" required="no" default="">   
        <cfargument name="other_dedretamount" required="no" default="0">   
        <cfargument name="other_premium" required="no" default="0">   
        <cfargument name="other_brokerfee" required="no" default="0">   
        <cfargument name="other_agencyfee" required="no" default="0">   
        <cfargument name="other_tax" required="no" default="0">   
        <cfargument name="other_filingfee" required="no" default="0">   
        <cfargument name="other_totalpremium" required="no" default="0">   
        <cfargument name="other_proposalnotes" required="no" default=""> 
        <cfargument name="wc_notes" required="no" default=""> 
        <cfargument name="ue_notes" required="no" default=""> 
        <cfargument name="epli_notes" required="no" default=""> 
        <cfargument name="bond_notes" required="no" default=""> 
        <cfargument name="other_notes" required="no" default="">     
        <cfargument name="label_needed" required="no" default="0">     
                              
		<cfquery name="editClient">
			UPDATE clients
			   SET [affiliation_id] = #arguments.affiliation_id#
			      ,[client_type_id] = #arguments.client_type_id#
			      ,[ams] = '#arguments.ams#'
			      ,[am] = #val(arguments.am)#
                  ,[client_code] = '#arguments.client_code#'
			      ,[entity_name] = '#arguments.entity_name#'
			      ,[dba] = '#arguments.dba#'
			      ,[mailing_address] = '#arguments.mailing_address#'
			      ,[mailing_address2] = '#arguments.mailing_address2#'
			      ,[mailing_city] = '#arguments.mailing_city#'
			      ,[mailing_state] = #arguments.mailing_state#
			      ,[mailing_zip] = '#arguments.mailing_zip#'
			      ,[business_phone] = '#arguments.business_phone#'
			      ,[business_email] = '#arguments.business_email#'
			      ,[website] = '#arguments.website#'
			      ,[fein] = '#arguments.fein#'
			      ,[year_business_started] = '#arguments.year_business_started#'
			      ,[years_experience] = '#arguments.years_experience#'
			      ,[x_reference] = '#arguments.x_reference#'
			      ,[client_status_id] = #arguments.client_status_id#
			      ,[current_effective_date] = '#arguments.current_effective_date#'
                  ,[ue_type] = '#arguments.ue_type#'
                  ,[ue_date1] = '#arguments.ue_date1#'
                  ,[ue_date2] = '#arguments.ue_date2#'
                  ,[ue_issuing_company] = #val(arguments.ue_issuing_company)#
                  ,[ue_occurrence] = #val(arguments.ue_occurrence)#
                  ,[ue_aggregate] = #val(arguments.ue_aggregate)#
                  ,[ue_retention] = #val(arguments.ue_retention)#
                  ,[ue_premium] = #val(arguments.ue_premium)#
                  ,[ue_brokerfee] = #val(arguments.ue_brokerfee)#
                  ,[ue_agencyfee] = #val(arguments.ue_agencyfee)#
                  ,[ue_filingfee] = #val(arguments.ue_filingfee)#
                  ,[ue_stampingfee] = #val(arguments.ue_stampingfee)#
                  ,[ue_sltax] = #val(arguments.ue_sltax)#
                  ,[ue_totalpremium] = #val(arguments.ue_totalpremium)#
                  ,[ue_declined] = #val(arguments.ue_declined)#
                  ,[ue_declinedreason] = '#arguments.ue_declinedreason#'
                  ,[ue_proposalnotes] = '#arguments.ue_proposalnotes#'
                  ,[ue_rate_state] = #val(arguments.ue_rate_state)#
                  <!---
                  ,[ue_rate_sltax] = #val(arguments.ue_rate_sltax)#
                  ,[ue_rate_filingfee] = #val(arguments.ue_rate_filingfee)#
                  ,[ue_rate_stampingfee] = #val(arguments.ue_rate_stampingfee)#
                  ,[ue_rate_statesurcharge] = #val(arguments.ue_rate_statesurcharge)#
                  ,[ue_rate_munisurcharge] = #val(arguments.ue_rate_munisurcharge)#
									--->
                  ,[epli_date1] = '#arguments.epli_date1#'
                  ,[epli_date2] = '#arguments.epli_date2#'
                  ,[epli_retrodate] = '#arguments.epli_retrodate#'
                  ,[epli_prioracts] = #val(arguments.epli_prioracts)#
                  ,[epli_issuing_company] = #val(arguments.epli_issuing_company)#
                  ,[epli_aggregate] = #val(arguments.epli_aggregate)#
                  ,[epli_retention] = #val(arguments.epli_retention)#
                  ,[epli_doincluded] = #val(arguments.epli_doincluded)#
                  ,[epli_aggregate2] = #val(arguments.epli_aggregate2)#
                  ,[epli_retention2] = #val(arguments.epli_retention2)#
                  ,[epli_fulltime] = #val(arguments.epli_fulltime)#                 
                  ,[epli_partime] = #val(arguments.epli_partime)#
                  ,[epli_totalemployees] = #val(arguments.epli_totalemployees)#                                    
                  ,[epli_premium] = #val(arguments.epli_premium)#
                  ,[epli_brokerfee] = #val(arguments.epli_brokerfee)#
                  ,[epli_agencyfee] = #val(arguments.epli_agencyfee)#
                  ,[epli_filingfee] = #val(arguments.epli_filingfee)#
                  ,[epli_sltax] = #val(arguments.epli_sltax)#
                  ,[epli_totalpremium] = #arguments.epli_totalpremium#
                  ,[epli_declined] = #val(arguments.epli_declined)#
                  ,[epli_declinedreason] = '#arguments.epli_declinedreason#'
                  ,[epli_proposalnotes] = '#arguments.epli_proposalnotes#'
                  ,[wc_states] = '#arguments.wc_states#'
                  ,[wc_effectivedate] = '#arguments.wc_effectivedate#'
                  ,[wc_expiredate] = '#arguments.wc_expiredate#' 
                  ,[wc_issuing_company] = #val(arguments.wc_issuing_company)#
                  ,[wc_classcode] = '#arguments.wc_classcode#'
                  ,[wc_rate] = #val(arguments.wc_rate)#
                  ,[wc_premium] = #val(arguments.wc_premium)#
                  ,[wc_agencyfee] = #val(arguments.wc_agencyfee)#
                  ,[wc_totalpremium] = #val(arguments.wc_totalpremium)#                                    
                  ,[wc_fein] = '#arguments.wc_fein#'
                  ,[wc_additionalfeins] = #val(arguments.wc_additionalfeins)#
                  ,[wc_fulltime] = #val(arguments.wc_fulltime)#
                  ,[wc_partime] = #val(arguments.wc_partime)#
                  ,[wc_totalemployees] = #val(arguments.wc_totalemployees)#
                  ,[wc_payroll] = #val(arguments.wc_payroll)#
                  ,[wc_eachaccident] = #val(arguments.wc_eachaccident)#
                  ,[wc_diseaseeach] = #val(arguments.wc_diseaseeach)#
                  ,[wc_diseaselimit] = #val(arguments.wc_diseaselimit)#
                  ,[wc_declined] = #val(arguments.wc_declined)#
                  ,[wc_declinedreason] = '#arguments.wc_declinedreason#'
                  ,[wc_proposalnotes] = '#arguments.wc_proposalnotes#'
                  ,[bond_type] = '#arguments.bond_type#'
                  ,[bond_issuing_company] = #val(arguments.bond_issuing_company)#
                  ,[bond_amount] = #val(arguments.bond_amount)#
                  ,[bond_obligee] = '#arguments.bond_obligee#'
                  ,[bond_premium] = #val(arguments.bond_premium)#
                  ,[bond_fees] = #val(arguments.bond_fees)#
                  ,[bond_deliveryfee] = #val(arguments.bond_deliveryfee)#
                  ,[bond_tax] = #val(arguments.bond_tax)#
                  ,[bond_totalpremium] = #val(arguments.bond_totalpremium)#
                  ,[bond_declined] = #val(arguments.bond_amount)#
                  ,[bond_declinedreason] = '#arguments.bond_declinedreason#'
                  ,[other_loc] = #val(arguments.other_loc)#
                  ,[other_effectivedate] = '#arguments.other_effectivedate#'
                  ,[other_expiredate] = '#arguments.other_expiredate#'
                  ,[other_issuing_company] = #val(arguments.other_issuing_company)#
                  ,[other_dedret] = '#arguments.other_dedret#'
                  ,[other_dedretamount] = #val(arguments.other_dedretamount)#
                  ,[other_premium] = #val(arguments.other_premium)#
                  ,[other_brokerfee] = #val(arguments.other_brokerfee)#
                  ,[other_agencyfee] = #val(arguments.other_agencyfee)#
                  ,[other_tax] = #val(arguments.other_tax)#
                  ,[other_filingfee] = #val(arguments.other_filingfee)#
                  ,[other_totalpremium] = #val(arguments.other_totalpremium)#
                  ,[other_proposalnotes] = '#arguments.other_proposalnotes#'
                  ,[wc_notes] = '#arguments.wc_notes#'
                  ,[ue_notes] = '#arguments.ue_notes#'
                  ,[epli_notes] = '#arguments.epli_notes#'
                  ,[bond_notes] = '#arguments.bond_notes#'
                  ,[other_notes] = '#arguments.other_notes#'
                  ,[label_needed] = #val(arguments.label_needed)#
			 WHERE 
			 	client_id = #arguments.client_id#
		</cfquery>
	</cffunction>
	<cffunction name ="deleteClient" output="false" access="remote">
		<cfargument name="client_id" required="yes">
		<cfquery name="delClient">
		update clients set active=0 where clientid=#arguments.client_id#
		</cfquery>
	</cffunction>
	<cffunction name="addClientContact" output="false" access="remote">
		<cfargument name="client_id" required="yes">
		<cfargument name="name" required="yes">
		<cfargument name="title">
		<cfargument name="phone">
		<cfargument name="cell">
		<cfargument name="fax">
		<cfargument name="email">
		<cfset var result = "">
		 <cftry>
		<cfquery name="addclientcontact">
			insert into client_contacts(client_id,name,title,phone,cell,fax,email)
			values(#arguments.client_id#,'#arguments.name#','#arguments.title#','#arguments.phone#','#arguments.cell#','#arguments.fax#','#arguments.email#')
		</cfquery>
		<cfset result="success">
		<cfcatch type="any"><cfset result="false"></cfcatch>
		</cftry>
		<cfreturn result />
	</cffunction>
	<cffunction name="updateClientContact" output="false" access="remote">
		<cfargument name="client_id" required="no">
		<cfargument name="contactid" required="yes">
		<cfargument name="name" required="yes">
		<cfargument name="title">
		<cfargument name="phone">
		<cfargument name="cell">
		<cfargument name="fax">
		<cfargument name="email">
		<cfset var result = "">
		 <cftry>
		<cfquery name="qupdateclientcontact">
			UPDATE client_contacts
			set [name] ='#arguments.name#'
				,[title]='#arguments.title#'
				,[phone]='#arguments.phone#'
				,[cell]='#arguments.cell#'
				,[fax]='#arguments.fax#'
				,[email]='#arguments.email#'
			where contactid=#arguments.contactid#
		</cfquery>
		<cfset result="success">
		<cfcatch type="any"><cfset result="false"></cfcatch>
		</cftry>
		<cfreturn result />
	</cffunction>
	<!--- Ratings --->
	<cffunction name="editApplication" output="false">
		<cfargument name="application_id" required="true">
		<cfargument name="gross_receipts" required="no">
		<cfargument name="court_basketball" required="no">
		<cfargument name="court_racquetball" required="no">
		<cfargument name="court_tennis" required="no">
		<cfargument name="sauna" required="no">
		<cfargument name="steam_room" required="no">
		<cfargument name="whirlpool" required="no">
		<cfargument name="pool_indoor" required="no">
		<cfargument name="pool_outdoor" required="no">
		<cfargument name="beauty_angel" required="no">
		<cfargument name="beds_tanning" required="no">
		<cfargument name="beds_spray" required="no">
		<cfargument name="number_trainers" required="no">
		<cfargument name="number_children" required="no" default="0">
		<cfargument name="silver_sneakers" required="no" default="0">
		<cfargument name="square_ft" required="no" default="0">
		<cfargument name="leased_space" required="no" default="0">
		<cfargument name="play_apparatus" required="no" default="0">
    <cfargument name="massage" required="no" default="0">
        <cfargument name="notes" required="no" default="">
		
			<cfquery name="qupdateApp">
				update [applications]
				set gross_receipts='#arguments.gross_receipts#'
				,court_basketball=#arguments.court_basketball#
				,court_racquetball=#arguments.court_racquetball#
				,court_tennis=#arguments.court_tennis#
				,sauna=#arguments.sauna#
				,steam_room=#arguments.steam_room#
				,whirlpool=#arguments.whirlpool#
				,pool_indoor=#arguments.pool_indoor#
				,pool_outdoor=#arguments.pool_outdoor#
				,beauty_angel=#arguments.beauty_angel#
				,beds_tanning=#arguments.beds_tanning#
				,beds_spray=#arguments.beds_spray#
				,number_trainers=#arguments.number_trainers#
				,number_children=#arguments.number_children#
				,silver_sneakers=#arguments.silver_sneakers#
				,square_ft=#arguments.square_ft#
				,leased_space=#arguments.leased_space#
				,play_apparatus=#arguments.play_apparatus#
       ,notes='#arguments.notes#'
       ,massage='#arguments.massage#'
				where application_id=#arguments.application_id#
			</cfquery>
			<cfset success=1>
			<cfreturn success>
	</cffunction>
	<cffunction name="getLiabilityExpos" output="false">
		<cfargument name="application_id" required="yes">
		<cfif application_id eq 0>
			<cfquery name="qgetappexpos">

			select
			0 as instructors_expo
			,0 as basketball_expo
			,0 as rt_courts_expo
			,0 as tennis_courts_expo
			,0 as sauna_expo
			,0 as steamroom_expo
			,0 as whirlpool_expo
			,0 as pools_expo
			,0 as poolsoutdoor_expo
			,0 as tanning_expo
			,0 as spraytanning_expo
			,0 as beautyangels_expo
			,0 as silversneakers_expo
			,0 as massage_expo
			,0 as pt_expo
			,0 as childsitting_expo
			,0 as junglegym_expo
			,0 as leasedspace_expo
      ,0 as employeebenefits_expo
      ,0 as employee_rec_benefits_id
			,0 as gross_receipts
			,0 as square_ft
			from applications
			where 1=1
		</cfquery>
		<cfelse>
		<cfquery name="qgetappexpos">
			declare @appid int;
			set @appid = #arguments.application_id#;
			
			select
			number_trainers as instructors_expo
			,court_basketball as basketball_expo
			,court_racquetball as rt_courts_expo
			,court_tennis as tennis_courts_expo
			,sauna as sauna_expo
			,steam_room as steamroom_expo
			,whirlpool as whirlpool_expo
			,pool_indoor as pools_expo
			,pool_outdoor as poolsoutdoor_expo
			,beds_tanning as tanning_expo
			,beds_spray as spraytanning_expo
			,beauty_angel as beautyangels_expo
			,"silversneakers_expo" = case 
				when silver_sneakers = 1 then 1 
				else 0 
				end
			,massage as massage_expo
			,personal_trainers as pt_expo
			,child_sitting as childsitting_expo
			,"junglegym_expo" = case
				when play_apparatus = 1 then 1
				else 0
				end
			,leased_square_ft as leasedspace_expo
      ,employee_benefits as employeebenefits_expo
      ,employee_rec_benefits_id
			,gross_receipts
			,square_ft
			from applications
			where application_id = @appid
		</cfquery>
		</cfif>
		<cfreturn qgetappexpos />
	</cffunction>
	<cffunction name="getPropLimits" output="true">
		<cfargument name="application_id" required="yes">
		<cfset fieldMap = appGW.fieldMappings2()>

		<cfquery name="qdata">
			select
      <cfloop from="1" to="#arrayLen(fieldMap)#" index="i">
			#fieldMap[i][1]# as #fieldMap[i][2]#<cfif i lt arrayLen(fieldMap)>, </cfif>
      </cfloop>
			from applications
			where application_id = #arguments.application_id#
		</cfquery>

		<cfreturn qdata />
	</cffunction>  
    	<cffunction name="getYesNo" output="false">
		<cfargument name="application_id" required="yes">
		<cfquery name="getdata">
			select notes
			from applications
			where application_id = #arguments.application_id#
		</cfquery>
		<cfreturn getdata />
	</cffunction>
	<cffunction name="getRating" output="false">
		<cfargument name="ratingid" required="yes">
		<cfquery name="qgetrating">
			select r.ratingid, r.application_id, r.location_id, rl.*, r.liability_plan_id, r.PROPERTY_PLAN_ID, r.state_id, r.square_footage, r.gross_receipts, r.excl_proposal, r.gl_issuing_company_id, r.property_issuing_company_id, r.endorsement_id, r.savedatetime, r.user_id, r.history, r.historynotes, r.endorse, rp.* 
			from rating r
			inner join rating_liability rl on r.ratingid = rl.ratingid
			inner join rating_property rp on r.ratingid = rp.ratingid 
			where r.ratingid = #arguments.ratingid#
		</cfquery>
<!---Michael's old query
			<cfquery name="qgetrating">
			select * from rating r
			inner join rating_liability rl on r.rating_liability_id = rl.rating_liability_id
			inner join rating_property rp on r.rating_property_id = rp.rating_property_id 
			where r.ratingid = #arguments.ratingid#
		</cfquery>--->		
		<cfreturn qgetrating />
	</cffunction>
	<cffunction name="updateRating" output="false">
		<cfargument name="ratingid" default="0">
		<cfargument name="rating_liability_id" required="no">
		<cfargument name="rating_property_id" required="no">
		
		<cfquery name="quprating">
		 update [rating]
		 set rating_liability_id = #arguments.rating_liability_id#
		 ,rating_property_id = #arguments.rating_property_id#
		 ,[savedatetime] = #createodbcdatetime(now())#
		 ,[user_id] = #session.auth.id#
		 where ratingid = #arguments.ratingid#
		</cfquery>
	</cffunction>
	<cffunction name="getRatingHistory" output="false">
		<cfargument name="rc">
		
		<cfquery name="qgethistory">
		select r.ratingid,r.savedatetime,u.user_name,historynotes as notes,r.application_id,r.location_id, r.endorse 
		from rating r
		left join users u on r.user_id=u.user_id
		<!--- where r.application_id=#arguments.rc.application_id# and --->
		where r.location_id=#arguments.rc.location_id#
		and r.history=1
        <cfif arguments.rc.getAll is false>and savedatetime between '#arguments.rc.startdate#' and '#arguments.rc.enddate#'</cfif>
		order by r.savedatetime desc
		</cfquery>
		<cfreturn qgethistory>
	</cffunction>
	<cffunction name="addEditRating" output="false">
		<cfargument name="ratingid" default="0">
		<cfargument name="application_id" required="yes">
		<cfargument name="location_id" required="yes">
		<cfargument name="liability_plan_id" required="no">
		<cfargument name="issuing_company_id" required="no">
		<cfargument name="state_id" required="no">
		<cfargument name="square_footage" required="no" default="0">
		<cfargument name="gross_receipts" required="no">
		<cfargument name="excl_proposal" required="no" default="0">
		<cfargument name="gl_issuing_company_id" required="no">
		<cfargument name="property_issuing_company_id" required="no">
		<cfargument name="rating_liability_id" required="no">
		<cfargument name="rating_property_id" required="no">
		<cfargument name="endorsement_id" required="no">
		<cfargument name="history" default="0">
        <cfargument name="endorse" default="0">
        <cfparam name="historynotes" default="Rating History Saved">
        <cfif endorse eq 1>
        <cfset historynotes = "Endorsement Added">
        </cfif>
		
		<cfif arguments.ratingid neq 0>
			<cfquery name="editRating">
			UPDATE [rating]
			SET [application_id] = #arguments.application_id#
			      ,[location_id] = #arguments.location_id#
			      ,[liability_plan_id] = #arguments.liability_plan_id#
			      ,[property_plan_id] = #arguments.property_plan_id#
			      ,[state_id] = 0
			      ,[square_footage] = #arguments.square_footage#
			      ,[gross_receipts] = '#arguments.gross_receipts#'
			      ,[excl_proposal] = #arguments.excl_proposal#
			      ,[gl_issuing_company_id] = #arguments.gl_issuing_company_id#
			      ,[property_issuing_company_id] = #arguments.property_issuing_company_id#
			      ,[rating_liability_id] = #arguments.rating_liability_id#
			      ,[rating_property_id] = #arguments.rating_property_id#
			      ,[endorsement_id] = #arguments.endorsement_id#
			      ,[savedatetime] = #createodbcdatetime(now())#
			      ,[user_id] = #session.auth.id#
			      ,history = #arguments.history#
                  ,endorse = #arguments.endorse#
                  <cfif history eq 1>
                  ,historynotes = '#historynotes#'
                  </cfif>
			 WHERE ratingid=#arguments.ratingid#

			</cfquery>
		<cfreturn arguments.ratingid />
		<cfelse>
			<cfquery name="addRating">
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
	           ,history
               ,endorse
	           <cfif history eq 1>
		       ,historynotes
		       </cfif>
	           )
	     	VALUES
	           (#arguments.application_id#
	           ,#arguments.location_id#
	           ,#arguments.liability_plan_id#
	           ,#arguments.property_plan_id#
	           ,NULL
	           ,#arguments.square_footage#
	           ,'#arguments.gross_receipts#'
	           ,#arguments.excl_proposal#
	           ,#arguments.gl_issuing_company_id#
	           ,#arguments.property_issuing_company_id#
	           ,NULL
	           ,NULL
	           ,0
	           ,#createodbcdatetime(now())#
	           ,#session.auth.id#
	           ,#arguments.history#
               ,#arguments.endorse#
	            <cfif history eq 1>
		       ,'#historynotes#'
		       </cfif>
		       )
	           
	           SELECT @@IDENTITY AS RID
			
			</cfquery>
			<cfreturn addRating.rid />
		</cfif>
	</cffunction>
	<cffunction name="addRatingLiability" output="yes">
		<cfargument name="ratingid" required="yes">
		<cfargument name="rc" required="yes">
        
       
		<cfquery name="qaddratingliability">
		INSERT INTO [rating_liability]
           ([ratingid]
           ,[gl_deductable]
           ,[base_rate_annual]
           ,[instructors_expo]
           ,[instructors_base]
           ,[instructors_annual]
           ,[basketball_expo]
           ,[basketball_base]
           ,[basketball_annual]
           ,[rt_courts_expo]
           ,[rt_courts_base]
           ,[rt_courts_annual]
           ,[sauna_expo]
           ,[sauna_base]
           ,[sauna_annual]
           ,[steamroom_expo]
           ,[steamroom_base]
           ,[steamroom_annual]
           ,[whirlpool_expo]
           ,[whirlpool_base]
           ,[whirlpool_annual]
           ,[pools_expo]
           ,[pools_base]
           ,[pools_annual]
           ,[tanning_expo]
           ,[tanning_base]
           ,[tanning_annual]
           ,[spraytanning_expo]
           ,[spraytanning_base]
           ,[spraytanning_annual]
           ,[beautyangels_expo]
           ,[beautyangels_base]
           ,[beautyangels_annual]
           ,[silversneakers_expo]
           ,[silversneakers_base]
           ,[silversneakers_annual]
           ,[massage_expo]
           ,[massage_base]
           ,[massage_annual]
           ,[pt_expo]
           ,[pt_base]
           ,[pt_annual]
           ,[childsitting_expo]
           ,[childsitting_base]
           ,[childsitting_annual]
           ,[junglegym_expo]
           ,[junglegym_base]
           ,[junglegym_annual]
           ,[leasedspace_expo]
           ,[leasedspace_base]
           ,[leasedspace_annual]
           ,[employeebenefits_expo]
           ,[employeebenefits_base]
           ,[employeebenefits_annual]           
           ,[silversneakers_override]
           ,[pt_override]
           ,[junglegym_override]
           ,[leasedspace_override]
           ,[employeebenefits_override]
           ,[massage_override]
           ,[total_annual]
           ,[total_debits]
           ,[loc_annual_premium]
           ,[pro_rata_gl]
           ,[brokerfee]
           ,[surplustax]
           ,[inspectionfee]
           ,[terrorism_rejected]
           ,[terrorism_fee]
           ,[stampingfee]
           ,[filingfee]
           ,[statecharge]
           ,[rpgfee]
           ,[rpgall]
           ,[grandtotal]
           ,[gldate1]
           ,[gldate2]
           ,[gl_prorate]
           ,[underwriting_notes]
           ,[yesnoquestions]
           ,[liability_propnotes]
           ,[poolsoutdoor_expo]
           ,[poolsoutdoor_base]
           ,[poolsoutdoor_annual]
           ,[tennis_courts_expo]
           ,[tennis_courts_base]
           ,[tennis_courts_annual]
           ,[liab_historydate]
			,use_prorata
			,broker_override
			,broker_flatpercent
			,broker_percentoverride
            ,inspection_override,
            rpg_override,            
            base_override,
            statemuni_override,
            filing_override,
            premium_mod,
            final_mod,
            premium_mod_label,
            total_mod)
     VALUES
           (#arguments.ratingid#
           ,#arguments.rc.gl_deductable#
           ,#arguments.rc.base_rate_annual#
           ,#arguments.rc.instructors_expo#
           ,#arguments.rc.instructors_base#
           ,#arguments.rc.instructors_annual#
           ,#arguments.rc.basketball_expo#
           ,#arguments.rc.basketball_base#
           ,#arguments.rc.basketball_annual#
           ,#arguments.rc.rt_courts_expo#
           ,#arguments.rc.rt_courts_base#
           ,#arguments.rc.rt_courts_annual#
           ,#arguments.rc.sauna_expo#
           ,#arguments.rc.sauna_base#
           ,#arguments.rc.sauna_annual#
           ,#arguments.rc.steamroom_expo#
           ,#arguments.rc.steamroom_base#
           ,#arguments.rc.steamroom_annual#
           ,#arguments.rc.whirlpool_expo#
           ,#arguments.rc.whirlpool_base#
           ,#arguments.rc.whirlpool_annual#
           ,#arguments.rc.pools_expo#
           ,#arguments.rc.pools_base#
           ,#arguments.rc.pools_annual#
           ,#arguments.rc.tanning_expo#
           ,#arguments.rc.tanning_base#
           ,#arguments.rc.tanning_annual#
           ,#arguments.rc.spraytanning_expo#
           ,#arguments.rc.spraytanning_base#
           ,#arguments.rc.spraytanning_annual#
           ,#arguments.rc.beautyangels_expo#
           ,#arguments.rc.beautyangels_base#
           ,#arguments.rc.beautyangels_annual#
           ,#arguments.rc.silversneakers_expo#
           ,#arguments.rc.silversneakers_base#
           ,#arguments.rc.silversneakers_annual#
           ,#arguments.rc.massage_expo#
           ,#arguments.rc.massage_base#
           ,#arguments.rc.massage_annual#
           ,#arguments.rc.pt_expo#
           ,#arguments.rc.pt_base#
           ,#arguments.rc.pt_annual#
           ,#arguments.rc.childsitting_expo#
           ,#arguments.rc.childsitting_base#
           ,#arguments.rc.childsitting_annual#
           ,#arguments.rc.junglegym_expo#
           ,#arguments.rc.junglegym_base#
           ,#arguments.rc.junglegym_annual#
           ,#arguments.rc.leasedspace_expo#
           ,#arguments.rc.leasedspace_base#
           ,#arguments.rc.leasedspace_annual#
           ,#arguments.rc.employeebenefits_expo#
           ,#arguments.rc.employeebenefits_base#
           ,#arguments.rc.employeebenefits_annual#           
           ,#arguments.rc.silversneakers_override#
           ,#arguments.rc.pt_override#
           ,#arguments.rc.junglegym_override#
           ,#arguments.rc.leasedspace_override#
           ,#arguments.rc.employeebenefits_override#
           ,#arguments.rc.massage_override#
           ,#arguments.rc.total_annual#
           ,#arguments.rc.total_debits#
           ,#arguments.rc.loc_annual_premium#
           ,#arguments.rc.pro_rata_gl#
           ,#arguments.rc.brokerfee#
           ,#arguments.rc.surplustax#
           ,#arguments.rc.inspectionfee#
           ,#arguments.rc.terrorism_rejected#
           ,#arguments.rc.terrorism_fee#
           ,#arguments.rc.stampingfee#
           ,#arguments.rc.filingfee#
           ,#arguments.rc.statecharge#
           ,#arguments.rc.rpgfee#
           ,#arguments.rc.rpgall#
           ,#arguments.rc.grandtotal#
           ,'#arguments.rc.gldate1#'
           ,'#arguments.rc.gldate2#'
           ,#arguments.rc.gl_prorate#
           ,'#arguments.rc.underwriting_notes#'
           ,'#arguments.rc.yesnoquestions#'
           ,'#arguments.rc.liability_propnotes#'
           ,#arguments.rc.poolsoutdoor_expo#
           ,#arguments.rc.poolsoutdoor_base#
           ,#arguments.rc.poolsoutdoor_annual#
           ,#arguments.rc.tennis_courts_expo#
           ,#arguments.rc.tennis_courts_base#
           ,#arguments.rc.tennis_courts_annual#
           ,#createodbcdatetime(now())#
		   ,#arguments.rc.use_prorata#
			,#arguments.rc.broker_override#
			,#arguments.rc.broker_flatpercent#
			,#arguments.rc.broker_percentoverride#
            ,#arguments.rc.inspection_override#
            ,#arguments.rc.rpg_override#
            ,#arguments.rc.base_override#
            ,#arguments.rc.statemuni_override#
            ,#arguments.rc.filing_override#
            ,#arguments.rc.premium_mod#
            ,#arguments.rc.final_mod#
            ,'#arguments.rc.premium_mod_label#'
            ,#arguments.rc.total_mod#
            )
		
		 select @@IDENTITY as LID
		</cfquery>
		<cfreturn qaddratingliability.lid />
	</cffunction>
	<cffunction name="editRatingLiability" output="yes">
		<cfargument name="ratingid" required="yes">
		<cfargument name="rc" required="yes">
    
		<cfquery name="qeditliability">
		UPDATE [rating_liability]
   		SET [ratingid] = #arguments.rc.ratingid#
      ,[gl_deductable] = #arguments.rc.gl_deductable#
      ,[base_rate_annual] = #arguments.rc.base_rate_annual#
      ,[instructors_expo] = #arguments.rc.instructors_expo#
      ,[instructors_base] = #arguments.rc.instructors_base#
      ,[instructors_annual] = #arguments.rc.instructors_annual#
      ,[basketball_expo] = #arguments.rc.basketball_expo#
      ,[basketball_base] = #arguments.rc.basketball_base#
      ,[basketball_annual] = #arguments.rc.basketball_annual#
      ,[rt_courts_expo] = #arguments.rc.rt_courts_expo#
      ,[rt_courts_base] = #arguments.rc.rt_courts_base#
      ,[rt_courts_annual] = #arguments.rc.rt_courts_annual#
      ,[sauna_expo] = #arguments.rc.sauna_expo#
      ,[sauna_base] = #arguments.rc.sauna_base#
      ,[sauna_annual] = #arguments.rc.sauna_annual#
      ,[steamroom_expo] = #arguments.rc.steamroom_expo#
      ,[steamroom_base] = #arguments.rc.steamroom_base#
      ,[steamroom_annual] = #arguments.rc.steamroom_annual#
      ,[whirlpool_expo] = #arguments.rc.whirlpool_expo#
      ,[whirlpool_base] = #arguments.rc.whirlpool_base#
      ,[whirlpool_annual] = #arguments.rc.whirlpool_annual#
      ,[pools_expo] = #arguments.rc.pools_expo#
      ,[pools_base] = #arguments.rc.pools_base#
      ,[pools_annual] = #arguments.rc.pools_annual#
      ,[tanning_expo] = #arguments.rc.tanning_expo#
      ,[tanning_base] = #arguments.rc.tanning_base#
      ,[tanning_annual] = #arguments.rc.tanning_annual#
      ,[spraytanning_expo] = #arguments.rc.spraytanning_expo#
      ,[spraytanning_base] = #arguments.rc.spraytanning_base#
      ,[spraytanning_annual] = #arguments.rc.spraytanning_annual#
      ,[beautyangels_expo] = #arguments.rc.beautyangels_expo#
      ,[beautyangels_base] = #arguments.rc.beautyangels_base#
      ,[beautyangels_annual] = #arguments.rc.beautyangels_annual#
      ,[silversneakers_expo] = #arguments.rc.silversneakers_expo#
      ,[silversneakers_base] = #arguments.rc.silversneakers_base#
      ,[silversneakers_annual] = #arguments.rc.silversneakers_annual#
      ,[massage_expo] = #arguments.rc.massage_expo#
      ,[massage_base] = #arguments.rc.massage_base#
      ,[massage_annual] = #arguments.rc.massage_annual#
      ,[pt_expo] = #arguments.rc.pt_expo#
      ,[pt_base] = #arguments.rc.pt_base#
      ,[pt_annual] = #arguments.rc.pt_annual#
      ,[childsitting_expo] = #arguments.rc.childsitting_expo#
      ,[childsitting_base] = #arguments.rc.childsitting_base#
      ,[childsitting_annual] = #arguments.rc.childsitting_annual#
      ,[junglegym_expo] = #arguments.rc.junglegym_expo#
      ,[junglegym_base] = #arguments.rc.junglegym_base#
      ,[junglegym_annual] = #arguments.rc.junglegym_annual#
      ,[leasedspace_expo] = #arguments.rc.leasedspace_expo#
      ,[leasedspace_base] = #arguments.rc.leasedspace_base#
      ,[leasedspace_annual] = #arguments.rc.leasedspace_annual#
      ,[employeebenefits_expo] = #arguments.rc.employeebenefits_expo#
      ,[employeebenefits_base] = #arguments.rc.employeebenefits_base#
      ,[employeebenefits_annual] = #arguments.rc.employeebenefits_annual#      
      ,[silversneakers_override] = #arguments.rc.silversneakers_override#
      ,[pt_override] = #arguments.rc.pt_override#
      ,[junglegym_override] = #arguments.rc.junglegym_override#
      ,[leasedspace_override] = #arguments.rc.leasedspace_override#
      ,[employeebenefits_override] = #arguments.rc.employeebenefits_override#
      ,[massage_override] = #arguments.rc.massage_override#
      ,[total_annual] = #arguments.rc.total_annual#
      ,[total_debits] = #arguments.rc.total_debits#
      ,[loc_annual_premium] = #arguments.rc.loc_annual_premium#
      ,[pro_rata_gl] = #arguments.rc.pro_rata_gl#
      ,[brokerfee] = #arguments.rc.brokerfee#
      ,[surplustax] = #arguments.rc.surplustax#
      ,[inspectionfee] = #arguments.rc.inspectionfee#
      ,[terrorism_rejected] = #arguments.rc.terrorism_rejected#
      ,[terrorism_fee] = #arguments.rc.terrorism_fee#
      ,[stampingfee] = #arguments.rc.stampingfee#
      ,[filingfee] = #arguments.rc.filingfee#
      ,[statecharge] = #arguments.rc.statecharge#
      ,[rpgfee] = #arguments.rc.rpgfee#
      ,[rpgall] = #arguments.rc.rpgall#
      ,[grandtotal] = #arguments.rc.grandtotal#
      ,[gldate1] = '#arguments.rc.gldate1#'
      ,[gldate2] = '#arguments.rc.gldate2#'
      ,[gl_prorate] = #arguments.rc.gl_prorate#
      ,[underwriting_notes] = '#arguments.rc.underwriting_notes#'
      ,[yesnoquestions] = '#arguments.rc.yesnoquestions#'
      ,[liability_propnotes] = '#arguments.rc.liability_propnotes#'
      ,[poolsoutdoor_expo] = #arguments.rc.poolsoutdoor_expo#
      ,[poolsoutdoor_base] = #arguments.rc.poolsoutdoor_base#
      ,[poolsoutdoor_annual] = #arguments.rc.poolsoutdoor_annual#
      ,[tennis_courts_expo] = #arguments.rc.tennis_courts_expo#
      ,[tennis_courts_base] = #arguments.rc.tennis_courts_base#
      ,[tennis_courts_annual] = #arguments.rc.tennis_courts_annual#
      ,[liab_historydate] = #createodbcdatetime(now())#
	  ,use_prorata = #arguments.rc.use_prorata#
		,broker_override = #arguments.rc.broker_override#
		,broker_flatpercent = #arguments.rc.broker_flatpercent#
		,broker_percentoverride = #arguments.rc.broker_percentoverride#
        ,[total_debitspercent] = #arguments.rc.total_debitspercent#
        ,[premium_mod] = #arguments.rc.premium_mod#
        ,[final_mod] = #arguments.rc.final_mod#
        ,[premium_mod_label] = '#arguments.rc.premium_mod_label#'
        ,[total_mod] = #val(arguments.rc.total_mod)#
        ,[inspection_override] = #arguments.rc.inspection_override#
        ,[rpg_override] = #arguments.rc.rpg_override#
        ,[base_override] = #arguments.rc.base_override#
        ,[statemuni_override] = #arguments.rc.statemuni_override#
        ,[filing_override] = #arguments.rc.filing_override#
 		WHERE rating_liability_id = #arguments.rc.rating_liability_id#

	</cfquery>
	<cfreturn arguments.rc.rating_liability_id />

	</cffunction>
	<cffunction name="totalRPG" returntype="numeric" output="yes">
		<cfargument name="client_id" required="yes">
		<cfquery name="data">
        select  sum(rl.rpgfee) as totalrpg
        from rating_liability rl
        inner join rating r
        on r.ratingid = rl.ratingid
        inner join locations l
        on r.location_id = l.location_id
        inner join clients c
        on c.client_id = l.client_id
        where c.client_id = #arguments.client_id#
        and l.location_status_id = 1
        and (r.history = 0 OR r.history is null)
		</cfquery>
		<cfif data.recordcount>
		<cfset result = val(data.totalrpg)>
		<cfelse>
		<cfset result = 0>
		</cfif>

		<cfreturn result />
	</cffunction>    
	<cffunction name="deletePD" output="yes">
		<cfargument name="proposal_doc_id" required="yes">
    <cfset result = "success">
    <cftry>
		<cfquery name="data">
			DELETE FROM proposal_docs
     WHERE proposal_doc_id = #ARGUMENTS.proposal_doc_id#
		</cfquery>
    <cfcatch type="any">
    <cfset result = cfcatch.Message>
    </cfcatch>
    </cftry>

		<cfreturn result />
	</cffunction>      
	<cffunction name ="getExpOther" output="yes">
		<cfargument name="rating_liability_id" required="yes">

		<cfquery name="qgetexpother">
			select * from rating_liability_otherexp
			where rating_liability_id = #val(arguments.rating_liability_id)#
		</cfquery>
		<cfreturn qgetexpother />
	</cffunction>
	<cffunction name="addRatingLiabilityOther">
		<cfargument name="rating_liability_id" required="yes">
		<cfargument name="new_expo">
		<cfargument name="new_annual">
		<cfquery name="qaddrlother">
			INSERT INTO rating_liability_otherexp
           (rating_liability_id
           ,expname
           ,other_annual)
     		VALUES
           (#arguments.rating_liability_id#
           ,'#arguments.new_expo#'
           ,#arguments.new_annual#)
		</cfquery>
	</cffunction>
	<cffunction name="updateRatingLiabilityOther">
		<cfargument name="otherexp_id" required="yes">
    <cfargument name="rating_liability_id" required="yes">
		<cfargument name="new_expo">
		<cfargument name="new_annual">
		<cfif arguments.otherexp_id eq 0 or arguments.otherexp_id eq ''>
		<cfquery name="qaddrlother">
			INSERT INTO rating_liability_otherexp
           (rating_liability_id
           ,expname
           ,other_annual)
     		VALUES
           (#arguments.rating_liability_id#
           ,'#arguments.new_expo#'
           ,#arguments.new_annual#)
		</cfquery>    
    <cfelse>
		<cfquery name="qaddrlother">
			UPDATE rating_liability_otherexp
			set expname='#arguments.new_expo#'
			,other_annual=#arguments.new_annual#
			where otherexp_id = #arguments.otherexp_id#
		</cfquery>
    </cfif>
	</cffunction>
	<cffunction name="editRatingLiabilityOther">
		<cfargument name="otherexp_id" required="yes">
		<cfargument name="new_expo">
		<cfargument name="new_annual">
	
		<cfquery name="qaddrlother">
			UPDATE rating_liability_otherexp
			set expname='#arguments.new_expo#'
			,other_annual=#arguments.new_annual#
			where otherexp_id = #arguments.otherexp_id#
		</cfquery>
	</cffunction>  
	<cffunction name="addRatingProperty">
		<cfargument name="ratingid" required="yes">
		<cfargument name="rc" required="yes">
		<cfquery name="qaddratingproperty">
		INSERT INTO [rating_property]
           ([ratingid]
           ,[prop_deductible]
           ,[prop_exclwind]
           ,[prop_winddeductable]
           ,[prop_buildingrate]
           ,[prop_buildinglimit]
           ,[prop_buildingpremium]
           ,[prop_bpprate]
           ,[prop_bpplimit]
           ,[prop_bpppremium]
           ,[prop_tirate]
           ,[prop_tilimit]
           ,[prop_tipremium]
           ,[prop_90]
           ,[prop_bieerate]
           ,[prop_bieelimit]
           ,[prop_bieepremium]
           ,[prop_daysdeductible]
           ,[prop_edprate]
           ,[prop_edplimit]
           ,[prop_edppremium]
           ,[prop_hvacrate]
           ,[prop_hvaclimit]
           ,[prop_hvacpremium]
           ,[prop_signrate]
           ,[prop_signlimit]
           ,[prop_signpremium]
           ,[prop_equipbreakrate]
           ,[prop_equipbreaktotal]
           ,[prop_equipbreakpremium]
           ,[employee_dishonesty_id]
           ,[property_emp_amount]
           ,[cyber_liability_amount_id]
           ,[property_cyber_amount]
           ,[prop_floodrate]
           ,[prop_floodlimit]
           ,[prop_floodpremium]
           ,[prop_flooddeduct]
           ,[prop_quakerate]
           ,[prop_quakelimit]
           ,[prop_quakepremium]
           ,[prop_quakededuct]
           ,[premium_override]
           ,[prop_ratedpremium]
           ,[prop_chargedpremium]
		   ,[prop_proratapremium]
       			,[prop_taxoverride]
           ,[prop_taxes]
           ,[prop_use_prorata]
           ,[prop_agencyfee]
           ,[prop_agencyfeeoverride]
           ,[prop_agencyamount]
           ,[prop_terrorism_rejected]
           ,[prop_terrorism]
           ,[prop_grandtotal]
           ,[propdate1]
           ,[propdate2]
           ,[prop_prorate]
           ,[prop_underwritingnotes]
           ,[prop_yesnoquestions]
           ,[property_propnotes]
           ,[prop_historydate]
           ,[prop_subtotal])
     VALUES
           (#arguments.ratingid#
           ,#arguments.rc.prop_deductible#
           ,#arguments.rc.prop_exclwind#
           ,'#arguments.rc.prop_winddeductable#'
           ,#arguments.rc.prop_buildingrate#
           ,#arguments.rc.prop_buildinglimit#
           ,#arguments.rc.prop_buildingpremium#
           ,#arguments.rc.prop_bpprate#
           ,#arguments.rc.prop_bpplimit#
           ,#arguments.rc.prop_bpppremium#
           ,#arguments.rc.prop_tirate#
           ,#arguments.rc.prop_tilimit#
           ,#arguments.rc.prop_tipremium#
           ,#arguments.rc.prop_90#
           ,#arguments.rc.prop_bieerate#
           ,#arguments.rc.prop_bieelimit#
           ,#arguments.rc.prop_bieepremium#
           ,#arguments.rc.prop_daysdeductible#
           ,#arguments.rc.prop_edprate#
           ,#arguments.rc.prop_edplimit#
           ,#arguments.rc.prop_edppremium#
           ,#arguments.rc.prop_hvacrate#
           ,#arguments.rc.prop_hvaclimit#
           ,#arguments.rc.prop_hvacpremium#
           ,#arguments.rc.prop_signrate#
           ,#arguments.rc.prop_signlimit#
           ,#arguments.rc.prop_signpremium#
           ,#arguments.rc.prop_equipbreakrate#
           ,#arguments.rc.prop_equipbreaktotal#
           ,#arguments.rc.prop_equipbreakpremium#
           ,#arguments.rc.employee_dishonesty_id#
           ,#arguments.rc.property_emp_amount#
           ,#arguments.rc.cyber_liability_amount_id#
           ,#arguments.rc.property_cyber_amount#
           ,#arguments.rc.prop_floodrate#
           ,#arguments.rc.prop_floodlimit#
           ,#arguments.rc.prop_floodpremium#
           ,#arguments.rc.prop_flooddeduct#
           ,#arguments.rc.prop_quakerate#
           ,#arguments.rc.prop_quakelimit#
           ,#arguments.rc.prop_quakepremium#
           ,#arguments.rc.prop_quakededuct#
           ,#arguments.rc.premium_override#
           ,#arguments.rc.prop_ratedpremium#
           ,#arguments.rc.prop_chargedpremium#
		   ,#arguments.rc.prop_proratapremium#
       ,#arguments.rc.prop_taxoverride#
           ,#arguments.rc.prop_taxes#
           ,#arguments.rc.prop_use_prorata#
           ,#arguments.rc.prop_agencyfee#
           ,#arguments.rc.prop_agencyfeeoverride#
           ,#arguments.rc.prop_agencyamount#
           ,#arguments.rc.prop_terrorism_rejected#
           ,#arguments.rc.prop_terrorism#
           ,#arguments.rc.prop_grandtotal#
           ,'#arguments.rc.propdate1#'
           ,'#arguments.rc.propdate2#'
           ,#arguments.rc.prop_prorate#
           ,'#arguments.rc.prop_underwritingnotes#'
           ,'#arguments.rc.prop_yesnoquestions#'
           ,'#arguments.rc.property_propnotes#'
           ,#createodbcdatetime(now())#
           ,#arguments.rc.prop_subtotal#)

			select @@IDENTITY as PROPID;
		</cfquery>
		<cfreturn qaddratingproperty.propid />
	</cffunction>
  <cffunction name="renewDates" output="true" returntype="any">
  	<cfargument name="client_id" required="yes">
    <cfargument name="current_effective_date" required="yes">
    <cfset expDate =  dateFormat(dateAdd("d",365,ARGUMENTS.current_effective_date))> 
    <cfset result = "success">
    <cftry>
    <cfquery>
    UPDATE clients
    SET current_effective_date = <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.current_effective_date#">
    WHERE client_id = #arguments.client_id#
    </cfquery>
    <cfset locations = getLocations(client_id)>

    <cfloop query="locations">
    <cfif locations.exclude_prop neq 1 AND locations.location_status_id eq 1>
			<cfquery>
      UPDATE rating_liability
      SET gldate1 = <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.current_effective_date#">,
      gldate2 = <cfqueryparam cfsqltype="cf_sql_date" value="#expDate#">
      WHERE ratingid = #val(locations.myratingid)#
      </cfquery>
			<cfquery>
      UPDATE rating_property
      SET propdate1 = <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.current_effective_date#">,
      propdate2 = <cfqueryparam cfsqltype="cf_sql_date" value="#expDate#">
      WHERE ratingid = #val(locations.myratingid)#
      </cfquery>      
      </cfif>
    </cfloop>
    <cfcatch type="any">
    	<cfset result = "#cfcatch.Message#">
    </cfcatch>
    </cftry>
    
    <cfreturn result />
  </cffunction>

	<cffunction name="editRatingProperty">
		<cfargument name="ratingid" required="yes">
		<cfargument name="rc" required="yes">
		<cfquery name="qeditproperty">
		UPDATE [rating_property]
  		 SET [ratingid] = #arguments.rc.ratingid#
      ,[prop_deductible] = #arguments.rc.prop_deductible#
      ,[prop_exclwind] = #arguments.rc.prop_exclwind#
      ,[prop_winddeductable] = '#arguments.rc.prop_winddeductable#'
      ,[prop_buildingrate] = #arguments.rc.prop_buildingrate#
      ,[prop_buildinglimit] = #arguments.rc.prop_buildinglimit#
      ,[prop_buildingpremium] = #arguments.rc.prop_buildingpremium#
      ,[prop_bpprate] = #arguments.rc.prop_bpprate#
      ,[prop_bpplimit] = #arguments.rc.prop_bpplimit#
      ,[prop_bpppremium] = #arguments.rc.prop_bpppremium#
      ,[prop_tirate] = #arguments.rc.prop_tirate#
      ,[prop_tilimit] = #arguments.rc.prop_tilimit#
      ,[prop_tipremium] = #arguments.rc.prop_tipremium#
      ,[prop_90] = #arguments.rc.prop_90#
      ,[prop_bieerate] = #arguments.rc.prop_bieerate#
      ,[prop_bieelimit] = #arguments.rc.prop_bieelimit#
      ,[prop_bieepremium] = #arguments.rc.prop_bieepremium#
      ,[prop_daysdeductible] = #arguments.rc.prop_daysdeductible#
      ,[prop_edprate] = #arguments.rc.prop_edprate#
      ,[prop_edplimit] = #arguments.rc.prop_edplimit#
      ,[prop_edppremium] = #arguments.rc.prop_edppremium#
      ,[prop_hvacrate] = #arguments.rc.prop_hvacrate#
      ,[prop_hvaclimit] = #arguments.rc.prop_hvaclimit#
      ,[prop_hvacpremium] = #arguments.rc.prop_hvacpremium#
      ,[prop_signrate] = #arguments.rc.prop_signrate#
      ,[prop_signlimit] = #arguments.rc.prop_signlimit#
      ,[prop_signpremium] = #arguments.rc.prop_signpremium#
      ,[prop_equipbreakrate] = #arguments.rc.prop_equipbreakrate#
      ,[prop_equipbreaktotal] = #arguments.rc.prop_equipbreaktotal#
      ,[prop_equipbreakpremium] = #arguments.rc.prop_equipbreakpremium#
      ,[employee_dishonesty_id] = #arguments.rc.employee_dishonesty_id#
      ,[property_emp_amount] = #arguments.rc.property_emp_amount#
      ,[cyber_liability_amount_id] = #arguments.rc.cyber_liability_amount_id#
      ,[property_cyber_amount] = #arguments.rc.property_cyber_amount#
      ,[prop_floodrate] = #arguments.rc.prop_floodrate#
      ,[prop_floodlimit] = #arguments.rc.prop_floodlimit#
      ,[prop_floodpremium] = #arguments.rc.prop_floodpremium#
      ,[prop_flooddeduct] = #arguments.rc.prop_flooddeduct#
      ,[prop_quakerate] = #arguments.rc.prop_quakerate#
      ,[prop_quakelimit] = #arguments.rc.prop_quakelimit#
      ,[prop_quakepremium] = #arguments.rc.prop_quakepremium#
      ,[prop_quakededuct] = #arguments.rc.prop_quakededuct#
      ,[premium_override] = #arguments.rc.premium_override#
      ,[prop_ratedpremium] = #arguments.rc.prop_ratedpremium#
      ,[prop_chargedpremium] = #arguments.rc.prop_chargedpremium#
      ,[prop_proratapremium] = #arguments.rc.prop_proratapremium#
      ,[prop_taxoverride] = #arguments.rc.prop_taxoverride#
      ,[prop_taxes] = #arguments.rc.prop_taxes#
      ,[prop_use_prorata] = #arguments.rc.prop_use_prorata#
      ,[prop_agencyfee] = #arguments.rc.prop_agencyfee#
      ,[prop_agencyfeeoverride] = #arguments.rc.prop_agencyfeeoverride#
      ,[prop_agencyamount] = #arguments.rc.prop_agencyamount#
      ,[prop_terrorism_rejected] = #arguments.rc.prop_terrorism_rejected#
      ,[prop_terrorism] = #arguments.rc.prop_terrorism#
      ,[prop_grandtotal] = #arguments.rc.prop_grandtotal#
      ,[propdate1] = '#arguments.rc.propdate1#'
      ,[propdate2] = '#arguments.rc.propdate2#'
      ,[prop_prorate] = #arguments.rc.prop_prorate#
      ,[prop_underwritingnotes] = '#arguments.rc.prop_underwritingnotes#'
      ,[prop_yesnoquestions] = '#arguments.rc.prop_yesnoquestions#'
      ,[property_propnotes] = '#arguments.rc.property_propnotes#'
      ,[prop_historydate] = #createodbcdatetime(now())#
      ,[prop_subtotal] = #arguments.rc.prop_subtotal#
 		WHERE [rating_property_id] = #arguments.rc.rating_property_id#
  
	</cfquery>
    <cfreturn arguments.rc.rating_property_id />
	</cffunction>

	<cffunction name ="getDebitCredit" output="yes">
	 <cfargument name="rating_liability_id" required="yes">
   <cfargument name="debtcredit_type" required="yes">

		<cfquery name="qgetdebt">
			select * from rating_liability_debtcredits
			where rating_liability_id=#val(arguments.rating_liability_id)#
            and debtcredit_type = #val(arguments.debtcredit_type)#
		</cfquery>
		<cfreturn qgetdebt />
	</cffunction>
	<cffunction name="addDebtCredit">
		<cfargument name="rating_liability_id" required="yes">
		<cfargument name="debtcredit_name">
		<cfargument name="debtcredit_value">
        <cfargument name="debtcredit_type">
		<cfquery name="qadddebt">
			INSERT INTO [rating_liability_debtcredits]
           ([rating_liability_id]
           ,[debtcredit_name]
           ,[debtcredit_value]
           ,[debtcredit_type])
     		VALUES
           (#arguments.rating_liability_id#
           ,'#arguments.debtcredit_name#'
           ,#arguments.debtcredit_value#
           ,#arguments.debtcredit_type#)
		</cfquery>
	</cffunction>
	<cffunction name="editDebtCredit">
		<cfargument name="debtcredit_id" required="yes">
		<cfargument name="debtcredit_name">
		<cfargument name="debtcredit_value">
        <cfargument name="debtcredit_type">
		<cfquery name="qadddebt">
			UPDATE [rating_liability_debtcredits]
			SET [debtcredit_name] ='#arguments.debtcredit_name#'
           ,[debtcredit_value]=#arguments.debtcredit_value#
           ,[debtcredit_type]=#arguments.debtcredit_type#
			WHERE debtcredit_id=#arguments.debtcredit_id#
		</cfquery>
	</cffunction>
	<cffunction name="getEb">
		<cfargument name="rating_property_id">
		<cfquery name="qgeteb">
		select * from rating_property_eb
		where rating_property_id = #val(arguments.rating_property_id)#
		</cfquery>
		<cfreturn qgeteb>
	</cffunction>
	<cffunction name="addEb">
		<cfargument name="rating_property_id">
		<cfargument name="eb_title">
		<cfargument name='eb_rate'>
		<cfargument name="eb_limit">
		<cfargument name="eb_premium">
		<cfargument name="eb_deductible">
		<cfquery name="qaddeb">
			INSERT INTO [rating_property_eb]
           ([rating_property_id]
           ,[eb_title]
           ,[eb_rate]
           ,[eb_limit]
           ,[eb_premium]
           ,[eb_deductible])
    		 VALUES
           (#arguments.rating_property_id#
           ,'#arguments.eb_title#'
           ,#arguments.eb_rate#
           ,#arguments.eb_limit#
           ,#arguments.eb_premium#
           ,#arguments.eb_deductible#)
		</cfquery>
      </cffunction>
	<cffunction name="editEb">
		<cfargument name="eb_id">
		<cfargument name="eb_title">
		<cfargument name='eb_rate'>
		<cfargument name="eb_limit">
		<cfargument name="eb_premium">
		<cfargument name="eb_deductible">
		<cfquery name="qupeb">
		UPDATE [rating_property_eb]
   		SET [eb_title] = '#arguments.eb_title#'
      ,[eb_rate] = #arguments.eb_rate#
      ,[eb_limit] = #arguments.eb_limit#
      ,[eb_premium] = #arguments.eb_premium#
      ,[eb_deductible] = #arguments.eb_deductible#
 		WHERE eb_id = #arguments.eb_id#
		</cfquery>
	</cffunction>
	<cffunction name="getRatingPropertyOther">
		<cfargument name="rating_property_id">
		<cfquery name="qgetrpo">
		select * from rating_property_other
		where rating_property_id = #val(arguments.rating_property_id)#
		</cfquery>
		<cfreturn qgetrpo />
	</cffunction>
	<cffunction name="addratingpropertyother">
		<cfargument name="rating_property_id">
		<cfargument name="other_title">
		<cfargument name="other_rate">
		<cfargument name="other_limit">
		<cfargument name="other_premium">
		<cfquery name="qaddrpo">
			INSERT INTO [rating_property_other]
	           ([rating_property_id]
	           ,[other_title]
	           ,[other_rate]
	           ,[other_limit]
	           ,[other_premium])
	     	VALUES
	           (#arguments.rating_property_id#
	           ,'#arguments.other_title#'
	           ,#arguments.other_rate#
	           ,#arguments.other_limit#
	           ,#arguments.other_premium#)
	      </cfquery>
	</cffunction>
	<cffunction name="editRatingPropertyOther">
		<cfargument name="other_property_id">
		<cfargument name="other_title">
		<cfargument name="other_rate">
		<cfargument name="other_limit">
		<cfargument name="other_premium">
		<cfquery name="qupdrpo">
		UPDATE [rating_property_other]
   		SET [other_title] = '#arguments.other_title#'
	      ,[other_rate] = #arguments.other_rate#
	      ,[other_limit] = #arguments.other_limit#
	      ,[other_premium] = #arguments.other_premium#
	 		WHERE other_property_id = #arguments.other_property_id#
		</cfquery>
	</cffunction>
	<cffunction name="getCinfo" access="public">
		<cfargument name="location_id" required="yes">
		<cfquery name="qgetcinfo">
			select l.*,ca.code,s.name as state, c.entity_name as client_ni, c.mailing_address, c.mailing_address2, c.mailing_city, c.mailing_zip, ss.name as mailing_statename, c.current_effective_date, l.dba as cdba, c.ams, cs.name as statusname
			from locations l
			inner join clients c on c.client_id=l.client_id
			left join client_affiliations ca on ca.affiliation_id=c.affiliation_id 
			inner join states s on s.state_id=l.state_id
			inner join states ss on ss.state_id = c.mailing_state
      left join client_status cs on c.client_status_id = cs.client_status_id
			where l.location_id=#arguments.location_id#
		</cfquery>
		<cfreturn qgetcinfo />
	</cffunction>
</cfcomponent>