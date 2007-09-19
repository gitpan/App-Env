package App::Env::Site2::App1;

use strict;
use warnings;

# track the number of times this is invoked
our $cnt = 0;

sub envs
{
    my ( $opt ) = @_;

    $cnt++;

    return { Site2_App1 => $cnt };
}

1;
