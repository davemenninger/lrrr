package Lrrr::Controller::Users;

use strict;
use warnings;

use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub list {
  my $self = shift;

  $self->render( template => 'userlist', format => 'html' );

  return;
}

1;
