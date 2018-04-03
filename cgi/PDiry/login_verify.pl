#!perl
use DBI;
use CGI;
use Digest::MD5 qw(md5 md5_hex md5_base64);
require 'debug.pl';
use warnings;
use CGI::Session;
use strict;
use POSIX qw/strftime/;

BEGIN {
   push @INC, "./lib";  
   binmode(STDIN);                       # Form data
   binmode(STDOUT, ':encoding(UTF-8)');  # HTML
   binmode(STDERR, ':encoding(UTF-8)');  # Error messages
}


use DBModule;
our $db_exec;

my $cgi = new CGI;
use CGI qw(:all -utf8);
my %params = $cgi->Vars;
my $session = new CGI::Session(undef, $cgi, undef);
my $sid = $session->id;

my $cookie = $cgi->cookie(
                            -name=>'CGISESSID',
                            -value=>$sid,
                            -expires=>'+4h',
                        );

$cgi->autoEscape(undef);
my $uname = $cgi->param('usr_name');
my $passwd = $cgi->param('passwd');
my $page = $cgi->param ('page');

if (is_uname_exist ( $uname )){
    $session->clear;
    $session->delete();
    print $cgi->redirect(-cookie=>$cookie,-location=>"/cgi-bin/PDiry/login.pl?status=no_such_userexist");   

}
 
my $sql = "SELECT user_role FROM login_info WHERE user_email=?;";
my $qh = $db_exec->prepare ($sql);
$qh->execute($uname);
my $user_role = $qh->fetchrow_array;

$sql = "SELECT user_passwd FROM login_info WHERE user_email=?;";
$qh = $db_exec->prepare ($sql);
$qh->execute($uname);
my $user_passwd = $qh->fetchrow_array;
$passwd = md5_hex ($passwd);
if ( "$user_passwd" eq "$passwd" ){
    $session->param('usr_name',$uname);
    $session->param('role', $user_role);
    $sql = "SELECT uid FROM login_info WHERE user_email=?;";
    $qh = $db_exec->prepare ($sql);
    $qh->execute($uname);
    my $uid = $qh->fetchrow_array;
    $session->param('uid', $uid);
    my $logged_time = strftime('%Y-%m-%d %H:%M:%S',localtime);
    if ( $page eq 'admin' ){
         if ( $user_role == 1 ){
            $session->clear;
            $session->delete();
            print $cgi->redirect(-cookie=>$cookie,-location=>"/cgi-bin/PDiry/login.pl?status=not_admin");  
         }
    }
    $sql = "insert into t_persession (sid , uid ,o_count, logged_time,is_logged_in, is_logged_out)
            values (\'$sid\' ,  \'$uid\'  , '0'   ,    \'$logged_time\',   '1',   '0')";
    $qh = $db_exec->prepare ($sql);
    $qh->execute();
   if ( $page ne 'admin' ){
      print $cgi->redirect(-cookie=>$cookie,-location=>"/cgi-bin/PDiry/index.pl");
   }else{
      print $cgi->redirect(-cookie=>$cookie,-location=>"/cgi-bin/PDiry/index.pl?AppParam=ADMIN_PAGE");
   }
}else{
    $session->clear;
    $session->delete();
    print $cgi->redirect(-cookie=>$cookie,-location=>"/cgi-bin/PDiry/login.pl?status=error");
}

