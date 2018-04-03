#!perl

BEGIN {
   binmode(STDIN);                       # Form data
   binmode(STDOUT, ':encoding(UTF-8)');  # HTML
   binmode(STDERR, ':encoding(UTF-8)');  # Error messages
}


use DBI;
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use warnings;
use CGI::Session;
use strict;
use Template;

my $LoginHeader = {
                        
                        -title => 'PDirectory',
                        -style=>[ 
                                       { -type =>'text/css', -src=>'/static/styles/PDiry/body.css'},
                                       { -type =>'text/css', -src=>'/static/styles/PDiry/bootstrap.css'},
                                       { -type =>'text/css', -src=>'/static/styles/PDiry/bootstrap-responsive.css'},
                                       { -type =>'text/css', -src=>'/static/styles/PDiry/jquery-ui-1.8.18.custom.css'},
                                      
                                    ],  
                         -script=>[
                                        { -type => 'text/javascript', -src => '/static/js/PDiry/jquery.js'},
                                        { -type => 'text/javascript', -src => '/static/js/PDiry/jquery.min.js' },
                                        { -type => 'text/javascript', -src => '/static/js/PDiry/pre_logout.js' },
                                        { -type => 'text/javascript', -src => '/static/js/PDiry/bootstrap.js'},
                                     ],
                    };




my $cgi = new CGI;
$cgi->autoEscape(undef);
print $cgi->header(-type=>"text/html", -charset=>"UTF-8");

print $cgi->start_html($LoginHeader); 

if ($cgi->param('status') eq 'jslogout'){
    my $sid = $cgi->param('sid');
    my $cookie = $cgi->cookie(
                            -name=>'CGISESSID',
                            -value=>$sid,
                            -expires=>'-1d',
                        );
     $cgi->redirect(-cookie=>$cookie,-location=>"admin_login.pl?status=logout"); 
}

my $out;
     my $tt = Template->new;
     $tt->process('admin_login.html', undef, \$out)
        || die $tt->error; 

print $out;


print '<div style="bottom:0px; float:right">
						<SMALL style="bottom:0px;float:inherit;color:#BC8F8F">
						      Web Site Copyright © Authored by Global Foundries<br>
						      
						</SMALL>
          </div>'; 
   
print $cgi->end_html;