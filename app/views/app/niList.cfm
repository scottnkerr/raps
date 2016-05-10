
<cfoutput>
<h2 style="padding-left:10px;">CLIENT: #rc.client.entity_name#</h2>
<ol style="margin:20px 0;">
<cfloop query="rc.ni">
<li>#named_insured#</li>
</cfloop>
</ol>
</cfoutput>
