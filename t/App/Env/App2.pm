package App::Env::App2;

# track the number of times this is invoked
our $cnt = 0;

sub envs
{
    my ( $opt ) = @_;

    $cnt++;

    return { App2 => $cnt };
}

1;
