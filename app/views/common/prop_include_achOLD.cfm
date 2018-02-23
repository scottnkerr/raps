
<style>
body, p {font-size:12px !important;}
h2 {margin-top:15px;}
.tbl {background-color:#000;}
.tbl td,th,caption{background-color:#fff;}
td, th {font-size:12px;}
input {border:none;}
</style>
<cfoutput>
<h2>Authorization Agreement for Pre-Authorized Payments</h2>
<div style="border:1px solid black; padding:15px;">

<table width="100%" border="0" cellspacing="0" cellpadding="10">
  <tr>
    <td style="font-weight:bold; width:140px">Customer Name:</td>
    <td><div style="border-bottom:1px solid black; padding-bottom:1px;">#client.entity_name#, #client.dba#</div></td>
  </tr>
  <tr>
    <td style="font-weight:bold;">Contact Name:</td>
    <td><div style="border-bottom:1px solid black; padding-bottom:1px;">#contacts.name# </div></td>
  </tr>
  <tr>
      <td style="font-weight:bold;">FEIN:</td>
    <td><div style="border-bottom:1px solid black; padding-bottom:1px;">#client.fein# </div></td>
  </tr>  
  <tr>
    <td style="font-weight:bold;">Mailing Address:</td>
    <td><div style="border-bottom:1px solid black; padding-bottom:1px;">#client.mailing_address# </div></td>
  </tr>
  <tr>
    <td style="font-weight:bold;">City/State/Zip:</td>
    <td><div style="border-bottom:1px solid black; padding-bottom:1px;">#client.mailing_city#, #client.statename# #client.mailing_zip#</div></td>
  </tr>
  <tr>
    <td style="font-weight:bold;">Loan Number:</td>
    <td><div style="border-bottom:1px solid black; padding-bottom:1px;">&nbsp;</div></td>
  </tr>
  <tr>
      <td style="font-weight:bold;">AMS Client Number:</td>
    <td><div style="border-bottom:1px solid black; padding-bottom:1px;">#client.ams# &nbsp;</div></td>
    </tr>
</table>
</div>
<p style="padding:20px 0;">
I/(We) hereby authorize BankDirect / Fitness Insurance, LLC. to initiate debit entries for amounts due under our premium finance agreement(s), subsequent policy endorsement(s) and audit premium amount(s) due from the checking account indicated below at the depository named below, hereinafter called DEPOSITORY, and to debit same to such account.
</p>
<div style="border:1px solid black; padding:15px;">
<table width="100%" border="0" cellspacing="0" cellpadding="10">
  <tr>
    <td style="font-weight:bold; width:140px">Depository Bank Name:</td>
    <td><div style="border-bottom:1px solid black; padding-bottom:1px;">&nbsp;</div></td>
  </tr>
  <tr>
    <td style="font-weight:bold;">Contact Name:</td>
    <td><div style="border-bottom:1px solid black; padding-bottom:1px;">&nbsp;</div></td>
  </tr>
  <tr>
      <td style="font-weight:bold;">FEIN:</td>
    <td><div style="border-bottom:1px solid black; padding-bottom:1px;">&nbsp;</div></td>
  </tr>  
  <tr>
    <td style="font-weight:bold;">Mailing Address:</td>
    <td><div style="border-bottom:1px solid black; padding-bottom:1px;">&nbsp; </div></td>
  </tr>
</table>
</div>
<h2 style="margin-top:20px">PLEASE ATTACH A VOIDED CHECK FOR THIS ACCOUNT</h2>
<p>
This authorization is to remain in full force and effect until BankDirect / Fitness Insurance, LLC. and DEPOSITORY have received written information from the above customer(s) of its termination, in such time and in such manner as to afford BankDirect / Fitness Insurance, LLC. and DEPOSITORY a reasonable opportunity to act upon it.
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