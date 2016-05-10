
<style>
body, p {font-size:14px !important;
line-height:20px !important;}
h2 {margin-top:15px; text-align:center; font-size:24px;}
.tbl {background-color:#000;}
.tbl td,th,caption{background-color:#fff;}
td, th {font-size:14px !important;}
input {border:none;}
</style>
<cfoutput>
<h2>Authorization Agreement for Pre-Authorized Payments</h2>
<div style="border:1px solid black; padding:15px;">
        <cfset rc.proposaldocs.proposal_doc_content = rc.thiscontent>
<cfsavecontent variable="rc.proposaldocs.proposal_doc_content">

<table width="100%" border="0" cellspacing="0" cellpadding="18">
  <tr>
    <td style="font-size:16px; font-weight:bold; width:170px">Customer Name:</td>
    <td><div style="font-size:16px; border-bottom:1px solid black; padding-bottom:1px;">#client.entity_name#</div></td>
  </tr>
  <tr>
    <td style="font-size:16px; font-weight:bold;">Contact Name:</td>
    <td><div style="font-size:16px; border-bottom:1px solid black; padding-bottom:1px;"><cfif contacts.recordcount>#contacts.name#</cfif></div></td>
  </tr>
  <tr>
      <td style="font-size:16px; font-weight:bold;">FEIN:</td>
    <td><div style="font-size:16px; border-bottom:1px solid black; padding-bottom:1px;">#client.fein#</div></td>
  </tr>  
  <tr>
    <td style="font-size:16px; font-weight:bold;">Mailing Address:</td>
    <td><div style="font-size:16px; border-bottom:1px solid black; padding-bottom:1px;">#client.mailing_address#</div></td>
  </tr>
  <tr>
    <td style="font-size:16px; font-weight:bold;">City/State/Zip:</td>
    <td><div style="font-size:16px; border-bottom:1px solid black; padding-bottom:1px;">#client.mailing_city#, #client.statename# #client.mailing_zip#</div></td>
  </tr>  
  <tr>
    <td style="font-size:16px; font-weight:bold;">Loan Number:</td>
    <td><div style="font-size:16px; border-bottom:1px solid black; padding-bottom:1px;"></div></td>
  </tr>  
  <tr>
    <td style="font-size:16px; font-weight:bold;">AMS Client Number:</td>
    <td><div style="font-size:16px; border-bottom:1px solid black; padding-bottom:1px;">#client.ams#</div></td>
  </tr>      
</table> 
</cfsavecontent>        
		<cfinclude template="/app/views/common/shortcodes.cfm">
  
<cfset pagebreak = '<p style="page-break-after: always !important; padding:0, margin:0; line-height:0; height:0; overflow:hidden;">&nbsp;</p>'>
#replacenocase(replacenocase(content,"[PAGE_BREAK]", pagebreak, "ALL"),'[RANDY_SIG]','<img src="/images/testsig2.gif" height="75" width="200">','ALL')#

</div>
<p style="padding:20px 0;">
I/(We) hereby authorize BankDirect / Brown & Brown, LLC. To initiate debit entries for amounts due under our premium finance agreement(s), subsequent policy endorsement(s) and audit premium amount(s) due from the checking account indicated below at the depository named below, hereinafter called DEPOSITORY, and to debit same to such account.  
</p>
<div style="font-size:16px; border:1px solid black; padding:15px;">
<table width="100%" border="0" cellspacing="0" cellpadding="18">
  <tr>
    <td style="font-size:16px; font-weight:bold; width:170px">Depository Bank Name:</td>
    <td><div style="font-size:16px; border-bottom:1px solid black; padding-bottom:1px;">&nbsp;</div></td>
  </tr>
  <tr>
    <td style="font-size:16px; font-weight:bold;">Branch Name:</td>
    <td><div style="font-size:16px; border-bottom:1px solid black; padding-bottom:1px;">&nbsp;</div></td>
  </tr>
  <tr>
      <td style="font-size:16px; font-weight:bold;">City/State/Zip:</td>
    <td><div style="font-size:16px; border-bottom:1px solid black; padding-bottom:1px;">&nbsp;</div></td>
  </tr>  
  <tr>
    <td style="font-size:16px; font-weight:bold;">Customer Bank Acct ##:</td>
    <td><div style="font-size:16px; border-bottom:1px solid black; padding-bottom:1px;">&nbsp; </div></td>
  </tr>
</table>
</div>
<h2 style="margin-top:30px"><span style="background-color:##FF0;">PLEASE ATTACH A VOIDED CHECK FOR THIS ACCOUNT</span></h2>
<p>
This authorization is to remain in full force and effect until BankDirect / Brown & Brown, LLC. and DEPOSITORY have received written information from the above customer(s) of its termination, in such time and in such manner as to afford BankDirect / Brown & Brown, LLC. and DEPOSITORY a reasonable opportunity to act upon it.  
</p>
<br /><br />
<p style="padding-bottom:15px;">
Authorized &amp; Agreed to by:
</p>
______________________________________________________________________________________________________________________<br />
By:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Title:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Date:
</div>
</cfoutput>