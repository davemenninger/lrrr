package Lrrr;
use strict;
use warnings;

our $VERSION = '0.01';

use Mojo::Base 'Mojolicious';
use Mango;
use Lrrr::Authentication;
use Lrrr::Authorization;
use Mojolicious::Plugin::Bcrypt;

# This method will run once at server start
sub startup {
  my $self = shift;

  my $mongo_uri =
    $ENV{'MONGOLAB_URI'};    #'mongodb://<user>:<pass>@<server>/<database>';
  $self->helper( mango => sub { state $mango = Mango->new($mongo_uri) } );

  # auth
  $self->plugin( bcrypt => { cost => 6 } );
  $self->plugin(
    authentication => {
      autoload_user => 1,
      load_user     => sub { return Lrrr::Authentication->load_user(@_); },
      validate_user => sub { return Lrrr::Authentication->validate_user(@_); }
    }
  );
  $self->plugin(
    authorization => {
      has_priv   => sub { return Lrrr::Authorization->has_priv(@_); },
      is_role    => sub { return Lrrr::Authorization->is_role(@_); },
      user_privs => sub { return Lrrr::Authorization->user_privs(@_) },
      user_role  => sub { return Lrrr::Authorization->user_role(@_) }
    }
  );

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get(
    '/' => sub {
      $self = shift;
      $self->render('home');
    }
  );

  $r->any('/login')->to( controller => 'login', action => 'login' );

  $r->get('/logout')->to( controller => 'login', action => 'logoff' );

  $r->any('/register')->to( controller => 'register', action => 'register' );

  $r->get(
    '/user' => sub {
      $self = shift;
      $self->render('user');
    }
  );

  $r->get(
    '/hidden' => sub {
      $self = shift;
      $self->render(
        text => ( $self->is_user_authenticated ) ? 'secrets!' : 'go away!' );
    }
  );

  return;
}

1;
