
<script type="text/javascript">
function CheckWindowState()    {           
//close the window if print dialogue has closed
if(document.readyState=="complete") {
//window.close(); 
} else {           
setTimeout("CheckWindowState()", 2000)
}
}
$(document).ready(function(){
	updateTotals();
	
	<cfif isDefined("URL.savemsg")>
	saveAlert();
	</cfif>
<cfif isDefined('print')>
//if printing app remove wijmo checkboxes because they don't print properly
$(":input[type='checkbox']").wijcheckbox("destroy");
//$('input').attr('disabled','disabled');

//print
window.print(); 
//call function to see if the print dialog has closed, then close the window.
CheckWindowState();

</cfif>

$('#closebutton').click(function() {
window.close(); 								 
});
	$(":input[type='checkbox']").wijcheckbox("refresh");
	//Add Employee
			$("#addEmp").click(function() {		
						
			//console.log(totalwc);		
			  
				$('#addWC').before('<li class="clear"><input name="workcompid" value="" type="hidden"><input name="wc_name" id="wc_name1" type="text" class="width-134 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all" style="margin-right:2px;" /></li><li><input name="title" id="wc_title1" type="text" class="width-134 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all" style="margin-right:2px;" /></li><li><input name="percentown" id="wc_percent_owner1" type="text" class="width-40 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all" style="margin-right:2px;" /></li><li><input name="salary" id="wc_salary1" type="text" class="width-65 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all" style="margin-right:2px;" /></li><li style="padding-left:10px;"><input type="checkbox" value="1"  name="include" id="wc_include1" class="newbox" /></li><li style="padding-left:25px;"><input type="checkbox" value="1"  name="exclude" id="wc_exclude1" class="newbox" /></li>');	
				//$(".newbox").wijcheckbox();
				$(":input[type='checkbox']").removeClass("newbox");
				var totalwc = $('input[name=wc_name]').length;	
				if (totalwc	 >= 4) {	
				$(this).hide();
								alert('Maximum number of WC Owners reached.');
				
			}

			});	
			
	$('#save').click(function(e){
		e.preventDefault();
		var data = $('#appform').serialize();
		$.ajax({
			  type: "POST",
			  cache: false,
			  url: "/index.cfm?event=app.addEditApp",
			  data: data

			}).success(function(resp) {
					var url = '/index.cfm?event=app&savemsg=1&ratingid=<cfoutput>#ratingid#</cfoutput>&client_id=' + <cfoutput>#client_id#</cfoutput> + '&application_id=' + resp;	 
					window.location.href = url;					
								
			});
	
	});
		$('#savehistory').click(function(e){
		e.preventDefault();

		//var data = $('#appform').serialize();
		$.ajax({
			  type: "POST",
			  cache: false,
			  url: "/index.cfm?event=app.saveapphistory&application_id=<cfoutput>#application_id#</cfoutput>"

			}).success(function(resp) {
				if (resp = 'success'){
					alert("History Saved");
				 //$('#clientform').get(0).reset();
				 //destroy and recreate dateboxes because form reset fucks 'em up.
				 $(".datebox").wijinputdate("destroy");
					$(".datebox").wijinputdate(
					{
						showTrigger: true
					});					 
				
				}
				else{
					alert('There was an error');
				}
				 
				
			});
	
	});
		
	$('#printapp').click(function(e) {
		e.preventDefault();		
		//$('#save').trigger('click');				 
		var height = $(window).height();
		var client_id = <cfoutput>#client_id#</cfoutput>;
        var url = '<cfoutput>#cgi.SCRIPT_NAME#?#cgi.QUERY_STRING#&print</cfoutput>'
        var windowName = "PrintApp";
        var windowSize = "width=910,scrollbars=yes,toolbar=yes,height=" + height
 
        window.open(url, windowName, windowSize);	    			 
	});
<!---<cfif isDefined("rc.rating")>	
	$('#ratebutton').click(function(e) {
		e.preventDefault();	
		var client_id = <cfoutput>#client_id#</cfoutput>;
		var application_id = <cfoutput>#rc.application_id#</cfoutput>;
		var location_id = <cfoutput>#rc.rating.location_id#</cfoutput>;
		var rating_id = <cfoutput>#rc.rating.ratingid#</cfoutput>;
        //var url = '/index.cfm?event=app&print&client_id='+client_id;
		var url = '/index.cfm?event=main.ratings&application_id='+application_id+'&location_id='+location_id+'&ratingid='+rating_id+'&client_id='+client_id;
        var windowName = "Rating";
 
        window.open(url, windowName);	    			 
	});	
</cfif>	--->
	$('#ViewNI').click(function(e) {
		e.preventDefault();						 
		var height = $(window).height();
        var url = '/index.cfm?event=app.niList&client_id=<cfoutput>#client_id#</cfoutput>&pagetitle=Additional Named Insureds'
        var windowName = "ViewNIWindow";
        var windowSize = "width=910,scrollbars=yes,toolbar=no,height=" + height
 
        window.open(url, windowName, windowSize);	    			 
	});
//auto total courts
$('.courts').blur(function() {
updateTotals();
});	
//auto total pools
$('.pools').blur(function() {
updateTotals();
});	
//auto total beds
$('.beds').blur(function() {
updateTotals();
});	

});//end document ready
function updateTotals() {
	var total = 0;						 
	$('.courts').each(function() {		
		var value = parseFloat($(this).autoNumericGet());		
		total = total + value;				
	 });
	$('#court_total').autoNumericSet(total);
	var total = 0;						 
	$('.pools').each(function() {		
		var value = parseFloat($(this).autoNumericGet());		
		total = total + value;				
	 });
	$('#pool_total').autoNumericSet(total);	
	var total = 0;						 
	$('.beds').each(function() {		
		var value = parseFloat($(this).autoNumericGet());		
		total = total + value;				
	 });
	$('#beds_total').autoNumericSet(total);		
}
</script>
<cfif isDefined('print')>
<style>
input[type='checkbox'] {
-moz-appearance: none;
width:15px;
height:15px;
}
* {
	background: transparent !important;
	color: black !important;
	text-shadow: none !important;
	filter:none !important;
	-ms-filter: none !important;
} /* Black prints faster: sanbeiji.com/archives/953 */
p a, p a:visited {
	color: #444 !important;
	text-decoration: underline;
}
p a[href]:after {
	content: " (" attr(href) ")";
}
abbr[title]:after {
	content: " (" attr(title) ")";
}
 .ir a:after, a[href^="javascript:"]:after, a[href^="#"]:after {
content: "";
}  /* Don't show links for images, or javascript/internal links */
pre, blockquote {
	border: 1px solid #999;
	page-break-inside: avoid;
}
thead {
	display: table-header-group;
} /* css-discuss.incutio.com/wiki/Printing_Tables */
tr, img {
	page-break-inside: avoid;
}
 @page {
margin: 0.5cm;
}
p, h2, h3 {
	orphans: 3;
	widows: 3;
}
h2, h3 {
	page-break-after: avoid;
}
.hide-on-print {
	display: none !important;
}
.print-only {
	display: block !important;
}

.ui-widget-content {
border-color:#000000;
color:#000000;
}

.wijmo-wijtextbox {
padding:3px;
border-color:#000000 !important;
color:#000000 !important;
text-align:right;
background-color:#ffffff !important;
}
#appcontainer .wijmo-wijtextbox {
	background-color:#ffffff !important;
}

.pblast .wijmo-wijtextbox {
width:70px;
color:#000000 !important;
}
.wijmo-checkbox .wijmo-checkbox-box, div.wijmo-wijradio-box {
	border-color:#000000;
margin-top:-1px !important;
height:15px;

}

.wijmo-wijinput {
border:1px solid #000000 !important;
}
.wijmo-wijtextbox.ui-state-focus{
background-color: #ffffff !important;
border-color:#000000 !important;
color:#000000 !important;
}
.buttons {
	display:none !important;
}
.formfields {
border-color:#000000 !important;
}
#appcontainer ul.appul8 {
width:224px;
padding-right:0;	
overflow:hidden;
}
.grayborder {
	border-color:#000000;
}
#appcontainer ul.effdate {
	width:858px !important;
}
.appcontact2 {

}

.appul15 {
width:504px !important;
}
.appul16 {
width:339px !important;
}
.selectbox2 {
	border-color:#000000 !important;
}

    @media print {
        div.divFooter {
            position: fixed;
            bottom: 0;
        }
    }
.footerspacer {
opacity:0;
font-size:11px;
}
#addWC {
	display:none;
}
</style>
</cfif>