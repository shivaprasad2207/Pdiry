#!perl

BEGIN {
   push @INC, "./lib";  
}


use warnings;
use strict;
use CGI;
require CGI::Session;
use Digest::MD5 qw(md5 md5_hex md5_base64);
use Data::Dumper;
require ("debug.pl");
use CGI::Carp qw(fatalsToBrowser);
use JSON;
our  $MainPageHeader;
use Time::Local;
use Date::Manip;

my $cgi = CGI::new();
my $flag = $cgi->param('flag');

if ( $flag eq 'SHOW_INSTA_COMP' ){
   
   my ($user_name,$role) = is_valid_user($cgi); 
   my $insta_id = $cgi->param('insta_id');
   my $t = $insta_id;
   $t =~ /__PROJ_ID__(.*)__INSTA_ID__(.*)__INSTA_NAME__(.*)/;
   my $proj_id = $1;
   $insta_id = $2;
   my $insta_name = $3;
   my $link_go_to = '
               <br> <a href="index.pl?AppParam=GOTO_INSTA_PROJ&proj_id=__PROJ_ID__&insta_id=__INSTA_ID__&insta_name=__INSTA_NAME__">
                        &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp+ View __INSTA_NAME__ Environment 
                    </a>
               ';
   my $link_modify = '
               <a href="index.pl?AppParam=MODIFY_INSTA_PROJ&proj_id=__PROJ_ID__&insta_id=__INSTA_ID__&insta_name=__INSTA_NAME__">
                        &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp+ Modify __INSTA_NAME__ Name 
                    </a>
               ';
   my $link_del = '
               <a href="index.pl?AppParam=DEL_INSTA_PROJ&proj_id=__PROJ_ID__&insta_id=__INSTA_ID__&insta_name=__INSTA_NAME__">
                        &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp+ Delete Enviornment __INSTA_NAME__ Name 
                    </a><br>
               ';
    my $link_add_comp = '
               <a href="index.pl?AppParam=ADD_INSTA_COMPO_FORM&proj_id=__PROJ_ID__&insta_id=__INSTA_ID__&insta_name=__INSTA_NAME__">
                        &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp+ Add New Component in  __INSTA_NAME__ Name 
                    </a>
               ';
   my @links ;
   foreach my $link ($link_go_to,$link_modify,$link_del,$link_add_comp){
      $link =~ s/__INSTA_NAME__/$insta_name/g;
      $link =~ s/__PROJ_ID__/$proj_id/g;
      $link =~ s/__INSTA_ID__/$insta_id/g;
      push ( @links, $link);
   }
   print "Content-type: text/plain; charset=iso-8859-1\n\n";
   print @links;
}elsif ( $flag eq 'ADD_NEW_INSTA_OF_PROJ'){
   my $insta_name = $cgi->param('new_insta');
   my $proj_id = $cgi->param('proj_id');
  
   if  ( $insta_name !~ /^\w+$/ ){
         print "Content-type: text/plain; charset=iso-8859-1\n\n";
         print "0";
   }else{ 
      my $ret = add_new_instance_of_proj ($insta_name , $proj_id, $cgi );
      print "Content-type: text/plain; charset=iso-8859-1\n\n";
      print "1";
   }
}elsif ($flag eq 'MODIFY_COMP'){
   my $insta_id = $cgi->param('insta_id');
   my $comp_id = $cgi->param('comp_id');
   my $proj_id = $cgi->param('proj_id');
   my $field = $cgi->param('field');
   my %field_map_rw = (
         type => '<tr> <td> Type </td> <td> <input type="text" name="type" value="__TYPE__"> </td> </tr>',
         host_name => '<tr> <td> Host name </td> <td> <input type="text" name="host_name" value="__HOST_NAME__"> </td> </tr>',
         ip => '<tr> <td> Ip </td> <td> <input type="text" name="ip" value="__IP__"> </td> </tr>',
         user => '<tr> <td> User </td> <td> <input type="text" name="user" value="__USER__"> </td> </tr>',
         password => '<tr> <td> Password </td> <td> <input type="text" name="password" value="__PASSWD__"> </td> </tr>',
         Comments => '<tr> <td> Comments </td> <td> <input type="text" name="Comments" value="__CMNTS__"> </td> </tr>',
   );
   my %field_map_ro = (
         type => '<tr> <td> Type </td> <td> <input type="text" name="type" value="__TYPE__" readonly="readonly"> </td> </tr>',
         host_name => '<tr> <td> Host name </td> <td> <input type="text" name="host_name" value="__HOST_NAME__" readonly="readonly"> </td> </tr>',
         ip => '<tr> <td> Ip </td> <td> <input type="text" name="ip" value="__IP__" readonly="readonly"> </td> </tr>',
         user => '<tr> <td> User </td> <td> <input type="text" name="user" value="__USER__" readonly="readonly"> </td> </tr>',
         password => '<tr> <td> Password </td> <td> <input type="text" name="password" value="__PASSWD__" readonly="readonly"> </td> </tr>',
         Comments => '<tr> <td> Comments </td> <td> <input type="text" name="Comments" value="__CMNTS__" readonly="readonly"> </td> </tr>',
   );
   $field_map_ro{$field} = $field_map_rw{$field};
   
   my $html = '<form id="mod_comp_form" action="#">' . '<table border="2px" cellspacing="4px"
                                                style="position:relative;left:22px;padding:5px;margin:2px" cellpadding="2px" >';
   my @rows = values (%field_map_ro);
   my $line = join '',@rows;
   my $last_line = '<tr> <td colspan="2">
                                          &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                                          <input type="submit" name="update" value="Update"
                                          onclick="javascript:modify_comp_info( );return false;">
                                          <input type="hidden" name="insta_id" value="__INSTA_ID__">
                                          <input type="hidden" name="proj_id" value="__PROJ_ID__">
                                          <input type="hidden" name="comp_id" value="__COMP_ID__">
                                          <input type="hidden" name="field" value="__FIELD__">
                        </td> <tr>
                  </table> </form>';
   $html = $html . $line . $last_line;
   my %comp_info = get_comp_info_by_comp_id( $comp_id );
   $html =~ s/__TYPE__/$comp_info{type}/g;
   $html =~ s/__HOST_NAME__/$comp_info{host_name}/g;
   $html =~ s/__IP__/$comp_info{ip}/g;
   $html =~ s/__USER__/$comp_info{user}/g;
   $html =~ s/__PASSWD__/$comp_info{password}/g;
   $html =~ s/__CMNTS__/$comp_info{Comments}/g;
   
   $html =~ s/__INSTA_ID__/$insta_id/g;
   $html =~ s/__PROJ_ID__/$proj_id/g;
   $html =~ s/__COMP_ID__/$comp_id/g;
   $html =~ s/__FIELD__/$field/g;
   print "Content-type: text/plain; charset=iso-8859-1\n\n";
   print $html;  
}elsif ($flag eq 'DELETE_COMP'){
   my $insta_id = $cgi->param('insta_id');
   my $comp_id = $cgi->param('comp_id');
   my $proj_id = $cgi->param('proj_id');
  
   my %field_map_ro = (
         type => '<tr> <td> Type </td> <td> <input type="text" name="type" value="__TYPE__" readonly="readonly"> </td> </tr>',
         host_name => '<tr> <td> Host name </td> <td> <input type="text" name="host_name" value="__HOST_NAME__" readonly="readonly"> </td> </tr>',
         ip => '<tr> <td> Ip </td> <td> <input type="text" name="ip" value="__IP__" readonly="readonly"> </td> </tr>',
         user => '<tr> <td> User </td> <td> <input type="text" name="user" value="__USER__" readonly="readonly"> </td> </tr>',
         password => '<tr> <td> Password </td> <td> <input type="text" name="password" value="__PASSWD__" readonly="readonly"> </td> </tr>',
         Comments => '<tr> <td> Comments </td> <td> <input type="text" name="Comments" value="__CMNTS__" readonly="readonly"> </td> </tr>',
   );

   
   my $html = '<b> Confirm below details to be Deleted </b> <br>
                     <form id="del_comp_form" action="#">' . '<table border="2px" cellspacing="4px"
                                                style="position:relative;left:22px;padding:5px;margin:2px" cellpadding="2px" >';
   my @rows = values (%field_map_ro);
   my $line = join '',@rows;
   my $last_line = '<tr> <td colspan="2" align="center">
                                          
                                          <br><input type="submit" name="Delete" value="Delete"
                                          onclick="javascript:deleted_comp_info( );return false;">
                                          <input type="hidden" name="insta_id" value="__INSTA_ID__">
                                          <input type="hidden" name="proj_id" value="__PROJ_ID__">
                                          <input type="hidden" name="comp_id" value="__COMP_ID__">
                                          <input type="hidden" name="field" value="__FIELD__">
                                          <br>
                        </td> <tr>
                  </table> </form>';
   $html = $html . $line . $last_line;
   my %comp_info = get_comp_info_by_comp_id( $comp_id );
   $html =~ s/__TYPE__/$comp_info{type}/g;
   $html =~ s/__HOST_NAME__/$comp_info{host_name}/g;
   $html =~ s/__IP__/$comp_info{ip}/g;
   $html =~ s/__USER__/$comp_info{user}/g;
   $html =~ s/__PASSWD__/$comp_info{password}/g;
   $html =~ s/__CMNTS__/$comp_info{Comments}/g;
   
   $html =~ s/__INSTA_ID__/$insta_id/g;
   $html =~ s/__PROJ_ID__/$proj_id/g;
   $html =~ s/__COMP_ID__/$comp_id/g;
   print "Content-type: text/plain; charset=iso-8859-1\n\n";
   print $html;  
}elsif ($flag eq 'MODIFIED_COMP_INFO'){
      my $proj_id = $cgi->param('proj_id');
      my $insta_id = $cgi->param('insta_id');
      my $comp_id = $cgi->param('comp_id');
      my $field = $cgi->param('field');
      my $field_val = $cgi->param($field);
      my ($uid , $time) = get_uid_and_time ( $cgi);
      my $sql = "update components set $field=\'$field_val\', time=\'$time\',uid=\'$uid\' where comp_id=\'$comp_id\';";
      my $ret = exec_raw_sql ( $sql );
      my $insta_name = get_insta_name_by_insta_id ( $insta_id );
      my $url = "index.pl?AppParam=GOTO_INSTA_PROJ&proj_id=$proj_id&insta_id=$insta_id&insta_name=$insta_name";
      print "Content-type: text/plain; charset=iso-8859-1\n\n";
      print $url;
}elsif ($flag eq 'DELTED_COMP_INFO'){
      my $proj_id = $cgi->param('proj_id');
      my $insta_id = $cgi->param('insta_id');
      my $comp_id = $cgi->param('comp_id');
      my ($uid , $time) = get_uid_and_time ( $cgi);
      my $sql = "update components set is_active=\'0\' , time=\'$time\',uid=\'$uid\' where comp_id=\'$comp_id\';";
      my $ret = exec_raw_sql ( $sql );
      my $insta_name = get_insta_name_by_insta_id ( $insta_id );
      my $url = "index.pl?AppParam=GOTO_INSTA_PROJ&proj_id=$proj_id&insta_id=$insta_id&insta_name=$insta_name";
      print "Content-type: text/plain; charset=iso-8859-1\n\n";
      print $url;
}elsif ($flag eq 'GET_PASSWD'){
      my $comp_id = $cgi->param('comp_id');
      my $passwd = get_passwd_by_comp_id ( $comp_id );
      print "Content-type: text/plain; charset=iso-8859-1\n\n";
      print "<br><br><br><br><font color=\"green\"> <b>Password : &nbsp&nbsp&nbsp  $passwd </b> </font>" ;
}elsif ($flag eq 'SHOW_SENT_MSG'){
   my $uname = $cgi->param('uname');
   my $msg_id = $cgi->param('msg_id');
   my %data = get_sent_message_by_msg_id ( $msg_id, $uname );
   $data{from_s} =~ s/^\s+//; $data{from_s} =~ s/\s+$//;
    
    my $out = '';
    my $tt = Template->new;
        $tt->process('msg_open_sent_item_in_dialog.html', \%data, \$out)
        || die $tt->error;
    print $out;
}elsif ($flag eq 'DEL_SENT_MSG_MARKED'){
      my $msg_ids = $cgi->param('msg_ids');
      my $uname = $cgi->param('uname');
      $msg_ids =~ s/checkbox_//g;
      my @arr_msg_ids = split ':',$msg_ids;
      foreach my $msg_id (@arr_msg_ids){
        my $ret = delete_sent_message_by_msg_id ( $msg_id, $uname );
      }
      print "Content-type: text/plain; charset=iso-8859-1\n\n";
      print '<b><font color="green"> Message Sent Successfully</font></b>';
}elsif ($flag eq 'ADD_NEW_USER'){
   my $uname = $cgi->param('email');
   my $passwd = $cgi->param('passwd');
   $uname =~ s/^\s+//; $uname =~ s/\s+$//;
   $passwd = md5_hex ($passwd);
   my $sql = "insert login_info (user_passwd, user_email, user_role, is_active) values ( \'$passwd\' ,\'$uname\', \'1\', \'1\');";
   my $ret = exec_raw_sql ( $sql );
   print "Content-type: text/plain; charset=iso-8859-1\n\n";
   print "<b><font color=\"green\"> User  $uname is added Successfully</font></b>";
}elsif ($flag eq 'PROMOTE_USER'){
   my $uname = $cgi->param('email');
   my $uid = $cgi->param('uid');
   $uname =~ s/^\s+//; $uname =~ s/\s+$//;
   my $sql = "update login_info set user_role=\'0\' where uid=\'$uid\';";
   my $ret = exec_raw_sql ( $sql );
   print "Content-type: text/plain; charset=iso-8859-1\n\n";
   print "<b><font color=\"green\"> User  $uname is promoted with Admin privilages</font></b>";
}elsif ($flag eq 'DE_PROMOTE_USER'){
   my $uname = $cgi->param('email');
   my $uid = $cgi->param('uid');
   $uname =~ s/^\s+//; $uname =~ s/\s+$//;
   my $sql = "update login_info set user_role=\'1\' where uid=\'$uid\';";
   my $ret = exec_raw_sql ( $sql );
   print "Content-type: text/plain; charset=iso-8859-1\n\n";
   print "<b><font color=\"green\"> User  $uname is depromoted from Admin privilages</font></b>";
}elsif ($flag eq 'DELETE_USER'){
   my $uname = $cgi->param('email');
   my $uid = $cgi->param('uid');
   $uname =~ s/^\s+//; $uname =~ s/\s+$//;
   my $sql = "update login_info set is_active=\'0\' where uid=\'$uid\';";
   my $ret = exec_raw_sql ( $sql );
   print "Content-type: text/plain; charset=iso-8859-1\n\n";
   print "<b><font color=\"green\"> User account $uname is deleted</font></b>";
}elsif ($flag eq 'PASSWD_CH'){
   my $passwd = $cgi->param('passwd');
   my $uid = $cgi->param('uid');
   $passwd = md5_hex ($passwd);
   my $sql = "update login_info set user_passwd=\'$passwd\' where uid=\'$uid\';";
   my $ret = exec_raw_sql ( $sql );
   print "Content-type: text/plain; charset=iso-8859-1\n\n";
   print "<b><font color=\"green\"> Password is changed</font></b>";
}elsif ($flag eq 'SEND_PASSWD_CH_MSG'){
   print "Content-type: text/plain; charset=iso-8859-1\n\n";
   print "<br><br><b><font color=\"green\"> Find Password change link in Home Page\'s Side Tab\'s </font></b>";
}elsif ($flag eq 'RESET_PASSWD'){
   my $uname = $cgi->param('email');
   my $uid = $cgi->param('uid');
   my $passwd = md5_hex ('welcome');
   $uname =~ s/^\s+//; $uname =~ s/\s+$//;
   my $sql = "update login_info set user_passwd=\'$passwd\' where uid=\'$uid\';";
   my $ret = exec_raw_sql ( $sql );
   print "Content-type: text/plain; charset=iso-8859-1\n\n";
   print "<b><font color=\"green\"> Password is set as \'welcome\' for user $uname.</font></b>";
}
   
   

1
;