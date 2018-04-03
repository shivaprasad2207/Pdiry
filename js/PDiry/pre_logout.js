
function add_new_user (){
    var form_params = $("#add_new_user").serialize();
    $("#msg").html('<img src="/static/images/PDiry/1.gif" />');
    var url = '/cgi-bin/PDiry/core.pl?flag=ADD_NEW_USER&' + form_params;
    $.get(
            url,
            function(data, textStatus, jqXHR) {
				var components =  data.toString();
				$("#form_area").html('');
				$("#msg").html(data);
                        },
            "html"
        );    
}

function select_promote_user() {
    var mySelectList = document.getElementById("select_usr");  
    var email = mySelectList.options[mySelectList.selectedIndex].value;
    email = email.split("___");
    document.getElementById("promoted_user").value = email[0];
    document.getElementById("promoted_user_id").value = email[1];
    $("#promote_button").css("visibility", "visible");  
}

function select_depromote_user() {
    var mySelectList = document.getElementById("select_usr");  
    var email = mySelectList.options[mySelectList.selectedIndex].value;
    email = email.split("___");
    document.getElementById("promoted_user").value = email[0];
    document.getElementById("promoted_user_id").value = email[1];
    $("#promote_button").css("visibility", "visible");  
}

function select_delete_user() {
    var mySelectList = document.getElementById("select_usr");  
    var email = mySelectList.options[mySelectList.selectedIndex].value;
    email = email.split("___");
    document.getElementById("promoted_user").value = email[0];
    document.getElementById("promoted_user_id").value = email[1];
    $("#promote_button").css("visibility", "visible");  
}

function promote_user () {
    $("#msg").html('<img src="/static/images/PDiry/1.gif" />');
    var email = document.getElementById("promoted_user").value;
    var uid = document.getElementById("promoted_user_id").value;
     var url = '/cgi-bin/PDiry/core.pl?flag=PROMOTE_USER&email=' + email+ '&uid=' + uid;
    $.get(
            url,
            function(data, textStatus, jqXHR) {
				var components =  data.toString();
				$("#form_area").html('');
				$("#msg").html(data);
                        },
            "html"
        );    
}

function reset_passwd () {
    $("#msg").html('<img src="/static/images/PDiry/1.gif" />');
    var email = document.getElementById("promoted_user").value;
    var uid = document.getElementById("promoted_user_id").value;
     var url = '/cgi-bin/PDiry/core.pl?flag=RESET_PASSWD&email=' + email+ '&uid=' + uid;
    $.get(
            url,
            function(data, textStatus, jqXHR) {
				var components =  data.toString();
				$("#form_area").html('');
				$("#msg").html(data);
                        },
            "html"
        );    
}

function depromote_user () {
    $("#msg").html('<img src="/static/images/PDiry/1.gif" />');
    var email = document.getElementById("promoted_user").value;
    var uid = document.getElementById("promoted_user_id").value;
     var url = '/cgi-bin/PDiry/core.pl?flag=DE_PROMOTE_USER&email=' + email+ '&uid=' + uid;
    $.get(
            url,
            function(data, textStatus, jqXHR) {
				var components =  data.toString();
				$("#form_area").html('');
				$("#msg").html(data);
                        },
            "html"
        );    
}

function delete_user () {
    $("#msg").html('<img src="/static/images/PDiry/1.gif" />');
    var email = document.getElementById("promoted_user").value;
    var uid = document.getElementById("promoted_user_id").value;
     var url = '/cgi-bin/PDiry/core.pl?flag=DELETE_USER&email=' + email+ '&uid=' + uid;
    $.get(
            url,
            function(data, textStatus, jqXHR) {
				var components =  data.toString();
				$("#form_area").html('');
				$("#msg").html(data);
                        },
            "html"
        );    
}

function ch_passwd (){
        $("#resp").html('<img src="/static/images/PDiry/1.gif" />');
	var passwd1 = document.getElementById("passwd1").value;
	var passwd2 = document.getElementById("passwd2").value;
	var uid = document.getElementById("uid").value;
	if ( passwd1 == passwd2){ 
	    var url = '/cgi-bin/PDiry/core.pl?flag=PASSWD_CH&passwd='+passwd1+'&uid='+uid;
	    $.get(
		url,
		function(data, textStatus, jqXHR) {
				var components =  data.toString();
				$("#resp").html('');
				$("#disp").html(data);
                        },
		"html"
	    );
	}else{
	    $("#resp").html('');
	    alert ( 'Both Password do not match');
	}
}

function passwd_change_msg (){
    $("local_dialog_box").html('');
    $("#p_load").html('<img src="/static/images/PDiry/1.gif" />');
    var url = '/cgi-bin/PDiry/core.pl?flag=SEND_PASSWD_CH_MSG' ;
    var tag = $('<div  id="local_dialog_box" style="overflow:scroll"> </div>');
    var title = '<b style="\
                                                    background-image:url(/static/images/PDiry/oinfo_title_bar.png); \
                                                    height:15px; \
                                                    width:200px; color:white;padding:0px"> \
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    Password Change \
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
		       $("#p_load").html('');
                       tag.html(data).dialog({
                                modal: true,
                                title: title,
                                open: function(event, ui) {  
                                        $('.ui-dialog-titlebar-close')
                                        .removeClass("ui-dialog-titlebar-close")
                                        .html('<img src="/static/images/PDiry/closebutton.png" width="25" height="25" style="padding:1px">');
                                        $('.ui-widget-overlay').css('width','100%');
                                },  
				width: 600,
                                height: 300,              
                                close: function(event, ui){
                                                    $('body').css('overflow','auto');
						    $("#load").html('');						    
                                       } 
                               
                              }).dialog('open');                
	 }
       }); 
}

function option_handler() {
    
    var mySelectList = document.getElementById("instance");  
    var result = mySelectList.options[mySelectList.selectedIndex].value;
    $("#insta_load").html('');
    $("#insta_prop").html('');
    $("#comp_disp").remove();
    $("#insta_load").html('<img src="/static/images/PDiry/1.gif" />');
    var url = '/cgi-bin/PDiry/core.pl?flag=SHOW_INSTA_COMP&insta_id='+ result;
         $.get(
            url,
            function(data, textStatus, jqXHR) {
				var components =  data.toString();
				$("#insta_load").html('');
		                $("#insta_prop").html('');
		                $("#insta_prop").html(data);
			    
                        },
            "html"
        );    
}

function clear_disp_area (){
    $("#disp").html('');
}


function modify_comp ( field, comp_id, proj_id, insta_id ){
    $("#load").html('<img src="/static/images/PDiry/1.gif" />');
    var url = '/cgi-bin/PDiry/core.pl?flag=MODIFY_COMP&insta_id='+insta_id+'&comp_id='+comp_id+'&proj_id='+proj_id+'&field='+field ;
    var tag = $('<div  id="local_dialog_box" style="overflow:scroll"> </div>');
    var title = '<b style="\
                                                    background-image:url(/static/images/PDiry/oinfo_title_bar.png); \
                                                    height:15px; \
                                                    width:200px; color:white;padding:0px"> \
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    Modify Info \
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
                       tag.html(data).dialog({
                                modal: true,
                                title: title,
                                open: function(event, ui) {  
                                        $('.ui-dialog-titlebar-close')
                                        .removeClass("ui-dialog-titlebar-close")
                                        .html('<img src="/static/images/PDiry/closebutton.png" width="25" height="25" style="padding:1px">');
                                        $('.ui-widget-overlay').css('width','100%');
                                },  
				width: 550,
                                height: 450,              
                                close: function(event, ui){
                                                    $('body').css('overflow','auto');
						    $("#load").html('');						    
                                       } 
                               
                              }).dialog('open');                
	 }
       }); 
}

function modify_comp_info (){
    var form_params = $("#mod_comp_form").serialize();
    $("#local_dialog_box").remove();
    var url = '/cgi-bin/PDiry/core.pl?flag=MODIFIED_COMP_INFO&'+form_params ;
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
		       var url =  data.toString();
		       $("#load").html('');
		       $("#local_dialog_box").remove();                       
		       window.location = url;              
	 }
       }); 
}


function delete_comp ( comp_id, proj_id, insta_id ){
    $("#load").html('<img src="/static/images/PDiry/1.gif" />');
    var url = '/cgi-bin/PDiry/core.pl?flag=DELETE_COMP&insta_id='+insta_id+'&comp_id='+comp_id+'&proj_id='+proj_id ;
    var tag = $('<div  id="local_dialog_box" style="overflow:scroll"> </div>');
    var title = '<b style="\
                                                    background-image:url(/static/images/PDiry/oinfo_title_bar.png); \
                                                    height:15px; \
                                                    width:200px; color:white;padding:0px"> \
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    Delete Confirm \
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
                       tag.html(data).dialog({
                                modal: true,
                                title: title,
                                open: function(event, ui) {  
                                        $('.ui-dialog-titlebar-close')
                                        .removeClass("ui-dialog-titlebar-close")
                                        .html('<img src="/static/images/PDiry/closebutton.png" width="25" height="25" style="padding:1px">');
                                        $('.ui-widget-overlay').css('width','100%');
                                },  
				width: 600,
                                height: 450,              
                                close: function(event, ui){
                                                    $('body').css('overflow','auto');
						    $("#load").html('');						    
                                       } 
                               
                              }).dialog('open');                
	 }
       }); 
}

function show_password ( comp_id ){
    
    $("#load").html('<img src="/static/images/PDiry/1.gif" />');
    $("#local_dialog_box").remove();
    var url = '/cgi-bin/PDiry/core.pl?flag=GET_PASSWD&comp_id='+comp_id ;
    var tag = $('<div  id="local_dialog_box" style="overflow:scroll"> </div>');
    var title = '<b style="\
                                                    background-image:url(/static/images/PDiry/oinfo_title_bar.png); \
                                                    height:15px; \
                                                    width:200px; color:white;padding:0px"> \
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\
                                                    Password  \
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
                       tag.html(data).dialog({
                                modal: true,
                                title: title,
                                open: function(event, ui) {  
                                        $('.ui-dialog-titlebar-close')
                                        .removeClass("ui-dialog-titlebar-close")
                                        .html('<img src="/static/images/PDiry/closebutton.png" width="25" height="25" style="padding:1px">');
                                        $('.ui-widget-overlay').css('width','100%');
                                },  
				width: 600,
                                height: 300,              
                                close: function(event, ui){
                                                    $('body').css('overflow','auto');
						    $("#load").html('');						    
                                       } 
                               
                              }).dialog('open');                
	 }
       }); 
}


function deleted_comp_info (){
    var form_params = $("#del_comp_form").serialize();
    $("#local_dialog_box").remove();
    var url = '/cgi-bin/PDiry/core.pl?flag=DELTED_COMP_INFO&'+form_params ;
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
		       var url =  data.toString();
		       $("#load").html('');
		       $("#local_dialog_box").remove();                       
		       window.location = url;              
	 }
       }); 
}


function add_insta_of_project ( proj_name, proj_id){
    var form_params = $("#new_proj_insta").serialize();
    var url = '/cgi-bin/PDiry/core.pl?flag=ADD_NEW_INSTA_OF_PROJ&'+ form_params;
    var insta_name = document.getElementById("insta_name").value;
    var msg1 = 'New Environment ' + insta_name + ' ' + 'is added to Project ' + proj_name;
    var msg2 =  'Seems there are non-alphanumeric characters in new environment name';
    $.get(
            url,
            function(data, textStatus, jqXHR) {
				var ret =  data.toString();
				if ( ret == 1){
				    alert ( msg1 );
				     var url = '/cgi-bin/PDiry/index.pl?AppParam=INST_DISP&id='+ proj_id ;
				     window.location = url;
				}else {
				    alert ( msg2 );
				     var url = '/cgi-bin/PDiry/index.pl?AppParam=INST_DISP&id='+ proj_id ;
				     window.location = url;
				}
                        },
            "html"
        );    
   
}

function show_proj_page(){
        var mySelectList = document.getElementById("main_proj");  
        var proj = mySelectList.options[mySelectList.selectedIndex].value;
	var Tarray = proj.split("___O___");
        $("#disp").html('<img src="/static/images/PDiry/1.gif" />');
	var url = '/cgi-bin/PDiry/index.pl?AppParam=INST_DISP&id='+ Tarray[1]+'&proj='+Tarray[0];
	window.location = url;
}

function show_proj_delete_form(){
	var mySelectList = document.getElementById("main_proj");  
        var proj = mySelectList.options[mySelectList.selectedIndex].value;
	var Tarray = proj.split("___O___");
        $("#disp").html('<img src="/static/images/PDiry/1.gif" />');
	var url = '/cgi-bin/PDiry/index.pl?AppParam=SHOW_PROJ_DEL_FORM&id='+ Tarray[1]+'&proj='+Tarray[0];
	window.location = url;
}

function show_proj_modify_form() {
    var mySelectList = document.getElementById("main_proj");  
        var proj = mySelectList.options[mySelectList.selectedIndex].value;
	var Tarray = proj.split("___O___");
        $("#disp").html('<img src="/static/images/PDiry/1.gif" />');
	var url = '/cgi-bin/PDiry/index.pl?AppParam=SHOW_PROJ_MODIFY_FORM&id='+ Tarray[1]+'&proj='+Tarray[0];
	window.location = url;
}


function logout( sid ){
    var xmlhttp;
    var url = '/cgi-bin/PDiry/logout.pl?term=' + sid  + '&flag=' + 'logout';
    
    if (window.XMLHttpRequest){// code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp=new XMLHttpRequest();
    }else{// code for IE6, IE5
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlhttp.open("GET",url,false);
    xmlhttp.send();
    var ret = xmlhttp.responseText;
    window.location = '/cgi-bin/PDiry/login.pl?status=logout';
}
