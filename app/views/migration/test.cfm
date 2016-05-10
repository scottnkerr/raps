<cfset date1 = now()>
<cfset date2 = dateAdd("d",360,date1)>
<cfset days = dateDiff("d",date1,date2)>
<cfset factor = numberFormat(days / 365,"0.000")>
<cfdump var="#factor#">


<cfsetting requesttimeout="600">
		<cfquery name="getLocations" datasource="Gym">
		select *
        FROM [0-LOC INFO]
        WHERE ClientID = 30170
		</cfquery>
<cfloop query="getLocations">
            <cfset ao.str.prop_grandtotal = val(getLocations["MOD PREM"][currentrow])+val(getLocations["MOD FEE"][currentrow])+val(getLocations["Equip Break Prem Unmod"][currentrow])+val(getLocations["ED PREM"][currentrow])+val(getLocations["prop state surch"][currentrow])+val(getLocations["prop muni surch"][currentrow])+val(getLocations["fl sl tax"][currentrow])+val(getLocations["fl stamp"][currentrow])+val(getLocations["fl asmt"][currentrow])>
			<cfif getLocations["bco"][currentrow] eq "ONE">
            <cfset extraamount = (val(getLocations["mod prem"][currentrow]) + val(getLocations["equip break prem unmod"][currentrow]))*0.03 >
            <cfset ao.str.prop_grandtotal = ao.str.prop_grandtotal + extraamount>
            </cfif>
            <cfoutput>#ao.str.prop_grandtotal#<br></cfoutput>
</cfloop>
    

        

<cfabort>
 	<cffunction name="getLiabilityPlan" output="yes" returntype="any">
		<cfargument name="GymPlanID" type="any" required="yes">
		<cfparam name="result" default="0">
		<cfquery datasource="Gym" name="gymdata">
		select "CONGLOM CODE" as ccode, "DESCRIPTION" as plandesc
		from "LU Plan Premiums by Conglom"	
		WHERE "PLAN##" = #ARGUMENTS.GymPlanID#	
		</cfquery>
        <cfdump var="#gymdata#">
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
        <cfabort>


		<cfquery name="data" datasource="Gym">
		select lochistid from "0-loc info history"

		</cfquery>
        <cfdump var="#data#">
        <cfabort>
<cfloop from="1" to="10" index="i">
<cfquery datasource="gym" name="getstuff">
    select TOP 1 clientid, tame#i#  
    FROM "0-other lines of business"
    where clientid = 3121
</cfquery>
<cfdump var="#getstuff#">
</cfloop>

<cfabort>
 <cfquery datasource="Gym" name="getpolicydrop">
 SELECT *
FROM [LU GYM POL TYPES]
</cfquery>
<cfquery datasource="Gym" name="getissuing">
SELECT *
FROM [LU Issuing Company Names];
</cfquery>
<cfdump var="#getpolicydrop#">   
<cfdump var="#getissuing#">
<cfquery datasource="gym" name="policyinfo">
select top 10 * from "0-POL INFO"
</cfquery>
<cfdump var="#policyinfo#">
<!---
<cfset field = "testfield">
<cfset value = "testvalue">
<cfset ao.num[field] = value>
			<cfset ao.str.air_structure = 'testing'>
			<cfset ao.num.building_coverage_amount = 111>
<cfdump var="#ao#">
<cfset fields = convertField(OtherDesc='HVAsC',OtherLimit=1000000,OtherPrem=100,OtherDed=0)>
<cfif structKeyExists(fields,'num')>
<cfset structAppend(ao.num,fields.num)>
</cfif>
<cfif structKeyExists(fields,'str')>
<cfset structAppend(ao.str,fields.str)>
</cfif>
<cfif structKeyExists(fields,'notes')>

</cfif>
<cfdump var="#ao#">
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
			</cfif>
		<cfset fields.num.cyber_liability_amount_id = cyberid>
		<cfset fields.num.property_cyber_amount = val(ARGUMENTS.OtherPrem)>
		<cfelseif findnocase('HVAC',ARGUMENTS.OtherDesc) gt 0>
		
		<cfset fields.num.prop_hvaclimit = val(ARGUMENTS.OtherLimit)>
		<cfset fields.num.prop_hvacpremium = val(ARGUMENTS.OtherPrem)>
			<cfif fields.num.prop_hvaclimit neq 0 AND fields.num.prop_hvacpremium neq 0>
			<cfset fields.num.prop_hvacrate = fields.num.prop_hvaclimit / fields.num.prop_hvacpremium * 100>
			</cfif>		
		<cfelse>
		<cfset fields.notes = "OTHER COVERAGE - #ARGUMENTS.OtherDesc# Limit: #val(ARGUMENTS.OtherLimit)# Premium: #val(ARGUMENTS.OtherPrem)# Deductible: #val(ARGUMENTS.OtherDed)#">
		</cfif>

		<cfreturn fields />
	</cffunction>
--->
		<cfquery name="data" datasource="Gym">
		select *
		from "0-MISC SPECIFIC" 
		WHERE LocID = 2611
		</cfquery>
		
		<cfdump var="#data#">
		<cfabort>
		<cfquery name="data2" datasource="Gym">
		select * from "0-MISC SPECIFIC"
		WHERE "OTHER 1 DESC" <> null
		ORDER BY "OTHER 1 DESC" asc
		</cfquery>
<cfdump var="#data2#">	
<cfabort>
<cfquery datasource="Gym" name="getlocations" >
select  "BCO NAME"
from "LU Billing Co Info"
</cfquery>

		<cfquery datasource="Gym" name="gymdata">
		select "CONGLOM CODE" as ccode, "DESCRIPTION" as plandesc
		from "LU Plan Premiums by Conglom"	
		WHERE "PLAN##" = 172	
		</cfquery>
		
Rating history: 0-LOC INFO HISTORY
Property Plans: LU Prop Rates or LU Billing Co Info?
Liability Plans: LU Plan Premiums by Conglom
<cfdump var="#getlocations#">