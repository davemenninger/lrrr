package Lrrr::Controller::Register;

use strict;
use warnings;

use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub register {
  my $self = shift;

  if ( $self->req->method eq 'POST'){
    if( !$self->is_user_authenticated ) {
      my $u = $self->req->param('u');
      my $p = $self->req->param('p');

      # secret_phrase is a kludge to prevent bots
      my $secret_phrase = $self->req->param('secret_phrase');

      if ( defined $secret_phrase && $secret_phrase eq 'zoidberg' ) {
        my $doc = $self->mango->db->collection('users')->find_one( { username => $u } );
        if( $doc ){
          $self->render( msg => 'username taken' );
        } else {
          my $oid = $self->mango->db->collection('users')->insert( { username => $u , password => $self->bcrypt($p) } );
          if( $oid ) {
            $self->render(msg => 'welcome '.$oid );
          } else {
            $self->render(msg => 'failed to insert' );
          }
        }
      } else {
        $self->render(msg => 'wrong secret phrase');
      }
    } else {
      $self->render( msg => 'already logged in' );
    }
  } else { #not POST, so GET
    if( !$self->is_user_authenticated ) {
      $self->render(msg => 'register here:');
    } else {
      $self->render(msg => 'already logged in');
    }
  }
}

1;
