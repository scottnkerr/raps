<cfcomponent>
	<cfset variables.fw = '' />
	<cffunction name="init" access="public" returntype="void">
		<cfargument name="fw" type="any" required="yes" />
		<cfset variables.fw = arguments.fw />
		<!--- Set up the gateway to the model.component to make it available to all functions in the controller --->
		<cfset loginGW = createObject('component','app.model.login').init()>        
	</cffunction>

	<cffunction name="before" access="public" output="no" returntype="void">
		<cfargument name="rc" type="struct" required="yes" />
		<cfif session.auth.isLoggedIn and variables.fw.getItem() is not 'logout'>
			<cfset variables.fw.redirect('main.search') />
		</cfif>
	</cffunction>

	
	<cffunction name="login" access="public" returntype="void">
		<cfargument name="rc" type="struct" required="yes" />

		<cfset var validUser = 0 />
		<!--- <cfset var userValid = 0 />
		<cfset var userService = getUserService() />
		<cfset var user = '' />
 			--->
		<!--- if the form variables do not exist, redirect to the login form --->
		<cfif not structkeyexists(rc,'username') or not structkeyexists(rc,'password')>

			<cfset variables.fw.redirect('login') />
		<cfelse>
    		<cfif len(username) and len(password)>
        <cfset getUser = loginGW.checkUser(rc.username,rc.password)>
        <cfif getUser.recordcount>
					<cfset validUser = 1>
        </cfif>
				</cfif>
		</cfif>
		<!--- if the login credentials failed the test, set a message and redirect to the login form --->
		<cfif not validUser>
			<cfset rc.message = 'Please try again' />
			<cfset variables.fw.redirect('login','message') />
		</cfif>

		<!--- since the user is valid, set session variables --->
		<cfset session.auth.isLoggedIn = true />
		<cfset session.auth.name = getUser.user_firstname />
        <cfset session.auth.fullname = "#getUser.user_firstname# #getUser.user_lastname#" />
        <cfset session.auth.id = getUser.user_id />
		<cfset session.auth.role = getUser.user_role_id />
        <cfset session.auth.username = getUser.user_name />
        <cfset session.auth.sig = getUser.user_sig />

		<cfset variables.fw.redirect('main.search') />
	</cffunction>

	<cffunction name="logout" access="public" returntype="void">
		<cfargument name="rc" type="struct" required="yes" />
		<!--- reset the session variables --->
		<cfset structdelete(session.auth,'name') />
        <cfset structdelete(session.auth,'id') />
        <cfset structdelete(session.auth,'role') />
        <cfset session.auth.isLoggedIn = false />
        <cfset session.auth.fullname = 'guest' />
		<cfset rc.message = "You've logged out" />
		<cfset variables.fw.redirect('login','message') />
	</cffunction>
<!---	<cffunction name="encryptAll" access="public" returntype="void">
		<cfargument name="rc" type="struct" required="yes" />
		<cfquery name="data">
    SELECT user_id, user_pass FROM Users
    </cfquery>
<!---    <cfloop query="data">
    <cfset encrypted = loginGW.encryptPassword(data.user_pass)>
    <cfquery>
    update users
    set user_pass = '#encrypted#'
    where user_id = #data.user_id#
    </cfquery>
    </cfloop>--->
    <cfdump var="#data#">
    <cfset fw.setView('login.default')>
	</cffunction>
  <cffunction name="resetPass" output="yes">
  <cfquery name="data">
  SELECT user_id, user_firstname, user_lastname, user_pass, user_name
  from users
  where user_id = 32
  </cfquery>
  <cfdump var="#data#">
  <cfset encrypted = loginGW.encryptPassword('sc0tty3ll0w')>
  <cfset decrypted = loginGW.decryptPassword(data.user_pass)>
  encrypted = #encrypted#<br>
  decrypted = #decrypted#<br>
  <cfquery>
  update users
  set user_pass = '#encrypted#'
  where user_id = 32
  </cfquery>
  <cfset fw.setView('login.default')>
  </cffunction>
  --->

</cfcomponent>