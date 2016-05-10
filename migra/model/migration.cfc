<cfcomponent output="false">
	<cffunction name="init" returntype="any" output="false">
		<cfreturn this />
	</cffunction>
	<cffunction name="clientUpdate" returntype="any" output="false">
	<!---argument not needed but I included it so you can see how to use for other stuff--->
	<cfargument name="testargument" type="any" default="" required="no" />
	<cfparam name="result" default="success" />
	<cfquery name="ClientAccess" datasource="Gym">
		select * from "0-MAIN CLIENT SCREEN" where "Client Status 1 2 3" = 2;
	</cfquery>
	<cftry>
		<cfloop query="ClientAccess">
		    <cfset ao = CreateAccessObject() />
		    <cfset ao.num.gym_id = ClientID />
		
			<cfset ao.str.entity_name = ClientAccess["Insd Name"][currentrow] />
			<cfset ao.str.dba = ClientAccess["Insd DBA"][currentrow] />
			<cfset ao.str.mailing_address = ClientAccess["Insd Mailing Address"][currentrow] />
			<!--- mailing_address2 : does not exist within gym. --->
			<cfset ao.str.mailing_city = ClientAccess["Insd Mailing City"][currentrow] />
			<!--- INT? <cfset ao.str.mailing_state = ClientAccess["Insd Mailing State"][currentrow] /> --->
			<cfset ao.str.mailing_zip = ClientAccess["Insd Mailing Zip"][currentrow] />
			<cfset ao.str.business_phone = ClientAccess["Insd Phone"][currentrow] />
			<cfset ao.str.business_email = ClientAccess["Insd Email"][currentrow] />
			<cfset ao.str.website = ClientAccess["Insd WebSite"][currentrow] />
			<cfset ao.str.fein = ClientAccess["Insd FEIN"][currentrow] />
			
			<cfset ao.str.x_reference = ClientAccess["Cross Ref ID"][currentrow] /> 
			
			
			<cfset ao.str.client_code = ClientAccess["Tam Client##"][currentrow] />
			
			
		    <cfset ao.str.client_notes = ClientAccess["Insd Memo"][currentrow] />
				
				
				
				
				
				
		    <cfset result = MigrateToRaps( "clients", ao ) />
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
	
	<!--- Checks a table in raps and updates or inserts an object. --->
	<cffunction name="MigrateToRaps">
		<cfargument name="rapsTable" />
		<cfargument name="gymObject" />
		<cfparam name="result" default="success" />
		<cftry>
			<cfoutput>
				select * from dbo.#rapsTable# where gym_id = #gymObject.num.gym_id#; 
			</cfoutput>
			<cfquery name="CheckTable" datasource="raps"> 
		  		select * from dbo.#rapsTable# where gym_id = #gymObject.num.gym_id#; 
		  	</cfquery>
			
		  	<cfif CheckTable.recordcount>
		        <cfset TableQuery = "update dbo.clients set #GetMigrationUpdateObject( gymObject )# where gym_id = #gymObject.num.gym_id#;" />
		    <cfelse>
		        <cfset TableQuery = "insert into dbo.clients #GetMigrationInsertObject( gymObject )#;" />
		    </cfif>
			<cfquery name="TableUpdate" datasource="raps"> 
				#REReplace(TableQuery,"''","'","ALL")#
	    	</cfquery>
			<cfcatch type="any">
				<cfset result = "#cfcatch.Message# - #cfcatch.Detail# --- Query: #TableQuery#" />
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
				<cfset temp = ArrayAppend( returnStringArray, LCase( quoteAtb[i] ) & " = '" & REReplace( Object["str"][quoteAtb[i]], "'", "&apos;", "ALL" ) & "'" ) />
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
				<cfset temp = ArrayAppend( returnStringArray, "'" & REReplace( Object["str"][quoteAtb[i]], "'", "&apos;", "ALL" ) & "'" ) />
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
</cfcomponent>