#!/usr/bin/env perl

use strict;
use warnings;

# this section must correspond with Mojolicios::Plugin::Bcrypt
# ############################################################
use Crypt::Eksblowfish::Bcrypt qw(bcrypt en_base64);

sub _salt {
  my $num = 999999;
  my $cr = crypt( rand($num), rand($num) ) . crypt( rand($num), rand($num) );
  return en_base64( substr( $cr, 4, 16 ) );
}

my $cost = sprintf( '%02d', 6 );
my $settings = join( '$', '$2a', $cost, _salt() );

# ############################################################

use Mango;
my $mongo_uri = $ENV{'MONGOLAB_URI'};
my $mango     = Mango->new($mongo_uri);

if ( defined $ENV{LRRR_ADMIN_USERNAME} && defined $ENV{LRRR_ADMIN_PASSWORD} ) {
  my $username = $ENV{LRRR_ADMIN_USERNAME};
  my $password = $ENV{LRRR_ADMIN_PASSWORD};

  # insert admin user
  my $doc =
    $mango->db->collection('users')->find_one( { username => $username } );
  if ($doc) {
    print $username . " already exists!\n";
  }
  else {
    my $oid = $mango->db->collection('users')->insert(
      {
        username => $username,
        password => bcrypt( $password, $settings ),
        role     => 'admin'
      }
    );
    print "inserted " . $username . " with oid: " . $oid . "\n";
  }
}
else {
  print
"the ENV variables LRRR_ADMIN_USERNAME and LRRR_ADMIN_PASSWORD need to be set for this command to create a new admin user.\n";
}

# list existing admin users
my $c = $mango->db->collection('users')->find( { role => 'admin' } );
print "existing admins:\n";
while ( my $doc = $c->next ) {
  print $doc->{username} . "\n";
}
