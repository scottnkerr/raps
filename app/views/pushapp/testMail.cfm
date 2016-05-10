<cfparam name="FORM.fromEmail" default="webmaster@fitnessinsurance.com">
<cfparam name="FORM.toEmail" default="skerr@greystonetech.com">
<cfparam name="FORM.emailSubject" default="Testing cfmail and smtp">
<cfparam name="FORM.emailBody" default="This is a test message">
<cfoutput>
<style>
input, textarea {
	width:180px;
	text-align:left !important;
}
</style>
<div style="padding:20px;">
<form method="post" autocomplete="off">
From Email Address:<br>
<input type="text" name="fromEmail" value="#FORM.fromEmail#"><br><br>
To Email Address:<br>
<input type="text" name="toEmail" value="#FORM.toEmail#"><br><br>
Subject:<br>
<input type="text" name="emailSubject" value="#FORM.emailSubject#"><br><br>
Message:<br>
<textarea name="emailBody">#FORM.emailBody#</textarea><br>
<input type="submit" name="emailSub" value="SEND EMAIL" style="text-align:center !important;">
</form>
</div>
</cfoutput>