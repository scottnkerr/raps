<cfcomponent output="false">
	<cffunction name="init" returntype="any" output="false">
		<cfreturn this />
	</cffunction>
	<cffunction name="checkUser" returntype="query" output="true">
    <cfargument name="user_name" type="string" required="yes">
    <cfargument name="user_pass" type="string" required="yes">
    
    <cfset encrypted = encryptPassword(ARGUMENTS.user_pass)>
		<cfquery name="getUser" datasource="raps">
		SELECT *
        FROM users
        WHERE user_name = '#ARGUMENTS.user_name#'
        AND user_pass = '#encrypted#'
        AND (disabled = 0 OR disabled is null)
		</cfquery>
    <cfdump var="#encrypted#">
		<cfreturn getUser />
	</cffunction>
  <cffunction name="encryptPassword" returntype="string" output="yes">
    <cfargument name="user_pass" type="string" required="yes">
      <cfset TheKey = 'The Dude Abides'>
      <cfset Encrypted = Encrypt(ARGUMENTS.user_pass, TheKey)> 
      <cfreturn Encrypted />
  </cffunction>  
  <cffunction name="decryptPassword" returntype="string" output="yes">
    <cfargument name="user_pass" type="string" required="yes">
      <cfset TheKey = 'The Dude Abides'>
      <cfset Decrypted = Decrypt(ARGUMENTS.user_pass, TheKey)> 
      <cfreturn Decrypted />
  </cffunction>  
</cfcomponent>