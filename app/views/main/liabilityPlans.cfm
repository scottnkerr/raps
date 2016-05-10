<script>
$(document).ready(function() {
	$('#addplanform')[0].reset();
	$('#liability_plan_id').val(0);
	$('.user_label').hide();
	totalchecks = 0;

	// validate signup form on keyup and submit
	var container = $('div.errors');
	var validator = $("#addplanform").validate({
		rules: {
			name: {
				required: true
				}
		},
		messages: {
			name: {
				required: "*"
			}
		},

		submitHandler: function() {
			var name = $('#name').val();
			var data = $('#addplanform').serialize();
			
			$.ajax({
			  type: "POST",
			  cache: false,
			  url: "/index.cfm?event=main.saveLiabilityPlan",
			  data: data

			}).success(function(resp) {
					saveAlert();
					var currentid = $('#liability_plan_id').val();
					if (currentid == 0) {
					var html = '<option value='+resp+'>'+name+'</option>';
					$('#select_plan').append(html);	
					$('#liability_plan_id').val(resp);
					$('#select_plan').val(resp);
					}
				
			});
			
		},
		// set this class to error-labels to indicate valid fields
		success: function(label) {
			// set &nbsp; as text for IE
			label.html("&nbsp;").addClass("checked");
		}
	});

$(".edituser").live("click", function(){
$('#adduser').show();
$("#user_name").rules("remove", "required");
$("#user_name").rules("remove", "remote");
  validator.resetForm();
//$("#user_name").prop('disabled', true);

	
	$('input.usermsg').val('Edit User');
	$('label.usermsg').html('Edit User');
	var id = $(this).attr("edit_id");

	 });
$(".deleteuser").live("click", function(){	
	var id = $(this).attr("delete_id");
	var data = "user_id=" + id;
	$("#dialog-confirm").wijdialog({
                autoOpen: true,
                resizable: false,
                height: 180,
                width: 400,
                modal: true,
                buttons: {
                    "Delete User": function () {
                        $(this).wijdialog("close");
			
								$.ajax({
								  type: "POST",	   
								  url: "/app/model/main.cfc?method=deleteUserAJAX",
								  cache: false,
								  data: data
					
								}).success(function() { 

								 resetStuff(); 
								});
                    },
                    Cancel: function () {
                        $(this).wijdialog("close");
                    }
                }

            });		
										  });
$('#adduser').click(function(){
	resetStuff(1);
							 });
//plan selection 
$('#select_plan').change(function() {
		var id = $(this).val();		
	if (id == 0) {
	    $('#addplanform')[0].reset();
		$('#liability_plan_id').val(0);
		$('#total_plans').val(0);
		$(":input[type='checkbox']").wijcheckbox("refresh");
	}
	else {
	$.ajax({
    url: "/index.cfm?event=main.getPlans", 
	type: "get",
	cache: false,
	dataType: "json",
	data: {
	  liability_plan_id: id
  }
  , success: function (data){
	  //populate the form 
	 $(":input[type='checkbox']").prop("checked",false);
	 
		$.each(data, function() {
		  $.each(this, function(k, v) {
				if (v.liability_plan_id != undefined) {
				$('#liability_plan_id').val(v.liability_plan_id);
				}
				if (v.name != undefined) {
				$('#name').val(v.name);
				}
				if (v.proposal_hide == 1) {
				$('#proposal_hide').prop('checked',true);
				}
				else {
				$('#proposal_hide').prop('checked',false);	
				}
				if (v.disabled == 1) {
				$('#disabled').prop('checked',true);
				}
				else {
				$('#disabled').prop('checked',false);	
				}				
				if (v.base_rate != undefined) {
				$('#base_rate').autoNumericSet(v.base_rate);
				}
				if (v.instructor_base != undefined) {
				$('#instructor_base').autoNumericSet(v.instructor_base);
				}
				if (v.basketball_base != undefined) {
				$('#basketball_base').autoNumericSet(v.basketball_base);
				}
				if (v.racquetball_base != undefined) {
				$('#racquetball_base').autoNumericSet(v.racquetball_base);
				}				
				if (v.tennis_base != undefined) {
				$('#tennis_base').autoNumericSet(v.tennis_base);
				}
				if (v.sauna_base != undefined) {
				$('#sauna_base').autoNumericSet(v.sauna_base);
				}
				if (v.steam_room_base != undefined) {
				$('#steam_room_base').autoNumericSet(v.steam_room_base);
				}
				if (v.whirlpool_base != undefined) {
				$('#whirlpool_base').autoNumericSet(v.whirlpool_base);
				}
				if (v.pools_base != undefined) {
				$('#pools_base').autoNumericSet(v.pools_base);
				}
				if (v.poolsoutdoor_base != undefined) {
				$('#poolsoutdoor_base').autoNumericSet(v.poolsoutdoor_base);
				}				
				
				if (v.tanning_base != undefined) {
				$('#tanning_base').autoNumericSet(v.tanning_base);
				}
				if (v.spray_tanning_base != undefined) {
				$('#spray_tanning_base').autoNumericSet(v.spray_tanning_base);
				}
				if (v.beauty_angels_base != undefined) {
				$('#beauty_angels_base').autoNumericSet(v.beauty_angels_base);
				}
				if (v.silver_sneakers_base != undefined) {
				$('#silver_sneakers_base').autoNumericSet(v.silver_sneakers_base);
				}
				if (v.massage_base != undefined) {
				$('#massage_base').autoNumericSet(v.massage_base);
				}
				if (v.personal_trainers_base != undefined) {
				$('#personal_trainers_base').autoNumericSet(v.personal_trainers_base);
				}
				if (v.child_sitting_base != undefined) {
				$('#child_sitting_base').autoNumericSet(v.child_sitting_base);
				}
				if (v.jungle_gym_base != undefined) {
				$('#jungle_gym_base').autoNumericSet(v.jungle_gym_base);
				}
				if (v.leased_space_base != undefined) {
				$('#leased_space_base').autoNumericSet(v.leased_space_base);
				}
				if (v.leased_space_base != undefined) {
				$('#employeebenefits_base').autoNumericSet(v.employeebenefits_base);
				}				
				if (v.terrorism_minimum != undefined) {
				$('#terrorism_minimum').autoNumericSet(v.terrorism_minimum);
				}				
				if (v.csl_each != undefined) {
				$('#csl_each').val(v.csl_each);
				}
				if (v.csl_aggregate != undefined) {
				$('#csl_aggregate').val(v.csl_aggregate);
				}
				if (v.csl_products != undefined) {
				$('#csl_products').val(v.csl_products);
				}
				if (v.med_pay_per_person != undefined) {
				$('#med_pay_per_person').val(v.med_pay_per_person);
				}
				if (v.fire_damage_legal != undefined) {
				$('#fire_damage_legal').val(v.fire_damage_legal);
				}
				if (v.personal_advertising_injury != undefined) {
				$('#personal_advertising_injury').val(v.personal_advertising_injury);
				}
				if (v.professional_liability != undefined) {
				$('#professional_liability').val(v.professional_liability);
				}
				if (v.tanning_bed_liability != undefined) {
				$('#tanning_bed_liability').val(v.tanning_bed_liability);
				}
				if (v.hired_auto_liability != undefined) {
				$('#hired_auto_liability').val(v.hired_auto_liability);
				}
				if (v.non_owned_auto_liability != undefined) {
				$('#non_owned_auto_liability').val(v.non_owned_auto_liability);
				}
				if (v.policy_deductible != undefined) {
				$('#policy_deductible').val(v.policy_deductible);
				}
				if (v.sex_abuse_occ != undefined) {
				$('#sex_abuse_occ').val(v.sex_abuse_occ);
				}
				if (v.sex_abuse_agg != undefined) {
				$('#sex_abuse_agg').val(v.sex_abuse_agg);
				}
				if (v.default_credit != undefined) {
				$('#default_credit').autoNumericSet(v.default_credit);
				}		
				if (v.default_credit_label != undefined) {
				$('#default_credit_label').val(v.default_credit_label);
				}				
				if (v.affiliation_id != undefined) {
				$(".check_"+v.affiliation_id).prop("checked", true);								 
				$(":input[type='checkbox']").wijcheckbox("refresh");
				
				}		   
		  });
		});
}
  // this runs if an error
  , error: function (xhr, textStatus, errorThrown){
    // show error
    alert(errorThrown);
  }
	});
	}
	
 });
});

resetStuff = function(fullreset) {
	
			  $('#adduserform')[0].reset();
			  $('#user_id').val(0);
			  //trash and redraw the grid with new values from db

			$('#user_name').rules("add", {
						remote : "/app/model/main.cfc?method=checkDup",
						required: true
			});
			$('.user_label').html('').hide();
			$('#user_name').show();
			$('#adduser').hide();
			$('input.usermsg').val('Add User');
			$('label.usermsg').html('Add User');
			if (fullreset != 1) {
			  $("#usergrid").wijgrid("destroy");
			  createUserGrid();
			  $(".message").html("Changes Saved").slideDown();
			  //add back the rules for required and remote for user name				
			}
}
			
 </script>

<div id="statusbar">
  <div id="pagename">Liability Plan Administration</div>
  <div id="statusstuff"> </div>
  <!---End Statusstuff--->
</div>
<!---End statusbar--->

<div class="msgcontainer">
<div class="message"></div>
</div>
  <form id="addplanform" method="post" autocomplete="off">
<ul class="formfields width-260" style="margin:10px 0 10px;">

<li class="clear"><label class="width-65 proper">Select Plan</label></li>
<li><select name="select_plan" id="select_plan" class="selectbox2 width-157">
<option value="0">New Plan</option>
<cfoutput query="rc.plans"><option value="#liability_plan_id#">#name#</option></cfoutput>
</select>
</li>
<li class="clear"><label class="width-65 proper">Plan Name</label></li>
<li><input type="text" name="name" id="name" class="width-149 txtleft"></li>
<li class="clear"><label>&nbsp;</label></li>
<input type="hidden" name="liability_plan_id" id="liability_plan_id" value="0">
<li class="clear"><label class="width-134 proper">base rate</label></li>
<li><input type="text" name="base_rate" id="base_rate" class="width-80 dollarmask"></li>
<li class="clear"><label class="width-134 proper">instructor base</label></li>
<li><input type="text" name="instructor_base" id="instructor_base" class="width-80 dollarmask"></li>
<li class="clear"><label class="width-134 proper">basketball base</label></li>
<li><input type="text" name="basketball_base" id="basketball_base" class="width-80 dollarmask"></li>
<li class="clear"><label class="width-134 proper">racquetball base</label></li>
<li><input type="text" name="racquetball_base" id="racquetball_base" class="width-80 dollarmask"></li>
<li class="clear"><label class="width-134 proper">tennis base</label></li>
<li><input type="text" name="tennis_base" id="tennis_base" class="width-80 dollarmask"></li>
<li class="clear"><label class="width-134 proper">sauna base</label></li>
<li><input type="text" name="sauna_base" id="sauna_base" class="width-80 dollarmask"></li>
<li class="clear"><label class="width-134 proper">steam room base</label></li>
<li><input type="text" name="steam_room_base" id="steam_room_base" class="width-80 dollarmask"></li>
<li class="clear"><label class="width-134 proper">whirlpool base</label></li>
<li><input type="text" name="whirlpool_base" id="whirlpool_base" class="width-80 dollarmask"></li>
<li class="clear"><label class="width-134 proper">indoor pools base</label></li>
<li><input type="text" name="pools_base" id="pools_base" class="width-80 dollarmask"></li>
<li class="clear"><label class="width-134 proper">outdoor pools base</label></li>
<li><input type="text" name="poolsoutdoor_base" id="poolsoutdoor_base" class="width-80 dollarmask"></li>
<li class="clear"><label class="width-134 proper">tanning base</label></li>
<li><input type="text" name="tanning_base" id="tanning_base" class="width-80 dollarmask"></li>
<li class="clear"><label class="width-134 proper">spray tanning base</label></li>
<li><input type="text" name="spray_tanning_base" id="spray_tanning_base" class="width-80 dollarmask"></li>
<li class="clear"><label class="width-134 proper">beauty angels base</label></li>
<li><input type="text" name="beauty_angels_base" id="beauty_angels_base" class="width-80 dollarmask"></li>
<li class="clear"><label class="width-134 proper">silver sneakers base</label></li>
<li><input type="text" name="silver_sneakers_base" id="silver_sneakers_base" class="width-80 dollarmask"></li>
<li class="clear"><label class="width-134 proper">massage base</label></li>
<li><input type="text" name="massage_base" id="massage_base" class="width-80 dollarmask"></li>
<li class="clear"><label class="width-134 proper">personal trainers base</label></li>
<li><input type="text" name="personal_trainers_base" id="personal_trainers_base" class="width-80 dollarmask"></li>
<li class="clear"><label class="width-134 proper">child sitting base</label></li>
<li><input type="text" name="child_sitting_base" id="child_sitting_base" class="width-80 dollarmask"></li>
<li class="clear"><label class="width-134 proper">jungle gym base</label></li>
<li><input type="text" name="jungle_gym_base" id="jungle_gym_base" class="width-80 dollarmask"></li>
<li class="clear"><label class="width-134 proper">leased space base</label></li>
<li><input type="text" name="leased_space_base" id="leased_space_base" class="width-80 dollarmask"></li>
<li class="clear"><label class="width-134 proper">employee benefits base</label></li>
<li><input type="text" name="employeebenefits_base" id="employeebenefits_base" class="width-80 dollarmask"></li>
<li class="clear"><label class="width-134 proper">Terrorism Minimum</label></li>
<li><input type="text" name="terrorism_minimum" id="terrorism_minimum" class="width-80 dollarmask"></li>
    </ul>
<ul class="formfields width-302" style="margin:10px 0 10px;">

<li class="clear"><label>&nbsp;</label></li>
<li class="clear"><label>&nbsp;</label></li>
<li class="clear"><label>&nbsp;</label></li>
<li class="clear"><label class="width-134 proper">CSL each</label></li>
<li><input type="text" name="csl_each" id="csl_each" class="width-80 "></li>
<li class="clear"><label class="width-134 proper">CSL aggregate</label></li>
<li><input type="text" name="csl_aggregate" id="csl_aggregate" class="width-80 "></li>
<li class="clear"><label class="width-134 proper">CSL products</label></li>
<li><input type="text" name="csl_products" id="csl_products" class="width-80 "></li>
<li class="clear"><label class="width-134 proper">med pay per person</label></li>
<li><input type="text" name="med_pay_per_person" id="med_pay_per_person" class="width-80 "></li>
<li class="clear"><label class="width-134 proper">fire damage legal</label></li>
<li><input type="text" name="fire_damage_legal" id="fire_damage_legal" class="width-80 "></li>
<li class="clear"><label class="width-134 proper">personal advertising injury</label></li>
<li><input type="text" name="personal_advertising_injury" id="personal_advertising_injury" class="width-80 "></li>
<li class="clear"><label class="width-134 proper">professional liability</label></li>
<li><input type="text" name="professional_liability" id="professional_liability" class="width-80 "></li>
<li class="clear"><label class="width-134 proper">tanning bed liability</label></li>
<li><input type="text" name="tanning_bed_liability" id="tanning_bed_liability" class="width-80 "></li>
<li class="clear"><label class="width-134 proper">hired auto liability</label></li>
<li><input type="text" name="hired_auto_liability" id="hired_auto_liability" class="width-80 "></li>
<li class="clear"><label class="width-134 proper">non owned auto liability</label></li>
<li><input type="text" name="non_owned_auto_liability" id="non_owned_auto_liability" class="width-80 "></li>
<li class="clear"><label class="width-134 proper">policy deductible</label></li>
<li><input type="text" name="policy_deductible" id="policy_deductible" class="width-80 "></li>
<li class="clear"><label class="width-134 proper">sex abuse occ</label></li>
<li><input type="text" name="sex_abuse_occ" id="sex_abuse_occ" class="width-80 "></li>
<li class="clear"><label class="width-134 proper">sex abuse agg</label></li>
<li><input type="text" name="sex_abuse_agg" id="sex_abuse_agg" class="width-80 "></li>
<li class="clear"><label>&nbsp;</label></li>
<li class="clear"><label class="width-134 proper">Default Credit/Debit Label</label></li>
<li><input type="text" name="default_credit_label" id="default_credit_label" class="width-80 txtleft"></li>
<li class="clear"><label class="width-134 proper">Default Credit/Debit Amount</label></li>
<li><input type="text" name="default_credit" id="default_credit" class="width-80 percentmask"></li>
<li class="clear"><label>&nbsp;</label></li>
<li class="clear"><input type="checkbox" name="proposal_hide" id="proposal_hide" value="1" class="width-80 "></li>
<li><label>Proposal Override</label></li>
<li class="clear"><label>&nbsp;</label></li>
<li class="clear"><input type="checkbox" name="disabled" id="disabled" value="1" class="width-80 "></li>
<li><label>Disabled</label></li>
</ul>    
<ul class="formfields width-375" style="margin:10px 0 10px;">
<li class="clear"><label>&nbsp;</label></li>
<li class="clear"><label>&nbsp;</label></li>
<li class="clear"><label class="bold">Plan Applies To:</label></li>
<cfoutput>
<cfloop query="rc.conglom">
	
<li class="clear"><input type="checkbox" name="check_#rc.conglom.currentrow#" id="check_#rc.conglom.currentrow#" class="planchecks check_#rc.conglom.affiliation_id#" value="#rc.conglom.affiliation_id#" />

</li>
<li><label class="width-60">#rc.conglom.code#</label></li>
<li><label>-</label></li>
<li><label>#rc.conglom.name#</label></li>
</cfloop>
<input type="hidden" name="totalplans" id="totalplans" value="#rc.conglom.recordcount#" />
</cfoutput>
</ul>  


<div style="clear:both"></div>

<input type="submit" name="plansub" class="buttons" value="SAVE">
<!---<button name="deleteplan" class="buttons">DELETE PLAN</button>--->
</form>
<table id="usergrid">
</table>
</div>
<div id="dialog-confirm" title="Delete User?">
  <p> <span class="ui-icon ui-icon-alert"></span> Are you sure you want to delete this user?</p>
</div>
