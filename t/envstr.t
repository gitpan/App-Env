use Test::More;

use strict;
use warnings;

use Env::Path;

use lib 't';
use File::Temp;
use App::Env;

if ( Env::Path->PATH->Whence( 'env' ) )
{
    plan tests => 5;
}
else
{
    plan skip_all => "'env' command not in path";
}

my $app1 = App::Env->new( 'App1' );

my ( $envstr, $output );

$envstr = $app1->str;

$output = qx{env $envstr $^X -e 'print \$ENV{Site1_App1}'};
die "error running env: $@\n" if $@;
chomp $output;
is( $output, '1', 'envstr' );


sub test_exclude {
    my ( $exclude, $label ) = @_;

    my $envstr = $app1->str( Exclude => $exclude );

    my $output = qx{env $envstr $^X -e 'print \$ENV{Site1_App1}'};

    die "error running env: $@\n" if $@;
    chomp $output;

    is( $output, '', $label );
}

# test exclusion
test_exclude( qr/Site1_.*/, 'envstr; exclude regexp' );
test_exclude( 'Site1_App1', 'envstr; exclude scalar' );
test_exclude( [ 'Site1_App1' ], 'envstr; exclude array' );

test_exclude( sub { my( $var, $val ) = @_;
		    return $var eq 'Site1_App1' ? 1 : 0 },
	      'envstr; exclude code' );
