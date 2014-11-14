package Lrrr::Authentication;

sub load_user {
  my ($class, $app, $username) = @_;

  my $collection = $app->mango->db->collection('users');
  my $user = $collection->find_one( {username => $username} );

  return {
    'username' => $user->{username}
  } if ( defined $user->{username} );
  return undef;
}

sub validate_user {
  my ($class, $app, $username, $password, $extas) = @_;

  my $collection = $app->mango->db->collection('users');
  my $user = $collection->find_one( {username => $username} );

  $app->session( 'role' => ( defined $user->{role} ) ? $user->{role} : 'guest' );

  return $user->{username} if ( defined $user->{username} && defined $user->{password} && $app->bcrypt_validate($password, $user->{password}) );
  return undef;
}

1;
