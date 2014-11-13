package Lrrr 0.01;

use strict;
use warnings;

use Mojo::Base 'Mojolicious';
use Mango;
use Lrrr::Authentication;

# This method will run once at server start
sub startup {
  my $self = shift;

  my $mongo_uri = $ENV{'MONGOLAB_URI'}; #'mongodb://<user>:<pass>@<server>/<database>';
  $self->helper( mango => sub { state $mango = Mango->new($mongo_uri) } );

  # auth
  $self->plugin( authentication => {
    autoload_user => 1,
    load_user => sub { return Lrrr::Authentication->load_user(@_); },
    validate_user => sub { return Lrrr::Authentication->validate_user(@_); }
  });

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/' => sub {
    $self = shift;
    $self->render('home');
  });

  $r->any('/login')->to('auth#login');

  $r->get('/logout')->to('auth#logoff');

  $r->get('/user' => sub {
    $self = shift;
    $self->render('user');
  });

  $r->get('/hidden' => sub {
    $self = shift;
    $self->render( text => ($self->is_user_authenticated) ? 'secrets!' : 'go away!' );
  });

}

1;
