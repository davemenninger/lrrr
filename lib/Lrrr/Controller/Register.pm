package Lrrr::Controller::Register;

use strict;
use warnings;

use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub register {
  my $self = shift;
  my $collection = $self->mango->db->collection('users');

  if ( $self->is_user_authenticated
    && $self->has_privilege('create_user') )
  {

    if ( $self->req->method eq 'POST' ) {
      my $u    = $self->req->param('u');
      my $p    = $self->req->param('p');
      my $role = $self->req->param('role');

      my $doc = $collection->find_one( { username => $u } );
      if ($doc) {
        $self->render( msg => 'username taken' );
      }
      else {
        # insert the user
        my $oid = $collection->insert(
          {
            username => $u,
            password => $self->bcrypt($p),
            role     => $role
          }
        );
        if ($oid) {
          $self->render( msg => 'welcome ' . $oid );
        }
        else {
          $self->render( msg => 'failed to insert' );
        }
      }
    }
    else {    # not POST, so GET
      $self->render( msg => 'register a new user:' );
    }
  }
  else {      #not admin
    $self->render( msg => 'you must be logged in as admin.' );
  }
  return;
}

1;
