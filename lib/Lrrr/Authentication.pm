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

  return $user->{username} if ( defined $user->{username} && defined $user->{password} && $password eq $user->{password} );
  return undef;
}

1;
