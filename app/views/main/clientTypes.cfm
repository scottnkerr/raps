<script>
$(document).ready(function() {
populateSelect();
$('#client_type_id').change(function() {
		var id = $(this).val();	
		$(":input[type='checkbox']").prop("checked",false);
		$(":input[type='checkbox']").wijcheckbox("refresh");
	if (id == 0) {
	    $('#clienttypeform')[0].reset();
		$('#client_type_id').val(0);
		
		
	}
	else {
		
	$.ajax({
		type: "GET",
		url: "/index.cfm?event=main.getClientTypes",
		dataType: "json",
		data: {
			client_type_id: id
		}
	}).success(function(response) {
		
		$.each(response.data, function(k,v) {	
			if (v.disabled == 1) {
			$('#disabled').prop("checked", true);
			$("#disabled").wijcheckbox("refresh");
			}
			$('#type').val(v.type);

		});
					 
					
	});	
	
	}
	
 });
//end client_type_id change

	var validator = $("#clienttypeform").validate({
		rules: {
			type: {
				required: true
				}

		},
		messages: {
			type: {
				required: "*"
			}			
		},

		submitHandler: function() {
			var data = $('#clienttypeform').serialize();
			
			$.ajax({
			  type: "POST",
			  cache: false,
			  url: "/index.cfm?event=main.saveClientType",
			  data: data

			}).success(function(resp) {
				if (resp = 'success'){
				 populateSelect();
				 $(".message").html("Changes Saved").slideDown();
				 saveAlert();
				//resetStuff();
				//$('#select_plan').append('<option value="' + result + '" selected="selected">' + result + '</option>');
				//$('.selectbox').wijdropdown("refresh");
				}
				else{
					alert('There was an error');
				}
				 
				
			});
			
		},
		// set this class to error-labels to indicate valid fields
		success: function(label) {
			// set &nbsp; as text for IE
			label.html("&nbsp;").addClass("checked");
		}
	});

	
});
//end document.ready

populateSelect = function() {
var currentselect = $('#client_type_id').val();
	
$('#clienttypeform')[0].reset();
$(":input[type='checkbox']").wijcheckbox("refresh");
$('#client_type_id').find('option').remove().end().append('<option value="0">Add new type</option>').val(0);
$.ajax({
	type: "GET",
	url: "/index.cfm?event=main.getClientTypes",
	dataType: "json"
}).success(function(response) {
	var html = '';
    $.each(response.data, function(k,v) {
		if (v.client_type_id != undefined)
		{
        html += '<option value="' + v.client_type_id + '">' + v.type + '</option>';
		}
	});
	$('#client_type_id').append(html);			 
	$('#client_type_id').val(currentselect).trigger('change');				
});
	
}
</script>

<div id="statusbar">
  <div id="pagename">Entity Types Administration</div>
  <div id="statusstuff"> </div>
  <!---End Statusstuff--->
</div>
<!---End statusbar--->
<div class="msgcontainer">
<div class="message"></div>
</div>
  <form id="clienttypeform" method="post" autocomplete="off">
<ul class="formfields txtleft" style="margin:10px 0 10px;">
<li class="clear"><label class="width-120">Select Type</label></li>
<li><select name="client_type_id" id="client_type_id" class="selectbox2" style="width:158px;">
  </select>
  </li>
 <li class="clear"><label>&nbsp;</label></li> 
 <li class="clear"><label class="width-120">Type Name</label></li>
 <li><input type="text" name="type" id="type" class="width-150" /></li>
 <li class="clear"><label>&nbsp;</label></li> 
 <li class="clear"><input type="checkbox" name="disabled" id="disabled" value="1" /></li>
 <li><label>Disabled</label></li>
 <li class="clear"><label>&nbsp;</label></li> 
 <li class="clear"><input type="submit" name="typesub" class="buttons" value="SAVE"></li> 

 </ul> 

</form>

<div id="dialog-confirm" title="Delete User?">
  <p> <span class="ui-icon ui-icon-alert"></span> Are you sure you want to delete this user?</p>
</div>