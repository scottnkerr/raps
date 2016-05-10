<cfif isDefined("rc.result")><cfdump var="#rc.result#"></cfif>
<style>
p {
	padding:10px;
}
</style>
<cfif not isDefined("rc.clientid")>
<p><a href="/index.cfm?event=migration.clientUpdate">Migrate Clients</a></p>
<p><a href="/index.cfm?event=migration.locationUpdate">Migrate Locations</a></p>
<p><a href="/index.cfm?event=migration.applicationUpdate">Migrate Applications</a></p>
<p><a href="/index.cfm?event=migration.ratingUpdate">Migrate Ratings</a></p>
<p><a href="/index.cfm?event=migration.ratingGLUpdate">Migrate GL Ratings</a></p>
<p><a href="/index.cfm?event=migration.ratingPropUpdate">Migrate Property Ratings</a></p>
<p><a href="/index.cfm?event=migration.applicationHisUpdate">Migrate Application History</a></p>
<p><a href="/index.cfm?event=migration.ratingHisUpdate">Migrate Rating History</a></p>
<p><a href="/index.cfm?event=migration.ratingHisGLUpdate">Migrate GL Rating History</a></p>
<p><a href="/index.cfm?event=migration.ratingHisPropUpdate">Migrate Property Rating History</a></p>
<p><a href="/index.cfm?event=migration.policyUpdate">Migrate Policies</a></p>
<p><a href="/index.cfm?event=migration.otherLocUpdate">Migrate Other Lines of Coverage</a></p>
<p><a href="/index.cfm?event=migration.contactUpdate">Migrate Contacts</a></p>
</cfif>
