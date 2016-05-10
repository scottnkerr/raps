<cfcomponent>
	<cffunction name="init" access="public" returntype="void">
		<cfargument name="fw" type="any" required="yes" />
		<cfset variables.fw = arguments.fw />
		<!--- Set up the gateway to the model.component to make it available to all functions in the controller --->
		<cfset migrationGW = createObject('component','app.model.migration').init() />  
              
	</cffunction>
  
	<cffunction name="clientUpdate" access="public">
	    <cfargument name="rc" type="any">
  		<cfparam name="rc.clientid" default="0">
   		<cfsetting requesttimeout="600">
		<cfset rc.result = migrationGW.clientUpdate(rc.clientid)>
	</cffunction>   
	<cffunction name="locationUpdate" access="public">
	    <cfargument name="rc" type="any">
  <cfparam name="rc.clientid" default="0">
    <cfsetting requesttimeout="600">
		<cfset rc.result = migrationGW.locationUpdate(rc.clientid)>
		<cfset variables.fw.setView("migration.default")>
	</cffunction> 
	<cffunction name="applicationUpdate" access="public">
	    <cfargument name="rc" type="any">
  <cfparam name="rc.clientid" default="0">
	<cfsetting requesttimeout="600">
		<cfset rc.result = migrationGW.applicationUpdate(clientid=rc.clientid)>
		<cfset variables.fw.setView("migration.default")>
	</cffunction> 
	<cffunction name="ratingUpdate" access="public">
	    <cfargument name="rc" type="any">
  <cfparam name="rc.clientid" default="0">
		<cfsetting requesttimeout="600">
		<cfset rc.result = migrationGW.ratingUpdate(clientid=rc.clientid)>
		<cfset variables.fw.setView("migration.default")>
	</cffunction> 
	<cffunction name="ratingGLUpdate" access="public">
	    <cfargument name="rc" type="any">
  <cfparam name="rc.clientid" default="0">
	<cfsetting requesttimeout="600">
		<cfset rc.result = migrationGW.ratingGLUpdate(clientid=rc.clientid)>
		<cfset variables.fw.setView("migration.default")>
	</cffunction> 
	<cffunction name="ratingPropUpdate" access="public">
	    <cfargument name="rc" type="any">
  <cfparam name="rc.clientid" default="0">
	<cfsetting requesttimeout="600">
		<cfset rc.result = migrationGW.ratingPropUpdate(clientid=rc.clientid)>
		<cfset variables.fw.setView("migration.default")>
	</cffunction> 
	<cffunction name="applicationHisUpdate" access="public">
	    <cfargument name="rc" type="any">
  <cfparam name="rc.clientid" default="0">
	<cfsetting requesttimeout="1200">
		<cfset rc.result = migrationGW.applicationUpdate(history=1,clientid=rc.clientid)>
		<cfset variables.fw.setView("migration.default")>
	</cffunction>     	
	<cffunction name="ratingHisUpdate" access="public">
	    <cfargument name="rc" type="any">
  <cfparam name="rc.clientid" default="0">
		<cfsetting requesttimeout="600">
		<cfset rc.result = migrationGW.ratingUpdate(history=1,clientid=rc.clientid)>
		<cfset variables.fw.setView("migration.default")>
	</cffunction> 
	<cffunction name="ratingHisGLUpdate" access="public">
	    <cfargument name="rc" type="any">
  <cfparam name="rc.clientid" default="0">
	<cfsetting requesttimeout="600">
		<cfset rc.result = migrationGW.ratingGLUpdate(history=1,clientid=rc.clientid)>
		<cfset variables.fw.setView("migration.default")>
	</cffunction> 
	<cffunction name="ratingHisPropUpdate" access="public">
	    <cfargument name="rc" type="any">
  <cfparam name="rc.clientid" default="0">
	<cfsetting requesttimeout="600">
		<cfset rc.result = migrationGW.ratingPropUpdate(history=1,clientid=rc.clientid)>
		<cfset variables.fw.setView("migration.default")>
	</cffunction>     
	<cffunction name="policyUpdate" access="public">
	    <cfargument name="rc" type="any">
  <cfparam name="rc.clientid" default="0">
  <cfparam name="rc.startrow" default="1">
  <cfparam name="rc.endrow" default="0">
	<cfsetting requesttimeout="1200">
		<cfset rc.result = migrationGW.policyUpdate(startrow=rc.startrow,endrow=rc.endrow,clientid=rc.clientid)>
		<cfset variables.fw.setView("migration.default")>
	</cffunction> 
	<cffunction name="otherLOCUpdate" access="public">
	    <cfargument name="rc" type="any">
  <cfparam name="rc.clientid" default="0">
	<cfsetting requesttimeout="600">
		<cfset rc.result = migrationGW.otherLOCUpdate(clientid=rc.clientid)>
		<cfset variables.fw.setView("migration.default")>
	</cffunction> 
	<cffunction name="contactUpdate" access="public">
	    <cfargument name="rc" type="any">
  <cfparam name="rc.clientid" default="0">
	<cfsetting requesttimeout="600">
		<cfset rc.result = migrationGW.contactUpdate(clientid=rc.clientid)>
		<cfset variables.fw.setView("migration.default")>
	</cffunction>
	<cffunction name="updateAll" access="public">
	    <cfargument name="rc" type="any">
	<cfsetting requesttimeout="1800">
		<cfset rc.result.clients = migrationGW.clientUpdate()>
        <cfset rc.result.contacts = migrationGW.contactUpdate()>
        <cfset rc.result.locations = migrationGW.locationUpdate()>
        <cfset rc.result.applications = migrationGW.applicationUpdate()>
        <cfset rc.result.ratings = migrationGW.ratingUpdate()>
        <cfset rc.result.glratings = migrationGW.ratingGLUpdate()>
        <cfset rc.result.propratings = migrationGW.ratingPropUpdate()>
        <cfset rc.result.policies = migrationGW.policyUpdate()>
        <cfset rc.result.otherLOC = migrationGW.otherLOCUpdate()>
		<cfset variables.fw.setView("migration.default")>
	</cffunction>   
  <cffunction name="singleClient" access="public" output="yes">
  <cfargument name="rc" type="any">
  <cfset rc.gymClients = migrationGW.getClients(clientid=0,orderBy='"AG2 REC","TAM CLIENT##"',limitByStatus=false)>
  <cfif isDefined("FORM.formSub")>
  <cfset rc.checkDup = migrationGW.checkDup(FORM.clientid)>
	<cfset rc.thisGymClient = migrationGW.getClients(clientid=FORM.clientid,limitByStatus=false)>
  </cfif>
  </cffunction>  
  <cffunction name="checkPolicyIssuing" access="public" output="yes">
  <cfargument name="rc" type="any">
  <cfsetting requesttimeout="1800">
 	<cfset notfoundarray = migrationGW.policyIssuingCheck()>
  <cfset cleanArray = arrayNew(1) />
  <cfdump var="#notfoundarray#">
  <cfloop from="1" to="#arrayLen(notfoundarray)#" index="i">
 	<cfset thisone = notfoundarray[i]>
      <cfif not ArrayFindNoCase(cleanArray,thisone)>
        <cfset arrayAppend(cleanArray, thisone) />
    </cfif>
  </cfloop>
  <cfdump var="#cleanArray#">

  <cfset variables.fw.setView("migration.default")>
  </cffunction>    
       	    			 	    
</cfcomponent>