<script>
$(document).ready(function() {
populateSelect();
$('#employee_dishonesty_id').change(function() {
		var id = $(this).val();	
		$(":input[type='checkbox']").prop("checked",false);
		$(":input[type='checkbox']").wijcheckbox("refresh");
	if (id == 0) {
	    $('#limitsform')[0].reset();
		$('#employee_dishonesty_id').val(0);
		
		
	}
	else {
		
	$.ajax({
		type: "GET",
		url: "/index.cfm?event=main.getEmployeeDishonesty",
		dataType: "json",
		data: {
			employee_dishonesty_id: id
		}
	}).success(function(response) {
		
		$.each(response.data, function(k,v) {	
			if (v.disabled == 1) {
			$('#disabled').prop("checked", true);
			$("#disabled").wijcheckbox("refresh");
			}
			$('#employee_dishonesty_amount').val(v.employee_dishonesty_amount);

		});
					 
					
	});	
	
	}
	
 });
//end employee_dishonesty_id change

	var validator = $("#limitsform").validate({
		rules: {
			employee_dishonesty_amount: {
				required: true
				}

		},
		messages: {
			employee_dishonesty_amount: {
				required: "*"
			}			
		},

		submitHandler: function() {
			var data = $('#limitsform').serialize();
			
			$.ajax({
			  type: "POST",
			  cache: false,
			  url: "/index.cfm?event=main.saveEmployeeDishonesty",
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
$('#employee_dishonesty_id').find('option').remove().end().append('<option value="0">Add new</option>').val(0);
$.ajax({
	type: "GET",
	url: "/index.cfm?event=main.getEmployeeDishonesty",
	dataType: "json"
}).success(function(response) {
	var html = '';
    $.each(response.data, function(k,v) {
		if (v.employee_dishonesty_id != undefined)
		{
        html += '<option value="' + v.employee_dishonesty_id + '">' + v.employee_dishonesty_amount + '</option>';
		}
	});
	$('#employee_dishonesty_id').append(html);			 
				
});
	
}



</script>

<div id="statusbar">
  <div id="pagename">Employee Dishonesty Administration</div>
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
<li><select name="employee_dishonesty_id" id="employee_dishonesty_id" class="selectbox2" style="width:158px;">
  </select>
  </li>
 <li class="clear"><label>&nbsp;</label></li> 
 <li class="clear"><label class="width-120">Name</label></li>
 <li><input type="text" name="employee_dishonesty_amount" id="employee_dishonesty_amount" class="width-150" /></li>
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