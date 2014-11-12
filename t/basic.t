use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('Lrrr');
$t->get_ok('/')->status_is(200)->content_like(qr/Home/i);
$t->get_ok('/hidden')->status_is(200)->content_like(qr/go away/i);
$t->get_ok('/login')->status_is(200)->content_like(qr/Login/i);
$t->get_ok('/logout')->status_is(200)->content_like(qr/logged out/i);
$t->get_ok('/user')->status_is(200)->content_like(qr/User/i);

$t->post_ok('/login' => form =>  { u => 'fnark', p => 'fnork' })->status_is(200)->content_like(qr/failed/i);

done_testing();
