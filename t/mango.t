use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

#plan skip_all => 'set TEST_ONLINE to enable this test'
#  unless $ENV{TEST_ONLINE};

use Mango;

my $t = Test::Mojo->new('Lrrr');

# Clean up before start
my $collection = $t->app->mango->db->collection('users');
$collection->drop if $collection->options;
#$collection->create;

# insert user and pass
$collection->insert({username => 'bender', password => 'rodriguez'});
# test login, hidden
$t->post_ok('/login' => form =>  { u => 'bender', p => 'rodriguez' })->status_is(200)->content_like(qr/ok/i);

# Cleanup at end
$collection->drop;

done_testing();
