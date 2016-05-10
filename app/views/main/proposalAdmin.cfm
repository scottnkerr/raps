<script>
$(document).ready(function() {
$('#proposal_doc_content').wijeditor({
							mode:'simple',
							showFooter:false,
							simpleModeCommands: ["FontName", "FontSize","Bold", "Italic", "UnderLine", "SubScript", "SuperScript", "Link", "StrikeThrough", "InsertDate", "InsertImage", "NumberedList", "BulletedList", "InsertCode","CheckBox", "JustifyLeft", "JustifyCenter", "JustifyRight", "JustifyFull", "Outdent", "Indent", "Undo", "Redo" ]});
//$("#proposal_doc_content").wijeditor("setText", "");
populateSelect();
$('#proposal_doc_id').change(function() {
		var id = $(this).val();	
		$(":input[type='checkbox']").prop("checked",false);
		$(":input[type='checkbox']").wijcheckbox("refresh");
	if (id == 0) {
	    $('#limitsform')[0].reset();
		$('#proposal_doc_id').val(0);
		$("#proposal_doc_content").wijeditor("setText", " ");
		
	}
	else {
		
	$.ajax({
		type: "GET",
		url: "/index.cfm?event=main.getProposalDocs",
		dataType: "json",
		data: {
			proposal_doc_id: id
		}
	}).success(function(response) {
		
		$.each(response.data, function(k,v) {	
			if (v.disabled == 1) {
			$('#disabled').prop("checked", true);
			}
			if (v.includes_list == 1) {
			$('#includes_list').prop("checked", true);
			}			
			if (v.editable == 1) {
			$('#editable').prop("checked", true);
			}			
			if (v.defaultcheck == 1) {
			$('#defaultcheck').prop("checked", true);
			}			
			$('#proposal_doc_name').val(v.proposal_doc_name);
			$('#proposal_doc_include').val(v.proposal_doc_include);
			var content = v.proposal_doc_content;
			if (content == "") {
			$("#proposal_doc_content").wijeditor("setText", " ");	
			}
			else {
			//$("#proposal_doc_content").val(content);
			$("#proposal_doc_content").wijeditor("setText", content);
			}
		});
		
					 
					
	});	
	
	}
	
 });
//end proposal_doc_id change

	var validator = $("#limitsform").validate({
		rules: {
			proposal_doc_name: {
				required: true
				}

		},
		messages: {
			proposal_doc_name: {
				required: "*"
			}			
		},

		submitHandler: function() {
		//can't serialize form because the wijeditor text doesn't always get passed. set variables manually
        var proposal_doc_id = $('#proposal_doc_id').val();
        var proposal_doc_name = $('#proposal_doc_name').val();
        var proposal_doc_content = $("#proposal_doc_content").wijeditor("getText");
		var ischecked = $('#editable').attr('checked');
		if (ischecked == 'checked') {		
        	editable=1
		}
		else {
			editable=0
		}
		var ischecked = $('#defaultcheck').attr('checked');
		if (ischecked == 'checked') {		
        	defaultcheck=1
		}
		else {
			defaultcheck=0
		}
		var ischecked = $('#disabled').attr('checked');
		if (ischecked == 'checked') {		
        	disabled=1
		}
		else {
			disabled=0
		}		
		var ischecked = $('#includes_list').attr('checked');
		if (ischecked == 'checked') {		
        	includeslist=1
		}
		else {
			includeslist=0
		}			
 //       defaultcheck=
 //       disabled=
			
			$.ajax({
			  type: "POST",
			  cache: false,
			  url: "/index.cfm?event=main.saveProposalDocs",
			  data: {
				  proposal_doc_id:proposal_doc_id,
				  proposal_doc_name:proposal_doc_name,
				  proposal_doc_content:proposal_doc_content,
				  editable:editable,
				  defaultcheck:defaultcheck,
				  disabled:disabled,
					includes_list:includeslist
			  }

			}).success(function(resp) {
				if (resp = 'success'){
				$("#proposal_doc_content").wijeditor("setText", " ");
				 populateSelect();
				 saveAlert();
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
$('#deletePD').click(function(e) {
	e.preventDefault();	
	var proposal_doc_id = $('#proposal_doc_id').val();
	if (proposal_doc_id != 0) {
	$("#dialog-confirm").wijdialog({
                autoOpen: true,
                resizable: false,
                height: 180,
                width: 400,
                modal: true,
                buttons: {
                    "Delete Document": function () {
                        $(this).wijdialog("close");
													$.ajax({
													type: "POST",
													cache: false,
													url: "/index.cfm?event=main.deletePD",
													data: {
														proposal_doc_id:proposal_doc_id
													}
									
												}).success(function(resp) {
													location.reload();
												});			

                    },
                    Cancel: function () {
                        $(this).wijdialog("close");
                    }
                }

            });				

	}
});
<!---	$('#preview').click(function(e) {
	thisid = $('#proposal_doc_id').val();
	thisname = $('#proposal_doc_name').val();
	thiscontent = $("#proposal_doc_content").wijeditor("getText");
	console.log(thiscontent);
	thisinclude = $('#proposal_doc_include').val();
	e.preventDefault();

		$.ajax({
            url: '/index.cfm?event=main.proposalCreate2',
            type: "post",
			//set async to false to false to force the loop to wait for the ajax response before continuing
			async:false,
            data: { thisid : thisid,
					thisname : thisname,
					thiscontent : thiscontent,
					thisinclude : thisinclude,
					directoryname: 'previews',
					pagenumber: 1,
					lastone: 1,
					includeheader: 1,
					includefooter: 1,
					client_id: 1,
					onlyquote: 1,
					preview: 1
			},
            dataType: 'json',
            success: function(data){
			
			  var checkresult = data.indexOf("Fitness");
			  if (checkresult == 0) {
				 var filelink = 'Proposal Complete: <a href="/proposals/'+data+'" target="_blank">'+data+'</a>'; 
				 var embedlink = '/proposals/'+data;
              $('#proposalresult').html(filelink).slideDown();
			  embedPDF(embedlink);
			  
			  $('.message').hide();
			  }

            },
			error: function(jqXHR, textStatus, errorThrown) {
			alert(errorThrown);	
			}
          });	
		
		});	--->
	$('#showCode').click(function(e) {
		e.preventDefault();
		var content = $("#proposal_doc_content").wijeditor("getText");
		$('#content_code').val(content).slideDown();
	});
});
//end document.ready

populateSelect = function() {
var currentselect = $('#proposal_doc_id').val();
$('#limitsform')[0].reset();
$(":input[type='checkbox']").wijcheckbox("refresh");
$('#proposal_doc_id').find('option').remove().end().append('<option value="0">Add new</option>').val(0);

$.ajax({
	type: "GET",
	url: "/index.cfm?event=main.getProposalDocs",
	dataType: "json"
}).success(function(response) {
	var html = '';
    $.each(response.data, function(k,v) {
		if (v.proposal_doc_id != undefined)
		{
        html += '<option value="' + v.proposal_doc_id + '">' + v.proposal_doc_name + '</option>';
		}
	});
	$('#proposal_doc_id').append(html);			 
	$('#proposal_doc_id').val(currentselect).trigger('change');		
});
	
}
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


</script>
<style>
#content_code {
	display:none;
}
</style>
<div id="statusbar">
  <div id="pagename">Proposal Document Administration</div>
  <div id="statusstuff"> </div>
  <!---End Statusstuff--->
</div>
<!---End statusbar--->

<div class="msgcontainer">
<div class="message"></div>
</div>
  <form id="limitsform" method="post" autocomplete="off">
<ul class="formfields txtleft fullwidth" style="margin:10px 0 10px;">
<li class="clear"><label class="width-120">Select</label></li>
<li><select name="proposal_doc_id" id="proposal_doc_id" class="selectbox2 docform" style="width:158px;">
  </select>
  <input type="hidden" name="proposal_doc_include" id="proposal_doc_include" />
  </li>

 <li class="clear"><label class="width-120">Name</label></li>
 <li><input type="text" name="proposal_doc_name" id="proposal_doc_name" class="width-150 docform" /></li>
 <li style="padding-left:10px;"><input type="checkbox" name="editable" id="editable" value="1" class="docform" /></li>
 <li><label>User Editable</label></li>
  <li style="padding-left:10px;"><input type="checkbox" name="defaultcheck" id="defaultcheck" value="1" class="docform" /></li>
 <li><label>Checked By Default</label></li>
 <li style="padding-left:10px;"><input type="checkbox" name="disabled" id="disabled" value="1" class="docform" /></li>
 <li><label for="disabled">Disabled</label></li>
 <li style="padding-left:10px;"><input type="checkbox" name="includes_list" id="includes_list" value="1" class="docform" /></li>
 <li><label for="includes_list">List Format</label></li>
<li><textarea name="proposal_doc_content" id="proposal_doc_content" style="width:1088px; height: 475px; margin-bottom:5px;" class="txtleft editdoc"></textarea></li>
<li><textarea name="content_code" id="content_code" style="width:1080px; height: 200px; margin-bottom:5px;" class="txtleft"></textarea></li>
<li class="clear">
 <input type="submit" name="typesub" class="buttons" value="SAVE"><!--- <button name="preview" id="preview" class="buttons">PREVIEW</button>---> <button name="showCode" id="showCode" class="buttons">CODE</button> <button name="deletePD" id="deletePD" class="buttons">DELETE</button></li>
 </ul> 
</form>
<div>
<div id="pdfembed"></div>
<p>Short code list:</p>
<p>
[CURRENT_DATE]<BR />
[ENTITY_NAME]<BR />
[DBA]<BR />
[ADDRESS_BLOCK]<BR />
[ADDRESS_LINE] (Mailing address lines 1 and 2 on a single line)<BR />
[CITY_STATE_ZIP]<BR />
[AMS]<BR />
[FEIN]<BR />
[CONTACT_NAME]<BR />
[CONTACT_PHONE]<BR />
[CONTACT_FAX]<BR />
[CONTACT_EMAIL]<BR />
[CURRENT_EFFECTIVE_DATE]<BR />
[TERRORISM_PREMIUM]<BR />
[USER_SIG]<BR />
[USER_NAME]<BR />
[PAGE_BREAK]<BR />
</p>
<p>Short codes are not case sensitive</p>
</div>

<div id="dialog-confirm" title="Delete Document?">
  <p> <span class="ui-icon ui-icon-alert"></span> Are you sure you want to delete this document? This cannot be undone.</p>
</div>