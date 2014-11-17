use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME         => 'Lrrr',
  VERSION_FROM => 'lib/Lrrr.pm',
  PREREQ_PM    => {
    'Mojolicious'                         => '5.57',
    'Mojolicious::Plugin::Authentication' => 0,
    'Mojolicious::Commands'               => 0,
    'Mango'                               => 0
  },
  test => { TESTS => 't/*.t' }
);
