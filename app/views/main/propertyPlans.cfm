<script>
$(document).ready(function() {
populateSelect();
$('#property_plan_id').change(function() {
		id = $(this).val();	
		$(":input[type='checkbox']").prop("checked",false);
		$(":input[type='checkbox']").wijcheckbox("refresh");
		$('.dyna').val('');
		$('.dynaids').val(0);
	if (id == 0) {
	    $('#limitsform')[0].reset();
		$('#property_plan_id').val(0);
		$('#property_emp_id').val(0);
	}
	else {
		
	$.ajax({
		type: "GET",
		url: "/index.cfm?event=main.getPropertyPlans",
		dataType: "json",
		data: {
			property_plan_id: id
		}
	}).success(function(response) {
		
		$.each(response.data, function(k,v) {	
			if (v.proposal_hide == 1) {
			$('#proposal_hide').prop("checked", true);;
			}
			if (v.disabled == 1) {
			$('#disabled').prop("checked", true);;
			}			
			$('#property_plan_name').val(v.property_plan_name);
			//$('#prop_premium').autoNumericSet(v.prop_premium);
			$('#prop_agencyfee').autoNumericSet(v.prop_agencyfee);
			$('#prop_terrorism').autoNumericSet(v.prop_terrorism);
			$('#prop_eqpbrkrate').autoNumericSet(v.prop_eqpbrkrate);

		});
		$.ajax({
			type: "GET",
			url: "/index.cfm?event=main.getPropCyber",
			dataType: "json",
			data: {
				property_plan_id: id
			}	
		}).success(function(response) {
			
			$.each(response.data, function(k,v) {	
				thisfield =	$('#cid_'+v.cyber_liability_amount_id);
				nextfield = thisfield.next();
				thisfield.autoNumericSet(v.property_cyber_amount);
				nextfield.val(v.property_cyber_id);
			});			
			$.ajax({
				type: "GET",
				url: "/index.cfm?event=main.getPropEmp",
				dataType: "json",
				data: {
					property_plan_id: id
				}	
			}).success(function(response) {
				
				$.each(response.data, function(k,v) {	
					thisfield =	$('#eid_'+v.employee_dishonesty_id);
					nextfield = thisfield.next();
					thisfield.autoNumericSet(v.property_emp_amount);
					nextfield.val(v.property_emp_id);
				});				
			});						 
			
		});						 
					
	});

	
	}
	
 });
//end property_plan_id change

	var validator = $("#limitsform").validate({
		rules: {
			property_plan_name: {
				required: true
				}

		},
		messages: {
			property_plan_name: {
				required: "*"
			}			
		},

		submitHandler: function() {
			property_plan_id = $('#property_plan_id').val();
			var data = $('#limitsform').serialize();
			
			$.ajax({
			  type: "POST",
			  cache: false,
			  url: "/index.cfm?event=main.savePropertyPlans",
			  data: data

			}).success(function(resp) {
				var gotnewid = $.isNumeric(resp);
				if (gotnewid == true) {
					
					pid = resp;
				}
				else {
					pid = property_plan_id;
				}
				//number of cyber fields
				total1 = $('.propcyber').nextAll();
				count1 = total1.length;
				//number of emp disho fields
				total2 = $('.propempdishonesty').nextAll();
				count2 = total2.length;
				if (count1 > count2) {
					count = count1
				}
				else {
					count = count2
				}
			
				$('.propcyber').each(function() {
				
				var cyber_liability_amount_id = $(this).attr('cid');				
				var property_cyber_amount = $(this).autoNumericGet();
				var property_cyber_id = $(this).next().val();
				$.ajax({
				  type: "POST",
				  cache: false,
				  url: "/index.cfm?event=main.savePropertyCyber",
				  data: {
					property_plan_id: pid,
					cyber_liability_amount_id: cyber_liability_amount_id,
					property_cyber_amount: property_cyber_amount,
					property_cyber_id: property_cyber_id
				  }
	
				}).success(function(resp) {

					
				});
			
				});
				start = 0;
				$('.propempdishonesty').each(function() {
				start = start + 1;
				var employee_dishonesty_id = $(this).attr('eid');
				var property_emp_amount = $(this).autoNumericGet();
				var property_emp_id = $(this).next().val();
				$.ajax({
				  type: "POST",
				  cache: false,
				  url: "/index.cfm?event=main.savePropertyEmp",
				  data: {
					property_plan_id: pid,
					employee_dishonesty_id: employee_dishonesty_id,
					property_emp_amount: property_emp_amount,
					property_emp_id: property_emp_id
				  }
	
				}).success(function(resp) {
					 
					
				});
					 if (start >= count2) {
				 populateSelect();
				 saveAlert();
					 }				
				});					
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
	var currentselect = $('#property_plan_id').val();

$('#limitsform')[0].reset();
$(":input[type='checkbox']").wijcheckbox("refresh");
$('#property_plan_id').find('option').remove().end().append('<option value="0">Add new</option>').val(0);
$.ajax({
	type: "GET",
	url: "/index.cfm?event=main.getPropertyPlans",
	dataType: "json"
}).success(function(response) {
	var html = '';
    $.each(response.data, function(k,v) {
		if (v.property_plan_id != undefined)
		{
        html += '<option value="' + v.property_plan_id + '">' + v.property_plan_name + '</option>';
		}
	});
	$('#property_plan_id').append(html);			 
	$('#property_plan_id').val(currentselect).trigger('change');				
});
	
}



</script>

<div id="statusbar">
  <div id="pagename">Property Plan Administration</div>
  <div id="statusstuff"> </div>
  <!---End Statusstuff--->
</div>
<!---End statusbar--->

<div class="msgcontainer">
<div class="message"></div>
</div>
  <form id="limitsform" method="post" autocomplete="off">
<ul class="formfields" style="margin:10px 0 10px;">
<li class="clear"><label class="width-120">Select</label></li>
<li><select name="property_plan_id" id="property_plan_id" class="selectbox2" style="width:158px;">
  </select>
  </li>
 <li class="clear"><label>&nbsp;</label></li> 
 <li class="clear"><label class="width-120">Name</label></li>
 <li><input type="text" name="property_plan_name" id="property_plan_name" class="width-150 txtleft" /></li>
 <!--- <li class="clear"><label class="width-120">Premium</label></li>
 <li><input type="text" name="prop_premium" id="prop_premium" class="width-80 dollarmask" /></li>--->
  <li class="clear"><label class="width-120">Agency Fee</label></li>
 <li><input type="text" name="prop_agencyfee" id="prop_agencyfee" class="width-80 percentdecmask" /></li>
  <li class="clear"><label class="width-120">Terrorism Fee</label></li>
 <li><input type="text" name="prop_terrorism" id="prop_terrorism" class="width-80 percentdecmask" /></li> 
  <li class="clear"><label class="width-120">Equipment Breakdown</label></li>
 <li><input type="text" name="prop_eqpbrkrate" id="prop_eqpbrkrate" class="width-80 percentdecmask" /></li>  
 <li class="clear"><label>&nbsp;</label></li> 
 <li class="clear"><input type="checkbox" name="proposal_hide" id="proposal_hide" value="1" /></li>
 <li><label>Proposal Override</label></li> 
 <li class="clear"><label>&nbsp;</label></li> 
 <li class="clear"><input type="checkbox" name="proposal_hide" id="proposal_hide" value="1" /></li>
 <li><label>Disabled</label></li>

 <li class="clear"><label>&nbsp;</label></li> 
 <li class="clear"><input type="submit" name="typesub" class="buttons" value="SAVE"></li> 
 </ul> 
<ul class="formfields" style="margin:10px 0 10px;">
<li class="clear"><label class="bold">Cyber Liability Values</label></li>

<cfoutput query="rc.cyber"><li class="clear"><label class="width-150">#cyber_liability_amount#</label></li><li>
<input type="text" name="prop_cyberamount" id="cid_#cyber_liability_amount_id#" class="propcyber width-80 dollarmask dyna" cid="#cyber_liability_amount_id#" />
<input type="hidden" name="property_cyber_id" value="0" class="dynaids" />
</li>
</cfoutput>

<li class="clear"><label class="bold">Employee Dishonesty Values</label></li>
<cfoutput query="rc.empdishonesty"><li class="clear"><label class="width-150">#employee_dishonesty_amount#</label></li><li>
<input type="text" name="prop_empdishonestyamount" id="eid_#employee_dishonesty_id#" class="propempdishonesty width-80 dollarmask dyna" eid="#employee_dishonesty_id#" />
<input type="hidden" name="property_emp_id" value="0" class="dynaids" />
</li>
</cfoutput>
</ul>
</form>

<div id="dialog-confirm" title="Delete User?">
  <p> <span class="ui-icon ui-icon-alert"></span> Are you sure you want to delete this user?</p>
</div>