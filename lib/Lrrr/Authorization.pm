package Lrrr::Authorization;

use strict;
use warnings;

my %roles = (
  admin => { create_user => 1, delete_user => 1 },
  guest => { foo => 1 }
);

sub has_priv {
  my ( $class, $app, $priv, $extradata ) = @_;

  return 0
    unless ( $app->session('role') );

  my $role = $app->session('role');

  my $privs = $roles{$role};

  return 1
    if exists( $privs->{$priv} );

  return 0;
}

sub is_role {
  my ( $class, $app, $role, $extradata ) = @_;

  return 0
    unless ( $app->session('role') );

  return 1
    if ( $app->session('role') eq $role );

  return 0;
}

sub user_privs {
  my ( $class, $app, $extradata ) = @_;

  return []
    unless ( $app->session('role') );

  my $role = $app->session('role');

  my $privs = $roles{$role};

  return keys( %{$privs} );
}

sub user_role {
  my ( $class, $app, $extradata ) = @_;

  return $app->session('role');
}

1;
