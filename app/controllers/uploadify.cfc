<cfcomponent>
<cffunction name="uploadimage" access="remote" returntype="any" returnformat="plain">
<cfset path = expandpath('../../')>
<cffile action="upload" filefield="form.fileData" destination="#path#proposals\uploads" nameconflict="makeunique" />
<cfset filename='#CFFile.ServerFile#'> 
<cfreturn filename />
</cffunction>
<cffunction name="uploadsig" access="remote" returntype="any" returnformat="plain">
<cfset path = expandpath('../../')>
<cffile action="upload" filefield="form.fileData" destination="#path#sigs" nameconflict="makeunique" />
<cfset filename='#CFFile.ServerFile#'> 
<cfreturn filename />
</cffunction>
</cfcomponent>