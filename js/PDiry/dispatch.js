
function dispatch (mpid){
    window.location = "index.pl?AppParam=MPID&mpid=" + mpid;
}

function password_change_form( uid ){
    $("#passwd_form_disp").html('<img src="/static/images/My-Blog/1.gif" />');
    var url = '/cgi-bin/My-blog/core.pl?flag=PASSWD_CHANGE_FORM&uid='+uid;
    $.get(
         url,
         function(data, textStatus, jqXHR) {
                                $("#passwd_form_disp").html(data);
                            },
        "html"
    );     
}

function email_change_form ( uid ){
    $("#email_form_disp").html('<img src="/static/images/My-Blog/1.gif" />');
    var url = '/cgi-bin/My-blog/core.pl?flag=EMAIL_CHANGE_FORM&uid='+uid;
    $.get(
         url,
         function(data, textStatus, jqXHR) {
                                $("#email_form_disp").html(data);
                            },
        "html"
    );     
}

function name_change_form ( uid ){
    $("#name_form_disp").html('<img src="/static/images/My-Blog/1.gif" />');
    var url = '/cgi-bin/My-blog/core.pl?flag=NAME_CHANGE_FORM&uid='+uid;
    $.get(
         url,
         function(data, textStatus, jqXHR) {
                                $("#name_form_disp").html(data);
                            },
        "html"
    );     
}

function submit_user_new_email ( uid ){
    var form_params = $("#email_form").serialize();
    $("#p_load_disp").html('<img src="/static/images/My-Blog/1.gif" />');
    var url = '/cgi-bin/My-Blog/core.pl?flag=' + 'EMAIL_CHANGE_SUBMIT&' + form_params + '&uid=' + uid;
     $.get(
             url,
             function(data, textStatus, jqXHR) {
                                    $("#container2").remove(); 
                                    $("#container").remove(); 
                                    $("#p_load_disp").html('');
                                    $("#email_form").remove(); 
                                    $("#log_1").html(  data );
                            },
            "html"
        );
       
}

function submit_user_new_name( uid ){
    var form_params = $("#name_form").serialize();
    $("#p_load_disp").html('<img src="/static/images/My-Blog/1.gif" />');
    var url = '/cgi-bin/My-Blog/core.pl?flag=' + 'NAME_CHANGE_SUBMIT&' + form_params + '&uid=' + uid;
     $.get(
             url,
             function(data, textStatus, jqXHR) {
                                    $("#container1").remove(); 
                                    $("#container").remove(); 
                                    $("#p_load_disp").html('');
                                    $("#name_form").remove(); 
                                    $("#log_1").html(  data );
                            },
            "html"
        );
}



function submit_user_passwd ( uid ){
    var form_params = $("#passwd_form").serialize();
    $("#p_load_disp").html('<img src="/static/images/My-Blog/1.gif" />');
    var p1 = document.getElementById("p1").value;
    var p2 = document.getElementById("p2").value;
    if ( p1 != p2 ){
        $("#p_load_disp").html('<b>Both New password should be same</b>');
    }else {
        var url = '/cgi-bin/My-Blog/core.pl?flag=' + 'PASSWD_CHANGE_SUBMIT&' + form_params + '&uid=' + uid;
        $.get(
             url,
             function(data, textStatus, jqXHR) {
                                    $("#p_load_disp").html('');
                                    $("#passwd_form").remove(); 
                                    $("#log_1").html(  data );
                            },
            "html"
        );
    }    
}



function remove_box ( id ){
    id = '#' + id;
    $(id).remove();
}

function add_quesation(  uid  , mpid , spid ){
    $("#load_disp").html('<img src="/static/images/My-Blog/1.gif" />');
    var quesation = document.getElementById("quesation").value;
    var description = document.getElementById("description").value;
    var url = '/cgi-bin/My-blog/core.pl?flag=ADD_Q&quesation='+quesation + '&description='+description + '&uid='+uid + '&mpid='+mpid + '&spid='+spid;  
    $.get(
         url,
         function(data, textStatus, jqXHR) {
                                $("#load_disp").html(data);
                            },
        "html"
    );     
    
}

function write_to_admin ( qid, full_name, email ){
    $("#contact_admin_load").html('<img src="/static/images/My-Blog/1.gif" />');
     var subject_text = document.getElementById("mail_subject").value;
     var mail_text = document.getElementById("mail_text").value;
     var url = '/cgi-bin/My-blog/core.pl?flag=SEND_MAIL_TO_ADMIN&subject_text='+subject_text+'&mail_text='+mail_text+'&qid='+qid +'&email='+email+'&full_name='+full_name;  
    $.get(
         url,
         function(data, textStatus, jqXHR) {
                                $("#contact_admin_load").html(data);
                            },
        "html"
    );     
}

function request_new_main_topic ( qid , full_name, email){
    $("#req_new_main_topic_load").html('<img src="/static/images/My-Blog/1.gif" />');
    var main_topic_req = document.getElementById("main_topic_req").value;
     var url = '/cgi-bin/My-blog/core.pl?flag=REQ_NEW_MAIL_TOPIC&subject_text='+main_topic_req +'&email='+email+'&full_name='+full_name;  
    $.get(
         url,
         function(data, textStatus, jqXHR) {
                                $("#req_new_main_topic_load").html(data);
                            },
        "html"
    );     
}


function request_new_sub_topic(qid, full_name , email , topic_name ){
    $("#req_new_sub_topic_load").html('<img src="/static/images/My-Blog/1.gif" />');
    var sub_topic_req = document.getElementById("req_new_sub_topic").value;
     var url = '/cgi-bin/My-blog/core.pl?flag=REQ_NEW_SUB_TOPIC&subject_text='+sub_topic_req +'&email='+email+'&full_name='+full_name+'&main_topic='+topic_name ;  
    $.get(
         url,
         function(data, textStatus, jqXHR) {
                                $("#req_new_sub_topic_load").html(data);
                            },
        "html"
    );     

    
}



function request_new_sub_topic_form ( uname , mpid ) {
     var url = '/cgi-bin/My-blog/core.pl?flag=NEW_SUB_TOPIC_REQ_FORM&uname='+uname +'&mpid=' + mpid;
    var tag = $('<div id="user" style="overflow:scroll"> </div>');
    var title = '<b style="                         height:15px; \
                                                    width:200px; color:yellow;padding:0px"> \
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    Request For Main Topic \
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                </b>' ;
    
    $.get(
            url,
            function(data, textStatus, jqXHR) {
                     tag.html(data).dialog({
                                                                modal: true,
                                                                title: title,
                                                                hide:"explode",
                                                                open: function(event, ui) {  
                                                                    $('.ui-dialog-titlebar-close')
                                                                    .removeClass("ui-dialog-titlebar-close")
                                                                    .html('<img src="/static/images/My-Blog/closebutton.png" width="25" height="25" style="padding:1px">');
                                                                    $('.ui-widget-overlay').css('width','100%');
                                                                },  
                                                                width: 700,
                                                                height: 300,              
                                                                close: function(event, ui){
                                                                $('body').css('overflow','auto');
                                          
                                                            } 
                                                            }).dialog('open');                  
	 },
         "html"
      );   
    
}

function request_for_main_topic ( uname ) {
     var url = '/cgi-bin/My-blog/core.pl?flag=NEW_MAIN_TOPIC_REQ_FORM&uname='+uname;
    var tag = $('<div id="user" style="overflow:scroll"> </div>');
    var title = '<b style="                         height:15px; \
                                                    width:200px; color:yellow;padding:0px"> \
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    Request For Main Topic \
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                </b>' ;
    
    $.get(
            url,
            function(data, textStatus, jqXHR) {
                     tag.html(data).dialog({
                                                                modal: true,
                                                                title: title,
                                                                hide:"explode",
                                                                open: function(event, ui) {  
                                                                    $('.ui-dialog-titlebar-close')
                                                                    .removeClass("ui-dialog-titlebar-close")
                                                                    .html('<img src="/static/images/My-Blog/closebutton.png" width="25" height="25" style="padding:1px">');
                                                                    $('.ui-widget-overlay').css('width','100%');
                                                                },  
                                                                width: 700,
                                                                height: 300,              
                                                                close: function(event, ui){
                                                                $('body').css('overflow','auto');
                                          
                                                            } 
                                                            }).dialog('open');                  
	 },
         "html"
      );   
    
}

function discussion_add_to_thread ( qid ){
    $("#load_d").html('<img src="/static/images/My-Blog/1.gif" />');
    var text = document.getElementById("text").value;
    var url = '/cgi-bin/My-blog/core.pl?flag=ADD_COMMENT_TO_THREAD&qid='+qid  +  '&text='+text;
    $.get(
         url,
         function(data, textStatus, jqXHR) {
                                $("#load_d").html('');
                                window.location = '/cgi-bin/My-blog/index.pl?AppParam=ShowThread&QID=' + qid; 
                            },
        "html"
    );     
}

function F_discussion_add_to_thread ( qid , name){
    $("#load_d").html('<img src="/static/images/My-Blog/1.gif" />');
    var text = document.getElementById("text").value;
    var url = '/cgi-bin/My-blog/core.pl?flag=F_ADD_COMMENT_TO_THREAD&qid='+qid  +  '&text='+text + '&name=' + name;
    $.get(
         url,
         function(data, textStatus, jqXHR) {
                                $("#load_d").html('');
                                window.location = 'index.pl?AppParam=RESPOND_COMNT&qid=' + qid + '&uname=' + name; 
                            },
        "html"
    );     
}


function contact_admin ( uname ){
    var url = '/cgi-bin/My-blog/core.pl?flag=ADMIN_CONTACT_FORM&uname='+uname;
    var tag = $('<div id="user" style="overflow:scroll"> </div>');
    var title = '<b style="                         height:15px; \
                                                    width:200px; color:yellow;padding:0px"> \
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    Contact Admin \
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                </b>' ;
    
    $.get(
            url,
            function(data, textStatus, jqXHR) {
                     tag.html(data).dialog({
                                                                modal: true,
                                                                title: title,
                                                                hide:"explode",
                                                                open: function(event, ui) {  
                                                                    $('.ui-dialog-titlebar-close')
                                                                    .removeClass("ui-dialog-titlebar-close")
                                                                    .html('<img src="/static/images/My-Blog/closebutton.png" width="25" height="25" style="padding:1px">');
                                                                    $('.ui-widget-overlay').css('width','100%');
                                                                },  
                                                                width: 700,
                                                                height: 600,              
                                                                close: function(event, ui){
                                                                $('body').css('overflow','auto');
                                          
                                                            } 
                                                            }).dialog('open');                  
	 },
         "html"
      );   
    
}

function my_subscription(){
    var url = '/cgi-bin/My-blog/core.pl?flag=MY_SUBSCRIPTION';
    var tag = $('<div id="user" style="overflow:scroll"> </div>');
    var title = '<b style="                         height:15px; \
                                                    width:200px; color:white;padding:0px"> \
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    My Subscription \
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                </b>' ;
    
    $.get(
            url,
            function(data, textStatus, jqXHR) {
                     tag.html(data).dialog({
                                                                modal: true,
                                                                title: title,
                                                                hide:"explode",
                                                                open: function(event, ui) {  
                                                                    $('.ui-dialog-titlebar-close')
                                                                    .removeClass("ui-dialog-titlebar-close")
                                                                    .html('<img src="/static/images/My-Blog/closebutton.png" width="25" height="25" style="padding:1px">');
                                                                    $('.ui-widget-overlay').css('width','100%');
                                                                },  
                                                                width: 700,
                                                                height: 200,              
                                                                close: function(event, ui){
                                                                $('body').css('overflow','auto');
                                          
                                                            } 
                                                            }).dialog('open');                  
	 },
         "html"
    ); 
    
}

function subscribe ( mpid,spid){
    $("#load").html('<img src="/static/images/My-Blog/1.gif" />');
    var url = '/cgi-bin/My-blog/core.pl?flag=SUBSCRIBE&mpid='+mpid + '&spid='+spid;
    var tag = $('<div style="overflow:scroll"> </div>');
    var title = '<b style="                         height:15px; \
                                                    width:200px; color:white;padding:0px"> \
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    Subscribe \
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
                       $("#load").html('');
                       window.location = '/cgi-bin/My-Blog/index.pl?AppParam=MPID&mpid=' +  mpid ;
	 } 
       }); 
}

function unsubscribe ( mpid,spid){
    $("#load").html('<img src="/static/images/My-Blog/1.gif" />');
    var url = '/cgi-bin/My-blog/core.pl?flag=UNSUBSCRIBE&mpid='+mpid + '&spid='+spid;
  
    var tag = $('<div style="overflow:scroll"> </div>');
  
    var title = '<b style="                         height:15px; \
                                                    width:200px; color:white;padding:0px"> \
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    Unsubscribe \
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
                       $("#load").html('');
                       var mark = "#ok_" + mpid + '_' + spid ;
                       $(mark).html('');
                       window.location = '/cgi-bin/My-Blog/index.pl?AppParam=MPID&mpid=' +  mpid ;
	 }
    
       }); 
  
}

function make_quesation ( mpid,spid){
     $("#load").html('<img src="/static/images/My-Blog/1.gif" />');
    var url = '/cgi-bin/My-blog/core.pl?flag=IS_SUBSCRIBED&mpid='+mpid + '&spid='+spid;
    var tag = $('<div style="overflow:scroll"> </div>');
    var title = '<b style="                         height:15px; \
                                                    width:200px; color:white;padding:0px"> \
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    Notice \
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                </b>' ;
  
    $.get(
         url,
         function(data, textStatus, jqXHR) {
                                $("#load").html('');
                                if ( data == 1){
                                    var url = '/cgi-bin/My-blog/core.pl?flag=SHOW_FORM_Q_DIALOG&mpid='+mpid + '&spid='+spid;  
                                    $.get(
                                           url,
                                           function(data, textStatus, jqXHR) { 
                                                var tag = $('<div style="overflow:scroll"> </div>');
                                                var title = '<b style="                         height:15px; \
                                                    width:200px; color:white;padding:0px"> \
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    Add Quesation \
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
                                                            $("#load_disp").html('');
                                                            tag.html(data).dialog({
                                                                modal: true,
                                                                title: title,
                                                                hide:"explode",
                                                                open: function(event, ui) {  
                                                                    $('.ui-dialog-titlebar-close')
                                                                    .removeClass("ui-dialog-titlebar-close")
                                                                    .html('<img src="/static/images/My-Blog/closebutton.png" width="25" height="25" style="padding:1px">');
                                                                    $('.ui-widget-overlay').css('width','100%');
                                                                },  
                                                                width: 1400,
                                                                height: 600,              
                                                                close: function(event, ui){
                                                                $('body').css('overflow','auto');
                                          
                                                            } 
                                                            }).dialog('open');                
                                                        }
                                            });                                         
                                           },
                                           "html"
                                     );     
                                }else{
                                      tag.html(data).dialog({
                                            modal: true,
                                            title: title,
                                            hide:"explode",
                                            open: function(event, ui) {  
                                                    $('.ui-dialog-titlebar-close')
                                                    .removeClass("ui-dialog-titlebar-close")
                                                    .html('<img src="/static/images/My-Blog/closebutton.png" width="25" height="25" style="padding:1px">');
                                                     $('.ui-widget-overlay').css('width','100%');
                                            },  
                                            width: 600,
                                            height: 300,              
                                            close: function(event, ui){
                                                    $('body').css('overflow','auto');
                                         } 
                                       }).dialog('open');                                                              
                                }    
                        },
        "html"
    );     
}


function make_view ( mpid,spid ){
    $("#load").html('<img src="/static/images/My-Blog/1.gif" />');
    var url = '/cgi-bin/My-blog/core.pl?flag=IS_SUBSCRIBED&mpid='+mpid + '&spid='+spid;
    var tag = $('<div style="overflow:scroll"> </div>');
    var title = '<b style="                         height:15px; \
                                                    width:200px; color:white;padding:0px"> \
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    Notice \
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                </b>' ;
  
    $.get(
         url,
         function(data, textStatus, jqXHR) {
                                $("#load").html('');
                                if ( data == '1'){
                                    window.location = 'index.pl?AppParam=ShowQlist&spid=' + spid + '&mpid=' + mpid ;                           
                                }else{
                                      
                                      tag.html(data).dialog({
                                            modal: true,
                                            title: title,
                                            hide:"explode",
                                            open: function(event, ui) {  
                                                    $('.ui-dialog-titlebar-close')
                                                    .removeClass("ui-dialog-titlebar-close")
                                                    .html('<img src="/static/images/My-Blog/closebutton.png" width="25" height="25" style="padding:1px">');
                                                     $('.ui-widget-overlay').css('width','100%');
                                            },  
                                            width: 600,
                                            height: 300,              
                                            close: function(event, ui){
                                                    $('body').css('overflow','auto');
                                         } 
                                       }).dialog('open');                                                              
                                }    
                        },
        "html"
    );     
    
}


function recieve_new_uname (){
    $("#load_mesg").html('verifying if same user_name exist .....');
    $("#load").html('<img src="/static/images/My-Blog/1.gif" />');
    var uname =  document.getElementById("uname").value;
    var url = '/cgi-bin/My-Blog/core.pl?flag=' + 'VERIFY_USER_NAME_EXIST&' + 'uname=' + uname;   
    $.get(
         url,
         function(data, textStatus, jqXHR) {
	                        var ret = data.toString();
	                        if ( ret == '1'){
				    $("#load_mesg").html('<br><b>Choose another user_name as it is already used</b>');
				    $("#load").html('');
				}else{
				    var url = '/cgi-bin/My-Blog/core.pl?flag=' + 'SHOW_NEW_USER_REG_FORM&' + 'uname=' + uname;      
				    $.get(
					    url,
					    function(data, textStatus, jqXHR) {
						$("#init_form").html('');
						$("#load").html('');
						$("#load_mesg").html('');
				                $("#new_user_form").html(data);
					    },
					    "html"
					);    
				
				}
				
				
                        },
        "text"
    );     
}

function recieve_register_form (uname) {
   
    $("#from_load").html('<img src="/static/images/My-Blog/1.gif" />');
    var form_params = $("#new_user_form_reg1").serialize();
    form_params = form_params + '&uname=' + uname;
    var url = '/cgi-bin/My-Blog/core.pl?flag=' + 'REGISTER_THIS_USER&' + form_params;
    $.get(
         url,
         function(data, textStatus, jqXHR) {
                                $("#new_user_form_reg1").html('');
				$("#reg_mesg").html(data);
			    
                        },
        "html"
    );    
    
    
}

