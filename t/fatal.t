#!perl

use Test::More tests => 3;
use Test::Exception;

use lib 't';
use App::Env;

my $env = App::Env->new( 'App1', { SysFatal => 1 } );

dies_ok { $env->system( $^X, '-e', 'exit(1)' ) } 'system';
dies_ok { $env->capture( $^X, '-e', 'exit(1)' ) } 'capture';
dies_ok { $env->qexec( $^X, '-e', 'exit(1)' ) } 'qexec';
