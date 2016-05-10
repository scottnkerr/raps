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
createSearchGrid();			
$( "#clientsearch" ).autocomplete({
			source: "/index.cfm?event=main.clientSearch",
			minLength: 2,
			select: function( event, ui ) {
				log( ui.item ?
					"Selected: " + ui.item.value + " aka " + ui.item.id :
					"Nothing selected, input was " + this.value );
			}
		});


$('#searchsub').click(function(e) {
			
			e.preventDefault();
			$("#searchgrid").wijgrid("destroy");
            $(".somessage").hide();
			createSearchGrid();
			

});
//quick pick functionality
$('#qpbutton').click(function(e) {
			var reporturl = '<cfoutput>#reporturl#</cfoutput>';
			e.preventDefault();
			var val = $('#qpfield').val();
			if (val !== '') {			
			cid = $('#row_number_' + val).attr('client_id');

				if (cid != undefined) {
					var loc = reporturl + cid
					document.location.href=loc;
				}
			}

});
			

});
createSearchGrid = function() {	// search grid
			var reporturl = '<cfoutput>#reporturl#</cfoutput>';
			var formvalues = $('#searchform').serialize();
			var url = '/index.cfm?event=main.getClientGrid&' + formvalues;
            $("#searchgrid").wijgrid({
                allowSorting: true,
                allowPaging: true,
                pageSize: 16,
                rowStyleFormatter: function (args) {
				   var wg = $.wijmo.wijgrid;
				 
				   if ((args.state === wg.renderState.rendering) && (args.type & wg.rowType.data)) {
				      args.$rows.dblclick(function () {
				      	var cid = args.data["CLIENTID"];
				      	var loc = reporturl + cid;
				      	document.location.href=loc;
				      	
				        
				      });
				   }
				},
				columns: [
						  { headerText: "Row", width: 50, ensurePxWidth: true },
						  { headerText: "Entity Name" },
						  { headerText: "DBA" },
						  { headerText: "Client Code", width: 100, ensurePxWidth: true},
						  { headerText: "X Reference", width: 100, ensurePxWidth: true },
						  { headerText: "Contact", width: 180, ensurePxWidth: true },
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
                }
            });
}
</script>
<form id="searchform" name="searchform" autocomplete="off">
<ul class="formfields fullwidth" style="margin:10px 0 10px;">
<li><label class="bold radiohoriz">Search By:</label></li>
<li><input type="radio" name="searchby" checked="checked" value="entity_name"></li>
<li><label class="radiohoriz">Entity Name</label></li>
<li><input type="radio" name="searchby" value="ams"></li>
<li><label class="radiohoriz">AMS</label></li>
<li><input type="radio" name="searchby" value="client_code"></li>
<li><label class="radiohoriz">Client Code</label></li>

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



<div class="graybar">Search Results</div>
<img id="LoadingImage" src="/images/loading.gif" style="display:none;" />
            <table id="searchgrid">
            </table>

