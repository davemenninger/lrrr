package Lrrr::Authorization;

use strict;
use warnings;

my %roles = (
  admin => { create_user => 1, delete_user => 1 },
  guest => { foo         => 1 }
);

sub has_priv {
  my ( $class, $app, $priv, $extradata ) = @_;
  my $role  = $app->session('role');
  my $privs = $roles{$role};
  return ( $app->session('role') && exists( $privs->{$priv} ) );
}

sub is_role {
  my ( $class, $app, $role, $extradata ) = @_;
  return ( $app->session('role') && $app->session('role') eq $role );
}

sub user_privs {
  my ( $class, $app, $extradata ) = @_;

  if ( $app->session('role') ) {
    my $role  = $app->session('role');
    my $privs = $roles{$role};
    return keys( %{$privs} );
  }
  else {
    return [];
  }
}

sub user_role {
  my ( $class, $app, $extradata ) = @_;
  return $app->session('role');
}

1;
