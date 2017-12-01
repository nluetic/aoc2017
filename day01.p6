# https://adventofcode.com/2017/day/1
#
# use_distance false for part one, true for part two
#

use v6;

my $base = $*PROGRAM-NAME.split(/\./)[0];
sub MAIN(Str :$inputfile = "$base.in", Bool :$use_distance = False) {

    my Int $sum = 0;
    my Int $distance = 1;

    my $input = $inputfile.IO.slurp;

    my @captcha = $input.comb(/\d/);

    if $use_distance {
        if !(@captcha.elems %% 2) {
            die("uneven number of elements found");
        }
        $distance = Int(@captcha.elems / 2);
    }

    for 0..(@captcha.elems - 1) -> $first {
        if (@captcha[$first] == @captcha[($first + $distance) % @captcha.elems]) {
            $sum += @captcha[$first];
        }
    }
    say $sum;
}
