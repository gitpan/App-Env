#!perl

use Test::More tests => 5;

use strict;
use warnings;

use lib 't';
use File::Temp;
use File::Spec::Functions qw[ catfile ];

use App::Env;

my $script = catfile( qw [ t capture.pl ] );

{
    my $app1 = App::Env->new( 'App1', { Cache => 0 } );

    my ($stdout, $stderr ) = $app1->capture( $^X,  $script );
    is( $?, 0, 'successful system call' );

    is( $stdout, "STDOUT\n", 'success: STDOUT' );
    is( $stderr, "STDERR\n", 'success: STDERR' );
}

{
    my $app1 = App::Env->new( 'App1', { Cache => 0 } );

    my ($stdout, $stderr ) = $app1->capture( $^X,  $script, '1' );
    isnt( $?, 0, 'unsuccessful system call' );
}

{
    my $app1 = App::Env->new( 'App1', { Cache => 0, SysFatal => 1 } );

    eval {
	my ($stdout, $stderr ) = $app1->capture( $^X,  $script, '1' );
    };
    isnt( $@, '', 'unsuccessful system call: SysFatal' );
}
