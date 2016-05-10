<script>
$(document).ready(function() {
	$('#sortable').sortable({
			handle: '.movebutton2'
	});
	$('#saveorder').click(function(e) {
		e.preventDefault();
		var sortorder = $('#sortable').sortable('serialize');
		
		idlist = [];
		$(sortorder.split("&")).each(function () {
		//strip out non numeric 									   
		var thisid = this.replace(/[^0-9]/g, ''); 
		idlist.push(thisid);
		});
		$('#sort_serialized').val(idlist);
		$.ajax({
            url: '/index.cfm?event=main.saveProposalOrder',
            type: "post",
            data: { idlist: $('#sort_serialized').val()
			},
            dataType: 'json',
            success: function(data){
			saveAlert();
			  }

		});			
	});
});
//end document ready
</script>

<div id="statusbar">
  <div id="pagename">Proposal Document Order Administration</div>
  <div id="statusstuff"> </div>
  <!---End Statusstuff--->
</div>
<!---End statusbar--->

<div class="msgcontainer">
<div class="message"></div>
</div>
  <form id="proposalform" method="post" action="/index.cfm?event=main.proposalCreate" autocomplete="off">
  
<input type="hidden" name="sort_serialized" id="sort_serialized" value="" />
<ul id="sortable" class="doclist txtleft" style="margin:10px 0 10px; min-height:20px;">
<cfoutput query="rc.proposaldocs">
<li class="clear" id="section_id_#rc.proposaldocs.proposal_doc_id#">
<div class="docname2">#rc.proposaldocs.proposal_doc_name#</div>
<img src="/images/movebutton.png" class="movebutton2" title="Click and drag to change document order" />
<div class="clear"></div>
</li>
</cfoutput>
</ul>
<button class="buttons" name="saveorder" id="saveorder">SAVE ORDER</button>
</form>

<div id="dialog-confirm" title="Delete User?">
  <p> <span class="ui-icon ui-icon-alert"></span> Are you sure you want to delete this user?</p>
</div>