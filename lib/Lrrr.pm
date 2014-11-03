package Lrrr;
use Mojo::Base 'Mojolicious';
use Mango;
use Mango::BSON;

# This method will run once at server start
sub startup {
  my $self = shift;

  my $mongo_uri = $ENV{'MONGOLAB_URI'}; #'mongodb://<user>:<pass>@<server>/<database>';
  $self->helper( mango => sub { state $mango = Mango->new($mongo_uri) } );

  # auth
  $self->plugin( authentication => {
    autoload_user => 1,
    load_user => sub {
        my $self = shift;
        my $username = shift;

        my $collection = $self->mango->db('test')->collection('users');
        my $user = $collection->find_one( {username => $username} );

        return { 
          'username' => $user->{username} 
        };
        return undef;
    },
    validate_user => sub {
        my $self = shift;
        my $username = shift || '';
        my $password = shift || '';
        my $extradata = shift || {};

        my $collection = $self->mango->db('test')->collection('users');
        my $user = $collection->find_one( {username => $username} );

        return $user->{username} if ( $password eq $user->{password} );
        return undef;
    },
  });

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('example#welcome');

  $r->any('/login')->to('auth#login');

  $r->get('/logout')->to('auth#logoff');

  $r->get('/user' => sub {
    $self = shift;

    if( $self->is_user_authenticated ){
      my $username = $self->current_user->{'username'};
      $self->render(text=>"your username is $username!");
    } else {
      $self->render(text=>"not logged in!");
    }
  });

  $r->get('/hidden' => sub {
    $self = shift;
    $self->render( text => ($self->is_user_authenticated) ? 'secrets!' : 'go away!' );
  });

}

1;
