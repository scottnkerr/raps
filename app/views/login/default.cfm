
<div id="head">
<img src="/images/logo-large.png" id="logolarge">
<div id="loginform">
<img src="images/login.png" id="lock">
<form action="/index.cfm?event=login.login" method="post" autocomplete="off">
<ul class="formfields width-260">
<cfif structkeyexists(rc,"message")>

<li class="loginmessage"><label></label></li>
<li class="loginmessage"><span class="bold"><cfoutput>#rc.message#</cfoutput></span></li>
</cfif>
<li class="clear"><label>User Name</label></li>
<li><input type="text" name="username" class="txtleft exclude"></li>
<li><label>Password</label></li>
<li><input type="password" name="password" class="txtleft exclude"></li>
<li><label>&nbsp;</label></li>

<li><button class="buttons exclude">Submit</button></li>

</ul>
</form>
</div>
</div>
<div id="homepic">
</div>