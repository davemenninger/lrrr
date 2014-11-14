use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

use Mango;

my $t = Test::Mojo->new('Lrrr');
my $collection = $t->app->mango->db->collection('users');

# test get page ok

# test register bad
$t->post_ok('/register' => form =>  { u => 'bender', p => 'rodriguez' })->status_is(200)->content_like(qr/must be logged in as admin/i);

# login as admin
$t->post_ok('/login' => form =>  { u => 'hermes', p => 'conrad' })->status_is(200)->content_like(qr/ok/i);

# test register name already taken
$t->post_ok('/register' => form =>  { u => 'hermes', p => 'conrad', role => 'robot' })->status_is(200)->content_like(qr/username taken/i);

#test register good
$t->post_ok('/register' => form =>  { u => 'bender', p => 'rodriguez', role => 'robot' })->status_is(200)->content_like(qr/welcome/i);

# get rid of new user bender
$collection->remove( { username => 'bender' } );

done_testing();
