
<cfcomponent name="main" output="false">

	<cffunction name="init" output="false">
		<cfargument name="fw">
		<cfset variables.fw = arguments.fw> 
		<!--- Set up the gateway to the model.component to make it available to all functions in the controller --->
		<cfset mainGW = createObject('component','app.model.main').init()>
		<cfset JSON = createObject('component','app.model.services.json').init() />
		<cfset appGW = createObject('component','app.model.app').init()>
    <cfset loginGW = createObject('component','app.model.login').init()>    
	</cffunction>
	<cffunction name="after" access="public" output="no" returntype="void">
		<cfargument name="rc" type="struct" required="yes" />
		<cfset rc.docs = mainGW.getdocs(0)>
	</cffunction>  
	<cffunction
    name="returnNull"
    access="public"
    returntype="void"
    output="false"
    hint="I simply return void / null.">

    <cfreturn />
    </cffunction>  
	<cffunction name="default" access="public">
		<cfargument name="rc" type="any">
		<cfset variables.fw.redirect('main.search') />
	</cffunction>
    <cffunction name="checkSecurity" access="public">
    <cfif SESSION.auth.role is 1>
    <cfreturn true>
    <cfelse>
    <cfset variables.fw.redirect('main.securityError')>
    </cfif>
    </cffunction>
  
	<cffunction name="search" access="public">
		<cfargument name="rc" type="any">
        <cfset rc.userSearchOptions = mainGW.getUserSearchOptions()>
        <cfset rc.title = "Client Search">
	</cffunction>
	<cffunction name="proposalChecklist" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.client_id" default="0">
        
        <cfset rc.client = mainGW.getClient(client_id=rc.client_id)>
        <cfset rc.title = "Printing and Proposals - #rc.client.entity_name#">
        <cfset rc.contacts = mainGW.getClientContacts(client_id=rc.client_id)>
        <cfset rc.date = dateFormat(now(),'mm/dd/yyyy')>
        <!--- replace this with amount from rating 
        <cfset rc.terrorism_premium = "$238.00">--->
        <cfset rc.proposaldocs = mainGW.getProposalDocs(0,0)>
        <cfset rc.sigimage = '<img src="http://#cgi.SERVER_NAME#/sigs/#session.auth.sig#" width="200">'>
        <cfset path = expandpath('.')>
        <cfset fullpath = "#path#\proposals\previews">
 
	</cffunction>
	<cffunction name="proposalAdmin" access="public">
		<cfargument name="rc" type="any">
        <cfset rc.title = "Proposal Admin">
        <cfset checkSec = checkSecurity()>
        
	</cffunction> 
	<cffunction name="proposalAdminOrder" access="public">
		<cfargument name="rc" type="any">
        <cfset checkSec = checkSecurity()>
        <cfset rc.proposaldocs = mainGW.getProposalDocs(0,0)>
        <cfset rc.title = "Proposal Order">
	</cffunction>      
         
	<cffunction name="proposalCreate" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.sort_serialized" default="">
		<cfset IDList = ReReplaceNoCase(rc.sort_serialized, "(&){0,1}section_id\[\]=", ",", "all") />
	</cffunction>  
	<cffunction name="proposalCreate2" access="public" output="yes">
    
		<cfargument name="rc" type="any">
        <cfparam name="rc.thisid" default="0">
        <cfparam name="rc.thisname" default="">
        <cfparam name="rc.thiscontent" default="">
        <cfparam name="rc.thisinclude" default="">
        <cfparam name="rc.thisfile" default="">	
        <cfparam name="rc.directoryname" default="">
        <cfparam name="rc.pagenumber" default="1">
        <cfparam name="rc.lastone" default="false">
        <cfparam name="rc.includeheader" default="1">
        <cfparam name="rc.includefooter" default="1">
        <cfparam name="rc.client_id" default="0">
        <cfparam name="rc.onlyquote" default="0">
        <cfparam name="rc.preview" default="0">
		<cfparam name="rc.header_image_override" default="">
		<cfparam name="rc.gray_footer" default="0">

				<cfset prefixLen = 3>
        <cfset pageLen = len(rc.pagenumber)>
        
        <cfset lead = prefixlen - pageLen>
        <cfset prefix = "">
        <cfloop from="1" to="#lead#" index="i">
        <cfset prefix = prefix & "0">
        </cfloop>
        <cfset prefix = prefix & rc.pagenumber>
        <cfset docid = replacenocase(rc.thisid,'section_id_','','ALL')>
        
        <cfset client = mainGW.getClient(client_id=rc.client_id)>
        
        <cfset wc = mainGW.getClientWC(rc.client_id)>
        <cfif client.wc_issuing_company neq 0 and client.wc_issuing_company neq ''>
        <cfset wcissuing = mainGW.getIssuingCompanies(client.wc_issuing_company)>
        <cfelse>
        <cfset wcissuing.name = ''>
        </cfif>
        <cfif client.ue_issuing_company neq 0 and client.ue_issuing_company neq ''>
        <cfset ueissuing = mainGW.getIssuingCompanies(client.ue_issuing_company)>
        <cfelse>
        <cfset ueissuing.name = ''>
        </cfif>        
        <cfif client.epli_issuing_company neq 0 and client.epli_issuing_company neq ''>
        <cfset epliissuing = mainGW.getIssuingCompanies(client.epli_issuing_company)>
        <cfelse>
        <cfset epliissuing.name = ''>
        </cfif>        
        <cfset contacts = mainGW.getClientContacts(rc.client_id)>
        <cfset wcconsolidated = mainGW.getWCConsolidated(rc.client_id)>
        <cfset excessconsolidated = mainGW.getConsolidated(rc.client_id)>
        <cfset epliconsolidated = mainGW.getEPLIConsolidated(rc.client_id)>
        <cfset othercoverages = mainGW.getClientLOC(client_id=rc.client_id,othertab=1)>
        <cfset other2coverages = mainGW.getClientLOC(client_id=rc.client_id,othertab=2)>
        <cfset other3coverages = mainGW.getClientLOC(client_id=rc.client_id,othertab=3)>
        <cfif client.other_issuing_company neq 0 and client.other_issuing_company neq ''>
        <cfset otherissuing = mainGW.getIssuingCompanies(client.other_issuing_company)>
        <cfelse>
        <cfset otherissuing.name = ''>
        </cfif>   
        <cfif client.other2_issuing_company neq 0 and client.other_issuing_company neq ''>
        <cfset other2issuing = mainGW.getIssuingCompanies(client.other2_issuing_company)>
        <cfelse>
        <cfset other2issuing.name = ''>
        </cfif> 
        <cfif client.other3_issuing_company neq 0 and client.other3_issuing_company neq ''>
        <cfset other3issuing = mainGW.getIssuingCompanies(client.other3_issuing_company)>
        <cfelse>
        <cfset other3issuing.name = ''>
        </cfif>                      
        <cfset ani = mainGW.getNI(rc.client_id,0) />
        <cfset path = expandpath('.')>
        
        <cftry>
        <cfset fullpath = "#path#\proposals\#rc.directoryname#">
		<cfif DirectoryExists(fullpath)>
        <cfset message = "it exists">
        <cfelse>
        <cfdirectory action="create" directory="#fullpath#">
        <cfset message = "directory created">
        </cfif> 
        <cfdirectory action="list" directory="#fullpath#" name="filelist" filter="*.pdf">
        <cfif filelist.recordcount>
        <cfset totalpages = 0>
        <cfloop query="filelist">
        <cfpdf action="getInfo" source="#fullpath#\#filelist.name#" name="PDFInfo">
        <cfset totalpages = PDFInfo.TotalPages + totalpages> 
        </cfloop>  
        <cfset pagenum = totalpages + 1>
        <cfelse>
        <cfset pagenum = 1>
        </cfif>        
		<cfif trim(rc.header_image_override) eq ''>
			<cfset margintop = "1">		
		<cfelse>
			<cfset margintop = "1.25">
		</cfif>				
		<cfif trim(rc.header_image_override) eq ''>
			<cfset marginbottom = ".75">		
		<cfelse>
			<cfset marginbottom = "1">
		</cfif>	 			
        <cfif trim(rc.thisfile) eq '' AND rc.thisinclude neq 'prop_include_quote.cfm'>
					<cfif rc.thisinclude eq 'prop_include_summary.cfm'>
          	<cfset totals = getPropSummaryTotals(rc.client_id,rc.onlyquote)>
          </cfif>
       
        <cfdocument format="pdf" name="proposalpdf" margintop="#margintop#" marginbottom="#marginbottom#" backgroundvisible="yes" localurl="true" filename="#fullpath#\#prefix#-FitnessProposal.pdf" overwrite="yes" fontembed="no">
        <cfoutput>
        <html>
        <body style="position: relative; font-family:Arial, Helvetica, sans-serif;">
        <cfif rc.thisinclude neq '' AND rc.thisinclude neq 'prop_include_quote.cfm'>
        <cfinclude template="/app/views/common/#rc.thisinclude#">
        <cfelse>
        <cfif rc.preview eq 1>
        <cfinclude template="/app/views/common/shortcodes.cfm">
        <cfset content = '<br />' & content>
        <cfelse>
        <cfset content = rc.thiscontent>
        </cfif>
       
       <cfset terrorism_premium = mainGW.getTerrorismPrem(rc.client_id,rc.onlyquote)>
        
        <cfset excess_terrorism_premium = mainGW.getExTerrorismPrem(client.ue_rate_state,client.ue_premium,client.liability_plan_id)>
       
        <cfset pagebreak = '<p style="page-break-after: always !important; padding:0, margin:0; line-height:0; height:0; overflow:hidden;">&nbsp;</p>'>
        #replacenocase(replacenocase(replacenocase(replacenocase(content,"[PAGE_BREAK]", pagebreak, "ALL"),'[RANDY_SIG]','<img src="/images/testsig2.gif" height="75" width="200">','ALL'),'[terrorism_premium]', dollarFormat(terrorism_premium),'ALL'),'[excess_terrorism_premium]', dollarFormat(excess_terrorism_premium),'ALL')# 
        </cfif>        


        </body>
        </html>
        </cfoutput>
        <cfif rc.includefooter is 1> 
		
        <cfdocumentitem type="footer" evalAtPrint="true" grayfooter="#rc.gray_footer#">
        <cfset thispagenum = pagenum + cfdocument.currentpagenumber - 1>
			<cfif val(attributes.grayfooter) eq 1>
			<cfset xtrastyles = "background-color: ##7F7F7F; padding: 20px 10px 10px; color:##ffffff">
			<cfset transtextcolor = '##7F7F7F' >
			<cfelse>
			<cfset xtrastyles = "">	
			<cfset transtextcolor = '##FFFFFF' >
			</cfif>
       <p style="text-align:center; font-family:Arial, Helvetica, sans-serif; font-size:14px; line-height:18px; #xtrastyles#">2170 S. Parker Rd, Suite 251<span style="color:#transtextcolor#">W</span>|<span style="color:#transtextcolor#">W</span>Denver, CO  80231<span style="color:#transtextcolor#">W</span>|<span style="color:#transtextcolor#">W</span>800.881.7130<span style="color:#transtextcolor#">W</span>|<span style="color:#transtextcolor#">W</span>Fax 720.279.8321<span style="color:#transtextcolor#">W</span>|<span style="color:#transtextcolor#">W</span>www.fitnessinsurance.com<cfoutput><br /><span style="font-size:xx-small; font-style:italic;">Doing Business As Fitness Insurance Agency in MI, TX, NC, NY, and CA. CA License Number 0G00756</span><br />Page #thispagenum#<span style="color:#transtextcolor#">WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW</span> #dateFormat(now(),"mm/dd/yyyy")#</cfoutput></p>
        </cfdocumentitem>  
				
        </cfif>      
        </cfdocument> 
        <cfelseif rc.thisinclude is 'prop_include_quote.cfm'>
        <cfset locations = mainGW.getPropLocations(rc.client_id,rc.onlyquote)>
     		

        <cfdocument format="pdf" name="proposalpdf" margintop="1" marginbottom=".75" backgroundvisible="yes" localurl="true" filename="#fullpath#\#prefix#-FitnessProposal.pdf" overwrite="yes" fontembed="no">
        <cfoutput>
        <html>
        <body style="position: relative; font-family:Arial, Helvetica, sans-serif;">
        <cfset totalall = 0>
        <cfset totalglpremium = 0>
        <cfset totalglterrorism = 0>
        <cfset totalglbroker = 0>
        <cfset totalglinspection = 0>
        <cfset totalglsurplus = 0>
        <cfset totalglstamping = 0>
        <cfset totalglfiling = 0>
        <cfset totalglstate = 0>
        <cfset totalglrpg = 0>
        <cfset totalgl = 0>
        <cfset totalproppremium = 0>
        <cfset totalpropterrorism = 0>
        <cfset totalpropagencyfee = 0>
        <cfset totalpropbrokerfee = 0>
        <cfset totalpropempdis = 0>
        <cfset totalproptaxes = 0>
        <cfset totalpropequip = 0>
        <cfset totalprop = 0>
        <cfset newpagenum = pagenum>
		<cfloop query="locations">
       
        <cfset rating = mainGW.getLocationRating(locations.location_id)>
        
        <cfset totalpremium = val(rating.prop_grandtotal) + val(rating.grandtotal) - val(rating.rpgfee)>
        <cfset totalglpremium = val(totalglpremium) + val(rating.pro_rata_gl)>
        <cfset totalall = val(totalall) + val(totalpremium)>
        <cfif rating.terrorism_rejected neq 1>
        <cfset totalglterrorism = val(totalglterrorism) + val(rating.terrorism_fee)>
        </cfif>
        <cfset totalglbroker = val(totalglbroker) + val(rating.brokerfee)>
        <cfset totalglinspection = val(totalglinspection) + val(rating.inspectionfee)>
        <cfset totalglsurplus = val(totalglsurplus) + val(rating.surplustax)>
        <cfset totalglstamping = val(totalglstamping) + val(rating.stampingfee)>
        <cfset totalglfiling = val(totalglfiling) + val(rating.filingfee)>
        <cfset totalglstate = val(totalglstate) + val(rating.statecharge)>
        <cfset totalglrpg= val(totalglrpg) + val(rating.rpgfee)>
        <cfset totalgl = val(totalgl) + val(rating.grandtotal)>
				<cfif rating.prop_use_prorata neq 1>
        <cfset propprem = rating.prop_chargedpremium>
        <cfelse>
        <cfset propprem = rating.prop_proratapremium>
        </cfif>        
        
        <cfset totalproppremium = val(totalproppremium) + val(propprem)>
        <cfif rating.prop_terrorism_rejected neq 1>
        <cfset totalpropterrorism = val(totalpropterrorism) + val(rating.propt)>
        </cfif>        
        <cfset totalpropagencyfee = val(totalpropagencyfee) + val(rating.prop_agencyamount)>
        <cfset totalpropbrokerfee = val(totalpropbrokerfee) + val(rating.prop_brokerfee)>
        <cfset totalpropempdis = val(totalpropempdis) + val(rating.property_emp_amount)>
        <cfset totalproptaxes = val(totalproptaxes) + val(rating.prop_taxes)>
        <cfset totalprop = val(totalprop) + val(rating.prop_grandtotal)>
        <cfset grandtotal = val(totalprop) + val(totalgl)>
        <cfinclude template="/app/views/common/prop_include_quote.cfm">
        <cfdocumentitem type="footer" evalAtPrint="true">
		<cfinclude template="/app/views/common/printfooter.cfm">
       <cfset newpagenum = newpagenum + 1>
        </cfdocumentitem>
        <cfif locations.currentrow lt locations.recordcount>
        <cfdocumentitem type="pagebreak" />
        </cfif>
        <!---
        <cfif locations.currentrow eq locations.recordcount>
        <cfinclude template="/app/views/common/prop_include_summary.cfm">
        </cfif>--->
        
		</cfloop>
        </body>
        </html>
        </cfoutput>
        </cfdocument>        
        
        <cfelse>
        <cffile action = "copy" destination = "#fullpath#\#prefix#-FitnessProposal.pdf" source = "#path#\proposals\uploads\#rc.thisfile#">
        <cfif rc.includefooter is 1> 
        <cfsavecontent variable="footerstuff">
		<table style="background-color:##7F7F7F"><tr><td style="background-color:blue"><span style="font-family:Arial, Helvetica, sans-serif; font-size:xx-small; line-height:1.5em;">2170 S. Parker Rd, Suite 251<span style="color:white">W</span>|<span style="color:white">W</span>Denver, CO  80231<span style="color:white">W</span>|<span style="color:white">W</span>800.881.7130<span style="color:white">W</span>|<span style="color:white">W</span>Fax 720.279.8321<span style="color:white">W</span>|<span style="color:white">W</span>www.fitnessinsurance.com<cfoutput><br /><span style="font-size:xx-small; font-style:italic;"><sup>Doing Business As Fitness Insurance Agency in MI, TX, NC, NY, and CA. CA License Number 0G00756</sup></span><br />Page #pagenum#<span style="color:white">WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW</span> #dateFormat(now(),"mm/dd/yyyy")#</cfoutput></span></td></tr></table>
        </cfsavecontent>
        <cfpdf action="addFooter" source="#fullpath#\#prefix#-FitnessProposal.pdf" text="#footerstuff#" showonprint="yes" opacity="10" bottomMargin=".75" />
        </cfif>
        
        
        </cfif>
       <cfif rc.includeheader is 1>
       <cfif trim(rc.header_image_override) neq ''>
       <cfset headerimage = "#path#\images\#rc.header_image_override#">
       <cfelse>
       <cfset headerimage = "#path#\images\Fitness-Insurance-logo-long.gif">
       </cfif>
       <cfpdf action="addHeader" source="#fullpath#\#prefix#-FitnessProposal.pdf" image="#headerimage#"  topMargin="#margintop#" leftMargin="0" rightMargin="0" showonprint="yes" opacity="10" />
       </cfif>
       <cfif rc.includefooter is 1>  

      </cfif>
       <cfif rc.lastone is true>

       <cfpdf action="merge" directory="#fullpath#" name="proposalpdf" overwrite="yes" ascending="yes" />

      <cfset filename = "Fitness Proposal-#listgetat(SESSION.auth.username,1,'@')#-#dateFormat(now(),'mm-dd-yyyy')#-#timeFormat(now(),'HH-mm-ss')#.pdf">
      <cfpdf action="write" source="proposalpdf" destination="#path#\proposals\#filename#" overwrite="yes" saveOption="linear" />
      
       <cfdirectory action="delete" directory="#fullpath#" recurse="yes">
       <cfset message = filename>
       </cfif>             
        <cfcatch type="any">
        <cfset message = "#cfcatch.Message# = #cfcatch.Detail#">
        </cfcatch>
        </cftry>
        <cfset result = message>
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	        	
	</cffunction>            
	<cffunction name="getPropSummaryTotals" returntype="struct">
  <cfargument name="client_id" required="yes">
  <cfargument name="onlyquote" required="yes">
  <cfset locations = mainGW.getPropLocations(arguments.client_id,arguments.onlyquote)>
  <cfset totals = StructNew()>
		<cfset totals.totalall = 0>
    <cfset totals.totalglpremium = 0>
    <cfset totals.totalglterrorism = 0>
    <cfset totals.totalglbroker = 0>
    <cfset totals.totalglinspection = 0>
    <cfset totals.totalglsurplus = 0>
    <cfset totals.totalglstamping = 0>
    <cfset totals.totalglfiling = 0>
    <cfset totals.totalglstate = 0>
    <cfset totals.totalglrpg = 0>
    <cfset totals.totalgl = 0>
    <cfset totals.totalproppremium = 0>
    <cfset totals.totalpropterrorism = 0>
    <cfset totals.totalpropagencyfee = 0>
    <cfset totals.totalpropempdis = 0>
    <cfset totals.totalproptaxes = 0>
    <cfset totals.totalpropequip = 0>
    <cfset totals.totalprop = 0>
  <!---custom tax fields--->
  <cfloop from="1" to="5" index="i">
     <cfset "totals.totalcustomtax_#i#" = 0>
  </cfloop>
		<cfloop query="locations">
       
        <cfset rating = mainGW.getLocationRating(locations.location_id)>
        
        <cfset totalpremium = val(rating.prop_grandtotal) + val(rating.grandtotal) - val(rating.rpgfee)>
    <cfif rating.use_prorata eq 1>
    	<cfset glprem = rating.pro_rata_gl>
			<cfelse>
      <cfset glprem = rating.loc_annual_premium>
      </cfif>        
        <cfset totals.totalglpremium = val(totals.totalglpremium) + val(glprem)>
        <cfset totals.totalall = val(totals.totalall) + val(totalpremium)>
        <cfif rating.terrorism_rejected neq 1>
        <cfset totals.totalglterrorism = val(totals.totalglterrorism) + val(rating.terrorism_fee)>
        </cfif>
        <cfset totals.totalglbroker = val(totals.totalglbroker) + val(rating.brokerfee)>
        <cfset totals.totalglinspection = val(totals.totalglinspection) + val(rating.inspectionfee)>
        <cfset totals.totalglsurplus = val(totals.totalglsurplus) + val(rating.surplustax)>
        <!---custom taxes--->
        <cfloop from="1" to="5" index="i">
        	<cfset thislabel = evaluate("rating.custom_tax_#i#_label")>
          <cfset thisamount = evaluate("rating.custom_tax_#i#")>
          <cfset totalcustomtax = evaluate("totals.totalcustomtax_#i#")>
          <cfif trim(thislabel) neq ''>
        		<cfset "totals.totalcustomtax_#i#" = val(totalcustomtax) + val(thisamount)>
           
          </cfif>
        </cfloop>
        <cfset totals.totalglstamping = val(totals.totalglstamping) + val(rating.stampingfee)>
        <cfset totals.totalglfiling = val(totals.totalglfiling) + val(rating.filingfee)>
        <cfset totals.totalglstate = val(totals.totalglstate) + val(rating.statecharge)>
        <cfset totals.totalglrpg= val(totals.totalglrpg) + val(rating.rpgfee)>
        <cfset totals.totalgl = val(totals.totalgl) + val(rating.grandtotal)>
				<cfif rating.prop_use_prorata neq 1>
        <cfset propprem = rating.prop_chargedpremium>
        <cfelse>
        <cfset propprem = rating.prop_proratapremium>
        </cfif>        
        
        <cfset totals.totalproppremium = val(totals.totalproppremium) + val(propprem)>
        <cfif rating.prop_terrorism_rejected neq 1>
        <cfset totals.totalpropterrorism = val(totals.totalpropterrorism) + val(rating.propt)>
        </cfif>        
        <cfset totals.totalpropagencyfee = val(totals.totalpropagencyfee) + val(rating.prop_agencyamount)>
        <cfset totals.totalpropempdis = val(totals.totalpropempdis) + val(rating.property_emp_amount)>
        <cfset totals.totalproptaxes = val(totals.totalproptaxes) + val(rating.prop_taxes)>
        <cfset totals.totalprop = val(totals.totalprop) + val(rating.prop_grandtotal)>
        <cfset totals.grandtotal = val(totals.totalprop) + val(totals.totalgl)>
        
		</cfloop>    
    <cfreturn totals />
  </cffunction>
	<cffunction name="proposalPreview" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.thisid" default="0">
        <cfparam name="rc.thisname" default="">
        <cfparam name="rc.thiscontent" default="">
        <cfparam name="rc.thisinclude" default="">
        <cfparam name="rc.thisfile" default="">	
        <cfparam name="rc.pagenumber" default="1">
        <cfparam name="pagenum" default="1">
        <cfparam name="rc.lastone" default="false">
        <cfparam name="rc.includeheader" default="1">
        <cfparam name="rc.includefooter" default="1">
        <cfparam name="rc.client_id" default="2">
        <cfparam name="rc.date" default="#dateFormat(now(),'mm/dd/yyyy')#">
        <cfparam name="rc.terrorism_premium" default="$100">
        <cfparam name="message" default="success">
        <cfparam name="rc.onlyquote" default="0">
        <cfset docid = replacenocase(rc.thisid,'section_id_','','ALL')>
        <cfset rc.client = mainGW.getClient(client_id=rc.client_id)>
        <cfset client = mainGW.getClient(client_id=rc.client_id)>
        <cfset wc = mainGW.getClientWC(rc.client_id)>
        <cfset wcissuing = mainGW.getIssuingCompanies(rc.client.wc_issuing_company)>
        <cfset ueissuing = mainGW.getIssuingCompanies(rc.client.ue_issuing_company)>
        <cfset epliissuing = mainGW.getIssuingCompanies(rc.client.epli_issuing_company)>
        <cfset rc.contacts = mainGW.getClientContacts(rc.client_id)>
        <cfset rc.sigimage = '<img src="http://#cgi.SERVER_NAME#/sigs/#session.auth.sig#" width="200">'>

        <cfset path = expandpath('.')>
        <cfset fullpath = "#path#\proposals\previews">
      
        <cftry>
    
        <cfif rc.thisinclude neq 'prop_include_quote.cfm'>
        <cfdocument format="pdf" name="proposalpdf" margintop="1" marginbottom=".75" backgroundvisible="yes" localurl="true" filename="#fullpath#\#rc.thisname#.pdf" overwrite="yes" fontembed="no">
        
        <cfoutput>
        <html>
        <body style="position: relative; font-family:Arial, Helvetica, sans-serif;">
        <cfif rc.thisinclude neq '' AND rc.thisinclude neq 'prop_include_quote.cfm'>
        <cfinclude template="/app/views/common/#rc.thisinclude#">
        <cfelse>
        <!---replace shortcodes with real data--->
        <cfset rc.proposaldocs.proposal_doc_content = rc.thiscontent>
		<cfinclude template="/app/views/common/shortcodes.cfm">
        <cfset pagebreak = '<p style="page-break-after: always !important; padding:0, margin:0; line-height:0; height:0; overflow:hidden;">&nbsp;</p>'>
        #replacenocase(replacenocase(content,"[PAGE_BREAK]", pagebreak, "ALL"),'[RANDY_SIG]','<img src="/images/testsig2.gif" height="75" width="200">','ALL')# 
 
        </cfif>        


        </body>
        </html>
        </cfoutput>
        <cfif rc.includefooter is 1> 
        <cfdocumentitem type="footer" evalAtPrint="true">
       <p style="text-align:center; font-family:Arial, Helvetica, sans-serif; font-size:14px; line-height:18px; background-color:##7F7F7F">2170 S. Parker Rd, Suite 251<span style="color:white">W</span>|<span style="color:white">W</span>Denver, CO  80231<span style="color:white">W</span>|<span style="color:white">W</span>800.881.7130<span style="color:white">W</span>|<span style="color:white">W</span>Fax 720.279.8321<span style="color:white">W</span>|<span style="color:white">W</span>www.fitnessinsurance.com<cfoutput><br /><span style="font-size:xx-small; font-style:italic;">Doing Business As Fitness Insurance Agency in MI, TX, NC, NY, and CA. CA License Number 0G00756</span><br />Page 1<span style="color:white">WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW</span> #dateFormat(now(),"mm/dd/yyyy")#</cfoutput></p>
        </cfdocumentitem>  
        </cfif>      
        </cfdocument> 
        <cfelseif rc.thisinclude is 'prop_include_quote.cfm'>
        <cfset locations = mainGW.getPropLocations(rc.client_id,rc.onlyquote)>
        
        <cfdocument format="pdf" name="proposalpdf" margintop="1" marginbottom=".75" backgroundvisible="yes" localurl="true" filename="#fullpath#\#rc.thisname#.pdf" overwrite="yes" fontembed="no">
        <cfoutput>
        <html>
        <body style="position: relative; font-family:Arial, Helvetica, sans-serif;">
        <cfset totalall = 0>
        <cfset totalglpremium = 0>
        <cfset totalglterrorism = 0>
        <cfset totalglbroker = 0>
        <cfset totalglinspection = 0>
        <cfset totalglsurplus = 0>
        <cfset totalglstamping = 0>
        <cfset totalglfiling = 0>
        <cfset totalglstate = 0>
        <cfset totalgl = 0>
        <cfset totalproppremium = 0>
        <cfset totalpropterrorism = 0>
        <cfset totalpropagencyfee = 0>
        <cfset totalpropempdis = 0>
        <cfset totalproptaxes = 0>
        <cfset totalprop = 0>
        
		<cfloop query="locations">
        
        <cfset rating = mainGW.getLocationRating(locations.location_id)>
        <cfset totalpremium = val(rating.prop_grandtotal) + val(rating.grandtotal)>
        <cfset totalglpremium = val(totalglpremium) + val(rating.pro_rata_gl)>
        <cfset totalall = val(totalall) + val(totalpremium)>
        <cfif rating.terrorism_rejected neq 1>
        <cfset totalglterrorism = val(totalglterrorism) + val(rating.terrorism_fee)>
        </cfif>
        <cfset totalglbroker = val(totalglbroker) + val(rating.brokerfee)>
        <cfset totalglinspection = val(totalglinspection) + val(rating.inspectionfee)>
        <cfset totalglsurplus = val(totalglsurplus) + val(rating.surplustax)>
        <cfset totalglstamping = val(totalglstamping) + val(rating.stampingfee)>
        <cfset totalglfiling = val(totalglfiling) + val(rating.filingfee)>
        <cfset totalglstate = val(totalglstate) + val(rating.statecharge)>
        <cfset totalgl = val(totalgl) + val(rating.grandtotal)>
				<cfif rating.prop_use_prorata neq 1>
        <cfset propprem = rating.prop_chargedpremium>
        <cfelse>
        <cfset propprem = rating.prop_proratapremium>
        </cfif>        
        
        <cfset totalproppremium = val(totalproppremium) + val(propprem)>
        <cfif rating.prop_terrorism_rejected neq 1>
        <cfset totalpropterrorism = val(totalpropterrorism) + val(rating.prop_terrorism)>
        </cfif>        
        <cfset totalpropagencyfee = val(totalpropagencyfee) + val(rating.prop_agencyamount)>
        <cfset totalpropempdis = val(totalpropempdis) + val(rating.property_emp_amount)>
        <cfset totalproptaxes = val(totalproptaxes) + val(rating.prop_taxes)>
        <cfset totalprop = val(totalprop) + val(rating.prop_grandtotal)>
        <cfset grandtotal = val(totalprop) + val(totalgl)>
        <cfinclude template="/app/views/common/prop_include_quote.cfm">
        <cfdocumentitem type="footer" evalAtPrint="true">
		<cfinclude template="/app/views/common/printfooter.cfm">
       
        </cfdocumentitem>
        <cfdocumentitem type="pagebreak" />
        
        <cfif locations.currentrow eq locations.recordcount>
        <cfinclude template="/app/views/common/prop_include_summary.cfm">
        </cfif>
        
		</cfloop>
        </body>
        </html>
        </cfoutput>
        </cfdocument>        
        
        <cfelse>
        <!---
        <cffile action = "move" destination = "#fullpath#\#rc.pagenumber#-FitnessProposal.pdf" source = "#path#\proposals\uploads\#rc.thisfile#">
        --->
        </cfif>
       <cfif rc.includeheader is 1>
       <cfif docid neq 6>
       <cfset headerimage = "#path#\images\Fitness-Insurance-logo-long.gif">
       <cfelse>
       <cfset headerimage = "#path#\images\ACH-Header.gif">
       </cfif>
       <cfpdf action="addHeader" source="#fullpath#\#rc.thisname#.pdf" image="#headerimage#"  topMargin="1" leftMargin="0" rightMargin="0" showonprint="yes" opacity="10" />
       </cfif>


        <cfcatch type="any">
        <cfset message = "#cfcatch.Message# = #cfcatch.Detail#">
        </cfcatch>
        </cftry>
        <cfset result = message>
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	        	
	</cffunction>                
	<cffunction name="client" access="public">
		<cfargument name="rc" type="any">
		<cfset rc.types = mainGW.getTypes() />
		<cfset rc.affiliations = mainGW.getAffiliations() />
		<cfset rc.states = mainGW.getStates() />
        <cfset rc.getclients = mainGW.getClients()>
        <cfset rc.issuing = mainGW.getCompanyAccordion(disabled="active")>
        <cfset rc.policytypes = mainGW.getPolicyTypes()>
        <cfset rc.nirelationships = mainGW.getNIRelationships()>
        <cfset rc.policystatus = mainGW.getPolicyStatus()>
        <cfset rc.users = mainGW.getUsersSimple(user_id=0,excldisabled=1) />
        <cfset rc.loc = mainGW.getOtherLoc()>
        <cfset rc.title = "New Client">
		<cfif structkeyexists(rc,"client_id")>
			<cfset rc.client = mainGW.getClient(client_id=rc.client_id)>
			<cfset rc.contacts = mainGW.getClientContacts(client_id=rc.client_id)>
      <cfset rc.locations = mainGW.getLocations(rc.client_id)>
      <cfset rc.glplans = mainGW.getClientGLPlans(0,rc.client_id,0)>
      <!---<cfdump var="#rc.locations#">--->
            <cfset rc.xrefs = mainGW.getXrefs(rc.client_id,rc.client.x_reference)>
			<cfset rc.lstatus = mainGW.getLocationStatus()>
            <cfset rc.title = "Client - #rc.client.entity_name#">
		</cfif>

	</cffunction>
  <cffunction name="saveAllLocHistory" output="yes">
  <cfargument name="rc" type="any">
  <cfparam name="rc.client_id" default="0">
  <cfparam name="result" default="success">
  <cfset rc.locations = mainGW.getLocations(rc.client_id)>
  <cfloop query="rc.locations">
  <cfif rc.locations.LOCATION_STATUS_ID eq 1>
  <cfset saveHistory = appGW.cloneapp(application_id=rc.locations.application_id)>
  </cfif>
  </cfloop>
        <cfset rc.response = JSON.encode(result)>
        <cfset fw.setView('common.ajax')>
  </cffunction>
	<cffunction name="liabilityPlans" access="public">
		<cfargument name="rc" type="any">
		<cfset checkSec = checkSecurity()>
        <cfset rc.plans = mainGW.getGLPlans(0,"ALL")>
        <cfset rc.conglom = mainGW.getConglom(0,0)>
        <cfset rc.title = "Liability Plan Admin">
	</cffunction> 
	<cffunction name="propertyPlans" access="public">
		<cfargument name="rc" type="any">
        <cfset checkSec = checkSecurity()>
        <cfset rc.cyber = mainGW.getCyberLiability(0,0)>
        <cfset rc.empdishonesty = mainGW.getEmployeeDishonesty(0,0)>
        <cfset rc.title = "Property Plan Admin">
	</cffunction>   
	<cffunction name="stateTaxes" access="public">
		<cfargument name="rc" type="any">
        <cfset checkSec = checkSecurity()>
        <cfset rc.title = "State Taxes Admin">
	</cffunction>
	<cffunction name="issuingCompanies" access="public">
		<cfargument name="rc" type="any">
        <cfset checkSec = checkSecurity()>
        <cfset rc.title = "Issuing Company Admin">
	</cffunction> 
	<cffunction name="cyberLiability" access="public">
		<cfargument name="rc" type="any">
        <cfset checkSec = checkSecurity()>
        <cfset rc.title = "Cyber Liability Admin">
	</cffunction>     
	<cffunction name="employeeDishonesty" access="public">
		<cfargument name="rc" type="any">
        <cfset checkSec = checkSecurity()>
        <cfset rc.title = "Employee Dishonesty Admin">
	</cffunction>      
	<cffunction name="glCredits" access="public">
		<cfargument name="rc" type="any">
        <cfset checkSec = checkSecurity()>
        <cfset rc.title = "GL Credits Admin">
	</cffunction>       
	<cffunction name="documentAdmin" access="public">
		<cfargument name="rc" type="any">
        <cfset rc.title = "Document Admin">
		<cfset checkSec = checkSecurity()>
        <cfset message = "">
        
        <cfset UploadPath = ExpandPath( "./docs/" ) />
        <cfif isDefined("rc.document_id")>
        <cfparam name="rc.upload" default="">
        <cfparam name="path" default="">
        <cfparam name="rc.delete" default="false">
        <cfif rc.upload neq ''>
            <cffile action="UPLOAD" filefield="upload" destination="#UploadPath#" nameconflict="MAKEUNIQUE">
            <cfset path='#File.ServerFile#'>  
        </cfif>    
        <cfset rc.result = mainGW.saveDoc(rc.document_id,rc.document_name,path,rc.delete)>  
        <cfset message = "Changes Saved">              
        </cfif>
        
	</cffunction>  
	<cffunction name="conglomCodes" access="public">
		<cfargument name="rc" type="any">
        <cfset rc.title = "Conglom Code Admin">
		<cfset checkSec = checkSecurity()>
	</cffunction> 
	<cffunction name="clientTypes" access="public">
		<cfargument name="rc" type="any">
        <cfset rc.title = "Entity Types Admin">
		<cfset checkSec = checkSecurity()> 
	</cffunction>  
	<cffunction name="requestedLimits" access="public">
		<cfargument name="rc" type="any">
        <cfset rc.title = "Entity Types Admin">
		<cfset checkSec = checkSecurity()>
	</cffunction> 
	<cffunction name="additionalLimits" access="public">
		<cfargument name="rc" type="any">
        <cfset rc.title = "Additional Limits Admin">
		<cfset checkSec = checkSecurity()>
	</cffunction>         
	<cffunction name="employeeBenefits" access="public">
		<cfargument name="rc" type="any">
        <cfset rc.title = "Employee Benefits Admin">
		<cfset checkSec = checkSecurity()> 
	</cffunction>   
	<cffunction name="clubLocated" access="public">
		<cfargument name="rc" type="any">
        <cfset rc.title = "Club Locations Admin">
		<cfset checkSec = checkSecurity()> 
	</cffunction>    
	<cffunction name="constructionTypes" access="public">
		<cfargument name="rc" type="any">
        <cfset rc.title = "Construction Types Admin">
		<cfset checkSec = checkSecurity()> 
	</cffunction> 
	<cffunction name="roofTypes" access="public">
		<cfargument name="rc" type="any">
        <cfset rc.title = "Roof Types Admin">
		<cfset checkSec = checkSecurity()>
	</cffunction>   
	<cffunction name="policyTypes" access="public">
		<cfargument name="rc" type="any">
        <cfset rc.title = "Policy Types Admin">
		<cfset checkSec = checkSecurity()>
	</cffunction>     
	<cffunction name="policyStatus" access="public">
		<cfargument name="rc" type="any">
        <cfset rc.title = "Policy Status Admin">
		<cfset checkSec = checkSecurity()>
	</cffunction>   
	<cffunction name="terminationReasons" access="public">
		<cfargument name="rc" type="any">
        <cfset rc.title = "Termination Reasons Admin">
		<cfset checkSec = checkSecurity()>
	</cffunction> 
	<cffunction name="niRelationships" access="public">
		<cfargument name="rc" type="any">
        <cfset rc.title = "NI Relationships Admin">
		<cfset checkSec = checkSecurity()>
	</cffunction>        
	<cffunction name="epli" access="public">
		<cfargument name="rc" type="any">
        <cfset rc.title = "EPLI Admin">
		<cfset checkSec = checkSecurity()>
	</cffunction>                      
	<cffunction name="getConglom" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.affiliation_id" default="0">
		<cfset conglom = mainGW.getConglom(0,"ALL",rc.affiliation_id)>
        <cfset rc.response = JSON.encode(conglom)>
        <cfset fw.setView('common.ajax')>
	</cffunction>
  
	<cffunction name="uploadFile" access="public">
		<cfargument name="rc" type="any">
        <cffile action="upload" filefield="form.fileData" destination="c:\domains\Raps\proposals" nameconflict="makeunique" />
    
        <!---
        <cfparam name="rc.affiliation_id" default="0">
		<cfset conglom = mainGW.getConglom(0,"ALL",rc.affiliation_id)>
        <cfset rc.response = JSON.encode(conglom)>--->
        <cfset rc.response = "success">
        <cfset fw.setView('common.ajax')>
	</cffunction>    
	<cffunction name="getProposalDocs" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.proposal_doc_id" default="0">
		<cfset result = mainGW.getProposalDocs(rc.proposal_doc_id,"ALL",'proposal_doc_name')>
        <cfset rc.response = JSON.encode(result)>
        <cfset fw.setView('common.ajax')>
	</cffunction>    
	<cffunction name="getCyberValue" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.cyber_liability_amount_id" default="0">
        <cfparam name="rc.property_plan_id" default="0">
		<cfset result = mainGW.getCyberValue(rc.cyber_liability_amount_id,rc.property_plan_id)>
        <cfset rc.response = JSON.encode(result)>
        <cfset fw.setView('common.ajax')>
	</cffunction> 
	<cffunction name="getEmpDisValue" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.employee_dishonesty_id" default="0">
        <cfparam name="rc.property_plan_id" default="0">
		<cfset result = mainGW.getEmpDisValue(rc.employee_dishonesty_id,rc.property_plan_id)>
        <cfset rc.response = JSON.encode(result)>
        <cfset fw.setView('common.ajax')>
	</cffunction>         
	<cffunction name="getSession" access="public">
		<cfargument name="rc" type="any">
        <cfif session.auth.isLoggedIn>
        <cfset rc.response = true>        
        <cfelse>
        <cfset rc.response = true> 
        </cfif>
        <cfset fw.setView('common.ajax')>
	</cffunction>     
	<cffunction name="addConsolidate" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.client_id1" default="0">
        <cfparam name="rc.client_id2" default="0">
		<cfset data = mainGW.addConsolidate(rc.client_id1,rc.client_id2)>
        <cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction>
	<cffunction name="addEPLIConsolidate" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.client_id1" default="0">
        <cfparam name="rc.client_id2" default="0">
		<cfset data = mainGW.addEPLIConsolidate(rc.client_id1,rc.client_id2)>
        <cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction> 
	<cffunction name="addWCConsolidate" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.client_id1" default="0">
        <cfparam name="rc.client_id2" default="0">
		<cfset data = mainGW.addWCConsolidate(rc.client_id1,rc.client_id2)>
        <cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction>        
	<cffunction name="deleteConsolidation" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.ue_consolidation_id" default="0">
		<cfset data = mainGW.deleteConsolidation(rc.ue_consolidation_id)>
        <cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction> 
	<cffunction name="deleteEPLIConsolidation" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.epli_consolidation_id" default="0">
		<cfset data = mainGW.deleteEPLIConsolidation(rc.epli_consolidation_id)>
        <cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction> 
	<cffunction name="deleteWCConsolidation" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.wc_consolidation_id" default="0">
		<cfset data = mainGW.deleteWCConsolidation(rc.wc_consolidation_id)>
        <cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction> 
	<cffunction name="deletePolicy" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.policy_id" default="0">
		<cfset data = mainGW.deletePolicy(rc.policy_id)>
        <cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction> 
	<cffunction name="deleteNI" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.named_insured_id" default="0">
		<cfset data = mainGW.deleteNI(rc.named_insured_id)>
        <cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction>                         
	<cffunction name="getClientTypes" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.client_type_id" default="0">
		<cfset ct = mainGW.getClientTypes(rc.client_type_id,"ALL")>
        <cfset rc.response = JSON.encode(ct)>
        <cfset fw.setView('common.ajax')>
	</cffunction> 
	<cffunction name="getRequestedLimits" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.requested_limits_id" default="0">
		<cfset data = mainGW.getRequestedLimits(rc.requested_limits_id)>
        <cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction> 
	<cffunction name="getDocs" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.document_id" default="0">
		<cfset data = mainGW.getDocs(rc.document_id)>
        <cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction>     
	<cffunction name="getClientWC" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.client_id" default="0">
		<cfset data = mainGW.getClientWC(rc.client_id)>
        <cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction> 
	<cffunction name="getClientLOC" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.client_id" default="0">
        <cfparam name="rc.othertab" default="1">
		<cfset data = mainGW.getClientLOC(rc.client_id,rc.othertab)>
        <cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction>         
	<cffunction name="getPolicyTypes" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.policy_type_id" default="0">
		<cfset data = mainGW.getPolicyTypes(rc.policy_type_id)>
        <cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction> 
	<cffunction name="getGLCredits" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.credit_id" default="0">
		<cfset data = mainGW.getGLCredits(rc.credit_id)>
        <cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction>     
	<cffunction name="getNIRelationships" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.ni_relationship_id" default="0">
		<cfset data = mainGW.getNIRelationships(rc.ni_relationship_id)>
        <cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction>     
	<cffunction name="getPolicyStatus" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.policy_status_id" default="0">
		<cfset data = mainGW.getPolicyStatus(rc.policy_status_id)>
        <cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction>   
	<cffunction name="getOtherLoc" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.other_loc_id" default="0">
		<cfset data = mainGW.getOtherLoc(rc.other_loc_id)>
        <cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction>             
	<cffunction name="getClubLocated" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.club_located_id" default="0">
		<cfset data = mainGW.getClubLocated(rc.club_located_id)>
        <cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction>
	<cffunction name="getConstructionTypes" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.construction_type_id" default="0">
		<cfset data = mainGW.getConstructionTypes(rc.construction_type_id)>
        <cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction> 
	<cffunction name="getRoofTypes" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.roof_type_id" default="0">
		<cfset data = mainGW.getRoofTypes(rc.roof_type_id)>
        <cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction>     
	<cffunction name="getCyberLiability" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.cyber_liability_amount_id" default="0">
		<cfset data = mainGW.getCyberLiability(rc.cyber_liability_amount_id)>
        <cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction>
	<cffunction name="getPropCyber" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.property_plan_id" default="0">
		<cfset data = mainGW.getPropCyber(rc.property_plan_id)>
        <cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction>   
	<cffunction name="getPropEmp" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.property_plan_id" default="0">
		<cfset data = mainGW.getPropEmp(rc.property_plan_id)>
        <cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction>        
	<cffunction name="getEDP" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.edp_amount_id" default="0">
		<cfset data = mainGW.getEDP(rc.edp_amount_id)>
        <cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction> 
	<cffunction name="getEmployeeDishonesty" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.employee_dishonesty_id" default="0">
		<cfset data = mainGW.getEmployeeDishonesty(rc.employee_dishonesty_id)>
        <cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction>
	<cffunction name="getPropertyPlans" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.property_plan_id" default="0">
		<cfset data = mainGW.getPropertyPlans(rc.property_plan_id)>
        <cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction>         
	<cffunction name="getEPL" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.epl_limits_id" default="0">
		<cfset data = mainGW.getEPL(rc.epl_limits_id)>
        <cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction>                     
	<cffunction name="getAdditionalLimits" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.additional_limits_id" default="0">
		<cfset data = mainGW.getAdditionalLimits(rc.additional_limits_id)>
        <cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction> 
	<cffunction name="getTerminationReasons" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.termination_reasons_id" default="0">
		<cfset data = mainGW.getTerminationReasons(rc.termination_reasons_id)>
        <cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction>     
	<cffunction name="getPolicies" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.client_id" default="0">
        <cfparam name="rc.policy_id" default="0">
		<cfset data = mainGW.getPolicies(rc.client_id,rc.policy_id)>
        <cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction> 
    <cffunction name="getLocations" access="public">
		<cfargument name="rc" type="any">
		<cfparam name="client_id" default="0">
		<cfset data = mainGW.getLocations(rc.client_id)>

    <cfif data.recordcount eq 0 OR data.mostrecentsavetime eq ''>
		<cfset mainGW.updatesavetime(rc.client_id,now())>
    </cfif>
        <cfif isDefined("rc.pageLoadTime") AND data.recordcount>
	        <cfset checkdates = DateCompare(rc.pageLoadTime, data.mostrecentsavetime)>
            <cfif checkdates eq -1>
            <cfset rc.response = JSON.encode(data)>
            <cfelse>
            <cfset rc.response = "NOREFRESH">
            </cfif>
        <cfelseif not data.recordcount>    
        <cfset rc.response = "NOREFRESH">
        <cfelse>
        <cfset rc.response = JSON.encode(data)>
        </cfif>
        <cfset fw.setView('common.ajax')>
	</cffunction>
    <cffunction name="getLocationStatus" access="public">
		<cfargument name="rc" type="any">
		<cfset data = mainGW.getLocationStatus()>
        <cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction>    
	<cffunction name="getEmployeeBenefits" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.employee_rec_benefits_id" default="0">
		<cfset data = mainGW.getEmployeeBenefits(rc.employee_rec_benefits_id)>
        <cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction>                 
	<cffunction name="getParentCompanies" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.parent_company_id" default="0">
        <cfparam name="rc.filter" default="ALL">
		<cfset pc = mainGW.getParentCompanies(rc.parent_company_id,rc.filter)>
        <cfset rc.response = JSON.encode(pc)>
        <cfset fw.setView('common.ajax')>
	</cffunction>  
	<cffunction name="getIssuingCompanies" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.issuing_company_id" default="0">
        <cfparam name="rc.filter" default="ALL">
		<cfset ic = mainGW.getIssuingCompanies(rc.issuing_company_id,rc.filter)>
        <cfset rc.response = JSON.encode(ic)>
        <cfset fw.setView('common.ajax')>
	</cffunction> 
	<cffunction name="getCompanyAccordion" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.filter" default="ALL">
		<cfset ca = mainGW.getCompanyAccordion(rc.filter)>
        <cfset rc.response = JSON.encode(ca)>
        <cfset fw.setView('common.ajax')>
	</cffunction>                 
	<cffunction name="getStates" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.state_id" default="0">
		<cfset states = mainGW.getStates(rc.state_id)>
        <cfset rc.response = JSON.encode(states)>
        <cfset fw.setView('common.ajax')>
	</cffunction>  
 	<cffunction name="getRatingState" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.location_id" default="0">
		<cfset states = mainGW.getRatingState(rc.location_id)>
        <cfset rc.response = JSON.encode(states)>
        <cfset fw.setView('common.ajax')>
	</cffunction>              
	<cffunction name="getPlans" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.liability_plan_id" default="0">
		<cfset plans = mainGW.getGLPlansCodes(rc.liability_plan_id,"ALL") />
		<cfset rc.response = JSON.encode(plans)>
        <cfset fw.setView('common.ajax')>
	</cffunction>
	<cffunction name="getGLPlans" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.liability_plan_id" default="0">
		<cfset plans = mainGW.getGLPlans(rc.liability_plan_id,"ALL") />
		<cfset rc.response = JSON.encode(plans)>
        <cfset fw.setView('common.ajax')>
	</cffunction>    
	<cffunction name="clientSearch" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.term" default="">
		<cfset results = mainGW.clientSearchAutoComplete(rc.term,rc.searchby) />
    <cfset resultslist = "">
    <cfloop query="results">
    <cfif rc.searchby neq 'policy'>
    <cfset field = results[rc.searchby]>
    <cfelse>
    <cfset field = results.policy_number>
    </cfif>
    <cfset resultslist = listappend(resultslist, '"#field#"')>
    </cfloop>
       <!--- <cfset resultslist = ListQualify(ValueList(results.entity_name),'"')> --->       
        <cfset rc.response = '[#resultslist#]'>
        <cfset fw.setView('common.ajax')>
	</cffunction>  
	<cffunction name="creditSearch" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.term" default="">
		<cfset results = mainGW.creditSearch(rc.term) />
        <cfset resultslist = ListQualify(ValueList(results.credit_name),'"')>        
        <cfset rc.response = '[#resultslist#]'>
        <cfset fw.setView('common.ajax')>
	</cffunction>             
	<cffunction name="checkUserDup" access="public">
		<cfargument name="rc" type="any">
		<cfset rc.response = mainGW.checkDup(user_name)>
        <cfset fw.setView('common.ajax')>
        <cfreturn result>
	</cffunction> 
	<cffunction name="checkClientCodeDup" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.client_code" default="">
        <cfparam name="rc.client_id" default="0">
		<cfset rc.response = mainGW.checkClientCodeDup(rc.client_code,rc.client_id)>
        <cfset fw.setView('common.ajax')>
        <cfreturn result>
	</cffunction>     
	<cffunction name="checkPlanDup" access="public">
		<cfargument name="rc" type="any">
		<cfset rc.response = mainGW.checkPlanDups(name)>
        <cfset fw.setView('common.ajax')>
        <cfreturn result>
	</cffunction>            
	<cffunction name="users" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.message" default="">
        <cfset rc.title = "User Admin">
        <cfif isDefined("URL.user_id")>
        	<cfset rc.getuser = mainGW.getUser(URL.user_id)>
        </cfif>
        <cfset rc.roles = mainGW.getRoles()>
	</cffunction>
	<cffunction name="getusers" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.user_id" default="0">
		<cfset users = mainGW.getUsersSimple(rc.user_id) />
    <!--- if getting just one back decrypt the password--->
    <cfif users.recordcount eq 1>
    		<cfset DecryptedPassword = loginGW.decryptPassword(users.user_pass)>
        <cfset newcolarray = Arraynew(1)>
        <cfset newcolarray[1] = DecryptedPassword>
		
        <cfset QueryAddColumn(users, 'DecryptedPass', "VarChar", newcolarray)>    
    </cfif>
		<cfset rc.response = JSON.encode(users)>
        <cfset fw.setView('common.ajax')>
	</cffunction>
	<cffunction name="getnotes" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.client_id" default="0">
		<cfset result = mainGW.getnotes(rc.client_id) />
		<cfset rc.response = JSON.encode(result)>
        <cfset fw.setView('common.ajax')>
	</cffunction>    
	<cffunction name="getNI" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.client_id" default="0">
        <cfparam name="rc.named_insured_id" default="0">
        
		<cfset ni = mainGW.getNI(rc.client_id,rc.named_insured_id) />
		<cfset rc.response = JSON.encode(ni)>
        <cfset fw.setView('common.ajax')>
	</cffunction>
	<cffunction name="getConsolidated" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.client_id" default="0">
		<cfset gc = mainGW.getConsolidated(rc.client_id) />
		<cfset rc.response = JSON.encode(gc)>
        <cfset fw.setView('common.ajax')>
	</cffunction> 
	<cffunction name="getEPLIConsolidated" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.client_id" default="0">    
		<cfset result = mainGW.getEPLIConsolidated(rc.client_id) />
		<cfset rc.response = JSON.encode(result)>
        <cfset fw.setView('common.ajax')>
	</cffunction> 
	<cffunction name="getWCConsolidated" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.client_id" default="0">    
		<cfset result = mainGW.getWCConsolidated(rc.client_id) />
		<cfset rc.response = JSON.encode(result)>
        <cfset fw.setView('common.ajax')>
	</cffunction>               
	<cffunction name="saveUser" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.disabled" default="0">
		<cfset var user_id = rc.user_id >
		<cfset var user_firstname = rc.user_firstname >
		<cfset var user_lastname = rc.user_lastname >
		<cfset var user_name = rc.user_name >
		<cfset var user_pass = rc.user_pass >
		<cfset var user_pass_confirm = rc.user_pass_confirm >
		<cfset var user_role_id = rc.user_role_id >
        <cfset var user_sig = rc.user_sig >
		<cfset result = mainGW.saveUserAjax(user_id=user_id,
					user_firstname=user_firstname,
					user_lastname = user_lastname,
					user_name = user_name,
					user_pass = user_pass,
					user_pass_confirm = user_pass_confirm,
					user_role_id = user_role_id,
					user_sig=user_sig,
					disabled=rc.disabled) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction>
	<cffunction name="addWCOwner" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.owner_name" default="">
        <cfparam name="rc.owner_title" default="">
        <cfparam name="rc.owner_percent" default="0">
        <cfparam name="rc.owner_salary" default="0">
        <cfparam name="rc.client_id" default="0">
        <cfparam name="rc.client_wc_id" default="0">
        <cfparam name="rc.owner_include" default="0">
        <cfparam name="rc.owner_exclude" default="0">
		<cfset result = mainGW.saveWCOwner(rc.owner_name,rc.owner_title,rc.owner_percent,rc.owner_salary,rc.client_id,rc.client_wc_id,rc.owner_include,rc.owner_exclude) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction> 
	<cffunction name="deleteWCOwner" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.client_wc_id" default="0">
		<cfset result = mainGW.deleteWCOwner(rc.client_wc_id) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction>   
	<cffunction name="addLOC" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.loc_desc" default="">
        <cfparam name="rc.loc_amount" default="0">
        <cfparam name="rc.client_loc_id" default="0">
        <cfparam name="rc.client_id" default="0">
        <cfparam name="rc.othertab" default="0">
		<cfset result = mainGW.saveLOC(rc.loc_desc,rc.loc_amount,rc.client_loc_id,rc.client_id,rc.othertab) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction>        
	<cffunction name="saveUserSearch" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.search_en" default="0">
        <cfparam name="rc.search_dba" default="0">
        <cfparam name="rc.search_ni" default="0">
        <cfparam name="rc.search_cn" default="0">
        <cfparam name="rc.search_xref" default="0">
        <cfparam name="rc.search_status" default="2">
        <cfparam name="rc.searchby" default="entity_name">
        <cfparam name="rc.searchbyother" default="mailing_address">
        <cfparam name="rc.exact" default="0">
		<cfset result = mainGW.saveUserSearchOptions(rc.search_en,rc.search_dba,rc.search_ni,rc.search_cn,rc.search_xref,rc.search_status,rc.searchby,rc.searchbyother,rc.exact) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction>
	<cffunction name="saveNotes" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.client_id" default="0">
        <cfparam name="rc.client_notes" default="0">
		<cfset result = mainGW.saveNotes(rc.client_id,rc.client_notes) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction> 
	<cffunction name="saveSticky" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.user_id" default="0">
        <cfparam name="rc.pinsticky" default="0">
		<cfset result = mainGW.saveSticky(rc.user_id,rc.pinsticky) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction>    
	<cffunction name="deletePD" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.proposal_doc_id" default="0">
		<cfset result = mainGW.deletePD(rc.proposal_doc_id) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction>       
	<cffunction name="saveConglom" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.affiliation_id" default="0">
        <cfparam name="rc.name" default="">
        <cfparam name="rc.code" default="0">
        <cfparam name="rc.disabled" default="0">
		<cfset result = mainGW.saveConglom(rc.affiliation_id,rc.name,rc.code,rc.disabled) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction> 
	<cffunction name="saveState" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.state_id" default="0">
        <cfparam name="rc.tax_rate" default="0">
        <cfparam name="rc.stamp_tax" default="0">
        <cfparam name="rc.filing_fee" default="0">
        <cfparam name="rc.broker_policy_fee" default="0">
        <cfparam name="rc.inspection_fee" default="0">
        <cfparam name="rc.rpg_fee" default="0">
        <cfparam name="rc.custom_tax_1_label" default="">
        <cfparam name="rc.custom_tax_1" default="0">
        <cfparam name="rc.custom_tax_1_type" default="%">
        <cfparam name="rc.custom_tax_2_label" default="">
        <cfparam name="rc.custom_tax_2" default="0">
        <cfparam name="rc.custom_tax_2_type" default="%">
        <cfparam name="rc.custom_tax_3_label" default="">
        <cfparam name="rc.custom_tax_3" default="0">
        <cfparam name="rc.custom_tax_3_type" default="%">
        <cfparam name="rc.custom_tax_4_label" default="">
        <cfparam name="rc.custom_tax_4" default="0">
        <cfparam name="rc.custom_tax_4_type" default="%">
        <cfparam name="rc.custom_tax_5_label" default="">
        <cfparam name="rc.custom_tax_5" default="0">
        <cfparam name="rc.custom_tax_5_type" default="%">
        <!---terrorism fee is now defined at plan level, but leaving this in in case they change their mind
        <cfparam name="rc.terrorism_fee" default="0">--->
		<cfparam name="rc.calculation" default="">
        <cfparam name="rc.notes" default="">
        <cfparam name="rc.prop_tax" default="0">
       <!--- <cfparam name="rc.prop_fees" default="0">--->
        <cfparam name="rc.prop_notes" default="">
        <cfparam name="rc.prop_min_premium" default="0">
		<cfset result = mainGW.saveState(rc.state_id,
										 rc.tax_rate,
										 rc.stamp_tax,
										 ReReplace(rc.filing_fee, "[^\d.]", "","ALL"),
										 rc.broker_policy_fee,
										 ReReplace(rc.inspection_fee, "[^\d.]", "","ALL"),
										 ReReplace(rc.rpg_fee, "[^\d.]", "","ALL"),
										 rc.custom_tax_1_label,
										 ReReplace(rc.custom_tax_1, "[^\d.]", "","ALL"),
										 rc.custom_tax_1_type,
										 rc.custom_tax_2_label,
										 ReReplace(rc.custom_tax_2, "[^\d.]", "","ALL"),
										 rc.custom_tax_2_type,
										 rc.custom_tax_3_label,
										 ReReplace(rc.custom_tax_3, "[^\d.]", "","ALL"),
										 rc.custom_tax_3_type,
										 rc.custom_tax_4_label,
										 ReReplace(rc.custom_tax_4, "[^\d.]", "","ALL"),
										 rc.custom_tax_4_type,
										 rc.custom_tax_5_label,
										 ReReplace(rc.custom_tax_5, "[^\d.]", "","ALL"),
										 rc.custom_tax_5_type,
										 <!---rc.terrorism_fee,--->
										 rc.calculation,
										 rc.notes,
										 rc.prop_tax,
										 <!---ReReplace(rc.prop_fees, "[^\d.]", "","ALL"),--->
										 rc.prop_notes,
										 ReReplace(rc.prop_min_premium, "[^\d.]", "","ALL")) />
        
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction>  
	<cffunction name="saveClientType" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.client_type_id" default="0">
        <cfparam name="rc.type" default="">
        <cfparam name="rc.disabled" default="0">
		<cfset result = mainGW.saveClientType(rc.client_type_id,rc.type,rc.disabled) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction> 
	<cffunction name="saveRequestedLimits" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.requested_limits_id" default="0">
        <cfparam name="rc.requested_limit" default="">
        <cfparam name="rc.disabled" default="0">
		<cfset result = mainGW.saveRequestedLimits(rc.requested_limits_id,rc.requested_limit,rc.disabled) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction>
	<cffunction name="savePolicyTypes" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.policy_type_id" default="0">
        <cfparam name="rc.policy_type" default="">
        <cfparam name="rc.disabled" default="0">
		<cfset result = mainGW.savePolicyTypes(rc.policy_type_id,rc.policy_type,rc.disabled) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction> 
	<cffunction name="saveGLCredits" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.credit_id" default="0">
        <cfparam name="rc.credit_name" default="">
        <cfparam name="rc.disabled" default="0">
		<cfset result = mainGW.saveGLCredits(rc.credit_id,rc.credit_name,rc.disabled) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction>     
	<cffunction name="saveNIRelationships" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.ni_relationship_id" default="0">
        <cfparam name="rc.ni_relationship" default="">
        <cfparam name="rc.disabled" default="0">
		<cfset result = mainGW.saveNIRelationships(rc.ni_relationship_id,rc.ni_relationship,rc.disabled) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction>     
	<cffunction name="savePolicyStatus" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.policy_status_id" default="0">
        <cfparam name="rc.policy_status" default="">
        <cfparam name="rc.disabled" default="0">
		<cfset result = mainGW.savePolicyStatus(rc.policy_status_id,rc.policy_status,rc.disabled) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction>  
	<cffunction name="saveOtherLoc" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.other_loc_id" default="0">
        <cfparam name="rc.other_loc" default="">
        <cfparam name="rc.disabled" default="0">
		<cfset result = mainGW.saveOtherLoc(rc.other_loc_id,rc.other_loc,rc.disabled) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction>            
	<cffunction name="saveClubLocated" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.club_located_id" default="0">
        <cfparam name="rc.club_located" default="">
        <cfparam name="rc.disabled" default="0">
		<cfset result = mainGW.saveClubLocated(rc.club_located_id,rc.club_located,rc.disabled) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction>  
	<cffunction name="saveConstructionTypes" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.construction_type_id" default="0">
        <cfparam name="rc.construction_type" default="">
        <cfparam name="rc.disabled" default="0">
		<cfset result = mainGW.saveConstructionTypes(rc.construction_type_id,rc.construction_type,rc.disabled) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction> 
	<cffunction name="renewDates" access="public">
		<cfargument name="rc" type="any">
    <cfparam name="rc.client_id" default="0">
    <cfparam name="rc.current_effective_date" default="">
		<cfset result = mainGW.renewDates(rc.client_id,rc.current_effective_date) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction>   
	<cffunction name="saveRoofTypes" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.roof_type_id" default="0">
        <cfparam name="rc.roof_type" default="">
        <cfparam name="rc.disabled" default="0">
		<cfset result = mainGW.saveRoofTypes(rc.roof_type_id,rc.roof_type,rc.disabled) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction>       
	<cffunction name="saveCyberLiability" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.cyber_liability_amount_id" default="0">
        <cfparam name="rc.cyber_liability_amount" default="">
        <cfparam name="rc.disabled" default="0">
		<cfset result = mainGW.saveCyberLiability(rc.cyber_liability_amount_id,rc.cyber_liability_amount,rc.disabled) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction>
	<cffunction name="saveProposalDocs" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.proposal_doc_id" default="0">
        <cfparam name="rc.proposal_doc_name" default="">
        <cfparam name="rc.proposal_doc_content" default="">
        <cfparam name="rc.editable" default="0">
        <cfparam name="rc.defaultcheck" default="0">
        <cfparam name="rc.disabled" default="0">
        <cfparam name="rc.includes_list" default="0">
		<cfset result = mainGW.saveProposalDocs(rc.proposal_doc_id,rc.proposal_doc_name,rc.proposal_doc_content,rc.editable,rc.defaultcheck,rc.disabled,rc.includes_list) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction> 
	<cffunction name="saveProposalOrder" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="result" default="success">
        <cfparam name="rc.idlist" default="">
        <cftry>
        <cfloop from="1" to="#listlen(rc.idlist)#" index="i">
        <cfset proposal_doc_id = listgetat(idlist,i)>
		<cfset result = mainGW.saveProposalOrder(proposal_doc_id,i) />
        </cfloop>
        <cfcatch type="any">
        <cfset result = "#cfcatch.Message# - #cfcatch.Detail#">
        </cfcatch>
        </cftry>
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction>        
	<cffunction name="saveEDP" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.edp_amount_id" default="0">
        <cfparam name="rc.edp_amount" default="">
        <cfparam name="rc.disabled" default="0">
		<cfset result = mainGW.saveEDP(rc.edp_amount_id,rc.edp_amount,rc.disabled) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction>
	<cffunction name="saveEmployeeDishonesty" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.employee_dishonesty_id" default="0">
        <cfparam name="rc.employee_dishonesty_amount" default="">
        <cfparam name="rc.disabled" default="0">
		<cfset result = mainGW.saveEmployeeDishonesty(rc.employee_dishonesty_id,rc.employee_dishonesty_amount,rc.disabled) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction> 
	<cffunction name="savePropertyPlans" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.property_plan_id" default="0">
        <cfparam name="rc.property_plan_name" default="">
        <!---<cfparam name="rc.prop_premium" default="">--->
        <cfparam name="rc.prop_agencyfee" default="">
        <cfparam name="rc.prop_terrorism" default="">
        <cfparam name="rc.prop_eqpbrkrate" default="">
        <cfparam name="rc.proposal_hide" default="0">
        <cfparam name="rc.disabled" default="0">
		<cfset result = mainGW.savePropertyPlans(rc.property_plan_id,rc.property_plan_name,rc.prop_agencyfee,rc.prop_terrorism,rc.prop_eqpbrkrate,rc.disabled,rc.proposal_hide) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction> 
	<cffunction name="savePropertyCyber" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.property_plan_id" default="0">
        <cfparam name="rc.cyber_liability_amount_id" default="0">
        <cfparam name="rc.property_cyber_amount" default="0">
        <cfparam name="rc.property_cyber_id" default="0">
        <cfparam name="rc.disabled" default="0">
		<cfset result = mainGW.savePropertyCyber(rc.property_plan_id,rc.cyber_liability_amount_id,rc.property_cyber_amount,rc.property_cyber_id) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction> 
	<cffunction name="savePropertyEmp" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.property_plan_id" default="0">
        <cfparam name="rc.employee_dishonesty_id" default="0">
        <cfparam name="rc.property_emp_amount" default="0">
        <cfparam name="rc.property_emp_id" default="0">
        <cfparam name="rc.disabled" default="0">
		<cfset result = mainGW.savePropertyEmp(rc.property_plan_id,rc.employee_dishonesty_id,rc.property_emp_amount,rc.property_emp_id) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction>                 
	<cffunction name="saveEPL" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.epl_limits_id" default="0">
        <cfparam name="rc.epl_limit" default="">
        <cfparam name="rc.disabled" default="0">
		<cfset result = mainGW.saveEPL(rc.epl_limits_id,rc.epl_limit,rc.disabled) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction>                     
	<cffunction name="saveAdditionalLimits" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.additional_limits_id" default="0">
        <cfparam name="rc.additional_limits" default="">
        <cfparam name="rc.disabled" default="0">
		<cfset result = mainGW.saveAdditionalLimits(rc.additional_limits_id,rc.additional_limits,rc.disabled) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction> 
	<cffunction name="saveTerminationReasons" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.termination_reasons_id" default="0">
        <cfparam name="rc.termination_reasons" default="">
        <cfparam name="rc.disabled" default="0">
		<cfset result = mainGW.saveTerminationReasons(rc.termination_reasons_id,rc.termination_reasons,rc.disabled) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction>     
	<cffunction name="savePolicy" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.client_id" default="0">
		<cfparam name="rc.policy_id" default="0">
        <cfparam name="rc.renewed_policy_id" default="0">
        <cfparam name="rc.policy_type_id" default="0">
        <cfparam name="rc.policy_effectivedate" default="">
        <cfparam name="rc.policy_expiredate" default="">
        <cfparam name="rc.policy_number" default="0">
        <cfparam name="rc.policy_issuing_company" default="0">
        <cfparam name="rc.policy_status_id" default="0">
        <cfparam name="rc.policy_canceldate" default="">
		<cfset result = mainGW.savePolicy(rc.client_id,rc.policy_id,rc.policy_type_id,rc.policy_effectivedate,rc.policy_expiredate,rc.policy_number,rc.policy_issuing_company,rc.policy_status_id,rc.policy_canceldate) />
        <cfif rc.renewed_policy_id neq 0>
        <cfset changestatus = mainGW.changePolicyStatus(rc.renewed_policy_id)>
        </cfif>
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction>     
	<cffunction name="saveNI" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.client_id" default="0">
		<cfparam name="rc.named_insured_id" default="0">
        <cfparam name="rc.named_insured" default="">
        <cfparam name="rc.relationship" default="0">
        <cfparam name="rc.notes" default="">
        <cfparam name="rc.ni_fein" default="">
        <cfparam name="rc.yearstarted" default="">
        <cfparam name="rc.gl" default="0">
        <cfparam name="rc.property" default="0">
        <cfparam name="rc.ue" default="0">
        <cfparam name="rc.wc" default="0">
        <cfparam name="rc.epli" default="0">
        <cfparam name="rc.cyber" default="0">
		<cfset result = mainGW.saveNI(rc.client_id,rc.named_insured_id,rc.named_insured,rc.relationship,rc.notes,rc.ni_fein,rc.yearstarted,rc.gl,rc.property,rc.ue,rc.wc,rc.epli,rc.cyber) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction>         
	<cffunction name="saveEmployeeBenefits" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.employee_rec_benefits_id" default="0">
        <cfparam name="rc.employee_rec_benefits" default="">
        <cfparam name="rc.disabled" default="0">
		<cfset result = mainGW.saveEmployeeBenefits(rc.employee_rec_benefits_id,rc.employee_rec_benefits,rc.disabled) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction>              
	<cffunction name="saveParentCompany" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.parent_company_id" default="0">
        <cfparam name="rc.parent_company_name" default="">
        <cfparam name="rc.disabled" default="0">
		<cfset result = mainGW.saveParentCompany(rc.parent_company_id,rc.parent_company_name,rc.disabled) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction> 
	<cffunction name="saveIssuingCompany" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.issuing_company_id" default="0">
        <cfparam name="rc.parent_company_id2" default="0">
        <cfparam name="rc.name" default="">
        <cfparam name="rc.code" default="">
        <cfparam name="rc.disabled2" default="0">
		<cfset result = mainGW.saveIssuingCompany(rc.issuing_company_id,rc.parent_company_id2,rc.name,rc.code,rc.disabled2) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction>   
	<cffunction name="saveLocationStatus" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.location_id" default="0">
        <cfparam name="rc.location_status_id" default="0">
		<cfset result = mainGW.saveLocationStatus(rc.location_id,rc.location_status_id) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction> 
	<cffunction name="saveLocationExclude" access="public">
		<cfargument name="rc" type="any">
        <cfparam name="rc.location_id" default="0">
        <cfparam name="rc.exclude_prop" default="0">
        <cfparam name="rc.ratingid" default="0">
		<cfset result = mainGW.saveLocationExclude(rc.location_id,rc.exclude_prop) />
    <cfset ratingSync = appGW.ratingLocSync(excl=rc.exclude_prop,syncWith='rating',id=rc.ratingid)>
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction>                               
	<cffunction name="saveDefaultSearch" access="public">
		<cfargument name="rc" type="any">
		<cfset result = mainGW.saveUserSearchOptions(1,0,0,0,0,2) />
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />	
	</cffunction>        
  <!---
	<cffunction name="addEditClient">
		<cfargument name="rc" type="any">
		<cfset var result="">
        <cfparam name="rc.current_effective_date" default="">
        <cfparam name="rc.ue_type" default="">
        <cfparam name="rc.ue_declined" default="0">
        <cfparam name="rc.ue_date1" default="">
        <cfparam name="rc.ue_date2" default="">
        <cfparam name="rc.epli_declined" default="0">
        <cfparam name="rc.epli_doincluded" default="0">
        <cfparam name="rc.wc_declined" default="0">
        <cfparam name="rc.bond_declined" default="0">
        <cfparam name="rc.label_needed" default="0">
        <cfparam name="rc.wc_additionalfeins" default="0">
        <cfparam name="rc.other_dedret" default="">
        <cfparam name="rc.epli_retrodate" default="">
        <cfparam name="rc.epli_prioracts" default="0">
		<cfif rc.client_id eq 0>
        
				<cfset result1 = mainGW.addClient(affiliation_id=rc.affiliation_id,
						client_type_id=rc.client_type_id,
						 ams=rc.ams,
						am=rc.am,
						client_code=rc.client_code,
						entity_name=rc.entity_name,
						dba=rc.dba,
						mailing_address=rc.mailing_address,
						mailing_address2=rc.mailing_address2,
						mailing_city=rc.mailing_city,
						mailing_state=rc.mailing_state,
						mailing_zip=rc.mailing_zip,
						business_phone=rc.business_phone,
						business_email=rc.business_email,
						website=rc.website,
						fein=rc.fein,
						year_business_started=rc.year_business_started,
						years_experience=rc.years_experience,
						x_reference=rc.x_reference,
						client_status_id=rc.client_status_id,
						current_effective_date=rc.current_effective_date,
						ue_type=rc.ue_type,
						ue_date1=rc.ue_date1,
						ue_date2=rc.ue_date2,
						ue_issuing_company=rc.ue_issuing_company,
						ue_occurrence=ReReplace(rc.ue_occurrence, "[^\d.]", "","ALL"),
						ue_aggregate=ReReplace(rc.ue_aggregate, "[^\d.]", "","ALL"),
						ue_retention=ReReplace(rc.ue_retention, "[^\d.]", "","ALL"),
						ue_premium=ReReplace(rc.ue_premium, "[^\d.]", "","ALL"),
						ue_brokerfee=ReReplace(rc.ue_brokerfee, "[^\d.]", "","ALL"),
						ue_agencyfee=ReReplace(rc.ue_agencyfee, "[^\d.]", "","ALL"),
						ue_stampingfee=ReReplace(rc.ue_stampingfee, "[^\d.]", "","ALL"),
						ue_filingfee=ReReplace(rc.ue_filingfee, "[^\d.]", "","ALL"),
						ue_sltax=ReReplace(rc.ue_sltax, "[^\d.]", "","ALL"),
						ue_totalpremium=ReReplace(rc.ue_totalpremium, "[^\d.]", "","ALL"),
						ue_declined=rc.ue_declined,
						ue_declinedreason=rc.ue_declinedreason,
						ue_proposalnotes=rc.ue_proposalnotes,
						ue_rate_state=rc.ue_rate_state,
						<!---
						ue_rate_sltax=ReReplace(rc.ue_rate_sltax, "[^\d.]", "","ALL"),
						ue_rate_filingfee=ReReplace(rc.ue_rate_filingfee, "[^\d.]", "","ALL"),
						ue_rate_stampingfee=ReReplace(rc.ue_rate_stampingfee, "[^\d.]", "","ALL"),
						ue_rate_statesurcharge=ReReplace(rc.ue_rate_statesurcharge, "[^\d.]", "","ALL"),
						ue_rate_munisurcharge=ReReplace(rc.ue_rate_munisurcharge, "[^\d.]", "","ALL"),
						--->
						epli_date1=rc.epli_date1,
						epli_date2=rc.epli_date2,
						epli_retrodate=rc.epli_retrodate,
						epli_prioracts=rc.epli_prioracts,
						epli_issuing_company=rc.epli_issuing_company,
						epli_aggregate=ReReplace(rc.epli_aggregate, "[^\d.]", "","ALL"),
						epli_retention=ReReplace(rc.epli_retention, "[^\d.]", "","ALL"),
						epli_doincluded=rc.epli_doincluded,
						epli_aggregate2=ReReplace(rc.epli_aggregate2, "[^\d.]", "","ALL"),
						epli_retention2=ReReplace(rc.epli_retention2, "[^\d.]", "","ALL"),	
						epli_fulltime=rc.epli_fulltime,
						epli_partime=rc.epli_partime,
						epli_totalemployees=rc.epli_totalemployees,						
						epli_premium=ReReplace(rc.epli_premium, "[^\d.]", "","ALL"),
						epli_brokerfee=ReReplace(rc.epli_brokerfee, "[^\d.]", "","ALL"),
						epli_agencyfee=ReReplace(rc.epli_agencyfee, "[^\d.]", "","ALL"),
						epli_filingfee=ReReplace(rc.epli_filingfee, "[^\d.]", "","ALL"),
						epli_sltax=ReReplace(rc.epli_sltax, "[^\d.]", "","ALL"),
						epli_totalpremium=ReReplace(rc.epli_totalpremium, "[^\d.]", "","ALL"),
						epli_declined=rc.epli_declined,
						epli_declinedreason=rc.epli_declinedreason,
						epli_proposalnotes=rc.epli_proposalnotes,
						wc_states=rc.wc_states,
						wc_effectivedate=rc.wc_effectivedate,
						wc_expiredate=rc.wc_expiredate,
						wc_issuing_company=rc.wc_issuing_company,
						wc_classcode=rc.wc_classcode,
						wc_rate=ReReplace(rc.wc_rate, "[^\d.]", "","ALL"),
                        wc_premium=ReReplace(rc.wc_premium, "[^\d.]", "","ALL"),
						wc_agencyfee=ReReplace(rc.wc_agencyfee, "[^\d.]", "","ALL"),
						wc_totalpremium=ReReplace(rc.wc_totalpremium, "[^\d.]", "","ALL"),
						wc_fein=rc.wc_fein,
						wc_additionalfeins=rc.wc_additionalfeins,
						wc_fulltime=rc.wc_fulltime,
						wc_partime=rc.wc_partime,
						wc_totalemployees=rc.wc_totalemployees,
						wc_payroll=ReReplace(rc.wc_payroll, "[^\d.]", "","ALL"),
						wc_eachaccident=ReReplace(rc.wc_eachaccident, "[^\d.]", "","ALL"),
						wc_diseaseeach=ReReplace(rc.wc_diseaseeach, "[^\d.]", "","ALL"),
						wc_diseaselimit=ReReplace(rc.wc_diseaselimit, "[^\d.]", "","ALL"),
						wc_declined=rc.wc_declined,
						wc_declinedreason=rc.wc_declinedreason,
						wc_proposalnotes=rc.wc_proposalnotes,
						bond_type=rc.bond_type,
						bond_issuing_company=rc.bond_issuing_company,
						bond_amount=ReReplace(rc.bond_amount, "[^\d.]", "","ALL"),
						bond_obligee=rc.bond_obligee,
						bond_premium=ReReplace(rc.bond_premium, "[^\d.]", "","ALL"),
						bond_fees=ReReplace(rc.bond_fees, "[^\d.]", "","ALL"),
						bond_deliveryfee=ReReplace(rc.bond_deliveryfee, "[^\d.]", "","ALL"),
						bond_tax=ReReplace(rc.bond_tax, "[^\d.]", "","ALL"),
						bond_totalpremium=ReReplace(rc.bond_totalpremium, "[^\d.]", "","ALL"),
						bond_declined=rc.bond_declined,
						bond_declinedreason=rc.bond_declinedreason,
						other_loc=rc.other_loc,
						other_effectivedate=rc.other_effectivedate,
						other_expiredate=rc.other_expiredate,
						other_issuing_company=rc.other_issuing_company,
						other_dedret=rc.other_dedret,
						other_dedretamount=ReReplace(rc.other_dedretamount, "[^\d.]", "","ALL"),
						other_premium=ReReplace(rc.other_premium, "[^\d.]", "","ALL"),
						other_brokerfee=ReReplace(rc.other_brokerfee, "[^\d.]", "","ALL"),
						other_agencyfee=ReReplace(rc.other_agencyfee, "[^\d.]", "","ALL"),
						other_tax=ReReplace(rc.other_tax, "[^\d.]", "","ALL"),
						other_filingfee=ReReplace(rc.other_filingfee, "[^\d.]", "","ALL"),
						other_totalpremium=ReReplace(rc.other_totalpremium, "[^\d.]", "","ALL"),
						other_proposalnotes=rc.other_proposalnotes,
						wc_notes=rc.wc_notes,
						ue_notes=rc.ue_notes,
						epli_notes=rc.epli_notes,
						bond_notes=rc.bond_notes,
						other_notes=rc.other_notes,
						label_needed=rc.label_needed)			
						 />
				 <cfif isnumeric(result1)>
				 	<!--- Got the ID, successful insert --->
					<!--- Get contacts as struct of arrays --->
					<cfset formStruct = getPageContext().getRequest().getParameterMap()>
					<!--- Get the Array length based on number of forms submitted --->
					<cfset count = arrayLen(formStruct['name'])>
					<!--- name,title,cell,phone,fax,email --->
					<cftry>
					<cfloop from="1" to="#count#" index="i">
						<cfif formStruct['name'][i] neq "">
						<cfset result2=mainGW.addClientContact(client_id=result1,
								name=#formStruct['name'][i]#,
								phone=#formStruct['phone'][i]#,
								title=#formStruct['title'][i]#,
								cell=#formStruct['cell'][i]#,
								fax=#formStruct['fax'][i]#,
								email=#formStruct['email'][i]#) />
						</cfif>
					</cfloop>
                    <cfset result = result1>
                    <!---<cfset result = serializeJSON(result)>--->
					 <cfcatch type="any"><cfset result.a="false"></cfcatch>
                    
					</cftry> 

				<cfelse>
					<cfset result="false">
				</cfif>
		<cfelse>
			<cfset result1 = mainGW.editClient(client_id=rc.client_id,
						affiliation_id=rc.affiliation_id,
						client_type_id=rc.client_type_id,
						 ams=rc.ams,
						am=rc.am,
						client_code=rc.client_code,
						entity_name=rc.entity_name,
						dba=rc.dba,
						mailing_address=rc.mailing_address,
						mailing_address2=rc.mailing_address2,
						mailing_city=rc.mailing_city,
						mailing_state=rc.mailing_state,
						mailing_zip=rc.mailing_zip,
						business_phone=rc.business_phone,
						business_email=rc.business_email,
						website=rc.website,
						fein=rc.fein,
						year_business_started=rc.year_business_started,
						years_experience=rc.years_experience,
						x_reference=rc.x_reference,
						client_status_id=rc.client_status_id,
						current_effective_date=rc.current_effective_date,
						ue_type=rc.ue_type,
						ue_date1=rc.ue_date1,
						ue_date2=rc.ue_date2,
						ue_issuing_company=rc.ue_issuing_company,
						ue_occurrence=ReReplace(rc.ue_occurrence, "[^\d.]", "","ALL"),
						ue_aggregate=ReReplace(rc.ue_aggregate, "[^\d.]", "","ALL"),
						ue_retention=ReReplace(rc.ue_retention, "[^\d.]", "","ALL"),
						ue_premium=ReReplace(rc.ue_premium, "[^\d.]", "","ALL"),
						ue_brokerfee=ReReplace(rc.ue_brokerfee, "[^\d.]", "","ALL"),
						ue_agencyfee=ReReplace(rc.ue_agencyfee, "[^\d.]", "","ALL"),
						ue_filingfee=ReReplace(rc.ue_filingfee, "[^\d.]", "","ALL"),
						ue_stampingfee=ReReplace(rc.ue_stampingfee, "[^\d.]", "","ALL"),
						ue_sltax=ReReplace(rc.ue_sltax, "[^\d.]", "","ALL"),
						ue_totalpremium=ReReplace(rc.ue_totalpremium, "[^\d.]", "","ALL"),
						ue_declined=rc.ue_declined,
						ue_declinedreason=rc.ue_declinedreason,
						ue_proposalnotes=rc.ue_proposalnotes,
						ue_rate_state=rc.ue_rate_state,
						<!---
						ue_rate_sltax=ReReplace(rc.ue_rate_sltax, "[^\d.]", "","ALL"),
						ue_rate_filingfee=ReReplace(rc.ue_rate_filingfee, "[^\d.]", "","ALL"),
						ue_rate_stampingfee=ReReplace(rc.ue_rate_stampingfee, "[^\d.]", "","ALL"),
						ue_rate_statesurcharge=ReReplace(rc.ue_rate_statesurcharge, "[^\d.]", "","ALL"),
						ue_rate_munisurcharge=ReReplace(rc.ue_rate_munisurcharge, "[^\d.]", "","ALL"),
						--->
						epli_date1=rc.epli_date1,
						epli_date2=rc.epli_date2,
						epli_retrodate=rc.epli_retrodate,
						epli_prioracts=rc.epli_prioracts,
						epli_issuing_company=rc.epli_issuing_company,
						epli_aggregate=ReReplace(rc.epli_aggregate, "[^\d.]", "","ALL"),
						epli_retention=ReReplace(rc.epli_retention, "[^\d.]", "","ALL"),
						epli_doincluded=rc.epli_doincluded,
						epli_aggregate2=ReReplace(rc.epli_aggregate2, "[^\d.]", "","ALL"),
						epli_retention2=ReReplace(rc.epli_retention2, "[^\d.]", "","ALL"),	
						epli_fulltime=rc.epli_fulltime,
						epli_partime=rc.epli_partime,
						epli_totalemployees=rc.epli_totalemployees,						
						epli_premium=ReReplace(rc.epli_premium, "[^\d.]", "","ALL"),
						epli_brokerfee=ReReplace(rc.epli_brokerfee, "[^\d.]", "","ALL"),
						epli_agencyfee=ReReplace(rc.epli_agencyfee, "[^\d.]", "","ALL"),
						epli_filingfee=ReReplace(rc.epli_filingfee, "[^\d.]", "","ALL"),
						epli_sltax=ReReplace(rc.epli_sltax, "[^\d.]", "","ALL"),
						epli_totalpremium=ReReplace(rc.epli_totalpremium, "[^\d.]", "","ALL"),
						epli_declined=rc.epli_declined,
						epli_declinedreason=rc.epli_declinedreason,
						epli_proposalnotes=rc.epli_proposalnotes,						
						wc_states=rc.wc_states,
						wc_effectivedate=rc.wc_effectivedate,
						wc_expiredate=rc.wc_expiredate,
						wc_issuing_company=rc.wc_issuing_company,
						wc_classcode=rc.wc_classcode,
						wc_rate=ReReplace(rc.wc_rate, "[^\d.]", "","ALL"),
                        wc_premium=ReReplace(rc.wc_premium, "[^\d.]", "","ALL"),
						wc_agencyfee=ReReplace(rc.wc_agencyfee, "[^\d.]", "","ALL"),
						wc_totalpremium=ReReplace(rc.wc_totalpremium, "[^\d.]", "","ALL"),						
						wc_fein=rc.wc_fein,
						wc_additionalfeins=rc.wc_additionalfeins,
						wc_fulltime=rc.wc_fulltime,
						wc_partime=rc.wc_partime,
						wc_totalemployees=rc.wc_totalemployees,
						wc_payroll=ReReplace(rc.wc_payroll, "[^\d.]", "","ALL"),
						wc_eachaccident=ReReplace(rc.wc_eachaccident, "[^\d.]", "","ALL"),
						wc_diseaseeach=ReReplace(rc.wc_diseaseeach, "[^\d.]", "","ALL"),
						wc_diseaselimit=ReReplace(rc.wc_diseaselimit, "[^\d.]", "","ALL"),
						wc_declined=rc.wc_declined,
						wc_declinedreason=rc.wc_declinedreason,
						wc_proposalnotes=rc.wc_proposalnotes,						
						bond_type=rc.bond_type,
						bond_issuing_company=rc.bond_issuing_company,
						bond_amount=ReReplace(rc.bond_amount, "[^\d.]", "","ALL"),
						bond_obligee=rc.bond_obligee,
						bond_premium=ReReplace(rc.bond_premium, "[^\d.]", "","ALL"),
						bond_fees=ReReplace(rc.bond_fees, "[^\d.]", "","ALL"),
						bond_deliveryfee=ReReplace(rc.bond_deliveryfee, "[^\d.]", "","ALL"),
						bond_tax=ReReplace(rc.bond_tax, "[^\d.]", "","ALL"),
						bond_totalpremium=ReReplace(rc.bond_totalpremium, "[^\d.]", "","ALL"),
						bond_declined=rc.bond_declined,
						bond_declinedreason=rc.bond_declinedreason,
						other_loc=rc.other_loc,
						other_effectivedate=rc.other_effectivedate,
						other_expiredate=rc.other_expiredate,
						other_issuing_company=rc.other_issuing_company,
						other_dedret=rc.other_dedret,
						other_dedretamount=ReReplace(rc.other_dedretamount, "[^\d.]", "","ALL"),
						other_premium=ReReplace(rc.other_premium, "[^\d.]", "","ALL"),
						other_brokerfee=ReReplace(rc.other_brokerfee, "[^\d.]", "","ALL"),
						other_agencyfee=ReReplace(rc.other_agencyfee, "[^\d.]", "","ALL"),
						other_tax=ReReplace(rc.other_tax, "[^\d.]", "","ALL"),
						other_filingfee=ReReplace(rc.other_filingfee, "[^\d.]", "","ALL"),
						other_totalpremium=ReReplace(rc.other_totalpremium, "[^\d.]", "","ALL"),
						other_proposalnotes=rc.other_proposalnotes,
						wc_notes=rc.wc_notes,
						ue_notes=rc.ue_notes,
						epli_notes=rc.epli_notes,
						bond_notes=rc.bond_notes,
						other_notes=rc.other_notes,
						label_needed=rc.label_needed) />
						
			<cfset formStruct = getPageContext().getRequest().getParameterMap()>
			<!--- Get the Array length based on number of forms submitted --->
            <cfif isDefined('formStruct.name')>
			<cfset count = arrayLen(formStruct['name'])>
			<!--- name,title,cell,phone,fax,email --->
            
			<cfloop from="1" to="#count#" index="i">
				<cfif formStruct['name'][i] neq "">
					<cfif formStruct['contactid'][i] neq "">
						<!--- Update Contact --->
						<cfset temp=mainGW.updateClientContact(client_id=rc.client_id,
								contactid=#formStruct['contactid'][i]#,
								name=#formStruct['name'][i]#,
								phone=#formStruct['phone'][i]#,
								title=#formStruct['title'][i]#,
								cell=#formStruct['cell'][i]#,
								fax=#formStruct['fax'][i]#,
								email=#formStruct['email'][i]#) />
					<cfelse>
						<!--- New Contact --->
						<cfset temp=mainGW.addClientContact(client_id=rc.client_id,
								name=#formStruct['name'][i]#,
								phone=#formStruct['phone'][i]#,
								title=#formStruct['title'][i]#,
								cell=#formStruct['cell'][i]#,
								fax=#formStruct['fax'][i]#,
								email=#formStruct['email'][i]#) />
					</cfif>
				</cfif>
			</cfloop>
            </cfif>
			<cfset result="success">
		</cfif>
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />
	</cffunction> 
--->
	<cffunction name="addEditClient">
		<cfargument name="rc" type="any">
		<cfset var result="">
        <cfparam name="rc.current_effective_date" default="">
        <cfparam name="rc.ue_type" default="">
        <cfparam name="rc.ue_declined" default="0">
        <cfparam name="rc.ue_date1" default="">
        <cfparam name="rc.ue_date2" default="">
        <cfparam name="rc.epli_declined" default="0">
        <cfparam name="rc.epli_doincluded" default="0">
        <cfparam name="rc.wc_declined" default="0">
        <cfparam name="rc.bond_declined" default="0">
        <cfparam name="rc.label_needed" default="0">
        <cfparam name="rc.wc_additionalfeins" default="0">
        <cfparam name="rc.other_dedret" default="">
        <cfparam name="rc.epli_retrodate" default="">
        <cfparam name="rc.epli_prioracts" default="0">
        <cfparam name="rc.ue_terrorism_rejected" default="0">
        <!---save client data--->
        <cfset result1 = appGW.SaveData(rc,'clients',rc.client_id)>
        
				
					<!--- Get contacts as struct of arrays --->
					<cfset formStruct = getPageContext().getRequest().getParameterMap()>
					<!--- Get the Array length based on number of forms submitted --->
         <cfif structKeyExists(formStruct,"name")>
					<cfset count = arrayLen(formStruct['name'])>
					<!--- name,title,cell,phone,fax,email --->
					<cfloop from="1" to="#count#" index="i">
          <cfset rc2 = structNew()>
          <cfif formStruct['name'][i] neq "">
          <cfset rc2.contactid = formStruct['contactid'][i]>
          <cfset rc2.Name = formStruct['name'][i]>
          <cfset rc2.Phone = formStruct['phone'][i]>
          <cfset rc2.Title = formStruct['title'][i]>
          <cfset rc2.Cell = formStruct['cell'][i]>
          <cfset rc2.Fax = formStruct['fax'][i]>
          <cfset rc2.Email = formStruct['email'][i]>
          <cfset rc2.DeleteContact = formStruct['deletecontact'][i]>
          <cfset rc2.client_id = result1>
          <cfset rc2.contact_order = formStruct['contactorder'][i]>
						<cfif rc2.DeleteContact eq 1>
           <cfset result2 = mainGW.deleteContact(rc2.contactid)>
          <cfelse>
          <cfset checkDup = mainGW.checkDupContacts(rc2)>
					 <cfif not checkDup>
          <cfset result2 = appGW.SaveData(rc2,'client_contacts',rc2.contactid)>
          </cfif>
          </cfif>
						</cfif>
					</cfloop>

					</cfif>
          <cfif rc.client_id neq 0>
           <cfset result = "success">
           <cfelse>
           <cfset result = result1>
           </cfif>          
		<cfset rc.response = JSON.encode(result) />
		<cfset fw.setView('common.ajax') />
	</cffunction>   
	<cffunction name="deleteClient">
	</cffunction>
	<cffunction name="getClientGrid">
    	<cfargument name="rc" type="any">
        <cfparam name="rc.searchby" default="entity_name">
        <cfparam name="rc.searchbyother" default="Mailing Address">
        <cfparam name="rc.clientsearch" default="">
        <cfparam name="rc.search_en" default="0">
        <cfparam name="rc.search_dba" default="0">
        <cfparam name="rc.search_ni" default="0">
        <cfparam name="rc.search_cn" default="0">
        <cfparam name="rc.search_xref" default="0">
        <cfparam name="rc.search_status" default="2">
        <cfparam name="rc.exact" default="0">
		<cfset clients = mainGW.getClientGrid(rc.searchby,rc.searchbyother,rc.clientsearch,rc.search_en,rc.search_dba,rc.search_ni,rc.search_cn,rc.search_xref,rc.search_status,rc.exact) />
        <cfset numarray = ArrayNew(1)>
        <cfloop query="clients">
        <cfset numarray[clients.currentrow] = clients.currentrow>
        </cfloop>
        <cfset newquery = QueryAddColumn(clients, "rownumber", "Integer", numarray)>
		<cfset rc.response = JSON.encode(clients)>
        <cfset fw.setView('common.ajax')>
	</cffunction>
	<cffunction name="saveLiabilityPlan" access="public">
		<cfargument name="rc" type="any">
        
			<cfset var liability_plan_id = rc.liability_plan_id>
            <cfset var name = rc.name>
            
            <cfset var base_rate = rc.base_rate>
            <cfset var instructor_base = rc.instructor_base>
            <cfset var basketball_base = rc.basketball_base>
            <cfset var racquetball_base = rc.racquetball_base>
            <cfset var tennis_base = rc.tennis_base>
            <cfset var sauna_base = rc.sauna_base>
            <cfset var steam_room_base = rc.steam_room_base>
            <cfset var whirlpool_base = rc.whirlpool_base>
            <cfset var pools_base = rc.pools_base>
            <cfset var poolsoutdoor_base = rc.poolsoutdoor_base>
            <cfset var tanning_base = rc.tanning_base>
            <cfset var spray_tanning_base = rc.spray_tanning_base>
            <cfset var beauty_angels_base = rc.beauty_angels_base>
            <cfset var silver_sneakers_base = rc.silver_sneakers_base>
            <cfset var massage_base = rc.massage_base>
            <cfset var personal_trainers_base = rc.personal_trainers_base>
            <cfset var child_sitting_base = rc.child_sitting_base>
            <cfset var jungle_gym_base = rc.jungle_gym_base>
            <cfset var leased_space_base = rc.leased_space_base>
            <cfset var employeebenefits_base = rc.employeebenefits_base>
            <cfset var terrorism_minimum = rc.terrorism_minimum>
            <cfset var terrorism_fee = rc.terrorism_fee>
            <cfset var csl_each = rc.csl_each>
            <cfset var csl_aggregate = rc.csl_aggregate>
            <cfset var csl_products = rc.csl_products>
            <cfset var med_pay_per_person = rc.med_pay_per_person>
            <cfset var fire_damage_legal = rc.fire_damage_legal>
            <cfset var personal_advertising_injury = rc.personal_advertising_injury>
            <cfset var professional_liability = rc.professional_liability>
            <cfset var tanning_bed_liability = rc.tanning_bed_liability>
            <cfset var hired_auto_liability = rc.hired_auto_liability>
            <cfset var non_owned_auto_liability = rc.non_owned_auto_liability>
            <cfset var policy_deductible = rc.policy_deductible>
            <cfset var sex_abuse_occ = rc.sex_abuse_occ>
            <cfset var sex_abuse_agg = rc.sex_abuse_agg>
            <cfset var default_credit = rc.default_credit>
            <cfset var default_credit_label = rc.default_credit_label>
            <cfset var totalplans = rc.totalplans>
			 <cfparam name="rc.disabled" default="0">
       <cfparam name="rc.proposal_hide" default="0">
			<cfset planlist = "">
            <cfloop from="1" to="#totalplans#" index="i">
           
            <cfif isDefined("rc.check_#i#")>
			<cfset thischeck = rc["check_#i#"]>
            <cfset planlist = listappend(planlist, thischeck)>
            </cfif>
            </cfloop>
			<cfset logdata="#dateFormat(now(),'mm/dd/yyyy')#, TotalPlans: #totalplans#, planlist = #planlist#">
            <cffile action="append" file="c:/fields.txt" output="#logdata#">
		<cfset result = mainGW.saveGLPlan(liability_plan_id=liability_plan_id,
						name=name,
						disabled=rc.disabled,
						proposal_hide=rc.proposal_hide,
						base_rate=ReReplace(base_rate, "[^\d.]", "","ALL"),
						instructor_base=ReReplace(instructor_base, "[^\d.]", "","ALL"),
						basketball_base=ReReplace(basketball_base, "[^\d.]", "","ALL"),
						racquetball_base=ReReplace(racquetball_base, "[^\d.]", "","ALL"),
						tennis_base=ReReplace(tennis_base, "[^\d.]", "","ALL"),
						sauna_base=ReReplace(sauna_base, "[^\d.]", "","ALL"),
						steam_room_base=ReReplace(steam_room_base, "[^\d.]", "","ALL"),
						whirlpool_base=ReReplace(whirlpool_base, "[^\d.]", "","ALL"),
						pools_base=ReReplace(pools_base, "[^\d.]", "","ALL"),
						poolsoutdoor_base=ReReplace(poolsoutdoor_base, "[^\d.]", "","ALL"),
						tanning_base=ReReplace(tanning_base, "[^\d.]", "","ALL"),
						spray_tanning_base=ReReplace(spray_tanning_base, "[^\d.]", "","ALL"),
						beauty_angels_base=ReReplace(beauty_angels_base, "[^\d.]", "","ALL"),
						silver_sneakers_base=ReReplace(silver_sneakers_base, "[^\d.]", "","ALL"),
						massage_base=ReReplace(massage_base, "[^\d.]", "","ALL"),
						personal_trainers_base=ReReplace(personal_trainers_base, "[^\d.]", "","ALL"),
						child_sitting_base=ReReplace(child_sitting_base, "[^\d.]", "","ALL"),
						jungle_gym_base=ReReplace(jungle_gym_base, "[^\d.]", "","ALL"),
						leased_space_base=ReReplace(leased_space_base, "[^\d.]", "","ALL"),
						employeebenefits_base=ReReplace(employeebenefits_base, "[^\d.]", "","ALL"),
						terrorism_minimum=ReReplace(terrorism_minimum, "[^\d.]", "","ALL"),
						terrorism_fee=ReReplace(terrorism_fee, "[^\d.]", "","ALL"),
						csl_each=csl_each,
						csl_aggregate=csl_aggregate,
						csl_products=csl_products,
						med_pay_per_person=med_pay_per_person,
						fire_damage_legal=fire_damage_legal,
						personal_advertising_injury=personal_advertising_injury,
						professional_liability=professional_liability,
						tanning_bed_liability=tanning_bed_liability,
						hired_auto_liability=hired_auto_liability,
						non_owned_auto_liability=non_owned_auto_liability,
						policy_deductible=policy_deductible,
						sex_abuse_occ=sex_abuse_occ,
						sex_abuse_agg=sex_abuse_agg,
						default_credit=ReReplace(default_credit, "[^\d.]", "","ALL"),
						default_credit_label=default_credit_label,
						planlist=planlist) />
		<cfset rc.response = JSON.encode(result) />            
		<cfset fw.setView('common.ajax') />	
	</cffunction> 
	    
<!--- Ratings --->
	<cffunction name="ratings" access="public" output="yes">
		<cfargument name="rc" type="any">
    <cfparam name="rc.client_id" default="0">
    <cfparam name="rc.application_id" default = '0'>
    <cfparam name = "rc.endorseAlert" default="0">
    <cfset rc.issuing = mainGW.getCompanyAccordion()>
    <cfset rc.issuingprop = mainGW.getCompanyAccordion()>
    <cfset rc.glplans = mainGW.getClientGLPlans(0,rc.client_id,0)>
    <cfset rc.propplans = mainGW.getPropertyPlans(0,0)>
    <cfset rc.cyber = mainGW.getCyberLiability(0,0)>
    <cfset rc.empdis = mainGW.getEmployeeDishonesty(0,0)>
    <cfset rc.cinfo = mainGW.getCinfo(location_id=rc.location_id)>
    <cfset rc.liability_expos = mainGW.getLiabilityExpos(application_id=rc.application_id)>
    <cfset rc.property_limits = mainGW.getPropLimits(application_id=rc.application_id)>

        <cfset rc.totalrpg = mainGW.totalRPG(rc.client_id)>       
        <cfset rc.title = "Rating - New">
        
            <cfif isDefined("rc.endorse") AND rc.endorse is 1>
            	<cfset rc.eform = mainGW.getRating(ratingid=rc.oldratingid)>
            </cfif>         
        
		<cfif rc.application_id neq 0>
			<!--- <cfset rc.liability_expos = mainGW.getLiabilityExpos(application_id=rc.application_id)> --->
            <cfset rc.yesno = mainGW.getYesNo(rc.application_id)>
		</cfif>
		<cfif rc.ratingid neq 0>
			<cfset rc.rform = mainGW.getRating(ratingid=rc.ratingid)>
    

			<cfset rc.expother = mainGW.getExpOther(rating_liability_id=rc.rform.rating_liability_id)>
			<cfset rc.debit = mainGW.getDebitCredit(rating_liability_id=rc.rform.rating_liability_id,debtcredit_type=1)>
            <cfset rc.credit = mainGW.getDebitCredit(rating_liability_id=rc.rform.rating_liability_id,debtcredit_type=2)>
			<cfset rc.otherprop = mainGW.getRatingPropertyOther(rating_property_id=rc.rform.rating_property_id)>
			<cfset rc.eb = mainGW.getEB(rating_property_id=rc.rform.rating_property_id)>
            <!---check for any endorsements--->
            <cfset rc.checkEndorsement = mainGW.checkEndorsement(rc.ratingid)>
            
            <cfif rc.checkEndorsement.recordcount>
            	<cfif rc.checkEndorsement.gldate1 gt rc.rform.gldate1>
                	<cfset rc.endorseAlert = 1>
                
                </cfif>    
            </cfif>   
			<cfif isDefined("rc.summary") AND rc.summary is "b">
            <cfset rc.title = "Carrier Summary - #rc.cinfo.named_insured#">
            <cfelseif isDefined("rc.summary") AND rc.summary is "a">
            <cfset rc.title = "Agency Summary - #rc.cinfo.named_insured#">
            <cfelse>
            <cfset rc.title = "Rating - #rc.cinfo.named_insured#">
            </cfif>             
            
		</cfif>
	</cffunction>  
      
	<cffunction name="getRatingHistory" access="public">
		<cfargument name="rc" type="any">
		<cfset history = mainGW.getRatingHistory(rc=rc)>
		<cfset rc.response = JSON.encode(history)>
        <cfset fw.setView('common.ajax')>
	</cffunction>
	<cffunction name="getOtherExp" access="public">
    <cfargument name="rc" type="any">
		<cfparam name="rc.rating_liability_id" default="0">
		<cfset data = mainGW.getExpOther(rating_liability_id=rc.rating_liability_id)>
		<cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction>
	<cffunction name="getDebit" access="public">
    <cfargument name="rc" type="any">    
  	<cfparam name="rc.rating_liability_id" default="0">
		<cfset data = mainGW.getDebitCredit(rating_liability_id=rc.rating_liability_id,debtcredit_type=1)>
		<cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction>        
	<cffunction name="getCredit" access="public">
    <cfargument name="rc" type="any">    
  	<cfparam name="rc.rating_liability_id" default="0">
		<cfset data = mainGW.getDebitCredit(rating_liability_id=rc.rating_liability_id,debtcredit_type=2)>
		<cfset rc.response = JSON.encode(data)>
        <cfset fw.setView('common.ajax')>
	</cffunction> 
	<cffunction name="addEditRatings" access="public" output="true">
		<cfargument name="rc" type="any">
    	
		<cfset var result = StructNew() />
    <!---list of fields to NOT strip out special characters--->
		<cfset exlist = "gldate1,gldate2,gldate3,gldate4,underwriting_notes,yesnoquestions,propdate1,propdate2,prop_underwritingnotes,prop_yesnoquestionsnew_creditname,new_debitname,default_credit_label,premium_mod_label,liability_propnotes,property_propnotes,historynotes,prop_winddeductable,prop_coinsurancelabel,custom_tax_1_label,custom_tax_2_label,custom_tax_3_label,custom_tax_4_label,custom_tax_5_label">
    <!---loop through and strip out non numeric characters, be sure to add any text fields to exlist above--->
		<cfloop collection="#rc#" item="key">

			<cfif not listfindnocase(exlist,#key#)>
				<cfset temp = StructUpdate(rc, #key#, ReReplace(#rc[key]#,"[^\d.]", "","ALL"))>

				<cfif #rc[key]# eq ''>
        <!---#key# = #rc[key]# will be removed<br>--->
					<cfset temp2 = StructUpdate(rc, #key#, returnNull())>
				</cfif>
			</cfif>
      
		</cfloop>

		
		<cfparam name="rc.ratingid" default="0">
		<cfparam name="rc.location_id" default="0">
		<cfparam name="rc.application_id" default="0">
		<cfparam name="rc.liability_plan_id" default="0">
		<cfparam name="rc.property_plan_id" default="0">
		<cfparam name="rc.gl_issuing_company_id" default="0">
		<cfparam name="rc.property_issuing_company_id" default="0">
		<cfparam name="rc.square_footage" default="0">
		<cfparam name="rc.gross_receipts" default="0">
		<cfparam name="rc.excl_proposal" default="0">
		<cfparam name="rc.gl_deductable" default="0">
		<cfparam name="rc.base_rate_annual" default="0">
		<cfparam name="rc.instructors_expo" default="0">
		<cfparam name="rc.instructors_base" default="0">
		<cfparam name="rc.instructors_annual" default="0">
		<cfparam name="rc.basketball_expo" default="0">
		<cfparam name="rc.basketball_base" default="0">
		<cfparam name="rc.basketball_annual" default="0">
		<cfparam name="rc.rt_courts_expo" default="0">
		<cfparam name="rc.rt_courts_base" default="0">
		<cfparam name="rc.rt_courts_annual" default="0">
		<cfparam name="rc.tennis_courts_expo" default="0">
		<cfparam name="rc.tennis_courts_base" default="0">
		<cfparam name="rc.tennis_courts_annual" default="0">
		<cfparam name="rc.sauna_expo" default="0">
		<cfparam name="rc.sauna_base" default="0">
		<cfparam name="rc.sauna_annual" default="0">
		<cfparam name="rc.steamroom_expo" default="0">
		<cfparam name="rc.steamroom_base" default="0">
		<cfparam name="rc.steamroom_annual" default="0">
		<cfparam name="rc.whirlpool_expo" default="0">
		<cfparam name="rc.whirlpool_base" default="0">
		<cfparam name="rc.whirlpool_annual" default="0">
		<cfparam name="rc.pools_expo" default="0">
		<cfparam name="rc.pools_base" default="0">
		<cfparam name="rc.pools_annual" default="0">
		<cfparam name="rc.poolsoutdoor_expo" default="0">
		<cfparam name="rc.poolsoutdoor_base" default="0">
		<cfparam name="rc.poolsoutdoor_annual" default="0">
		<cfparam name="rc.tanning_expo" default="0">
		<cfparam name="rc.tanning_base" default="0">
		<cfparam name="rc.tanning_annual" default="0">
		<cfparam name="rc.spraytanning_expo" default="0">
		<cfparam name="rc.spraytanning_base" default="0">
		<cfparam name="rc.spraytanning_annual" default="0">
		<cfparam name="rc.beautyangels_expo" default="0">
		<cfparam name="rc.beautyangels_base" default="0">
		<cfparam name="rc.beautyangels_annual" default="0">
		<cfparam name="rc.silversneakers_expo" default="0">
		<cfparam name="rc.silversneakers_base" default="0">
		<cfparam name="rc.silversneakers_annual" default="0">
		<cfparam name="rc.massage_expo" default="0">
		<cfparam name="rc.massage_base" default="0">
		<cfparam name="rc.massage_annual" default="0">
		<cfparam name="rc.pt_expo" default="0">
		<cfparam name="rc.pt_base" default="0">
		<cfparam name="rc.pt_annual" default="0">
		<cfparam name="rc.childsitting_expo" default="0">
		<cfparam name="rc.childsitting_base" default="0">
		<cfparam name="rc.childsitting_annual" default="0">
		<cfparam name="rc.junglegym_expo" default="0">
		<cfparam name="rc.junglegym_base" default="0">
		<cfparam name="rc.junglegym_annual" default="0">
		<cfparam name="rc.leasedspace_expo" default="0">
		<cfparam name="rc.leasedspace_base" default="0">
		<cfparam name="rc.leasedspace_annual" default="0">
		<cfparam name="rc.employeebenefits_expo" default="0">
		<cfparam name="rc.employeebenefits_base" default="0">
		<cfparam name="rc.employeebenefits_annual" default="0">    
    <cfparam name="rc.silversneakers_override" default="0">
    <cfparam name="rc.pt_override" default="0">
    <cfparam name="rc.junglegym_override" default="0">
    <cfparam name="rc.leasedspace_override" default="0">
    <cfparam name="rc.employeebenefits_override" default="0">
    <cfparam name="rc.massage_override" default="0">
		<cfparam name="rc.total_annual" default="0">
		<cfparam name="rc.total_debits" default="0">
		<cfparam name="rc.loc_annual_premium" default="0">
		<cfparam name="rc.pro_rata_gl" default="0">
		<cfparam name="rc.use_prorata" default="0">
		<cfparam name="rc.broker_override" default="0">
		<cfparam name="rc.brokerfee" default="0">
		<cfparam name="rc.broker_flatpercent" default="0">
		<cfparam name="rc.broker_percentoverride" default="0">
		<cfparam name="rc.broker_flatpercent" default="0">
		<cfparam name="rc.surplustax" default="0">
		<cfparam name="rc.inspectionfee" default="0">
		<cfparam name="rc.terrorism_rejected" default="0">
		<cfparam name="rc.terrorism_fee" default="0">
		<cfparam name="rc.stampingfee" default="0">
		<cfparam name="rc.filingfee" default="0">
		<cfparam name="rc.statecharge" default="0">
		<cfparam name="rc.rpgfee" default="0">
		<cfparam name="rc.rpgall" default="0">
		<cfparam name="rc.grandtotal" default="0">
		<cfparam name="rc.gl_prorate" default="0">
		<cfparam name="rc.underwriting_notes" default="0">
		<cfparam name="rc.yesnoquestions" default="">
		<cfparam name="rc.prop_deductible" default="0">
		<cfparam name="rc.prop_exclwind" default="0">
		<cfparam name="rc.prop_buildingrate" default="0">
		<cfparam name="rc.prop_buildinglimit" default="0">
		<cfparam name="rc.prop_buildingpremium" default="0">
		<cfparam name="rc.prop_bpprate" default="0">
		<cfparam name="rc.prop_bpplimit" default="0">
		<cfparam name="rc.prop_bpppremium" default="0">
		<cfparam name="rc.prop_tirate" default="0">
		<cfparam name="rc.prop_tilimit" default="0">
		<cfparam name="rc.prop_tipremium" default="0">
		<cfparam name="rc.prop_90" default="0">
		<cfparam name="rc.prop_bieerate" default="0">
		<cfparam name="rc.prop_bieelimit" default="0">
		<cfparam name="rc.prop_bieepremium" default="0">
		<cfparam name="rc.prop_daysdeductible" default="0">
		<cfparam name="rc.prop_edprate" default="0">
		<cfparam name="rc.prop_edplimit" default="0">
		<cfparam name="rc.prop_edppremium" default="0">
		<cfparam name="rc.prop_hvacrate" default="0">
		<cfparam name="rc.prop_hvaclimit" default="0">
		<cfparam name="rc.prop_hvacpremium" default="0">
		<cfparam name="rc.prop_signrate" default="0">
		<cfparam name="rc.prop_signlimit" default="0">
		<cfparam name="rc.prop_signpremium" default="0">
		<cfparam name="rc.prop_equipbreakrate" default="0">
		<cfparam name="rc.prop_equipbreaktotal" default="0">
		<cfparam name="rc.prop_equipbreakpremium" default="0">
		<cfparam name="rc.employee_dishonesty_id" default="0">
		<cfparam name="rc.property_emp_amount" default="0">
		<cfparam name="rc.cyber_liability_amount_id" default="0">
		<cfparam name="rc.property_cyber_amount" default="0">
		<cfparam name="rc.prop_floodrate" default="0">
		<cfparam name="rc.prop_floodlimit" default="0">
		<cfparam name="rc.prop_floodpremium" default="0">
		<cfparam name="rc.prop_flooddeduct" default="0">
		<cfparam name="rc.prop_quakerate" default="0">
		<cfparam name="rc.prop_quakelimit" default="0">
		<cfparam name="rc.prop_quakepremium" default="0">
		<cfparam name="rc.prop_quakededuct" default="0">
		<cfparam name="rc.premium_override" default="0">
		<cfparam name="rc.prop_ratedpremium" default="0">
		<cfparam name="rc.prop_chargedpremium" default="0">
    <cfparam name="rc.prop_taxoverride" default="0">
		<cfparam name="rc.prop_taxes" default="0">
		<cfparam name="rc.prop_use_prorata" default="0">
		<cfparam name="rc.prop_agencyfee" default="0">
    <cfparam name="rc.prop_agencyfeeoverride" default="0">
		<cfparam name="rc.prop_agencyamount" default="0">
    <cfparam name="rc.prop_brokerfee" default="0">
		<cfparam name="rc.prop_terrorism_rejected" default="0">
		<cfparam name="rc.prop_terrorism" default="0">
		<cfparam name="rc.prop_grandtotal" default="0">
		<cfparam name="rc.propdate1" default="0">
		<cfparam name="rc.propdate2" default="0">
		<cfparam name="rc.prop_prorate" default="0">
		<cfparam name="rc.prop_underwritingnotes" default="0">
		<cfparam name="rc.prop_yesnoquestions" default="">
		<cfparam name="rc.gldate1" default="0">
		<cfparam name="rc.gldate2" default="0">
		<cfparam name="rc.history" default="0">
    <cfparam name="rc.endorse" default="0">
    <cfparam name="rc.total_debitspercent" default="0">
    <cfparam name="rc.premium_mod" default="0">
    <cfparam name="rc.final_mod" default="0">
    <cfparam name="rc.premium_mod_label" default="">
    <cfparam name="rc.inspection_override" default="0">
    <cfparam name="rc.rpg_override" default="0">
    <cfparam name="rc.base_override" default="0">
    <cfparam name="rc.statemuni_override" default="0">
    <cfparam name="rc.stamping_override" default="0">	
    <cfparam name="rc.filing_override" default="0">	
    <cfparam name="rc.prop_subtotal" default="0">	
    <cfparam name="rc.property_propnotes" default="">	
 
    <!---save main rating first, redefining rc.ratingid in case it is new so it will pass new id to liability and property update --->
		<cfset rc.ratingid = appGW.SaveData(rc,'rating',rc.ratingid)>
    <cfset rc.rating_liability_id = appGW.SaveData(rc,'rating_liability',rc.rating_liability_id)> 
    <cfset rc.rating_property_id = appGW.SaveData(rc,'rating_property',rc.rating_property_id)>  
    <!--- Add Other Exposures, Debits and Credits, Property Perils, etc --->
		<cfset formStruct = getPageContext().getRequest().getParameterMap()>
    <cfset updateExpoDebitsEtc(formStruct,rc.rating_liability_id)>
    <cfset updateOtherPropPerils(formStruct,rc.rating_property_id)>  
    <!---get mapped corresponding liability fields in app---> 
    <cfset syncRC = appGW.appRatingSync(rc=rc,syncWith='applications')>
    <!--- update app--->
    <cfset appSync = appGW.SaveData(syncRc,'applications',rc.application_id)>
    <cfset result.ratingid = rc.ratingid >
    <cfset result.rating_liability_id=rc.rating_liability_id>
    <cfset result.rating_property_id = rc.rating_property_id>
    <cfset locSync = appGW.ratingLocSync(excl=rc.excl_proposal,syncWith='locations',id=rc.location_id)>
    
    <cfset rc.response = JSON.encode(result)>
    <cfset fw.setView('common.ajax')>
  
	</cffunction>  
<!---	<cffunction name="addEditRatings" access="public" returntype="void" output="true">
		<cfargument name="rc" type="any">
    
		<cfset var result = StructNew() />
		<cfset exlist = "gldate1,gldate2,gldate3,gldate4,underwriting_notes,yesnoquestions,propdate1,propdate2,prop_underwritingnotes,prop_yesnoquestionsnew_creditname,new_debitname,default_credit_label,premium_mod_label,liability_propnotes,property_propnotes">
    <!---loop through and strip out non numeric characters, be sure to add any text fields to exlist above--->
		<cfloop collection="#rc#" item="key">

			<cfif not listfindnocase(exlist,#key#)>
				<cfset temp = StructUpdate(rc, #key#, ReReplace(#rc[key]#,"[^\d.]", "","ALL"))>

				<cfif #rc[key]# eq ''>
        <!---#key# = #rc[key]# will be removed<br>--->
					<cfset temp2 = StructUpdate(rc, #key#, returnNull())>
				</cfif>
			</cfif>
      
		</cfloop>
	
		
		<cfparam name="rc.ratingid" default="0">
		<cfparam name="rc.location_id" default="0">
		<cfparam name="rc.application_id" default="0">
		<cfparam name="rc.liability_plan_id" default="0">
		<cfparam name="rc.property_plan_id" default="0">
		<cfparam name="rc.gl_issuing_company_id" default="0">
		<cfparam name="rc.property_issuing_company_id" default="0">
		<cfparam name="rc.square_footage" default="0">
		<cfparam name="rc.gross_receipts" default="0">
		<cfparam name="rc.excl_proposal" default="0">
		<cfparam name="rc.gl_deductable" default="0">
		<cfparam name="rc.base_rate_annual" default="0">
		<cfparam name="rc.instructors_expo" default="0">
		<cfparam name="rc.instructors_base" default="0">
		<cfparam name="rc.instructors_annual" default="0">
		<cfparam name="rc.basketball_expo" default="0">
		<cfparam name="rc.basketball_base" default="0">
		<cfparam name="rc.basketball_annual" default="0">
		<cfparam name="rc.rt_courts_expo" default="0">
		<cfparam name="rc.rt_courts_base" default="0">
		<cfparam name="rc.rt_courts_annual" default="0">
		<cfparam name="rc.tennis_courts_expo" default="0">
		<cfparam name="rc.tennis_courts_base" default="0">
		<cfparam name="rc.tennis_courts_annual" default="0">
		<cfparam name="rc.sauna_expo" default="0">
		<cfparam name="rc.sauna_base" default="0">
		<cfparam name="rc.sauna_annual" default="0">
		<cfparam name="rc.steamroom_expo" default="0">
		<cfparam name="rc.steamroom_base" default="0">
		<cfparam name="rc.steamroom_annual" default="0">
		<cfparam name="rc.whirlpool_expo" default="0">
		<cfparam name="rc.whirlpool_base" default="0">
		<cfparam name="rc.whirlpool_annual" default="0">
		<cfparam name="rc.pools_expo" default="0">
		<cfparam name="rc.pools_base" default="0">
		<cfparam name="rc.pools_annual" default="0">
		<cfparam name="rc.poolsoutdoor_expo" default="0">
		<cfparam name="rc.poolsoutdoor_base" default="0">
		<cfparam name="rc.poolsoutdoor_annual" default="0">
		<cfparam name="rc.tanning_expo" default="0">
		<cfparam name="rc.tanning_base" default="0">
		<cfparam name="rc.tanning_annual" default="0">
		<cfparam name="rc.spraytanning_expo" default="0">
		<cfparam name="rc.spraytanning_base" default="0">
		<cfparam name="rc.spraytanning_annual" default="0">
		<cfparam name="rc.beautyangels_expo" default="0">
		<cfparam name="rc.beautyangels_base" default="0">
		<cfparam name="rc.beautyangels_annual" default="0">
		<cfparam name="rc.silversneakers_expo" default="0">
		<cfparam name="rc.silversneakers_base" default="0">
		<cfparam name="rc.silversneakers_annual" default="0">
		<cfparam name="rc.massage_expo" default="0">
		<cfparam name="rc.massage_base" default="0">
		<cfparam name="rc.massage_annual" default="0">
		<cfparam name="rc.pt_expo" default="0">
		<cfparam name="rc.pt_base" default="0">
		<cfparam name="rc.pt_annual" default="0">
		<cfparam name="rc.childsitting_expo" default="0">
		<cfparam name="rc.childsitting_base" default="0">
		<cfparam name="rc.childsitting_annual" default="0">
		<cfparam name="rc.junglegym_expo" default="0">
		<cfparam name="rc.junglegym_base" default="0">
		<cfparam name="rc.junglegym_annual" default="0">
		<cfparam name="rc.leasedspace_expo" default="0">
		<cfparam name="rc.leasedspace_base" default="0">
		<cfparam name="rc.leasedspace_annual" default="0">
		<cfparam name="rc.employeebenefits_expo" default="0">
		<cfparam name="rc.employeebenefits_base" default="0">
		<cfparam name="rc.employeebenefits_annual" default="0">    
    <cfparam name="rc.silversneakers_override" default="0">
    <cfparam name="rc.pt_override" default="0">
    <cfparam name="rc.junglegym_override" default="0">
    <cfparam name="rc.leasedspace_override" default="0">
    <cfparam name="rc.employeebenefits_override" default="0">
    <cfparam name="rc.massage_override" default="0">
		<cfparam name="rc.total_annual" default="0">
		<cfparam name="rc.total_debits" default="0">
		<cfparam name="rc.loc_annual_premium" default="0">
		<cfparam name="rc.pro_rata_gl" default="0">
		<cfparam name="rc.use_prorata" default="0">
		<cfparam name="rc.broker_override" default="0">
		<cfparam name="rc.brokerfee" default="0">
		<cfparam name="rc.broker_flatpercent" default="0">
		<cfparam name="rc.broker_percentoverride" default="0">
		<cfparam name="rc.broker_flatpercent" default="0">
		<cfparam name="rc.surplustax" default="0">
		<cfparam name="rc.inspectionfee" default="0">
		<cfparam name="rc.terrorism_rejected" default="0">
		<cfparam name="rc.terrorism_fee" default="0">
		<cfparam name="rc.stampingfee" default="0">
		<cfparam name="rc.filingfee" default="0">
		<cfparam name="rc.statecharge" default="0">
		<cfparam name="rc.rpgfee" default="0">
		<cfparam name="rc.rpgall" default="0">
		<cfparam name="rc.grandtotal" default="0">
		<cfparam name="rc.gl_prorate" default="0">
		<cfparam name="rc.underwriting_notes" default="0">
		<cfparam name="rc.yesnoquestions" default="">
		<cfparam name="rc.prop_deductible" default="0">
		<cfparam name="rc.prop_exclwind" default="0">
		<cfparam name="rc.prop_winddeductable" default="0">
		<cfparam name="rc.prop_buildingrate" default="0">
		<cfparam name="rc.prop_buildinglimit" default="0">
		<cfparam name="rc.prop_buildingpremium" default="0">
		<cfparam name="rc.prop_bpprate" default="0">
		<cfparam name="rc.prop_bpplimit" default="0">
		<cfparam name="rc.prop_bpppremium" default="0">
		<cfparam name="rc.prop_tirate" default="0">
		<cfparam name="rc.prop_tilimit" default="0">
		<cfparam name="rc.prop_tipremium" default="0">
		<cfparam name="rc.prop_90" default="0">
		<cfparam name="rc.prop_bieerate" default="0">
		<cfparam name="rc.prop_bieelimit" default="0">
		<cfparam name="rc.prop_bieepremium" default="0">
		<cfparam name="rc.prop_daysdeductible" default="0">
		<cfparam name="rc.prop_edprate" default="0">
		<cfparam name="rc.prop_edplimit" default="0">
		<cfparam name="rc.prop_edppremium" default="0">
		<cfparam name="rc.prop_hvacrate" default="0">
		<cfparam name="rc.prop_hvaclimit" default="0">
		<cfparam name="rc.prop_hvacpremium" default="0">
		<cfparam name="rc.prop_signrate" default="0">
		<cfparam name="rc.prop_signlimit" default="0">
		<cfparam name="rc.prop_signpremium" default="0">
		<cfparam name="rc.prop_equipbreakrate" default="0">
		<cfparam name="rc.prop_equipbreaktotal" default="0">
		<cfparam name="rc.prop_equipbreakpremium" default="0">
		<cfparam name="rc.employee_dishonesty_id" default="0">
		<cfparam name="rc.property_emp_amount" default="0">
		<cfparam name="rc.cyber_liability_amount_id" default="0">
		<cfparam name="rc.property_cyber_amount" default="0">
		<cfparam name="rc.prop_floodrate" default="0">
		<cfparam name="rc.prop_floodlimit" default="0">
		<cfparam name="rc.prop_floodpremium" default="0">
		<cfparam name="rc.prop_flooddeduct" default="0">
		<cfparam name="rc.prop_quakerate" default="0">
		<cfparam name="rc.prop_quakelimit" default="0">
		<cfparam name="rc.prop_quakepremium" default="0">
		<cfparam name="rc.prop_quakededuct" default="0">
		<cfparam name="rc.premium_override" default="0">
		<cfparam name="rc.prop_ratedpremium" default="0">
		<cfparam name="rc.prop_chargedpremium" default="0">
    <cfparam name="rc.prop_taxoverride" default="0">
		<cfparam name="rc.prop_taxes" default="0">
		<cfparam name="rc.prop_use_prorata" default="0">
		<cfparam name="rc.prop_agencyfee" default="0">
    <cfparam name="rc.prop_agencyfeeoverride" default="0">
		<cfparam name="rc.prop_agencyamount" default="0">
		<cfparam name="rc.prop_terrorism_rejected" default="0">
		<cfparam name="rc.prop_terrorism" default="0">
		<cfparam name="rc.prop_grandtotal" default="0">
		<cfparam name="rc.propdate1" default="0">
		<cfparam name="rc.propdate2" default="0">
		<cfparam name="rc.prop_prorate" default="0">
		<cfparam name="rc.prop_underwritingnotes" default="0">
		<cfparam name="rc.prop_yesnoquestions" default="">
		<cfparam name="rc.gldate1" default="0">
		<cfparam name="rc.gldate2" default="0">
		<cfparam name="rc.history" default="0">
        <cfparam name="rc.endorse" default="0">
        <cfparam name="rc.total_debitspercent" default="0">
        <cfparam name="rc.premium_mod" default="0">
        <cfparam name="rc.final_mod" default="0">
        <cfparam name="rc.premium_mod_label" default="">
        <cfparam name="rc.inspection_override" default="0">
        <cfparam name="rc.rpg_override" default="0">
        <cfparam name="rc.base_override" default="0">
        <cfparam name="rc.statemuni_override" default="0">
        <cfparam name="rc.filing_override" default="0">	
        <cfparam name="rc.prop_subtotal" default="0">	
        <cfparam name="rc.property_propnotes" default="">	
        
		<!--- If RATING ID ZERO OR NEW HISTORY SNAPSHOT--->
		<cfif rc.ratingid eq 0 or rc.history eq 1>

			<!---  the application first --->
			<cfset app = mainGW.editApplication(application_id=rc.application_id
			,client_id=rc.client_id
			,location_id=rc.location_id
			,number_trainers =rc.instructors_expo
			,court_basketball=rc.basketball_expo
			,court_racquetball=rc.rt_courts_expo
			,court_tennis=rc.tennis_courts_expo
			,sauna=rc.sauna_expo
			,steam_room=rc.steamroom_expo
			,whirlpool=rc.whirlpool_expo
			,pool_indoor=rc.pools_expo
			,pool_outdoor=rc.poolsoutdoor_expo
			,beds_tanning=rc.tanning_expo
			,beds_spray=rc.spraytanning_expo
			,beauty_angel=rc.beautyangels_expo
			,silver_sneakers=rc.silversneakers_expo
			,massage=rc.massage_expo
			,leased_space=rc.leasedspace_expo
			,employee_benefits=rc.employeebenefits_expo				
			,personal_trainers=rc.pt_expo
			,number_children=rc.childsitting_expo
			,play_apparatus = rc.junglegym_expo
			,gross_receipts=rc.gross_receipts
			,square_ft=square_footage
			,notes=rc.yesnoquestions)>
			<cfif app eq 1>
				<!--- Build New Rating, get the ID --->
				<cfset rating = mainGW.addEditRating(application_id=rc.application_id
				 ,location_id = rc.location_id
			      ,liability_plan_id = rc.liability_plan_id
			      ,property_plan_id = rc.property_plan_id
			      ,square_footage = rc.square_footage
			      ,gross_receipts = REReplace(rc.gross_receipts,"[^\d.]", "","ALL")
			      ,excl_proposal = rc.excl_proposal
			      ,gl_issuing_company_id = rc.gl_issuing_company_id
			      ,property_issuing_company_id = rc.property_issuing_company_id
			      ,endorsement_id = 0
			      ,history=rc.history
				  ,endorse=rc.endorse)>
			    
				<!--- Add Liability  get @@Identity--->
				<cfset liability = mainGW.addRatingLiability(ratingid = rating,rc=rc)>
				<!--- Add Other Exposures --->
				<cfset formStruct = getPageContext().getRequest().getParameterMap()>
                <cfset addExpoDebitsEtc(formStruct,rc.rating_liability_id)>
       
				<!--- Add Property get @@Identity --->
				<cfset property = mainGW.addRatingProperty(ratingid = rating,rc=rc)>
				
				<cfif structkeyexists(formStruct,"newpropfield1")>
				<!--- Add Other Properties --->
				<cfset count = arrayLen(formStruct['newpropfield1'])>
					<!--- do the columns --->
					<cfloop from="1" to="#count#" index="i">
						
						<cfif formStruct['newpropfield1'][i] neq "">
								<!--- New Other Prop --->
								<cfset tempprop=mainGW.addratingpropertyother(rating_property_id=property,
										other_title=#formStruct['newpropfield1'][i]#
										,other_rate=#formStruct['newpropfield2'][i]#
								        ,other_limit=#formStruct['newpropfield3'][i]#
								        ,other_premium=#formStruct['newpropfield4'][i]#) />
						</cfif>
					</cfloop>
				</cfif>
					<!--- Add Other EB --->
				<cfif structkeyexists(formStruct,"newperil_name")>	
					<cfset count = arrayLen(formStruct['newperil_name'])>
					<!--- do the columns --->
					<cfloop from="1" to="#count#" index="i">
						
						<cfif formStruct['newperil_name'][i] neq "">
								<!--- New Other Prop --->
								<cfset tempprop=mainGW.addEb(rating_property_id=property,
										eb_title=#formStruct['newperil_name'][i]#
										,eb_rate=#formStruct['newperil_rate'][i]#
								        ,eb_limit=#formStruct['newperil_limit'][i]#
								        ,eb_premium=#formStruct['newperil_premium'][i]#
								        ,eb_deductible=#formStruct['eb_deduct'][i]#) />
						</cfif>
					</cfloop>
				</cfif>
				<!--- Update the main rating table with liability and property ID's --->
				<cfset final = mainGW.updateRating(ratingid = rating,rating_liability_id=liability,rating_property_id=property)>
				<!--- Update Application values --->
				<cfset result.ratingid = rating>
				<cfset result.rating_liability_id = liability>
				<cfset result.rating_property_id = property>
			<cfelse>
				<cfset result = 'false'>
			</cfif>
		<cfset rc.response = JSON.encode(result)>
        <cfset fw.setView('common.ajax')>
			
		<cfelse>
		<!--- UPDATE ONLY/NOT HISTORY --->
			<!--- UPDATE Liability and Property Records/ Update Rating Table --->
			<!--- Update Application values --->
			<!---  the application first --->
			<cfset app = mainGW.editApplication(application_id=rc.application_id
			,client_id=rc.client_id
			,location_id=rc.location_id
			,number_trainers =rc.instructors_expo
			,court_basketball=rc.basketball_expo
			,court_racquetball=rc.rt_courts_expo
			,court_tennis=rc.tennis_courts_expo
			,sauna=rc.sauna_expo
			,steam_room=rc.steamroom_expo
			,whirlpool=rc.whirlpool_expo
			,pool_indoor=rc.pools_expo
			,pool_outdoor=rc.poolsoutdoor_expo
			,beds_tanning=rc.tanning_expo
			,beds_spray=rc.spraytanning_expo
			,beauty_angel=rc.beautyangels_expo
			,silver_sneakers=rc.silversneakers_expo
			,massage=rc.massage_expo
			,personal_trainers=rc.pt_expo
			,number_children=rc.childsitting_expo
			,play_apparatus = rc.junglegym_expo
			,gross_receipts=rc.gross_receipts
			,square_ft=square_footage
			,notes=rc.yesnoquestions)>
			<cfif app eq 1>
				<!--- Update existing Rating --->
				<cfset rating = mainGW.addEditRating(ratingid=rc.ratingid
				,application_id=rc.application_id
				 ,location_id = rc.location_id
			      ,liability_plan_id = rc.liability_plan_id
			      ,property_plan_id = rc.property_plan_id
			      ,square_footage = rc.square_footage
			      ,gross_receipts = REReplace(rc.gross_receipts,"[^\d.]", "","ALL")
			      ,excl_proposal = rc.excl_proposal
			      ,gl_issuing_company_id = rc.gl_issuing_company_id
			      ,property_issuing_company_id = rc.property_issuing_company_id
			      ,rating_liability_id=rc.rating_liability_id
			      ,rating_property_id=rc.rating_property_id
			      ,endorsement_id = 0
			      ,history=0)>
			    
				<!--- Add Liability  get @@Identity--->
				<cfset liability = mainGW.editRatingLiability(ratingid = rc.ratingid,rc=rc)>
        
				<!--- Add Other Exposures --->
				<cfset formStruct = getPageContext().getRequest().getParameterMap()>
        
                <cfset updateEDC = updateExpoDebitsEtc(formStruct,rc.rating_liability_id)>

				<!--- Add Property get @@Identity --->
				<cfset property = mainGW.editRatingProperty(ratingid = rc.ratingid,rc=rc)>
				
				<!--- Other Properties --->
			<cfif structkeyexists(formStruct,"newpropfield1")>
				<cfset count = arrayLen(formStruct['newpropfield1'])>
					<!--- do the columns --->
					<cfloop from="1" to="#count#" index="i">
						<cfif formStruct['newpropfield1'][i] neq "">
						
							<cfif formStruct['other_property_id'][i] neq "">
								<!--- Update debt --->
								<cfset tempprop=mainGW.editratingpropertyother(other_property_id=#formStruct['other_property_id'][i]#
										,other_title=#formStruct['newpropfield1'][i]#
										,other_rate=#formStruct['newpropfield2'][i]#
								        ,other_limit=#formStruct['newpropfield3'][i]#
								        ,other_premium=#formStruct['newpropfield4'][i]#) />
							<cfelse>
								<!--- New Other Prop --->
								<cfset tempprop=mainGW.addratingpropertyother(rating_property_id=rc.rating_property_id
										,other_title=#formStruct['newpropfield1'][i]#
										,other_rate=#formStruct['newpropfield2'][i]#
								        ,other_limit=#formStruct['newpropfield3'][i]#
								        ,other_premium=#formStruct['newpropfield4'][i]#) />
							</cfif>
						</cfif>
					</cfloop>
				</cfif>
					<!--- Other EB --->
				<cfif structkeyexists(formStruct,"newperil_name")>
					<cfset count = arrayLen(formStruct['newperil_name'])>
					<!--- do the columns --->
					<cfloop from="1" to="#count#" index="i">
						<cfif formStruct['newperil_name'][i] neq "">
						
							<cfif formStruct['eb_id'][i] neq "">
								<!--- Update eb --->
								<cfset tempprop=mainGW.editEb(eb_id=#formStruct['eb_id'][i]#
										,eb_title=#formStruct['newperil_name'][i]#
										,eb_rate=#formStruct['newperil_rate'][i]#
								        ,eb_limit=#formStruct['newperil_limit'][i]#
								        ,eb_premium=#formStruct['newperil_premium'][i]#
								        ,eb_deductible=#formStruct['eb_deduct'][i]#) />
							<cfelse>
								<!--- New EB --->
								<cfset tempprop=mainGW.addEb(rating_property_id=rc.rating_property_id
										,eb_title=#formStruct['newperil_name'][i]#
										,eb_rate=#formStruct['newperil_rate'][i]#
								        ,eb_limit=#formStruct['newperil_limit'][i]#
								        ,eb_premium=#formStruct['newperil_premium'][i]#
								        ,eb_deductible=#formStruct['eb_deduct'][i]#) />
							</cfif>
						</cfif>
					</cfloop>
				</cfif>
				<!--- Update Application values --->
				<cfset result.ratingid = rc.ratingid >
				<cfset result.rating_liability_id=rc.rating_liability_id>
				<cfset result.rating_property_id = rc.rating_property_id>
			<cfelse>
				<cfset result = 'false'>
			</cfif>
			<cfset rc.response = JSON.encode(result)>
        	<cfset fw.setView('common.ajax')>
			
			
		</cfif>
	</cffunction>--->
  <!---
<cffunction name="addExpoDebitsEtc" access="public" returntype="void" output="true">
<cfargument name="formStruct" type="struct" required="yes">
<cfargument name="rating_liability_id" required="yes">
					<!--- Get the Array length based on number of forms submitted --->
					<cfif structkeyexists(formStruct,"new_expo")>
						<cfset count = arrayLen(formStruct['new_expo'])>
						<!--- do the columns --->
						<cfloop from="1" to="#count#" index="i">
							<cfif formStruct['new_expo'][i] neq "">
									<!--- New Other Exp --->
                                    <cfset new_annual = "#formStruct['new_annual'][i]#">
									<cfset temp=mainGW.addRatingLiabilityOther(rating_liability_id=liability,
											new_expo=#formStruct['new_expo'][i]#,
											new_annual=REReplace(new_annual,"[^\d.]", "","ALL")) />
							</cfif>
						</cfloop>
					</cfif>
				<!--- Add Other Debts --->
				<cfif structkeyexists(formStruct,"new_debitname")>
					<!--- Get the Array length based on number of forms submitted --->
					<cfset count = arrayLen(formStruct['new_debitname'])>
					<!--- do the columns --->
					<cfloop from="1" to="#count#" index="i">
						<cfset pct = val(replace(formStruct['new_debitamount'][i],"%","","ALL"))>
						<cfif formStruct['new_debitname'][i] neq "">
								<!--- New Other Exp --->
								<cfset temp=mainGW.addDebtCredit(rating_liability_id=liability,
										debtcredit_name=#formStruct['new_debitname'][i]#,
										debtcredit_value=pct,
										debtcredit_type=1) />
						</cfif>
					</cfloop>
				</cfif>
				<!--- Add Other Credits --->
				<cfif structkeyexists(formStruct,"new_creditname")>
					<!--- Get the Array length based on number of forms submitted --->
					<cfset count = arrayLen(formStruct['new_creditname'])>
					<!--- do the columns --->
					<cfloop from="1" to="#count#" index="i">
						<cfset pct = val(replace(formStruct['new_creditamount'][i],"%","","ALL"))>
						<cfif formStruct['new_creditname'][i] neq "">
								<!--- New Other Exp --->
								<cfset temp=mainGW.addDebtCredit(rating_liability_id=liability,
										debtcredit_name=#formStruct['new_creditname'][i]#,
										debtcredit_value=pct,
										debtcredit_type=2) />
						</cfif>
					</cfloop>
				</cfif>         
</cffunction>    --->
<cffunction name="updateExpoDebitsEtc" access="public" returntype="void" output="true">
<cfargument name="formStruct" type="struct" required="yes">
<cfargument name="rating_liability_id" required="yes">
					<!--- Get the Array length based on number of forms submitted --->
				<cfif structkeyexists(formStruct,"new_expo")>
					<cfset count = arrayLen(formStruct['new_expo'])>
					<!--- do the columns --->
					<cfloop from="1" to="#count#" index="i">
                    <!---<cflog application="no" file="otherexp" text="loop iteration: #count#, Loop beginning">--->
						<cfif formStruct['new_expo'][i] neq "">
                        <!---<cflog application="no" file="otherexp" text="loop iteration: #count#, new_expo is not blank">--->
						<cfset new_annual = "#formStruct['new_annual'][i]#">
							<cfif formStruct['otherexp_id'][i] neq "" AND formStruct['del_exp'][i] neq 1>
                            <!---<cflog application="no" file="otherexp" text="loop iteration: #count#, update existing exposure">--->
								<!--- Update Other Exp --->
								<cfset temp=mainGW.updateRatingLiabilityOther(otherexp_id=#formStruct['otherexp_id'][i]#,
										rating_liability_id=arguments.rating_liability_id,
										new_expo=#formStruct['new_expo'][i]#,
										new_annual=REReplace(new_annual,"[^\d.]", "","ALL")) />           
							<cfelseif formStruct['del_exp'][i] neq 1>
                            <!---<cflog application="no" file="otherexp" text="loop iteration: #count#, create new exposure">--->
								<!--- New Other Exp --->
								<cfset temp=mainGW.addRatingLiabilityOther(rating_liability_id=arguments.rating_liability_id,
										new_expo=#formStruct['new_expo'][i]#,
										new_annual=REReplace(new_annual,"[^\d.]", "","ALL")) />
                            <cfelse>
                            <!---<cflog application="no" file="otherexp" text="loop iteration: #count#, delete exposure">--->
                            	<cfset temp=mainGW.deleteOtherExp(otherexp_id=#formStruct['otherexp_id'][i]#)>           
							</cfif>
						</cfif>
					</cfloop>
				</cfif>
				<!--- Add Other Debts --->
        
				<cfif structkeyexists(formStruct,"new_debitname")>
					<!--- Get the Array length based on number of forms submitted --->
					<cfset count = arrayLen(formStruct['new_debitname'])>
					<!--- do the columns --->
					<cfloop from="1" to="#count#" index="i">
						<cfset pct = val(replace(formStruct['new_debitamount'][i],"%","","ALL"))>
						<cfif len(formStruct['new_debitname'][i])>
						
							<cfif len(formStruct['debit_id'][i]) AND formStruct['del_debit'][i] neq 1>
								<!--- Update debt --->
								<cfset temp=mainGW.editDebtCredit(debtcredit_id=#formStruct['debit_id'][i]#,
										rating_liability_id=arguments.rating_liability_id,
										debtcredit_name=#formStruct['new_debitname'][i]#,
										debtcredit_value=pct,
										debtcredit_type=1) />
							<cfelseif formStruct['del_debit'][i] eq 1>
              <cfset temp=mainGW.deleteOtherDebit(debtcredit_id=#formStruct['debit_id'][i]#)> 
              <cfelse>
								<!--- New Other Exp --->
								<cfset temp=mainGW.addDebtCredit(rating_liability_id=arguments.rating_liability_id,
										debtcredit_name=#formStruct['new_debitname'][i]#,
										debtcredit_value=pct,
										debtcredit_type=1) />                        
							</cfif>
						</cfif>
					</cfloop>
				</cfif>
				<!--- Add Other Credits --->
				<cfif structkeyexists(formStruct,"new_creditname")>
					<!--- Get the Array length based on number of forms submitted --->
					<cfset count = arrayLen(formStruct['new_creditname'])>
					<!--- do the columns --->
					<cfloop from="1" to="#count#" index="i">
						<cfset pct = val(replace(formStruct['new_creditamount'][i],"%","","ALL"))>
						<cfif formStruct['new_creditname'][i] neq "">
						
							<cfif formStruct['credit_id'][i] neq "" AND formStruct['del_credit'][i] neq 1>
								<!--- Update debt --->
								<cfset temp=mainGW.editDebtCredit(debtcredit_id=#formStruct['credit_id'][i]#,
										rating_liability_id=arguments.rating_liability_id,
										debtcredit_name=#formStruct['new_creditname'][i]#,
										debtcredit_value=pct,
										debtcredit_type=2) />
							<cfelseif formStruct['del_credit'][i] neq 1>
								<!--- New Other Exp --->
								<cfset temp=mainGW.addDebtCredit(rating_liability_id=arguments.rating_liability_id,
										debtcredit_name=#formStruct['new_creditname'][i]#,
										debtcredit_value=pct,
										debtcredit_type=2) />
                            <cfelse>
                                <cfset temp=mainGW.deleteOtherDebit(debtcredit_id=#formStruct['credit_id'][i]#)>        
							</cfif>
						</cfif>
					</cfloop>
				</cfif>               
</cffunction>
<cffunction name="updateOtherPropPerils">
<cfargument name="formStruct" type="struct" required="yes">
<cfargument name="rating_property_id" required="yes">
				<!--- Other Properties --->
			<cfif structkeyexists(formStruct,"newpropfield1")>
				<cfset count = arrayLen(formStruct['newpropfield1'])>
					<!--- do the columns --->
					<cfloop from="1" to="#count#" index="i">
						<cfif formStruct['newpropfield1'][i] neq "">
						
							<cfif formStruct['other_property_id'][i] neq "">
								<!--- Update debt --->
								<cfset tempprop=mainGW.editratingpropertyother(other_property_id=#formStruct['other_property_id'][i]#
										,other_title=#formStruct['newpropfield1'][i]#
										,other_rate=#formStruct['newpropfield2'][i]#
								        ,other_limit=#REReplace(formStruct['newpropfield3'][i],"[^\d.]", "","ALL")#
								        ,other_premium=#REReplace(formStruct['newpropfield4'][i],"[^\d.]", "","ALL")#) />
							<cfelse>
								<!--- New Other Prop --->
								<cfset tempprop=mainGW.addratingpropertyother(rating_property_id=arguments.rating_property_id
										,other_title=#formStruct['newpropfield1'][i]#
										,other_rate=#formStruct['newpropfield2'][i]#
								        ,other_limit=#REReplace(formStruct['newpropfield3'][i],"[^\d.]", "","ALL")#
								        ,other_premium=#REReplace(formStruct['newpropfield4'][i],"[^\d.]", "","ALL")#) />
							</cfif>
						</cfif>
					</cfloop>
				</cfif>
					<!--- Other EB --->
				<cfif structkeyexists(formStruct,"newperil_name")>
					<cfset count = arrayLen(formStruct['newperil_name'])>
					<!--- do the columns --->
					<cfloop from="1" to="#count#" index="i">
						<cfif formStruct['newperil_name'][i] neq "">
						
							<cfif formStruct['eb_id'][i] neq "">
								<!--- Update eb --->
								<cfset tempprop=mainGW.editEb(eb_id=#formStruct['eb_id'][i]#
										,eb_title=#formStruct['newperil_name'][i]#
										,eb_rate=#formStruct['newperil_rate'][i]#
								        ,eb_limit=#REReplace(formStruct['newperil_limit'][i],"[^\d.]", "","ALL")#
								        ,eb_premium=#REReplace(formStruct['newperil_premium'][i],"[^\d.]", "","ALL")#
								        ,eb_deductible=#REReplace(formStruct['eb_deduct'][i],"[^\d.]", "","ALL")#) />
							<cfelse>
								<!--- New EB --->
								<cfset tempprop=mainGW.addEb(rating_property_id=arguments.rating_property_id
										,eb_title=#formStruct['newperil_name'][i]#
										,eb_rate=#formStruct['newperil_rate'][i]#
								        ,eb_limit=#REReplace(formStruct['newperil_limit'][i],"[^\d.]", "","ALL")#
								        ,eb_premium=#REReplace(formStruct['newperil_premium'][i],"[^\d.]", "","ALL")#
								        ,eb_deductible=#REReplace(formStruct['eb_deduct'][i],"[^\d.]", "","ALL")#) />
							</cfif>
						</cfif>
					</cfloop>
				</cfif>
</cffunction>
<!---
<cffunction name="updateExpoDebitsEtcOLD" access="public" returntype="void" output="true">
<cfargument name="formStruct" type="struct" required="yes">
<cfargument name="rating_liability_id" required="yes">
					<!--- Get the Array length based on number of forms submitted --->
				<cfif structkeyexists(formStruct,"new_expo")>
					<cfset count = arrayLen(formStruct['new_expo'])>
					<!--- do the columns --->
					<cfloop from="1" to="#count#" index="i">
                    <!---<cflog application="no" file="otherexp" text="loop iteration: #count#, Loop beginning">--->
						<cfif formStruct['new_expo'][i] neq "">
                        <!---<cflog application="no" file="otherexp" text="loop iteration: #count#, new_expo is not blank">--->
						<cfset new_annual = "#formStruct['new_annual'][i]#">
							<cfif formStruct['otherexp_id'][i] neq "" AND formStruct['del_exp'][i] neq 1>
                            <!---<cflog application="no" file="otherexp" text="loop iteration: #count#, update existing exposure">--->
								<!--- Update Other Exp --->
								<cfset temp=mainGW.editRatingLiabilityOther(otherexp_id=#formStruct['otherexp_id'][i]#,
										rating_liability_id=arguments.rating_liability_id,
										new_expo=#formStruct['new_expo'][i]#,
										new_annual=REReplace(new_annual,"[^\d.]", "","ALL")) />           
							<cfelseif formStruct['del_exp'][i] neq 1>
                            <!---<cflog application="no" file="otherexp" text="loop iteration: #count#, create new exposure">--->
								<!--- New Other Exp --->
								<cfset temp=mainGW.addRatingLiabilityOther(rating_liability_id=arguments.rating_liability_id,
										new_expo=#formStruct['new_expo'][i]#,
										new_annual=REReplace(new_annual,"[^\d.]", "","ALL")) />
                            <cfelse>
                            <!---<cflog application="no" file="otherexp" text="loop iteration: #count#, delete exposure">--->
                            	<cfset temp=mainGW.deleteOtherExp(otherexp_id=#formStruct['otherexp_id'][i]#)>           
							</cfif>
						</cfif>
					</cfloop>
				</cfif>
				<!--- Add Other Debts --->
        
				<cfif structkeyexists(formStruct,"new_debitname")>
					<!--- Get the Array length based on number of forms submitted --->
					<cfset count = arrayLen(formStruct['new_debitname'])>
					<!--- do the columns --->
					<cfloop from="1" to="#count#" index="i">
						<cfset pct = val(replace(formStruct['new_debitamount'][i],"%","","ALL"))>
						<cfif len(formStruct['new_debitname'][i])>
						
							<cfif len(formStruct['debit_id'][i]) AND formStruct['del_debit'][i] neq 1>
								<!--- Update debt --->
								<cfset temp=mainGW.editDebtCredit(debtcredit_id=#formStruct['debit_id'][i]#,
										rating_liability_id=arguments.rating_liability_id,
										debtcredit_name=#formStruct['new_debitname'][i]#,
										debtcredit_value=pct,
										debtcredit_type=1) />
							<cfelseif formStruct['del_debit'][i] eq 1>
              <cfset temp=mainGW.deleteOtherDebit(debtcredit_id=#formStruct['debit_id'][i]#)> 
              <cfelse>
								<!--- New Other Exp --->
								<cfset temp=mainGW.addDebtCredit(rating_liability_id=arguments.rating_liability_id,
										debtcredit_name=#formStruct['new_debitname'][i]#,
										debtcredit_value=pct,
										debtcredit_type=1) />                        
							</cfif>
						</cfif>
					</cfloop>
				</cfif>
				<!--- Add Other Credits --->
				<cfif structkeyexists(formStruct,"new_creditname")>
					<!--- Get the Array length based on number of forms submitted --->
					<cfset count = arrayLen(formStruct['new_creditname'])>
					<!--- do the columns --->
					<cfloop from="1" to="#count#" index="i">
						<cfset pct = val(replace(formStruct['new_creditamount'][i],"%","","ALL"))>
						<cfif formStruct['new_creditname'][i] neq "">
						
							<cfif formStruct['credit_id'][i] neq "" AND formStruct['del_credit'][i] neq 1>
								<!--- Update debt --->
								<cfset temp=mainGW.editDebtCredit(debtcredit_id=#formStruct['credit_id'][i]#,
										rating_liability_id=arguments.rating_liability_id,
										debtcredit_name=#formStruct['new_creditname'][i]#,
										debtcredit_value=pct,
										debtcredit_type=2) />
							<cfelseif formStruct['del_credit'][i] neq 1>
								<!--- New Other Exp --->
								<cfset temp=mainGW.addDebtCredit(rating_liability_id=arguments.rating_liability_id,
										debtcredit_name=#formStruct['new_creditname'][i]#,
										debtcredit_value=pct,
										debtcredit_type=2) />
                            <cfelse>
                                <cfset temp=mainGW.deleteOtherDebit(debtcredit_id=#formStruct['credit_id'][i]#)>        
							</cfif>
						</cfif>
					</cfloop>
				</cfif>                
</cffunction>--->
<cffunction name="addEditEndorsement" access="public" returntype="void" output="false">
		<cfargument name="rc" type="any">
		<cfset var result = StructNew() />
		<cfset exlist = "gldate1,gldate2,gldate3,gldate4,underwriting_notes,yesnoquestions,propdate1,propdate2,prop_underwritingnotes,prop_yesnoquestions">
		<cfloop collection="#rc#" item="key">
			<cfif not listfindnocase(exlist,#key#)>
				<cfset temp = StructUpdate(rc, #key#, ReReplace(#rc[key]#,"[^\d.]", "","ALL"))>
				<cfif #rc[key]# eq ''>
					<cfset temp2 = StructUpdate(rc, #key#, returnNull())>
				</cfif>
			</cfif>
		</cfloop>
	
		
		<cfparam name="rc.ratingid" default="0">
        <cfparam name="rc.rating_liability_id" default="0">
        <cfparam name="rc.rating_property_id" default="0">
		<cfparam name="rc.location_id" default="0">
		<cfparam name="rc.application_id" default="0">
		<cfparam name="rc.liability_plan_id" default="0">
		<cfparam name="rc.property_plan_id" default="0">
		<cfparam name="rc.gl_issuing_company_id" default="0">
		<cfparam name="rc.property_issuing_company_id" default="0">
		<cfparam name="rc.square_footage" default="0">
		<cfparam name="rc.gross_receipts" default="0">
		<cfparam name="rc.excl_proposal" default="0">
		<cfparam name="rc.gl_deductable" default="0">
		<cfparam name="rc.base_rate_annual" default="0">
		<cfparam name="rc.instructors_expo" default="0">
		<cfparam name="rc.instructors_base" default="0">
		<cfparam name="rc.instructors_annual" default="0">
		<cfparam name="rc.basketball_expo" default="0">
		<cfparam name="rc.basketball_base" default="0">
		<cfparam name="rc.basketball_annual" default="0">
		<cfparam name="rc.rt_courts_expo" default="0">
		<cfparam name="rc.rt_courts_base" default="0">
		<cfparam name="rc.rt_courts_annual" default="0">
		<cfparam name="rc.tennis_courts_expo" default="0">
		<cfparam name="rc.tennis_courts_base" default="0">
		<cfparam name="rc.tennis_courts_annual" default="0">
		<cfparam name="rc.sauna_expo" default="0">
		<cfparam name="rc.sauna_base" default="0">
		<cfparam name="rc.sauna_annual" default="0">
		<cfparam name="rc.steamroom_expo" default="0">
		<cfparam name="rc.steamroom_base" default="0">
		<cfparam name="rc.steamroom_annual" default="0">
		<cfparam name="rc.whirlpool_expo" default="0">
		<cfparam name="rc.whirlpool_base" default="0">
		<cfparam name="rc.whirlpool_annual" default="0">
		<cfparam name="rc.pools_expo" default="0">
		<cfparam name="rc.pools_base" default="0">
		<cfparam name="rc.pools_annual" default="0">
		<cfparam name="rc.poolsoutdoor_expo" default="0">
		<cfparam name="rc.poolsoutdoor_base" default="0">
		<cfparam name="rc.poolsoutdoor_annual" default="0">
		<cfparam name="rc.tanning_expo" default="0">
		<cfparam name="rc.tanning_base" default="0">
		<cfparam name="rc.tanning_annual" default="0">
		<cfparam name="rc.spraytanning_expo" default="0">
		<cfparam name="rc.spraytanning_base" default="0">
		<cfparam name="rc.spraytanning_annual" default="0">
		<cfparam name="rc.beautyangels_expo" default="0">
		<cfparam name="rc.beautyangels_base" default="0">
		<cfparam name="rc.beautyangels_annual" default="0">
		<cfparam name="rc.silversneakers_expo" default="0">
		<cfparam name="rc.silversneakers_base" default="0">
		<cfparam name="rc.silversneakers_annual" default="0">
		<cfparam name="rc.massage_expo" default="0">
		<cfparam name="rc.massage_base" default="0">
		<cfparam name="rc.massage_annual" default="0">
		<cfparam name="rc.pt_expo" default="0">
		<cfparam name="rc.pt_base" default="0">
		<cfparam name="rc.pt_annual" default="0">
		<cfparam name="rc.childsitting_expo" default="0">
		<cfparam name="rc.childsitting_base" default="0">
		<cfparam name="rc.childsitting_annual" default="0">
		<cfparam name="rc.junglegym_expo" default="0">
		<cfparam name="rc.junglegym_base" default="0">
		<cfparam name="rc.junglegym_annual" default="0">
		<cfparam name="rc.leasedspace_expo" default="0">
		<cfparam name="rc.leasedspace_base" default="0">
		<cfparam name="rc.leasedspace_annual" default="0">
		<cfparam name="rc.employeebenefits_expo" default="0">
		<cfparam name="rc.employeebenefits_base" default="0">
		<cfparam name="rc.employeebenefits_annual" default="0">    
		<cfparam name="rc.total_annual" default="0">
		<cfparam name="rc.total_debits" default="0">
		<cfparam name="rc.loc_annual_premium" default="0">
		<cfparam name="rc.pro_rata_gl" default="0">
		<cfparam name="rc.use_prorata" default="0">
		<cfparam name="rc.broker_override" default="0">
		<cfparam name="rc.brokerfee" default="0">
		<cfparam name="rc.broker_flatpercent" default="0">
		<cfparam name="rc.broker_percentoverride" default="0">
		<cfparam name="rc.broker_flatpercent" default="0">
		<cfparam name="rc.surplustax" default="0">
		<cfparam name="rc.inspectionfee" default="0">
		<cfparam name="rc.terrorism_rejected" default="0">
		<cfparam name="rc.terrorism_fee" default="0">
		<cfparam name="rc.stampingfee" default="0">
		<cfparam name="rc.filingfee" default="0">
		<cfparam name="rc.statecharge" default="0">
		<cfparam name="rc.rpgfee" default="0">
		<cfparam name="rc.rpgall" default="0">
		<cfparam name="rc.grandtotal" default="0">
		<cfparam name="rc.gl_prorate" default="0">
		<cfparam name="rc.underwriting_notes" default="0">
		<cfparam name="rc.yesnoquestions" default="">
		<cfparam name="rc.prop_deductible" default="0">
		<cfparam name="rc.prop_exclwind" default="0">
		<cfparam name="rc.prop_winddeductable" default="0">
		<cfparam name="rc.prop_buildingrate" default="0">
		<cfparam name="rc.prop_buildinglimit" default="0">
		<cfparam name="rc.prop_buildingpremium" default="0">
		<cfparam name="rc.prop_bpprate" default="0">
		<cfparam name="rc.prop_bpplimit" default="0">
		<cfparam name="rc.prop_bpppremium" default="0">
		<cfparam name="rc.prop_tirate" default="0">
		<cfparam name="rc.prop_tilimit" default="0">
		<cfparam name="rc.prop_tipremium" default="0">
		<cfparam name="rc.prop_90" default="0">
		<cfparam name="rc.prop_bieerate" default="0">
		<cfparam name="rc.prop_bieelimit" default="0">
		<cfparam name="rc.prop_bieepremium" default="0">
		<cfparam name="rc.prop_daysdeductible" default="0">
		<cfparam name="rc.prop_edprate" default="0">
		<cfparam name="rc.prop_edplimit" default="0">
		<cfparam name="rc.prop_edppremium" default="0">
		<cfparam name="rc.prop_hvacrate" default="0">
		<cfparam name="rc.prop_hvaclimit" default="0">
		<cfparam name="rc.prop_hvacpremium" default="0">
		<cfparam name="rc.prop_signrate" default="0">
		<cfparam name="rc.prop_signlimit" default="0">
		<cfparam name="rc.prop_signpremium" default="0">
		<cfparam name="rc.prop_equipbreakrate" default="0">
		<cfparam name="rc.prop_equipbreaktotal" default="0">
		<cfparam name="rc.prop_equipbreakpremium" default="0">
		<cfparam name="rc.employee_dishonesty_id" default="0">
		<cfparam name="rc.property_emp_amount" default="0">
		<cfparam name="rc.cyber_liability_amount_id" default="0">
		<cfparam name="rc.property_cyber_amount" default="0">
		<cfparam name="rc.prop_floodrate" default="0">
		<cfparam name="rc.prop_floodlimit" default="0">
		<cfparam name="rc.prop_floodpremium" default="0">
		<cfparam name="rc.prop_flooddeduct" default="0">
		<cfparam name="rc.prop_quakerate" default="0">
		<cfparam name="rc.prop_quakelimit" default="0">
		<cfparam name="rc.prop_quakepremium" default="0">
		<cfparam name="rc.prop_quakededuct" default="0">
		<cfparam name="rc.premium_override" default="0">
		<cfparam name="rc.prop_ratedpremium" default="0">
		<cfparam name="rc.prop_chargedpremium" default="0">
    <cfparam name="rc.prop_taxoverride" default="0">
		<cfparam name="rc.prop_taxes" default="0">
		<cfparam name="rc.prop_use_prorata" default="0">
		<cfparam name="rc.prop_agencyfee" default="0">
    <cfparam name="rc.prop_agencyfeeoverride" default="0">
		<cfparam name="rc.prop_agencyamount" default="0">
    <cfparam name="rc.prop_brokerfee" default="0">
		<cfparam name="rc.prop_terrorism_rejected" default="0">
		<cfparam name="rc.prop_terrorism" default="0">
		<cfparam name="rc.prop_grandtotal" default="0">
		<cfparam name="rc.propdate1" default="0">
		<cfparam name="rc.propdate2" default="0">
		<cfparam name="rc.prop_prorate" default="0">
		<cfparam name="rc.prop_underwritingnotes" default="0">
		<cfparam name="rc.prop_yesnoquestions" default="0">
		<cfparam name="rc.gldate1" default="0">
		<cfparam name="rc.gldate2" default="0">
		<cfparam name="rc.history" default="0">
        <cfparam name="rc.endorse" default="0">
        <cfparam name="rc.total_debitspercent" default="0">
        <cfparam name="rc.premium_mod" default="0">
        <cfparam name="rc.final_mod" default="0">
        <cfparam name="rc.premium_mod_label" default="">
        <cfparam name="rc.inspection_override" default="0">
        <cfparam name="rc.rpg_override" default="0">
        <cfparam name="rc.base_override" default="0">
        <cfparam name="rc.statemuni_override" default="0">
        <cfparam name="rc.stamping_override" default="0">	
        <cfparam name="rc.filing_override" default="0">
        <cfparam name="rc.prop_subtotal" default="0">	
			
			<!---  update or add the application first --->

			<cfset appid = appGW.addApplication(application_id=rc.application_id
			,client_id=rc.client_id
			,location_id=rc.location_id
			,number_trainers =rc.instructors_expo
			,court_basketball=rc.basketball_expo
			,court_racquetball=rc.rt_courts_expo
			,court_tennis=rc.tennis_courts_expo
			,sauna=rc.sauna_expo
			,steam_room=rc.steamroom_expo
			,whirlpool=rc.whirlpool_expo
			,pool_indoor=rc.pools_expo
			,pool_outdoor=rc.poolsoutdoor_expo
			,beds_tanning=rc.tanning_expo
			,beds_spray=rc.spraytanning_expo
			,beauty_angel=rc.beautyangels_expo
			,silver_sneakers=rc.silversneakers_expo
			,massage=rc.massage_expo
			,leased_space=rc.leasedspace_expo
			,employee_benefits=rc.employeebenefits_expo
			,personal_training=rc.pt_expo
			,number_children=rc.childsitting_expo
			,play_apparatus = rc.junglegym_expo
			,gross_receipts=rc.gross_receipts
			,square_ft=square_footage
			,notes=rc.yesnoquestions)>
			
				<!--- Build New Rating, get the ID --->
				<cfset rating = mainGW.addEditRating(application_id=appid
				  ,ratingid = rc.ratingid
				  ,rating_liability_id = rc.rating_liability_id
				  ,rating_property_id = rc.rating_property_id
				 ,location_id = rc.location_id
			      ,liability_plan_id = rc.liability_plan_id
			      ,property_plan_id = rc.property_plan_id
			      ,square_footage = rc.square_footage
			      ,gross_receipts = REReplace(rc.gross_receipts,"[^\d.]", "","ALL")
			      ,excl_proposal = rc.excl_proposal
			      ,gl_issuing_company_id = rc.gl_issuing_company_id
			      ,property_issuing_company_id = rc.property_issuing_company_id
			      ,endorsement_id = 0
			      ,history=1
				  ,endorse=1)>
			    
				<!--- Add Liability  get @@Identity--->
                <cfif rc.ratingid eq 0>
				<cfset liability = mainGW.addRatingLiability(ratingid = rating,rc=rc)>
                <cfelse>
                <cfset liability = mainGW.editRatingLiability(ratingid = rating,rc=rc)>
                </cfif>
				<!--- Add Other Exposures --->
				<cfset formStruct = getPageContext().getRequest().getParameterMap()>
				<cfset addExpoDebitsEtc(formStruct,liability)>
				<!--- Add Property get @@Identity --->
                <cfif rc.ratingid eq 0>
				<cfset property = mainGW.addRatingProperty(ratingid = rating,rc=rc)>
				<cfelse>
                <cfset property = mainGW.editRatingProperty(ratingid = rating,rc=rc)>
                </cfif>
				<cfif structkeyexists(formStruct,"newpropfield1")>
				<!--- Add Other Properties --->
				<cfset count = arrayLen(formStruct['newpropfield1'])>
					<!--- do the columns --->
					<cfloop from="1" to="#count#" index="i">
						
						<cfif formStruct['newpropfield1'][i] neq "">
								<!--- New Other Prop --->
								<cfset tempprop=mainGW.addratingpropertyother(rating_property_id=property,
										other_title=#formStruct['newpropfield1'][i]#
										,other_rate=#formStruct['newpropfield2'][i]#
								        ,other_limit=#formStruct['newpropfield3'][i]#
								        ,other_premium=#formStruct['newpropfield4'][i]#) />
						</cfif>
					</cfloop>
				</cfif>
					<!--- Add Other EB --->
				<cfif structkeyexists(formStruct,"newperil_name")>	
					<cfset count = arrayLen(formStruct['newperil_name'])>
					<!--- do the columns --->
					<cfloop from="1" to="#count#" index="i">
						
						<cfif formStruct['newperil_name'][i] neq "">
								<!--- New Other Prop --->
								<cfset tempprop=mainGW.addEb(rating_property_id=property,
										eb_title=#formStruct['newperil_name'][i]#
										,eb_rate=#formStruct['newperil_rate'][i]#
								        ,eb_limit=#formStruct['newperil_limit'][i]#
								        ,eb_premium=#formStruct['newperil_premium'][i]#
								        ,eb_deductible=#formStruct['eb_deduct'][i]#) />
						</cfif>
					</cfloop>
				</cfif>
				<!--- Update the main rating table with liability and property ID's --->
				<cfset final = mainGW.updateRating(ratingid = rating,rating_liability_id=liability,rating_property_id=property)>
				<!--- Update Application values --->
                <cfset result.application_id = appid>
				<cfset result.ratingid = rating>
				<cfset result.rating_liability_id = liability>
				<cfset result.rating_property_id = property>

		<cfset rc.response = JSON.encode(result)>
        <cfset fw.setView('common.ajax')>

	</cffunction>	
	<cffunction name="purgeProposals" access="public" output="yes">
		<cfargument name="rc" type="any">  
		<cfset path = expandpath('./proposals')>
    <cfdirectory action="list" directory="#path#" name="files" filter="*.pdf">
    <cfset checkdate = dateadd("d",-7,now())>
    <cfloop query="files">
      <cfif files.name neq 'uploads' and datecompare(checkdate, files.datelastmodified) eq 1>
      Deleting #files.name#, it was modified #files.datelastmodified#
      <cffile action="delete" file="#path#/#files.name#">
      <cfelse>
      Skipping #files.name#, it was modified #files.datelastmodified#
      </cfif><br>
    </cfloop>

  </cffunction>    
	<cffunction name="specialreport" access="public" output="yes">
		<cfargument name="rc" type="any">  
<cfset data = mainGW.specialReport()>
<cfset state = "">
<cfset totalloc = 0>
<cfset totalgl = 0>
<cfset grandtotalloc = 0>
<cfset grandtotalgl = 0>
<table border="1" style="margin-top:100px;">
<tr><td>State</td><td>Total Active Locations</td><td>Total GL Premiums</td></tr>
<cfloop query="data">
<cfif data.statename neq state>
<tr><td>#state#</td><td>#totalloc#</td><td>#totalgl#</td><tr>
<cfset state = data.statename>
<cfset totalloc = 1>
<cfset totalgl = data.pro_rata_gl>
<cfelse>
<cfset totalloc = totalloc + 1>
<cfset totalgl = totalgl + val(data.pro_rata_gl)>
</cfif>
<cfset grandtotalloc = grandtotalloc +1>
<cfset grandtotalgl = grandtotalgl + val(data.pro_rata_gl)>

<cfif data.currentrow eq data.recordcount>
<tr><td>#state#</td><td>#totalloc#</td><td>#totalgl#</td><tr>
</cfif>
</cfloop>
<tr><td>Grand Totals</td><td>#grandtotalloc#</td><td>#grandtotalgl#</td></tr>
</table>
<cfset fw.setView('main.test') />	 
  </cffunction>   
	<cffunction name="wcreport" access="public" output="yes">
		<cfargument name="rc" type="any">  
<cfset data = mainGW.wcReport()>

<cfset state = "">

<cfset totalwc = 0>
<cfset grandtotalwc = 0>
<table border="1" style="margin-top:100px;">
<tr><td>State</td><td>Total WC Premiums</td></tr>
<cfloop query="data">
<cfset hasActiveLocs = mainGW.checkactiveLocs(data.client_id)>
<cfif hasActiveLocs eq true>
<cfif data.statename neq state>
<tr><td>#state#</td><td>#totalwc#</td><tr>
<cfset state = data.statename>
<cfset totalwc = data.wc_premium>
<cfelse>
<cfset totalwc = totalwc + val(data.wc_premium)>
</cfif>
<cfset grandtotalwc = grandtotalwc + val(data.wc_premium)>

<cfif data.currentrow eq data.recordcount>
<tr><td>#state#</td><td>#totalwc#</td></tr>
</cfif>
</cfif>
</cfloop>
<tr><td>Grand Totals</td><td>#grandtotalwc#</td></tr>
</table>
<cfset fw.setView('main.test') />	 
  </cffunction>    
<cffunction name="test" access="public" output="yes">
<cfset terrorism_premium = mainGW.getTerrorismPrem(50,0)>
<cfdump var="#terrorism_premium#">
</cffunction>
</cfcomponent>