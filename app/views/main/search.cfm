    <style type="text/css">
        .wijmo-wijgrid
        {
            position: relative;
            min-height: 120px;
        }
        .wijmo-wijgrid-overlay
        {
            z-index: 99;
        }
        .wijmo-wijgrid-loading
        {
				background: inherit;
        }
        .wijmo-wijgrid-loadingtext
        {
            position: absolute;
            opacity: 1;
            z-index: 100;
            padding: 0.4em;
            font-size: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.25);
        }
        .wijmo-wijgrid-loadingtext .ui-icon
        {
            display: inline-block;
            margin-right: 0.4em;
        }    
    </style>
<script type="text/javascript">

$(document).ready(function () {						
function log( message ) {
			$( "<div/>" ).text( message ).prependTo( "#log" );
			$( "#log" ).scrollTop( 0 );
		}	
createSearchGrid(true);			
$( "#clientsearch" ).autocomplete({
			source: function(request, response) {
    $.getJSON("/index.cfm?event=main.clientSearch", { searchby: $('input[name=searchby]:checked').val(), term: request.term }, 
              response);
  },
			minLength: 2,
			select: function( event, ui ) {
				log( ui.item ?
					"Selected: " + ui.item.value + " aka " + ui.item.id :
					"Nothing selected, input was " + this.value );
			}
		});
$('#applyoptions').click(function(e) {
			var data = $('.userso').serialize();
			e.preventDefault();
			$(".somessage").hide();
			$.ajax({
			  type: "POST",
			  cache: false,
			  url: "/index.cfm?event=main.saveUserSearch",
			  data: data

			}).success(function(resp) {
				if (resp = 'success'){
				$(".somessage").html("Changes Saved").slideDown();
				$("#applyoptions").removeClass('ui-state-focus');
				}
				else{
					alert('There was an error');
				}
		
			});
});
$('#applydefault').click(function(e) {
			e.preventDefault();
			$(".somessage").hide();
			$.ajax({
			  type: "POST",
			  cache: false,
			  url: "/index.cfm?event=main.saveDefaultSearch"

			}).success(function(resp) {
				if (resp = 'success'){
				$(".somessage").html("System Defaults Applied").slideDown();
				$("#applydefault").removeClass('ui-state-focus');
				$('.userso').removeAttr('checked');
				$('.defaultradio').attr('checked', true);
				$(":input[type='checkbox']").wijcheckbox("refresh");
				//$(":input[type='radio']").wijradio("refresh");
				}
				else{
					alert('There was an error');
				}
		
			});
});
$('#searchsub').click(function(e) {
			
			e.preventDefault();
			$("#searchgrid").wijgrid("destroy");
            $(".somessage").hide();
			createSearchGrid();
			

});
//quick pick functionality
$('#qpbutton').click(function(e) {
			
			e.preventDefault();
			var val = $('#qpfield').val();
			if (val !== '') {			
			cid = $('#row_number_' + val).attr('client_id');

				if (cid != undefined) {
					var loc = 'index.cfm?event=main.client&client_id=' + cid
					document.location.href=loc;
				}
			}

});
			

});
createSearchGrid = function(firstLoad) {	// search grid
//default param value = false
firstLoad = typeof firstLoad !== 'undefined' ? firstLoad : false;
var formvalues = $('#searchform').serialize();
if (firstLoad != true) {
	var url = '/index.cfm?event=main.getClientGrid&' + formvalues;
}
else {
	var url = '/index.cfm?event=main.getClientGrid&search_status=1';
}
			

            $("#searchgrid").wijgrid({
                allowSorting: true,
                allowPaging: false,
                //pageSize: 16,
                rowStyleFormatter: function (args) {
				   var wg = $.wijmo.wijgrid;
				 
				   if ((args.state === wg.renderState.rendering) && (args.type & wg.rowType.data)) {
				      args.$rows.dblclick(function () {
				      	var cid = args.data["CLIENTID"];
				      	var loc = 'index.cfm?event=main.client&client_id=' + cid;
				      	document.location.href=loc;
				      	
				        
				      });
				   }
				},
				columns: [
						  { headerText: "Row", width: 50, ensurePxWidth: true },
						  { headerText: "Entity Name" },
						  { headerText: "DBA" },
							{ headerText: "AMS" },
						  { headerText: "Client Code", width: 85, ensurePxWidth: true},
						  { headerText: "X Reference", width: 170, ensurePxWidth: true },
						  { headerText: "Contact", width: 170, ensurePxWidth: true },
						  { headerText: "Client ID", visible: false }
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
					 { name: "ROW", mapping: function (item) { 
					 	var link1 = "<div client_id='" + item.client_id + "' style='width:75px' id='row_number_" + item.rownumber + "'>" + item.rownumber + "</div>";
					 	return link1
						} 
						},
					 { name: "ENTITY NAME", mapping: "entity_name", },
					 { name: "DBA", mapping: "dba" },
					 { name: "AMS", mapping: "ams" },
					 { name: "CLIENT CODE", mapping: "client_code" },
					 { name: "X-REFERENCE", mapping: "x_reference" },
					 { name: "CONTACT", mapping:"cname"},
					 { name: "CLIENTID", mapping:"client_id"}
					 
                  ])
                }),

                loading: function(e) {
                  var $grid = $(e.target).closest(".wijmo-wijgrid"),
							$text = $grid
								.append("<div class=\"wijmo-wijgrid-overlay ui-widget-overlay\"></div><span class=\"wijmo-wijgrid-loadingtext ui-widget-content ui-corner-all\"><span class=\"ui-icon ui-icon-clock\"></span>Loading...</span>")
								.find("> .wijmo-wijgrid-loadingtext");
						
							$text
	           				.position({
									my: "center",
									at: "center center",
									of: $grid,
									collision: "none"
							});
                },
				loaded: function() {
				$('#qpfield').val(1);
				$('#qpbutton').focus();	
				}
            });
}
</script>
  <div id="statusbar">
  <div id="pagename">Client Search</div>
  <div id="statusstuff">  
  </div><!---End Statusstuff--->
  </div><!---End statusbar---> 
<form id="searchform" name="searchform" autocomplete="off">
<ul class="formfields fullwidth" style="margin:10px 0 10px;">
<li><label class="bold radiohoriz">Search By:</label></li>
<li><input id="sb1" type="radio" name="searchby" class="userso" <cfif rc.userSearchOptions.search_options_searchby is 'entity_name'>checked="checked"</cfif> value="entity_name"></li>
<li><label class="radiohoriz" for="sb1">Entity Name</label></li>
<li><input id="sb2" type="radio" name="searchby" class="userso" value="policy" <cfif rc.userSearchOptions.search_options_searchby is 'policy'>checked="checked"</cfif>></li>
<li><label class="radiohoriz" for="sb2">Policy #</label></li>
<li><input id="sb3" type="radio" name="searchby" class="userso" value="ams" <cfif rc.userSearchOptions.search_options_searchby is 'ams'>checked="checked"</cfif>></li>
<li><label class="radiohoriz" for="sb3">AMS</label></li>
<li><input id="sb4" type="radio" name="searchby" class="userso" value="client_code" <cfif rc.userSearchOptions.search_options_searchby is 'client_code'>checked="checked"</cfif>></li>
<li><label class="radiohoriz" for="sb4">Client Code</label></li>
<li><input id="sb5" type="radio" name="searchby" class="userso" value="more" <cfif rc.userSearchOptions.search_options_searchby is 'more'>checked="checked"</cfif>></li>
<li><label class="radiohoriz" for="sb5">More</label></li>
<li>
<select class="selectbox2" name="searchbyother" class="userso">
<option value="mailing_address" <cfif rc.userSearchOptions.search_options_other is 'mailing_address'>selected</cfif>>Mailing Address</option>
<option value="location_address" <cfif rc.userSearchOptions.search_options_other is 'location_address'>selected</cfif>>Location Address</option>
<option value="mailing_city" <cfif rc.userSearchOptions.search_options_other is 'mailing_city'>selected</cfif>>City</option>
<option value="mailing_state" <cfif rc.userSearchOptions.search_options_other is 'mailing_state'>selected</cfif>>State</option>
<option value="mailing_zip" <cfif rc.userSearchOptions.search_options_other is 'mailing_zip'>selected</cfif>>Zip</option>
<option value="business_phone" <cfif rc.userSearchOptions.search_options_other is 'business_phone'>selected</cfif>>Phone</option>
<option value="business_email" <cfif rc.userSearchOptions.search_options_other is 'business_email'>selected</cfif>>Email</option>
</select></li>
<li style="margin-left:15px;"><input type="checkbox" name="exact" id="exact" class="userso" value="1" <cfif rc.userSearchOptions.search_options_exact is 1>checked="checked"</cfif>></li><li><label for="exact">Exact Match</label></li>
<li><label class="bold radiohoriz alignright width-80">Include:</label></li>
<li><input id="i1" type="radio" class="userso" value="0" name="search_status" <cfif rc.userSearchOptions.search_options_status is 0> checked="checked"</cfif>></li>
<li><label class="radiohoriz" for="i1">All</label></li>
<li><input id="i2" type="radio" class="userso defaultradio" name="search_status" value="2"<cfif rc.userSearchOptions.search_options_status is 2> checked="checked"</cfif>></li>
<li><label class="radiohoriz" for="i2">Active</label></li>
<li><input id="i3" type="radio" class="userso" name="search_status" value="3"<cfif rc.userSearchOptions.search_options_status is 3> checked="checked"</cfif>></li>
<li><label class="radiohoriz" for="i3">Terminated</label></li>
<li><input id="i4" type="radio" class="userso" name="search_status" value="1"<cfif rc.userSearchOptions.search_options_status is 1> checked="checked"</cfif>></li>
<li><label class="radiohoriz" for="i4">Prospect</label></li>

</ul>
<div style="clear:both;"></div>
<ul class="formfields fullwidth">
<li><input type="text" id="clientsearch" name="clientsearch" class="txtleft width-200">
</li>
<li><input type="image" src="/images/searchbutton2.png" name="searchsub" id="searchsub" class="searchbutton2" /></li>
<li><label>Quick Pick</label></li>
<li><input type="text" name="qpfield" id="qpfield" class="width-30 txtleft"></li>
<li><input type="image" src="/images/quickpickbutton.png" name="qpbutton" id="qpbutton" class="searchbutton2" /></li>
</ul>
<div class="expandbar graybar">Advanced Search Options</div>
<div class="advancedsearch2">






<ul class="formfields width-302">
<li><label class="width-302 bold" style="padding-left:0;">Scope of Name Search</label></li>
<!---
<li class="checkmargin"><input type="checkbox" class="userso" name="search_en" value="1"<cfif rc.userSearchOptions.search_options_en is 1> checked="checked"</cfif>></li>

<li><label>Entity Name</label></li>--->
<li class="checkmargin"><input type="checkbox" class="userso" name="search_dba" value="1"<cfif rc.userSearchOptions.search_options_dba is 1> checked="checked"</cfif>></li>
<li><label>DBA Name</label></li>
<li class="checkmargin"><input type="checkbox" class="userso" name="search_ni" value="1"<cfif rc.userSearchOptions.search_options_ni is 1> checked="checked"</cfif>></li>
<li><label>Named Insured</label></li>
<li class="checkmargin"><input type="checkbox" class="userso" name="search_cn" value="1"<cfif rc.userSearchOptions.search_options_cn is 1> checked="checked"</cfif>></li>
<li><label>Contact Name</label></li>
<li class="checkmargin"><input type="checkbox" class="userso" name="search_xref" value="1"<cfif rc.userSearchOptions.search_options_xref is 1> checked="checked"</cfif>></li>
<li><label>X-reference</label></li>
</ul>
<ul class="formfields searchoptions" style="float:right; width:auto;">
<!---
<li class="checkmargin"><input type="checkbox" name="savedefault"></li>
<li><label>Save as default user options</label></li>
<li style="clear:both; height:10px;"></li>--->
<li class="somessage">Changes Saved</li>
<li style="clear:both;"><button class="buttons" id="applyoptions">SAVE OPTIONS</button></li>
<li><button class="buttons" id="applydefault">APPLY DEFAULT</button></li>
</ul>
</form>
<div style="clear:both"></div>
</div>

<div class="graybar">Search Results</div>
<img id="LoadingImage" src="/images/loading.gif" style="display:none;" />
            <table id="searchgrid">
            </table>

