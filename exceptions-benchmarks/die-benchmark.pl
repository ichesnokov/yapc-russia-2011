#!/usr/bin/perl
use strict;
use warnings;

use Carp;
use Exception::Class;

use Benchmark qw( cmpthese );

cmpthese(
    1000000,
    {   'Die\n'     => sub { eval { die "Error\n"; }; },
        'Die'       => sub { eval { die "Error"; }; },
        'Croak\n'   => sub { eval { croak "Error\n"; }; },
        'Croak'     => sub { eval { croak "Error"; }; },
        'Throw'     => sub { eval { Exception::Class->throw( error => "Error" ); }; },
    }
);

