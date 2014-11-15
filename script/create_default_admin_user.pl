#!/usr/bin/env perl

use strict;
use warnings;


# this section must correspond with Mojolicios::Plugin::Bcrypt
# ############################################################
use Crypt::Eksblowfish::Bcrypt qw(bcrypt en_base64);
sub _salt {
  my $num = 999999;
  my $cr = crypt( rand($num), rand($num) ) . crypt( rand($num), rand($num) );
  en_base64( substr( $cr, 4, 16 ) );
}

my $cost = sprintf( '%02d', 6 );
my $settings = join( '$', '$2a', $cost, _salt() );
# ############################################################


use Mango;
my $mongo_uri = $ENV{'MONGOLAB_URI'};
my $mango = Mango->new($mongo_uri);

# change this to get from ENV instead?
my $username = "hermes";
my $password = "conrad";

# insert admin user
my $doc = $mango->db->collection('users')->find_one( { username => $username } );
if ( $doc ) {
  print $username . " already exists!\n";
} else {
  my $oid = $mango->db->collection('users')->insert( { username => $username, password => bcrypt($password,$settings), role => 'admin' } );
  print "inserted ".$username." with oid: " . $oid . "\n";
}

# list existing admin users
my $c = $mango->db->collection('users')->find( { role => 'admin' } );
print "existing admins:\n";
while ( my $doc = $c->next ){
    print $doc->{username} . "\n";
}
