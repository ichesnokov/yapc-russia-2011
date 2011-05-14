#!/usr/bin/perl
use strict;
use warnings;

use Benchmark qw( cmpthese );

our $error_code;

sub buggy_die { die "blablabla\n"; }
sub buggy_return { $error_code = 'Error'; }

cmpthese(
    1000000,
    {   'String eval' => sub { my $res = eval "buggy_die()"; return $@ ? 0 : $res; },
        'Braces eval' => sub { my $res = eval {buggy_die()}; return $@ ? 0 : $res; },
        'Error code'  => sub { my $res = buggy_return(); return $error_code eq 'Error' ? 0 : $res; },
    }
);
