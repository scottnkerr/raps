//variables for save prompt
isDirty = false;
var msg = 'You have unsaved changes.';
var popUp;

$(document).ready(function () {
		$.ajaxSetup ({ 
			// Disable caching of AJAX responses because IE sucks donkey dick 
			cache: false 
		});	
	
$('.phonenumber').inputmask({"mask": "(999) 999-9999"});							
//save prompt if changes are made
/*
    $(':input').not('.exclude').change(function(){
        if(!isDirty){
            isDirty = true;
        }
    });
    
    window.onbeforeunload = function(){
		
        if(isDirty){
            return msg;
        }
    };	*/
 //session timout warning 
//get url query string parameters
var querystring = location.search.replace( '?', '' ).split( '&' );
// declare object
var queryObj = {};
// loop through each name-value pair and populate object
for ( var i=0; i<querystring.length; i++ ) {
      // get name and value
      var name = querystring[i].split('=')[0];
      var value = querystring[i].split('=')[1];
      // populate object
      queryObj[name] = value;
}

//don't run session counter if on the login page.
if ( queryObj[ "event" ] != "login" ) {

//ping session every 65 minutes to see if it's still alive
var checkInterval = 185*60*1000; //185 minutes
setTimeout('pingSession()', checkInterval);
}
$('input').not('.exclude').bind('focus', function() {
pingSession();												
});

$('#logoutbutton').click(function(e) {
	e.preventDefault();
	var url = $(this).attr("href");
	closeIt();
	window.location.href = url;
								  
});

//input mask for dollars		
$('.dollarmask').autoNumeric({aSign: '$',vMin: '-100000.00',mDec: 0});
$('.dollarmaskdec').autoNumeric({aSign: '$',vMin: '-100000.00',mDec: 2});
$('.dollarmasknd').autoNumeric({aSign: '$',vMin: '-100000.00'});
//input mask for integers
$('.numbermask').autoNumeric({aSep: '',mDec: 0});
$('.numberdecmask').autoNumeric({aSep: '',mDec: 3});
$('.percentmask').autoNumeric({aSign: '%',aSep:'',pSign:'s',vMin: '-100', vMax:500});
$('.percentmask2').autoNumeric({aSign: '%',aSep:'',mDec: 0,pSign:'s',vMin:0, vMax:500});
$('.percentdecmask').autoNumeric({aSign: '%',aSep:'',mDec: 4,pSign:'s',vMin:0, vMax:500});
			//initiate menu
			$("#mainmenu").wijmenu({showDelay: 0});
			//advanced search box
			$('.togglesearch').click(function() {
				$('#advancedsearch').slideToggle('fast');							  
											  });
			$('.expandbar').click(function() {
				$('.advancedsearch2').slideToggle('fast');							  
											  });			
			//fade in tabs
			$("#container").fadeIn('slow');
			//decorate form elements
			$(".selectbox").wijdropdown();
			//decorate all text inputs except 'rounded' class (searchbox)
			$(":input[type='text'],:input[type='password'],textarea").not(".rounded,.phonenumber").wijtextbox();
			//non-wijmo input mask for dates
			$('.datebox').inputmask("mm/dd/yyyy");
			//$(":input[type='checkbox']").not(".plaincheck").wijcheckbox();
			/*
            $("#historygridOLD").wijgrid({
                allowSorting: true,
                allowPaging: true,
                pageSize: 16,
                data: [
                    ['02/21/12', 'Lorem Ipsem', 'Some test info'],
					['02/21/12', 'Sed ut perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Ut perspiciatis unde omnis', 'Some test info'],
                    ['02/21/12', 'Lorem Ipsem', 'Some test info'],
					['02/21/12', 'Sed ut perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Ut perspiciatis unde omnis', 'Some test info'],	
                    ['02/21/12', 'Lorem Ipsem', 'Some test info'],
					['02/21/12', 'Sed ut perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Ut perspiciatis unde omnis', 'Some test info'],
                    ['02/21/12', 'Lorem Ipsem', 'Some test info'],
					['02/21/12', 'Sed ut perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Ut perspiciatis unde omnis', 'Some test info'],
                    ['02/21/12', 'Lorem Ipsem', 'Some test info'],
					['02/21/12', 'Sed ut perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Ut perspiciatis unde omnis', 'Some test info'],
                    ['02/21/12', 'Lorem Ipsem', 'Some test info'],
					['02/21/12', 'Sed ut perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Ut perspiciatis unde omnis', 'Some test info'],	
                    ['02/21/12', 'Lorem Ipsem', 'Some test info'],
					['02/21/12', 'Sed ut perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Ut perspiciatis unde omnis', 'Some test info'],
                    ['02/21/12', 'Lorem Ipsem', 'Some test info'],
					['02/21/12', 'Sed ut perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Ut perspiciatis unde omnis', 'Some test info'],
                    ['02/21/12', 'Lorem Ipsem', 'Some test info'],
					['02/21/12', 'Sed ut perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Ut perspiciatis unde omnis', 'Some test info'],
                    ['02/21/12', 'Lorem Ipsem', 'Some test info'],
					['02/21/12', 'Sed ut perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Ut perspiciatis unde omnis', 'Some test info'],	
                    ['02/21/12', 'Lorem Ipsem', 'Some test info'],
					['02/21/12', 'Sed ut perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Ut perspiciatis unde omnis', 'Some test info'],
                    ['02/21/12', 'Lorem Ipsem', 'Some test info'],
					['02/21/12', 'Sed ut perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Ut perspiciatis unde omnis', 'Some test info'],
                    ['02/21/12', 'Lorem Ipsem', 'Some test info'],
					['02/21/12', 'Sed ut perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Ut perspiciatis unde omnis', 'Some test info'],
                    ['02/21/12', 'Lorem Ipsem', 'Some test info'],
					['02/21/12', 'Sed ut perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Ut perspiciatis unde omnis', 'Some test info'],	
                    ['02/21/12', 'Lorem Ipsem', 'Some test info'],
					['02/21/12', 'Sed ut perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Ut perspiciatis unde omnis', 'Some test info'],
                    ['02/21/12', 'Lorem Ipsem', 'Some test info'],
					['02/21/12', 'Sed ut perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Ut perspiciatis unde omnis', 'Some test info'],
                    ['02/21/12', 'Lorem Ipsem', 'Some test info'],
					['02/21/12', 'Sed ut perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Ut perspiciatis unde omnis', 'Some test info'],
                    ['02/21/12', 'Lorem Ipsem', 'Some test info'],
					['02/21/12', 'Sed ut perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Ut perspiciatis unde omnis', 'Some test info'],	
                    ['02/21/12', 'Lorem Ipsem', 'Some test info'],
					['02/21/12', 'Sed ut perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Ut perspiciatis unde omnis', 'Some test info'],
                    ['02/21/12', 'Lorem Ipsem', 'Some test info'],
					['02/21/12', 'Sed ut perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Ut perspiciatis unde omnis', 'Some test info'],
                    ['02/21/12', 'Lorem Ipsem', 'Some test info'],
					['02/21/12', 'Sed ut perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Ut perspiciatis unde omnis', 'Some test info'],
                    ['02/21/12', 'Lorem Ipsem', 'Some test info'],
					['02/21/12', 'Sed ut perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Ut perspiciatis unde omnis', 'Some test info'],	
                    ['02/21/12', 'Lorem Ipsem', 'Some test info'],
					['02/21/12', 'Sed ut perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Ut perspiciatis unde omnis', 'Some test info'],
                    ['02/21/12', 'Lorem Ipsem', 'Some test info'],
					['02/21/12', 'Sed ut perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Perspiciatis unde omnis iste natus', 'Some test info'],
					['02/21/12', 'Ut perspiciatis unde omnis', 'Some test info'],						
					['02/21/12', 'Lorem Ipsem', 'Some test info']

                ],
                columns: [
                    { headerText: "Date", width: 80, ensurePxWidth: true }, { headerText: "Notes" }, { headerText: "User", width: 130, ensurePxWidth: true }
                ]
            });	
             */
			$('.showhidden').live('click', function(e) {
					e.preventDefault();
					$('.hidden').slideToggle();
												  });
		

					
			//initiate tabs
			$("#tabs").wijtabs();
			//manual rating modal window
			$("#dialog-modal").wijdialog({
                autoOpen: false,
                height: 220,
                width: 400,
                modal: true,
				captionButtons: {
                pin: { visible: false },
                refresh: { visible: false },
                toggle: { visible: false },
                minimize: { visible: false },
                maximize: { visible: false }
				}
            });
			//decorate buttons
			$(".buttons").button();
			//decorate radio buttons
			//$(":input[type='radio']").wijradio();		
//			dateBoxes();
		



			  $(".txtdefault").formDefaults();

//autonumeric plugin overrides readonly attribute, so do this for auto totals	
//set the tabIndex to -1 so it will be skipped.
$('.readonly').attr("tabIndex","-1");
$('.readonly').focus(function() {
	$(this).blur();					  
});
$('.readonlyLive').live('focus',function() {
	$(this).removeClass('ui-state-focus').blur();					  
});
$('.readonlyLive').live('click',function() {
	$(this).removeClass('ui-state-focus').blur();					  
});
$('.disablesomething').click(function() {
	
	var disablefield = $(this).attr('disablefield');
	console.log(disablefield);
	var ischecked = $(this).attr('checked');
	if (ischecked == 'checked') {
		$('#'+disablefield).val("").attr("disabled", "disabled");
	}
	else {
		$('#'+disablefield).removeAttr("disabled aria-disabled").removeClass('wijmo-wijtextbox-disabled ui-state-disabled');
	}
});
//$('.newWindow').click(function (event){
// 					var height = $(window).height();
//					
//                    var url = $(this).attr("href");
//                    var windowName = "popUp";//$(this).attr("name");
//                    var windowSize = "width=910,scrollbars=yes,toolbar=no,height=" + height
// 
//                    popUp = window.open(url, windowName, windowSize);
// 
//                    event.preventDefault();
// 
//});
			//remove ui focus state when clicking out of newly created fields
			$('.newli .wijmo-wijtextbox').live('blur', function () {
			$(this).removeClass("ui-state-focus")
			});			
			$('.newli .wijmo-wijtextbox').live('focus', function () {
			$(this).addClass("ui-state-focus")
			});	
        });
saveAlert = function() {
$(".message").html("Changes Saved").fadeIn().delay(1500).fadeOut();
$(".buttons").removeClass("ui-state-focus");	
}	
pingSession = function() {
	$.ajax({
		type: "GET",
		url: "/index.cfm?event=main.getSession",
		dataType: "json",
		timeout: 5000,
		error: function(XMLHttpRequest, textStatus, errorThrown) {
			closeIt();
            //window.location.href = '/index.cfm?event=login';
        }
	});		
}	
function closeIt() {
    if (popUp != null) {
        popUp.close();
    }
}
function sessionWarning() {
    alert('Your session is about to expire due to inactivity.');    
}
function sessionRedirect() {
	var url = '/index.cfm?event=login.logout';
	closeIt();
    window.location.href = url;    
}
getFilter = function() {
	var filter = $('input[name=filterradio]:checked').val();
	return filter;
}
function wAlert(html) {
	$('#windowmsg').html(html);
	//console.log(html);
	$('#dialog-modal2').wijdialog({
        autoOpen: true,
        //height: 180,
        width: 400,
        modal: true,
        buttons: {
            "Close": function () {
                 $(this).wijdialog("close");
                    },
                },		
		captionButtons: {
        pin: { visible: false },
        refresh: { visible: false },
        toggle: { visible: false },
        minimize: { visible: false },
        maximize: { visible: false }
				}
     });
}
//function dateBoxes() {
//	//set up datepickers
//	$(".datebox").wijinputdate({
//		nullText: "",
//		showNullText: true,
//		showTrigger:true
//		});	
//}
//function destroyDateBoxes() {
//	//set up datepickers
//	$(".datebox").wijinputdate("destroy");	
//}
//function refreshDateBoxes() {
//	destroyDateBoxes();
//	dateBoxes();	
//}
//function blankDate(elem)
//{
// 
//    $(elem).wijinputdate("setText", null);
//    $(elem).wijinputdate({date:null});
//}
  function checkDate(date)
  {
    // regular expression to match required date format 
    re = /^\d{1,2}\/\d{1,2}\/\d{4}$/;
		result = "valid";

    if(date != '' && !date.match(re)) {
      result = "invalid";
    }

    return result;
  }