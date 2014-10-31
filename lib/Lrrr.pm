package Lrrr;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');

  # auth
  $self->plugin( authentication => {
    autoload_user => 1,
    load_user => sub {
        my $self = shift;
        my $uid  = shift;

        return {
            'username' => 'foo',
            'password' => 'bar',
            'name'     => 'Foo'
            } if($uid eq 'userid' || $uid eq 'useridwithextradata');
        return undef;
    },
    validate_user => sub {
        my $self = shift;
        my $username = shift || '';
        my $password = shift || '';
        my $extradata = shift || {};

        return 'useridwithextradata' if($username eq 'foo' && $password eq 'bar' && ( $extradata->{'ohnoes'} || '' ) eq 'itsameme');
        return 'userid' if($username eq 'foo' && $password eq 'bar');
        return undef;
    },
  });

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('example#welcome');

  $r->post('/login' => sub {
    my $self = shift;
    my $u    = $self->req->param('u');
    my $p    = $self->req->param('p');


    $self->render(text => ($self->authenticate($u, $p)) ? 'ok' : 'failed');
  });

  $r->get( '/logout' => sub {
    my $self = shift;

    $self->logout();
    $self->render(text => 'logout');
  });

  $r->get('/user/:uid' => sub {
    $self = shift;
    my $uid = $self->param('uid');
    $self->render(text=>"you is $uid!");
  });

  $r->get('/hidden' => sub {
    $self = shift;
    $self->render( text => ($self->is_user_authenticated) ? 'secrets!' : 'go away!' );
  });

}

1;
