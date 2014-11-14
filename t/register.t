use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

use Mango;

my $t = Test::Mojo->new('Lrrr');
my $collection = $t->app->mango->db->collection('users');

# test register bad
$t->post_ok('/register' => form =>  { u => 'hermes', p => 'conrad' })->status_is(200)->content_like(qr/wrong secret phrase/i);
$t->post_ok('/register' => form =>  { u => 'hermes', p => 'conrad', secret_phrase => 'leela' })->status_is(200)->content_like(qr/wrong secret phrase/i);

#test register good
$t->post_ok('/register' => form =>  { u => 'hermes', p => 'conrad', secret_phrase => 'zoidberg' })->status_is(200)->content_like(qr/welcome/i);

# get rid of hermes
$collection->remove( { username => 'hermes' } );

done_testing();
