<script>
$(document).ready(function() {
populateSelect();
$('#employee_rec_benefits_id').change(function() {
		var id = $(this).val();	
		$(":input[type='checkbox']").prop("checked",false);
		$(":input[type='checkbox']").wijcheckbox("refresh");
	if (id == 0) {
	    $('#limitsform')[0].reset();
		$('#employee_rec_benefits_id').val(0);
		
		
	}
	else {
		
	$.ajax({
		type: "GET",
		url: "/index.cfm?event=main.getEmployeeBenefits",
		dataType: "json",
		data: {
			employee_rec_benefits_id: id
		}
	}).success(function(response) {
		
		$.each(response.data, function(k,v) {	
			if (v.disabled == 1) {
			$('#disabled').prop("checked", true);
			$("#disabled").wijcheckbox("refresh");
			}
			$('#employee_rec_benefits').val(v.employee_rec_benefits);

		});
					 
					
	});	
	
	}
	
 });
//end employee_rec_benefits_id change

	var validator = $("#limitsform").validate({
		rules: {
			employee_rec_benefits: {
				required: true
				}

		},
		messages: {
			employee_rec_benefits: {
				required: "*"
			}			
		},

		submitHandler: function() {
			var data = $('#limitsform').serialize();
			
			$.ajax({
			  type: "POST",
			  cache: false,
			  url: "/index.cfm?event=main.saveEmployeeBenefits",
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
$('#employee_rec_benefits_id').find('option').remove().end().append('<option value="0">Add new</option>').val(0);
$.ajax({
	type: "GET",
	url: "/index.cfm?event=main.getEmployeeBenefits",
	dataType: "json"
}).success(function(response) {
	var html = '';
    $.each(response.data, function(k,v) {
		if (v.employee_rec_benefits_id != undefined)
		{
        html += '<option value="' + v.employee_rec_benefits_id + '">' + v.employee_rec_benefits + '</option>';
		}
	});
	$('#employee_rec_benefits_id').append(html);			 
				
});
	
}



</script>

<div id="statusbar">
  <div id="pagename">Employees Receiving Benefits Administration</div>
  <div id="statusstuff"> </div>
  <!---End Statusstuff--->
</div>
<!---End statusbar--->

<div class="msgcontainer">
<div class="message"></div>
</div>
  <form id="limitsform" method="post" autocomplete="off">
<ul class="formfields txtleft" style="margin:10px 0 10px;">
<li class="clear"><label class="width-120">Please Select</label></li>
<li><select name="employee_rec_benefits_id" id="employee_rec_benefits_id" class="selectbox2" style="width:158px;">
  </select>
  </li>
 <li class="clear"><label>&nbsp;</label></li> 
 <li class="clear"><label class="width-120">Name</label></li>
 <li><input type="text" name="employee_rec_benefits" id="employee_rec_benefits" class="width-150" /></li>
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