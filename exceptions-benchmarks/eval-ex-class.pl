#!/usr/bin/perl
use strict;
use warnings;

use Exception::Class;

use Benchmark qw( cmpthese );

our $error_code;

sub buggy_die { die "blablabla\n"; }

sub buggy_return { $error_code = 'Error'; }

sub string_eval {
    my $result = eval qq{buggy_die();};
    return Exception::Class->caught ? 0 : $result;
}

sub code_eval {
    my $result = eval { buggy_die(); };
    return Exception::Class->caught ? 0 : $result;
}

sub error_code {
    my $result = buggy_return();
    return $error_code eq 'Error'
        ? $error_code
        : $result;
}


cmpthese(
    1000000,
    {   'String eval' => \&string_eval,
        'Braces eval' => \&code_eval,
        'Error code'  => \&error_code,
    }
);
