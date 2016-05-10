<cfparam name="reportLayout" default="main">
<cfif reportLayout eq 'main'>
<cfinclude template="/app/views/common/header.cfm">
<cfelse>
<cfinclude template="/app/views/common/headerBlank.cfm">
</cfif>

<cfoutput>#body#</cfoutput>

<cfinclude template="/app/views/common/footer.cfm">