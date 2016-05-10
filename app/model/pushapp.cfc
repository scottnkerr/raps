<cfcomponent output="false">
	<cffunction name="init" returntype="any" output="false">
		<cfreturn this />
	</cffunction>
	<cffunction name="saveWebApp" returntype="struct" output="false">
    <cfargument name="form" type="struct">
    <cfparam name="response.success" default="false" type="boolean">
    <cfparam name="response.data" default="">
    <cftry>
		<cfquery name="data" datasource="raps">
        INSERT INTO web_applications (
        name,
        title,
        phone,
        cell,
        fax,
        email,
        eff_date,
        curr_ins_carr,
        named_insrd,
        dba,
        loc_addr,
        loc_addr2,
        loc_city,
        loc_state,
        loc_zip,
        website,
        year_started,
        yrs_in_bus,
        club_sq_ft,
        annual_gross,
        nbr_mbrs,
        fulltime,
        parttime,
        hrs_of_oper,
        key_club,
        date_submitted)
        VALUES (        
        '#name#',
        '#title#',
        '#phone#',
        '#cell#',
        '#fax#',
        '#email#',
        '#eff_date#',
        '#curr_ins_carr#',
        '#named_insrd#',
        '#dba#',
        '#loc_addr#',
        '#loc_addr2#',
        '#loc_city#',
        '#loc_state#',
        '#loc_zip#',
        '#website#',
        '#year_started#',
        '#yrs_in_bus#',
        '#club_sq_ft#',
        '#annual_gross#',
        '#nbr_mbrs#',
        '#fulltime#',
        '#parttime#',
        '#hrs_of_oper#',
        '#key_club#',
        #Now()#)
		</cfquery>
        <cfquery datasource="raps" name="getnew">
        select MAX(ID) as newid
        from web_applications
        </cfquery> 
        <cfset response.success = true>
        <cfset response.data = getnew.newid>
        <cfcatch type="any">
        <cfset response.success = false>
        <cfset response.data = "#cfcatch.Message# - #cfcatch.Detail#">
        </cfcatch>
        </cftry>       
		<cfreturn response />
	</cffunction> 
	<cffunction name="checkPush" returntype="any" output="false">
    <cfargument name="ID" type="numeric" required="yes">  
    <cfquery name="data" datasource="raps">
    SELECT * from web_applications
    WHERE ID = #ARGUMENTS.ID#
    </cfquery>
    <cfif data.pushed eq 1>
    <cfset result = 1>
    <cfelse>
    <cfset result = 0>
    </cfif>
    <cfreturn result>
    </cffunction>      
</cfcomponent>