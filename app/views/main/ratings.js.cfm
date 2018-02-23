<script type="text/javascript">

$(document).ready(function(){
	createHistoryGrid();
	getOtherExp();
	//getDebit();
	//getCredit();
	$('.printpage').click(function(e) {
		e.preventDefault();
		$(this).hide();
		window.print(); 
	});
$('#historyfilter').click(function(e){
	e.preventDefault();
	$("#historygrid").wijgrid("destroy");
	createHistoryGrid();
});	
$('#prop_exclwind').click(function(){
	var windchecked = $(this).attr('checked');
	if (windchecked == 'checked') {
		$('#prop_winddeductable').val("").addClass('readonlyLive');	
	}
	else {
		$('#prop_winddeductable').removeClass('readonlyLive');
	}
});	

<cfif endorse eq 1>
//if endorsement reset exposures, annual, base rate, total, etc
	$('.expo').autoNumericSet(0);
	$('.annual').autoNumericSet(0);
	$('#total_annual').autoNumericSet(0);
	$('#application_id').val(0);
</cfif>
<cfif viewhistory eq 1>

	$('input,textarea,select').attr('disabled','disabled');
	//$('button, .plus').not('.csummarybutton, .asummarybutton').hide();
	$('.selectbox2').addClass('wijmo-wijtextbox ui-widget ui-state-default ui-corner-all txtleft');
	$("#tabs" ).wijtabs({ disabledIndexes: [2] });
	//$(".datebox").wijinputdate({ disabled: true });
</cfif>
	$('#historytab').click(function() {
		$("#historygrid").wijgrid("destroy");	
		createHistoryGrid();
	});

	$('.saveratingbutton').click(function(e) {
		e.preventDefault();
		//disable to prevent double saving. Reenable after save complete.
		$(this).attr('disabled','disabled');
		data = $('#ratingform').serialize();	
		
		var glterrorismreject = $('#terrorism_rejected').attr('checked');
		if (glterrorismreject != 'checked') {
			var terrorism_rejected = 0
		}
		else {
			var terrorism_rejected = 1	
		}
		data = data + '&terrorism_rejected=' + terrorism_rejected;
		$.ajax({
			  type: "POST",
			  cache: false,
			  dataType:"json",
			  url: "/index.cfm?event=main.addEditRatings&history=0",
			  data: data
				}).success(function(resp) {
					//console.log(resp);
					if('ratingid' in resp) {
						var wasNewRating = $('#ratingid').val();
						if (wasNewRating == 0) {
						var url = '/index.cfm?event=main.ratings&application_id=<cfoutput>#URL.application_id#</cfoutput>&location_id=<cfoutput>#URL.location_id#</cfoutput>&ratingid='+resp.ratingid+'&client_id=<cfoutput>#URL.client_id#</cfoutput>'; 
					  window.location.href = url;	
						}
						else {
						saveAlert();
						getOtherExp();
						//reenable save button
						$('.saveratingbutton').removeAttr('disabled');
						}
						//getDebit();
						//getCredit();
						//$(":input[type='checkbox']").not(".plaincheck").wijcheckbox("refresh");
					}
					else {
						alert("There was an error. Tell Scott");
					}

			});
			
		});
$('.savehistorybutton').click(function(e) {
		e.preventDefault();
		var data = $('#ratingform').serialize();	
		$.ajax({
			  type: "POST",
			  cache: false,
			   dataType:"json",
			  //url: "/index.cfm?event=main.addEditRatings&history=1",
				 url: "/index.cfm?event=app.saveapphistory",
			  data: data
				}).success(function(resp) {
					saveAlert();
					getOtherExp();
					//getDebit();
					//getCredit();
					/*$('#ratingid').val(resp.ratingid);
					$('#rating_liability_id').val(resp.rating_liability_id);
					$('#rating_property_id').val(resp.rating_property_id);*/
			});
			
		});
$('.deleteexp').live('click',function() {
	$(this).prev().prev().prev().val(1);
	$(this).prev().val(0);
	var parentli = $(this).parent();
	$(parentli).slideUp();
});
$('.deletedebit').live('click',function() {
	$(this).prev().prev().prev().val(1);
	$(this).prev().val(0);
	var parentli = $(this).parent();
	$(parentli).slideUp();
});
$('.deletecredit').live('click',function() {
	$(this).prev().prev().prev().val(1);
	$(this).prev().val(0);
	var parentli = $(this).parent();
	$(parentli).slideUp();
});
$('.saveendorsebutton').click(function(e) {
		e.preventDefault();
		//console.log('clicked');
		var data = $('#ratingform').serialize();	
		$.ajax({
			  type: "POST",
			  cache: false,
			   dataType:"json",
			  url: "/index.cfm?event=main.addEditRatings&history=1&endorse=1&endorsement_id=<cfoutput>#oldratingid#</cfoutput>",
			  data: data
				}).success(function(resp) {
					//saveAlert();
					//console.log(resp);

					var url = '<cfoutput>/index.cfm?event=main.ratings&application_id=0&location_id=#location_id#&ratingid='+resp.ratingid+'&client_id=#client_id#</cfoutput>';
					window.location.href = url;
					
			});
			
		});

//make sure value of yesnoquestions on each tab reflects changes made in the other.
$('#yesnoquestions').bind('keypress blur', function() {
    $('#prop_yesnoquestions').val($(this).val());
});
$('#prop_yesnoquestions').bind('keypress blur', function() {
    $('#yesnoquestions').val($(this).val());
});

//$(".propchecks").wijcheckbox("refresh");	
<cfif viewhistory neq 1>
//getStateTaxes();	
checkForAlert();	
</cfif>	
//gl plan selection 

$('#liability_plan_id').change(function() {
						
	//$("#broker_override").removeAttr("checked");
	//$("#broker_override").wijcheckbox("refresh");										
	var id = $(this).val();	
		
	if (id != 0) {
		getLiabilityPlan();
	}

	
});
			//Add GL Other Exposure
			$("#addglExp").click(function() {	
										
				$('#otherexpsec').append('<li class="newli expli clear"><input type="hidden" name="otherexp_id" value=""><input type="hidden" name="del_exp" value="0"><input type="text" name="new_expo" class="width-122 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all txtleft newexpo"><input type="text" name="new_annual" class="width-80 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all newannual"><img class="imagebuttons deleteexp" src="/images/deletebutton.png"></li>');	
				$('.newli').slideDown('fast');
				//find newly created field and set focus
				var prevli = $(this).prev().find('.newexpo');
				prevli.focus();	
				//input mask for dollars		
				$('.newannual').autoNumeric({aSign: '$'});
			});

			//Add GL Debit
			$("#addglDebit").click(function() {										  
				$('#otherdebitsec').append('<li class="newli debitli clear"><input type="hidden" name="debit_id" value=""><input type="hidden" name="del_debit" value="0"><input class="width-200 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all txtleft newdebitname" name="new_debitname"><input class="width-80 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all newdebitamount" type="text" name="new_debitamount"><img class="imagebuttons deletedebit" src="/images/deletebutton.png"></li>');	
				$('.newli').slideDown('fast');
				//find newly created field and set focus
				var prevli = $(this).prev().find('.newdebitname');
				prevli.focus();
	
				$('.newdebitamount').autoNumeric({aSign: '%',aSep:'',mDec: 0,pSign:'s',vMin: '0'});

			});	
			$("#addglCredit").click(function() {										  
				$('#othercreditsec').append('<li class="newli creditli clear"><input type="hidden" name="credit_id" value=""><input type="hidden" name="del_credit" value="0"><input class="width-200 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all txtleft newcreditname" name="new_creditname"><input class="width-80 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all newcreditamount" type="text" name="new_creditamount"><img class="imagebuttons deletecredit" src="/images/deletebutton.png"></li>');	
				$('.newli').slideDown('fast');
				//find newly created field and set focus
				var prevli = $(this).prev().find('.newcreditname');
				prevli.focus();
				//input mask for dollars		
				$('.newcreditamount').autoNumeric({aSign: '%',aSep:'',mDec: 0,pSign:'s',vMin: '0'});

			});				
$('#terrorism_rejected').click(function() {
	var tfee = $('#terrorism_fee').autoNumericGet();
	var ischecked = $('#terrorism_rejected').attr('checked');
	if (ischecked == 'checked') {
		var tfee = 0;
	}
	$('#terrorism_fee_field').autoNumericSet(tfee);
});

$("#glratebutton").click(function(e) {
	e.preventDefault();	
	
 	var planid = $('#liability_plan_id').val();
	if (planid != 0)
	{
	 getLiabilityPlan(true);
	}
	else {
		alert('Select a rating plan');
	}

});//end glratebutton click
//trigger initial gl plan selection		
<cfif viewhistory neq 1>
//$('#liability_plan_id').trigger('change');
</cfif>
//autocomplete for debit names
$(".newdebitname").live("focus", function (event) {
    $(this).autocomplete({
			source: "/index.cfm?event=main.creditSearch",
			minLength: 1
});
});
/*

Property Tab stuff 

*/			

			//Add Prop1
			$("#addProp1").click(function() {		
										 
				$(this).before('<li class="newli firstpropfield"><input type="hidden" name="other_property_id" value=""><input name="newpropfield1" class="width-100 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all txtleft"><input type="text" name="newpropfield2" class="width-34 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all prate"><input type="text" name="newpropfield3" class="width-80 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all plimit"><input type="text" name="newpropfield4" class="width-80 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all ppremium eqpbrk"></li>');	
				$('.newli').slideDown('fast');
				var prevli = $(this).siblings('.firstpropfield').find('.wijmo-wijtextbox');
				prevli.focus();
			});	
			//Add Prop2
			$("#addProp2").click(function() {										  
				$(this).before('<li class="newli firstpropfield"><input type="hidden" name="eb_id" value=""><input name="newperil_name" class="width-100 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all txtleft"><input type="text" name="newperil_rate" class="width-34 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all prate"><input type="text" name="newperil_limit" class="width-80 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all"><input type="text" name="newperil_premium" class="width-80 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all ppremium eqpbrk"><li class="clear newli newdeduct"><label class="width-230 newdeductlabel">Deductible</label></li><li><input type="text" name="eb_deduct" class="width-80 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all" /></li>');	
				$('.newli').slideDown('fast');
				var prevli = $(this).siblings('.firstpropfield').find('.wijmo-wijtextbox');
				prevli.focus();
			});	
//dynamically add other peril name to deductible label			
$('input[name="newperil_name"]').live('keyup',function() {
			label = $(this).parent().next().find('.newdeductlabel');
			label.html($(this).val()+' Deductible');
});	


//cyber liability dropdown
	$('#cyber_liability_amount_id').change(function() {
	property_plan_id = $('#property_plan_id').val();
	cyber_liability_amount_id = $(this).val();
	if (property_plan_id != 0) {
		$.ajax({
			type: "GET",
			url: "/index.cfm?event=main.getCyberValue",
			dataType: "json",
			data: {
				property_plan_id: property_plan_id,
				cyber_liability_amount_id: cyber_liability_amount_id
			}
		}).success(function(response) {
			
			$.each(response.data, function(k,v) {	
				$("#property_cyber_amount").autoNumericSet(v.property_cyber_amount);
			});
			
			if (cyber_liability_amount_id == 0) {
				$("#property_cyber_amount").autoNumericSet(0);
			}
						
		});	
	}
	});
//employee dishonesty dropdown
	$('#employee_dishonesty_id').change(function() {
	property_plan_id = $('#property_plan_id').val();
	employee_dishonesty_id = $(this).val();
	if (property_plan_id != 0) {
		$.ajax({
			type: "GET",
			url: "/index.cfm?event=main.getEmpDisValue",
			dataType: "json",
			data: {
				property_plan_id: property_plan_id,
				employee_dishonesty_id: employee_dishonesty_id
			}
		}).success(function(response) {
			
			$.each(response.data, function(k,v) {	
				$("#property_emp_amount").autoNumericSet(v.property_emp_amount);
			});
			
			if (employee_dishonesty_id == 0) {
				$("#property_emp_amount").autoNumericSet(0);
			}
						
		});	
	}
	});	
//employee dishonesty dropdown
	$('#property_plan_id').change(function() {	
															
	var id = $(this).val();	
		
	if (id != 0) {
		getPropertyPlan();
	}

	
});

	$('#rateprop').click(function(e) {
		e.preventDefault();	
		//doPropRating();	
		var planid = $('#property_plan_id').val();
		if (planid != 0)
		{
		 getPropertyPlan(true);
		}		
		else {
			alert('Please Select a Property Plan');
		}
			
	});
<cfif viewhistory neq 1>
//$('#property_plan_id').trigger('change');	
</cfif>

$('.asummarybutton').click(function(e) {
	e.preventDefault();
	curTab = $('.ui-tabs-selected');
    curTabIndex = curTab.index();
	
	url = <cfoutput>'#cgi.SCRIPT_NAME#?#cgi.QUERY_STRING#&summary=a&printtab=' + curTabIndex</cfoutput>
	window.open(url);
});
$('.csummarybutton').click(function(e) {
	e.preventDefault();
	curTab = $('.ui-tabs-selected');
    curTabIndex = curTab.index();
	
	url = <cfoutput>'#cgi.SCRIPT_NAME#?#cgi.QUERY_STRING#&summary=b&printtab=' + curTabIndex</cfoutput>
	window.open(url);
});
<cfif isDefined('printtab')>
var tabindex = <cfoutput>#printtab#</cfoutput>

$("#tabs").wijtabs('select', tabindex);
$(".datebox").wijinputdate("destroy");
$('.datebox').addClass('blackborder').css({'margin-right':'2px'});	
	$('#header').hide();
	// hide inactive tabs
$('.ui-tabs-nav li').each(function() {
		var isactive = $(this).attr('aria-selected');
		if (isactive == 'false') {
			$(this).hide();
		}
});	
//if summary make fields readonly
$('input, select').focus(function() {
	$(this).blur();
});

$("input[type=checkbox],input[type=radio]").click(function(e){
	e.preventDefault();	
});
/*ghetto way of re-activating input masks for tabs other than default. loops through each field, setting the focus, which will then show the input mask
$('.wijmo-wijtextbox').each(function() {
	$(this).focus();								 
});*/
								   
	//$(":input[type='checkbox']").wijcheckbox("destroy");
	$('.wijmo-wijtextbox, .wijmo-wijtabs, .selectbox2, .wijmo-wijinput').addClass('blackborder');
	$('.ui-widget-header').addClass('noborder');
	$('body').css('background','none');
	$('#statusbar').css('color','#000000');
	$('.buttoncontainer').hide();
	$('.plus').hide();
	$('textarea').hide();
	$('#noteicon').hide();
	$('.msgcontainer').hide();
	$('#statusstuff').hide();
	$('.summaryinfo').show();
	$('.footerdate').show();
	$('#csummarymove2').appendTo('#csummarymove2dest');
	$('*').not('.printpage').css({'background':'none'});
	$('.planlabel1').text('Rating Plan');
	$('.planlabel2').text('Issuing Company');

<cfif printtab is 0>
var tabname = "LIABILITY";
$('.propplanli').hide();
$('#csummarymove1').removeClass('col3').appendTo('#abovetabs').width(700);

<cfelse>
var tabname = "PROPERTY";
$('.glplanli').hide();
$('#cpropsummarymove1').removeClass('col3').appendTo('#abovetabs');
$('.width-134').width(149);
</cfif>
	//window.print(); 
</cfif>	
<cfif isDefined('summary') and summary is 'a'>
$('.asummaryshow').show();
if (tabname == 'PROPERTY') {
$('.asummaryprop').show();
}
else {
$('.asummarygl').show();
$('.width-129').width(120);
$('.overridelabel').css({"width":51,"overflow":"hidden"});
}

$('.hidenotes').show();
$('#pagename').html(tabname + ' AGENCY SUMMARY');
$('.asummaryhide').hide();
<cfelseif isDefined('summary')>

$('#pagename').html(tabname+ ' RATING WORKSHEET FOR INSURANCE CARRIER');
$('.csummaryhide').hide();
$('.csummaryshow').show();
$('.csummaryspecial').width(200);
$('.tfeelabel').width(120);
$('.width-102').width(122);
$('.br').width(218);
$('.bratelabel').width(218);
$('#gl_prorate').css({'width':40, 'padding':'2px'});
$('#prop_prorate').css({'width':40, 'padding':'2px'});
$('.glfromto').width(169);
</cfif>

$('.overridefield').click(function() {
	overridefield = $(this).attr('overridefield');
	originalvalue = $('#'+overridefield).attr('originalval');
	ischecked = $(this).attr('checked');
	if (ischecked != 'checked') {	
		$('#'+overridefield).autoNumericSet(originalvalue).addClass('readonlyLive');	
	}
	else {
		$('#'+overridefield).removeClass('readonlyLive');
	}
});

});//end document ready

function getOtherExp() {
$('#otherexpsec').html('');	
		$.ajax({
			  type: "GET",
			  cache: false,
			  dataType:"json",
			  url: "/index.cfm?event=main.getOtherExp",
			  data: {
				rating_liability_id: <cfoutput>#val(rating_liability_id)#</cfoutput>  
			  }
				}).success(function(resp) {
					count = 0;
				$.each(resp.data,function(k,v) {
					count ++;
					$('.newli').show();
					$('#otherexpsec').append('<li class="newli expli clear"><input type="hidden" name="otherexp_id" value="'+v.otherexp_id+'"><input type="hidden" name="del_exp" value="0"><input type="text" name="new_expo" class="width-122 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all txtleft newexpo" value="'+v.expname+'"><input type="text" name="new_annual" class="width-80 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all newannual" value="'+v.other_annual+'"><img class="imagebuttons deleteexp" src="/images/deletebutton.png"></li>');				
				});
									if (count == resp.recordcount) {
						getDebit();
					}	
			});	
}
function getDebit() {
$('#otherdebitsec').html('');	
		$.ajax({
			  type: "GET",
			  cache: false,
			  dataType:"json",
			  url: "/index.cfm?event=main.getDebit",
			  data: {
				rating_liability_id: <cfoutput>#val(rating_liability_id)#</cfoutput> 
			  }
				}).success(function(resp) {
					count = 0;
				$.each(resp.data,function(k,v) {
					count ++;
					$('.newli').show();
					$('#otherdebitsec').append('<li class="newli debitli clear"><input type="hidden" name="debit_id" value="'+v.debtcredit_id+'"><input type="hidden" name="del_debit" value="0"><input class="width-200 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all txtleft newdebitname" name="new_debitname" value="'+v.debtcredit_name+'"><input class="width-80 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all newdebitamount percentmask2" type="text" name="new_debitamount" value="'+v.debtcredit_value+'%"><img class="imagebuttons deletedebit" src="/images/deletebutton.png"></li>');

				});
					if (count == resp.recordcount) {
						getCredit();
					}				
				$('.newdebitamount').autoNumeric({aSign: '%',aSep:'',mDec: 0,pSign:'s',vMin: '0'});
			});	
			
}
function getCredit() {
$('#othercreditsec').html('');	
		$.ajax({
			  type: "GET",
			  cache: false,
			  dataType:"json",
			  url: "/index.cfm?event=main.getCredit",
			  data: {
				rating_liability_id: <cfoutput>#val(rating_liability_id)#</cfoutput>
			  }
				}).success(function(resp) {
				$.each(resp.data,function(k,v) {
					//alert(v.otherexp_id);
					$('.newli').show();
					$('#othercreditsec').append('<li class="newli creditli clear"><input type="hidden" name="credit_id" value="'+v.debtcredit_id+'"><input type="hidden" name="del_credit" value="0"><input class="width-200 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all txtleft newcreditname" name="new_creditname" value="'+v.debtcredit_name+'"><input class="width-80 wijmo-wijtextbox ui-widget ui-state-default ui-corner-all newcreditamount percentmask2" type="text" name="new_creditamount" value="'+v.debtcredit_value+'%"><img class="imagebuttons deletecredit" src="/images/deletebutton.png"></li>');
				});
				$('.newcreditamount').autoNumeric({aSign: '%',aSep:'',mDec: 0,pSign:'s',vMin: '0'});
			});	
			
}
function proRate(date1,date2) {
    days = daydiff(parseDate(date1), parseDate(date2));	
	//divide days by 365 days in the year
	factor = days / 365;
	//round to thousandths
	roundedfactor = Math.round(factor*1000)/1000;
	return roundedfactor;
}
	
function parseDate(str) {
    var mdy = str.split('/')
    return new Date(mdy[2], mdy[0]-1, mdy[1]);
}

function daydiff(first, second) {
    return (second-first)/(1000*60*60*24)
}
function doPropRating() {
			//$(".propchecks").wijcheckbox("refresh");
			premiumoverride = $('#premium_override').attr('checked');
				propterrorismoverride = $("#prop_terrorism_override").attr('checked');
			isendorse = <cfoutput>#endorse#</cfoutput>;
			
			total = 0;
			tiv = 0;
			equipbrk = 0;
			$('.prate').each(function() {
				var prate = $(this).autoNumericGet();
				var plimit = $(this).next().autoNumericGet();
				var ppremium = Math.round(prate * plimit / 100);
				$(this).next().next().autoNumericSet(ppremium);
			});	
			$('.ppremium').each(function() {
				total = total + parseFloat($(this).autoNumericGet());							
			});
			
			$('.eqpbrk').each(function() {
				equipbrk = equipbrk + parseFloat($(this).autoNumericGet());				
				$('#prop_equipbreaktotal').autoNumericSet(equipbrk);
			});		
			propeqpbrkrate2 = $('#prop_equipbreakrate').autoNumericGet() / 100;
			ebpremium = Math.round(equipbrk * propeqpbrkrate2);
			$('#prop_equipbreakpremium').autoNumericSet(ebpremium);
			total = total + ebpremium;
			$('#prop_ratedpremium').autoNumericSet(total);
			if (premiumoverride != 'checked') {
				$('#prop_chargedpremium').autoNumericSet(total);
			}			
			if (premiumoverride == 'checked') {
				total = $('#prop_chargedpremium').autoNumericGet();
			}
		orginaltotal = total;
		propterrorism = Math.round(propterrorismrate * total);
		$("#prop_terrorism").attr("originalval", stampingfee);	
	//prop terrorism override 
		if (propterrorismoverride != 'checked') {		
			$('#prop_terrorism').autoNumericSet(propterrorism);
		}		
		else {
			propterrorism = parseFloat($('#prop_terrorism').autoNumericGet());
		}

			chargedpremium = parseFloat($('#prop_chargedpremium').autoNumericGet());
			//alert(propterrorism);
			rejectterrorism = $('#prop_terrorism_rejected').attr('checked');

			if (rejectterrorism == 'checked') {
				
				subtotal = chargedpremium;
			}
			else {
				subtotal = chargedpremium + propterrorism;
			}
			//figure pro rata
			var propdate1 = $('#propdate1').val();
			var propdate2 = $('#propdate2').val();
			propprorate = proRate(propdate1,propdate2);
			//alert(propprorate);
			$('#prop_prorate').val(propprorate);
			propproratapremium = Math.round(subtotal * propprorate);
			//propprorataterrorism = Math.round((propterrorismrate * total) * propprorate);
			
			proratafield = Math.round(chargedpremium * propprorate);
			propprorataterrorism = propproratapremium - proratafield;
			
			var useprorata = $('#prop_use_prorata').attr('checked');
			if (useprorata == 'checked') {
				$('#prop_proratapremium').autoNumericSet(proratafield);
			}
			else {
				$('#prop_proratapremium').autoNumericSet(0);
			}
			//if (useprorata == 'checked' && (prop_min_premium < propproratapremium || isendorse === 1)) {
				//tabatha had me remove the endorsement thing on 10/21/14
	//if (useprorata == 'checked' && isendorse !== 1) {
		if (useprorata == 'checked') {
				subtotal = propproratapremium;
				//$('#prop_chargedpremium').autoNumericSet(proratafield);
			}
		
			if (useprorata == 'checked' && prop_min_premium > propproratapremium && premiumoverride != 'checked' && isendorse !== 1) {
				// removed this on 9/25/14 per tabatha subtotal = prop_min_premium;
				//$('#prop_chargedpremium').autoNumericSet(propproratapremium);
			}
			//if pro rated changed terrorism
			if (useprorata == 'checked') {
				$('#prop_terrorism').autoNumericSet(propprorataterrorism);
			}
			$('#prop_subtotal').autoNumericSet(subtotal);
			agencyfieldrate = parseFloat($('#prop_agencyfee').autoNumericGet()) / 100;
			agencyfee = Math.round(subtotal * agencyfieldrate);
			
			$('#prop_agencyamount').autoNumericSet(agencyfee);
			proptaxes = subtotal * proptaxrate;
			propbrokerfee = parseFloat($('#prop_brokerfee').autoNumericGet());
			var proptaxoverride = $('#prop_taxoverride').attr('checked');
			if (proptaxoverride != 'checked') {
			$('#prop_taxes').autoNumericSet(proptaxes);
			}
			else {
				proptaxes = parseFloat($('#prop_taxes').autoNumericGet());
			}
			propgrandtotal = subtotal + agencyfee + propbrokerfee + proptaxes;
			$('#prop_grandtotal').autoNumericSet(propgrandtotal);	
	//remove blue
	$("#rateprop").removeClass("ui-state-focus");		
			<cfif endorse neq 1>
			if (prop_min_premium > subtotal) {
				alert('$'+prop_min_premium+' minimum premium applies.');
				//removed auto minimum premium override on 9/25 per tabatha 
				//total = prop_min_premium;
				//$('#prop_chargedpremium').autoNumericSet(prop_min_premium);
			}
			</cfif>		
}
function doGLRating() {
		//get base rate val and start totaling
		total = parseFloat($('.baserate').autoNumericGet());
		terrorism_minimum = $('#terrorism_minimum').val();
		
	//loop through each exposure field and add to total	
	$(".expo").each(function() {		
		expovalue = parseFloat($(this).autoNumericGet());
		//if exposure exists, do the math

		nextbase = $(this).next();
		basevalue = parseFloat(nextbase.autoNumericGet());
		nextannual = $(this).next().next();
		annualvalue = expovalue * basevalue;
		total = total + annualvalue;
		nextannual.autoNumericSet(annualvalue);
		
	 }); //end expo each
	//add manual exposures to total
	$(".newannual").each(function() {		
		thisval = parseFloat($(this).autoNumericGet());
		total = total + thisval;
	 }); //end newannual each	
	//write total to field
	$('#total_annual').autoNumericSet(total);
	 debittotal = 0;
	 modtotal = 1;
	 debittotalpercent = 0;
	$(".newdebitamount").each(function() {		
		thisval = parseFloat($(this).autoNumericGet());
		thisrate = thisval / 100;
		modtotal = modtotal + thisrate;
		thisdebit = total * thisrate
		debittotal = debittotal + thisdebit;
		debittotalpercent = debittotalpercent + thisval;
	 }); //end newdebitamount each
	$(".newcreditamount").each(function() {		
		thisval = parseFloat($(this).autoNumericGet());
		thisrate = thisval / 100;
		modtotal = modtotal - thisrate;
		thisdebit = total * thisrate
		debittotal = debittotal - thisdebit;
		debittotalpercent = debittotalpercent - thisval;
	 }); //end newdebitamount each	 
	
	$('#total_debits').autoNumericSet(debittotal);
	$('#total_debitspercent').autoNumericSet(debittotalpercent);
	$('#total_mod').autoNumericSet(modtotal);
	
	//premium mod factor
	premmod = $('#premium_mod').autoNumericGet() / 100;
	finalmod = (modtotal * premmod) + modtotal;
	finalmod = Math.round(finalmod * 100) / 100;
	

	//finalmod = modtotal + premmod;
	$('#final_mod').autoNumericSet(finalmod);
	//set loc annual premium
	laptotal = total * finalmod;
	
	laptotal = Math.round(laptotal);
	
	terrorism_fee = Math.round(laptotal * terrorismrate);
	if (terrorism_minimum > terrorism_fee) {
		terrorism = terrorism_minimum;	
		}
		else {
		terrorism = terrorism_fee;
	}

	
		
	$('.locannualprem').autoNumericSet(laptotal);
	//calculate pro rata
	var gldate1 = $('#gldate1').val();
	var gldate2 = $('#gldate2').val();
	roundedfactor = proRate(gldate1,gldate2);
	//get adjusted premium
	proratatotal = laptotal * roundedfactor;
	//round 
	proratatotal = Math.round(proratatotal);
	//pro rate terrorism
	prorataterrorism = terrorism * roundedfactor;
	if (prorataterrorism < terrorism_minimum) {
		prorataterrorism = terrorism_minimum;
	}
	prorataterrorism = Math.round(prorataterrorism*100)/100;

	$('#pro_rata_gl').autoNumericSet(proratatotal);
	$('#gl_prorate').val(roundedfactor);	
	//determine whether to use pro rata or not
	var usepr = $('#use_prorata').attr('checked');
	if (usepr == 'checked') {
		premium = proratatotal;
		finalterrorism = prorataterrorism;
	}
	else {
		premium = laptotal;
		finalterrorism = terrorism;
	}	
	
	//alert('terrorism='+finalterrorism);
	//check to see if terrorism rejected is checked. If not, add to premium before pro rata and taxes are figured
	ischecked = $('#terrorism_rejected').attr('checked');
	if (ischecked != 'checked') {
	//terrorismfee = parseFloat($('#terrorism_fee').autoNumericGet());
	finalpremium = parseFloat(premium) + parseFloat(finalterrorism);
	addterrorism = finalterrorism;
	}	
	else {
		
	finalpremium = premium;
	addterrorism = 0;
	}
		
	$("#terrorism_fee").autoNumericSet(finalterrorism);
	$("#terrorism_fee_field").autoNumericSet(addterrorism);
	//alert('finalpremium='+finalpremium);

	taxtotal = 0;	
	feetotal = 0;
	brokeroverride = $("#broker_override").attr('checked');
	baseoverride = $("#base_override").attr('checked');
	surplustaxoverride = $("#surplustax_override").attr('checked');
	inspectionoverride = $("#inspection_override").attr('checked');
	filingoverride = $("#filing_override").attr('checked');
	stampingoverride = $("#stamping_override").attr('checked');
	statemunioverride = $("#statemuni_override").attr('checked');
	rpgoverride = $("#rpg_override").attr('checked');
	

	//check to see if broker fee is overridden
	if (brokeroverride != 'checked') {
		//it's not, so reset the percent field and carry on
	$("#broker_percentoverride").autoNumericSet(brokerpercent);
	brokerfee = finalpremium * brokerrate;
	//alert(brokerfee);
	}
	//it is
	else {
		//is the override percentage or flat?
	brokercheck = $('#broker_percent').attr('checked');	
	
	brokercheckoverride = $('#broker_percentoverride').autoNumericGet() / 100;	
		if (brokercheck == 'checked') {
			brokerfee = finalpremium * brokercheckoverride;
			//alert(brokerfee);
		}
		else {
			brokerfee = parseFloat($("#brokerfee").autoNumericGet());
			//alert(brokerfee);
		}
	}
	brokerfee = Math.round(brokerfee);

	
	$("#brokerfee").autoNumericSet(brokerfee);
	$(".fees").each(function() {				  
		thisval = parseFloat($(this).autoNumericGet());
		feetotal = feetotal + thisval;
	}); //end fees each	 
	premiumandfees = finalpremium + feetotal + brokerfee;
	premiumandbrokerfee = finalpremium + brokerfee;
	 
		if (calculation == 'tax_premium_fees') {
		surplustax = premiumandfees * surplusrate;
		stampingfee = premiumandfees * stampingrate;
		//need premtaxtotal variable for use in custom tax below, so it knows whether to tax only premium or include fees
		premtaxtotal = premiumandfees;
		}
		else if (calculation == 'tax_premium_only'){
		surplustax = finalpremium * surplusrate;
		stampingfee = finalpremium * stampingrate;
		premtaxtotal = finalpremium;
		}
		else { //calculation is tax_premium_broker_fee_only
		surplustax = premiumandbrokerfee * surplusrate;
		stampingfee = premiumandbrokerfee * stampingrate;
		premtaxtotal = premiumandbrokerfee;
		}
		$("#stampingfee").attr("originalval", stampingfee);	
	//stamping override 
		if (stampingoverride != 'checked') {
			$("#stampingfee").autoNumericSet(stampingfee);
		}		
		if (surplustaxoverride == 'checked') {
			surplustax = $('#surplustax').autoNumericGet();
		}		
	$("#surplustax").autoNumericSet(surplustax);		
	$(".taxes").each(function() {				  
		thisval = parseFloat($(this).autoNumericGet());
		taxtotal = taxtotal + thisval;
	}); //end taxes each		
	//custom taxes
	
	$( ".custom_tax_amount:visible" ).each(function() {	

		//thisval = parseFloat($(this).autoNumericGet());
		thisrate = parseFloat($(this).next().val());
		thistype = $(this).next().next().val();
		thisoverride = $(this).parent().prev().prev().find('.customtaxoverride').attr('checked');
		
		if (thistype == '%') {
		
			var customamount = (thisrate / 100)  * premtaxtotal;
		}
		else {
			var customamount = thisrate;
		}
		if (thisoverride !== 'checked') {
			$(this).autoNumericSet(customamount);
		}
		else {
			var customamount = parseFloat($(this).autoNumericGet());
			//console.log(customamount);
		}
		
		taxtotal = taxtotal + customamount;
	});
	
	grandtotal = premium + feetotal + taxtotal + brokerfee + addterrorism;
	$('.grandtotal').autoNumericSet(grandtotal);

	
	//remove blue
	$("#glratebutton").removeClass("ui-state-focus");	
	


} //end doGLRating
createHistoryGrid = function() {
	var url = '/index.cfm?event=main.getRatingHistory&location_id=<cfoutput>#location_id#</cfoutput>';
	var getAll = $("#historyall").is(':checked');
	var startDate = $('#historyStartDate').val();
	var endDate = $('#historyEndDate').val();
	$("#historygrid").wijgrid({
                allowSorting: true,
                allowPaging: true,
                pageSize: 16,

                data: new wijdatasource({
                    proxy: new wijhttpproxy({
                        url: url,
                        dataType: "json",
                        data: {
						cache: false,
						getAll: getAll,
						startDate: startDate,
						endDate: endDate
                        },
                        key: "data"
                    }),
                    reader: new wijarrayreader([
					{ name: "Date", mapping: "savedatetime"},
					 { name: "Notes", mapping: function (item) { 

					 	var thisnote = item.notes; 

						return thisnote; } 
						},
					 { name: "User", mapping: "user_name" },
					 { name: "App History", mapping: function (item) { 
					 		if (item.application_id > 0) {
					 		var link2 = "<a target='_blank' href='/index.cfm?event=app&viewhistory=1&client_id=<cfoutput>#client_id#</cfoutput>&application_id=" + item.application_id + "'>App History</a>";
							}
							else {
								var link2 = '';
							}
					 		return link2
						} 
						},
						 { name: "Rating History", mapping: function (item) { 
					 var link3 = "<a target='_blank' href='/index.cfm?event=main.ratings&viewhistory=1&application_id=" + item.application_id + "&location_id=" + item.location_id + "&ratingid=" + item.ratingid + "&client_id=<cfoutput>#client_id#</cfoutput>" + "'>Rating History</a>";
					 	return link3
						}
						}

                  ])
                }),
                columns: [
                  { headerText: "Date", width: 150, ensurePxWidth: true }, { headerText: "Notes",width:500,ensurePxWidth:true }, { headerText: "User", width: 130, ensurePxWidth: true }, { headerText: "App History", width: 150, ensurePxWidth: true },{ headerText: "Rating History", width: 150, ensurePxWidth: true }
                ]
            });	
}
function checkForAlert() {
	
	 //get state tax info
	$.ajax({
		type: "GET",
		url: "/index.cfm?event=main.getRatingState",
		dataType: "json",
		data: {
			location_id: <cfoutput>#location_id#</cfoutput>
		}
	}).success(function(response) {
		$.each(response.data, function(k,v) {
			var glnotes = v.notes.trim();
			var propnotes = v.prop_notes.trim();
			<cfif rc.endorseAlert eq 1>
			var endorsenotes = "Mid-term endorsements have been processed.  Review endorsements prior to rating for renewal.";
			<cfelse>
			var endorsenotes = "";
			</cfif>
			var notesArray = new Array();
			if (glnotes != '') {
				notesArray.push('GL: ' + glnotes);
			}
			if (propnotes != '') {
				notesArray.push('Property: ' + propnotes);
			}
			if (endorsenotes != '') {
				notesArray.push(endorsenotes);
			}

			if (notesArray.length > 0) {
				var notehtml = "<ul class='notealert'>";
				for (var i = 0; i < notesArray.length; i++) {
					var notehtml = notehtml + "<li>"+notesArray[i]+"</li>";
				}			
			<cfif not isDefined("URL.summary")>wAlert(notehtml);</cfif>
			}
		});
		
					
	});		
}
function getStateTaxes() {
	
	 //get state tax info
	$.ajax({
		type: "GET",
		url: "/index.cfm?event=main.getRatingState",
		dataType: "json",
		data: {
			location_id: <cfoutput>#location_id#</cfoutput>
		}
	}).success(function(response) {
		$.each(response.data, function(k,v) {
			var brokeroverride = $("#broker_override").attr('checked');
			var baseoverride = $("#base_override").attr('checked');
			var surplustaxoverride = $("#surplustax_override").attr('checked');
			var inspectionoverride = $("#inspection_override").attr('checked');
			var filingoverride = $("#filing_override").attr('checked');
			var stampingoverride = $("#stamping_override").attr('checked');
			var statemunioverride = $("#statemuni_override").attr('checked');
			var rpgoverride = $("#rpg_override").attr('checked'); 	
			
			<cfif endorse eq 1>
			rpg = 0;
			inspectionfee = 0
			<cfelse>
			rpg = v.rpg_fee;
			inspectionfee = v.inspection_fee;
			</cfif>				
			//inspection fee
			if (inspectionoverride != 'checked') {
				$("#inspectionfee").autoNumericSet(inspectionfee).addClass('readonlyLive');
			}
			$("#inspectionfee").attr("originalval", inspectionfee);								   
			brokerrate = v.broker_policy_fee / 100;
			brokerpercent = v.broker_policy_fee;
			if (brokeroverride != 'checked') {
			$("#broker_percentoverride").autoNumericSet(brokerpercent);
			$("#broker_percent").attr('checked','checked');
			}
			surplusrate = v.tax_rate / 100;
			stampingrate = v.stamp_tax / 100;
			//filing fee
			filingfee = v.filing_fee;
			if (filingoverride != 'checked') {
				$("#filingfee").autoNumericSet(filingfee).addClass('readonlyLive');
			}
			$("#filingfee").attr("originalval", filingfee);			
			rpgfee = rpg;
			if (rpgoverride != 'checked') {
			$("#rpgfee").autoNumericSet(rpgfee);
			}
			calculation = v.calculation;
//			terrorismrate = v.terrorism_fee / 100;
			proptaxrate = v.prop_tax / 100;
			prop_min_premium = v.prop_min_premium;
			state_id = v.state_id;
			//custom taxes
			//first hide any that are showing and blank values
			$('.customtax').hide();
			//$('.customtax input').val('');
			custom_tax_1_label = v.custom_tax_1_label;
			custom_tax_1 = v.custom_tax_1;
			custom_tax_1_type = v.custom_tax_1_type;
			custom_tax_2_label = v.custom_tax_2_label;
			custom_tax_2 = v.custom_tax_2;
			custom_tax_2_type = v.custom_tax_2_type;
			custom_tax_3_label = v.custom_tax_3_label;
			custom_tax_3 = v.custom_tax_3;
			custom_tax_3_type = v.custom_tax_3_type;
			custom_tax_4_label = v.custom_tax_4_label;
			custom_tax_4 = v.custom_tax_4;
			custom_tax_4_type = v.custom_tax_4_type;
			custom_tax_5_label = v.custom_tax_5_label;
			custom_tax_5 = v.custom_tax_5;
			custom_tax_5_type = v.custom_tax_5_type;
			
			if (custom_tax_1_label !== '') {
				showHideCustomTax('.custom_tax_1_container',custom_tax_1_label,custom_tax_1,custom_tax_1_type);
			}
			if (custom_tax_2_label !== '') {
				showHideCustomTax('.custom_tax_2_container',custom_tax_2_label,custom_tax_2,custom_tax_2_type);
			}
			if (custom_tax_3_label !== '') {
			showHideCustomTax('.custom_tax_3_container',custom_tax_3_label,custom_tax_3,custom_tax_3_type);
			}
			
			if (custom_tax_4_label !== '') {
				showHideCustomTax('.custom_tax_4_container',custom_tax_4_label,custom_tax_4,custom_tax_4_type);
			}
			if (custom_tax_5_label !== '') {
				showHideCustomTax('.custom_tax_5_container',custom_tax_5_label,custom_tax_5,custom_tax_5_type);
			}												
		});
		
					
	});	
}
function showHideCustomTax(container, tlabel, tamount, ttype) {
				if (ttype == '%') {
					var thislabel = tlabel + ' ' + tamount + ttype;
				}
				else {
					var thislabel = tlabel + ' ' + ttype + tamount;
				}
				$(container).show();
				var customtaxoverride = $(container + ' .customtaxoverride').prop("checked");
				$(container + ' .customtaxlabel').text(thislabel);
				$(container + ' .custom_tax_rate').val(tamount);
				if(!customtaxoverride) {
					$(container + ' .custom_tax_label').val(tlabel);
				}
				$(container + ' .custom_tax_type').val(ttype);
}
function getPropStateTaxes() {
	
	 //get state tax info
	$.ajax({
		type: "GET",
		url: "/index.cfm?event=main.getRatingState",
		dataType: "json",
		data: {
			location_id: <cfoutput>#location_id#</cfoutput>
		}
	}).success(function(response) {
		$.each(response.data, function(k,v) {

			proptaxrate = v.prop_tax / 100;
			prop_min_premium = v.prop_min_premium;
			state_id = v.state_id;
		});
		
					
	});	
}
function getLiabilityPlan(doRatingAfter) {
	doRatingAfter = typeof doRatingAfter !== 'undefined' ? doRatingAfter : false;
	
	var id = $('#liability_plan_id').val();
	$.ajax({
    url: "/index.cfm?event=main.getGLPlans", 
	type: "get",
	cache: false,
	dataType: "json",
	data: {
	  liability_plan_id: id
  }
  , success: function (response){
	  //populate the form 
	// $(":input[type='checkbox']").prop("checked",false);
	//$(".propchecks").prop("checked",false);
	 
//populate base rates
		  $.each(response.data, function(k, v) {
			    var endorse = <cfoutput>#endorse#</cfoutput>
				if (endorse !== 1) {
				baserate = v.base_rate
				}
				else {
				baserate = 0;
				}
				var baseoverride = $('#base_override').attr('checked');
				if (baseoverride !== 'checked') {
					$('#base_rate_annual').autoNumericSet(baserate);
				}

				$('#instructors_base').autoNumericSet(v.instructor_base);
				$('#basketball_base').autoNumericSet(v.basketball_base);
				$('#rt_courts_base').autoNumericSet(v.racquetball_base);
				$('#tennis_courts_base').autoNumericSet(v.tennis_base);
				$('#sauna_base').autoNumericSet(v.sauna_base);
				$('#steamroom_base').autoNumericSet(v.steam_room_base);
				$('#whirlpool_base').autoNumericSet(v.whirlpool_base);
				$('#pools_base').autoNumericSet(v.pools_base);
				$('#poolsoutdoor_base').autoNumericSet(v.poolsoutdoor_base);
				$('#tanning_base').autoNumericSet(v.tanning_base);
				$('#spraytanning_base').autoNumericSet(v.spray_tanning_base);
				$('#beautyangels_base').autoNumericSet(v.beauty_angels_base);
				var sschecked = $('#silversneakers_override').attr('checked');
				if (sschecked != 'checked') {
					$('#silversneakers_base').autoNumericSet(v.silver_sneakers_base);
				}					
				var mchecked = $('#massage_override').attr('checked');
				if (mchecked != 'checked') {
					$('#massage_base').autoNumericSet(v.massage_base);
				}					
				var ptchecked = $('#pt_override').attr('checked');
				if (ptchecked != 'checked') {
					$('#pt_base').autoNumericSet(v.personal_trainers_base);
				}					
				$('#childsitting_base').autoNumericSet(v.child_sitting_base);
				var jjchecked = $('#junglegym_override').attr('checked');
				if (jjchecked != 'checked') {
					$('#junglegym_base').autoNumericSet(v.jungle_gym_base);
				}			
				var lschecked = $('#leasedspace_override').attr('checked');
				if (lschecked != 'checked') {
					$('#leasedspace_base').autoNumericSet(v.leased_space_base);
				}									
				var ebchecked = $('#employeebenefits_override').attr('checked');
				if (ebchecked != 'checked') {
					$('#employeebenefits_base').autoNumericSet(v.employeebenefits_base);
				}				
				$('#default_credit_label').val(v.default_credit_label);

				$('#default_credit').autoNumericSet(v.default_credit);
				
	    		$('#terrorism_minimum').val(v.terrorism_minimum);
					//terrorism_fee from gl plan
					terrorismrate = v.terrorism_fee / 100;
					
		if (doRatingAfter) { 
		getStateTaxes();
		//delay rating so everything is defined.
		setTimeout(function() { doGLRating() }, 500);
		}
		  });

}
  // this runs if an error
  , error: function (xhr, textStatus, errorThrown){
    // show error
    alert(errorThrown);
  }
	});//end ajax	
}
function getPropertyPlan(doRatingAfter) {
	doRatingAfter = typeof doRatingAfter !== 'undefined' ? doRatingAfter : false;
	property_plan_id = $('#property_plan_id').val();
	if (property_plan_id != 0) {
		$.ajax({
			type: "GET",
			url: "/index.cfm?event=main.getPropertyPlans",
			dataType: "json",
			data: {
				property_plan_id: property_plan_id
			}
		}).success(function(response) {
			
			$.each(response.data, function(k,v) {	
				var afoverride = $('#prop_agencyfeeoverride').attr('checked');
				if (afoverride != 'checked') {
					$("#prop_agencyfee").autoNumericSet(v.prop_agencyfee);
				}
				
				propterrorismrate = v.prop_terrorism / 100;
				propeqpbrkrate = v.prop_eqpbrkrate / 100;
				var equipoverride = $('#prop_equipbreakoverride').attr('checked');
				if(equipoverride !== 'checked') {
				$('#prop_equipbreakrate').autoNumericSet(v.prop_eqpbrkrate);
				}
				
				//$("#prop_terrorism").autoNumericSet(v.prop_terrorism);
				if (doRatingAfter) { 
				getPropStateTaxes();
				//delay rating so everything is defined.
				setTimeout(function() { doPropRating() }, 500);
				}				
			});
			
						
		});		
		}
	
}
function fieldOverride(field1,field2) {
	//get
}
</script>