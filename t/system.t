use Test::More tests => 2;

use strict;
use warnings;

use lib 't';
use File::Temp;
use App::Env;

my $app1 = App::Env->new( 'App1' );

{
    # redirect STDOUT.
    open my $oldout, ">&STDOUT"     or die "Can't dup STDOUT: $!";

    my $tmp = File::Temp->new;

    open (STDOUT, '>', $tmp) or die "Can't redirect STDOUT: $!";
    select STDOUT; $| = 1;      # make unbuffered

    $app1->system( "$^X -e 'print \$ENV{Site1_App1}'");

    open STDOUT, ">&", $oldout or die "Can't reset STDOUT: $!";
    seek($tmp, 0, 0);

    chomp( my $output = <$tmp> ); 

    is( $output, '1', 'system' );
}


# try qexec
{

    my $output = $app1->qexec( $^X, q{-e 'print $ENV{Site1_App1}'});
    chomp( $output );

    is( $output, '1', 'qexec' );
}
