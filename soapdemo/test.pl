#!/usr/bin/perl

use strict;
use lib qw ( ./ );
use WebService;
use EmbedIT::WebIT;
use CGI;

my $lib_path = "./lib";

# ----------------------------------------------------------------------------------------------------------

sub WebServiceTest {
  my $show_wsdl = 0;
  if (uc($ENV{'QUERY_STRING'}) eq 'WSDL') {
    $show_wsdl = 1;
  }

  if ($show_wsdl) {
    print "Content-type: text/xml; charset=\"utf-8\"\n\n";
    open F, "TestBind.wsdl";
    while (my $l = <F>) {
      print $l;
    }
    close F;

  } else {
    eval {
      unshift @INC, $lib_path;      # add at run time the library path of the generated classes from wsdl2perl
      require MyServer::Test::Test; # use the server class generated by wsdl2perl
  
      my $t = WebService->new();    # create a WebService handling object
      my $server = MyServer::Test::Test->new({ dispatch_to     => 'WebService',
                                               transport_class => 'SOAP::WSDL::Server::CGI' });
      $server->handle();
    };
    if ($@) { print STDERR "just do something ...the call has failed\n$@\n"; }
  }
}

# ----------------------------------------------------------------------------------------------------------

my $server = new EmbedIT::WebIT(  SERVER_NAME     => 'localhost',
                                  SERVER_IP       => '127.0.0.1',
                                  SERVER_PORT     => 8089,
                                  SOFTWARE        => 'MyApp',
                                  QUEUE_SIZE      => 100,
                                  WAIT_RESPONSE   => 1,
                                  IMMED_CLOSE     => 0,
                                  EMBED_PERL      => 1,
                                  FORK_CONN       => 1,
                                  SETUP_ENV       => 1,
                                  SERVER_ADMIN    => 'info@my.org',
                                  SERVERS         => 1,
                                  WORKERS         => 0,
                                  DOCUMENTS       => {
                                                       '/WS/Test' => 'main::WebServiceTest',
                                                     },
                                  ERROR_PAGES     => { 
                                                       'ALL' => '/error.html', 
                                                     },
                                  CGI_PATH        => '/WS',
                                  PROC_PREFIX     => 'test:',
                                  LOG_HEADERS     => 0,
                                  LOG_PACKETS     => 0,
                                  ENV_KEEP        => [ 'PERL5LIB', 'LD_LIBRARY_PATH' ],
                                  NO_LOGGING      => 0,
                             );

$server->execute();

# ----------------------------------------------------------------------------------------------------------
