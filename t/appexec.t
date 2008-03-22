#!perl

use Test::More tests => 2;

use lib 't';

#############################################################

{
    open( my $fh, '-|',
          $^X, '-Mblib', '-It', 'blib/script/appexec', 'App1',
          $^X, '-e', 'print "$ENV{Site1_App1}"' )
      or die( "error opening pipe to appexec\n" );

    my $res = <$fh>;
    is( $res, '1', 'direct' );
}

{
    open( my $fh, '-|',
          $^X, '-Mblib', '-It', 'blib/script/appexec', 'App3',
          $^X, '-e', 'print "$ENV{Site1_App1}"' )
      or die( "error opening pipe to appexec\n" );

    my $res = <$fh>;
    is( $res, '1', 'alias' );
}
