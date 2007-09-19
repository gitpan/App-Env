package App::Env::Site1::App1;

use strict;
use warnings;

# track the number of times this is invoked
my $cnt = 0;

sub envs
{
    my ( $opt ) = @_;

    $cnt++;

    return { Site1_App1 => $cnt, %{$opt} };
}

sub reset
{
    $cnt = 0;
}

1;
