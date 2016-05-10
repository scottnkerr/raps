<script>
$(document).ready(function() {
populateSelect();
$('#state_id').change(function() {
		var id = $(this).val();	
		$(":input[type='checkbox']").prop("checked",false);
		$(":input[type='checkbox']").wijcheckbox("refresh");
	if (id == 0) {
	    $('#stateform')[0].reset();
		$('#state_id').val(0);
		
		
	}
	else {
		
	$.ajax({
		type: "GET",
		url: "/index.cfm?event=main.getStates",
		dataType: "json",
		data: {
			state_id: id
		}
	}).success(function(response) {
		
		$.each(response.data, function(k,v) {
			if (v.calculation == 'tax_premium_fees') {
			$('#tax_premium_fees').prop("checked", true);			
			}
			else if (v.calculation == 'tax_premium_only') {
			$('#tax_premium_only').prop("checked", true);			
			}
			else  {
			$('#tax_premium_broker_fee_only').prop("checked", true);			
			}	

			$(":input[type='checkbox']").wijcheckbox("refresh");
			$('#tax_rate').autoNumericSet(v.tax_rate);
			$('#stamp_tax').autoNumericSet(v.stamp_tax);
			$('#filing_fee').autoNumericSet(v.filing_fee);
			$('#broker_policy_fee').autoNumericSet(v.broker_policy_fee);
			$('#inspection_fee').autoNumericSet(v.inspection_fee);
			$('#rpg_fee').autoNumericSet(v.rpg_fee);
			$('#terrorism_fee').autoNumericSet(v.terrorism_fee);
			$('#notes').val(v.notes);
			$('#prop_tax').autoNumericSet(v.prop_tax);
			//$('#prop_fees').autoNumericSet(v.prop_fees);
			$('#prop_notes').val(v.prop_notes);
			$('#prop_min_premium').autoNumericSet(v.prop_min_premium);
		});
					 
					
	});	
	
	}
	
 });
//end state_id change

	var validator = $("#stateform").validate({
		rules: {
			name: {
				required: true
				},
			code: {
				required: true
				},
			state_id: { valueNotEquals: 0 }

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

			var data = $('#stateform').serialize();
			
			$.ajax({
			  type: "POST",
			  cache: false,
			  url: "/index.cfm?event=main.saveState",
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
 // add the rule here
 $.validator.addMethod("valueNotEquals", function(value, element, arg){
  return arg != value;
 }, "Please Select State");
	
});
//end document.ready

populateSelect = function() {
	var currentselect = $('#state_id').val();

$('#stateform')[0].reset();
$(":input[type='checkbox']").wijcheckbox("refresh");
$('#state_id').find('option').remove().end().append('<option value="0">Select State</option>').val(0);
$.ajax({
	type: "GET",
	url: "/index.cfm?event=main.getStates",
	dataType: "json"
}).success(function(response) {
	var html = '';
    $.each(response.data, function(k,v) {
		if (v.state_id != undefined)
		{
        html += '<option value="' + v.state_id + '">' + v.name + '</option>';
		}
	});
	$('#state_id').append(html);		
	$('#state_id').val(currentselect).trigger('change');		 
				
});
	
}
</script>

<div id="statusbar">
  <div id="pagename">State Taxes &amp; Surcharges Administration</div>
  <div id="statusstuff"> </div>
  <!---End Statusstuff--->
</div>
<!---End statusbar--->
<div class="msgcontainer">
<div class="message"></div>
</div>
  <form id="stateform" method="post" autocomplete="off">
<ul class="formfields" style="margin:10px 0 10px;">
<li class="clear"><label class="width-120">Select State</label></li>
<li><select name="state_id" id="state_id" class="selectbox2" style="width:88px;">
  </select>
  </li>
 <li class="clear"><label>&nbsp;</label></li> 
 <li class="clear"><label class="bold">GL/Excess</label></li> 
 <li class="clear"><label class="width-120">Tax Rate</label></li>
 <li><input type="text" name="tax_rate" id="tax_rate" class="width-80 percentdecmask" /></li>
 <li class="clear"><label class="width-120">Stamp Tax</label></li>
 <li><input type="text" name="stamp_tax" id="stamp_tax" class="width-80 percentdecmask" /></li>
  <li class="clear"><label class="width-120">Filing Fee</label></li>
 <li><input type="text" name="filing_fee" id="filing_fee" class="width-80 dollarmaskdec" /></li>
  <li class="clear"><label class="width-120">Broker Policy Fee</label></li>
 <li><input type="text" name="broker_policy_fee" id="broker_policy_fee" class="width-80 percentdecmask" /></li>
   <li class="clear"><label class="width-120">Inspection Fee</label></li>
 <li><input type="text" name="inspection_fee" id="inspection_fee" class="width-80 dollarmaskdec" /></li>
   <li class="clear"><label class="width-120">RPG Fee</label></li>
 <li><input type="text" name="rpg_fee" id="rpg_fee" class="width-80 dollarmaskdec" /></li>
    <li class="clear"><label class="width-120">Terrorism Fee</label></li>
 <li><input type="text" name="terrorism_fee" id="terrorism_fee" class="width-80 percentdecmask" /></li>


 <li class="clear"><input type="radio" name="calculation" id="tax_premium_only" value="tax_premium_only" /></li>
  <li><label>Tax Premium Only</label></li>
  <li class="clear"><input type="radio" name="calculation" id="tax_premium_fees" value="tax_premium_fees" /></li>
  <li><label class="width-120">Tax Premium &amp; Fees</label></li>
 <li class="clear"><input type="radio" name="calculation" id="tax_premium_broker_fee_only" value="tax_premium_broker_fee_only" /></li>
  <li><label>Tax Premium/Broker Fee Only</label></li> 
  <li class="clear"><label class="width-120">Notes</label></li>
 <li class="clear"><textarea name="notes" id="notes" class="txtleft" style="width:210px;"></textarea></li>

 <li class="clear"><label>&nbsp;</label></li> 
 <li class="clear"><input type="submit" name="conglomsub" class="buttons" value="SAVE"></li> 
 </ul> 
 <ul class="formfields" style="margin:10px 0 10px;">

 <li class="clear"><label>&nbsp;</label></li> 
 <li class="clear"><label>&nbsp;</label></li> 
 <li class="clear"><label class="bold">Property</label></li>  
 <li class="clear"><label class="width-120">Tax</label></li>
 <li><input type="text" name="prop_tax" id="prop_tax" class="width-80 percentdecmask" /></li>
<!---  <li class="clear"><label class="width-120">Other Fees</label></li>
 <li><input type="text" name="prop_fees" id="prop_fees" class="width-80 dollarmaskdec" /></li>--->
  <li class="clear"><label class="width-120">Minimum Premium</label></li>
 <li><input type="text" name="prop_min_premium" id="prop_min_premium" class="width-80 dollarmaskdec" /></li> 
   <li class="clear"><label class="width-120">Notes</label></li>
 <li class="clear"><textarea name="prop_notes" id="prop_notes" class="txtleft" style="width:210px;"></textarea></li>
 </ul>
 </form>
<!---
<select name="test" class="selectbox2">
<optgroup label="ABC Parent Company">
<option>AAA</option>
<option>DDD</option>
<option>ZZZ</option>
</optgroup>
<optgroup label="Another Parent Company">
<option>Abc</option>
<option>dfgh</option>
<option>rtyu</option>
</optgroup>
<optgroup label="Last Parent Company">
<option>eryt</option>
<option>yuoi</option>
<option>fghj</option>
</optgroup>
</select>--->


<div id="dialog-confirm" title="Delete User?">
  <p> <span class="ui-icon ui-icon-alert"></span> Are you sure you want to delete this user?</p>
</div>