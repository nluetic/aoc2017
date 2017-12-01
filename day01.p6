# https://adventofcode.com/2017/day/1
#
# use_distance "False" for part one, "True" for part two
#

use v6;

my $base = $*PROGRAM-NAME.split(/\./)[0];

# Defaultinputfile day01.in can be overridden with ./day01.pl --inputfile=x.in
# to call with $use_distance == True simply use ./day01.pl --use_distance
sub MAIN(Str :$inputfile = "$base.in", Bool :$use_distance = False) {

    # slurp - reads in the whole file
    # comb - searches content according to regex returning a list
    #        split should have been fine too, as we have nothing to throw away
    # map - cast the elements to Int
    my Int @captcha = $inputfile.IO.slurp.comb(/\d/).map( { .Int } );

    # check for divisablity
    if !(@captcha.elems %% 2) {
        die("uneven number of elements found");
    }

    # "div" - integerdivision, in contrast to "/" division of rationals
    my Int $distance = $use_distance ?? @captcha.elems div 2 !! 1;

    my Int $sum = 0;
    for 0..(@captcha.elems - 1) -> $i {
        if (@captcha[$i] == @captcha[($i + $distance) % @captcha.elems]) {
            $sum += @captcha[$i];
        }
    }

    say $sum;
}
