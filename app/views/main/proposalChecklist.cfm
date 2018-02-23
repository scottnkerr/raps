<cfset datetime = "#dateFormat(now(),'mm-dd-yyyy')#">
<cfset randomid = randrange(100,10000)>
<cfset directoryname = "#listgetat(SESSION.auth.username, 1,'@')#-#datetime#-#randomid#">


<script>
$(document).ready(function() {
	$(":input[type='checkbox']").not(".plaincheck").wijcheckbox();
	$('.docchecks').each(function() {
		var ischecked = $(this).attr('checked');
		if (ischecked == 'checked') {
			var parentli = $(this).parents('li');
			parentli.show();
		}
	});
						   
	$('#sortable').sortable({
			handle: '.movebutton'
	});

	$('.docchecks').wijcheckbox("refresh");
	$('#propbutton').click(function(e){	
		e.preventDefault();
		//$('.docchecks').wijcheckbox("refresh");
		$('#proposalresult').hide();
		//$('#checklist').hide();
		//$(this).hide();
		$('.message').show();
		createProposal();
								   

	});
	$('.backbutton').click(function(e){	
		var url = '/index.cfm?event=main.client&client_id='+<cfoutput>#client_id#</cfoutput>;										
		window.location.href = url;									   
	});	
	$('#checkall').click(function(e) {
		e.preventDefault();						 
		$('.docchecks').prop('checked', true);	
		$('.docli').removeClass('ignoresort');
		$('.docchecks').wijcheckbox("refresh");
		$('.docli').fadeIn();
	});
	$('#uncheckall').click(function(e) {
		e.preventDefault();						 
		$('.docchecks').prop('checked', false);	
		$('.docli').addClass('ignoresort');
		$('.docchecks').wijcheckbox("refresh");
	});	
	$('#hideunchecked').click(function(e) {
		e.preventDefault();						 
		$('.docchecks').each(function() {
			var ischecked = $(this).attr('checked');
			if (ischecked != 'checked') {
				var parentli = $(this).parents('li');
				parentli.slideUp();
			}

		});
	});	
	$('.adddoc').click(function(e) {
		e.preventDefault();
		$('.addpropdoc').slideDown();
	});
	
	$('#canceldocbutton').click(function(e) {
		e.preventDefault();
		$('.addpropdoc').slideUp();
	});	
	$('#adddocbutton').click(function(e) {
		e.preventDefault();
		//generate unique id for new li
		randomnum = Math.floor((Math.random()*1000)+100);
		var li = '<li class="clear docli" id="section_id_'+randomnum+'"><input type="checkbox" class="docchecks" checked="checked" /><img src="/images/movebutton.png" class="movebutton" title="Click and drag to change document order" /><img src="/images/editbuttonlarge.png" class="doceditbutton" title="Click to edit" /></li>'
		$('#sortable').prepend(li);
		$('.addpropdoc').slideUp();
	});		
	$('.fileupload').click(function() {
		
		$('.addpropdoc').slideDown();
	});	
	$('#showunchecked').click(function(e) {
		e.preventDefault();						 
		$('.docli').fadeIn();
	});	
	$('.docchecks').live('change', function(){
		var ischecked = $(this).attr('checked');	
		if (ischecked == 'checked') {
			$(this).parents('li').removeClass('ignoresort');
		}
		else {
			$(this).parents('li').addClass('ignoresort');	
		}
	});	
	$('.doceditbutton').click(function() {
		//console.log('clicked');
		var nextfield = $(this).next().next();
		//console.log(nextfield);
		var nextid = nextfield.attr('id');
		//console.log(nextid);
		if (nextid != undefined) {
		nextfield.wijeditor({
							mode:'simple',
							showFooter:false,
							simpleModeCommands: ["FontName", "FontSize","Bold", "Italic", "UnderLine", "SubScript", "SuperScript", "Link", "StrikeThrough", "InsertDate", "InsertImage", "NumberedList", "BulletedList", "InsertCode","CheckBox", "JustifyLeft", "JustifyCenter", "JustifyRight", "JustifyFull", "Outdent", "Indent", "Undo", "Redo","BackColor","ForeColor" ]
							});
		}
		else {
		var hideme = $(this).next().next();
		hideme.slideToggle();
		//console.log('should close');
		}
		
	});
			$('#upload').uploadify({
				'swf'      : 'uploadify.swf',
				'uploader' : '/app/controllers/uploadify.cfc?method=uploadimage',
				'fileSizeLimit' : '5MB',
				'buttonText' : 'BROWSE...',
				'multi': true,
				'fileTypeExts' : '*.pdf',
				'onUploadSuccess' : function(file, data, response) {
					//console.log(file.name);
				var li = '<li class="clear docli" style="display:list-item;"><input type="checkbox" class="docchecks newdocchecks" checked="checked" /><div class="docname">'+file.name+'</div><input type="hidden" name="proposal_doc_name" value="'+data+'" class="propdocname" /><div class="includeheader"><input type="checkbox" name="includeheader" class="newdocchecks includeheadercheck" style="margin:0 !important"><div class="docname">Include Header</div></div><div class="includefooter"><input type="checkbox" name="includefooter" class="newdocchecks includefootercheck"><div class="docname">Include Footer</div></div><img src="/images/movebutton.png" class="movebutton" title="Click and drag to change document order" /><textarea name="proposal_doc_content" style="width:1088px; height: 475px;" class="clear editdoc txtleft"></textarea> <input type="hidden" name="proposal_doc_include" value="" class="propdocinclude" /><input type="hidden" name="proposal_doc_file" value="'+data+'" class="propdocfile" /><div style="clear:both"></div></li>'
				$('#sortable').append(li);					
            	//$('#newfile').val(data);
        		},
				'onQueueComplete' : function(queueData) {
            	$('.newdocchecks').wijcheckbox('destroy');
				$('.newdocchecks').wijcheckbox();
        } 
			});		
//if generating proposal for locations with status of 'quote'
//the id's will need to updated based on proposal_doc_id if they change in the db!
$('#quoteonly').click(function() {
	$('.quoteswap').each(function() {
    $(this).toggleClass('ignoresort').fadeToggle();
		var thischeck = $(this).find('input[type=checkbox]');
		thischeck.prop("checked", !thischeck.prop("checked"));
		$('.docchecks').wijcheckbox("refresh");	
  });
	/*
	ischecked = $('#quoteonly').attr('checked');
	if (ischecked == 'checked') {
		$('#section_id_9').removeClass('ignoresort');
		$('#doc_9').prop('checked', true);
		$('#section_id_9').fadeIn();
		$('#section_id_10').fadeOut();
		$('#section_id_10').addClass('ignoresort');
		$('#doc_10').prop('checked', false);
		$('#section_id_39').removeClass('ignoresort');
		$('#doc_39').prop('checked', true);
		$('#section_id_39').fadeIn();
		$('#section_id_40').fadeOut();
		$('#section_id_40').addClass('ignoresort');
		$('#doc_40').prop('checked', false);		
		$('.docchecks').wijcheckbox("refresh");
	}
	else {
		$('#section_id_9').addClass('ignoresort');
		$('#doc_9').prop('checked', false);
		$('#section_id_9').fadeOut();
		$('#section_id_10').fadeIn();
		$('#section_id_10').removeClass('ignoresort');
		$('#doc_10').prop('checked', true);
		$('.docchecks').wijcheckbox("refresh");		
	}
	*/
});
});
//end document.ready
  function embedPDF(url){
	//get location of pdfembed div
	var eTop = 140;
	var windowheight = $(window).height();
	var divheight = Math.round(windowheight - eTop - 40);
	//$('#pdfembed').css('height', divheight);
    var myPDF = new PDFObject({ 

      url: url,
	  width: 1088,
	  height: divheight

    }).embed('pdfembed'); 
    // Be sure your document contains an element with the ID 'pdfembed' 

  }
function createProposal() {
			var checked = $(".docchecks:checked").length;
			//console.log(checked);
			var wcchecked = $('#doc_2').prop('checked');
			var eplichecked = $('#doc_5').prop('checked');
			var uechecked = $('#doc_4').prop('checked');
			var glpropchecked = $('#doc_3').prop('checked');
			var otherchecked = $('#doc_48').prop('checked');
			var otherchecked2 = $('#doc_49').prop('checked');
			var otherchecked3 = $('#doc_50').prop('checked');
			
		if (checked >= 1) {
		//remove li's that are not selected so they are not sorted/passed	
		//$('.ignoresort').remove();	
		var sortorder = $('#sortable').sortable('serialize');
		//console.log(sortorder);
		
		$('#sort_serialized').val(sortorder);
		
		counter = 0;
		var numItems = $('.docli').not('.ignoresort').length
		$('.docli').not('.ignoresort').each(function() {
		counter = counter + 1;						  
		var thisid = $(this).attr('id');
		var thisname = $(this).find('.propdocname').val();
		var thisheaderoverride = $(this).find('.headeroverride').val();
		var grayfooter = $(this).find('.grayfooter').val();
		var thiscontent = formatContent(this);
		var thisinclude = $(this).find('.propdocinclude').val();
		var thisfile = $(this).find('.propdocfile').val();
		var ischecked = $(this).find('.includeheadercheck').attr('checked');
		if (ischecked == 'checked') {
		includeheader = 1;	
		}
		else {
		includeheader = 0;	
		}
		var ischecked = $(this).find('.includefootercheck').attr('checked');
		if (ischecked == 'checked') {
		includefooter = 1;	
		}
		else {
		includefooter = 0;	
		}				
		if (counter < numItems) {
			lastone = false;
		}
		else {
			lastone = true;
		}

		var quotechecked = $('#quoteonly').attr('checked');
		if (quotechecked == 'checked') {
			onlyquote = 1;
		}
		else {
			onlyquote = 0;	
		}
		$.ajax({
            url: '/index.cfm?event=main.proposalCreate2',
            type: "post",
			//set async to false to false to force the loop to wait for the ajax response before continuing
			async:false,
            data: { thisid : thisid,
					thisname : thisname,
					thiscontent : thiscontent,
					thisinclude : thisinclude,
					thisfile : thisfile,
					directoryname: <cfoutput>'#directoryname#'</cfoutput>,
					pagenumber: counter,
					lastone: lastone,
					includeheader: includeheader,
					includefooter: includefooter,
					client_id: <cfoutput>#rc.client.client_id#</cfoutput>,
					onlyquote: onlyquote,
					wcchecked: wcchecked,
					eplichecked: eplichecked,
					uechecked: uechecked,
					glpropchecked: glpropchecked,
					otherchecked: otherchecked,
					otherchecked2: otherchecked2,
					otherchecked3: otherchecked3,
				    header_image_override: thisheaderoverride,
				    gray_footer: grayfooter
			},
            dataType: 'json',
            success: function(data){
			
			  var checkresult = data.indexOf("Fitness");
			  if (checkresult == 0) {
				 var filelink = 'Proposal Complete: <a href="/proposals/'+data+'" target="_blank">'+data+'</a>'; 
				 var embedlink = '/proposals/'+data;
              $('#proposalresult').html(filelink).slideDown();
			  //embedPDF(embedlink);
			  
			  $('.message').hide();
			  }

            },
			error: function(jqXHR, textStatus, errorThrown) {
			alert(errorThrown);	
			}
          });	
		});		
		/*
		$(sortorder.split("&")).each(function () {
		//strip out non numeric 									   
		var thisid = this.replace(/[^0-9]/g, ''); 

		});*/

		}								   
		else {			
			alert('please select something');
		}
}
function formatContent(elem) {
	var content = '<div style="font-size:12px; font-family:Arial; padding:0; margin:0; line-height:16px;">' + $(elem).find('.editdoc').val();
	var haslist = $(elem).hasClass('haslist');
	if (haslist == true) {
		var content = content + '<table style="margin:0;">';
		var thislist = $(elem).find('.listpropdoc li');	
		$(thislist).each(function() {
			var ischecked = $(this).find('input[type=checkbox]').prop('checked');
			if (ischecked == true) {
				var thisval = $(this).find('input[name=listtext]').val();
				//console.log(thisval);
				if (thisval == "blank") {
					var firstcol = "&nbsp;";
					var thisval = "&nbsp;";
				}
				else {
					var firstcol = "____";
				}
				content = content + '<tr><td style="vertical-align:top;font-family:Arial; font-size:12px;">'+firstcol+'</td><td style="font-family:Arial; font-size:12px;">' + thisval + '</td></tr>'; 
			}
		});
		content = content + '</table>';
	}

		content = content  + '</div>';

	return content;
}
</script>
<style type="text/css">
    .uploadify-button {

        border: none;

    }

</style> 
<div id="statusbar">
  <div id="pagename">Proposal Checklist</div>
  <div id="statusstuff"> </div>
  <!---End Statusstuff--->
</div>
<cfset fullpath = "c:\domains\raps\proposals">
<!---
<cfdirectory action="list" directory="#fullpath#" name="filelist" filter="*.pdf">
<cfloop query="filelist">
<cfpdf action="getInfo" source="#fullpath#\#filelist.name#" name="PDFInfo">
<cfoutput>#PDFInfo.TotalPages#</cfoutput><br />
</cfloop>--->

<!---End statusbar--->

<div id="checklist">
<form id="newfieldform" method="post" autocomplete="off">
<ul id="proposaloptions">
<!---<li style="padding:0 5px 0 0" class="adddoc"><img src="/images/plus.png" class="plus"></li>
<li><a href="#" class="adddoc">ADD DOCUMENT</a></li>--->
<li><a id="checkall" href="#">CHECK ALL</a></li>
<li><a id="uncheckall" href="#">UNCHECK ALL</a></li>
<li><a id="hideunchecked" href="#">HIDE UNCHECKED</a></li>
<li><a id="showunchecked" href="#">SHOW ALL</a></li>
<li style="float:right; border:0px solid"><label>Propose quote locations only</label></li>
<li style="float:right; margin:-1px 0 0 0; padding:0 3px; border:0px solid; width:20px" class="quoteonlyli"><input id="quoteonly" type="checkbox" name="quoteonly" class="plaincheck" value="1" /></li>
</ul>

<ul class="formfields txtleft addpropdoc fullwidth">
<li class="clear"><label>Choose Document</label></li>
<li><input id="doclibrary" name="addtype" type="radio" checked="checked" /></li>
<li><select name="document_id" class="selectbox2"><cfoutput query="rc.docs"><option value="#rc.docs.document_id#">#rc.docs.document_name#</option></cfoutput></select></li>
<li><input id="fileupload" name="addtype" type="radio" /></li>
<li><label>Upload File</label></li>
<li><input id="texteditor" name="addtype" type="radio" /></li>
<li><label>Text Editor</label></li>
<li class="clear" style="padding-top:5px"><button name="adddocbutton" id="adddocbutton" class="buttons">ADD</button></li>
<li style="padding-top:5px"><button name="canceldocbutton" id="canceldocbutton" class="buttons">CANCEL</button></li>
<!---
<li class="clear fileuploadli"><label>SELECT FILE</label></li>
<li class="fileuploadli"><input type="file" name="upload" id="upload" /></li>
<li class="clear editorli"><textarea name="newtext" id="newtext" style="width:1088px; height: 475px;"></textarea></li>--->
</ul>

</form>

   <!--- <input id="newfile" name="newfile" type="text" />--->
  <form id="proposalform" method="post" action="/index.cfm?event=main.proposalCreate" autocomplete="off">
  
<input type="hidden" name="sort_serialized" id="sort_serialized" value="" />
<ul id="sortable" class="doclist txtleft" style="margin:10px 0 10px; min-height:20px;">
<cfoutput query="rc.proposaldocs">
<li class="clear docli<cfif rc.proposaldocs.defaultcheck neq 1> ignoresort</cfif><cfif rc.proposaldocs.includes_list eq 1> haslist</cfif><cfif rc.proposaldocs.quote_swap eq 1> quoteswap</cfif>" id="section_id_#rc.proposaldocs.proposal_doc_id#"><input type="checkbox" id="doc_#rc.proposaldocs.proposal_doc_id#" name="doc_#rc.proposaldocs.proposal_doc_id#" class="docchecks"<cfif rc.proposaldocs.defaultcheck is 1> checked="checked"</cfif> /><div class="docname">#rc.proposaldocs.proposal_doc_name#</div><input type="checkbox" checked="checked" name="includeheader" class="plaincheck hidecheck includeheadercheck" /><input type="checkbox" name="includefooter"<cfif rc.proposaldocs.proposal_doc_id neq 6> checked="checked"</cfif> class="plaincheck hidecheck includefootercheck">
<input type="hidden" name="proposal_doc_name" value="#rc.proposaldocs.proposal_doc_name#" class="propdocname" />
<input type="hidden" name="header_image_override" value="#rc.proposaldocs.header_image_override#" class="headeroverride" />	  
<input type="hidden" name="gray_footer" value="#val(rc.proposaldocs.gray_footer)#" class="grayfooter" />	
<img src="/images/movebutton.png" class="movebutton" title="Click and drag to change document order" />
<cfif rc.proposaldocs.editable is 1 OR rc.proposaldocs.includes_list eq 1><img src="/images/editbuttonlarge.png" class="doceditbutton" title="Click to edit" /></cfif>
<!---replace shortcodes with real data--->
<cfinclude template="/app/views/common/shortcodes.cfm">
<cfif rc.proposaldocs.includes_list eq 1>
<!--- deal with lists --->
<!--- First, replace brackets with < and > so it doesn't cause problems with regex --->
<cfset content = replacenocase(content, "[list]","<list>","ALL")>
<cfset content = replacenocase(content, "[/list]","</list>","ALL")>
<!--- find content between <list> and </list>--->
<cfset list = Rematch('<list[^>]*>(?:[^<]+|<(?!/list>))+',content)>
<!--- if a match was found, strip out list tag and get rest of content--->
<cfif arrayIsDefined(list,1)>
<cfset liststring = list[1]>
<!---remove the list from the content area because we need to display differently --->
<cfset content = replacenocase(content, liststring,"","ALL")>
<cfset content = replacenocase(content, "</list>","","ALL")>
<cfset liststring = replacenocase(liststring, "<list>","","ALL")>
<cfset checklistarray = listtoarray(liststring, "~")>

	<cfif arraylen(checklistarray)>
  <ul class="listpropdoc">
    <cfloop from="1" to="#arraylen(checklistarray)#" index="i">
    <cfif len(trim(checklistarray[i])) and find("[blank]",checklistarray[i]) eq 0 and find("[space]",checklistarray[i]) eq 0 and trim(checklistarray[i]) neq "<br>">
    <li><input type="checkbox" name="checklistitem" id="checklistitem#rc.proposaldocs.currentrow##i#" value="#checklistarray[i]#" class="plaincheck" checked> <label for="checklistitem#rc.proposaldocs.currentrow##i#" style="float:left;">#checklistarray[i]#</label><input type="hidden" name="listtext" value="#checklistarray[i]#"></li>
    <cfelseif find("[blank]",checklistarray[i]) gt 0>
    <li><input type="checkbox" name="checklistitem" id="checklistitem#rc.proposaldocs.currentrow##i#" value="#checklistarray[i]#" class="plaincheck"> <input type="text" name="listtext" style="width:1030px;"></li>    
    <cfelse>
    <li style="visibility:hidden;"><input type="checkbox" name="checklistitem" id="checklistitem#rc.proposaldocs.currentrow##i#" value="#checklistarray[i]#" class="plaincheck" checked> <label for="checklistitem#rc.proposaldocs.currentrow##i#" style="float:left;">&nbsp;</label><input type="hidden" name="listtext" value="blank"></li>    
    </cfif>
    </cfloop>
    </ul>
  </cfif>
  </cfif>
</cfif>

<textarea id="textarea_#rc.proposaldocs.proposal_doc_id#" name="proposal_doc_content" style="width:1088px; height: 475px;" class="clear editdoc txtleft" proposal_doc_id="#rc.proposaldocs.proposal_doc_id#">
#content#
</textarea> 
<input type="hidden" name="proposal_doc_include" value="#rc.proposaldocs.proposal_doc_include#" class="propdocinclude" />
<input type="hidden" name="proposal_doc_file" value="#rc.proposaldocs.proposal_doc_file#" class="propdocfile" />
<div class="clear"></div>
</li>
</cfoutput>

 </ul> 
	<form id="fileform" autocomplete="off">
		<div id="queue"></div>
		<input id="upload" name="upload" type="file" multiple>
	</form>

</form>

</div>
<div class="proposalbuttons"><button class="buttons" id="propbutton">CREATE PROPOSAL</button>
<button class="buttons backbutton">BACK</button>
</div>
<div class="msgcontainer">
<div class="message">Please Wait...</div>
</div>
<div id="proposalresult"></div>
<div id="pdfembed"></div>
