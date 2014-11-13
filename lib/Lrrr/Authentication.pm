package Lrrr::Authentication;

sub load_user {
  my ($class, $app, $username) = @_;
        
  #return 1;
  #my $self = shift;
  #my $username = shift;

  my $collection = $app->mango->db('test')->collection('users');
  my $user = $collection->find_one( {username => $username} );

  return { 
    'username' => $user->{username} 
  } if ( defined $user->{username} );
  return undef;
}

sub validate_user {
  my ($class, $app, $username, $password, $extas) = @_;

  #return 1;
  #my $self = shift;
  #my $username = shift || '';
  #my $password = shift || '';
  #my $extradata = shift || {};

  my $collection = $app->mango->db('test')->collection('users');
  my $user = $collection->find_one( {username => $username} );

  return $user->{username} if ( $password eq $user->{password} );
  return undef;
}

1;
