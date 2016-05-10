<cfcomponent output="false">
	<cffunction name="init" returntype="any" output="false">
		<cfreturn this />
	</cffunction>
	<cffunction name="getlocations" returntype="any" output="false">
    <cfargument name="client_id" type="numeric" required="yes"> 
    <cfargument name="state_id" type="numeric" required="yes">  
    <cfquery name="data" datasource="raps">
    select a.*, b.name as statename from locations a
    inner join states b 
    on a.state_id = b.state_id
    where (location_status_id = 1
    or location_status_id = 2)
    and client_id = #ARGUMENTS.client_id#
    and (exclude_prop = 0
    or exclude_prop is null)
    <cfif ARGUMENTS.state_id neq 0>
    and a.state_id = #ARGUMENTS.state_id#
    </cfif>
    order by statename asc, a.location_number
    </cfquery>

    <cfreturn data>
    </cffunction> 
	<cffunction name="policyReportData" returntype="query" output="false">
    <cfargument name="startdate" type="date" required="yes"> 
    <cfargument name="enddate" type="date" required="yes">  
    <cfquery name="data" datasource="raps">
SELECT    clients.client_id, clients.entity_name, clients.ams, clients.client_code, clients.current_effective_date, 
DATEADD(year, 1, clients.current_effective_date) as renewal_date,
ISNULL(LEFT(users.user_firstname,1),'?')+ISNULL(LEFT(users.user_lastname,1),'') as user_initials,
(SELECT TOP 1 policy_info.policy_expiredate from policy_info where clients.client_id = policy_info.client_id 
AND policy_info.policy_type_id = 1 AND policy_info.policy_status_id = 1 AND policy_info.policy_expiredate BETWEEN <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.startdate#"> AND <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.enddate#"> ORDER BY policy_info.policy_expiredate DESC) AS GLRenewal,
(SELECT TOP 1 policy_info.policy_expiredate from policy_info where clients.client_id = policy_info.client_id 
AND policy_info.policy_type_id = 2 AND policy_info.policy_status_id = 1 AND policy_info.policy_expiredate BETWEEN <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.startdate#"> AND <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.enddate#"> ORDER BY policy_info.policy_expiredate DESC) AS PropRenewal,
(SELECT TOP 1 policy_info.policy_expiredate from policy_info where clients.client_id = policy_info.client_id 
AND policy_info.policy_type_id = 3 AND policy_info.policy_status_id = 1 AND policy_info.policy_expiredate BETWEEN <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.startdate#"> AND <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.enddate#"> ORDER BY policy_info.policy_expiredate DESC) AS EPLRenewal,
(SELECT TOP 1 policy_info.policy_expiredate from policy_info where clients.client_id = policy_info.client_id 
AND policy_info.policy_type_id = 4 AND policy_info.policy_status_id = 1 AND policy_info.policy_expiredate BETWEEN <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.startdate#"> AND <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.enddate#"> ORDER BY policy_info.policy_expiredate DESC) AS UmbRenewal,
(SELECT TOP 1 policy_info.policy_expiredate from policy_info where clients.client_id = policy_info.client_id 
AND policy_info.policy_type_id = 5 AND policy_info.policy_status_id = 1 AND policy_info.policy_expiredate BETWEEN <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.startdate#"> AND <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.enddate#"> ORDER BY policy_info.policy_expiredate DESC) AS ExcessRenewal,
(SELECT TOP 1 policy_info.policy_expiredate from policy_info where clients.client_id = policy_info.client_id 
AND policy_info.policy_type_id = 6 AND policy_info.policy_status_id = 1 AND policy_info.policy_expiredate BETWEEN <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.startdate#"> AND <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.enddate#"> ORDER BY policy_info.policy_expiredate DESC) AS WCRenewal,
(SELECT TOP 1 policy_info.policy_expiredate from policy_info where clients.client_id = policy_info.client_id 
AND policy_info.policy_type_id = 7 AND policy_info.policy_status_id = 1 AND policy_info.policy_expiredate BETWEEN <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.startdate#"> AND <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.enddate#"> ORDER BY policy_info.policy_expiredate DESC) AS BondRenewal,
(SELECT TOP 1 policy_info.policy_expiredate from policy_info where clients.client_id = policy_info.client_id 
AND policy_info.policy_type_id = 8 AND policy_info.policy_status_id = 1 AND policy_info.policy_expiredate BETWEEN <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.startdate#"> AND <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.enddate#"> ORDER BY policy_info.policy_expiredate DESC) AS QuakeRenewal,
(SELECT TOP 1 policy_info.policy_expiredate from policy_info where clients.client_id = policy_info.client_id 
AND policy_info.policy_type_id = 9 AND policy_info.policy_status_id = 1 AND policy_info.policy_expiredate BETWEEN <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.startdate#"> AND <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.enddate#"> ORDER BY policy_info.policy_expiredate DESC) AS FloodRenewal
FROM      dbo.clients
LEFT JOIN dbo.users 
ON clients.am = users.user_id
WHERE 1=1
AND (
(SELECT TOP 1 policy_info.policy_expiredate from policy_info where clients.client_id = policy_info.client_id 
AND policy_info.policy_type_id = 1 AND policy_info.policy_status_id = 1 ORDER BY policy_info.policy_expiredate DESC) BETWEEN <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.startdate#"> AND <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.enddate#">
OR (SELECT TOP 1 policy_info.policy_expiredate from policy_info where clients.client_id = policy_info.client_id 
AND policy_info.policy_type_id = 2 AND policy_info.policy_status_id = 1 ORDER BY policy_info.policy_expiredate DESC) BETWEEN <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.startdate#"> AND <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.enddate#">
OR (SELECT TOP 1 policy_info.policy_expiredate from policy_info where clients.client_id = policy_info.client_id 
AND policy_info.policy_type_id = 3 AND policy_info.policy_status_id = 1 ORDER BY policy_info.policy_expiredate DESC) BETWEEN <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.startdate#"> AND <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.enddate#">
OR (SELECT TOP 1 policy_info.policy_expiredate from policy_info where clients.client_id = policy_info.client_id 
AND policy_info.policy_type_id = 4 AND policy_info.policy_status_id = 1 ORDER BY policy_info.policy_expiredate DESC) BETWEEN <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.startdate#"> AND <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.enddate#">
OR (SELECT TOP 1 policy_info.policy_expiredate from policy_info where clients.client_id = policy_info.client_id 
AND policy_info.policy_type_id = 5 AND policy_info.policy_status_id = 1 ORDER BY policy_info.policy_expiredate DESC) BETWEEN <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.startdate#"> AND <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.enddate#">
OR (SELECT TOP 1 policy_info.policy_expiredate from policy_info where clients.client_id = policy_info.client_id 
AND policy_info.policy_type_id = 6 AND policy_info.policy_status_id = 1 ORDER BY policy_info.policy_expiredate DESC) BETWEEN <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.startdate#"> AND <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.enddate#">
OR (SELECT TOP 1 policy_info.policy_expiredate from policy_info where clients.client_id = policy_info.client_id 
AND policy_info.policy_type_id = 7 AND policy_info.policy_status_id = 1 ORDER BY policy_info.policy_expiredate DESC) BETWEEN <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.startdate#"> AND <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.enddate#">
OR (SELECT TOP 1 policy_info.policy_expiredate from policy_info where clients.client_id = policy_info.client_id 
AND policy_info.policy_type_id = 8 AND policy_info.policy_status_id = 1 ORDER BY policy_info.policy_expiredate DESC) BETWEEN <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.startdate#"> AND <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.enddate#">
OR (SELECT TOP 1 policy_info.policy_expiredate from policy_info where clients.client_id = policy_info.client_id 
AND policy_info.policy_type_id = 9 AND policy_info.policy_status_id = 1 ORDER BY policy_info.policy_expiredate DESC) BETWEEN <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.startdate#"> AND <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.enddate#">
)
ORDER BY clients.ams
    </cfquery>

    <cfreturn data>
    </cffunction>       
	<cffunction name="getClients" output="false">
    <cfargument name="client_status_id" default="2" required="no">
		<cfquery name="qdata" datasource="raps">
				SELECT client_id, client_code, entity_name, ams, am
                from clients
                where client_status_id = #ARGUMENTS.client_status_id#
		</cfquery>
		<cfreturn qdata />
	</cffunction> 
	<cffunction name="getPolicies" output="false">
    	<cfargument name="client_id" required="yes">
        <cfargument name="policy_status_id" default="1">
        <cfargument name="startdate" default="">
        <cfargument name="enddate" default="">
		
		<cfquery name="qdata" datasource="raps">
            select a.*, b.policy_type
            from policy_info a
            inner join policy_types b
            on a.policy_type_id = b.policy_type_id
            WHERE client_id = #ARGUMENTS.client_id#
            AND policy_status_id = #ARGUMENTS.policy_status_id#
            <cfif trim(ARGUMENTS.startdate) neq '' and trim(ARGUMENTS.enddate) neq ''>
            AND policy_expiredate between <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.startdate#"> and <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.enddate#">
            </cfif>
		</cfquery>		
		<cfreturn qdata />
	</cffunction> 
	<cffunction name="getMailingLabels" output="false">
		
		<cfquery name="qdata" datasource="raps">
        select a.entity_name, a.dba, a.mailing_address, a.mailing_address2, a.mailing_city, b.name as statename, a.mailing_zip
        from clients a
        inner join states b
        on a.mailing_state = b.state_id
        where label_needed = 1
		</cfquery>		
		<cfreturn qdata />
	</cffunction>  
	<cffunction name="clearPrintQueue" output="false">
		
		<cfquery name="qdata" datasource="raps">
        update clients
        set label_needed = 0
		</cfquery>	
        <cfset message = "success">	
		<cfreturn message />
	</cffunction>                    
</cfcomponent>