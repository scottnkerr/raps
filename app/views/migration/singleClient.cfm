<style>
table.gym td {
	border:1px solid black;
	padding:5px;

}
</style>
<cfoutput>
<!---<cfdump var="#rc.gymClients#">--->
<form action="/index.cfm?event=migration.singleClient" method="post">
Select Client:<br><BR>
<select name="clientid" id="clientid">
<cfloop query="rc.gymClients">
<option value="#rc.gymClients.clientid#" <cfif isDefined("FORM.clientid") AND FORM.clientid eq rc.gymClients.clientid> selected</cfif>><cfif len(rc.gymClients["AG2 REC"][currentrow])>#rc.gymClients["AG2 REC"][currentrow]# - </cfif>#rc.gymClients["TAM CLIENT##"][currentrow]# - #rc.gymClients["INSD NAME"][currentrow]#</option>
</cfloop>
</select>
<br><br>
<input type="submit" name="formSub" id="formSub" value="PREP CLIENT FOR MIGRATION">
</form>

<cfif isDefined("FORM.formSub")>
<br><br>
  <cfif rc.checkDup.recordcount>
  A record already exists in Raps for this account.<br><br>
  <cfdump var="#rc.checkdup#">

  </cfif>
  <br><br>
  GYM record:<br><br>
  <table class="gym">
  <tr>
  <td>CLIENTID</td>
  <td>AMS</td>
  <td>CLIENT CODE</td>
  <td>NAME</td>
  </tr>
  <tr>
  <td>#rc.thisGymClient["CLIENTID"][1]#</td>
  <td>#rc.thisGymClient["AG2 REC"][1]#</td>
  <td>#rc.thisGymClient["TAM CLIENT##"][1]#</td>
  <td>#rc.thisGymClient["INSD NAME"][1]#</td>
  </tr>
  </table>
  <br><br>  
<cfset eventList = "clientUpdate,locationUpdate,applicationUpdate,ratingUpdate,ratingGLUpdate,ratingPropUpdate,applicationHisUpdate,ratingHisUpdate,ratingHisGLUpdate,ratingHisPropUpdate,policyUpdate,otherLOCUpdate,contactUpdate">
<cfloop from="1" to="#listlen(eventList)#" index="i">
<a href="/index.cfm?event=migration.#listgetat(eventList,i)#&clientid=#form.clientid#" target="_blank">/index.cfm?event=migration.#listgetat(eventList,i)#&amp;clientid=#form.clientid#</a><br><br>
</cfloop>
</cfif>

</cfoutput>