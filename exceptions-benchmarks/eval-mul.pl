#!/usr/bin/perl
use strict;
use warnings;

use Benchmark qw( cmpthese );

sub mul_no_eval {
    return $_[0] * $_[1] * $_[2];
}

sub mul_use_eval {
    return eval { $_[0] * $_[1] * $_[2] };
}

cmpthese(
    1000000, {
        'No eval' => sub { mul_no_eval(100, 500, 100500) },
        'Eval'    => sub { mul_use_eval(100, 500, 100500) },
    }
);
