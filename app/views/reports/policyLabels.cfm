<script>
$(document).ready(function() {
	$('#createlabels').click(function(e) {
		e.preventDefault();
		var height = $(window).height();
		var startdate = $('#startdate').val();
		var enddate = $('#enddate').val();
        var url = '<cfoutput>#cgi.SCRIPT_NAME#?event=reports.printPolicyLabels&reportLayout=print&startdate=</cfoutput>'+startdate+'&enddate='+enddate;
        var windowName = "PrintPolicyLabels";
        var windowSize = "width=910,scrollbars=yes,toolbar=yes,height=" + height
 
        newwindow = window.open(url, windowName, windowSize).focus();		
	});


}); //end document ready
</script>
  <div id="statusbar">
  <div id="pagename"><cfoutput>#rc.title#</cfoutput></div>
  <div id="statusstuff">  
  </div><!---End Statusstuff--->
  </div><!---End statusbar---> 
  <cfset thismonth = month(now())>
  <cfset thisyear = year(now())>
  <cfset startdate = CreateDate(thisyear, thismonth, 1)>
  <cfset enddate = dateAdd('m',1,startdate)>
  <cfset enddate = dateAdd('d',-1,enddate)>	
<cfoutput>


<form id="dateform" name="dateform" method="post" autocomplete="off">
<ul class="formfields" style="margin-top:30px;">
<li class="clear"><label>From:</label></li>
<li><input type="text" class="datebox" id="startdate" name="startdate" value="#dateFormat(startdate, 'mm/dd/yyyy')#" /></li>
<li><label>To:</label></li>
<li><input type="text" class="datebox" id="enddate" name="enddate" value="#dateFormat(enddate, 'mm/dd/yyyy')#" /></li>
<li class="clear"><label>&nbsp;</label></li>
<li class="clear"><button class="buttons" name="createlabels" id="createlabels">CREATE LABELS</button></li>
</ul>
</form>
</cfoutput>