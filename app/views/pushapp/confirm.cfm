<script type="text/javascript">
$(document).ready(function(){

	$('#pushconfirm').click(function(e) {
		e.preventDefault();		
		pushID = <cfoutput>#rc.DecryptedID#</cfoutput>
		if (pushID != 0) {
			$.ajax({
			  type: "POST",
			  cache: false,
			  url: "/index.cfm?event=pushapp.push",
			  data: {
				  ID : pushID
			  }

			}).success(function(resp) {
				//if (resp == '"success"') {
				//alert('Application was pushed successfully.');
				//}
				alert(resp);
				$('#confirmform').fadeOut();
				
			});
	
		}							
	});

}); //end document ready
</script>
<div id="head">

<img src="/images/logo-large.png" id="logolarge">
<div id="confirmform">
<cfif rc.checkpreviouspush is 0>
<p>
Are you sure you want to push this application into RAPS?
</p>
<cfform action="#cgi.SCRIPT_NAME#?#cgi.QUERY_STRING#" method="post">
<button class="buttons" id="pushconfirm">YES</button>
</cfform>
<cfelse>
This application has already been pushed.
</cfif>
</div>
</div>
<div id="homepic">
</div>
