# https://adventofcode.com/2017/day/1

use v6;

sub MAIN(Str :$input = "1234") {

    my $sum = 0;

    my @captcha = $input.comb(/\d/);

    for 0..(@captcha.elems - 1) -> $first {
        if (@captcha[$first] == @captcha[($first + 1) % @captcha.elems]) {
            $sum += @captcha[$first];
        }
    }
    say $sum;
}
