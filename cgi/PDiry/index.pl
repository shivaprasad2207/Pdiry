#!perl
BEGIN {
   push @INC, "./lib";
   binmode(STDIN);                       # Form data
   binmode(STDOUT, ':encoding(UTF-8)');  # HTML
   binmode(STDERR, ':encoding(UTF-8)');  # Error messages
}

use CGI;
use CGI qw(:all -utf8);
use CGI::Carp qw(fatalsToBrowser);
require CGI::Session;
require 'debug.pl';
use Template;
use strict;
use warnings;
use Data::Dumper;
use lib::Headers;
use JSON;
use utf8;
use Time::Local;
use Date::Manip;

our $MainPageHeader;
my $cgi = CGI::new;
$cgi->autoEscape(1);

my %page_function_hash = (
   
        'MainPage' => {
                        pFunction => \&F_MainPage,
                        pHeader =>  $MainPageHeader,            
                     },
        'ADMIN_PAGE' => {
                        pFunction => \&F_ADMIN_PAGE,
                        pHeader =>  $MainPageHeader,            
                     },
        'SHOW_ADD_USER'=> {
                        pFunction => \&F_SHOW_ADD_USER,
                        pHeader =>  $MainPageHeader,            
                     },
        'INST_DISP' => {
                        pFunction => \&F_INST_DISP,
                        pHeader =>  $MainPageHeader,       
                     },
        'SHOW_ADD_PROJ_FORM' => {
                        pFunction => \&F_SHOW_ADD_PROJ_FORM,
                        pHeader =>  $MainPageHeader,            
                     },
        'RCV_ADD_PROJ'=> {
                        pFunction => \&F_RCV_ADD_PROJ,
                        pHeader =>  $MainPageHeader,       
                     },
        'SHOW_PROJ_DEL_FORM' => {
                        pFunction => \&F_SHOW_PROJ_DEL_FORM,
                        pHeader =>  $MainPageHeader, 
                     },
        'PROJ_DEL_CFRM' => {
                        pFunction => \&F_PROJ_DEL_CFRM,
                        pHeader =>  $MainPageHeader, 
                     },
       'SHOW_PROJ_MODIFY_FORM' => {
                        pFunction => \&F_SHOW_PROJ_MODIFY_FORM,
                        pHeader =>  $MainPageHeader, 
                     },
       'PROJ_MODIFY_CNFRM'  => {
                        pFunction => \&F_PROJ_MODIFY_CNFRM,
                        pHeader =>  $MainPageHeader, 
                     },
       'SHOW_ADD_NEW_INSTA_PROJ' => {
                        pFunction => \&F_SHOW_ADD_NEW_INSTA_PROJ,
                        pHeader =>  $MainPageHeader,   
                     },
       'GOTO_INSTA_PROJ' => {
                        pFunction => \&F_GOTO_INSTA_PROJ,
                        pHeader =>  $MainPageHeader,  
                     },
        'MODIFY_INSTA_PROJ' => {
                        pFunction => \&F_MODIFY_INSTA_PROJ,
                        pHeader =>  $MainPageHeader,
                     },
        'DEL_INSTA_PROJ' => {
                        pFunction => \&F_DEL_INSTA_PROJ,
                        pHeader =>  $MainPageHeader, 
                     },
       'ADD_INSTA_COMPO_FORM'=> {
                        pFunction => \&F_ADD_INSTA_COMPO_FORM,
                        pHeader =>  $MainPageHeader, 
                     },
       'NEW_COMP_ADD_CNFRM'=> {
                        pFunction => \&F_NEW_COMP_ADD_CNFRM,
                        pHeader =>  $MainPageHeader, 
                     },
       'MODIFY_INSTA_NAME_CNFRM'=> {
                        pFunction => \&F_MODIFY_INSTA_NAME_CNFRM,
                        pHeader =>  $MainPageHeader,                        
                     },
       'DEL_INSTA_NAME_CNFRM' => {
                        pFunction => \&F_DEL_INSTA_NAME_CNFRM,
                        pHeader =>  $MainPageHeader,
                     },
       'PROMOTE_USER'=> {
                        pFunction => \&F_PROMOTE_USER,
                        pHeader =>  $MainPageHeader,
                     },
       'DE_PROMOTE_USER'=> {
                        pFunction => \&F_DE_PROMOTE_USER,
                        pHeader =>  $MainPageHeader,
                     },
       'SHOW_USER_LIST'=> {
                        pFunction => \&F_SHOW_USER_LIST,
                        pHeader =>  $MainPageHeader,
                     },
       'DEL_USER'=> {
                        pFunction => \&F_DEL_USER,
                        pHeader =>  $MainPageHeader,
                     },
       'SET_PASSWORD'=> {
                        pFunction => \&F_SET_PASSWORD,
                        pHeader =>  $MainPageHeader,
                     },
       'RESET_USER_PASSWD'=> {
                        pFunction => \&F_RESET_USER_PASSWD,
                        pHeader =>  $MainPageHeader,
                     },
);


&AppInit( $cgi ); 

sub AppInit {
    my ($cgi) = @_;
    my $param = $cgi->param('AppParam');
    if (!$param){
        $param = 'MainPage';
    }elsif ($param =~ /\?/){
        my @params = split '\?' , $param;
        $cgi->{code} = $params[1];
        $param = $params[0];
    }
    $cgi->{'AppParam'} = $param  ;
    my $function_ref = $page_function_hash{$param}->{'pFunction'};
    $function_ref->($cgi);
}


sub F_MainPage {
    my ($cgi) = @_;
    my ($user_name,$role) = is_valid_user($cgi);
    my $param = $cgi->{'AppParam'};
    my $PageHeader = $page_function_hash{$param}->{'pHeader'};
    my $sid = $cgi->cookie('CGISESSID');
    my $session = CGI::Session->new( $sid );
    my $name = $session->param("usr_name");
    print $cgi->header( );
    print $cgi->start_html($PageHeader);
    
    my $out = ''; 
    my $tt = Template->new;
        $tt->process('page_top.html', undef, \$out)
        || die $tt->error;
    print $out;
    undef $out;
    
    my @main_projs = get_all_project_data ();
    my $data = {
            proj => \@main_projs,
    };
   
    $tt = Template->new;
        $tt->process('main_proj_page.html', $data, \$out)
        || die $tt->error;
    print $out;
    print $cgi->end_html();
}


sub F_ADMIN_PAGE {
    my ($cgi) = @_;
    my ($user_name,$role) = is_valid_user($cgi);
    my $param = $cgi->{'AppParam'};
    my $PageHeader = $page_function_hash{$param}->{'pHeader'};
    my $sid = $cgi->cookie('CGISESSID');
    my $session = CGI::Session->new( $sid );
    my $name = $session->param("usr_name");
    print $cgi->header( );
    print $cgi->start_html($PageHeader);
    
    my $out = ''; 
    my $tt = Template->new;
        $tt->process('admin_page_top.html', undef, \$out)
        || die $tt->error;
    print $out;
    undef $out;
    $tt = Template->new;
        $tt->process('admin_main_page.html', undef, \$out)
        || die $tt->error;
    print $out;
    print $cgi->end_html();
}

sub F_SHOW_ADD_USER{
    my ($cgi) = @_;
    my ($user_name,$role) = is_valid_user($cgi);
    my $param = $cgi->{'AppParam'};
    my $PageHeader = $page_function_hash{$param}->{'pHeader'};
    my $sid = $cgi->cookie('CGISESSID');
    my $session = CGI::Session->new( $sid );
    my $name = $session->param("usr_name");
    print $cgi->header( );
    print $cgi->start_html($PageHeader);
    
    my $out = ''; 
    my $tt = Template->new;
        $tt->process('admin_page_top.html', undef, \$out)
        || die $tt->error;
    print $out;
    undef $out;
    $tt = Template->new;
        $tt->process('show_add_user_form.html', undef, \$out)
        || die $tt->error;
    print $out;
    print $cgi->end_html();
}

sub F_SET_PASSWORD {
    my ($cgi) = @_;
    my ($user_name,$role) = is_valid_user($cgi);
    my $param = $cgi->{'AppParam'};
    my $PageHeader = $page_function_hash{$param}->{'pHeader'};
    my $sid = $cgi->cookie('CGISESSID');
    my $session = CGI::Session->new( $sid );
    my $name = $session->param("usr_name");
    my $uid = $session->param("uid");
    print $cgi->header( );
    print $cgi->start_html($PageHeader);
    
    my $out = ''; 
    my $tt = Template->new;
        $tt->process('page_top.html', undef, \$out)
        || die $tt->error;
    print $out;
    undef $out;
    my @main_projs = get_all_project_data ();
    my $data = {
            proj => \@main_projs,
            uid => $uid,
    };
   
    $tt = Template->new;
        $tt->process('passwd_change_form.html', $data, \$out)
        || die $tt->error;
    print $out;
    print $cgi->end_html();
}

sub F_RESET_USER_PASSWD{

   my ($cgi) = @_;
    my ($user_name,$role) = is_valid_user($cgi);
    my $param = $cgi->{'AppParam'};
    my $PageHeader = $page_function_hash{$param}->{'pHeader'};
    my $sid = $cgi->cookie('CGISESSID');
    my $session = CGI::Session->new( $sid );
    my $name = $session->param("usr_name");
    my $uid = $session->param("uid");
    print $cgi->header( );
    print $cgi->start_html($PageHeader);
    
    my $out = ''; 
    my $tt = Template->new;
        $tt->process('admin_page_top.html', undef, \$out)
        || die $tt->error;
    print $out;
    undef $out;
    my @usrs = get_all_user_info ();
    my $data = {
            usr => \@usrs,
    };
    
    $tt = Template->new;
        $tt->process('show_reset_user_passwd_form.html', $data, \$out)
        || die $tt->error;
    print $out;
    print $cgi->end_html();
}



sub F_PROMOTE_USER {
   my ($cgi) = @_;
    my ($user_name,$role) = is_valid_user($cgi);
    my $param = $cgi->{'AppParam'};
    my $PageHeader = $page_function_hash{$param}->{'pHeader'};
    my $sid = $cgi->cookie('CGISESSID');
    my $session = CGI::Session->new( $sid );
    my $name = $session->param("usr_name");
    print $cgi->header( );
    print $cgi->start_html($PageHeader);
    
    my $out = ''; 
    my $tt = Template->new;
        $tt->process('admin_page_top.html', undef, \$out)
        || die $tt->error;
    print $out;
    undef $out;
    my @usrs = get_all_user_info ();
    my $data = {
            usr => \@usrs,
    };
    
    $tt = Template->new;
        $tt->process('show_promote_user_form.html', $data, \$out)
        || die $tt->error;
    print $out;
    print $cgi->end_html();
}
sub F_SHOW_USER_LIST{
   my ($cgi) = @_;
    my ($user_name,$role) = is_valid_user($cgi);
    my $param = $cgi->{'AppParam'};
    my $PageHeader = $page_function_hash{$param}->{'pHeader'};
    my $sid = $cgi->cookie('CGISESSID');
    my $session = CGI::Session->new( $sid );
    my $name = $session->param("usr_name");
    print $cgi->header( );
    print $cgi->start_html($PageHeader);
    
    my $out = ''; 
    my $tt = Template->new;
        $tt->process('admin_page_top.html', undef, \$out)
        || die $tt->error;
    print $out;
    undef $out;
    my @usrs = get_all_user_info ();
    my $data = {
            usr => \@usrs,
    };
    
    $tt = Template->new;
        $tt->process('show_user_list.html', $data, \$out)
        || die $tt->error;
    print $out;
    print $cgi->end_html();
  
}

sub F_DE_PROMOTE_USER {
   my ($cgi) = @_;
    my ($user_name,$role) = is_valid_user($cgi);
    my $param = $cgi->{'AppParam'};
    my $PageHeader = $page_function_hash{$param}->{'pHeader'};
    my $sid = $cgi->cookie('CGISESSID');
    my $session = CGI::Session->new( $sid );
    my $name = $session->param("usr_name");
    print $cgi->header( );
    print $cgi->start_html($PageHeader);
    
    my $out = ''; 
    my $tt = Template->new;
        $tt->process('admin_page_top.html', undef, \$out)
        || die $tt->error;
    print $out;
    undef $out;
    my @usrs = get_all_user_info ();
    my $data = {
            usr => \@usrs,
    };
    
    $tt = Template->new;
        $tt->process('show_Depromote_user_form.html', $data, \$out)
        || die $tt->error;
    print $out;
    print $cgi->end_html();
}

sub F_DEL_USER {
   my ($cgi) = @_;
    my ($user_name,$role) = is_valid_user($cgi);
    my $param = $cgi->{'AppParam'};
    my $PageHeader = $page_function_hash{$param}->{'pHeader'};
    my $sid = $cgi->cookie('CGISESSID');
    my $session = CGI::Session->new( $sid );
    my $name = $session->param("usr_name");
    print $cgi->header( );
    print $cgi->start_html($PageHeader);
    
    my $out = ''; 
    my $tt = Template->new;
        $tt->process('admin_page_top.html', undef, \$out)
        || die $tt->error;
    print $out;
    undef $out;
    my @usrs = get_all_user_info ();
    my $data = {
            usr => \@usrs,
    };
    
    $tt = Template->new;
        $tt->process('show_delete_user_form.html', $data, \$out)
        || die $tt->error;
    print $out;
    print $cgi->end_html();
}

sub F_INST_DISP {
    my ($cgi) = @_;
    my ($user_name,$role) = is_valid_user($cgi);
    my $param = $cgi->{'AppParam'};
    my $PageHeader = $page_function_hash{$param}->{'pHeader'};
    my $sid = $cgi->cookie('CGISESSID');
    my $session = CGI::Session->new( $sid );
    my $name = $session->param("usr_name");
    print $cgi->header( );
    print $cgi->start_html($PageHeader);
    my $out = ''; 
    my $tt = Template->new;
        $tt->process('page_top.html', undef, \$out)
        || die $tt->error;
    print $out;
    undef $out;
    my $proj_id = $cgi->param('id');
    my %project_info = get_project_info_by_proj_id ( $proj_id );
    my @main_projs = get_all_project_data (); 
    my @instances = get_all_instances_of_proj ( $proj_id );

    my $data = {
            proj => \@main_projs,
            project_name => $project_info{project_name},
            project_desc => $project_info{project_desc},
            project_id => $proj_id,
            insta => \@instances,
    };
    
     $tt = Template->new;
        $tt->process('insta_proj_page.html', $data, \$out)
        || die $tt->error;
    print $out;
   
    print $cgi->end_html();
}

sub F_SHOW_ADD_PROJ_FORM {
    my ($cgi) = @_;
    my ($user_name,$role) = is_valid_user($cgi);
    my $param = $cgi->{'AppParam'};
    my $PageHeader = $page_function_hash{$param}->{'pHeader'};
    my $sid = $cgi->cookie('CGISESSID');
    my $session = CGI::Session->new( $sid );
    my $name = $session->param("usr_name");
    print $cgi->header( );
    print $cgi->start_html($PageHeader);
    
    my $out = ''; 
    my $tt = Template->new;
        $tt->process('page_top.html', undef, \$out)
        || die $tt->error;
    print $out;
    undef $out;
    
    my @main_projs = get_all_project_data ();
    my $data = {
            proj => \@main_projs,
    };
   
    $tt = Template->new;
        $tt->process('proj_add_form.html', $data, \$out)
        || die $tt->error;
    print $out;
    print $cgi->end_html();  
}

sub F_SHOW_ADD_NEW_INSTA_PROJ{
    my ($cgi) = @_;
    my ($user_name,$role) = is_valid_user($cgi);
    my $param = $cgi->{'AppParam'};
    my $PageHeader = $page_function_hash{$param}->{'pHeader'};
    my $sid = $cgi->cookie('CGISESSID');
    my $session = CGI::Session->new( $sid );
    my $name = $session->param("usr_name");
    print $cgi->header( );
    print $cgi->start_html($PageHeader);
    my $out = ''; 
    my $tt = Template->new;
        $tt->process('page_top.html', undef, \$out)
        || die $tt->error;
    print $out;
    undef $out;
    my $proj_id = $cgi->param('proj_id');
    my %project_info = get_project_info_by_proj_id ( $proj_id );
    my @main_projs = get_all_project_data ();    
   
    my $data = {
            proj => \@main_projs,
            project_name => $project_info{project_name},
            project_desc => $project_info{project_desc},
            project_id => $proj_id,
    };
    
     $tt = Template->new;
        $tt->process('add_new_inst_of_proj.html', $data, \$out)
        || die $tt->error;
    print $out;
   
    print $cgi->end_html();
   
}


sub F_SHOW_PROJ_MODIFY_FORM{
   my ($cgi) = @_;
    my ($user_name,$role) = is_valid_user($cgi);
    my $param = $cgi->{'AppParam'};
    my $PageHeader = $page_function_hash{$param}->{'pHeader'};
    my $sid = $cgi->cookie('CGISESSID');
    my $session = CGI::Session->new( $sid );
    my $name = $session->param("usr_name");
    print $cgi->header( );
    print $cgi->start_html($PageHeader);
   
    my $out = ''; 
    my $tt = Template->new;
        $tt->process('page_top.html', undef, \$out)
        || die $tt->error;
    print $out;
    undef $out;
    my $proj_id = $cgi->param('id');
    my $proj_name = $cgi->param('proj');  
    my @main_projs = get_all_project_data ();
    my $data = {
            proj => \@main_projs,
            proj_name => $proj_name,
            proj_id => $proj_id,
    };
    $tt = Template->new;
        $tt->process('proj_modify_form.html', $data, \$out)
        || die $tt->error;
    print $out;
    print $cgi->end_html(); 
}

sub F_RCV_ADD_PROJ{
    my ($cgi) = @_;
    my ($user_name,$role) = is_valid_user($cgi);
    my $param = $cgi->{'AppParam'};
    my $PageHeader = $page_function_hash{$param}->{'pHeader'};
    my $sid = $cgi->cookie('CGISESSID');
    my $session = CGI::Session->new( $sid );
    my $name = $session->param("usr_name");
    print $cgi->header( );
    print $cgi->start_html($PageHeader);
    my $out = ''; 
    my $tt = Template->new;
        $tt->process('page_top.html', undef, \$out)
        || die $tt->error;
    print $out;
    undef $out;

    my $proj_name = $cgi->param('proj_name');
    my $proj_desc = $cgi->param('proj_desc');
     
    my $data = {
            ProjectName => $proj_name,
            ProjectDesc => $proj_desc,
            flag => 0,
    };
    if ( $proj_name !~ /^\w+$/){
       $data->{msg} = "Project Name should have alphanumeric Or _ ";
       $data->{flag} = 1;
    }else {
       my $ret = add_new_project ($proj_name,$proj_desc,$cgi);
    }
    my @main_projs = get_all_project_data ();
    $data->{proj} = \@main_projs;
    $tt = Template->new;
        $tt->process('proj_add_responce.html', $data, \$out)
        || die $tt->error;
    print $out;
    print $cgi->end_html(); 
}

sub F_PROJ_MODIFY_CNFRM {
   my ($cgi) = @_;
    my ($user_name,$role) = is_valid_user($cgi);
    my $param = $cgi->{'AppParam'};
    my $PageHeader = $page_function_hash{$param}->{'pHeader'};
    my $sid = $cgi->cookie('CGISESSID');
    my $session = CGI::Session->new( $sid );
    my $name = $session->param("usr_name");
    print $cgi->header( );
    print $cgi->start_html($PageHeader);
    my $out = ''; 
    my $tt = Template->new;
        $tt->process('page_top.html', undef, \$out)
        || die $tt->error;
    print $out;
    undef $out;

    my $proj_id = $cgi->param('proj_id');
    my $proj_name = $cgi->param('proj_name');
    my %org_proj_info = get_project_info_by_proj_id ( $proj_id );
    my $org_proj_name = $org_proj_info{project_name};
    
    my $data = {
            ProjectName => $proj_name,
            OrgProjectName => $org_proj_name,
            flag => 0,
    };
    if ( $proj_name !~ /^\w+$/){
       $data->{msg} = "Project Name should have alphanumeric Or _ ";
       $data->{flag} = 1;
    }else {
       my $ret = modify_project_name ($proj_name,$proj_id,$cgi);
    }
    my @main_projs = get_all_project_data ();
    $data->{proj} = \@main_projs;
    $tt = Template->new;
        $tt->process('proj_modify_responce.html', $data, \$out)
        || die $tt->error;
    print $out;
    print $cgi->end_html(); 
  
}
sub F_SHOW_PROJ_DEL_FORM {
    my ($cgi) = @_;
    my ($user_name,$role) = is_valid_user($cgi);
    my $param = $cgi->{'AppParam'};
    my $PageHeader = $page_function_hash{$param}->{'pHeader'};
    my $sid = $cgi->cookie('CGISESSID');
    my $session = CGI::Session->new( $sid );
    my $name = $session->param("usr_name");
    print $cgi->header( );
    print $cgi->start_html($PageHeader); 
    my $out = ''; 
    my $tt = Template->new;
        $tt->process('page_top.html', undef, \$out)
        || die $tt->error;
    print $out;
    undef $out;    
    my @main_projs = get_all_project_data ();
    my $proj_id = $cgi->param('id');
    my $proj_name = $cgi->param('proj');
    
    my $data = {
            proj => \@main_projs,
            proj_name => $proj_name,
            proj_id => $proj_id,
    };
    
    if ( $proj_name !~ /^\w+$/){
       $data->{flag} = 1;
    }
    my @instances = get_all_instances_of_proj ( $proj_id );
    my @all_compo_html_format ;
    foreach my $instance (@instances){
      my $insta_id = $instance->{insta_id};
      my $insta_name = $instance->{insta_name};
      my @compos = get_all_compos_of_instance ( $insta_id );
      my $data = {
            compos => \@compos,
      };
      my $out = ''; 
      my $tt = Template->new;
        $tt->process('comp_html_format.html', $data, \$out)
        || die $tt->error;
      push (@all_compo_html_format, $out);
    }
    my $all_compo_html_format_line = join '', @all_compo_html_format;
    $data->{comp} = $all_compo_html_format_line;
    $tt = Template->new;
        $tt->process('proj_all_insta_all_comp_display.html', $data, \$out)
        || die $tt->error;
    print $out;
    print $cgi->end_html(); 
}

sub F_GOTO_INSTA_PROJ{
    my ($cgi) = @_;
    my ($user_name,$role) = is_valid_user($cgi);
    my $param = $cgi->{'AppParam'};
    my $PageHeader = $page_function_hash{$param}->{'pHeader'};
    my $sid = $cgi->cookie('CGISESSID');
    my $session = CGI::Session->new( $sid );
    my $name = $session->param("usr_name");
    print $cgi->header( );
    print $cgi->start_html($PageHeader); 
    my $out = ''; 
    my $tt = Template->new;
        $tt->process('page_top.html', undef, \$out)
        || die $tt->error;
    print $out;
    undef $out;    
    my @main_projs = get_all_project_data ();
    my $proj_id = $cgi->param('proj_id');
    my $insta_id = $cgi->param('insta_id');
    my $insta_name = get_insta_name_by_insta_id ($insta_id);
    my %project_info = get_project_info_by_proj_id ( $proj_id );
    my @instances = get_all_instances_of_proj ( $proj_id );
    my @compos = get_all_compos_of_instance ( $insta_id );
    my $compos_data = {
            compos => \@compos,
            proj_id => $proj_id,
            insta_id => $insta_id,
      };
    my $compos_html = ''; 
    $tt = Template->new;
        $tt->process('comp_html_format_edit.html', $compos_data, \$compos_html)
        || die $tt->error;
    
    my $data = {
            proj => \@main_projs,
            project_name => $project_info{project_name},
            project_desc => $project_info{project_desc},
            project_id => $proj_id,
            insta => \@instances,
            compos => $compos_html,
            insta_id => $insta_id,
            insta_name => $insta_name,
    };
  
     $tt = Template->new;
        $tt->process('show_all_compos_insta.html', $data, \$out)
        || die $tt->error;
    print $out;
}
sub F_DEL_INSTA_PROJ{
   my ($cgi) = @_;
    my ($user_name,$role) = is_valid_user($cgi);
    my $param = $cgi->{'AppParam'};
    my $PageHeader = $page_function_hash{$param}->{'pHeader'};
    my $sid = $cgi->cookie('CGISESSID');
    my $session = CGI::Session->new( $sid );
    my $name = $session->param("usr_name");
    print $cgi->header( );
    print $cgi->start_html($PageHeader); 
    my $out = ''; 
    my $tt = Template->new;
        $tt->process('page_top.html', undef, \$out)
        || die $tt->error;
    print $out;
    undef $out;    
    my @main_projs = get_all_project_data ();
    my $proj_id = $cgi->param('proj_id');
    my $insta_id = $cgi->param('insta_id');
    my $insta_name = get_insta_name_by_insta_id ($insta_id ) ;
    my %project_info = get_project_info_by_proj_id ( $proj_id );
    my @instances = get_all_instances_of_proj ( $proj_id );
    my $data = {
            proj => \@main_projs,
            project_name => $project_info{project_name},
            project_desc => $project_info{project_desc},
            project_id => $proj_id,
            insta => \@instances,
            insta_id => $insta_id,
            insta_name => $insta_name,
    };
   my @compos = get_all_compos_of_instance ( $insta_id );
    my $compos_data = {
            compos => \@compos,
            proj_id => $proj_id,
            insta_id => $insta_id,
      };
    my $compos_html = ''; 
    $tt = Template->new;
        $tt->process('comp_html_format.html', $compos_data, \$compos_html)
        || die $tt->error;
    $data->{compos} = $compos_html;
    $tt = Template->new;
        $tt->process('del_insta_name_form.html', $data, \$out)
        || die $tt->error;
    print $out;
}


sub F_MODIFY_INSTA_PROJ {
    my ($cgi) = @_;
    my ($user_name,$role) = is_valid_user($cgi);
    my $param = $cgi->{'AppParam'};
    my $PageHeader = $page_function_hash{$param}->{'pHeader'};
    my $sid = $cgi->cookie('CGISESSID');
    my $session = CGI::Session->new( $sid );
    my $name = $session->param("usr_name");
    print $cgi->header( );
    print $cgi->start_html($PageHeader); 
    my $out = ''; 
    my $tt = Template->new;
        $tt->process('page_top.html', undef, \$out)
        || die $tt->error;
    print $out;
    undef $out;    
    my @main_projs = get_all_project_data ();
    my $proj_id = $cgi->param('proj_id');
    my $insta_id = $cgi->param('insta_id');
    my $insta_name = get_insta_name_by_insta_id ($insta_id ) ;
    my %project_info = get_project_info_by_proj_id ( $proj_id );
    my @instances = get_all_instances_of_proj ( $proj_id );
    my $data = {
            proj => \@main_projs,
            project_name => $project_info{project_name},
            project_desc => $project_info{project_desc},
            project_id => $proj_id,
            insta => \@instances,
            insta_id => $insta_id,
            insta_name => $insta_name,
    };
     $tt = Template->new;
        $tt->process('modify_insta_name_form.html', $data, \$out)
        || die $tt->error;
    print $out;
}

sub F_MODIFY_INSTA_NAME_CNFRM{
    my ($cgi) = @_;
    my ($user_name,$role) = is_valid_user($cgi);
    my $param = $cgi->{'AppParam'};
    my $PageHeader = $page_function_hash{$param}->{'pHeader'};
    my $sid = $cgi->cookie('CGISESSID');
    my $session = CGI::Session->new( $sid );
    my $name = $session->param("usr_name");
    print $cgi->header( );
    print $cgi->start_html($PageHeader); 
    my $out = ''; 
    my $tt = Template->new;
        $tt->process('page_top.html', undef, \$out)
        || die $tt->error;
    print $out;
    undef $out;    
    my @main_projs = get_all_project_data ();
    my $proj_id = $cgi->param('proj_id');
    my $insta_id = $cgi->param('insta_id');
    my $insta_name = $cgi->param('insta_name');
    my $new_insta_name = $cgi->param('new_insta_name');
    my %project_info = get_project_info_by_proj_id ( $proj_id );
   
    my $data = {
            proj => \@main_projs,
            project_name => $project_info{project_name},
            project_desc => $project_info{project_desc},
            project_id => $proj_id,
            insta_id => $insta_id,
    };
    if  ( $new_insta_name !~ /^\w+$/ ){
         $data->{msg} = "Only Alpha Numeric name and _ is allowed ";
         $data->{flag} = 0;
    }else{
         my $ret = modify_porj_insta_name ( $new_insta_name, $insta_id, $cgi );
         $data->{msg} = "Instance Name $insta_name of project $project_info{project_name} is modified as $new_insta_name ";
         $data->{flag} = 1;
    }
     my @instances = get_all_instances_of_proj ( $proj_id );
     $data->{insta} = \@instances;
     $data->{insta_name} = get_insta_name_by_insta_id ( $insta_id );
    
    $tt = Template->new;
        $tt->process('modify_insta_name_cnfrm.html', $data, \$out)
        || die $tt->error;
    print $out;
}

sub F_DEL_INSTA_NAME_CNFRM {
    my ($cgi) = @_;
    my ($user_name,$role) = is_valid_user($cgi);
    my $param = $cgi->{'AppParam'};
    my $PageHeader = $page_function_hash{$param}->{'pHeader'};
    my $sid = $cgi->cookie('CGISESSID');
    my $session = CGI::Session->new( $sid );
    my $name = $session->param("usr_name");
    print $cgi->header( );
    print $cgi->start_html($PageHeader); 
    my $out = ''; 
    my $tt = Template->new;
        $tt->process('page_top.html', undef, \$out)
        || die $tt->error;
    print $out;
    undef $out;    
    my @main_projs = get_all_project_data ();
    my $proj_id = $cgi->param('proj_id');
    my $insta_id = $cgi->param('insta_id');
    my %project_info = get_project_info_by_proj_id ( $proj_id );
   
    my $data = {
            proj => \@main_projs,
            project_name => $project_info{project_name},
            project_desc => $project_info{project_desc},
            project_id => $proj_id,
            insta_id => $insta_id,
    };

    
     $data->{insta_name} = get_insta_name_by_insta_id ( $insta_id );
     
     my $ret = delete_insta_name ( $insta_id , $cgi);
     my @instances = get_all_instances_of_proj ( $proj_id );
     $data->{insta} = \@instances;
    
    $tt = Template->new;
        $tt->process('del_insta_name_cnfrm.html', $data, \$out)
        || die $tt->error;
    print $out; 
}

sub F_PROJ_DEL_CFRM {
    my ($cgi) = @_;
    my ($user_name,$role) = is_valid_user($cgi);
    my $param = $cgi->{'AppParam'};
    my $PageHeader = $page_function_hash{$param}->{'pHeader'};
    my $sid = $cgi->cookie('CGISESSID');
    my $session = CGI::Session->new( $sid );
    my $name = $session->param("usr_name");
    print $cgi->header( );
    print $cgi->start_html($PageHeader); 
    my $out = ''; 
    my $tt = Template->new;
        $tt->process('page_top.html', undef, \$out)
        || die $tt->error;
    print $out;
    undef $out;
    
    my $proj_id = $cgi->param('proj_id');
    my $proj_name = $cgi->param('proj_name');
    my $ret = delete_project ($proj_id, $proj_name,$cgi);
    my $data = {
            ProjectName => $proj_name,
    };
    my @main_projs = get_all_project_data ();
    $data->{proj} = \@main_projs;
    $tt = Template->new;
        $tt->process('proj_del_responce.html', $data, \$out)
        || die $tt->error;
    print $out;
    print $cgi->end_html(); 
}

sub F_ADD_INSTA_COMPO_FORM {
   my ($cgi) = @_;
    my ($user_name,$role) = is_valid_user($cgi);
    my $param = $cgi->{'AppParam'};
    my $PageHeader = $page_function_hash{$param}->{'pHeader'};
    my $sid = $cgi->cookie('CGISESSID');
    my $session = CGI::Session->new( $sid );
    my $name = $session->param("usr_name");
    print $cgi->header( );
    print $cgi->start_html($PageHeader); 
    my $out = ''; 
    my $tt = Template->new;
        $tt->process('page_top.html', undef, \$out)
        || die $tt->error;
    print $out;
    undef $out;    
    my @main_projs = get_all_project_data ();
    my $proj_id = $cgi->param('proj_id');
    my $insta_id = $cgi->param('insta_id');
    my $insta_name = get_insta_name_by_insta_id ($insta_id) ;
    my %project_info = get_project_info_by_proj_id ( $proj_id );
    my @instances = get_all_instances_of_proj ( $proj_id );
    
    my $data = {
            proj => \@main_projs,
            project_name => $project_info{project_name},
            project_desc => $project_info{project_desc},
            project_id => $proj_id,
            insta => \@instances,
            insta_id => $insta_id,
            insta_name => $insta_name,
    };
  
     $tt = Template->new;
        $tt->process('add_new_comp_inst.html', $data, \$out)
        || die $tt->error;
    print $out;   
}

sub F_NEW_COMP_ADD_CNFRM{
    my ($cgi) = @_;
    my ($user_name,$role) = is_valid_user($cgi);
    my $param = $cgi->{'AppParam'};
    my $PageHeader = $page_function_hash{$param}->{'pHeader'};
    my $sid = $cgi->cookie('CGISESSID');
    my $session = CGI::Session->new( $sid );
    my $name = $session->param("usr_name");
    print $cgi->header( );
    print $cgi->start_html($PageHeader); 
    my $out = ''; 
    my $tt = Template->new;
        $tt->process('page_top.html', undef, \$out)
        || die $tt->error;
    print $out;
    undef $out;    
    my @main_projs = get_all_project_data ();
    my $proj_id = $cgi->param('proj_id');
    my $insta_id = $cgi->param('insta_id');
    my $insta_name = $cgi->param('insta_name');
    my $proj_name = $cgi->param('proj_name');
    
    my $type = $cgi->param('type');
    my $host_name = $cgi->param('host_name');
    my $ip = $cgi->param('ip');
    my $user = $cgi->param('user');
    my $passwd = $cgi->param('passwd');
    my $comment = $cgi->param('comment');
    
    
    my %project_info = get_project_info_by_proj_id ( $proj_id );
    my @instances = get_all_instances_of_proj ( $proj_id );
    my $ret = add_new_component ($insta_id,$type,$host_name,$ip,$user,$passwd,$comment,$cgi );
    
    my $data = {
            proj => \@main_projs,
            project_name => $project_info{project_name},
            project_desc => $project_info{project_desc},
            project_id => $proj_id,
            insta => \@instances,
            insta_id => $insta_id,
            insta_name => $insta_name,
    };
    
     $tt = Template->new;
        $tt->process('add_new_comp_inst_cnfrm.html', $data, \$out)
        || die $tt->error;
    print $out;     
}