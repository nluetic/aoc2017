# https://adventofcode.com/2017/day/1
#
# use_distance "False" for part one, "True" for part two
#

use v6;

my $base = $*PROGRAM-NAME.split(/\./)[0];
sub MAIN(Str :$inputfile = "$base.in", Bool :$use_distance = False) {

    my @captcha = $inputfile.IO.slurp.comb(/\d/);

    if !(@captcha.elems %% 2) {
        die("uneven number of elements found");
    }

    my Int $distance = $use_distance ?? Int(@captcha.elems / 2) !! 1;

    my Int $sum = 0;
    for 0..(@captcha.elems - 1) -> $i {
        if (@captcha[$i] == @captcha[($i + $distance) % @captcha.elems]) {
            $sum += @captcha[$i];
        }
    }

    say $sum;
}
