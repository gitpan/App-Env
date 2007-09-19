package App::Env::App1;

# track the number of times this is invoked
our $cnt = 0;

sub envs
{
    my ( $opt ) = @_;

    $cnt++;

    return { App1 => $cnt };
}

1;
