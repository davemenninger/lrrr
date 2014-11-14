package Lrrr::Controller::Login;

use strict;
use warnings;

use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub login {
  my $self = shift;

  if ( $self->req->method eq 'POST'){
    if( !$self->is_user_authenticated ) {
      my $u = $self->req->param('u');
      my $p = $self->req->param('p');

      if( $self->authenticate($u,$p) ) {
        $self->render(msg => 'ok' );
      } else {
        $self->render(msg => 'failed' );
      }
    } else {
      $self->render(msg=>'already logged in');
    }
  } else {
    if( !$self->is_user_authenticated ) {
      $self->render(msg=>'log in here:');
    } else {
      $self->render(msg => 'already logged in');
    }
  }
}

sub logoff {
  my $self = shift;
  $self->logout();
  $self->session(expires => 1);
  $self->render(
    template=>'login/login',
    format=>'html',
    msg => 'you are now logged out.'
  );
}

1;
