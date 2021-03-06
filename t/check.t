use Smart::Comments;
use Test::More 'no_plan';




close *STDERR;
my $STDERR = q{};
open *STDERR, '>', \$STDERR;

my $x = 0;
### check: $x < 1

ok length $STDERR == 0           => 'True check is silent';

$ASSERTION = << 'END_ASSERT';

# $x < 0 was not true at FILE line 26.
#     $x was: 0

END_ASSERT

$ASSERTION =~ s/#/###/g;

eval {
### check: $x < 0
};

ok !$@                           => 'False check not deadly';


$STDERR =~ s/ at \S+ line / at FILE line /;

ok length $STDERR != 0           => 'False check is loud';
is $STDERR, $ASSERTION           => 'False check is loudly correct';

close *STDERR;
$STDERR = q{};
open *STDERR, '>', \$STDERR;

my $y = [];
   $x = 10;

my $ASSERTION2 = << 'END_ASSERTION2';

# $y < $x was not true at FILE line 55.
#     $y was: []
#     $x was: 10

END_ASSERTION2

$ASSERTION2 =~ s/#/###/g;

eval {
### check: $y < $x
};

ok !$@                           => 'False two-part check not deadly';


$STDERR =~ s/ at \S+ line / at FILE line /;

ok length $STDERR != 0           => 'False two-part check is loud';
is $STDERR, $ASSERTION2          => 'False two-part check is loudly correct';
