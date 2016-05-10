<script>
$(document).ready(function() {
populateSelect();
createAccordion();
$('input[name=filterradio]').click(function() {
	populateSelect();
	createAccordion();
});
$('#parent_company_id').change(function() {
		$(".message").html("Changes Saved").slideUp();								
		var id = $(this).val();	
		$("#disabled").prop("checked",false);
		$("#disabled").wijcheckbox("refresh");
	if (id == 0) {
	    $('#parentcompanyform')[0].reset();
		$('#parent_company_id').val(0);
		
		
	}
	else {
		
	$.ajax({
		type: "GET",
		url: "/index.cfm?event=main.getParentCompanies",
		dataType: "json",
		data: {
			parent_company_id: id
		}
	}).success(function(response) {
		
		$.each(response.data, function(k,v) {	
			if (v.disabled == 1) {
			$('#disabled').prop("checked", true);
			$("#disabled").wijcheckbox("refresh");
			}
			$('#parent_company_name').val(v.parent_company_name);

		});
					 
					
	});	
	
	}
	
 });
//end parent_company_id change
$('#issuing_company_id').change(function() {
		$(".message").html("Changes Saved").slideUp();
		var id = $(this).val();	
		$("#disabled2").prop("checked",false);
		$("#disabled2").wijcheckbox("refresh");
	if (id == 0) {
	    $('#issuingcompanyform')[0].reset();
		$('#issuing_company_id').val(0);		
		
	}
	else {
		
	$.ajax({
		type: "GET",
		url: "/index.cfm?event=main.getIssuingCompanies",
		dataType: "json",
		data: {
			issuing_company_id: id
		}
	}).success(function(response) {
		
		$.each(response.data, function(k,v) {	
			if (v.disabled == 1) {
			$('#disabled2').prop("checked", true);
			$("#disabled2").wijcheckbox("refresh");
			}
			$('#name').val(v.name);
			$('#code').val(v.code);
			$('#parent_company_id2').val(v.parent_company_id);
		});
					 
					
	});	
	
	}
	
 });
//end issuing company change
	var validator = $("#parentcompanyform").validate({
		rules: {
			parent_company_name: {
				required: true
				}
		},
		messages: {
			parent_company_name: {
				required: "*"
			}			
		},
		submitHandler: function() {
			var data = $('#parentcompanyform').serialize();
			$(".message").html("Changes Saved").slideUp();
			$.ajax({
			  type: "POST",
			  cache: false,
			  url: "/index.cfm?event=main.saveParentCompany",
			  data: data

			}).success(function(resp) {
				if (resp = 'success'){
				 populateSelect();
				 saveAlert();
				 createAccordion();
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
//end validation
	var validator2 = $("#issuingcompanyform").validate({
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
			var data = $('#issuingcompanyform').serialize();
			$(".message").html("Changes Saved").slideUp();
			
			$.ajax({
			  type: "POST",
			  cache: false,
			  url: "/index.cfm?event=main.saveIssuingCompany",
			  data: data

			}).success(function(resp) {
				if (resp = 'success'){
				 populateSelect();
				 saveAlert();
				 createAccordion();
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
//end validation2	
            

});
//end document.ready

populateSelect = function() {
	var filter = getFilter();
$('#parentcompanyform')[0].reset();
$('#issuingcompanyform')[0].reset();
$(":input[type='checkbox']").wijcheckbox("refresh");
$('.pc').find('option').remove().end();
$('#parent_company_id').append('<option value="0">Add New Parent Company</option>').val(0);
$('#issuing_company_id').find('option').remove().end().append('<option value="0">Add New Issuing Company</option>').val(0);
$.ajax({
	type: "GET",
	url: "/index.cfm?event=main.getParentCompanies&filter="+filter,
	dataType: "json"
}).success(function(response) {
	var html = '';
    $.each(response.data, function(k,v) {
		if (v.parent_company_id != undefined)
		{
        html += '<option value="' + v.parent_company_id + '">' + v.parent_company_name + '</option>';
		}
	});
	$('.pc').append(html);			 
				
});
//populate issuing company select
$.ajax({
	type: "GET",
	url: "/index.cfm?event=main.getIssuingCompanies&filter="+filter,
	dataType: "json"
}).success(function(response) {
	var html = '';
    $.each(response.data, function(k,v) {
		if (v.issuing_company_id != undefined)
		{
        html += '<option value="' + v.issuing_company_id + '">' + v.name + '</option>';
		}
	});
	$('#issuing_company_id').append(html);			 
				
});
}
createAccordion = function() {
	var filter = getFilter();
$("#accordion").wijaccordion("destroy");
$('#accordion').html('');
$.ajax({
	type: "GET",
	url: "/index.cfm?event=main.getCompanyAccordion&filter="+filter,
	dataType: "json"
}).success(function(response) {
	var html = '';
	var title = '';
    $.each(response.data, function(k,v) {
		if (title == '') {
			var div = '';
		}
		else {
		var div = '</ul></div>';	
		}
		if (v.parent_company_name != title)
		{		
        html += div + '<h3><a href="#">' + v.parent_company_name + '</a></h3><div><ul><li>' + v.name + '</li>';
		title = v.parent_company_name;
		}
		else {
		html += '<li>' + v.name + '</li>';	
		}
	});
	$('#accordion').append(html);			 
	$("#accordion").wijaccordion({requireOpenedPane: false});			
});

	
}

</script>

<div id="statusbar">
  <div id="pagename">Parent/Issuing Company Administration</div>
  <div id="statusstuff"> </div>
  <!---End Statusstuff--->
</div>
<!---End statusbar--->
<div class="msgcontainer">
<div class="message"></div>
</div>




  
<ul class="formfields txtleft" style="margin:10px 0 10px; width:335px;">
<li class="clear"><label class="">Filter</label></li>
<li><input type="radio" id="filterall" name="filterradio" value="all"></li>
<li><label>All&nbsp;&nbsp;&nbsp;</label></li>
<li><input type="radio" id="filteractive" name="filterradio" checked="checked" value="active"></li>
<li><label>Active&nbsp;&nbsp;&nbsp;</label></li>
<li><input type="radio" id="filterdisabled" name="filterradio" value="disabled"></li>
<li><label>Disabled</label></li>
<form id="parentcompanyform" method="post" autocomplete="off">
<li class="clear"><label class="bold">Parent Companies</label></li>

<li class="clear"><label class="width-120">Select Parent Company</label></li>
<li><select name="parent_company_id" id="parent_company_id" class="selectbox2 pc" style="width:158px;">
  </select>
  </li>
 <li class="clear"><label>&nbsp;</label></li> 
 <li class="clear"><label class="width-120">Name</label></li>
 <li><input type="text" name="parent_company_name" id="parent_company_name" class="width-150" /></li>

 <li class="clear"><label>&nbsp;</label></li> 
 <li class="clear"><input type="checkbox" name="disabled" id="disabled" value="1" /></li>
 <li><label>Disabled</label></li>
 <li class="clear"><label>&nbsp;</label></li> 
 <li class="clear"><input type="submit" name="typesub" class="buttons" value="SAVE"></li> 
 </ul> 
</form>
  <form id="issuingcompanyform" method="post">
<ul class="formfields txtleft" style="margin:10px 0 10px; width:335px;">
<li class="clear"><label>&nbsp;</label></li>
<li class="clear"><label class="bold">Issuing Companies</label></li>
<li class="clear"><label class="width-120">Select Issuing Company</label></li>
<li><select name="issuing_company_id" id="issuing_company_id" class="selectbox2" style="width:158px;">
  </select>
  </li>
 <li class="clear"><label>&nbsp;</label></li> 
 <li class="clear"><label class="width-120">Name</label></li>
 <li><input type="text" name="name" id="name" class="width-150" /></li>
<li class="clear"><label class="width-120">Parent Company</label></li>
 <li><select name="parent_company_id2" id="parent_company_id2" class="selectbox2 pc" style="width:158px;">
  </select>
  </li>
 <li class="clear"><label class="width-120">Code</label></li>
 <li><input type="text" name="code" id="code" class="width-150" /></li>
 <li class="clear"><label>&nbsp;</label></li> 
 <li class="clear"><input type="checkbox" name="disabled2" id="disabled2" value="1" /></li>
 <li><label>Disabled</label></li>
 <li class="clear"><label>&nbsp;</label></li> 
 <li class="clear"><input type="submit" name="icsub" class="buttons" value="SAVE"></li> 
 </ul> 
</form>
<div id="accordion" style="float:left;width:420px; margin-top:30px;">
</div>

<div id="dialog-confirm" title="Delete User?">
  <p> <span class="ui-icon ui-icon-alert"></span> Are you sure you want to delete this user?</p>
</div>