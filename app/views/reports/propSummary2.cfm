<script>
$(document).ready(function() {
	$('#statesub').click(function(e) {	
		e.preventDefault();
		client_id = <cfoutput>#client_id#</cfoutput>;
		state_id = $('#state_id').val();
		if (state_id == 0) {
			report_title = 'Property Summary Totals by State';
		}
		else {
			report_title = 'Property Summary Totals for One State';
		}
		$.ajax({
            url: '/index.cfm?event=reports.createReport',
            type: "post",
			//set async to false to false to force the loop to wait for the ajax response before continuing
			async:false,
            data: { client_id : client_id,
					state_id : state_id,
					report_title : report_title,
					template: 'report_propsummary'
			},
            dataType: 'json',
            success: function(data){
			  var checkresult = data.indexOf("Fitness");
			  if (checkresult == 0) {
				 var filelink = 'Report Complete: <a href="/reports/'+data+'" target="_blank">'+data+'</a>'; 
				 var embedlink = '/reports/'+data;
              $('#proposalresult').html(filelink).slideDown();
			  //embedPDF(embedlink);
				$('#pdfembed').html(filelink);
			  $('#statesub').removeClass('ui-state-focus');
			  }

            },
			error: function(jqXHR, textStatus, errorThrown) {
			alert(errorThrown);	
			}
          });	

	});
}); //end document ready

  function embedPDF(url){
	//get location of pdfembed div
	var eTop = 140;
	var windowheight = $(window).height();
	var divheight = Math.round(windowheight - eTop - 40);
	//$('#pdfembed').css('height', divheight);
    var myPDF = new PDFObject({ 

      url: url,
	  width: 1088,
	  height: divheight

    }).embed('pdfembed'); 
    // Be sure your document contains an element with the ID 'pdfembed' 

  }
</script>
  <div id="statusbar">
  <div id="pagename"><cfoutput>#rc.title# - #rc.client.entity_name#</cfoutput></div>
  <div id="statusstuff">  
  </div><!---End Statusstuff--->
  </div><!---End statusbar---> 

<div class="msgcontainer">
<div class="message"></div>
</div>
  <form id="stateform" method="post" action="/index.cfm?event=reports.createReport" autocomplete="off">
<ul class="formfields txtleft" style="margin:10px 0 10px;">
<input type="hidden" name="client_id" id="client_id" value="<cfoutput>#URL.client_id#</cfoutput>" />
<li class="clear"><label class="width-120">Select State</label></li>
<li><select id="state_id" name="state_id" class="selectbox2" style="width:100px;">
<option value="0">All States</option>
	<cfloop query="rc.states">
	<cfoutput><option value="#state_id#">#name#</option></cfoutput>
	</cfloop></select>
  </li>

 <li class="clear"><label>&nbsp;</label></li> 
 <li class="clear"><input type="submit" name="statesub" id="statesub" class="buttons" value="RUN REPORT"></li> 

 </ul> 

</form>
<div id="pdfembed" style="clear:both;"></div>