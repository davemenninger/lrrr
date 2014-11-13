use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

#plan skip_all => 'set TEST_ONLINE to enable this test'
#  unless $ENV{TEST_ONLINE};

use Mango;

my $t = Test::Mojo->new('Lrrr');

# Clean up before start
my $collection = $t->app->mango->db->collection('users');

# insert user and pass
my $oid = $collection->insert({username => 'bender', password => 'rodriguez'});

# test login bad
$t->post_ok('/login' => form =>  { u => 'philip', p => 'fry' })->status_is(200)->content_like(qr/failed/i);

# test login good
$t->post_ok('/login' => form =>  { u => 'bender', p => 'rodriguez' })->status_is(200)->content_like(qr/ok/i);
$t->post_ok('/login' => form =>  { u => 'bender', p => 'rodriguez' })->status_is(200)->content_like(qr/already logged in/i);

# test hidden page
$t->get_ok('/hidden')->status_is(200)->content_like(qr/secrets/i);

# test logout
$t->get_ok('/logout')->status_is(200)->content_like(qr/now logged out/i);

# test hidden page again
$t->get_ok('/hidden')->status_is(200)->content_like(qr/go away/i);

# Cleanup at end
$collection->remove( $oid );

done_testing();
