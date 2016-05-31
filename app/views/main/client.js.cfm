<script type="text/javascript">
$(document).ready(function(){

<cfif val(client_id) eq 0>

//$("#tabs").wijtabs('select', 3);
//$("#tabs" ).wijtabs({ disabledIndexes: [0,1,2,8,9] });

</cfif>

$('#renewdates').click(function() {
	var curdate = $('#current_effective_date').val();
// var curdate = <cfoutput>'#dateFormat(current_effective_date, "mm/dd/yyyyy")#'</cfoutput>; 	
			$.ajax({
			  type: "POST",
			  cache: false,
			  url: "/index.cfm?event=main.renewDates",
			  data: {
				  client_id : <cfoutput>#client_id#</cfoutput>,
					current_effective_date: curdate
			  }

			}).success(function(resp) {
				alert('Effective dates refreshed');			
			});
});
<!---print all apps for active locations
			first, reload page with printall added to url params--->
$('#printAll').click(function(e) {
	e.preventDefault();
	url = '/index.cfm?event=main.client&printall=1&client_id=<cfoutput>#client_id#</cfoutput>';
	window.location.href = url;
});
<!---next, get locations and build links for each app, launching each in a new window along with print command--->
<cfif isdefined('url.printall')>
	<cfif isdefined('rc.locations') and rc.locations.recordcount>
	<cfset activelocs = 0>
	<cfoutput query="rc.locations">
	<cfif rc.locations.location_status_id eq 1>
	<cfset activelocs = activelocs + 1>
	<cfset uri = "/index.cfm?event=app&ratingid=#rc.locations.myratingid#&client_id=#client_id#&print=1&application_id=#rc.locations.application_id#">
	window.open("#uri#");
</cfif>
	</cfoutput>
		<cfif activelocs eq 0>
		alert('There are no active locations to print');
		</cfif>
	<cfelse>
	alert('There are no apps to print');
	</cfif>
</cfif>
<!---end print all apps--->
$('#saveAllLocHistory').click(function(e) {
	e.preventDefault();
	var curdate = $('#current_effective_date').val();
// var curdate = <cfoutput>'#dateFormat(current_effective_date, "mm/dd/yyyyy")#'</cfoutput>; 	
			$.ajax({
			  type: "POST",
			  cache: false,
			  url: "/index.cfm?event=main.saveAllLocHistory",
			  data: {
				  client_id : <cfoutput>#client_id#</cfoutput>
			  }

			}).success(function(resp) {
				alert('History Saved');			
			});
});

$('.ownersalary').live('focus', function() {
$(this).autoNumeric({aSign: '$'});	
});
$('.ownerpercent').live('focus', function() {
$(this).autoNumeric({aSep: '',mDec: 0,vMax: 100});	
});
	var validator = $("#clientform").validate({
		rules: {
			entity_name: "required",
			client_code: {
				required: true,	
				remote: "/index.cfm?event=main.checkClientCodeDup&client_id=<cfoutput>#val(client_id)#</cfoutput>"	
			},
			current_effective_date: {
				required: true,
				date: true
			}		
		},
		messages: {
			client_code: {
				required: "*",
				//remote: jQuery.format("!")
				remote: function() { alert('Client Code already in use.'); }
			},
			entity_name: {
				required: "*"
			},
			current_effective_date: {
				required: "*"
			}
		},
		submitHandler: function() {
			var errors = "";
			$('.datebox').each(function() {
        var dateVal = $(this).val();
				var fieldName = $(this).attr('id');
				var isValid = checkDate(dateVal);
				if (isValid != 'valid') {
					errors = errors + fieldName + ', '; 
				}
      });
			if (errors != "") {
				alert('The following date fields have an invalid date format:' + errors);
			}
			else {
			 saveClient();
			}
		},		
		// set this class to error-labels to indicate valid fields
		success: function(label) {
			// set &nbsp; as text for IE
			label.html("&nbsp;").addClass("checked");
		}
	});

<cfif client_id neq 0>

createNIGrid();		
createUEGrid();
createEPLIGrid();
createWCGrid();
createPolicyGrid();
createLocationGrid();

//auto refresh new locations

setInterval(function(){refreshLocationGrid()},5000);

//add policy click

$('#addPolicy').click(function() {
	$('.policyformul').slideDown();
	$('.addpolicyli1').slideUp();
	$('.addpolicylabel').html('New Policy');
	//reset form fields
	$('#policy_type_id').val(1);
	$('#policy_issuing_company').val(0);
	$('#policy_number').val('');
	$('#policy_status_id').val(1);
	$('#policy_id').val(0);	
});
$('#policycancel').click(function(e) {
	e.preventDefault();
	$('.policyformul').slideUp();
	$('.addpolicyli1').slideDown();
	$('.addpolicylabel').html('Add Policy');
});
//auto total ue premium
$('.ueprem').blur(function() {
	var total = 0;						 
	$('.ueprem').each(function() {		
		var value = parseFloat($(this).autoNumericGet());		
		//value = parseInt($(this).val().replace(/\$/g, '').replace(/,/g, ''));
		total = total + value;				
	 });
	$('#ue_totalpremium').autoNumericSet(total);
});
//auto total wc premium
$('.wcprem').blur(function() {
	var total = 0;						 
	$('.wcprem').each(function() {		
		var value = parseFloat($(this).autoNumericGet());		
		//value = parseInt($(this).val().replace(/\$/g, '').replace(/,/g, ''));
		total = total + value;				
	 });
	$('#wc_totalpremium').autoNumericSet(total);
});
//auto total epli premium
$('.epliprem').blur(function() {
	var total = 0;						 
	$('.epliprem').each(function() {		
		var value = parseFloat($(this).autoNumericGet());		
		total = total + value;				
	 });
	$('#epli_totalpremium').autoNumericSet(total);
});
//auto total bond premium
$('.bondprem').blur(function() {
	var total = 0;						 
	$('.bondprem').each(function() {		
		var value = parseFloat($(this).autoNumericGet());		
		total = total + value;				
	 });
	$('#bond_totalpremium').autoNumericSet(total);
});
//auto total other lines premium
$('.otherprem').blur(function() {
	var total = 0;						 
	$('.otherprem').each(function() {		
		var value = parseFloat($(this).autoNumericGet());		
		total = total + value;				
	 });
	$('#other_totalpremium').autoNumericSet(total);
});
$('.other2prem').blur(function() {
	var total = 0;						 
	$('.other2prem').each(function() {		
		var value = parseFloat($(this).autoNumericGet());		
		total = total + value;				
	 });
	$('#other2_totalpremium').autoNumericSet(total);
});
$('.other3prem').blur(function() {
	var total = 0;						 
	$('.other3prem').each(function() {		
		var value = parseFloat($(this).autoNumericGet());		
		total = total + value;				
	 });
	$('#other3_totalpremium').autoNumericSet(total);
});

//auto epli employee total
$('.epliemp').blur(function() {
	var total = 0;						 
	$('.epliemp').each(function() {		
		var value = parseInt($(this).autoNumericGet());		
		total = total + value;				
	 });
	$('#epli_totalemployees').autoNumericSet(total);
});

//auto epli employee total
$('.wcemp').blur(function() {
	var total = 0;						 
	$('.wcemp').each(function() {		
		var value = parseInt($(this).autoNumericGet());		
		total = total + value;				
	 });
	$('#wc_totalemployees').autoNumericSet(total);
});

$('#addwcowner').click(function() {
 			$("#addwcowner").before('<li class="clear wcowners"><input type="text" name="owner_name" class="txtleft width-195 wcowners wijmo-wijtextbox ui-widget ui-state-default ui-corner-all ownername"><input type="text" name="owner_title" class="txtleft width-200 wcowners wijmo-wijtextbox ui-widget ui-state-default ui-corner-all ownertitle"><input type="text" name="owner_percent" class="width-50 wcowners wijmo-wijtextbox ui-widget ui-state-default ui-corner-all ownerpercent numbermask"><input type="text" name="owner_salary" class="width-111 wcowners wijmo-wijtextbox ui-widget ui-state-default ui-corner-all ownersalary"><input type="hidden" name="client_wc_id" class="wcowners" value="0"><input type="checkbox" name="owner_include" value="1" class="wcowners wccheck" /><input type="checkbox" name="owner_exclude" value="1" class="wcowners wccheck wcchecklast" /></li>');								

});
$('.addloc').click(function() {
 			$(this).before('<li class="clear locs"><label class="txtleft locs">Coverage</label></li><li><input type="text" name="loc_desc" class="txtleft width-190 locs wijmo-wijtextbox ui-widget ui-state-default ui-corner-all" /><input type="text" name="loc_limit" class="width-80 locs wijmo-wijtextbox ui-widget ui-state-default ui-corner-all" /><input type="hidden" name="client_loc_id" value="0" /></li>');								

});
							 
$('#addconsolidate').click(function() {
		var id1 = <cfoutput>#val(client_id)#</cfoutput>;
		var id2 = $('#consolidate_id').val();
		
		if (id2 != 0) {
			$.ajax({
			  type: "POST",
			  cache: false,
			  url: "/index.cfm?event=main.addConsolidate",
			  data: {
				  client_id1 : id1,
				  client_id2 : id2
			  }

			}).success(function(resp) {
				if (resp = 'success'){
				$("#uegrid").wijgrid("destroy");
				createUEGrid();
				}
				else{
					alert('There was an error');
				}
				 
				
			});
	
		}

});
$('#addepliconsolidate').click(function() {
		var id1 = <cfoutput>#val(client_id)#</cfoutput>;
		var id2 = $('#epli_consolidate_id').val();
		
		if (id2 != 0) {
			$.ajax({
			  type: "POST",
			  cache: false,
			  url: "/index.cfm?event=main.addEPLIConsolidate",
			  data: {
				  client_id1 : id1,
				  client_id2 : id2
			  }

			}).success(function(resp) {
				if (resp = 'success'){
				$("#epligrid").wijgrid("destroy");
				createEPLIGrid();
				}
				else{
					alert('There was an error');
				}
				 
				
			});
	
		}

});
$('#addwcconsolidate').click(function() {
		var id1 = <cfoutput>#val(client_id)#</cfoutput>;
		var id2 = $('#wc_consolidate_id').val();
		
		if (id2 != 0) {
			$.ajax({
			  type: "POST",
			  cache: false,
			  url: "/index.cfm?event=main.addWCConsolidate",
			  data: {
				  client_id1 : id1,
				  client_id2 : id2
			  }

			}).success(function(resp) {
				if (resp = 'success'){
				$("#wcgrid").wijgrid("destroy");
				createWCGrid();
				}
				else{
					alert('There was an error');
				}
				 
				
			});
	
		}

});
$('#addNI').click(function() {
	$('.niformul').slideDown();
	$('.addnili1').slideUp();
	$('.addnilabel').html('New Named Insured');
    

	$('.nifields').val('');
	$('#named_insured_id').val(0);
	$('.nichecks').attr('checked',false);
	$('.nichecks').wijcheckbox("refresh");	

});
$('#nicancel').click(function(e) {
	e.preventDefault();
	$('.niformul').slideUp();
	$('.addnili1').slideDown();
	$('.addnilabel').html('Add Named Insured');
});
	//we only want the fields for wc owners to be added once per page load, so use "one"
	$('#WCTab').click(function() {
		$("#wcgrid").wijgrid("doRefresh");
		createWCOwnerFields();
	
	});	
	//we only want the fields for wc owners to be added once per page load, so use "one"
	$('.OtherTab').click(function() {
		var thistab = $(this).attr('othertab');
		createLOCFields(thistab);
	
	});	

	$('#NITab').click(function() {
		$("#nigrid").wijgrid("doRefresh");							
	});
	$('#UETab').click(function() {
		$("#uegrid").wijgrid("doRefresh");

	});
	$('#EPLITab').click(function() {
		$("#epligrid").wijgrid("doRefresh");
	});	
	$('#PolicyTab').click(function() {
		$("#policygrid").wijgrid("doRefresh");
	});	
</cfif>	

	$('#policysave').click(function(e){
		e.preventDefault();
		var client_id = <cfoutput>#val(client_id)#</cfoutput>
		var data = $('.policyfield').serialize();
		var data = data + "&client_id=" + client_id
			$.ajax({
			  type: "POST",
			  cache: false,
			  url: "/index.cfm?event=main.savePolicy",
			  data: data

			}).success(function(resp) {
				$("#policygrid").wijgrid("destroy");
				createPolicyGrid();
				$('.policyformul').slideUp();
				$('.addpolicyli1').slideDown();
				$('.addpolicylabel').html('Add Policy');				
			});	
	});
	$('#nisave').click(function(e){
		e.preventDefault();
		var client_id = <cfoutput>#val(client_id)#</cfoutput>
		var data = $('.nifields').serialize();
		var checkvalue = $("#gl").attr("checked");
		if (checkvalue == "checked") {
		var data = data + "&gl=1";
		}
		var checkvalue = $("#property").attr("checked");
		if (checkvalue == "checked") {
		var data = data + "&property=1";
		}
		var checkvalue = $("#ue").attr("checked");
		if (checkvalue == "checked") {
		var data = data + "&ue=1";
		}
		var checkvalue = $("#wc").attr("checked");
		if (checkvalue == "checked") {
		var data = data + "&wc=1";
		}
		var checkvalue = $("#epli").attr("checked");
		if (checkvalue == "checked") {
		var data = data + "&epli=1";
		}		
		var checkvalue = $("#cyber").attr("checked");
		if (checkvalue == "checked") {
		var data = data + "&cyber=1";
		}			
		var data = data + "&client_id=" + client_id;
			$.ajax({
			  type: "POST",
			  cache: false,
			  url: "/index.cfm?event=main.saveNI",
			  data: data

			}).success(function(resp) {
				$("#nigrid").wijgrid("destroy");
				createNIGrid();
				$('.niformul').slideUp();
				$('.addnili1').slideDown();
				$('.addnilabel').html('Add Named Insured');				
			});	
	});	


$(".deletec").live("click", function(){	
	var id = $(this).attr("deleteconsolidation_id");
	var data = "ue_consolidation_id=" + id;
	$("#dialog-confirm").wijdialog({
                autoOpen: true,
                resizable: false,
                height: 180,
                width: 400,
                modal: true,
                buttons: {
                    "Delete": function () {
                        $(this).wijdialog("close");
			
								$.ajax({
								  type: "POST",	   
								  url: "/index.cfm?event=main.deleteConsolidation",
								  cache: false,
								  data: data
					
								}).success(function() { 
									$("#uegrid").wijgrid("destroy");
									createUEGrid();
								 
								});
                    },
                    Cancel: function () {
                        $(this).wijdialog("close");
                    }
                }
								   });

            });	
$(".deleteeplic").live("click", function(){	
	var id = $(this).attr("deleteconsolidation_id");
	var data = "epli_consolidation_id=" + id;
	$("#dialog-confirm").wijdialog({
                autoOpen: true,
                resizable: false,
                height: 180,
                width: 400,
                modal: true,
                buttons: {
                    "Delete": function () {
                        $(this).wijdialog("close");
			
								$.ajax({
								  type: "POST",	   
								  url: "/index.cfm?event=main.deleteEPLIConsolidation",
								  cache: false,
								  data: data
					
								}).success(function() { 
									$("#epligrid").wijgrid("destroy");
									createEPLIGrid();
								 
								});
                    },
                    Cancel: function () {
                        $(this).wijdialog("close");
                    }
                }
								   });

            });	
$(".deletewcc").live("click", function(){	
	var id = $(this).attr("deleteconsolidation_id");
	var data = "wc_consolidation_id=" + id;
	$("#dialog-confirm").wijdialog({
                autoOpen: true,
                resizable: false,
                height: 180,
                width: 400,
                modal: true,
                buttons: {
                    "Delete": function () {
                        $(this).wijdialog("close");
			
								$.ajax({
								  type: "POST",	   
								  url: "/index.cfm?event=main.deleteWCConsolidation",
								  cache: false,
								  data: data
					
								}).success(function() { 
									$("#wcgrid").wijgrid("destroy");
									createWCGrid();
								 
								});
                    },
                    Cancel: function () {
                        $(this).wijdialog("close");
                    }
                }
								   });

            });
$(".deletepolicy").live("click", function(){	
	var id = $(this).attr("deletepolicy_id");
	$("#dialog-confirm").wijdialog({
                autoOpen: true,
                resizable: false,
                height: 180,
                width: 400,
                modal: true,
                buttons: {
                    "Delete": function () {
                        $(this).wijdialog("close");
			
								$.ajax({
								  type: "POST",	   
								  url: "/index.cfm?event=main.deletePolicy",
								  cache: false,
								  data: {
									  policy_id: id
								  }
					
								}).success(function() { 
									$("#policygrid").wijgrid("destroy");
									createPolicyGrid();
								 
								});
                    },
                    Cancel: function () {
                        $(this).wijdialog("close");
                    }
                }
								   });

});
$(".deleteni").live("click", function(){	
	var id = $(this).attr("delete_id");
	$("#dialog-confirm").wijdialog({
                autoOpen: true,
                resizable: false,
                height: 180,
                width: 400,
                modal: true,
                buttons: {
                    "Delete": function () {
                        $(this).wijdialog("close");
			
								$.ajax({
								  type: "POST",	   
								  url: "/index.cfm?event=main.deleteNI",
								  cache: false,
								  data: {
									  named_insured_id: id
								  }
					
								}).success(function() { 
									$("#nigrid").wijgrid("destroy");
									createNIGrid();
								 
								});
                    },
                    Cancel: function () {
                        $(this).wijdialog("close");
                    }
                }
								   });

});
$(".editpolicy").live("click", function(){	
	$('.policyformul').slideDown();
	$('.addpolicyli1').slideUp();
	$('.addpolicylabel').html('Edit Policy');										
	var client_id = <cfoutput>#val(client_id)#</cfoutput>	;								
	var policy_id = $(this).attr("editpolicy_id");
			
	$.ajax({
		type: "GET",
		url: "/index.cfm?event=main.getPolicies",
		dataType: "json",
		data: {
			client_id: client_id,
			policy_id: policy_id
		}
	}).success(function(response) {
		
		$.each(response.data, function(k,v) {	

			$('#policy_type_id').val(v.policy_type_id);
			$('#policy_effectivedate').val(v.policyeffectivedate);
			$('#policy_expiredate').val(v.policyexpiredate);
			$('#policy_issuing_company').val(v.issuing_company_id);
			$('#policy_number').val(v.policynumber);
			$('#policy_status_id').val(v.policy_status_id);
			$('#policy_canceldate').val(v.policycanceldate);
			$('#policy_id').val(v.policy_id);

		});
				 
					
	});	


});
$(".editni").live("click", function(){	
	$('.nichecks').prop("checked", false);								
	$('.niformul').slideDown();
	$('.addnili1').slideUp();
	$('.addnilabel').html('Edit Named Insured');										
	var client_id = <cfoutput>#val(client_id)#</cfoutput>	;								
	var named_insured_id = $(this).attr("edit_id");
			
	$.ajax({
		type: "GET",
		url: "/index.cfm?event=main.getNI",
		dataType: "json",
		data: {
			client_id: client_id,
			named_insured_id: named_insured_id
		}
	}).success(function(response) {
		
		$.each(response.data, function(k,v) {	

			$('#named_insured_id').val(v.named_insured_id);
			$('#named_insured').val(v.named_insured);
			$('#relationship').val(v.relationship);
			$('#notes').val(v.notes);
			$('#ni_fein').val(v.ni_fein);
			$('#yearstarted').val(v.yearstarted);
			if (v.gl == 1) {
			$('#gl').prop("checked", true);
			}
			if (v.property == 1) {
			$('#property').prop("checked", true);
			}
			if (v.ue == 1) {
			$('#ue').prop("checked", true);
			}
			if (v.wc == 1) {
			$('#wc').prop("checked", true);
			}
			if (v.epli == 1) {
			$('#epli').prop("checked", true);
			}		
			if (v.cyber == 1) {
			$('#cyber').prop("checked", true);
			}					
		});
		$('.nichecks').wijcheckbox("refresh");			 
					
	});	


});
$(".renewpolicy").live("click", function(){	
	$('.policyformul').slideDown();
	$('.addpolicyli1').slideUp();
	$('.addpolicylabel').html('Renew Policy');										
	var client_id = <cfoutput>#val(client_id)#</cfoutput>	;								
	var policy_id = $(this).attr("renewpolicy_id");
			
	$.ajax({
		type: "GET",
		url: "/index.cfm?event=main.getPolicies",
		dataType: "json",
		data: {
			client_id: client_id,
			policy_id: policy_id
		}
	}).success(function(response) {
		
		$.each(response.data, function(k,v) {	
			//old expiration date becomes new effective date
			var neweffective = v.policyexpiredate;
			//get the year and add to it
			var getyear = neweffective.slice(-4);
			var yearnum = parseInt(getyear) + 1;
			var yearstring = yearnum.toString();
			//get the month and day
			var getrest = neweffective.substring(0,6);
			//reassemble the string for the new expiration date
			var newexpire = getrest + yearstring;

			$('#policy_type_id').val(v.policy_type_id);
			$('#policy_effectivedate').val(neweffective);
			$('#policy_expiredate').val(newexpire);
			$('#policy_issuing_company').val(v.issuing_company_id);
			$('#policy_number').val('');
			$('#policy_status_id').val(v.policy_status_id);
			$('#policy_canceldate').val('');
			$('#policy_id').val(0);
			$('#renewed_policy_id').val(v.policy_id);

		});
					 
					
	});	

});
$('#clearPolicyDate').click(function() {
	blankDate('#policy_canceldate');
});
<cfif client_id neq 0>
	$('#proposalbutton').click(function(e) {
		e.preventDefault();								
		var url = '/index.cfm?event=main.proposalChecklist&client_id='+<cfoutput>#val(client_id)#</cfoutput>;										
		window.open(url);								
	});
</cfif>	
	$('.locationselect').live('change', function() {
			var location_status_id = $(this).val();
			var location = $(this).attr('name');
			var location_id = location.replace('loc_','');
			$.ajax({
			  type: "POST",
			  cache: false,
			  url: "/index.cfm?event=main.saveLocationStatus",
			  data: {
				location_id: location_id,
				location_status_id: location_status_id
			  }

			}).success(function(resp) {

			});	
	});	
	$('.exclude_prop').live('click', function() {
			var ischecked = $(this).attr('checked');
			var ratingid = $(this).attr('ratingid');
			if (ischecked != 'checked') {
				var exclude_prop = 0;
			}
			else {
				var exclude_prop = 1	
			}
			var location = $(this).attr('name');
			var location_id = location.replace('exclude_','');
			
			$.ajax({
			  type: "POST",
			  cache: false,
			  url: "/index.cfm?event=main.saveLocationExclude",
			  data: {
				location_id: location_id,
				exclude_prop: exclude_prop,
				ratingid: ratingid
			  }

			}).success(function(resp) {

			});	
	});		
$(".deleteloc").live("click", function(){	
	var id = $(this).attr("delete_id");
	var data = "location_id=" + id;
	$("#dialog-confirm").wijdialog({
                autoOpen: true,
                resizable: false,
                height: 180,
                width: 400,
                modal: true,
                buttons: {
                    "Delete Location": function () {
                        $(this).wijdialog("close");
			
								$.ajax({
								  type: "POST",	   
								  url: "/app/model/main.cfc?method=deleteLoc",
								  cache: false,
								  data: data
					
								}).success(function() { 
								$("#locationgrid").wijgrid("destroy");
								createLocationGrid();
								 //resetStuff(); 
								});
                    },
                    Cancel: function () {
                        $(this).wijdialog("close");
                    }
                }

            });		
});	
$('#ueratebutton').click(function(e) {
		e.preventDefault();
		getUEState();
});
$('#ue_terrorism_rejected').click(function() {
	var tfee = $('#ue_terrorism_fee').autoNumericGet();
	var ischecked = $('#ue_terrorism_rejected').attr('checked');
	if (ischecked == 'checked') {
		var tfee = 0;
	}
	$('#ue_terrorism_fee_field').autoNumericSet(tfee);
});
			//Add Contact
			$("#addContact").click(function() {										  
				$(this).parent().before('<ul class="contactsection formfields width-500 col2 txtleft"><input type="hidden" name="contactid" value="0"><li class="blankli newli"><label>&nbsp;</label></li><li class="clear"><label class="bold width-417 newli">Contact</label></li><li class="newli"><label class="contactorderlabel">Order</label></li><li><input type="text" name="contactorder" class="contactorder wijmo-wijtextbox ui-widget ui-state-default ui-corner-all"></li><li class="clear newli"><label class="width-65">Name</label></li><li class="newli"><input type="text" name="name" class="width-163 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all"></li><li class="newli"><label class="width-50" style="padding-left:20px;">Title</label></li><li class="newli"><input type="text" name="title" class="width-163 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all"></li><li class="clear newli"><label class="width-65">Phone</label></li><li class="newli contactphoneli"><input type="text" name="phone" class="newphone width-163 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all"></li><li class="newli"><label class="width-50" style="padding-left:20px;">Cell</label></li><li class="newli contactphoneli"><input type="text" name="cell" class="newphone width-163 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all"></li><li class="clear newli"><label class="width-65">Fax</label></li><li class="newli contactphoneli"><input type="text" name="fax" class="newphone width-163 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all"></li><li class="newli"><label class="width-50" style="padding-left:20px;">Email</label></li><li class="newli"><input type="text" name="email" class="width-140 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all"></li><li class="newli"><a href=""><img src="/images/emailbutton.png"></a></li><li class="clear"><img class="imagebuttons deletecontact" src="/images/deletebutton.png"><input type="hidden" name="deletecontact" value="0"></li></ul>');	
				$('.newli').slideDown('fast');
				var prevli = $(this).siblings('.firstpropfield').find('.wijmo-wijtextbox');
$('.newphone').inputmask({"mask": "(999) 999-9999"});		
				prevli.focus();
			});			
			$('.deletecontact').live("click",function() {
					$(this).next().val(1);
					$(this).parent().parent().slideUp();
			});
	$('.proll').blur(function() {
		wcPayrollCalc();
	});			
});
//end document ready
saveClient = function(){
	 $('#saveclient').attr('disabled','disabled');
		var data = $('#clientform').serialize();
		<cfif client_id neq 0>
		wcPayrollCalc();
		var selectval = $('#testselect').val();
		//alert(selectval);
		
		$('input[name="owner_name"]').each(function() {
		var owner_name = $(this).val();
		var owner_title = $(this).next().val();
		var owner_percent = $(this).next().next().val();
		var owner_salary = $(this).next().next().next().val();
		var client_wc_id = $(this).next().next().next().next().val();
		var checked1 = $(this).next().next().next().next().next().attr('checked');
		if (checked1 == "checked") {
		var owner_include = 1;
		}
		else {
		var owner_include = 0;
		}
		var checked2 = $(this).next().next().next().next().next().next().attr('checked');
		if (checked2 == "checked") {
		var owner_exclude = 1;
		}
		else {
		var owner_exclude = 0;
		}		
		
 		if (owner_name != '') {
			$.ajax({
			  type: "POST",
			  cache: false,
			  url: "/index.cfm?event=main.addWCOwner",
			  data: {
				owner_name: owner_name,
				owner_title: owner_title,
				owner_percent: owner_percent,
				owner_salary: owner_salary,
				client_id: <cfoutput>#val(client_id)#</cfoutput>,
				client_wc_id: client_wc_id,
				owner_include: owner_include,
				owner_exclude: owner_exclude
			  }

			}).success(function(resp) {

			});			
		}
		else {
			$.ajax({
			  type: "POST",
			  cache: false,
			  url: "/index.cfm?event=main.deleteWCOwner",
			  data: {
				client_wc_id: client_wc_id
			  }

			}).success(function(resp) {

			});			
			
		}
		}); //end each owner_name function
		createWCOwnerFields();
		$('input[name="loc_desc"]').each(function() {
		var loc_desc = $(this).val();
		var loc_amount = $(this).next().val();
	    var client_loc_id = $(this).next().next().val();
		  var thistab = $(this).parent().parent().parent().attr('othertab');
			
			

			$.ajax({
			  type: "POST",
			  cache: false,
			  url: "/index.cfm?event=main.addLOC",
			  data: {
				loc_desc: loc_desc,
				loc_amount: loc_amount,
				client_loc_id: client_loc_id,
				client_id: <cfoutput>#val(client_id)#</cfoutput>,
				othertab: thistab
			  }

			}).success(function(resp) {

			});			

		}); //end each owner_name function
		createLOCFields(1);
		createLOCFields(2);
		createLOCFields(3);		
		</cfif>

		
			$.ajax({
			  type: "GET",
			  cache: false,
			  url: "/index.cfm?event=main.addEditClient",
			  data: data

			}).success(function(resp) {
				//alert(resp);
				var isnewID = $.isNumeric(resp);

				if (resp == '"success"'){
	
		 
				 $(window).scrollTop(0);
				 
				   saveAlert();
				   isDirty = false;
					$("#locationgrid").wijgrid("destroy");
					createLocationGrid();
				}
				else if (isnewID == true) {
					
					var url = '/index.cfm?event=main.client&client_id=' + resp;	 
					isDirty = false;
					window.location.href = url;
				}
				else{
					error = "There was an error - " + resp;
					alert(error);
				}
				 
				$('#saveclient').removeAttr('disabled');
			});
		
}
<cfif client_id neq 0>
refreshLocationGrid = function() {
	var pageLoadTime = $('#pageLoadTime').val();
	//var rows = $("#locationgrid").wijgrid("data").length;
	var url = '/index.cfm?event=main.getLocations&client_id=<cfoutput>#val(client_id)#</cfoutput>&isRefresh=1&pageLoadTime='+pageLoadTime;
			$.ajax({
			  type: "GET",
			  cache: false,
			  url: url,
			  dataType: "json",
			}).success(function(resp) {
				if (resp != "NOREFRESH") {
					var tablerows = $("#locationgrid tr").length;
					if (tablerows == 0) {
						var url = '/index.cfm?event=main.client&client_id=<cfoutput>#val(client_id)#</cfoutput>';
						isDirty = false;
						window.location.href = url;						
					}
					else {
						$("#locationgrid").wijgrid("destroy");
						createLocationGrid();
						var newloadtime = new Date();
						$('#pageLoadTime').val(newloadtime);
					}
				}

			});	
}

createLocationGrid = function(){
var url = '/index.cfm?event=main.getLocations&client_id=<cfoutput>#val(client_id)#</cfoutput>';
		$("#locationgrid").wijgrid({
				allowSorting: true,
				allowPaging: false,
                //pageSize: 10,
				columns: [
						  { headerText: "Loc" },
						  { headerText: "Entity Name" },
						  { headerText: "Address" },
						  { headerText: "Description" },
						  { headerText: "Status" },
						  { headerText: "Exclude" },
						  { headerText: "App"},
						  { headerText: "Rating"},
						  { headerText: "Endorse"}<cfif SESSION.auth.role is 1>,
						  { headerText: "Delete"}</cfif>
],				
                data: new wijdatasource({
                    proxy: new wijhttpproxy({
                        url: url,
                        dataType: "json",
                        data: {
						cache: false
                        },
                        key: "data"
                    }),
					
                    reader: new wijarrayreader([

					 { name: "Loc", mapping: "location_number" },
					 { name: "Entity Name", mapping: "ni" },
					 { name: "Address", mapping: function(item){
					 	var sitem = item.address + ', ' + item.city + ', ' + item.statename + ' ' + item.zip;

					   	return sitem;
					   	
					 	} 
					 },
					  { name: "Description", mapping: "description" },
					 { name: "Status", mapping: function(item){
					 	var sitem = item.location_status_id;
					 	
					//	var sdrop = "<select class='locationselect' name='loc_" + item.location_id +"' id='loc_" + item.location_id +"' selectme='"+sitem+"'></select>";
						var sdrop = "<select class='locationselect selectbox2' name='loc_" + item.location_id +"' id='stat_" + item.location_status_id +"'><cfloop query='rc.lstatus'><option value='<cfoutput>#locations_statusid#</cfoutput>'><cfoutput>#location_status#</cfoutput></option></cfloop>";
					   	return sdrop;
					   	
					 	} 
					 },
					 { name: "Exclude", mapping: function (item) { 
					 var ischecked = item.exclude_prop;
					 if (ischecked == 1) {
						 var checked = 'checked="checked"';
					 }
					 else {
						 var checked = '';
					 }
					 var link1 = '<input type="checkbox" name="exclude_' + item.location_id + '" value="1" class="exclude_prop" '+checked+' ratingid="'+item.myratingid+'">';
					 	return link1
						} 
						},
						 { name: "App", mapping: function (item) { 
					 		var link2 = "<a target='_blank' href='/index.cfm?event=app&client_id=<cfoutput>#val(client_id)#</cfoutput>&application_id=" + item.application_id + "&ratingid=" + item.myratingid + "'>App</a>";
					 		return link2
						} 
						},
						 { name: "Rating", mapping: function (item) { 
					 var link3 = "<a target='_blank' href='/index.cfm?event=main.ratings&application_id=" + item.application_id + "&location_id=" + item.location_id + "&ratingid=" + item.myratingid + "&client_id=" + item.client_id + "'>Rating</a>";
					 	return link3
						}
						},
					{ name: "Endorsements", mapping: function (item) { 
					 /* var link4 = "<a target='_blank' href='/index.cfm?event=main.ratings&endorse=1&application_id=0&ratingid=0&location_id=0&orig_application_id=" + item.application_id + "&oldlocation_id=" + item.location_id + "&oldratingid=" + item.myratingid + "&client_id=" + item.client_id + "'>Add Endorsement</a>"; */
					 var link4 = "<a target='_blank' href='/index.cfm?event=main.ratings&endorse=1&ratingid=0&application_id=" + item.application_id + "&location_id=" + item.location_id + "&oldratingid=" + item.myratingid + "&client_id=" + item.client_id + "'>Add Endorsement</a>";
					 	return link4
						}
					}<cfif SESSION.auth.role is 1>,
					{ name: "Delete", mapping: function (item) { 
					 /* var link4 = "<a target='_blank' href='/index.cfm?event=main.ratings&endorse=1&application_id=0&ratingid=0&location_id=0&orig_application_id=" + item.application_id + "&oldlocation_id=" + item.location_id + "&oldratingid=" + item.myratingid + "&client_id=" + item.client_id + "'>Add Endorsement</a>"; */
					 var link5 = "<img src='/images/deletebutton.png' class='imagebuttons deleteloc' delete_id='" + item.location_id + "'>";
					 	return link5
						}
					}</cfif>					
                  ])
                }),
				loaded: function (e) { populateLocSelect();}
            });

}
</cfif>
populateLocSelect = function() {
	$('.locationselect').each(function() {	
			var myid = $(this).attr("id");
			var idstr = myid.substr(5);
			$(this).val(idstr);
		});	
}
createUEGrid = function() {            
var url = '/index.cfm?event=main.getConsolidated&client_id=<cfoutput>#val(client_id)#</cfoutput>';
		$("#uegrid").wijgrid({
				allowSorting: true,
				allowPaging: true,
                pageSize: 10,
				columns: [
						  { headerText: "Client Code" },
						  { headerText: "AMS" },
						  { headerText: "Entity Name" },
						  { headerText: "DBA" },
						  { headerText: "DELETE" }
],				
                data: new wijdatasource({
                    proxy: new wijhttpproxy({
                        url: url,
                        dataType: "json",
                        data: {
						cache: false
                        },
                        key: "data"
                    }),
                    reader: new wijarrayreader([

					 { name: "Client Code", mapping: "client_code" },
					 { name: "AMS", mapping: "ams" },
					 { name: "Entity Name", mapping: "entity_name" },
					 { name: "DBA", mapping: "dba" },
					 { name: "DELETE", mapping: function (item) { 
					 //var link1 = "<a href='/index.cfm?event=main.users&user_id=" + item.USER_ID + "'>EDIT</a>";
					 var link1 = "<img src='/images/deletebutton.png' class='imagebuttons deletec' deleteconsolidation_id='" + item.ue_consolidation_id + "'>";
// x.value = x.value.replace(/['"]/g,'');
					 	return link1
						} 
						}
                  ])
                })
            });

}
createEPLIGrid = function() {            
var url = '/index.cfm?event=main.getEPLIConsolidated&client_id=<cfoutput>#client_id#</cfoutput>';
		$("#epligrid").wijgrid({
				allowSorting: true,
				allowPaging: true,
                pageSize: 10,
				columns: [
						  { headerText: "Client Code" },
						  { headerText: "AMS" },
						  { headerText: "Entity Name" },
						  { headerText: "DBA" },
						  { headerText: "DELETE" }
],				
                data: new wijdatasource({
                    proxy: new wijhttpproxy({
                        url: url,
                        dataType: "json",
                        data: {
						cache: false
                        },
                        key: "data"
                    }),
                    reader: new wijarrayreader([

					 { name: "Client Code", mapping: "client_code" },
					 { name: "AMS", mapping: "ams" },
					 { name: "Entity Name", mapping: "entity_name" },
					 { name: "DBA", mapping: "dba" },
					 { name: "DELETE", mapping: function (item) { 
					 //var link1 = "<a href='/index.cfm?event=main.users&user_id=" + item.USER_ID + "'>EDIT</a>";
					 var link1 = "<img src='/images/deletebutton.png' class='imagebuttons deleteeplic' deleteconsolidation_id='" + item.epli_consolidation_id + "'>";
// x.value = x.value.replace(/['"]/g,'');
					 	return link1
						} 
						}
                  ])
                })
            });

}
createWCGrid = function() {            
var url = '/index.cfm?event=main.getWCConsolidated&client_id=<cfoutput>#client_id#</cfoutput>';
		$("#wcgrid").wijgrid({
				allowSorting: true,
				allowPaging: true,
                pageSize: 10,
				columns: [
						  { headerText: "Client Code" },
						  { headerText: "AMS" },
						  { headerText: "Entity Name" },
						  { headerText: "DBA" },
						  { headerText: "DELETE" }
],				
                data: new wijdatasource({
                    proxy: new wijhttpproxy({
                        url: url,
                        dataType: "json",
                        data: {
						cache: false
                        },
                        key: "data"
                    }),
                    reader: new wijarrayreader([

					 { name: "Client Code", mapping: "client_code" },
					 { name: "AMS", mapping: "ams" },
					 { name: "Entity Name", mapping: "entity_name" },
					 { name: "DBA", mapping: "dba" },
					 { name: "DELETE", mapping: function (item) { 
					 //var link1 = "<a href='/index.cfm?event=main.users&user_id=" + item.USER_ID + "'>EDIT</a>";
					 var link1 = "<img src='/images/deletebutton.png' class='imagebuttons deletewcc' deleteconsolidation_id='" + item.wc_consolidation_id + "'>";
// x.value = x.value.replace(/['"]/g,'');
					 	return link1
						} 
						}
                  ])
                })
            });

}
createPolicyGrid = function() {            
var url = '/index.cfm?event=main.getPolicies&client_id=<cfoutput>#client_id#</cfoutput>';
		$("#policygrid").wijgrid({
				allowSorting: true,
				allowPaging: false,
				columns: [
						  { headerText: "Policy Type" },
						  { headerText: "Effective" },
						  { headerText: "Expiration" },
						  { headerText: "Issuing Company" },
						  { headerText: "Policy #" },
						  { headerText: "Status" },
						  { headerText: "Cancel Date" },
						  { headerText: "EDIT/RENEW/DELETE" }
],				
                data: new wijdatasource({
                    proxy: new wijhttpproxy({
                        url: url,
                        dataType: "json",
                        data: {
						cache: false
                        },
                        key: "data"
                    }),
                    reader: new wijarrayreader([

					 { name: "Policy Type", mapping: "policy_type" },
					 { name: "Effective", mapping: "policyeffectivedate" },
					 { name: "Expiration", mapping: "policyexpiredate" },
					 { name: "Issuing Company", mapping: "issuing_company" },
					 { name: "Policy", mapping: "policynumber" },
					 { name: "Status", mapping: "policy_status" },
					 { name: "Cancel Date", mapping: "policycanceldate" },
					 { name: "EDIT/RENEW/DELETE", mapping: function (item) { 
		
					 var link1 = "<img src='/images/editbutton.png' class='imagebuttons editpolicy' editpolicy_id='" + item.policy_id + "'><img src='/images/renewbutton.png' class='imagebuttons renewpolicy' renewpolicy_id='" + item.policy_id + "'><img src='/images/deletebutton.png' class='imagebuttons deletepolicy' deletepolicy_id='" + item.policy_id + "'>";

					 	return link1
						} 
						}
                  ])
                })
            });

}
createNIGrid = function() {            
var url = '/index.cfm?event=main.getNI&client_id=<cfoutput>#client_id#</cfoutput>';
		$("#nigrid").wijgrid({
				allowSorting: true,
				allowPaging: true,
                pageSize: 10,
				columns: [
						  { headerText: "Entity Name" },
						  { headerText: "FEIN" },
						  { headerText: "Year Started" },
						  { headerText: "Relationship" },
						  { headerText: "Notes" },
						  { headerText: "Applicable LOC", width: 130, ensurePxWidth: true },
						  { headerText: "EDIT/ DELETE", width: 80, ensurePxWidth: true }
],				
                data: new wijdatasource({
                    proxy: new wijhttpproxy({
                        url: url,
                        dataType: "json",
                        data: {
						cache: false
                        },
                        key: "data"
                    }),
                    reader: new wijarrayreader([

					 { name: "Entity Name", mapping: function (item) { 
					 var content = '<div style="width:150px;">'+item.named_insured+'</div>';

		
					 return content;
						} 
						},
					 { name: "FEIN", mapping: function (item) { return item.ni_fein } },
					 { name: "Year Started", mapping: function (item) { return item.yearstarted } },
					 { name: "Relationship", mapping: function (item) { return item.ni_relationship } },
					 { name: "Notes", mapping: function (item) { return item.notes } },
					 { name: "Applicable LOC", mapping: function (item) { 
					 var content = [];
					 if (item.gl == 1) {
					 	content.push("GL");
					 }
					 if (item.property == 1) {
						 content.push("Property");
					 }
					 if (item.ue == 1) {
						 content.push("UE");
					 }
					 if (item.wc == 1) {
						 content.push("WC");
					 }
					 if (item.epli ==1) {
						 content.push("EPLI");
					 }
		
					 return content;
						} 
						},
					{ name: "EDIT/DELETE", mapping: function (item) { 
					 //var link1 = "<a href='/index.cfm?event=main.users&user_id=" + item.USER_ID + "'>EDIT</a>";
					 var link1 = "<img src='/images/editbutton.png' class='imagebuttons editni' edit_id='" + item.named_insured_id + "'><img src='/images/deletebutton.png' class='imagebuttons deleteni' delete_id='" + item.named_insured_id + "'>";
// x.value = x.value.replace(/['"]/g,'');
					 	return link1
						} 
						}	
                  ])
                })
            });

}
createWCOwnerFields = function() {            
	$('.wcowners').remove();	
		var id = <cfoutput>#val(client_id)#</cfoutput>;
//get owner info for wc tab
	$.ajax({
		type: "GET",
		url: "/index.cfm?event=main.getClientWC",
		dataType: "json",
		data: {
			client_id: id
		}
	}).success(function(response) {
		//figure out how many there are, and how many blank rows we need
		var rows = response.recordcount;
  		if (rows < 4) {
		var blankrows = 3 - rows;
		}
		else {
		var blankrows = 0
		}
		//alert(blankrows);
		if (rows > 0) {
			//if there are records, loop through them and create fields
		$.each(response.data, function(k,v) {	
			if (v.owner_include == 1) {
				var checked1 = ' checked="checked"';
			}
			else {
				var checked1 = '';
			}
			if (v.owner_exclude == 1) {
				var checked2 = ' checked="checked"';
			}
			else {
				var checked2 = '';
			}			
$("#addwcowner").before('<li class="clear wcowners"><input type="text" name="owner_name" class="txtleft width-195 wcowners wijmo-wijtextbox ui-widget ui-state-default ui-corner-all" value="' + v.owner_name + '"><input type="text" name="owner_title" class="txtleft width-200 wcowners wijmo-wijtextbox ui-widget ui-state-default ui-corner-all" value="' + v.owner_title + '"><input type="text" name="owner_percent" class="width-50 wcowners wijmo-wijtextbox ui-widget ui-state-default ui-corner-all ownerpercent" value="' + v.owner_percent + '"><input type="text" name="owner_salary" class="width-111 wcowners wijmo-wijtextbox ui-widget ui-state-default ui-corner-all ownersalary" value="' + v.owner_salary + '"><input type="hidden" name="client_wc_id" class="wcowners" value="' + v.client_wc_id + '"><input type="checkbox" name="owner_include"  class="wcowners wccheck" value="1"' + checked1 + ' /><input type="checkbox" name="owner_exclude" class="wcowners wccheck wcchecklast" value="1"' + checked2 + ' /></li>');

		});
		}
		//create blank fields, if necessary
		for (i=0; i<blankrows; i++) {
 			$("#addwcowner").before('<li class="clear wcowners"><input type="text" name="owner_name" class="txtleft width-195 wcowners wijmo-wijtextbox ui-widget ui-state-default ui-corner-all ownername"><input type="text" name="owner_title" class="txtleft width-200 wcowners wijmo-wijtextbox ui-widget ui-state-default ui-corner-all ownertitle"><input type="text" name="owner_percent" class="width-50 wcowners wijmo-wijtextbox ui-widget ui-state-default ui-corner-all ownerpercent numbermask"><input type="text" name="owner_salary" class="width-111 wcowners wijmo-wijtextbox ui-widget ui-state-default ui-corner-all ownersalary"><input type="hidden" name="client_wc_id" class="wcowners wccheck" value="0"><input type="checkbox" name="owner_include" value="1" class="wcowners wccheck" /><input type="checkbox" name="owner_exclude" value="1" class="wcowners wccheck wcchecklast" /></li>');
        }
					
	});	


}
createLOCFields = function(othertab) {            
	$('.locs').remove();	
	
		var id = <cfoutput>#val(client_id)#</cfoutput>;
//get owner info for wc tab
	$.ajax({
		type: "GET",
		url: "/index.cfm?event=main.getClientLOC",
		dataType: "json",
		data: {
			client_id: id,
			othertab: othertab
		}
	}).success(function(response) {
		//figure out how many there are, and how many blank rows we need
		var rows = response.recordcount;
  		if (rows < 2) {
		var blankrows = 1 - rows;
		}
		else {
		var blankrows = 0
		}
		//alert(blankrows);
		if (rows > 0) {
			//if there are records, loop through them and create fields
		$.each(response.data, function(k,v) {	
			
$("#addloc"+othertab).before('<li class="clear locs"><label class="txtleft locs">Coverage</label></li><li><input type="text" name="loc_desc" class="txtleft width-190 locs wijmo-wijtextbox ui-widget ui-state-default ui-corner-all" value="'+v.loc_desc+'" /><input type="text" name="loc_limit" class="width-80 locs wijmo-wijtextbox ui-widget ui-state-default ui-corner-all" value="'+v.loc_amount+'" /><input type="hidden" name="client_loc_id" value="'+v.client_loc_id+'" /></li>');

		});
		}
		//create blank fields, if necessary
		for (i=0; i<blankrows; i++) {
 			$("#addloc"+othertab).before('<li class="clear locs"><label class="txtleft locs">Coverage</label></li><li><input type="text" name="loc_desc" class="txtleft width-190 locs wijmo-wijtextbox ui-widget ui-state-default ui-corner-all" /><input type="text" name="loc_limit" class="width-80 locs wijmo-wijtextbox ui-widget ui-state-default ui-corner-all" /><input type="hidden" name="client_loc_id" value="0" /></li>');
        }
					
	});	


}
function getUEState() {
	var state_id = $('#ue_rate_state').val();
	 //get state tax info
	$.ajax({
		type: "GET",
		url: "/index.cfm?event=main.getStates",
		dataType: "json",
		data: {
			state_id: state_id
		}
	}).success(function(response) {
		$.each(response.data, function(k,v) {
	//console.log(v);
	//premium
		var ue_premium = $('#ue_premium').autoNumericGet();
		var calculation = v.calculation;
		var rpgfee = $('#ue_agencyfee').autoNumericGet();
		//console.log(ue_premium);
		//terrorism
		var ue_terrorismrate = v.terrorism_fee / 100;
		var ue_terrorism = ue_premium * ue_terrorismrate;
			var ischecked = $('#ue_terrorism_rejected').attr('checked');
			if (ischecked != 'checked') {
			$('#ue_terrorism_fee').autoNumericSet(ue_terrorism);
			$('#ue_terrorism_fee_field').autoNumericSet(ue_terrorism);
			}

		//tax
		if (calculation == 'tax_premium_fees') {
			var temp = ue_premium + rpgfee;
			var ue_sltax = (parseFloat(ue_premium) + parseFloat(rpgfee)) * (v.tax_rate / 100);	
			//console.log(ue_sltax);
		}
		else { 
			var ue_sltax = ue_premium * (v.tax_rate / 100);
		}		
		

		$('#ue_sltax').autoNumericSet(ue_sltax);
		//stamping fee
		
		var ue_stampingfee = (parseFloat(ue_premium) + parseFloat(rpgfee) + parseFloat(v.filing_fee)) * (v.stamp_tax / 100);

		$('#ue_stampingfee').autoNumericSet(ue_stampingfee);		
		//stamping fee ue_brokerfee
		var ue_filingfee = v.filing_fee;
		$('#ue_filingfee').autoNumericSet(ue_filingfee);		
		//broker fee
		var ue_brokerfee = ue_premium * (v.broker_policy_fee / 100);
		$('#ue_brokerfee').autoNumericSet(ue_brokerfee);	
		//trigger blur so it totals
		$('.ueprem').trigger('blur');			
		});				
	});	
}
function wcPayrollCalc() {
	var totalp = 0;
	$('.payrollcalc').each(function(index, element) {
    totalp = parseFloat(totalp) + parseFloat($(this).autoNumericGet());
  });
	$('#wc_payroll').autoNumericSet(totalp);
}
</script>