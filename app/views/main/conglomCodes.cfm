<script>
$(document).ready(function() {
populateSelect();
$('#affiliation_id').change(function() {
		var id = $(this).val();	
		$(":input[type='checkbox']").prop("checked",false);
		$("#disabled").wijcheckbox("refresh");
	if (id == 0) {
	    $('#addconglomform')[0].reset();
		$('#affiliation_id').val(0);		
	}
	else {
		
	$.ajax({
		type: "GET",
		url: "/index.cfm?event=main.getConglom",
		dataType: "json",
		data: {
			affiliation_id: id
		}
	}).success(function(response) {
		
		$.each(response.data, function(k,v) {
			if (v.disabled == 1) {
			$('#disabled').prop("checked", true);
			$("#disabled").wijcheckbox("refresh");
			}
			if (v.name != undefined) {
			$('#name').val(v.name);
			}
			if (v.code != undefined) {
			$('#code').val(v.code);
			}		
		});
					 
					
	});	
	
	}
	
 });
//end affiliation_id change
	var validator = $("#addconglomform").validate({
		rules: {
			name: {
				required: true
				},
			code: {
				required: true
				}				
		},
		messages: {
			name: {
				required: "*"
			},
			code: {
				required: "*"
			}			
		},

		submitHandler: function() {
			var data = $('#addconglomform').serialize();
			
			$.ajax({
			  type: "POST",
			  cache: false,
			  url: "/index.cfm?event=main.saveConglom",
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
var currentselect = $('#affiliation_id').val();
$('#addconglomform')[0].reset();
$("#disabled").wijcheckbox("refresh");
$('#affiliation_id').find('option').remove().end().append('<option value="0">Add New Conglom Code</option>').val(0);
$.ajax({
	type: "GET",
	url: "/index.cfm?event=main.getConglom",
	dataType: "json"
}).success(function(response) {
	var html = '';
    $.each(response.data, function(k,v) {
		if (v.affiliation_id != undefined)
		{
        html += '<option value="' + v.affiliation_id + '">' + v.code + ' - ' + v.name + '</option>';
		}
	});
	$('#affiliation_id').append(html);			 
	$('#affiliation_id').val(currentselect).trigger('change');			
});
	
}
</script>

<div id="statusbar">
  <div id="pagename">Conglom Code Administration</div>
  <div id="statusstuff"> </div>
  <!---End Statusstuff--->
</div>
<!---End statusbar--->

<div class="msgcontainer">
<div class="message"></div>
</div>
  <form id="addconglomform" method="post" autocomplete="off">
<ul class="formfields txtleft" style="margin:10px 0 10px;">
<li class="clear"><label class="width-80">Select Conglom</label></li>
<li><select name="affiliation_id" id="affiliation_id" class="selectbox2" style="width:268px;">
  </select>
  </li>
 <li class="clear"><label>&nbsp;</label></li> 
 <li class="clear"><label class="width-80">Name</label></li>
 <li><input type="text" name="name" id="name" class="width-260" /></li>
  <li class="clear"><label class="width-80">Code</label></li>
 <li><input type="text" name="code" id="code" /></li>
 <li class="clear"><label>&nbsp;</label></li>  
 <li class="clear"><input type="checkbox" name="disabled" id="disabled" value="1" /></li>
 <li><label>Disabled</label></li>
 <li class="clear"><label>&nbsp;</label></li> 
 <li class="clear"><input type="submit" name="conglomsub" class="buttons" value="SAVE"></li> 
 </ul>
 </form>



<div id="dialog-confirm" title="Delete User?">
  <p> <span class="ui-icon ui-icon-alert"></span> Are you sure you want to delete this user?</p>
</div>