<cfparam name="FORM.document_id" default="0">

<script>
$(document).ready(function() {

$('#document_id').change(function() {
		var id = $(this).val();	
		$(":input[type='checkbox']").prop("checked",false);
		$(":input[type='checkbox']").wijcheckbox("refresh");
	if (id == 0) {
	    $('#limitsform')[0].reset();
		$('#document_id').val(0);
		$('.filefieldlabel').html('File');
		$('.filepreviewli').slideUp();
		$('#document_filepreview').html('');
		$('#deletedoc').fadeOut();
	}
	else {
	$('.filefieldlabel').html('Replace File');	
	$('.filepreviewli').slideDown();
	$('#deletedoc').fadeIn();
	$.ajax({
		type: "GET",
		url: "/index.cfm?event=main.getDocs",
		dataType: "json",
		data: {
			document_id: id
		}
	}).success(function(response) {
		
		$.each(response.data, function(k,v) {	
			$('#document_name').val(v.document_name);
			var html = '<a href="/docs/' + v.document_file + '" target="_blank">' +  v.document_file + '</a>';
			$('#document_filepreview').html(html);

		});
					 
					
	});	
	
	}
	
 });
//end document_id change

	var validator = $("#limitsform").validate({
		rules: {
			document_name: {
				required: true
				},
			upload: {
				required: false
			}

		},
		messages: {
			document_name: {
				required: "*"
			}
		},


		// set this class to error-labels to indicate valid fields
		success: function(label) {
			// set &nbsp; as text for IE
			label.html("&nbsp;").addClass("checked");
		}
	});
		   // var progressbar = $("#progressbar");
$('#document_id').trigger('change');
$("#deletedoc").click(function(e){	
	e.preventDefault();						   
	$("#dialog-confirm").wijdialog({
                autoOpen: true,
                resizable: false,
                height: 180,
                width: 400,
                modal: true,
                buttons: {
                    "Delete User": function () {
                        $(this).wijdialog("close");
						var action = $("#limitsform").attr("action");
						var action = action + '&delete=true';
						$("#limitsform").attr("action", action);
						$('#limitsform').submit();

                    },
                    Cancel: function () {
                        $(this).wijdialog("close");
                    }
                }

            });		
});

	
});
//end document.ready





</script>

<div id="statusbar">
  <div id="pagename">Document Administration</div>
  <div id="statusstuff"> </div>
  <!---End Statusstuff--->
</div>
<!---End statusbar--->

<div class="msgcontainer">
<div class="message"></div>
</div>


  <form id="limitsform" method="post" action="/index.cfm?event=main.documentAdmin" enctype="multipart/form-data" autocomplete="off">
<ul class="formfields txtleft" style="margin:10px 0 10px;">
<li class="clear"><label class="width-120">Select</label></li>
<li><select name="document_id" id="document_id" class="selectbox2" style="width:158px;">
<option value="0">Add New</option>
<cfoutput query="rc.docs"><option value="#rc.docs.document_id#"<cfif rc.docs.document_id eq FORM.document_id> selected="true"</cfif>>#rc.docs.document_name#</option></cfoutput>
  </select>
  </li>

 <li class="clear"><label>&nbsp;</label></li> 
 <li class="clear"><label class="width-120">Name</label></li>
 <li><input type="text" name="document_name" id="document_name" class="width-150" /></li>

<li class="clear filepreviewli"><label class="width-120">File</label></li>
 <li class="filepreviewli"><label id="document_filepreview"></label></li> 
  <li class="clear"><label class="width-120 filefieldlabel">File</label></li>
 <li><input id="upload" name="upload" type="file" /></li>
 <li class="clear"><label>&nbsp;</label></li> 
 <li class="clear"><input type="submit" name="typesub" class="buttons" value="SAVE"><input type="button" name="deletedoc" id="deletedoc" value="DELETE" class="buttons" /></li> 
 </ul> 

</form>

<div id="dialog-confirm" title="Delete Document?">
  <p> <span class="ui-icon ui-icon-alert"></span> Are you sure you want to delete this document?</p>
</div>