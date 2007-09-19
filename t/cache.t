use Test::More tests => 22;

use lib 't';

BEGIN { use_ok('App::Env') };

#############################################################

# check simple caching and uncaching 

App::Env::import( 'App1' );
is( $ENV{Site1_App1}, 1, "import func 1, cache on" );

App::Env::import( 'App1' );
is( $ENV{Site1_App1}, 1, "import func 2, cache on" );

App::Env::uncache( App => 'App1' );
App::Env::import( 'App1' );
is( $ENV{Site1_App1}, 2, "import func 2, deleted cache" );

App::Env::import( 'App1' );
is( $ENV{Site1_App1}, 2, "import func 2, cache on" );

#############################################################

# now check CacheID

App::Env::import( 'App1', { CacheID => 'foo' } );
is( $ENV{Site1_App1}, 3, "import func 3, cache on, new cache id" );


# verify that the old one is still cached.
App::Env::import( 'App1' );
is( $ENV{Site1_App1}, 2, "import func 2, cache on, old cache id" );

# and now try for foo again
App::Env::import( 'App1', { CacheID => 'foo' } );
is( $ENV{Site1_App1}, 3, "import func 3, cache on, old cache id" );


# merge.  should pull in cached App1
App::Env::import( 'App1', 'App2' );
ok( $ENV{Site1_App1} == 2 &&
    $ENV{Site1_App2} == 1, "merge cache: 1" );

# was App2 cached?
App::Env::import( 'App2' );
is( $ENV{Site1_App2}, 1, "merge cache: 2" );

# uncache App2 and import it to increment the counter,
# then reimport merge to see if it's being cached
App::Env::uncache( App => 'App2' );
App::Env::import( 'App2' );
is( $ENV{Site1_App2}, 2, "merge cache: 3" );

# now check merge.  should be same as above as it was cached
App::Env::import( 'App1', 'App2' );
ok( $ENV{Site1_App1} == 2 &&
    $ENV{Site1_App2} == 1, "merge cache: 4" );

# once more, but force an update of App2.
# should be same as above as it was cached
App::Env::import( 'App1', [ 'App2', { Force => 1 } ] );
ok( $ENV{Site1_App1} == 2 &&
    $ENV{Site1_App2} == 1, "merge cache: 5" );

# but now App2's counter should be incremented
# was App2 cached?
App::Env::import( 'App2' );
is( $ENV{Site1_App2}, 3, "merge cache: 6" );

App::Env::uncache( All => 1 );
is ( keys %App::Env::EnvCache, 0, "uncache all" );

#############################################################
# check Object caching

App::Env::Site1::App1::reset();
App::Env::Site1::App2::reset();

{
    my ( $obj1, $obj2 );

    # get new App1
    $obj1 = App::Env->new( 'App1' );
    is( $obj1->env('Site1_App1'), 1, "method 1, cache on" );

    # make sure that next attempt is cached
    $obj2 = App::Env->new( 'App1' );
    is( $obj2->env('Site1_App1'), 1, "method 2, cache on" );

    # uncache it and get it again
    $obj1->cache(0);
    $obj1 = App::Env->new( 'App1' );
    is( $obj1->env('Site1_App1'), 2, "method 1, cache on" );
    
    # make sure that last one was cached
    $obj1 = App::Env->new( 'App1' );
    is( $obj1->env('Site1_App1'), 2, "method 1, cache on" );

    # merge.  should pull in cached App1
    $obj1 = App::Env->new( 'App1', 'App2' );
    ok( $obj1->env('Site1_App1') == 2 &&
	$obj1->env('Site1_App2') == 1, "obj merge: 1" );

    # merge.  force reload of all apps
    $obj2 = App::Env->new( 'App1', 'App2', { Force => 1 } );
    ok( $obj2->env('Site1_App1') == 3 &&
	$obj2->env('Site1_App2') == 2, "obj merge: 2" );

    # but obj1 should be the same
    ok( $obj1->env('Site1_App1') == 2 &&
	$obj1->env('Site1_App2') == 1, "obj merge: 1 check" );
}
