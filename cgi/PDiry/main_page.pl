#!perl

BEGIN {
   
   push @INC, "./lib";  
};

use DBI;
use CGI;
require 'debug.pl';
use CGI qw(:all -utf8);
use warnings;
use CGI::Session;
use strict;
use Template;
use CGI::Carp qw(fatalsToBrowser);
use Myvars;
my $LoginHeader = {
                        
                        -title => 'WEB My Blog',
                        -style=>[ 
                                       { -type =>'text/css', -src=>'/static/styles/My-Blog/bootstrap.css'},
                                       { -type =>'text/css', -src=>'/static/styles/My-Blog/bootstrap-responsive.css'},
                                       { -type =>'text/css', -src=>'/static/styles/My-Blog/b1.css'},
                                       { -type =>'text/css', -src=>'/static/styles/My-Blog/jquery-ui-1.8.18.custom.css'},
                                    ],  
                         -script=>[
                                        { -type => 'text/javascript', -src => '/static/js/My-Blog/jquery.min.js'},
                                        { -type => 'text/javascript', -src => '/static/js/My-Blog/jquery.js'},
                                        { -type => 'text/javascript', -src => '/static/js/My-Blog/bootstrap.js'},
                                        { -type => 'text/javascript', -src => '/static/js/My-Blog/dispatch.js'},
                                        { -type => 'text/javascript', -src => '/static/js/My-Blog/jquery.ui.core.js' },
                                        { -type => 'text/javascript', -src => '/static/js/My-Blog/jquery-ui-1.8.18.custom.min.js' },
                                        { -type => 'text/javascript', -src => '/static/js/My-Blog/pre_logout.js'},
                                        { -type => 'text/javascript', -src => '/static/js/My-Blog/dispatch.js'},
                                     ],
                    };

our $H1;
our $H2;
my  @H3;

my $cgi = new CGI;
$cgi->autoEscape(undef);
my ($user_name,$role) = is_valid_user($cgi);

print $cgi->header(-type=>"text/html", -charset=>"UTF-8");

print $cgi->start_html($LoginHeader);
$H1 =~ s/%NAME%/$user_name/g;
print $H1;

my @main_page_info = get_main_page_info ();

@H3 =  @main_page_info;
my $out1;
my $elements = @H3;
my $loop = $elements/6;
my $remainder = $elements % 6;

if ( $remainder ){
   $loop++ ;
}

my ($from, $to)  = ( 0, 5);

foreach my $i (0 .. $loop - 1){
   my @h1 = @H3[$from..$to];
   my $data = {
      info => \@h1 
   };
   my $tt = Template->new;
        $tt->process('main_page.html', $data ,\$out1)
        || die $tt->error;
   print $out1;
   undef $out1;
   $from = $from + 6;
   $to = $to + 6 ;
}

print $cgi->end_html;