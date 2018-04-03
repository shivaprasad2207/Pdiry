#!perl

BEGIN {
   push @INC, "./lib";  
}
use warnings;
use strict;
use POSIX qw/strftime/;
use CGI;
use CGI::Carp qw(fatalsToBrowser);
require CGI::Session;
use Data::Dumper;
use lib::DB_OBJ;
use Template;

sub is_valid_user {
    my ($cgi) = @_;
    my $sid = $cgi->cookie('CGISESSID');
    if ($sid){
        my $session = CGI::Session->new( $sid );
        my $name = $session->param("usr_name");
        my $role = $session->param("role");
        return ($name,$role);
    }else {
        my $cookie = $cgi->cookie(
                            -name=>'CGISESSID',
                            -value=>$sid,
                            -expires=>'-1d',
                        );
        print $cgi->redirect(-cookie=>$cookie,-location=>"login.pl?status=Alogout"); 
        return;    
    }
}

sub is_user_authorised{
   my  ( $user_name , $user_passwd ) = @_;
   if ( user_authentication ( $user_name , $user_passwd )){
      return 1;   
   }else{
      return 0;
   }
}


sub get_all_project_data {
    my @projects = get_all_project_data_from_db ();
    return @projects;
}

sub is_uname_exist {
    my ( $uname ) = @_;
    my $ret = is_uname_exist_in_db ( $uname);  
    return $ret;
}


sub get_project_info_by_proj_id {
         my( $proj_id ) = @_ ;
         my %project_info = get_project_info_by_proj_id_from_db ( $proj_id );
         return %project_info;
} 

sub get_all_instances_of_proj {
   my ( $proj_id ) = @_;
   my @insta_info = get_all_instances_of_proj_from_db ( $proj_id );
   return @insta_info;
}

sub get_all_compos_of_instance {
   my ( $insta_id) = @_;
   my @compos = get_all_compos_of_instance_from_db ( $insta_id );
   return @compos;
}

########################### PROJECT RELATED #########################
sub add_new_project {
   my ($proj_name,$proj_desc,$cgi) = @_;
   my ($uid , $time) = get_uid_and_time ( $cgi);
   my $sql = "insert into projects ( project_name , project_desc , is_active, time, uid )
                    values (\'$proj_name\' , \'$proj_desc\'  ,  \'1\' , \'$time\', \'$uid\');";
   my $ret = my_sql_exec ($sql);
   return $ret;
}

sub delete_project {
   my ($proj_id, $proj_name, $cgi) = @_;
   my ($uid , $time) = get_uid_and_time ( $cgi);
   my $sql = "update projects set is_active=\'0\', time=\'$time\',uid=\'$uid\' where project_name=\'$proj_name\' and project_id=\'$proj_id\';";
   my $ret = my_sql_exec ($sql);
   return $ret;
}


sub  modify_project_name {
   my ($proj_name,$proj_id, $cgi) = @_;
   my ($uid , $time) = get_uid_and_time ( $cgi);
   my $sql = "update projects set project_name=\'$proj_name\' , time=\'$time\',uid=\'$uid\' where project_id=\'$proj_id\';";
   my $ret = my_sql_exec ($sql);
   return $ret;
}
######################### INSTANCE RELATED ##################

sub add_new_instance_of_proj {
   my ($insta_name , $proj_id, $cgi ) = @_;
   my ($uid , $time) = get_uid_and_time ( $cgi);
   my $sql = "insert into instances ( project_id , insta_name , is_active, time, uid)
                    values (\'$proj_id\' , \'$insta_name\'  ,  \'1\' , \'$time\', \'$uid\');";
   my $ret = my_sql_exec ($sql);
   return $ret;
}

sub modify_porj_insta_name {
   my ( $new_insta_name, $insta_id , $cgi ) = @_;
   my ($uid , $time) = get_uid_and_time ( $cgi);
   my $sql = "update  instances set insta_name=\'$new_insta_name\' , time=\'$time\',uid=\'$uid\' where insta_id=\'$insta_id\';";
   my $ret = my_sql_exec ($sql);
   return $ret;
}

sub delete_insta_name {
   my ($insta_id , $cgi) = @_;
   my ($uid , $time) = get_uid_and_time ( $cgi);
   my $sql = "update  instances set is_active=\'0\' , time=\'$time\',uid=\'$uid\'  where insta_id=\'$insta_id\';";
   my $ret = my_sql_exec ($sql);
   return $ret;
}

######################### COMPONENT RELATED ##################

sub add_new_component{
   my ($insta_id,$type,$host_name,$ip,$user,$passwd,$comment,$cgi ) = @_;
   my ($uid , $time) = get_uid_and_time ( $cgi);
   my $sql = "insert into components ( insta_id , host_name , ip, user, type, password, Comments, is_active,time,uid)
                    values (\'$insta_id\', \'$host_name\', \'$ip\', \'$user\', \'$type\', \'$passwd\',\'$comment\', \'1\', \'$time\' , \'$uid\');";
   my $ret = my_sql_exec ($sql);
   return $ret;
}



sub get_comp_info_by_comp_id {
   my ($comp_id) = @_;
   my %comp_info = get_comp_info_by_comp_id_from_db ( $comp_id );
   return %comp_info;
}

sub exec_raw_sql{
   my( $sql ) = @_;
   my $ret = my_sql_exec ($sql);
   return $ret;  
}

sub get_insta_name_by_insta_id {
   my ( $insta_id ) = @_;
   my $insta_name = get_insta_name_by_insta_id_from_db ( $insta_id ) ;
   return $insta_name;
}

sub get_passwd_by_comp_id {
   my( $comp_id ) = @_;
   my $passwd =  get_passwd_by_comp_id_from_db ( $comp_id);
   return $passwd;
}

sub get_uid_and_time {
   my ($cgi) = @_;
   my $time = strftime('%Y-%m-%d %H:%M:%S',localtime);
   my $sid = $cgi->cookie('CGISESSID');
   my $session = CGI::Session->new( $sid );
   my $uid = $session->param("uid");
   return ($uid,$time);
}

###################### ADMIN RELATED ######################

sub get_all_user_info{
    my @user_info = get_all_user_info_from_db ();
    return @user_info;
}



sub create_book_tag_string {
         my $length_of_randomstring=shift;
         my @chars=('A'..'Z','0'..'9');
         my $random_string;
         foreach (1..$length_of_randomstring){
		$random_string.=$chars[rand @chars];
	}
	return $random_string;
}



sub get_user_specific_info {
   my ( $id_x, $term ) = @_;
   my ( @ret ,@ings);
   
   if ( $id_x =~ /uname/){ 
      @ret = get_all_login_names_from_db ();
      @ings  = grep {/$term/} @ret;
   }elsif ( $id_x =~ /fname/){ 
      @ret = get_all_login_fnames_from_db ();
      @ings  = grep {/$term/} @ret;
   }elsif ( $id_x =~ /lname/){ 
     @ret = get_all_login_lnames_from_db ();
     @ings  = grep {/$term/} @ret;
   }elsif ( $id_x =~ /adress/){ 
     @ret = get_all_login_adress_from_db ();
     @ings  = grep {/$term/} @ret;
   }elsif ( $id_x =~ /dadress/){ 
     @ret = get_all_login_dadress_from_db ();
     @ings  = grep {/$term/} @ret;
   }elsif ( $id_x =~ /phone/){ 
     @ret = get_all_login_phones_from_db ();
     @ings  = grep {/$term/} @ret;
   }elsif ( $id_x =~ /email/){ 
     @ret = get_all_login_emails_from_db ();
     @ings  = grep {/$term/} @ret;
   }
   return @ings;     
}


sub local_my_get_style(){

my $style =<<"EOT";
 
.new_css {
    border: 1px solid #006;
    background: #ffc;
}
.new_css:hover {
    border: 1px solid #f00;
    background: #ff6;
}

.button {
    border: none;
    background: url('/forms/up.png') no-repeat top left;
    padding: 2px 8px;
}
.button:hover {
    border: none;
    background: url('/forms/down.png') no-repeat top left;
    padding: 2px 8px;
}
label {
    display: block;
    width: 150px;
    float: left;
    margin: 2px 4px 6px 4px;
    text-align: right;
}
br { clear: left; } 

   
EOT

return $style;

}



1
;