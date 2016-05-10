<style>
ul, ol, li {
font-family:Arial !important;
}
</style>
<cfoutput>
<cfparam name="rc.thiscontent" default="">
<cfparam name="rc.client.mailing_address" default="123 45th Ave">
<cfparam name="rc.client.mailing_address2" default="Suite 678">
<cfparam name="rc.client.mailing_city" default="Denver">
<cfparam name="rc.client.statename" default="CO">
<cfparam name="rc.client.mailing_zip" default="80210">
<cfparam name="rc.client.entity_name" default="Acme Gym, Inc.">
<cfparam name="rc.client.dba" default="Test DBA">
<cfparam name="rc.client.current_effective_date" default="#dateFormat(now())#">
<cfparam name="rc.client.ams" default="123">
<cfparam name="rc.client.fein" default="123456789">
<cfparam name="rc.proposaldocs.proposal_doc_content" default="#rc.thiscontent#">
<cfparam name="rc.date" default="#now()#">
<cfparam name="rc.terrorism_premium" default="123">
<cfparam name="rc.contacts.name" default="Tabatha Hintz">
<cfparam name="rc.contacts.phone" default="(303) 456-2345">
<cfparam name="rc.contacts.fax" default="">
<cfparam name="rc.contacts.email" default="tabatha@fitnessinsurance.com">
<cfparam name="rc.sigimage" default='<img src="http://#cgi.SERVER_NAME#/sigs/#session.auth.sig#" width="200">'>
<cfsavecontent variable="addressblock">
#rc.client.mailing_address#<br />
<cfif trim(rc.client.mailing_address2) neq ''>
#rc.client.mailing_address2#<br />
</cfif>
#rc.client.mailing_city#, #rc.client.statename#, #rc.client.mailing_zip#
</cfsavecontent>
<cfsavecontent variable="addressline">
#rc.client.mailing_address#<cfif trim(rc.client.mailing_address2) neq ''>, #rc.client.mailing_address2#</cfif>
</cfsavecontent>
<cfsavecontent variable="citystatezip">
#rc.client.mailing_city#, #rc.client.statename#, #rc.client.mailing_zip#
</cfsavecontent>
<cfset longdate = dateFormat(rc.date,'dddd, mmmm d, yyyy')>
<cfset content = REPLACENOCASE(REPLACENOCASE(REPLACENOCASE(REPLACENOCASE(REPLACENOCASE(REPLACENOCASE(REPLACENOCASE(REPLACENOCASE(REPLACENOCASE(REPLACENOCASE(REPLACENOCASE(REPLACENOCASE(REPLACENOCASE(REPLACENOCASE(REPLACENOCASE(REPLACENOCASE(rc.proposaldocs.proposal_doc_content,'[CURRENT_DATE]',longdate,'ALL'),'[ENTITY_NAME]','<b>#rc.client.entity_name#</b>','ALL'),'[TERRORISM_PREMIUM_OLD]',rc.terrorism_premium,'ALL'),'[DBA]',rc.client.dba,'ALL'),'[ADDRESS_BLOCK]',addressblock,'ALL'), '[CONTACT_NAME]',rc.contacts.name,'ALL'),'[CONTACT_PHONE]',rc.contacts.phone,'ALL'),'[CONTACT_FAX]',rc.contacts.fax,'ALL'),'[CONTACT_EMAIL]', rc.contacts.email, 'ALL'),'[CURRENT_EFFECTIVE_DATE]',dateFormat(rc.client.current_effective_date,'mm/dd/yyyy'),'ALL'),'[USER_SIG]',rc.sigimage,'ALL'),'[USER_NAME]',session.auth.fullname,'ALL'),'[ADDRESS_LINE]',addressline,'ALL'),'[CITY_STATE_ZIP]',citystatezip,'ALL'),'[AMS]',rc.client.ams,'ALL'),'[FEIN]',rc.client.fein,'ALL')>


</cfoutput>