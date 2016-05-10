<script>
$(document).ready(function() {
populateSelect();
$('#additional_limits_id').change(function() {
		var id = $(this).val();	
		$(":input[type='checkbox']").prop("checked",false);
		$(":input[type='checkbox']").wijcheckbox("refresh");
	if (id == 0) {
	    $('#limitsform')[0].reset();
		$('#additional_limits_id').val(0);
		
		
	}
	else {
		
	$.ajax({
		type: "GET",
		url: "/index.cfm?event=main.getAdditionalLimits",
		dataType: "json",
		data: {
			additional_limits_id: id
		}
	}).success(function(response) {
		
		$.each(response.data, function(k,v) {	
			if (v.disabled == 1) {
			$('#disabled').prop("checked", true);
			$("#disabled").wijcheckbox("refresh");
			}
			$('#additional_limits').val(v.additional_limits);

		});
					 
					
	});	
	
	}
	
 });
//end additional_limits_id change

	var validator = $("#limitsform").validate({
		rules: {
			additional_limits: {
				required: true
				}

		},
		messages: {
			additional_limits: {
				required: "*"
			}			
		},

		submitHandler: function() {
			var data = $('#limitsform').serialize();
			
			$.ajax({
			  type: "POST",
			  cache: false,
			  url: "/index.cfm?event=main.saveAdditionalLimits",
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
$('#additional_limits_id').find('option').remove().end().append('<option value="0">Add new limit</option>').val(0);
$.ajax({
	type: "GET",
	url: "/index.cfm?event=main.getAdditionalLimits",
	dataType: "json"
}).success(function(response) {
	var html = '';
    $.each(response.data, function(k,v) {
		if (v.additional_limits_id != undefined)
		{
        html += '<option value="' + v.additional_limits_id + '">' + v.additional_limits + '</option>';
		}
	});
	$('#additional_limits_id').append(html);			 
				
});
	
}



</script>

<div id="statusbar">
  <div id="pagename">Additional Limits Administration</div>
  <div id="statusstuff"> </div>
  <!---End Statusstuff--->
</div>
<!---End statusbar--->

<div class="msgcontainer">
<div class="message"></div>
</div>
  <form id="limitsform" method="post" autocomplete="off">
<ul class="formfields txtleft" style="margin:10px 0 10px;">
<li class="clear"><label class="width-120">Select Limit</label></li>
<li><select name="additional_limits_id" id="additional_limits_id" class="selectbox2" style="width:158px;">
  </select>
  </li>
 <li class="clear"><label>&nbsp;</label></li> 
 <li class="clear"><label class="width-120">Limit Name</label></li>
 <li><input type="text" name="additional_limits" id="additional_limits" class="width-150" /></li>
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