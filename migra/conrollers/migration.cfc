<cfcomponent>
	<cffunction name="init" access="public" returntype="void">
		<cfargument name="fw" type="any" required="yes" />
		<cfset variables.fw = arguments.fw />
		<!--- Set up the gateway to the model.component to make it available to all functions in the controller --->
		<cfset migrationGW = createObject('component','app.model.migration').init() />        
	</cffunction>
	<cffunction name="clientUpdate" access="public">
	    <cfargument name="rc" type="any">
		<cfset rc.result = migrationGW.clientUpdate()>
	</cffunction>  
</cfcomponent>