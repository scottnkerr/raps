<script>
$(document).ready(function() {

$('#printme').click(function(e) {
	e.preventDefault();
	//$('.buttonnav').hide();
	//window.print(); 
	var url = '/index.cfm?event=reports.printMailingLabels'
	window.open(url)
});

$('#clearme').click(function(e) {
	e.preventDefault();
			$.ajax({
			  type: "POST",
			  cache: false,
			  url: "/index.cfm?event=reports.clearPrintQueue"

			}).success(function(resp) {
				//alert(resp);				 
				alert('Queue cleared');
			});
});

}); //end document ready
</script>
<style>
    body {
        width: 8.5in;
        margin: 0in .1875in;
        }
    .label{
        /* Avery 5160 labels -- CSS and HTML by MM at Boulder Information Services */
        width: 2.025in; /* plus .6 inches from padding */
        height: .875in; /* plus .125 inches from padding */
        padding: .125in .3in 0;
        margin-right: .125in; /* the gutter */

        float: left;

        text-align: left;
        overflow: hidden;

        outline: 1px dotted; /* outline doesn't occupy space like border does */
        }
    .page-break  {
        clear: left;
        display:block;
        page-break-after:always;
        }
	.buttonnav {
	padding-bottom:20px;	
	}
    </style>
<!---<cfdump var="#rc.labels#">--->
<cfoutput>
<cfif rc.labels.recordcount>
<div class="buttonnav">
<button class="buttons" name="printme" id="printme">Print Labels</button>
<button class="buttons" name="clearme" id="clearme">Clear Queued Labels</button>
</div>

<cfloop query="rc.labels">
<div class="label">
#rc.labels.entity_name#<br />
#rc.labels.dba#<br />
#rc.labels.mailing_address#, #rc.labels.mailing_address2#<br />
#rc.labels.mailing_city#, #rc.labels.statename# #rc.labels.mailing_zip#
</div>
<cfif 30 MOD rc.labels.currentrow eq 1>
<div class="page-break"></div>
</cfif> 
</cfloop>
<cfelse>
There are no queued labels
</cfif>
</cfoutput>


