#!perl

use Test::More tests => 4;
use Test::Exception;

use lib 't';

# set default SysFatal and watch everything explode
use App::Env { SysFatal => 1, Cache => 0 };

my $env = App::Env->new( 'App1' );

dies_ok { $env->system( $^X, '-e', 'exit(1)' ) } 'system';
dies_ok { $env->capture( $^X, '-e', 'exit(1)' ) } 'capture';
dies_ok { $env->qexec( $^X, '-e', 'exit(1)' ) } 'qexec';

# now reset it and get the error messages
App::Env->import( { SysFatal => 0 } );

lives_ok { App::Env->new( 'App1')->system( $^X, '-e', 'exit(1)' ) } 'system';
