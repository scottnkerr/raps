<script>
$(document).ready(function() {
populateSelect();
$('#edp_amount_id').change(function() {
		var id = $(this).val();	
		$(":input[type='checkbox']").prop("checked",false);
		$(":input[type='checkbox']").wijcheckbox("refresh");
	if (id == 0) {
	    $('#limitsform')[0].reset();
		$('#edp_amount_id').val(0);
		
		
	}
	else {
		
	$.ajax({
		type: "GET",
		url: "/index.cfm?event=main.getEDP",
		dataType: "json",
		data: {
			edp_amount_id: id
		}
	}).success(function(response) {
		
		$.each(response.data, function(k,v) {	
			if (v.disabled == 1) {
			$('#disabled').prop("checked", true);
			$("#disabled").wijcheckbox("refresh");
			}
			$('#edp_amount').val(v.edp_amount);

		});
					 
					
	});	
	
	}
	
 });
//end edp_amount_id change

	var validator = $("#limitsform").validate({
		rules: {
			edp_amount: {
				required: true
				}

		},
		messages: {
			edp_amount: {
				required: "*"
			}			
		},

		submitHandler: function() {
			var data = $('#limitsform').serialize();
			
			$.ajax({
			  type: "POST",
			  cache: false,
			  url: "/index.cfm?event=main.saveEDP",
			  data: data

			}).success(function(resp) {
				if (resp = 'success'){
				 populateSelect();
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
$('#limitsform')[0].reset();
$(":input[type='checkbox']").wijcheckbox("refresh");
$('#edp_amount_id').find('option').remove().end().append('<option value="0">Add new</option>').val(0);
$.ajax({
	type: "GET",
	url: "/index.cfm?event=main.getEDP",
	dataType: "json"
}).success(function(response) {
	var html = '';
    $.each(response.data, function(k,v) {
		if (v.edp_amount_id != undefined)
		{
        html += '<option value="' + v.edp_amount_id + '">' + v.edp_amount + '</option>';
		}
	});
	$('#edp_amount_id').append(html);			 
				
});
	
}



</script>

<div id="statusbar">
  <div id="pagename">EDP Administration</div>
  <div id="statusstuff"> </div>
  <!---End Statusstuff--->
</div>
<!---End statusbar--->

<div class="msgcontainer">
<div class="message"></div>
</div>
  <form id="limitsform" method="post" autocomplete="off">
<ul class="formfields txtleft" style="margin:10px 0 10px;">
<li class="clear"><label class="width-120">Select</label></li>
<li><select name="edp_amount_id" id="edp_amount_id" class="selectbox2" style="width:158px;">
  </select>
  </li>
 <li class="clear"><label>&nbsp;</label></li> 
 <li class="clear"><label class="width-120">Name</label></li>
 <li><input type="text" name="edp_amount" id="edp_amount" class="width-150" /></li>
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