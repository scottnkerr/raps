
<cfcomponent name="reports" output="false">
	<cffunction name="init" output="false">
		<cfargument name="fw">
		<cfset variables.fw = arguments.fw> 
		<!--- Set up the gateway to the model.component to make it available to all functions in the controller --->
		<cfset mainGW = createObject('component','app.model.main').init()>
		<cfset appGW = createObject('component','app.model.app').init()>
        <cfset reportGW = createObject('component','app.model.reports').init()>
		<cfset JSON = createObject('component','app.model.services.json').init() />
	</cffunction>
	<cffunction name="default" access="public">
		<cfargument name="rc" type="any">

	</cffunction>
	<cffunction name="glSummary" access="public">
		<cfargument name="rc" type="any">
        <cfargument name="state" type="any" default="0">
        <cfset rc.title = "General Liability Summary - One or All States">
	</cffunction> 
	<cffunction name="glSummary2" access="public">
		<cfargument name="rc" type="any">
        <cfargument name="state" type="any" default="0">
        <cfset rc.title = "General Liability Summary - One or All States">
        <cfparam name="rc.client_id" default="0">
        <cfset rc.client = mainGW.getClient(client_id=rc.client_id)>
		<cfset rc.states = mainGW.getStates() />
	</cffunction> 
	<cffunction name="propSummary" access="public">
		<cfargument name="rc" type="any">
        <cfargument name="state" type="any" default="0">
        <cfset rc.title = "Property Summary - One or All States">
	</cffunction> 
	<cffunction name="propSummary2" access="public">
		<cfargument name="rc" type="any">
        <cfargument name="state" type="any" default="0">
        <cfset rc.title = "Property Summary - One or All States">
        <cfparam name="rc.client_id" default="0">
        <cfset rc.client = mainGW.getClient(client_id=rc.client_id)>
		<cfset rc.states = mainGW.getStates() />
	</cffunction>    
	<cffunction name="policyLabels" access="public">
		<cfargument name="rc" type="any">
        <cfset rc.title = "Policy Labels">
	</cffunction>
	<cffunction name="printPolicyLabels" access="public">
		<cfargument name="rc" type="any">
        <cfset rc.title = "Policy Labels">
        <cfparam name="rc.startdate" default="01/01/2001">
        <cfparam name="rc.enddate" default="01/01/2002">
        <cfset rc.reportQuery = reportGW.policyReportData(#rc.startdate#, #rc.enddate#)>
        
<!---        <cfset clients = reportGW.getClients()>
        <cfset dataArray = arrayNew(2)>
        <cfloop query="clients">
        <cfset dataArray[clients.currentrow][1] = #clients.entity_name#>
        <cfset dataArray[clients.currentrow][2] = #clients.client_code#>
        <cfset dataArray[clients.currentrow][3] = #clients.ams#>
        <cfset dataArray[clients.currentrow][4] = #clients.am#>
        <cfset policies = reportGW.getPolicies(client_id=clients.client_id,startdate=rc.startdate,enddate=rc.enddate)>
        <cfset dataArray[clients.currentrow][5] = #policies#>
        <cfset rc.data = dataArray>
        </cfloop>--->
	</cffunction>     
	<cffunction name="mailingLabels" access="public">
		<cfargument name="rc" type="any">
        <cfset rc.title = "Mailing Labels">
        <cfset rc.labels = reportGW.getMailingLabels()>
	</cffunction>                   
	<cffunction name="after" access="public" output="no" returntype="void">
		<cfargument name="rc" type="struct" required="yes" />
		<cfset rc.docs = mainGW.getdocs(0)>
	</cffunction> 
	<cffunction name="createReport" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.client_id" default="0">
        <cfparam name="rc.state_id" default="0">
        <cfparam name="rc.report_title" default="">
        <cfparam name="rc.template" default="report_glsummary">
        <cfparam name="message" default="default msg">
        <cfset rc.client = mainGW.getClient(client_id=rc.client_id)>
        <cfset rc.locations = reportGW.getLocations(client_id=rc.client_id,state_id=rc.state_id)>

        <cfset path = expandpath('.')>
        <cfset filename = 'Fitness-#rc.client.client_code#-#rc.report_title#.pdf'>
        <cftry>
    
        <cfdocument format="pdf" name="proposalpdf" margintop="1" marginbottom=".75" backgroundvisible="yes" localurl="true" filename="#path#\reports\#filename#" overwrite="yes" fontembed="no">
        <cfoutput>
        <html>
        <body style="position: relative; font-family:Arial, Helvetica, sans-serif;">

       
<cfinclude template="../views/common/#rc.template#.cfm">
        </body>
        </html>
        </cfoutput>
        
        <cfdocumentitem type="footer" evalAtPrint="true">
       <p style="text-align:center; font-family:Arial, Helvetica, sans-serif; font-size:14px; line-height:18px;">2170 S. Parker Rd, Suite 251 <span style="color:white">W</span>|<span style="color:white">W</span>Denver, CO  80231<span style="color:white">W</span>|<span style="color:white">W</span>800.881.7130<span style="color:white">W</span>|<span style="color:white">W</span>Fax 720.279.8321<span style="color:white">W</span>|<span style="color:white">W</span>www.fitnessinsurance.com<cfoutput><br /><span style="font-size:xx-small; font-style:italic;">Doing Business As Fitness Insurance Agency in MI, TX, NC, NY, and CA. CA License Number 0G00756</span><br />Page #cfdocument.currentpagenumber#<span style="color:white">WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW</span> #dateFormat(now(),"mm/dd/yyyy")#</cfoutput></p>
        </cfdocumentitem>          
        </cfdocument>                
       <cfpdf action="addHeader" source="#path#\reports\#filename#" image="#path#\images\Fitness-Insurance-logo-long.gif"  topMargin="1" leftMargin="0" rightMargin="0" showonprint="yes" opacity="10" />
       
     <cfset message = filename>
            
        <cfcatch type="any">
        <cfset message = "#cfcatch.Message# = #cfcatch.Detail#">
        </cfcatch>
        
        </cftry>
        <cfset result = message>
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	        	
	</cffunction>    

	<cffunction name="clearPrintQueue" access="public">
		<cfargument name="rc" type="any">
		<cfset history = reportGW.clearPrintQueue()>
		<cfset rc.response = JSON.encode(history)>
        <cfset fw.setView('common.ajax')>
	</cffunction>                 
</cfcomponent>