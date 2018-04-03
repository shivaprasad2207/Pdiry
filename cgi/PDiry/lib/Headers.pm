package lib::Headers;
require(Exporter);
use warnings;
use strict;
our @ISA = qw(Exporter);
our @EXPORT    = qw (
                      $MainPageHeader
                    );

our $MainPageHeader = {
                        -title => 'PDirectory',
                        -style=>[ 
                                       { -type =>'text/css', -src=>'/static/styles/PDiry/body.css'},
                                       { -type =>'text/css', -src=>'/static/styles/PDiry/bootstrap.css'},
                                       { -type =>'text/css', -src=>'/static/styles/PDiry/bootstrap-responsive.css'},
                                       { -type =>'text/css', -src=>'/static/styles/PDiry/jquery-ui-1.8.18.custom.css'},
                                    ],  
                         -script=>[
                                        { -type => 'text/javascript', -src => '/static/js/PDiry/jquery.min.js'},
                                        { -type => 'text/javascript', -src => '/static/js/PDiry/jquery-1.3.2.min.js'},
                                        { -type => 'text/javascript', -src => '/static/js/PDiry/jquery.js'},
                                        { -type => 'text/javascript', -src => '/static/js/PDiry/jquery.ui.core.js' },
                                        { -type => 'text/javascript', -src => '/static/js/PDiry/jquery-ui-1.8.18.custom.min.js' },
                                        { -type => 'text/javascript', -src => '/static/js/PDiry/advanced.js'},
                                        { -type => 'text/javascript', -src => '/static/js/PDiry/pre_logout.js'},
                                        { -type => 'text/javascript', -src => '/static/js/PDiry/bootstrap.js'},
                                                                            
                                     
                                     ],
                    };


1
;


                                       
                                       
                                       
                                        