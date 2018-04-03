package lib::DB_OBJ;

BEGIN{
   use Cwd;
   our $directory = cwd;
   require(Exporter);
   use warnings;
   use strict;
   use Data::Dumper;
};

use lib $directory;
use DBModule;
use POSIX qw/strftime/;

   our @ISA = qw(Exporter);
   our @EXPORT    = qw (
                        is_uname_exist_in_db
                        get_all_project_data_from_db
                        get_project_info_by_proj_id_from_db
                        get_all_instances_of_proj_from_db
                        get_all_compos_of_instance_from_db 
                        my_sql_exec
                        get_comp_info_by_comp_id_from_db
                        get_insta_name_by_insta_id_from_db
                        get_passwd_by_comp_id_from_db
                        get_all_user_info_from_db
                   );

   our $db_exec;

sub is_uname_exist_in_db{
    my ($uname ) = @_;
    my $sql = "select COUNT(*) from login_info where user_email=\'$uname\' and is_active=\'1\';";
    my $qh = $db_exec->prepare ($sql) or die (@errors, '<br>' . "* $sql *" . $db_exec->errstr. '<br>' );      
    $qh->execute()or die (@errors, '<br>' . "* $sql *" . $qh->errstr. '<br>' );  
    my ($count) = $qh->fetchrow_array();
    if ( $count){
      return 0;
    }else{
      return 1;
    }
}

sub get_all_project_data_from_db {
   
    my $sql = "SELECT * FROM projects where is_active=\'1\';";
    
    my $qh = $db_exec->prepare ($sql) or die (@errors, '<br>' . "* $sql *" . $db_exec->errstr. '<br>' );      
    
    $qh->execute()or die (@errors, '<br>' . "* $sql *" . $qh->errstr. '<br>' );
    my @project_list;
    while ( my ($project_id , $project_name, $project_desc) = $qh->fetchrow_array() ){
      my %hash;
      @hash{'project_id', 'project_name', 'project_desc'} = ($project_id , $project_name, $project_desc);
      push (@project_list,\%hash);
    }
    return @project_list;
}

sub get_all_user_info_from_db {
     my $sql = "SELECT user_email, uid, user_role FROM login_info where is_active=\'1\';";
    
    my $qh = $db_exec->prepare ($sql) or die (@errors, '<br>' . "* $sql *" . $db_exec->errstr. '<br>' );      
    
    $qh->execute()or die (@errors, '<br>' . "* $sql *" . $qh->errstr. '<br>' );
    my @user_list;
    while ( my ($email , $uid, $role) = $qh->fetchrow_array() ){
      my %hash;
      @hash{'email', 'uid', 'role'} = ($email , $uid, $role);
      push (@user_list,\%hash);
    }
    return @user_list;
}

sub get_project_info_by_proj_id_from_db {
   my ( $proj_id ) = @_;
   my $sql = "select project_name , project_desc from projects where project_id=\'$proj_id\' and is_active=\'1\';"; 
   my $qh = $db_exec->prepare ($sql) or die (@errors, '<br>' . "* $sql *" . $db_exec->errstr. '<br>' );      
   $qh->execute()or die (@errors, '<br>' . "* $sql *" . $qh->errstr. '<br>' ); 
   my %project_info;
   @project_info { 'project_name' , 'project_desc' } =  $qh->fetchrow_array();
   return %project_info;
}

sub get_all_instances_of_proj_from_db {
   my ( $proj_id ) = @_;
   my $sql = "select insta_id , insta_name from instances where project_id=\'$proj_id\' and is_active=\'1\';"; 
   my $qh = $db_exec->prepare ($sql) or die (@errors, '<br>' . "* $sql *" . $db_exec->errstr. '<br>' );      
   $qh->execute()or die (@errors, '<br>' . "* $sql *" . $qh->errstr. '<br>' ); 
   
    my @instance_list;
    while ( my ($insta_id , $insta_name) = $qh->fetchrow_array() ){
      my %hash;
      @hash{'insta_id', 'insta_name'} = ($insta_id , $insta_name);
      push (@instance_list,\%hash);
    }
    return @instance_list;
   
}

sub  get_all_compos_of_instance_from_db {
   my ( $insta_id ) = @_;
   my $sql = "select * from components where insta_id=\'$insta_id\' and is_active='1';";
   my $qh = $db_exec->prepare ($sql) or die (@errors, '<br>' . "* $sql *" . $db_exec->errstr. '<br>' );      
   $qh->execute()or die (@errors, '<br>' . "* $sql *" . $qh->errstr. '<br>' ); 
   
    my @comp_list; my $count = 1; 
    while ( my ($insta_id , $comp_id, $host_name, $ip, $user, $type, $password , $Comments, $is_active) = $qh->fetchrow_array() ){
      my %hash;
      @hash{'insta_id' , 'comp_id', 'host_name', 'ip', 'user', 'type', 'password' , 'Comments', 'count'}
               =
         ($insta_id , $comp_id, $host_name, $ip, $user, $type, $password , $Comments, $count);
         $count++;
      push (@comp_list,\%hash);
    }
    return @comp_list;
}

sub get_passwd_by_comp_id_from_db {
   my ( $comp_id) = @_;
   my $sql = "select password from components where comp_id=\'$comp_id\';"; 
   my $qh = $db_exec->prepare ($sql) or die (@errors, '<br>' . "* $sql *" . $db_exec->errstr. '<br>' );      
   $qh->execute()or die (@errors, '<br>' . "* $sql *" . $qh->errstr. '<br>' ); 
   my ($passwd) =  $qh->fetchrow_array();  
   return $passwd;
   
}

sub my_sql_exec {
    my ($sql) = @_;
    my $qh = $db_exec->prepare ($sql) or die (@errors, '<br>' . "* $sql *" . $db_exec->errstr. '<br>' );
    $qh->execute()or die (@errors, '<br>' . "* $sql *" . $qh->errstr. '<br>' );
    return 1;
}

sub get_comp_info_by_comp_id_from_db {
   my ($comp_id) = @_;
   my $sql = "select host_name, ip, user, type, password , Comments from components where comp_id=\'$comp_id\'and is_active='1';";
   my $qh = $db_exec->prepare ($sql) or die (@errors, '<br>' . "* $sql *" . $db_exec->errstr. '<br>' );      
   $qh->execute()or die (@errors, '<br>' . "* $sql *" . $qh->errstr. '<br>' ); 
   my %hash;
   @hash{'host_name', 'ip', 'user', 'type', 'password' , 'Comments'} = $qh->fetchrow_array();
   return %hash;
}

sub get_insta_name_by_insta_id_from_db{
   my ( $insta_id ) = @_;
   my $sql = "select insta_name from instances where insta_id=\'$insta_id\';"; 
   my $qh = $db_exec->prepare ($sql) or die (@errors, '<br>' . "* $sql *" . $db_exec->errstr. '<br>' );      
   $qh->execute()or die (@errors, '<br>' . "* $sql *" . $qh->errstr. '<br>' ); 
   my ($insta_name) =  $qh->fetchrow_array();  
   return $insta_name;
}

sub create_uniq_string {
         my $length_of_randomstring=shift;
         my @chars=('a'..'z','A'..'Z','0'..'9','_');
         my $random_string;
         foreach (1..$length_of_randomstring){
		$random_string.=$chars[rand @chars];
	}
	return $random_string;
}

sub generate_my_sql_rand_db {
   
   my $sql= "SELECT CAST(RAND() * 99999999 AS UNSIGNED) + 1 as randNum";
   my $qh = $db_exec->prepare ($sql) or die (@errors, '<br>' . "* $sql *" . $db_exec->errstr. '<br>' );
   $qh->execute()or die (@errors, '<br>' . "* $sql *" . $qh->errstr. '<br>' ); 
   my ($rand) = $qh->fetchrow_array();
   return $rand;
}

sub get_book_copies_by_id_from_db {
   my ($book_id) = @_; 
   my $sql = "select book_pid from book_collection where book_id = \'$book_id\'";
   my @book_copies;
   
   eval{
      my $qh = $db_exec->prepare ($sql) or push (@errors, '<br>' . "* $sql *" . $db_exec->errstr. '<br>' );
      $qh->execute()or push (@errors, '<br>' . "* $sql *" . $qh->errstr. '<br>' );
      while ( my ($book_copy) = $qh->fetchrow_array()){
         push @book_copies, $book_copy;
      }
   };
   if ( $@ ){
            return ('FAIL',$@);
      }else{
            return @book_copies ;
   }  
 
}

sub db_exec_single_val_ret {
   my ($sql) = @_;
   my $mail_id;
    my @errors;
   eval { 
         my $qh = $db_exec->prepare ($sql) or push (@errors, '<br>' . "* $sql *" . $db_exec->errstr. '<br>' );
         $qh->execute()or push (@errors, '<br>' . "* $sql *" . $qh->errstr. '<br>' );   
         $mail_id = $qh->fetchrow_array() ;
     };
      if ( $@ ){
            return ('FAIL',$@);
      }else{
            if ( defined ( $mail_id )){
               return ($mail_id);   
            }else{
               return ('FAIL',$@);   
            } 
   }  
}

sub db_exec_string_ret {
   my ($sql) = @_;
   my $mail_id;
    my @errors;
   eval { 
         my $qh = $db_exec->prepare ($sql) or push (@errors, '<br>' . "* $sql *" . $db_exec->errstr. '<br>' );
         $qh->execute()or push (@errors, '<br>' . "* $sql *" . $qh->errstr. '<br>' );   
         $mail_id = $qh->fetchrow_array() ;
     };
      if ( $@ ){
            return ('FAIL',$@);
      }else{
            if ( defined ( $mail_id )){
               return ($mail_id);   
            }else{
               return ('FAIL',$@);   
            } 
   }    
}

sub db_exec_return_boolean {
   my ($sql) = @_;
   my $ret;
    my @errors;
   eval { 
         my $qh = $db_exec->prepare ($sql) or push (@errors, '<br>' . "* $sql *" . $db_exec->errstr. '<br>' );
         $qh->execute()or push (@errors, '<br>' . "* $sql *" . $qh->errstr. '<br>' );   
         $ret = $qh->fetchrow_array() ;
     };
      if ( $@ ){
            return 0;
      }else{
            if ( defined ( $ret )){
               return 1;   
            }else{
               return 0;   
            } 
   }    
}


sub db_exec_string_no_ret {
   my ($sql) = @_;
    my @errors;
   eval { 
         my $qh = $db_exec->prepare ($sql) or push (@errors, '<br>' . "* $sql *" . $db_exec->errstr. '<br>' );
         $qh->execute()or push (@errors, '<br>' . "* $sql *" . $qh->errstr. '<br>' );   
     };
      if ( $@ ){
            return ('FAIL',$@);
      }else{
            return 1;
      }     
}




1
;