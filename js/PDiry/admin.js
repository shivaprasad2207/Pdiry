

function close_this_window (id){
 $('#'+ id).html('');
 $('#' + id).remove();
}

function get_member_info (){
    $("#new_member_add_form_msg").html('<img src="/static/images/My-Comm/1.gif" />');
    var form_params = $("#add_member_form").serialize();
    var url = '/cgi-bin/My-Comm/admin_func.pl?flag=' + 'MEMBER_ADD_INFO&'+ form_params ;
    $.get(
            url,
            function(data, textStatus, jqXHR) {
				$("#new_member_add_form_msg").html(data);
            },
            "text"
        );    
}

function modify_member_info() {
    $("#member_mod_form_msg").html('<img src="/static/images/My-Comm/1.gif" />');
    var form_params = $("#mod_member_form").serialize();
    var url = '/cgi-bin/My-Comm/admin_func.pl?flag=' + 'MEMBER_MODIFIED_INFO&'+ form_params ;
    $.get(
            url,
            function(data, textStatus, jqXHR) {
				$("#member_mod_form_msg").html(data);
            },
            "text"
        );      
}


function admin_member_add_form (){
         $("#disp").html('<img src="/static/images/My-Comm/1.gif" />')
         var url = '/cgi-bin/My-Comm/admin_func.pl?flag=' + 'SHOW_MEMBER_ADD_FORM' ;
         $.get(
            url,
            function(data, textStatus, jqXHR) {
				$("#display").html(data);
			    
                        },
            "text"
        );    
}

function admin_member_modify_form() {
         $("#disp").html('<img src="/static/images/My-Comm/1.gif" />')
         var url = '/cgi-bin/My-Comm/admin_func.pl?flag=' + 'SHOW_MEMBER_MODIFY_FORM' ;
         $.get(
            url,
            function(data, textStatus, jqXHR) {
				$("#display").html(data);
			    
                        },
            "text"
        );    
}

function admin_occupant_manage_form() {
         $("#disp").html('<img src="/static/images/My-Comm/1.gif" />')
         var url = '/cgi-bin/My-Comm/admin_func.pl?flag=' + 'SHOW_OCCUPANT_MANAGE_FORM' ;
         $.get(
            url,
            function(data, textStatus, jqXHR) {
				$("#display").html(data);
			    
                        },
            "text"
        );    
}


function admin_get_member_buttons (){
        $("#disp").html('<img src="/static/images/My-Comm/1.gif" />');
         var form_params = $("#search_form").serialize();
         form_params = form_params + '&flag=';
         var url = '/cgi-bin/My-Comm/admin_func.pl?flag=GET_BLK_FLOOR_INFO&'+ form_params;
         $.get(
            url,
            function(data, textStatus, jqXHR) {
				$("#disp").html(data);
			    
                        },
            "html"
        );    
}


function admin_get_occupants_buttons (){
        $("#disp").html('<img src="/static/images/My-Comm/1.gif" />');
         var form_params = $("#search_form").serialize();
         form_params = form_params + '&flag=GET_BLK_FLOOR_OF_OCCUPANT';
         var url = '/cgi-bin/My-Comm/admin_func.pl?'+ form_params;
         $.get(
            url,
            function(data, textStatus, jqXHR) {
				$("#disp").html(data);
			    
                        },
            "html"
        );    
}

function admin_lock_occupant_account_by_uname ( uname ){
         $("#disp_profile").html('<img src="/static/images/My-Comm/1.gif" />')
         var url = '/cgi-bin/My-Comm/admin_func.pl?flag=LOCK_OCCUPANT_ACCT&uname='+uname;
         $.get(
            url,
            function(data, textStatus, jqXHR) {
				$("#disp_profile").html(data);
			    
                        },
            "html"
        );    
}

function admin_unlock_occupant_account_by_uname ( uname ){
        $("#disp_profile").html('<img src="/static/images/My-Comm/1.gif" />')
         var url = '/cgi-bin/My-Comm/admin_func.pl?flag=UNLOCK_OCCUPANT_ACCT&uname='+uname;
         $.get(
            url,
            function(data, textStatus, jqXHR) {
				$("#disp_profile").html(data);
			    
                        },
            "html"
        );    
}

function admin_delete_occupant_profile_by_uname (uname){
      $("#disp_profile").html('<img src="/static/images/My-Comm/1.gif" />')
         var url = '/cgi-bin/My-Comm/admin_func.pl?flag=DEL_OCCUPANT_PROFILE&uname='+uname;
         $.get(
            url,
            function(data, textStatus, jqXHR) {
				$("#disp_profile").html(data);
			    
                        },
            "html"
        );    
}


function admin_view_occupant_profile_by_uname ( uname){
         $("#disp_profile").html('<img src="/static/images/My-Comm/1.gif" />')
         var url = '/cgi-bin/My-Comm/admin_func.pl?flag=VIEW_OCCUPANT_PROFILE&uname='+uname;
         $.get(
            url,
            function(data, textStatus, jqXHR) {
				$("#disp_profile").html(data);
			    
                        },
            "html"
        );    
}


function admin_change_passwd_form (){
         $("#disp").html('<img src="/static/images/My-Comm/1.gif" />')
         var url = '/cgi-bin/My-Comm/admin_func.pl?flag=' + 'SHOW_CHPASSWD_FORM' ;
         $.get(
            url,
            function(data, textStatus, jqXHR) {
				$("#display").html(data);
			    
                        },
            "text"
        );    
    
}
function get_passwdch_info() {
    $("#admin_chpasswd_form_msg").html('<img src="/static/images/My-Comm/1.gif" />')
    var form_params = $("#admin_chpasswd_form").serialize();
     var url = '/cgi-bin/My-Comm/admin_func.pl?flag=' + 'CHPASSWD_INFO&'+form_params ;
     $.get(
            url,
            function(data, textStatus, jqXHR) {
				$("#admin_chpasswd_form_msg").html(data);
			    
                        },
            "text"
        );    
}

function html_get (){
    
    var x = document.getElementById('gg').value(); 
    alert (x);
}

function admin_view_member_profile_by_uname ( uname ){
         $("#disp_profile").html('<img src="/static/images/My-Comm/1.gif" />');
         var url = '/cgi-bin/My-Comm/admin_func.pl?flag=SHOW_MEMBER_INFO&uname='+ uname;
         $.get(
            url,
            function(data, textStatus, jqXHR) {
				$("#disp_profile").html(data);
			    
                        },
            "html"
        );    
}

function admin_modify_member_profile_by_uname ( uname ){
    $("#disp_profile").html('<img src="/static/images/My-Comm/1.gif" />');
         var url = '/cgi-bin/My-Comm/admin_func.pl?flag=MOD_MEMBER_INFO&uname='+ uname;
         $.get(
            url,
            function(data, textStatus, jqXHR) {
				$("#disp_profile").html(data);
			    
                        },
            "html"
        );    
}

function admin_get_notice_test_box (){
         $("#obj_disp").html('<img src="/static/images/My-Comm/1.gif" />');
         var url = '/cgi-bin/My-Comm/admin_func.pl?flag=SHOW_ADMIN_NOTICE_TEXT_BOX';
         $.get(
            url,
            function(data, textStatus, jqXHR) {
				$("#obj_disp").html(data);
			    
                        },
            "html"
        );    
}

function promote_preview_notice (){
    $("#obj_disp").html('<img src="/static/images/My-Comm/1.gif" />');
    var url = '/cgi-bin/My-Comm/admin_func.pl?flag=PROMOTE_PREVIEW_NOTICE';
         $.get(
            url,
            function(data, textStatus, jqXHR) {
				$("#obj_disp").html(data);
			    
                        },
            "html"
        );    
    
}


function delete_existing_notice (){
        $("#obj_disp").html('<img src="/static/images/My-Comm/1.gif" />');
        var url = '/cgi-bin/My-Comm/admin_func.pl?flag=DELETE_EXISTING_NOTICE' ;
         $.get(
            url,
            function(data, textStatus, jqXHR) {
				$("#obj_disp").html(data);
			    
                        },
            "html"
        );     
}

function get_su_admin_create_form (){
         var url = '/cgi-bin/My-Comm/admin_func.pl?flag=SUDO_ADMIN_CREATE_FORM' ;
         $.get(
            url,
            function(data, textStatus, jqXHR) {
				$("#obj_disp").html(data);
			    
                        },
            "html"
        );    
}
function register_sudo_admin (){
    
    var uname = document.getElementById( 'uname').value;
    var url = '/cgi-bin/My-Comm/admin_func.pl?flag=SUDO_ADMIN_CREATE&uname=' + uname ;
    
         $.get(
            url,
            function(data, textStatus, jqXHR) {
				$("#obj_disp").html(data);
			    
                        },
            "html"
        );    
}

function depromote_sudo_admin() {
    var uname = document.getElementById( 'uname').value;
    var url = '/cgi-bin/My-Comm/admin_func.pl?flag=SUDO_ADMIN_DEPRMOTE&uname=' + uname ;
    
         $.get(
            url,
            function(data, textStatus, jqXHR) {
				$("#obj_disp").html(data);
			    
                        },
            "html"
        );    
}

function set_depromote_sudo_admin (uname){
    var url = '/cgi-bin/My-Comm/admin_func.pl?flag=SUDO_ADMIN_DEPRMOTE&uname=' + uname ;
         $.get(
            url,
            function(data, textStatus, jqXHR) {
				$("#obj_disp").html(data);
			    
                        },
            "html"
        );    
}

function set_delete_admin (uname){
    var url = '/cgi-bin/My-Comm/admin_func.pl?flag=ADMIN_DELETE&uname=' + uname ;
         $.get(
            url,
            function(data, textStatus, jqXHR) {
				$("#obj_disp").html(data);
			    
                        },
            "html"
        );    
}

function get_admin_delete_form (){
    var url = '/cgi-bin/My-Comm/admin_func.pl?flag=ADMIN_DELETE_FORM';
    
         $.get(
            url,
            function(data, textStatus, jqXHR) {
				$("#obj_disp").html(data);
			    
                        },
            "html"
        );    
}


function register_admin (){
         $("#new_sudo_admin_create_msg").html('<img src="/static/images/My-Comm/1.gif" />');
         var uname = document.getElementById( 'uname').value.length;
         var fname = document.getElementById( 'fname').value.length;
         var lname = document.getElementById( 'lname').value.length;
         var email = document.getElementById( 'email').value.length;
         var mobile = document.getElementById( 'mobile').value.length;
         var passwd2 = document.getElementById( 'passwd2').value.length;
         var passwd1 = document.getElementById( 'passwd1').value.length;
         var vpasswd2 = document.getElementById( 'passwd2').value;
         var vpasswd1 = document.getElementById( 'passwd1').value;
         
         if ( uname == 0 || fname == 0 || lname == 0 || email == 0 || mobile == 0){
            $("#new_sudo_admin_create_msg").html('<font color="red" size="5"><b> All Elements are Mandatory</b></font>');
         }else{
               if ( passwd2 == 0 || passwd1 == 0 ){
                   $("#new_sudo_admin_create_msg").html('<font color="red" size="5"><b>Password cannot be empty </b></font>');
               }else if ( vpasswd2 != vpasswd1 ){
                   $("#new_sudo_admin_create_msg").html('<font color="red" size="5"><b>Both Passwords are not same</b></font>');
               }else{
                    var form_params = $("#admin_create_form").serialize(); 
                    var url = '/cgi-bin/My-Comm/admin_func.pl?flag=REGISTER_ADMIN&' + form_params ;
                    $.get(
                        url,
                        function(data, textStatus, jqXHR) {
				$("#new_sudo_admin_create_msg").html(data);		    
                        },
                        "html"
                    );    
               }  
         }
}


function get_su_admin_depromote_form (){
         var url = '/cgi-bin/My-Comm/admin_func.pl?flag=SUDO_ADMIN_DEPROMOTE_FORM' ;
         $.get(
            url,
            function(data, textStatus, jqXHR) {
				$("#obj_disp").html(data);
			    
                        },
            "html"
        );    
}


function get_admin_create_form (){
         var url = '/cgi-bin/My-Comm/admin_func.pl?flag=ADMIN_CREATE_FORM' ;
         $.get(
            url,
            function(data, textStatus, jqXHR) {
				$("#obj_disp").html(data);
			    
                        },
            "html"
        );    
}

function delete_this_notice_by_id (notice_id){
        
    var url = '/cgi-bin/My-Comm/admin_func.pl?flag=DELETE_NOTICE_BY_ID&notice_id=' + notice_id ;
         $.get(
            url,
            function(data, textStatus, jqXHR) {
				$("#obj_disp").html(data);
			    
                        },
            "html"
        );    
}

function list_all_notice (){
    $("#obj_disp").html('<img src="/static/images/My-Comm/1.gif" />');
    var url = '/cgi-bin/My-Comm/admin_func.pl?flag=LIST_ALL_NOTICE';
         $.get(
            url,
            function(data, textStatus, jqXHR) {
				$("#obj_disp").html(data);
			    
                        },
            "html"
        );    
}

function admin_submit_html_notice_to_preview ( msg_txt ){
    var text = document.getElementById( 'msg_text').value;
    text = String(text);
    
    var html_text = text.replace(/&/g,'MY_AMB').replace(/</g,'MY_LT').replace(/>/g,'MY_GT').replace(/;/g,'MY_SEMICOMM');
    //alert ( html_text );
    var url = '/cgi-bin/My-Comm/admin_func.pl?flag=SUBMIT_ADMIN_NOTICE_TEXT&html_text='+html_text;
         
    $.ajax({
            url : url,
            type: 'GET',
            async: true,
            dataType: "html",
            context: document.body,
            processData:true,
            cache:false,
            global:true,
            traditional:true,
            success:function(data, textStatus, jqXHR) {
                    $("#obj_disp").html(data);
                    
            }
       }); 

}



function get_html_editor (){
     
    var url = 'index.pl?AppParam=AdminUserDepromote' 
    var tag = $('<div style="overflow:scroll"> </div>');
    var title = '<b style="\
                                                    background-image:url(/static/images/My_lib/oinfo_title_bar.png); \
                                                    height:15px; \
                                                    width:200px; color:white;padding:0px"> \
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    HTML EDITOR \
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                </b>' ;
     $.ajax({
            url : url,
            type: 'GET',
            async: true,
            dataType: "html",
            context: document.body,
            processData:true,
            cache:false,
            global:true,
            traditional:true,
            success:function(data, textStatus, jqXHR) {
                       tag.html(data).dialog({
                                modal: true,
                                title: title,
                                
                                open: function(event, ui) {  
                                        $('.ui-dialog-titlebar-close')
                                        .removeClass("ui-dialog-titlebar-close")
                                        .html('<img src="/static/images/My_lib/closebutton.png" width="25" height="25" style="padding:1px">');
                                        $('.ui-widget-overlay').css('width','100%');
                                },  
				width: 1200,
                                height: 900,              
                                close: function(event, ui){
                                                    $('body').css('overflow','auto');
                                       } 
                               
                              }).dialog('open');                
	 }
    
       }); 
    
}