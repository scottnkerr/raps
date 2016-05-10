
<cfcomponent name="pushapp" output="false">
    
	<cffunction name="init" output="false">
		<cfargument name="fw">
		<cfset variables.fw = arguments.fw> 
		<!--- Set up the gateway to the model.component to make it available to all functions in the controller --->
		<cfset mainGW = createObject('component','app.model.main').init()>
		<cfset appGW = createObject('component','app.model.app').init()>
        <cfset pushappGW = createObject('component','app.model.pushapp').init()>
		<cfset JSON = createObject('component','app.model.services.json').init() />
	</cffunction>
	<cffunction name="default" access="public">
		<cfargument name="rc" type="any">
		<!--- Decrypt so we know form is coming from right place--->
        <cfset TheKey = 'The Dude Abides'>
        <cfset DecryptedPassword = Decrypt(ToString(ToBinary(rc.catch)), TheKey)>
    	<cfif DecryptedPassword is 'jellybean$1023'>
        <cfset rc.response = pushappGW.saveWebApp(FORM=rc)>
        <cfif rc.response.success is true>
            <cfmail from="noreply@fitnessinsurance.com" subject="Quote Request from FitnessInsurance.com" type="html" to="requests@fitnessinsurance.com" bcc="scott.n.kerr@gmail.com">
            <table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;">
			<tr>
            <td style="font-weight:bold;">Contact Information</td>
            <td>&nbsp;</td>
            </tr>
            <tr>
            <td>Name:</td>
            <td>#name#</td>
            </tr>
            <tr>
            <td>Title:</td>
            <td>#title#</td>
            </tr>
            <tr>
            <td>Phone:</td>
            <td>#phone#</td>
            </tr>
            <tr>
            <td>Cell:</td>
            <td>#cell#</td>
            </tr>
            <tr>
            <td>Fax:</td>
            <td>#fax#</td>
            </tr>
            <tr>
            <td>Email:</td>
            <td>#email#</td>
            </tr>
            <tr>
            <td colspan="2">&nbsp;</td>
            </tr>
            <tr>
            <td style="font-weight:bold;">Club Information:</td>
            <td>&nbsp;</td>
            </tr>
            <tr>
            <td>Effective Date:</td>
            <td>#eff_date#</td>
            </tr>
            <tr>
            <td>Current Insurance Carrier:</td>
            <td>#curr_ins_carr#</td>
            </tr>
            <tr>
            <td>Named Insured:</td>
            <td>#named_insrd#</td>
            </tr>
            <tr>
            <td>DBA:</td>
            <td>#dba#</td>
            </tr>
            <tr>
            <td>Location Address:</td>
            <td>#loc_addr#</td>
            </tr>
            <tr>
            <td>Address 2:</td>
            <td>#loc_addr2#</td>
            </tr>
            <tr>
            <td>City, State, Zip:</td>
            <td>#loc_city#, #loc_state#, #loc_zip#</td>
            </tr>
            <tr>
            <td>Website:</td>
            <td>#website#</td>
            </tr>
            <tr>
            <td>Year Business Started:</td>
            <td>#year_started#</td>
            </tr>
            <tr>
            <td>## of Years Experience:</td>
            <td>#yrs_in_bus#</td>
            </tr>
            <tr>
            <td>Square Footage:</td>
            <td>#club_sq_ft#</td>
            </tr>
            <tr>
            <td>Gross Receipts:</td>
            <td>#annual_gross#</td>
            </tr>
            <tr>
            <td>## of Members:</td>
            <td>#nbr_mbrs#</td>
            </tr>
            <tr>
            <td>## FT Employees:</td>
            <td>#fulltime#</td>
            </tr>
            <tr>
            <td>## PT Employees:</td>
            <td>#parttime#</td>
            </tr>
            <tr>
            <td>Club Hours:</td>
            <td>#hrs_of_oper#</td>
            </tr>
            <tr>
            <td>24-Hour Key Club:</td>
            <td>#key_club#</td>
            </tr>
            </table>
            <!--- encrypt new id --->
			<cfset Secret = rc.response.data>
            <cfset TheKey = 'The Dude Abides'>
            <cfset Encrypted = Encrypt(Secret, TheKey)>
            <cfset Secret64 = ToBase64(Encrypted)>            
            
           <!--- <p><a href="http://raps.someotherway.com?event=pushapp.confirm&ID=#Secret64#">Push Application to RAPS</a></p>--->
            </cfmail> 
        <cfelse>  
        <!---if there was a problem inserting record email scott  --->
            <cfmail from="webmaster@fitnessinsurance.com" to="skerr@greystonetech.com" subject="Fitness Web App Issue">
            <cfoutput>#rc.response.data#</cfoutput>
            </cfmail>            
        </cfif>
        
        <cflocation url="http://fitnessinsurance.com/quote/index.cfm?status=1" addtoken="no">
		<!--- if passed secret not right --->
        <cfelse>
        <cflocation url="http://fitnessinsurance.com/quote/index.cfm?status=2" addtoken="no">
        </cfif>        
	</cffunction>
  <cffunction name="testMail" access="public" output="yes">
  <cfargument name="rc" type="any">
  <cfif isDefined("FORM.emailSub")>
  <cfmail from="#FORM.fromEmail#" to="#FORM.toEmail#" subject="#FORM.emailSubject#">
  #FORM.emailBody#
  </cfmail>
  Email Sent.
  </cfif>


  </cffunction>
	<cffunction name="confirm" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.ID" default="0">
        <cfparam name="rc.checkpreviouspush" default="0">
        <cfif rc.ID neq 0>
        <!--- Decrypt so we know form is coming from right place--->
        <cfset TheKey = 'The Dude Abides'>
            <cftry>
            <cfset rc.DecryptedID = Decrypt(ToString(ToBinary(rc.ID)), TheKey)>
            <!--- Make sure this web app hasn't already been pushed --->
            <cfset rc.checkpreviouspush = pushappGW.checkPush(ID=rc.DecryptedID)>
            <cfcatch>
                <cfmail from="webmaster@fitnessinsurance.com" to="skerr@greystonetech.com" subject="Fitness Web App Push Issue">
                <cfoutput>#cfcatch.Message# - #cfcatch.Detail#</cfoutput>
                </cfmail> 
                <cfset rc.DecryptedID = 0>         
            </cfcatch>
            </cftry>
        <cfelse>
        <cfset rc.DecryptedID = 0>
        </cfif>
    </cffunction>
	<cffunction name="push" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.ID" default="0">
        <!--- Make sure this web app hasn't already been pushed --->
        <cfset rc.checkpreviouspush = pushappGW.checkPush(ID=rc.ID)>
        
        <!--- 
		Call to function that retrieves web app 
		and creates a new RAPS client, location, and application
		goes here
		--->
        
        <cfif rc.ID neq 0 AND rc.checkpreviouspush neq 1>
		<cfset result = "Application successfully pushed." />
        <cfelseif rc.ID neq 0 AND rc.checkpreviouspush eq 1>
        <cfset result = "This application has already been pushed." />
        <cfelseif rc.ID eq 0>
        <cfset result = "Application does not exist." />
        <cfelse>
        <cfset result = "Something else went wrong." />
        </cfif>
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction>                       
</cfcomponent>