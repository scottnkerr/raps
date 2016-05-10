<script>
$(document).ready(function() {
					   
	$('#adduserform')[0].reset();
	$('.user_label').hide();
	createUserGrid();					   
	// validate signup form on keyup and submit
	var container = $('div.errors');
	var validator = $("#adduserform").validate({
		rules: {
			user_firstname: "required",
			user_lastname: "required",
			user_name: {
				required: true,
				//minlength: 2,
				remote: "/index.cfm?event=main.checkUserDup"
			},
			user_pass: {
				required: true,
				//minlength: 5
			},
			user_pass_confirm: {
				required: true,
				//minlength: 5,
				equalTo: "#user_pass"
			}

		},
		messages: {
			user_name: {
				required: "Enter a username",
				remote: jQuery.format("Username is already in use")
			},
			user_pass: {
				required: "Provide a password"
			},
			user_pass_confirm: {
				required: "Repeat your password",
				equalTo: "Enter the same password as above"
			}
		},
//showErrors: function(errorMap, errorList) {
//    $(".errordiv").html($.map(errorList, function (el) {
//        return el.message;
//    }).join(", "));
//},


		// specifying a submitHandler prevents the default submit, good for the demo
		submitHandler: function() {
			var data = $('#adduserform').serialize();
			var id = $('#user_id').val();
			$.ajax({
			  type: "POST",
			  cache: false,
			  url: "/index.cfm?event=main.saveUser",
			  data: data,
			  cache: false

			}).success(function(resp) {
				if (resp = 'success'){

				saveAlert();
					if (id == 0) {
						resetStuff();
					}
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

$(".edituser").live("click", function(){
$('#adduser').show();
$("#user_name").rules("remove", "required");
$("#user_name").rules("remove", "remote");
  validator.resetForm();
//$("#user_name").prop('disabled', true);

	
	
	$('label.usermsg').html('Edit User');
	var id = $(this).attr("edit_id");
	$.ajax({
    url: "/index.cfm?event=main.getUsers", 
	type: "get",
	cache: false,
	dataType: "json",
	data: {
	  user_id: id
  }
  , success: function (data){
	  //populate the form 
	 
		$.each(data, function() {
		  $.each(this, function(k, v) {
			if (v.disabled == 1) {
			$('#disabled').prop("checked", true);
			}			  
			else {
			$('#disabled').prop("checked", false);	
			}
		   if (v.user_id != undefined) {
		   $('#user_id').val(v.user_id);
		   }								
		   if (v.user_name != undefined) {
		   $('#user_name').val(v.user_name).hide();
		   $('.user_label').html(v.user_name).show();
		   }
		   if (v.user_firstname != undefined) {
		   $('#user_firstname').val(v.user_firstname);
		   }
		   if (v.user_lastname != undefined) {
		   $('#user_lastname').val(v.user_lastname);
		   }
		   if (v.decryptedpass != undefined) {
		   $('#user_pass').val(v.decryptedpass);
		   $('#user_pass_confirm').val(v.decryptedpass);
		   }	
		   if (v.user_sig != undefined) {
				$('#user_sig').val(v.user_sig);
				$('#sigimage').html('<img src="/sigs/'+v.user_sig+'" class="sigclass">');			   
		   }
		   if (v.user_role_id != undefined) {
		   $('#user_role_id').val(v.user_role_id);
		   //needed to refresh wijmo select box
		   $('.selectbox').wijdropdown("refresh");
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
			$('#upload').uploadify({
				'swf'      : 'uploadify.swf',
				'uploader' : '/app/controllers/uploadify.cfc?method=uploadsig',
				'fileSizeLimit' : '5MB',
				'buttonText' : 'BROWSE...',
				'multi': false,
				'fileTypeExts' : '*.jpg;*.png',
				'onUploadSuccess' : function(file, data, response) {
				$('#user_sig').val(data);
				$('#sigimage').html('<img src="/sigs/'+data+'" class="sigclass">');
        		},
				'onQueueComplete' : function(queueData) {
				//alert('queue complete');
        } 
			});	
});//end doc ready
//user grid	
createUserGrid = function() {            

		$("#usergrid").wijgrid({
				allowSorting: true,
				allowPaging: true,
                pageSize: 50,
                data: new wijdatasource({
                    proxy: new wijhttpproxy({
                        url: "index.cfm",
                        dataType: "json",
                        data: {
						event: "main.getUsers",
						cache: false
                        },
                        key: "data"
                    }),
                    reader: new wijarrayreader([
                     //{ name: "label", mapping: function (item) { return item.ITEM_NAME + (item.ITEM_CAT ? ", " + item.ITEM_CAT : "") + ", " + item.ITEM_ID } },
                     { name: "FULL NAME", mapping: function(item){
                     	return item.user_firstname + ' ' + item.user_lastname;
                     	} 
                     },
					 { name: "USER NAME", mapping: "username" },
					 { name: "ROLE", mapping: "user_role_name" },
					 { name: "STATUS", mapping: function (item) { 
					 if (item.disabled !== 1) {
					 	var link1 = "ACTIVE";
					 }
					 else {
					 	var link1 = "DISABLED";
					 }
					 	return link1
						}
					 },					 
					 { name: "EDIT/DELETE", mapping: function (item) { 
					 //var link1 = "<a href='/index.cfm?event=main.users&user_id=" + item.USER_ID + "'>EDIT</a>";
					 var link1 = "<img src='/images/editbutton.png' class='imagebuttons edituser' edit_id='" + item.user_id + "'><img src='/images/deletebutton.png' class='imagebuttons deleteuser' delete_id='" + item.user_id + "'>";
// x.value = x.value.replace(/['"]/g,'');
					 	return link1
						} 
						}
                  ])
                })
            });
 $(".wijmo-wijgrid").fadeIn();
		
};
resetStuff = function(fullreset) {
	
			  $('#adduserform')[0].reset();
			  $('#user_id').val(0);
			  	$('#user_sig').val('');
				$('#sigimage').html('');
			  //trash and redraw the grid with new values from db

			$('#user_name').rules("add", {
						remote : "/app/model/main.cfc?method=checkDup",
						required: true
			});
			$('.user_label').html('').hide();
			$('#user_name').show();
			$('#adduser').hide();
			
			$('label.usermsg').html('Add User');
			if (fullreset != 1) {
			  $("#usergrid").wijgrid("destroy");
			  createUserGrid();
			  
			  //add back the rules for required and remote for user name				
			}
}
			
 </script>
<style>
.wijmo-wijgrid {
	display:none;
}
</style>
<div id="statusbar">
  <div id="pagename">User Administration</div>
  <div id="statusstuff"> </div>
  <!---End Statusstuff--->
</div>
<!---End statusbar--->
<cfoutput>
<div class="msgcontainer">
<div class="message"></div>
</div>  
  <form id="adduserform" action="/index.cfm?event=main.doSaveUser" method="post" autocomplete="off">
    <ul class="formfields txtleft" style="margin:0px 0 10px; width:430px;">
      <li class="clear">
        <label class="bold usermsg">Add User</label>
        <label id="adduser">|&nbsp;&nbsp;&nbsp;Add User</label>
      </li>
      <li class="clear">
        <label class="width-120">First Name</label>
      </li>
      <li>
        <input type="hidden" name="user_id" id="user_id" value="0" />
        <input type="text" name="user_firstname" id="user_firstname" class="width-150" />
      </li>
      <li class="clear">
        <label class="width-120">Last Name</label>
      </li>
      <li>
        <input type="text" name="user_lastname" id="user_lastname" class="width-150" />
      </li>
      <li class="clear">
        <label class="width-120">Username</label>
      </li>
      <li>
        <label class="user_label"></label>
        <input type="text" name="user_name" id="user_name" class="width-150" />
      </li>
      <li class="clear">
        <label class="width-120">Password</label>
      </li>
      <li>
        <input type="password" name="user_pass" id="user_pass" class="width-150" />
      </li>
      <li class="clear">
        <label class="width-120">Confirm Password</label>
      </li>
      <li>
        <input type="password" name="user_pass_confirm" id="user_pass_confirm" class="width-150" />
      </li>
      <li class="clear">
        <label class="width-120">Role</label>
      </li>
      <li>
        <select name="user_role_id" id="user_role_id" class="selectbox" style="width:143px" />
        
        <cfloop query="rc.roles">
          <option value="#rc.roles.user_role_id#">#rc.roles.user_role_name#</option>
        </cfloop>
        </select>
      </li>
      <li class="clear">
        <label class="width-120">&nbsp;</label>
      </li>      
      <li>
      <input type="checkbox" name="disabled" id="disabled" value="1">
      </li>
<li><label for="disabled">Disabled</label></li>
		<li class="clear" style="height:20px"></li>
     
      <li class="clear">
        <label class="width-120">&nbsp;</label>
      </li>
      <li>
      <input type="hidden" name="user_sig" id="user_sig" />
        <input class="buttons usermsg" type="submit" value="Save" />
      </li>
    </ul>
  </form>
  <ul class="formfields uploadsig">
      <li class="clear">
        <label class="width-120">&nbsp;</label>
      </li>  
  <li class="clear"><label>Signature</label></li>
  <li class="clear"><label style="font-style:italic;">*Image must be .png or .jpg format and less than 5MB.</label></li>
  <li id="sigimage" class="clear"></li>
  <li class="clear">	<form id="fileform" autocomplete="off">
		<div id="queue"></div>
		<input id="upload" name="upload" type="file" multiple>
	</form>
    </li>
    </ul>
</cfoutput>
<div style="clear:both"></div>
<table id="usergrid">
</table>
</div>
<div id="dialog-confirm" title="Delete User?">
  <p> <span class="ui-icon ui-icon-alert"></span> Are you sure you want to delete this user?</p>
</div>
