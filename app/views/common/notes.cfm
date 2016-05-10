
<cfparam name="client_id" default="0">
<script>
$(document).ready(function () {
	var id = <cfoutput>#session.auth.id#</cfoutput>
	//get users pin pref
	$.ajax({
		type: "GET",
		url: "/index.cfm?event=main.getUsers",
		dataType: "json",
		data: {
			user_id: id
		}
	}).success(function(response) {
		$.each(response.data, function(k,v) {	
		if (v.pinsticky === 1) {
		var defaultpos = 0;	
		}
		else {
		var defaultpos = -240;	
		}
		$('#noteslider').css('right',defaultpos);
		});			
	});	
	//get notes
	$.ajax({
		type: "GET",
		url: "/index.cfm?event=main.getNotes",
		dataType: "json",
		data: {
			client_id: <cfoutput>#client_id#</cfoutput>
		}
	}).success(function(response) {
		$.each(response.data, function(k,v) {	
		$('#client_notes').val(v.client_notes);
		});			
	});		
	
	//note slider behavior	
	$('#noteicon').click(function() {
    var notespos = $('#noteslider').css('right');
	if (notespos == '0px') {
		var newpos = -240;
		//update user prefs
		$.ajax({
			type: "POST",
			url: "/index.cfm?event=main.saveSticky",
			dataType: "json",
			data: {
				user_id: <cfoutput>#session.auth.id#</cfoutput>,
				pinsticky: 0
			}
		}).success(function(response) {
		//alert(response);
		});			
	}
	else {
		var newpos = 0
	}
    	$('#noteslider').animate({
     	 right: newpos
    	});
  	});
	$('#savenote').click(function(e) {
		e.preventDefault();						  
		var client_id = <cfoutput>#client_id#</cfoutput>;
		client_notes = $("#client_notes").val();
		$.ajax({
			type: "POST",
			url: "/index.cfm?event=main.saveNotes",
			dataType: "json",
			data: {
				client_id: client_id,
				client_notes: client_notes
			}
		}).success(function(response) {
				   saveAlert();
				  
		});								  
	});
	$('#pinme').click(function(e) {
		e.preventDefault();						  
		$.ajax({
			type: "POST",
			url: "/index.cfm?event=main.saveSticky",
			dataType: "json",
			data: {
				user_id: <cfoutput>#session.auth.id#</cfoutput>,
				pinsticky: 1
			}
		}).success(function(response) {
		//alert(response);
		});								  
	});	
});
</script>

  <div id="noteslider"> <img id="noteicon" src="/images/notesicon.png">
  <a href="#" title="Pin Sticky Note" id="pinme"><img src="/images/pin.png" id="stickypin"></a>
    <div id="notecontainer">
    <div class="message" style="margin-bottom:5px;"></div>
    <form id="notesform" method="post" autocomplete="off">
    <textarea name="client_notes" id="client_notes"></textarea>
    <button class="buttons" name="savenote" id="savenote" style="margin-top:15px;">SAVE</button>
    </form>
    </div>
  </div>